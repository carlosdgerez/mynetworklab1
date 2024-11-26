#! /bin/bash

sudo iptables -A INPUT -j ACCEPT
sudo iptables -A OUTPUT -j ACCEPT

# Allow NAT to resolve DNS
sudo iptables -A FORWARD -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# save the rules

sudo apt install iptables-persistent
sudo netfilter-persistent save