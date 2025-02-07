#!/bin/bash
# This script will run the first time vagrant file is call.
# Ensure the MySQL configuration file exists
if [ -f /etc/mysql/my.cnf ]; then
  echo -e "\n[mysqld]\nbind-address = 0.0.0.0" |  tee -a /etc/mysql/my.cnf
  echo "Configuration added to /etc/mysql/my.cnf"

  # Restart MySQL service to apply changes
  systemctl restart mysql
else
  echo "Error: /etc/mysql/my.cnf not found. Please check your MySQL installation."
fi
