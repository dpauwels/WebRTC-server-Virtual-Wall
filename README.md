# WebRTC-server-Virtual-Wall
the STUN protocol and its extension TURN are used by the ICE framework to enable RTCPeerConnection to cope with NAT traversal and other network vagaries.
ICE is a framework for connecting peers, such as two video chat clients. Initially, ICE tries to connect peers directly, with the lowest possible latency, via UDP. In this process, STUN servers have a single task: to enable a peer behind a NAT to find out its public address and port.
If UDP fails, ICE tries TCP: first HTTP, then HTTPS. If direct connection fails—in particular, because of enterprise NAT traversal and firewalls—ICE uses an intermediary (relay) TURN server. In other words, ICE will first use STUN with UDP to directly connect peers and, if that fails, will fall back to a TURN relay server. 
Note that, by default, no ports are blocked on the nodes, so a TURN and STUN server aren't necessary. 
![alt tag](https://www.html5rocks.com/en/tutorials/webrtc/basics/stun.png)

## Run AppRTC web server/room server
```
./google_appengine/dev_appserver.py ./apprtc-master/out/app_engine/ --host server
```
Default port is 8080, can be changed with option --port

## Run Collider - WebSocket-based signaling server
```
sudo ./go/bin/collidermain
```
Default port and room-server adress can be changed in $HOME/go/src/collidermain/main.go. After every change, build again with ``` go install collidermain ```

## Run Coturn - STUN and TURN server
```
sudo turnserver -a -f
```
Default ports are 3478 and 3479 for both TCP and UDP
