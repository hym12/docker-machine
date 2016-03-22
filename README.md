# Docker & Vagrant synergy
---

In [Ideato](https://www.ideato.com) we are developing software using OSX so we had to find a solution about no native support for Docker.
Instead launching one Vagrant machine for each container (using vm.provider : docker) we recommend to host inside a Vagrant machine a fully working Docker Machine hosting our containers.
You would wonder why...We can reuse Docker images inside the single Vagrant machine and speed up our environment setup.

For this work we inspired from [Scott Lowe blog post](http://blog.scottlowe.org/2015/08/04/using-vagrant-docker-machine-together/)

##Requirements
###Vagrant
A Vagrant version is required because we will use it to share contents via NFS. Please check out [Vagrant Downloads](https://www.vagrantup.com/downloads.html).

###Docker Toolbox
The [Docker Toolbox](https://www.docker.com/products/docker-toolbox) installs everything you need to get started with Docker on Mac OS X, Linux and Windows. It includes the Docker client, Compose, Machine, Kitematic, and VirtualBox.

**NOTE** You can de-select Kinematic from Docker Toolbox installer, it's not stricted required 

##Setup

* Copy `vagrantconfig.dist.yml` in `vagrantconfig.yml`
* Open `vagrantconfig.yml` with your favourite editor. Here you can customize values for vCPUs number, RAM amount, private IP address. 
**Warning:** you have to provide enough memory for your containers.
* Open a command shell or terminal window and launch 

```
vagrant up
```

* Once the VM is up we are ready to create the Docker Machine. To create the Docker Machine launch  

```
sh docker_create.sh
```

It will install Docker engine inside your VM and inject the default SSH *insecure_private_key* 

* Now you need to tell Docker to talk to the new machine. You can do this with the command

```
$ docker-machine env default
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://10.0.0.10:2376"
export DOCKER_CERT_PATH="/Users/paolo/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"
# Run this command to configure your shell:
# eval $(docker-machine env default)
```

* Connect your current shell environment to the new machine as the last output line

```
eval "$(docker-machine env default)"
```
This sets environment variables for the current shell that the Docker client will read which specify the TLS settings. You need to do this each time you open a new shell or restart your machine.

* Now you can try to launch normal docker command on your host. Test it!

```
docker run -it busybox /bin/sh
```

```
  - try Docker Compose! open docker-compose.yml and launch docker-compose up -d
```

###**VMware Fusion users
###**Virtualbox users

##Install a Symfony Environment

```
  - complete Setup section
  - docker-compose up -d
  - launch from your OSX terminal:
	- docker exec -it web.1 sh -c 'curl -sS https://getcomposer.org/installer | php'
  	- docker exec -it web.1 sh -c 'mv composer.phar /usr/local/bin/composer && chmod 755 /usr/local/bin/composer'
  	- docker exec -it web.1 sh -c 'curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony && cd /var/www/vhosts/example1.it && /usr/local/bin/symfony new blog lts'
```
