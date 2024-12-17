# Install iptables-persistent to save rules
sudo apt update
sudo apt install -y iptables-persistent

# Set up basic firewall rules

# Accept all incoming and outgoing traffic by default (adjust as necessary)
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT

# Enable NAT for forwarding DNS and routing
sudo iptables -A FORWARD -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# Save the rules for persistence
sudo netfilter-persistent save

# Reload rules to ensure they are active
sudo netfilter-persistent reload

echo "Iptables rules configured and saved successfully!"