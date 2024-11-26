

# Enable the plattform repository

wget https://apt.puppetlabs.com/puppet8-release-bionic.deb 
sudo dpkg -i puppet8-release-bionic.deb
sudo apt update

# Install the agent
sudo apt-get install puppet-agent

# Start the puppet service
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

source /etc/profile.d/puppet-agent.sh
