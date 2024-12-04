#! /bin/bash

sudo apt-get update
sudo apt-get install -y apache2
echo "Web Server" | sudo tee /var/www/html/index.html
sudo systemctl enable apache2
sudo systemctl start apache2