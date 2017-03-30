#!/bin/bash

# http://doc.ilabt.iminds.be/ilabt-documentation/wilabfacility.html
# https://github.com/webrtc/apprtc
# https://github.com/webrtc/apprtc/tree/master/src/collider
# https://github.com/coturn/coturn/wiki/CoturnConfig

#sudo cp hostapd.conf /root/
#sudo hostapd /root/hostapd.conf &> /dev/null &

#sudo ifconfig wlan0 192.168.1.1/24

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
export GOPATH=$HOME/go
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
echo "export GOPATH=$HOME/go" >> /etc/profile
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
sudo cp stunnel.conf /etc/stunnel
sudo cp stunnel4 /etc/default/
sudo /etc/init.d/stunnel4 restart
