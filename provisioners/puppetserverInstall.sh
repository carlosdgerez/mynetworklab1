#! /bin/bash

wget https://apt.puppetlabs.com/puppet6-release-focal.deb 
sudo dpkg -i puppet6-release-focal.deb
sudo apt update

 # Install Puppet server (puppet agent and server on the same machine)
sudo apt-get update
sudo apt-get install -y puppetserver




