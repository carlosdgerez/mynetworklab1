class profile::puppetboard {
    # Configure Apache on this server
  class { 'apache':
    default_vhost => false,
  }

  # Configure Puppetboard
  class { 'puppetboard':
   # python_version    => '3.8',
    secret_key        => 'supersecret',
    manage_virtualenv => true,
  }

  # Access Puppetboard through pboard.example.com
  class { 'puppetboard::apache::vhost':
    vhost_name => 'puppet.local',
    port       => 80,
  }
  puppet_authorization::rule { 'puppetlabs puppetdb metrics':
    match_request_path    => '/metrics',
    match_request_type    => 'path',
    match_request_method  => ['get', 'post'],
    allow_unauthenticated => true,
    sort_order            => 500,
    path                  => '/etc/puppetlabs/puppetdb/conf.d/auth.conf',
  }
                
}
