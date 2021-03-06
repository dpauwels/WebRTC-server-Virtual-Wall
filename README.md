# WebRTC-server-Virtual-Wall
## Download
Run ```git clone https://github.ugent.be/dripauwe/WebRTC-server-Virtual-Wall.git```
## Install
```
cd WebRTC-server-Virtual-Wall/
sudo ./server_config.sh -turn X.X.X.X -room X.X.X.X -signaling X.X.X.X
source install_go
```

## Install only the STUN/TURN server
```
cd WebRTC-server-Virtual-Wall/
sudo ./turnserver_config.sh
```

## Introduction

The STUN protocol and its extension TURN are used by the ICE framework to enable RTCPeerConnection to cope with NAT traversal and other network vagaries.
ICE is a framework for connecting peers, such as two video chat clients. Initially, ICE tries to connect peers directly, with the lowest possible latency, via UDP. In this process, STUN servers have a single task: to enable a peer behind a NAT to find out its public address and port.
If UDP fails, ICE tries TCP: first HTTP, then HTTPS. If direct connection fails—in particular, because of enterprise NAT traversal and firewalls—ICE uses an intermediary (relay) TURN server. In other words, ICE will first use STUN with UDP to directly connect peers and, if that fails, will fall back to a TURN relay server. 
Note that, by default, no ports are blocked on the nodes, so a TURN server isn't necessary. 
![alt tag](https://www.html5rocks.com/en/tutorials/webrtc/basics/stun.png)

## Run AppRTC web server/room server
```
./google_appengine/dev_appserver.py ./apprtc-master/out/app_engine/ --host server
```
Default port is 8080, can be changed with option --port.
The source html and Javascript files can be found in apprtc-master/src/web_app/. Everytime you update the source code, you need to recompile by running ``` grunt build ``` in apprtc-master

The IP adresses of the signaling server and the STUN/TURN server can be changed in apprtc-master/src/app_engine/constants.py

## Run Collider - WebSocket-based signaling server
```
sudo ./go/bin/collidermain
```
Default port and room-server adress can be changed in go/src/collidermain/main.go. You can use the non-secure room-server port here, default 8080. After every change, build again with ``` go install collidermain ```

## Run Coturn - STUN and TURN server
```
sudo turnserver
```
Default ports are 3478 and 3479 for both TCP and UDP

## STUNNEL proxy server - https://www.digitalocean.com/community/tutorials/how-to-set-up-an-ssl-tunnel-using-stunnel-on-ubuntu
For screen capture with getUserMedia, the browser expects a HTTPS connection. Because SSL encryption is not possible with AppRTC, I use the stunnel server to proxy HTTP to HTTPS.
On default STUNNEL listens on port 8443 and uses the certificate located in cert/stunnel.pem.
To change these settings, edit the config file in /etc/stunnel/stunnel.conf

## Change logged statistics

To change the logged statistics, edit function PeerConnectionClient.prototype.setupLogging_ on line 115 in class apprtc-master/src/web_app/js/peerconnectionclient.js
