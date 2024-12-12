class profile::q2a_php {

  # Ensure PHP is managed using the puppet-php module
  class { 'php':
  ensure       => latest,
  manage_repos => true,
  fpm          => true,
  dev          => true,
  composer     => true,
  pear         => true,
  phpunit      => false,
}
   
  

}
