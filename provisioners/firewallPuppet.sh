# Update package list and install iptables-persistent for saving rules
export DEBIAN_FRONTEND=noninteractive

# Pre-answer any known questions
echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | sudo debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | sudo debconf-set-selections

# Update package index
apt-get update -q

# Install iptables non-interactively
apt install -y iptables-persistent
# Set up basic firewall rules

# Accept all incoming and outgoing traffic by default (adjust as necessary)
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT

# Enable NAT for forwarding DNS and routing
    iptables -A FORWARD -o eth0 -j ACCEPT
    iptables -A FORWARD -i eth0 -j ACCEPT
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


# Save the rules for persistence
    netfilter-persistent save

# Reload rules to ensure they are active
    netfilter-persistent reload

echo "Iptables rules configured and saved successfully!"