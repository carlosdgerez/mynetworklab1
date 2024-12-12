class role::webserver2 {
  include profile::base
  include apache
  include php
  # include profile::q2a_php
  include profile::q2a_apache_config
  # include profile::q2a_download_and_install
  # include profile::q2a_configuration
  # include profile::q2a_enable
}
