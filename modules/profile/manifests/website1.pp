class profile::website1 {
  class { 'apache':
    default_vhost => false,
  }

  apache::vhost { 'vhost.example.com':
    port    => 80,
    docroot => '/var/www/vhost',
  }

  file {'/var/www/vhost/index.html':
    content => 'Hello to web server 1',
  }
}
