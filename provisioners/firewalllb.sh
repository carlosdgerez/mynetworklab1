#!/bin/bash

# Update package list and install iptables-persistent
sudo apt update
sudo apt install -y iptables-persistent

# Allow traffic to web servers in the 192.168.56.0/21 subnet
sudo iptables -A OUTPUT -d 192.168.56.0/21 -j ACCEPT

# Block traffic to the secure zone in the 192.168.57.0/21 subnet
sudo iptables -A OUTPUT -d 192.168.57.0/21 -j DROP

# Allow internet access on interface eth1
sudo iptables -A OUTPUT -o eth1 -j ACCEPT

# Allow SSH access on port 22 to the host (10.0.0.1)
sudo iptables -A INPUT -p tcp --dport 22 -s 10.0.0.1 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Enable NAT for DNS resolution and packet forwarding
sudo iptables -A FORWARD -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Save iptables rules for persistence
sudo netfilter-persistent save
sudo netfilter-persistent reload

# Completion message
echo "Firewall rules have been configured and saved successfully!"