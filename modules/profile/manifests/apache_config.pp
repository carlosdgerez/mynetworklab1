

class profile::apache_config {

#   $install_dir = '/var/www/q2a'
#   $root_group = 'www-data' 


 
  
#   # # Disable conflicting modules and enable required modules
#   exec { 'disable_mpm_work':
#       command => '/usr/sbin/a2dismod work',
#       }

   

#   exec { 'enable_php7.2':
#      command => '/usr/sbin/a2enmod php7.2',  
#     }

#   exec { 'restart_apache2':
#       command     => '/bin/systemctl restart apache2',
#       path        => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
#       refreshonly => true,
#       subscribe   => File['/etc/apache2/apache2.conf'], # Example: restart if config changes
#     }


  
#    $apache_log_dir = '/var/log/apache2'

#   # file { "${apache_log_dir}/access.log":
#   #   ensure  => file,
#   #   owner   => 'www-data',
#   #   group   => 'www-data',
#   #   mode    => '0644',
#   # }
#   file { '/etc/apache2/sites-available/q2a.conf':
#       ensure  => file,
#       content => "
#         <VirtualHost *:80>
#           ServerName web2.local
#           DocumentRoot /var/www/q2a

#           <Directory /var/www/q2a>
#             Options Indexes FollowSymLinks
#             AllowOverride All
#             Require all granted
#           </Directory>

#           ErrorLog ${apache_log_dir}/q2a_error.log
#           CustomLog ${apache_log_dir}/q2a_access.log combined
#         </VirtualHost>",
#       notify  => Service['apache2'],
   
  


# }

  class { 'apache':
    mpm_module => 'prefork',
  }

  apache::mod { 'php7.2':
    require => Anchor['::apache::modules_set_up'], # Ensure module setup order
  }

  # Notify Apache service to restart only after enabling PHP module
  Service['apache2'] {
    subscribe => Apache::Mod['php7.2'], # Restart when PHP module is enabled
    notify    => Exec['apache2_reload'], # Reload Apache after service restart
  }

  # Command to reload Apache
  exec { 'apache2_reload':
    command     => '/usr/sbin/apachectl graceful',
    refreshonly => true,
    require     => Service['apache2'],
  }

}
