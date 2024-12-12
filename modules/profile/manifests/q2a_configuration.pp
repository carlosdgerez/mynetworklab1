class profile::q2a_configuration {
  $install_dir = '/var/www/q2a'
  $db_name     = 'q2a'
  $db_user     = 'q2a_user'
  $db_pass     = 'secure_password'
  $db_host     = '192.168.60.10'

 package { 'unzip':
    ensure => installed,
  }
  file { "${install_dir}/qa-config.php":
    ensure  => present,
    content => epp('profile/qa-config.php.epp', {
      db_host => $db_host,
      db_user => $db_user,
      db_pass => $db_pass,
      db_name => $db_name,
    }),
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    require => Exec['move_q2a_files'],
  }
  file { "${install_dir}/.htaccess":
    ensure  => present,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    require => Class['profile::q2a_download_and_install'],
  }

  exec { 'set_permissions':
    command => "/bin/chown -R www-data:www-data ${install_dir} && /bin/chmod -R 755 ${install_dir}",
    require => Class['profile::q2a_download_and_install'],
  }
}
