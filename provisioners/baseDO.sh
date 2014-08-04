#!/bin/bash -eux

# Add the
yum -y install \
 http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# Get Update Information
yum -y update

# Install the Develpment tools
yum -y groupinstall "Development Tools"

#Install the required packages
yum -y install ntp ntpdate ntp-doc git nano wget python gcc-c++ make ruby rubygems\
 nginx php-fpm php-cli php-pecl-apc php-mysql php-gd php-json php-curl\
 php-intl mysql msql-server gettext ImageMagick postfix 

#Install ruby gem
gem update --system

#Install ruby compass gem
gem install compass

# # Install Node.js
 yum -y install nodejs npm --enablerepo=epel

# Stop and disable default service instances
# Kill this line later Ubuntu instance - service nginx stop &&  update-rc.d -f nginx disable
chkconfig nginx off && chkconfig nginx --del
chkconfig mysqld off && chkconfig mysqld --del
chkconfig php-fpm off && chkconfig php-fpm --del


# service php5-fpm stop && (echo "manual" |  tee /etc/init/php5-fpm.override)
# service mysql stop && (echo "manual" |  tee /etc/init/mysql.override)

# Increase shared memory limit
sed -i.bak 's/kernel.shmmax = 68719476736/kernel.shmmax = 268435456/' /etc/sysctl.conf
sed -i.bak 's/kernel.shmall = 4294967296/kernel.shmall = 65536/' /etc/sysctl.conf
sysctl -w kernel.shmmax=268435456 kernel.shmall=65536
echo -e "apcu.shm_size=128M\napc.shm_size=128M" | sudo tee -a /etc/php.d/apcu.ini

######################
# Install Emergence
######################

# Configure AppArmor to allow Emergence to manage mysqld
# echo -e "/emergence/services/etc/my.cnf r,\n/emergence/services/data/mysql/ r,\n/emergence/services/data/mysql/** rwk,\n/emergence/services/run/mysqld/mysqld.sock w,\n/emergence/services/run/mysqld/mysqld.pid rw," | sudo tee -a /etc/apparmor.d/local/usr.sbin.mysqld
# sudo /etc/init.d/apparmor reload

#Clone the Emergence repo
git clone https://github.com/JarvusInnovations/Emergence ~/Emergence && cd ~/Emergence
npm install -g

# Move emergence-kernel startup script
mv /tmp/emergence-kernel.sh /etc/init.d/emergence-kernel

# Add emergence-kernel service to auto start on systemd
chkconfig --level 345 emergence-kernel on

# Make emergence-kernel executable
chmod -x /etc/init.d/emergence-kernel

# Start Emergence
# service emergence-kernel start

# Update root certs
wget -O/etc/pki/tls/certs/ca-bundle.crt http://curl.haxx.se/ca/cacert.pem
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Copy ssh files for git pull down
cd ~/.ssh

# Create the ssh config file
touch ~/.ssh/config

# Insert the StrictChecking off
echo 'StrictHostKeyChecking no' >> ~/.ssh/config

#move the id_files to the proper place
mv /tmp/id_rsa ~/.ssh
mv /tmp/id_rsa.pub ~/.ssh

# Set the file permissions
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub

#############################
#  
# Emergence Specific installs
#
#############################

# Turn on ntp service 
chkconfig ntpd on
#/etc/init.d/ntpd start
ntpdate pool.ntp.org

# Firewall
# Add the ports to be opened in firewall
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 9083 -j ACCEPT


# resstart firewall
/etc/init.d/iptables stop
/etc/init.d/iptables start

# Adjust SELinux rules:
#setsebool -P httpd_can_network_relay=1

# Disable TCP timestamps
echo '#Disable TCP timestamps' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_timestamps = 0' >> /etc/sysctl.conf


########
# Todo:
# Install MSQL server
# Install SSL Cert
# Install phpMyAdmin
# Configure MSQL server with apiDoc database & tables


