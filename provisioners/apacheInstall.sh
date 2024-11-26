#! /bin/bash

sudo apt-get update
sudo apt-get install -y apache2
echo "Web Server 2" | sudo tee /var/www/html/index.html
sudo systemctl enable apache2
sudo systemctl start apache2