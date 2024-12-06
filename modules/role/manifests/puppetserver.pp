class role::puppetserver {
  include profile::base
  include profile::puppetserver
  include profile::puppetdb
  include profile::puppetboard
}
