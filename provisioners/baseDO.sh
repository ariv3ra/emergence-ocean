#!/bin/bash -eux

# Get Update Information
#yum -y update

yum -y install ntp ntpdate ntp-doc nano wget



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

yum -y install ntp ntpdate ntp-doc nano

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
echo '#Disable TCP timestamps-Added by Angel Rivera' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_timestamps = 0' >> /etc/sysctl.conf


########
# Todo:
# Install MSQL server
# Install SSL Cert
# Install phpMyAdmin
# Configure MSQL server with apiDoc database & tables


