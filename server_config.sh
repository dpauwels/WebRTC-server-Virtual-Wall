#!/bin/bash
DIR=$PWD
sudo apt-get update
sudo apt-get install -y nodejs-legacy npm
sudo npm -g install grunt-cli
cd apprtc-master/
sudo npm install
# google-chrome (for google sdk config)
cd ../
sudo dpkg -i google-chrome*.deb; sudo apt-get -f install -y && sudo dpkg -i google-chrome*.deb

# go
wget https://storage.googleapis.com/golang/go1.7.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.7*
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$DIR/go
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
echo "export GOPATH=$DIR/go" >> /etc/profile
sed -n "s/ListenAndServeTLS(\"\/cert\/cert.pem\", \"\/cert\/key.pem\")/ListenAndServeTLS(\"${DIR}\/cert\/cert.pem\", \"${DIR}\/cert\/key.pem\")/g" go/src/collider/collider.go
go install collidermain
# libevent
cd libevent*
./configure
make
sudo make install
cd ../

# apprtc
cd apprtc-master/
grunt build

cd ../
sudo apt-get install stunnel4 -y
echo "cert = $DIR/cert/stunnel.pem" >> stunnel.conf
sudo cp stunnel.conf /etc/stunnel
sudo cp stunnel4 /etc/default/
sudo /etc/init.d/stunnel4 restart
