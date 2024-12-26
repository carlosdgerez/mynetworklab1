#! /bin/bash

   apt-get update
   apt-get install -y apache2
echo "Web Server" |    tee /var/www/html/index.html
   systemctl enable apache2
   systemctl start apache2