

class profile::q2a_enable{

  $install_dir = '/var/www/q2a'

  
  # Disable the default site
  exec { 'disable_default_site':
    command => '/usr/sbin/a2dissite 000-default.conf',
    onlyif  => '/usr/sbin/apache2ctl -S | grep "default server" | grep 000-default',
    require => Class['apache'],
    notify  => Service['apache2'],
  }

  # Define your custom virtual host
  apache::vhost { 'q2a':
    port     => 80,
    docroot  => $install_dir,
    options  => ['FollowSymLinks', 'ExecCGI'],
    ensure   => present,
    require  => File["${install_dir}/.htaccess"], # Ensure the .htaccess file exists
    notify   => Service['apache2'],
  }

  # Enable the new site
  exec { 'enable_q2a_site':
    command => '/usr/sbin/a2ensite q2a.conf',
    unless  => '/usr/sbin/apache2ctl -S | grep "q2a"',
    require => Apache::Vhost['q2a'],
    notify  => Service['apache2'],
  }


}
