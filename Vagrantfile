
BOX = "ubuntu/xenial64"

Vagrant.configure("2") do |config|
  # Define the base box to use
  config.vm.box = BOX  # You can choose any base box
  config.vm.boot_timeout= 600

  # Define the load balancer VM with a static IP
  config.vm.define :lb do |lb|
    lb.vm.hostname = "lb.local"
    lb.vm.network "private_network", ip: "192.168.56.10"  # Static IP for the load balancer
    lb.vm.network "forwarded_port", guest: 80, host: 8080
    lb.vm.synced_folder ".", "/myPuppetLab"
   #lb.vm.network "public_network"  # Public network to connect to the internet
    lb.vm.provider "virtualbox" do |vb|
      vb.memory = "512"  # Adjust the memory allocation
    end
    #lb.vm.provision "shell", inline: <<-SHELL
      
  end

  # Define the first web server VM with a static IP
  config.vm.define :web1 do |web1|
    web1.vm.hostname = "web1.local"
    web1.vm.network "private_network", ip: "192.168.56.11"  # Static IP for web server 1
    web1.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
  #  web1.vm.provision "shell", inline: <<-SHELL
  #    sudo apt-get update
  #    sudo apt-get install -y apache2
  #    echo "Web Server 1" | sudo tee /var/www/html/index.html
  #    sudo systemctl enable apache2
  #    sudo systemctl start apache2
  #  SHELL
  end

  # Define the second web server VM with a static IP
  config.vm.define :web2 do |web2|
    web2.vm.hostname = "web2.local"
    web2.vm.network "private_network", ip: "192.168.56.12"  # Static IP for web server 2
    web2.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
   # web2.vm.provision "shell", inline: <<-SHELL
   #   sudo apt-get update
   #   sudo apt-get install -y apache2
   #   echo "Web Server 2" | sudo tee /var/www/html/index.html
   #   sudo systemctl enable apache2
   #   sudo systemctl start apache2
   # SHELL
  end

  # Define the database server VM with a static IP (in a secure zone)
  config.vm.define :db do |db|
    db.vm.hostname = "db.local"
    db.vm.network "private_network", ip: "192.168.56.13"  # Static IP for MariaDB server
    db.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
   # db.vm.provision "shell", inline: <<-SHELL
   #   sudo apt-get update
   #   sudo apt-get install -y mariadb-server
   #   sudo mysql_secure_installation
      # Set up the database (optional)
   #   mysql -e "CREATE DATABASE mydb;"
    #  mysql -e "CREATE USER 'carlos'@'%' IDENTIFIED BY 'password';"
    #  mysql -e "GRANT ALL PRIVILEGES ON mydb.* TO 'carlos'@'%';"
    #  sudo systemctl enable mariadb
    #  sudo systemctl start mariadb
   # SHELL
  end
end
