
BOX = "ubuntu/bionic64"

Vagrant.configure("2") do |config|
  # Define the base box to use
  config.vm.box = BOX  # You can choose any base box
  config.vm.boot_timeout= 300
  config.ssh.insert_key = true

  # Define the load balancer VM with a static IP
  config.vm.define :lb do |lb|
    lb.vm.hostname = "lb.local"

    # Forward ports for HTTP and HTTPS traffic
    lb.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    lb.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true
    lb.vm.network "private_network", ip: "192.168.56.20"      # Internal network
    lb.vm.network "public_network", type: "dhcp"              # NAT for internet

   

    lb.vm.provider "virtualbox" do |vb|
      vb.memory = "512"  # Adjust the memory allocation
    end
    lb.vm.provision "shell", path: "provisioners/puppetAgentInstall.sh"  
    lb.vm.provision "shell", path: "provisioners/firewalllb.sh"
    
  end

  # Define the first web server VM with a static IP
  config.vm.define :web1 do |web1|
    web1.vm.hostname = "web1.local"
    web1.vm.network "forwarded_port", guest: 80, host: 9091, auto_correct: true
    web1.vm.network "private_network", ip: "192.168.56.21"    # Internal network
    web1.vm.network "private_network", ip: "192.168.57.21"    # Secure zone
    web1.vm.network "public_network", type: "dhcp"            # NAT for internet. Comented to block.

    web1.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
    web1.vm.provision "shell", path: "provisioners/puppetAgentInstall.sh"
    web1.vm.provision "shell", path: "provisioners/firewallweb.sh"
    web1.vm.provision "shell", path: "provisioners/apacheInstall.sh"
    web1.vm.provision "shell", path: "provisioners/unzipInstall.sh"
  end

  # Define the second web server VM with a static IP
  config.vm.define :web2 do |web2|
    web2.vm.hostname = "web2.local"
    web2.vm.network "forwarded_port", guest: 80, host: 9092, auto_correct: true
    web2.vm.network "private_network", ip: "192.168.56.22"    # Internal network
    web2.vm.network "private_network", ip: "192.168.57.22"    # Secure zone
    web2.vm.network "public_network", type: "dhcp"            # NAT for internet. Comented to block.
  
    web2.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
    web2.vm.provision "shell", path: "provisioners/puppetAgentInstall.sh"
    web2.vm.provision "shell", path: "provisioners/firewallweb.sh"
    web2.vm.provision "shell", path: "provisioners/apacheInstall.sh"
    web2.vm.provision "shell", path: "provisioners/unzipInstall.sh"
  end

  # Define the database server VM with a static IP (in a secure zone)
  config.vm.define :db do |db|
    db.vm.hostname = "db.local"
    db.vm.network "forwarded_port", guest: 80, host: 9093, auto_correct: true
    db.vm.network "private_network", ip: "192.168.57.10"      # Secure zone
    db.vm.network "public_network", type: "dhcp"              # NAT for internet. Comented to block. 
                                                              # (sudo ifconfig enp0s9 down) as fast alternative.
 
    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
    db.vm.provision "shell", path: "provisioners/puppetAgentInstall.sh"
    db.vm.provision "shell", path: "provisioners/firewalldb.sh"
   
  end
  config.vm.define :puppet do |puppet|
    puppet.vm.hostname = "puppet.local"
    puppet.vm.network "forwarded_port", guest: 80, host: 9090, auto_correct: true
    puppet.vm.network "private_network", ip: "192.168.56.10" # Management network
    puppet.vm.network "public_network", type: "dhcp"          # NAT for internet. Review latter restricted access.


    puppet.vm.synced_folder ".", "/mynetworklab"

    puppet.vm.provider "virtualbox" do |vb|
      vb.memory = "3072"  # Adjust the memory allocation
    end
    puppet.vm.provision "shell", path: "provisioners/puppetserverInstall.sh"
    puppet.vm.provision "shell", path: "provisioners/firewallPuppet.sh"
    puppet.vm.provision "shell", path: "provisioners/r10kInstall.sh" 
  end
end
