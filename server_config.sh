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

# google-chrome (for google sdk config)
sudo dpkg -i google-chrome*.deb; sudo apt-get -f install -y && sudo dpkg -i google-chrome*.deb

# go
sudo tar -C /usr/local -xzf go1.7*
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
echo "export GOPATH=$HOME/go" >> /etc/profile
go install collidermain
# libevent
tar xvf libevent*
cd libevent*
./configure
make
sudo make install
cd ..

# google cloud sdk
cd google-cloud-sdk
./install.sh
gcloud init
cd ..

# google appengine

# turnserver
cd turnserver-4.5.0.5
./configure
make
sudo make install
cd ..

sudo turnadmin -a -u test -r server -p test

# apprtc
grunt build

sudo apt-get install stunnel4 -y
sudo cp stunnel.conf /etc/stunnel
sudo cp stunnel4 /etc/default/
sudo /etc/init.d/stunnel4 restart

#sudo cp -r cert/ /


# start apprtc: $HOME/google_appengine/dev_appserver.py $HOME/apprtc/out/app_engine --host server
# start collider: $GOPATH/bin/collidermain -tls=true 
# start coturn: turnserver -a -f -r server

# https://github.com/muaz-khan/getStats

cd
sudo npm install getstats
