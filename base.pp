
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
    require => User['carlos'], # Ensure the user exists before creating the directory
  }

  file { '/home/carlos/.ssh':
    ensure => directory,
    owner  => 'carlos',
    group  => 'carlos',
    mode   => '0700',
    require => File['/home/carlos'], # Ensure the parent directory exists
  }

  ssh_authorized_key { 'carlos':
    ensure => present,
    user   => 'carlos',
    type   => 'ssh-rsa',
    key    => 'b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZWQyNTUxOQAAACCfi4+mvEIAqqc5pnp2251D/lx0qVzrXPZf18nmZPKDAgAAAJAreDt4K3g7eAAAAAtzc2gtZWQyNTUxOQAAACCfi4+mvEIAqqc5pnp2251D/lx0qVzrXPZf18nmZPKDAgAAAEAWmXHdzHgi2WMmpFEfUP9LAn62t8pXkOIWODW//Dw9GZ+Lj6a8QgCqpzmmenbbnUP+XHSpXOtc9l/XyeZk8oMCAAAAB3ZhZ3JhbnQBAgMEBQY=',
    require => File['/home/carlos/.ssh'],
  }
  notify { 'Hello, this is a notice from Puppetserver!':
  }


