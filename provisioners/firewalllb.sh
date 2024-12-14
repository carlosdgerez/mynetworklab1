#! /bin/bash



# Allow traffic to web servers
sudo iptables -A OUTPUT -d 192.168.56.0/21 -j ACCEPT

# Block traffic to secure zone
sudo iptables -A OUTPUT -d 192.168.57.0/21 -j DROP

# Allow internet access
sudo iptables -A OUTPUT -o eth1 -j ACCEPT

# Allow port 22 for ssh to host
sudo iptables -A INPUT -p tcp --dport 22 -s 10.0.0.1 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Allow NAT to resolve DNS
sudo iptables -A FORWARD -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE



# save the rules

sudo apt install iptables-persistent
sudo netfilter-persistent save