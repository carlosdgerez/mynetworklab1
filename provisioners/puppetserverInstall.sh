#! /bin/bash

wget https://apt.puppetlabs.com/puppet8-release-bionic.deb 
sudo dpkg -i puppet8-release-bionic.deb
sudo apt update

 # Install Puppet server (puppet agent and server on the same machine)
sudo apt-get update
sudo apt-get install -y puppetserver
sudo systemctl start puppetserver



