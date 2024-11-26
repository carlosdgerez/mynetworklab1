#! /bin/bash

# Allow traffic to LB
sudo iptables -A OUTPUT -d 192.168.50.20 -j ACCEPT

# Allow traffic to DB
sudo iptables -A OUTPUT -d 192.168.60.10 -j ACCEPT

# Allow internet access
sudo iptables -A OUTPUT -o eth1 -j ACCEPT

# Allow port 22 for ssh to host
sudo iptables -A INPUT -p tcp --dport 22 -s 10.0.0.1 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Allow NAT to resolve DNS
sudo iptables -A FORWARD -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Deny other outgoing traffic
sudo iptables -A OUTPUT -j DROP

# save the rules

sudo apt install iptables-persistent
sudo netfilter-persistent save

