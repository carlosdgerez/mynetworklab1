#! /bin/bash

# Install HAProxy for load balancing
          apt-get update
          apt-get install -y haproxy
          systemctl enable haproxy
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
        server web1 192.168.56.21:80 check
        server web2 192.168.56.22:80 check" |     tee - a /etc/haproxy/haproxy.cfg
          systemctl restart haproxy
    