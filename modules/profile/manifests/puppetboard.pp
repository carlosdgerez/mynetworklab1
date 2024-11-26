class profile::puppetboard {
  class { 'puppetboard':
    python_version    => '3.10',
    secret_key        => 'supersecret',
    manage_virtualenv => true,
  }

  class { 'apache':
    default_vhost => false,
  }
  class { 'puppetboard::apache::vhost':
    vhost_name => 'puppet.local',
    port       => 80,
  }
  
  puppet_authorization::rule { 'puppetlabs puppetdb metrics':
    match_request_path         => '/metrics',
    match_request_type         => 'path',
    match_request_method       => ['get','post'],
    allow_unauthenticated      => true,
    sort_order                 => 500,
    path                       => '/etc/puppetlabs/puppetdb/conf.d/auth.conf',
  }
}
