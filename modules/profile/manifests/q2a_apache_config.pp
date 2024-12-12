

class profile::q2a_apache_config {

  $install_dir = '/var/www/q2a'
  $root_group = 'www-data' 


 
  
  # # Disable conflicting modules and enable required modules
   exec { 'disable_mpm_work':
     command => '/usr/sbin/a2dismod work',
     onlyif  => "/usr/sbin/apache2ctl -M | grep -o '\w*work\w*'",
 
   }

  # exec { 'enable_mpm_prefork':
  #   command => '/usr/sbin/a2enmod mpm_prefork',
  #   unless  => '/usr/sbin/apache2ctl -M | grep mpm_prefork',
  #   require => Exec['disable_mpm_event'],
  # }

   exec { 'enable_php7.2':
     command => '/usr/sbin/a2enmod php7.2',
     unless  => '/usr/sbin/apache2ctl -M | grep php7.2',
  #   require => Exec['enable_mpm_prefork'],
   }

  
  # $apache_log_dir = '/var/log/apache2'

  # file { "${apache_log_dir}/access.log":
  #   ensure  => file,
  #   owner   => 'www-data',
  #   group   => 'www-data',
  #   mode    => '0644',
  # }
  file { '/etc/apache2/sites-available/q2a.conf':
      ensure  => file,
      content => "
        <VirtualHost *:80>
          ServerName web2.local
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
  


}

