#!/bin/sh
wget https://download.docker.com/linux/centos/7/x86_64/edge/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
yum -y install containerd.io-1.2.6-3.3.el7.x86_64.rpm
rm -f containerd.io-1.2.6-3.3.el7.x86_64.rpm
wget -qO- https://get.docker.com/ | sh
systemctl start docker
mkdir /root/v2ray
wget -O /root/v2ray/config.json https://raw.githubusercontent.com/niubude/xtools/master/v2ray/config.json
docker run --name=v2ray -p 8888:8888 -v /root/v2ray:/etc/v2ray -d v2ray/official