# Docker & Vagrant synergy
---

In Ideato we are developing software using OSX so we had to find a solution about no native support for Docker.
Instead launching one Vagrant machine for each container (using vm.provider : docker) we recommend to host inside a Vagrant machine a fully working Docker Machine hosting our containers.
You would wonder why...We can reuse Docker images inside the single Vagrant machine and speed up our environment setup
Please check http://blog.scottlowe.org/2015/08/04/using-vagrant-docker-machine-together/


##Setup

First of all download and install [Docker Toolbox](https://www.docker.com/products/docker-toolbox) and [Vagrant](https://www.vagrantup.com/downloads.html)

```
  - Open Vagrantfile
  - copy vagrantfile.dist.yml to vagrantfile.yml 
  - set your preferred private_network IP, cpus and RAM size in it(Remember you have to provide enough memory for your containers)
  - vagrant up
  - once the VM is up, open 'docker_create' file
  - set "generic-ip-address" with Vagrantfile private_ip and change "default" if you had set up vagrant machine name
  - launch it "sh docker_create.sh"
  - it will install the Docker Machine
  - launch docker-machine env default
  - launch eval "$(docker-machine env default)"
  - in your OSX terminal try to launch 'docker ps', 'docker-machine ssh' or 'vagrant ssh'
  - test it with 'docker run -it busybox /bin/bash'
  - try Docker Compose! open docker-compose.yml and launch docker-compose up -d
```

##Install a Symfony Environment

```
  - complete Setup section
  - docker-compose up -d
  - launch from your OSX terminal:
	- docker exec -it web.1 sh -c 'curl -sS https://getcomposer.org/installer | php'
  	- docker exec -it web.1 sh -c 'mv composer.phar /usr/local/bin/composer && chmod 755 /usr/local/bin/composer'
  	- docker exec -it web.1 sh -c 'curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony && cd /var/www/vhosts/example1.it && /usr/local/bin/symfony new blog lts'
```
