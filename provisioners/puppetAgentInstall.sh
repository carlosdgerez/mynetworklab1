

# Enable the plattform repository

wget https://apt.puppetlabs.com/puppet8-release-bionic.deb 
   dpkg -i puppet8-release-bionic.deb
   apt update

# Install the agent
   apt-get install puppet-agent

# Start the puppet service
   /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

source /etc/profile.d/puppet-agent.sh
