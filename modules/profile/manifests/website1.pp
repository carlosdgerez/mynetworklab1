class profile::website1{
  package { ['apache2', 'php', 'php-mysql', 'unzip']:
    ensure => installed,
  }

  service { 'apache2':
    ensure => running,
    enable => true,
  }

  file { '/etc/apache2/sites-available/q2a.conf':
    ensure  => file,
    content => template('profiles/q2a_apache_vhost.conf.erb'),
    notify  => Service['apache2'],
  }

  exec { 'enable_q2a_site':
    command => 'a2ensite q2a && systemctl reload apache2',
    unless  => 'apache2ctl -S | grep q2a',
    require => File['/etc/apache2/sites-available/q2a.conf'],
  }

  exec { 'download_q2a':
    command => 'wget -qO /tmp/q2a.zip https://github.com/q2a/question2answer.git',
    creates => '/tmp/q2a.zip',
  }

  exec { 'extract_q2a':
    command => 'unzip -o /tmp/q2a.zip -d /var/www/q2a',
    creates => '/var/www/q2a/index.php',
    require => Exec['download_q2a'],
  }

  file { '/var/www/q2a':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    recurse => true,
  }

  notify { 'Hello, this is a notice from web1, q2a installation done!  ':
    }
}
