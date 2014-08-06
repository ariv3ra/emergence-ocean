#!/bin/bash

# Install service binaries
apt-get update && apt-get upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get install -y python-software-properties python g++ make nodejs npm nodejs-legacy nginx php5-fpm php5-cli php5-apcu php5-mysql php5-gd php5-json php5-curl php5-intl mysql-server mysql-client ruby-compass gettext imagemagick postfix

# Stop and disable default service instances
service nginx stop && update-rc.d -f nginx disable
service php5-fpm stop && (echo "manual" | tee /etc/init/php5-fpm.override)
service mysql stop && (echo "manual" | tee /etc/init/mysql.override)

# Configure AppArmor to allow Emergence to manage mysqld
echo -e "/emergence/services/etc/my.cnf r,\n/emergence/services/data/mysql/ r,\n/emergence/services/data/mysql/** rwk,\n/emergence/services/run/mysqld/mysqld.sock w,\n/emergence/services/run/mysqld/mysqld.pid rw," | tee -a /etc/apparmor.d/local/usr.sbin.mysqld
/etc/init.d/apparmor reload

# Increase shared memory limit
echo -e "kernel.shmmax = 268435456\nkernel.shmall = 65536" | tee -a /etc/sysctl.d/60-shmmax.conf
sysctl -w kernel.shmmax=268435456 kernel.shmall=65536
echo -e "apcu.shm_size=128M\napc.shm_size=128M" | tee -a /etc/php5/mods-available/apcu.ini

# Install Emergence from GitHub
apt-get install -y git
git clone https://github.com/JarvusInnovations/Emergence ~/Emergence && cd ~/Emergence
npm install -g

# Start Emergence
wget http://emr.ge/dist/debian/upstart -O /etc/init/emergence-kernel.conf
start emergence-kernel