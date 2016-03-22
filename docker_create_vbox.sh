#!/bin/bash
docker-machine create -d generic \
 --generic-ssh-user vagrant \
 --generic-ssh-key ~/.vagrant.d/insecure_private_key \
 --generic-ip-address 10.0.0.10 \
 default
