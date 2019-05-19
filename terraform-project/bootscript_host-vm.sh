#!/bin/bash
sudo apt-get update
apt upgrade -y
apt-get dist-upgrade -y
apt-get install bridge-utils debootstrap ifenslave ifenslave-2.6 \
  lsof lvm2 chrony openssh-server sudo tcpdump vlan python -y
apt install linux-image-extra-$(uname -r) -y
echo 'bonding' >> /etc/modules
echo '8021q' >> /etc/modules
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPXv/U+LZubR02RTZ96jslRxhwtAS05G324T7ZSnDKKaRn70tvFfTQxjGULAXOemVJYFedlKGJelxLgvDm7pb2X8nJyEvwHJ/qtjHJfImJwRYV+Wyvt5erU734PLVu3iTfs8y6urZNF5DiV5LrtIrVBbHQj4isuIb9Kq9UyHflZOE+b3eJRySNaig90eUUVeIOJG/6VAP80nJYHoju2dhiVziRJ0NHKMh9WtBnRHOtFS4tHhLO+h3DP+zwVOh23HOYtZuetZWPPo0x/tklRjgRIbyhnxOPulksqHtWeaViRD3CFmqFcUxymdPH2ItITc9ScmS3OuYkYVVYpxjsGw1z' >> /home/ubuntu/.ssh/authorized_keys
#service ssh restart
service chrony restart
#reboot
