#!/bin/bash

# Update package list and install iptables-persistent for saving rules
export DEBIAN_FRONTEND=noninteractive

# Pre-answer any known questions
echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | sudo debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | sudo debconf-set-selections

# Update package index
apt-get update -q

# Install iptables non-interactively
apt install -y iptables-persistent

# Allow traffic to Load Balancer
    iptables -A OUTPUT -d 192.168.56.20 -j ACCEPT

# Allow traffic to Database
    iptables -A OUTPUT -d 192.168.57.10 -j ACCEPT

# Allow internet access
    iptables -A OUTPUT -o eth1 -j ACCEPT

# Allow SSH access on port 22 to the host
    iptables -A INPUT -p tcp --dport 22 -s 10.0.0.1 -j ACCEPT
    iptables -A INPUT -p tcp --dport 22 -s 10.0.0.7 -j ACCEPT # Patch to fix with a variable for the local net.
    iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Enable NAT for DNS resolution and forwarding
    iptables -A FORWARD -o eth0 -j ACCEPT
    iptables -A FORWARD -i eth0 -j ACCEPT
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Optional: Deny all other outgoing traffic (uncomment if needed)
#     iptables -A OUTPUT -j DROP

# Save the iptables rules for persistence
    netfilter-persistent save

# Reload rules to ensure they're applied immediately
    netfilter-persistent reload

echo "Firewall rules configured and saved successfully!"

