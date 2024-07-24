# ベースイメージとしてUbuntu 20.04を使用
FROM ubuntu:20.04

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージのインストール
RUN apt update && apt install -y \
    curl \
    gnupg2 \
    lsb-release \
    software-properties-common \
    build-essential \
    cmake \
    git \
    wget \
    vim \
    python3-pip \
    python3-venv \
    locales \
    sudo \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# ロケールの設定
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# catkin_toolsのインストール
RUN pip3 install catkin_tools

# ROS Noeticのセットアップ
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && apt update \
    && apt install -y ros-noetic-desktop-full \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# ROSの初期設定
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash"

# Gazeboのインストール
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" > /etc/apt/sources.list.d/gazebo-stable.list' \
    && wget https://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
    && apt update \
    && apt install -y gazebo11 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# ROSパッケージの依存関係をインストール
RUN apt update && apt install -y \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    build-essential \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep init && rosdep update

# Pythonの深層学習ライブラリのインストール
RUN pip3 install --upgrade pip
RUN pip3 install \
    numpy \
    scipy \
    matplotlib \
    pandas \
    scikit-learn \
    tensorflow \
    torch \
    torchvision

# 作業ディレクトリの作成
WORKDIR /root/catkin_ws

# エントリーポイントの設定
CMD ["bash"]
