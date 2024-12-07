#! /bin/bash

# Install HAProxy for load balancing
      sudo apt-get update
      sudo apt-get install -y haproxy
      sudo systemctl enable haproxy
      # Configure HAProxy with round robin for the web servers
      echo "global
        log 127.0.0.1 local0
        maxconn 200

      defaults
        log     global
        option  httplog
        timeout connect 5000ms
        timeout client  50000ms
        timeout server  50000ms

      frontend http-in
        bind *:80
        default_backend servers

      backend servers
        balance roundrobin
        server web1 192.168.50.21:80 check
        server web2 192.168.50.22:80 check" | sudo tee - a /etc/haproxy/haproxy.cfg
      sudo systemctl restart haproxy
    