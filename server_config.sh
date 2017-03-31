#!/bin/bash
usage="$(basename "$0") [-h] [-s n] -- this script installs and configures WebRTC webserver, roomserver and signaling server

where:
    -h, --help    show this help text
    -ip_turn      set the IP adress of the STUN/TURN server
    -ip_signaling set the IP adress of the signaling server
    -ip_room      set the IP adress of the webserver/roomserver"

while [[ $# > 1 ]]
do
	key="$1"
case $key in
	-ip_turn)
		ip_turn="$2"
		shift
		;;
	-ip_signaling)
	  ip_signaling="$2"
	  shift
	  ;;
	-ip_room)
	  ip_room="$2"
	  shift
	  ;;
	-h|--help)
	  echo "$usage"
	  exit
	  ;;
	*)
		echo "Argument not recognized"
		echo "$usage" >&2
		exit 1
	;;
esac
shift
done

if [ -z "$ip_turn" ]; then
  echo "Error: IP adress of the STUN/TURN server is not set!" >&2
  echo "$usage" >&2
  exit 1
fi
if [ -z "$ip_signaling" ]; then
  echo "Error: IP adress of the signaling server is not set!" >&2
  echo "$usage" >&2
  exit 1
fi
if [ -z "$ip_room" ]; then
  echo "Error: IP adress of the room server is not set!" >&2
  echo "$usage" >&2
  exit 1
fi


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
# replace IP adresses in constant.py
grunt build

cd ../
sudo apt-get install stunnel4 -y
echo "cert = $DIR/cert/stunnel.pem" >> stunnel.conf
sudo cp stunnel.conf /etc/stunnel
sudo cp stunnel4 /etc/default/
sudo /etc/init.d/stunnel4 restart
