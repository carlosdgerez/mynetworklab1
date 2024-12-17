#!/bin/bash

# Update package list and install iptables-persistent for saving rules
sudo apt update
sudo apt install -y iptables-persistent

# Allow traffic to Load Balancer
sudo iptables -A OUTPUT -d 192.168.56.20 -j ACCEPT

# Allow traffic to Database
sudo iptables -A OUTPUT -d 192.168.57.10 -j ACCEPT

# Allow internet access
sudo iptables -A OUTPUT -o eth1 -j ACCEPT

# Allow SSH access on port 22 to the host
sudo iptables -A INPUT -p tcp --dport 22 -s 10.0.0.1 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Enable NAT for DNS resolution and forwarding
sudo iptables -A FORWARD -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Optional: Deny all other outgoing traffic (uncomment if needed)
# sudo iptables -A OUTPUT -j DROP

# Save the iptables rules for persistence
sudo netfilter-persistent save

# Reload rules to ensure they're applied immediately
sudo netfilter-persistent reload

echo "Firewall rules configured and saved successfully!"

