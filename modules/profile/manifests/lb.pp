class profile::lb {
  package { 'haproxy':
    ensure => installed,
  }

  service { 'haproxy':
    ensure => running,
    enable => true,
  }

  file { '/etc/haproxy/haproxy.cfg':
    ensure  => file,
    content => "
      # Global settings
      global
          log 127.0.0.1 local0
          log 127.0.0.1 local1 notice
          chroot /var/lib/haproxy
          stats timeout 30s
          user haproxy
          group haproxy
          daemon

      # Default settings
      defaults
          log     global
          option  dontlognull
          timeout connect 5000ms
          timeout client  50000ms
          timeout server  50000ms

      # Frontend for HTTP requests
      frontend http_front
          bind *:80
          mode http
          default_backend http_back

      # Backend for web servers
      backend http_back
          mode http
          balance roundrobin
          option http-server-close
          option forwardfor
          server web1 web1.local:80 check
          server web2 web2.local:80 check

      # Stats page (optional)
      frontend stats
          bind *:8080
          stats enable
          stats uri /stats
          stats hide-version
          stats auth admin:admin
    ",
    notify  => Service['haproxy'],

    
  }
}
