# WebRTC-server-Virtual-Wall

![alt tag](https://www.html5rocks.com/en/tutorials/webrtc/basics/dataPathways.png)

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
