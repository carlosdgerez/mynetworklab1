class profiles::lb {
  package { 'haproxy':
    ensure => installed,
  }

  service { 'haproxy':
    ensure => running,
    enable => true,
  }

  file { '/etc/haproxy/haproxy.cfg':
    ensure  => file,
    content => template('profiles/haproxy.cfg.erb'),
    notify  => Service['haproxy'],
    notify { 'Hello, this is a notice from Load Balancer Haproxy installation done!   ':
    }
  }
}
