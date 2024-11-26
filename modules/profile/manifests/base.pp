class profile::base {
  package { 'vim':
    ensure => present,
  }

  user { 'carlos':
    ensure => present,
    groups => ['sudo'],
    shell  => '/bin/bash',
  }

  file { '/home/carlos':
    ensure => directory,
    owner  => 'carlos',
    group  => 'carlos',
  }

  file { '/home/carlos/.ssh':
    ensure => directory,
    owner  => 'carlos',
    group  => 'carlos',
    mode   => '0700',
  }

  ssh_authorized_key { 'carlos':
    ensure => present,
    user   => 'carlos',
    type   => 'ssh-rsa',
    key    => 'b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZWQyNTUxOQAAACCfi4+mvEIAqqc5pnp2251D/lx0qVzrXPZf18nmZPKDAgAAAJAreDt4K3g7eAAAAAtzc2gtZWQyNTUxOQAAACCfi4+mvEIAqqc5pnp2251D/lx0qVzrXPZf18nmZPKDAgAAAEAWmXHdzHgi2WMmpFEfUP9LAn62t8pXkOIWODW//Dw9GZ+Lj6a8QgCqpzmmenbbnUP+XHSpXOtc9l/XyeZk8oMCAAAAB3ZhZ3JhbnQBAgMEBQY=',
  }

  notify {'Hello from the puppetserver':}

}
