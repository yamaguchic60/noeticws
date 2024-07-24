# noeticws
gazebo,c++,python,pytorch関連を触る人用のdockerfileです。
＃まず、Dockerがxサーバに接続するために権限を与える。
$ xhost +local:docker

#Dockerfileからイメージを作る。最後のピリオドのとおりカレントディレクトリのどっかーファイルを参照しているので、どっかーファイルがあるディレクトリに移動してからビルドしてください。
$ docker build -t noeticimg .
＃イメージからコンテナを作る
$ docker run --name noeticcon -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -it noeticimg
＃動作中のコンテナに入る
$ docker exec -it noeticcon /bin/bash
#docker psで出てこない（コンテナが停止中）のとき
$ docker start noeticcon 
