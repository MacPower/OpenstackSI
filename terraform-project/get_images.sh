#!/bin/bash

## As root

cd /root/

## load source file 
. ~/openrc

### Get Centos 7 image
wget http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1901.qcow2

### Get Ubuntu Bionic 1804 latest 
wget http://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.vmdk


### Upload images to glance

openstack image create \
        --container-format bare \
        --disk-format qcow2 \
        --file CentOS-7-x86_64-GenericCloud-1901.qcow2 \
        CentOS-7-x86_64

openstack image create \
        --container-format bare \
        --disk-format vmdk \
        --file bionic-server-cloudimg-amd64.vmdk \
       Ubuntu-Bionic-x86_64
