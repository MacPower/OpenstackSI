#!/bin/bash
sudo cp /tmp/id_rsa /root/.ssh/
sudo cp /tmp/id_rsa.pub /root/.ssh/

sudo chmod 600 /root/.ssh/id_rsa
sudo chmod 644 /root/.ssh/id_rsa.pub