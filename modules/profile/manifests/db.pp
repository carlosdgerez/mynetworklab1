class profile::db {
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
    content => "
      CREATE DATABASE IF NOT EXISTS q2a;
      CREATE USER 'q2a_user'@'%' IDENTIFIED BY 'secure_password';
      GRANT ALL PRIVILEGES ON q2a.* TO 'q2a_user'@'%';
      FLUSH PRIVILEGES;
    ",
    mode    => '0644',
  }
}
