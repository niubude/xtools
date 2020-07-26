#!/bin/sh
#wget https://download.docker.com/linux/centos/7/x86_64/edge/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
#yum -y install containerd.io-1.2.6-3.3.el7.x86_64.rpm
#rm -f containerd.io-1.2.6-3.3.el7.x86_64.rpm
wget -qO- https://get.docker.com/ | sh
systemctl start docker
mkdir /root/v2ray

mkdir /root/nginx
docker run --name nginx -p 80:80 -v /root/nginx:/usr/share/nginx/html:ro -d nginx
curl https://get.acme.sh | sh
source ~/.bashrc 
acme.sh --issue -d pp.avps.ml --webroot /root/nginx
acme.sh --install-cert -d pp.avps.ml \
--key-file /root/v2ray/v2ray.key \
--fullchain-file /root/v2ray/v2ray.crt \
--reloadcmd      "docker restart nginx"

wget -O /root/v2ray/config.json https://raw.githubusercontent.com/niubude/xtools/master/v2ray/config.json
docker run --name=v2ray --net=host -v /root/v2ray:/etc/v2ray -d v2ray/official