# WebRTC-server-Virtual-Wall

## Run AppRTC web server
```
./google_appengine/dev_appserver.py ./apprtc-master/out/app_engine/ --host server
```
Default port is 8080, can be changed with option --port

## Run Collider - WebSocket-based signaling server
```
sudo ./go/bin/collidermain
```
Default port and room-server adress can be changed in $HOME/go/src/collidermain/main.go. After every change, build again with ``` go install collidermain ```
