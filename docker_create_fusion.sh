#!/bin/bash
docker-machine create -d vmwarefusion \
 --vmwarefusion-cpu-count 2 \
 --vmwarefusion-memory-size 4096 \
 --vmwarefusion-disk-size 40000 \
 default

sleep 5
mkdir -p ~/bin
cp docker_box_fusion.sh ~/bin
chmod 750 ~/bin/docker_box_fusion.sh
sudo nfsd enable

sleep 5
cat << EOF >> ~/.profile
DOCKER_HELPERS_OSX_MACHINE="default"
DOCKER_HELPERS_OSX_NFS_EXPORT=$(pwd)
source ~/bin/docker_box_fusion.sh
EOF

source ~/.profile
eval $(docker-machine env default)
dm restart