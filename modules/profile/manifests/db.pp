class profiles::db {
  package { ['mariadb-server', 'mariadb-client']:
    ensure => installed,
  }

  service { 'mariadb':
    ensure => running,
    enable => true,
  }

  exec { 'initialize_q2a_database':
    command => '/usr/bin/mysql < /tmp/q2a_db.sql',
    unless  => '/usr/bin/mysql -e "SHOW DATABASES LIKE \'q2a\';" | grep q2a',
    require => Service['mariadb'],
  }

  file { '/tmp/q2a_db.sql':
    ensure  => file,
    content => template('profiles/q2a_db.sql.erb'),
    mode    => '0644',
  }
}
