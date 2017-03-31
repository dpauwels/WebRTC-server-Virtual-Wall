#!/bin/bash

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
export GOPATH=$HOME/WebRTC-server-Virtual-Wall/go
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
echo "export GOPATH=$HOME/WebRTC-server-Virtual-Wall/go" >> /etc/profile
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
