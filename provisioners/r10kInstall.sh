#! /bin/bash

# r10k installer 

/opt/puppetlabs/puppet/bin/gem install r10k


# install modules that are in the puppetfile in the root directory
cd /mynetworklab
/opt/puppetlabs/puppet/bin/r10k puppetfile install -v