class profile::website2 {
  package { ['php', 'php-mysql', 'unzip', 'php7.2'] :
    ensure => installed,
  }
 

  class { 'apache':    
    service_ensure => running,
    service_enable => true,
    mpm_module     => 'prefork',
    default_vhost  => false,
  }

  apache::vhost { 'q2a':
    port             => 80,
    docroot          => '/var/www/q2a/question2answer-master',
  }

  class { 'apache::mod::php': }

  $apache_log_dir = '/var/log/apache2'

  file { "${apache_log_dir}/access.log":
    ensure  => file,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0644',
  }

  file { '/etc/apache2/sites-available/q2a.conf':
    ensure  => file,
    content => "
      <VirtualHost *:80>
        ServerName web2.local
        DocumentRoot /var/www/q2a/question2answer-master

        <Directory /var/www/q2a>
          Options Indexes FollowSymLinks
          AllowOverride All
          Require all granted
        </Directory>

        ErrorLog ${apache_log_dir}/q2a_error.log
        CustomLog ${apache_log_dir}/q2a_access.log combined
      </VirtualHost>",
    notify  => Service['apache2'],
  }

  exec { 'ENABLE_Q2A_SITE':
    command => '/usr/sbin/a2ensite q2a && systemctl reload apache2',
    unless  => '/usr/sbin/apache2ctl -S | grep q2a',
    require => File['/etc/apache2/sites-available/q2a.conf'],
  }

#  # Using the Puppet archive module to download and extract the Q2A archive
   archive { '/tmp/q2a.zip':
     ensure       => present,
     source       => 'https://github.com/q2a/question2answer/archive/refs/heads/master.zip',
     extract      => true,
     extract_path => '/var/www/q2a/',           # Extract to /var/www/q2a directory
     creates      => '/var/www/q2a/index.php', # Only extract if index.php does not already exist
     cleanup      => true,
     
   }

  file { '/var/www/q2a':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    recurse => true,
   }


  $install_dir = '/var/www/q2a/question2answer-master'
  $db_name     = 'q2a'
  $db_user     = 'q2a_user'
  $db_pass     = 'secure_password'
  $db_host     = '192.168.60.10'

 
 file { "${install_dir}/qa-config.php":
  ensure  => file,
  content => epp('profile/qa-config.php.epp', {
    db_host      => $db_host,
    db_user      => $db_user,
    db_pass      => $db_pass,
    db_name      => $db_name,
    
  }),
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  require => Archive['/tmp/q2a.zip'],
}
  file { "${install_dir}/.htaccess":
    ensure  => present,
    source  => "${install_dir}/.htaccess-example",
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    
  }

  exec { 'set_permissions':
    command => "/bin/chown -R www-data:www-data ${install_dir} && /bin/chmod -R 755 ${install_dir}",
    #require => Class['profile::q2a_download_and_install'],
  }
  notify { 'Hello, this is a notice from web1, q2a installation done!':
  }
}
