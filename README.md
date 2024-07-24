# noeticws
gazebo,c++,python,pytorch関連を触る人用のdockerfileです。

$ docker run --name noeticcon -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -it noeticimg

$ docker exec -it noeticcon /bin/bash
