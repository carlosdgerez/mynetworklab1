BOX = "bento/ubuntu-22.04"


Vagrant.configure("2") do |config|
  # Define the virtual machines
  config.vm.define :lb do |lb|
    lb.vm.box = BOX
    lb.vm.network "private_network", type: "dhcp", virtualbox__intnet: "internal_network"
    lb.vm.network "public_network", type: "dhcp"
    lb.vm.provision "shell", inline: <<-SHELL
      # Install HAProxy (or any load balancer you prefer)
      sudo apt-get update
      sudo apt-get install -y haproxy
      # Configure HAProxy to load balance between web servers (replace with your own IPs later)
      sudo sh -c 'echo "frontend http_front\n  bind *:80\n  default_backend http_back" > /etc/haproxy/haproxy.cfg'
      sudo sh -c 'echo "backend http_back\n  server web1 192.168.50.10:80 check\n  server web2 192.168.50.11:80 check" >> /etc/haproxy/haproxy.cfg'
      sudo systemctl restart haproxy
    SHELL
  end

  config.vm.define :web1 do |web1|
    web1.vm.box = BOX
    web1.vm.network "private_network", type: "dhcp", virtualbox__intnet: "internal_network"
    web1.vm.network "forwarded_port", guest: 80, host: 8081
    web1.vm.provision "shell", inline: <<-SHELL
      # Install Apache or any web server
      sudo apt-get update
      sudo apt-get install -y apache2
      sudo systemctl start apache2
    SHELL
  end

  config.vm.define :web2 do |web2|
    web2.vm.box = BOX
    web2.vm.network "private_network", type: "dhcp", virtualbox__intnet: "internal_network"
    web2.vm.network "forwarded_port", guest: 80, host: 8082
    web2.vm.provision "shell", inline: <<-SHELL
      # Install Apache or any web server
      sudo apt-get update
      sudo apt-get install -y apache2
      sudo systemctl start apache2
    SHELL
  end

  config.vm.define :internal do |internal|
    internal.vm.box = BOX
    internal.vm.network "private_network", type: "dhcp", virtualbox__intnet: "internal_network"
    internal.vm.provision "shell", inline: <<-SHELL
      # Setup the internal box with necessary packages
      sudo apt-get update
      sudo apt-get install -y curl
    SHELL
  end

  config.vm.define "database" do |db|
    db.vm.box = BOX
    db.vm.network "private_network", type: "dhcp", virtualbox__intnet: "internal_network"
    db.vm.provision "shell", inline: <<-SHELL
      # Install a database (e.g., MySQL)
      sudo apt-get update
      sudo apt-get install -y mysql-server
      sudo systemctl start mysql
    SHELL
  end

  # Define the internal network that all machines will connect to
  config.vm.network "private_network", type: "dhcp", virtualbox__intnet: "internal_network"
end
