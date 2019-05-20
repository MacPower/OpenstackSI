#!/bin/bash

# Upgrade the system to latest packages version
apt-get update && apt upgrade -y && apt-get dist-upgrade -y

# install necessary packages
apt-get install aptitude build-essential git ntp ntpdate openssh-server python-dev sudo -y 

# Getting OSA
git clone -b master https://opendev.org/openstack/openstack-ansible /opt/openstack-ansible

cd /opt/openstack-ansible/

# Moving to stable branch
git checkout stable/queens

# VM volume 
export BOOTSTRAP_OPTS="bootstrap_host_data_disk_device=sdb"
export ANSIBLE_ROLE_FETCH_MODE=git-clone

cd scripts/

./bootstrap-ansible.sh
./bootstrap-aio.sh

cd /opt/openstack-ansible/

echo "lxc_cache_prep_timeout: 3600" >> /etc/openstack_deploy/user_variables.yml

cd playbooks/

openstack-ansible setup-hosts.yml
openstack-ansible setup-infrastructure.yml
openstack-ansible setup-openstack.yml

