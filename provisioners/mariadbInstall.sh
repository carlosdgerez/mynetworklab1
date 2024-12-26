#! /bin/bash

    apt-get update
    apt-get install -y mariadb-server
    mysql_secure_installation
    # Set up the database (optional)
mysql -e "CREATE DATABASE mydb;"
mysql -e "CREATE USER 'carlos'@'%' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON mydb.* TO 'carlos'@'%';"
    systemctl enable mariadb
    systemctl start mariadb