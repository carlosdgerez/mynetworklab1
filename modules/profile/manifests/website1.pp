class profile::website1 {
  package { ['apache2', 'php', 'php-mysql']:
    ensure => installed,
  }

  service { 'apache2':
    ensure => running,
    enable => true,
  }

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
        ServerName web1.local
        DocumentRoot /var/www/q2a

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
#   archive { '/tmp/q2a.zip':
#     ensure       => present,
#     source       => 'https://github.com/q2a/question2answer/archive/refs/heads/master.zip',
#     extract      => true,
#     extract_path => '/var/www/q2a',           # Extract to /var/www/q2a directory
#     creates      => '/var/www/q2a/index.php', # Only extract if index.php does not already exist
#     cleanup      => true,
#   }

  file { '/var/www/q2a':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    recurse => true,
   }

  notify { 'Hello, this is a notice from web1, q2a installation done!':
  }
}
