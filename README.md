# Docker & Vagrant synergy

In [Ideato](https://www.ideato.com) we are developing software using OSX so we had to find a solution about no native support for Docker.
Instead launching one Vagrant machine for each container (using vm.provider : docker) we recommend to host inside a Vagrant machine a fully working Docker Machine hosting our containers.
<<<<<<< HEAD
You would wonder why..We can reuse Docker images inside the single Vagrant machine and speed up our environment setup
Please check http://blog.scottlowe.org/2015/08/04/using-vagrant-docker-machine-together/
=======
You would wonder why...We can reuse Docker images inside the single Vagrant machine and speed up our environment setup.
>>>>>>> e71af59290df96c56cb14ce61852bd7f0e5f19db

For this work we inspired from [Scott Lowe blog post](http://blog.scottlowe.org/2015/08/04/using-vagrant-docker-machine-together/)

##Requirements
###Vagrant
A Vagrant version is required because we will use it to share contents via NFS. Please check out [Vagrant Downloads](https://www.vagrantup.com/downloads.html).

###Docker Toolbox
The [Docker Toolbox](https://www.docker.com/products/docker-toolbox) installs everything you need to get started with Docker on Mac OS X, Linux and Windows. It includes the Docker client, Compose, Machine, Kitematic, and VirtualBox.

**NOTE** You can de-select Kinematic from Docker Toolbox installer, it's not stricted required. If you have already Virtuabox installed, the installer will skip 

##Setup

* Copy `vagrantconfig.dist.yml` in `vagrantconfig.yml`
* Open `vagrantconfig.yml` with your favourite editor. Here you can customize values for vCPUs number, RAM amount, private IP address. 
**Warning:** you have to provide enough memory for your containers; you can start with **at least** 2GB, but 4GB is recommended
* Open a command shell or terminal window and launch 

```
vagrant up
```

* Once the VM is up we are ready to create the Docker Machine. To create the Docker Machine launch 

###Virtualbox default Vagrant provider

```
sh docker_create_vbox.sh
```

It will install Docker engine inside your VM and inject the default Vagrant SSH *insecure_private_key* 

* Now you need to tell Docker to talk to the new machine. You can do this with the command

```
$ docker-machine env default
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://10.0.0.10:2376"
export DOCKER_CERT_PATH="/Users/ideato/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"
# Run this command to configure your shell:
# eval $(docker-machine env default)
```

* Connect your current shell environment to the new machine as the last output line

```
eval "$(docker-machine env default)"
```
This sets environment variables for the current shell that the Docker client will read which specify the TLS settings. You need to do this each time you open a new shell or restart your machine. You can add this line into your `.bashrc` every time you launch a new shell

```
# For docker-machine
eval "$(docker-machine env default)"
```
* You can test the environment to launch normal docker command on your host. Let's do it!

```
docker run -it busybox /bin/sh
```

Please read for further informations please read [Docker Machine](https://docs.docker.com/machine/) page

###Docker machine and VMware Fusion 
If you have a commercial copy of VMware Fusion we can use a different approach, you **don't need anymore Vagrant!** Run the script

```
sh docker_create_fusion.sh
```

It will create a Docker machine and share via NFS your current workspace directory inside virtual machine

Thanks to great [Julien Blog](http://julien.lirochon.net/up-and-running-docker-host-with-vmware-fusion-and-docker-machine.html) post for the helpers functions

##Build your stack

Now we are ready to build our stack to host Symfony dev environment with Docker Compose


```
$ docker-compose up -d
```
By default docker-compose command takes by default `docker-compose.yml` and start related containers. With `-f` switch we can specify custom docker-compose YAML

In the `docker-compose-examples` folder there's some docker-compose files with different stacks. For example:

```
docker-compose -f docker-compose.lemp-es.yml up -d
```

It will bootstrap a LEMP (Nginx, MySQL, PHP) with ES (Elasticsearch)

##Install a Symfony Environment

* Complete Setup section
* From your terminal launch

```
$ docker-compose up -d 
```

* After compose has been completed

```
	- docker exec -it web.1 sh -c 'curl -sS https://getcomposer.org/installer | php'
  	- docker exec -it web.1 sh -c 'mv composer.phar /usr/local/bin/composer && chmod 755 /usr/local/bin/composer'
  	- docker exec -it web.1 sh -c 'curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony && cd /var/www/vhosts/example1.it && /usr/local/bin/symfony new myapp lts'
```
