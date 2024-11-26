#! /bin/bash

sudo apt-get update
sudo apt-get install -y mariadb-server
sudo mysql_secure_installation
    # Set up the database (optional)
mysql -e "CREATE DATABASE mydb;"
mysql -e "CREATE USER 'carlos'@'%' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON mydb.* TO 'carlos'@'%';"
sudo systemctl enable mariadb
sudo systemctl start mariadb