#!/bin/bash

# Update package list and install necessary dependencies
# Update package list and install iptables-persistent for saving rules
export DEBIAN_FRONTEND=noninteractive

# Pre-answer any known questions
echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | sudo debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | sudo debconf-set-selections

# Update package index
apt-get update -q

# Install iptables non-interactively
apt install -y iptables-persistent

# Allow traffic from web1 and web2
  iptables -A INPUT -s 192.168.57.21 -j ACCEPT
  iptables -A INPUT -s 192.168.57.22 -j ACCEPT

# Allow traffic from Puppet server
  iptables -A INPUT -s 192.168.56.10 -j ACCEPT
  iptables -A OUTPUT -d 192.168.56.10 -j ACCEPT

# Allow traffic to/from Puppet server (IP: 192.168.56.10)
iptables -A INPUT -p tcp -s 192.168.56.10 --dport 8140 -j ACCEPT
iptables -A OUTPUT -p tcp -d 192.168.56.10 --sport 8140 -j ACCEPT

# Allow  access on port 22 to the host (10.0.0.1)
  iptables -A INPUT -p tcp --dport 22 -s 10.0.0.1 -j ACCEPT
  iptables -A INPUT -p tcp --dport 22 -s 10.0.0.7 -j ACCEPT # Patch Fix to Tromsø net host, need review.
  iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Allow NAT for DNS resolution and packet forwarding
  iptables -A FORWARD -o eth0 -j ACCEPT
  iptables -A FORWARD -i eth0 -j ACCEPT
  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Allow MySQL traffic from specific IPs (web1 and web2)
  iptables -A INPUT -p tcp -s 192.168.57.21 --dport 3306 -j ACCEPT
  iptables -A INPUT -p tcp -s 192.168.57.22 --dport 3306 -j ACCEPT

# Optional: Deny other outgoing traffic on port 3306 (uncomment if needed)
   iptables -A OUTPUT --dport 3306 -j DROP

# Save iptables rules for persistence
  netfilter-persistent save
  netfilter-persistent reload

# Configure Firewalld to allow MySQL connections
  firewall-cmd --add-service=mysql --permanent
  firewall-cmd --reload

# Completion message
echo "Firewall rules have been configured and saved successfully!"
