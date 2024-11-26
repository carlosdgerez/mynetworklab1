#! /bin/bash

# Allow traffic from web1 and web2
sudo iptables -A INPUT -s 192.168.60.21 -j ACCEPT
sudo iptables -A INPUT -s 192.168.60.22 -j ACCEPT

# Allow traffic from puppet server
sudo iptables -A INPUT -s 192.168.50.10 -j ACCEPT


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
