#!/bin/bash

# Define the lines to add
HOSTS_ENTRIES="192.168.56.10 puppetserver.local puppet.local puppet
192.168.56.20 lb lb.local
192.168.56.21 192.168.57.21 web1 web1.local
192.168.56.22 192.168.57.22 web2 web2.local"

# Backup the original /etc/hosts file if not already backed up
if [ ! -f /etc/hosts.bak ]; then
  cp /etc/hosts /etc/hosts.bak
fi

# Add each line if not already present
for entry in "$HOSTS_ENTRIES"; do
  if ! grep -qF "$entry" /etc/hosts; then
    echo "$entry" | sudo tee -a /etc/hosts > /dev/null
  fi
done