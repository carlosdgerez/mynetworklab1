#! /bin/bash

wget https://apt.puppetlabs.com/puppet8-release-bionic.deb 
   dpkg -i puppet8-release-bionic.deb
   apt update

 # Install Puppet server (puppet agent and server on the same machine)
   apt-get update
   apt-get install -y puppetserver pdk
   systemctl start puppetserver

   # Create a symbolic link between production environment and the synced file
   rm -rf /etc/puppetlabs/code/environments/production
   ln -s /home/carlos/Desktop/lab/mynetworklab /production



