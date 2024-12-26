#!/bin/bash

# Update package list and install iptables-persistent
# Update package list and install iptables-persistent for saving rules
export DEBIAN_FRONTEND=noninteractive

# Pre-answer any known questions
echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | sudo debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | sudo debconf-set-selections

# Update package index
apt-get update -q

# Install iptables non-interactively
apt install -y iptables-persistent

# Allow traffic to web servers in the 192.168.56.0/24 subnet
    iptables -A OUTPUT -d 192.168.56.0/24 -j ACCEPT

# Block traffic to the secure zone in the 192.168.57.0/21 subnet
    iptables -A OUTPUT -d 192.168.57.0/24 -j DROP

# Allow internet access on interface eth1
    iptables -A OUTPUT -o eth1 -j ACCEPT

# Allow SSH access on port 22 to the host (10.0.0.1)
    iptables -A INPUT -p tcp --dport 22 -s 10.0.0.1 -j ACCEPT
    iptables -A INPUT -p tcp --dport 22 -s 10.0.0.7 -j ACCEPT # Patch to Tromsø net. Fix with a variable later.
    iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Enable NAT for DNS resolution and packet forwarding
    iptables -A FORWARD -o eth0 -j ACCEPT
    iptables -A FORWARD -i eth0 -j ACCEPT
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Save iptables rules for persistence
    netfilter-persistent save
    netfilter-persistent reload

# Completion message
echo "Firewall rules have been configured and saved successfully!"