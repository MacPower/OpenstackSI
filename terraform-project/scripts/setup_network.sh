#!/bin/bash

## As root

cd /root/

## load source file 
. ~/openrc

openstack network create network_1 \
--dns-nameserver 8.8.8.8 8.8.4.4

openstack subnet create private_subnet_1 \
    --network network_1 \
    --subnet-range 192.168.100.0/24 

openstack router create admin_router_1