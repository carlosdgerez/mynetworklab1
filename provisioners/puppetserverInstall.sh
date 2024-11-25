#! /bin/bash

# Download the puppet apt repositories config packages
curl -O https://apt.puppet.com/puppet8-release-jammy.deb
curl -O https://apt.puppet.com/puppet-tools-release-jammy.deb

# Install the puppet apt repositories config packages
sudo dpkg -i puppet8-release-jammy.deb puppet-tools-release-jammy.deb

# Update the apt package list
sudo apt-get update

# Install the packages for Zeroconf DNS
sudo apt-get install -y avahi-daemon avahi-utils libnss-mdns

# Install Puppetserver and other puppet tools
sudo apt-get install -y puppetserver puppet-bolt pdk
