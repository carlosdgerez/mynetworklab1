#!/bin/bash

# Update package list and install necessary dependencies
sudo apt update
sudo apt install -y iptables-persistent firewalld

# Allow traffic from web1 and web2
sudo iptables -A INPUT -s 192.168.57.21 -j ACCEPT
sudo iptables -A INPUT -s 192.168.57.22 -j ACCEPT

# Allow traffic from Puppet server
sudo iptables -A INPUT -s 192.168.56.10 -j ACCEPT
sudo iptables -A OUTPUT -d 192.168.56.10 -j ACCEPT

# Allow SSH access on port 22 to the host (10.0.0.1)
sudo iptables -A INPUT -p tcp --dport 22 -s 10.0.0.1 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Allow NAT for DNS resolution and packet forwarding
sudo iptables -A FORWARD -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Allow MySQL traffic from specific IPs (web1 and web2)
sudo iptables -A INPUT -p tcp -s 192.168.57.21 --dport 3306 -j ACCEPT
sudo iptables -A INPUT -p tcp -s 192.168.57.22 --dport 3306 -j ACCEPT

# Optional: Deny other outgoing traffic (uncomment if needed)
# sudo iptables -A OUTPUT -j DROP

# Save iptables rules for persistence
sudo netfilter-persistent save
sudo netfilter-persistent reload

# Configure Firewalld to allow MySQL connections
sudo firewall-cmd --add-service=mysql --permanent
sudo firewall-cmd --reload

# Completion message
echo "Firewall rules have been configured and saved successfully!"
