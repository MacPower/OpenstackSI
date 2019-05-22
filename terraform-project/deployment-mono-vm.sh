#!/bin/bash

## Update and install required packages 

apt update 
apt upgrade -y
apt dist-upgrade

## Add SSH Key 
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPXv/U+LZubR02RTZ96jslRxhwtAS05G324T7ZSnDKKaRn70tvFfTQxjGULAXOemVJYFedlKGJelxLgvDm7pb2X8nJyEvwHJ/qtjHJfImJwRYV+Wyvt5erU734PLVu3iTfs8y6urZNF5DiV5LrtIrVBbHQj4isuIb9Kq9UyHflZOE+b3eJRySNaig90eUUVeIOJG/6VAP80nJYHoju2dhiVziRJ0NHKMh9WtBnRHOtFS4tHhLO+h3DP+zwVOh23HOYtZuetZWPPo0x/tklRjgRIbyhnxOPulksqHtWeaViRD3CFmqFcUxymdPH2ItITc9ScmS3OuYkYVVYpxjsGw1z' >> /home/root/.ssh/authorized_keys

## Clone Repo Openstack Ansible
git clone -b stable/stein https://opendev.org/openstack/openstack-ansible /opt/openstack-ansible

## Boostrap System 
cd /opt/openstack-ansible/scripts/

./bootstrap-ansible.sh
./bootstrap-aio.sh 

## Install OpenStack
cd /opt/openstack-ansible/playbooks/

openstack-ansible setup-hosts.yml
openstack-ansible setup-infrastructure.yml
openstack-ansible setup-openstack.yml

## install openstack additionnal components
openstack-ansible os-keystone-install.yml

## Get Ubuntu and Centos Images to Glance
/tmp/get_images.sh

## Set Nova compute flavors
/tmp/set_falvors.sh

echo "DONE"