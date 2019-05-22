#!/bin/bash

## Create flavor (type of instance)
openstack flavor create \
        --public t4.micro \
        --id auto \
        --ram 1024 \
        --disk 1 \
        --vcpus 1 \
        --rxtx-factor 1
    
openstack flavor create \
        --public t4.nano \
        --id auto \
        --ram 2048 \
        --disk 4 \
        --vcpus 2 \
        --rxtx-factor 1

openstack flavor create \
        --public t4.xlarge \
        --id auto \
        --ram 4096 \
        --disk 8 \
        --vcpus 4 \
        --rxtx-factor 1