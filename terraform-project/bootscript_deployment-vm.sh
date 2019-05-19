#!/bin/bash
sudo apt-get update
apt upgrade -y
apt-get dist-upgrade -y
apt-get install aptitude build-essential git ntp ntpdate openssh-server python-dev sudo -y 
git clone -b master https://opendev.org/openstack/openstack-ansible /opt/openstack-ansible
cd /opt/openstack-ansible/scripts
./bootstrap-ansible.sh