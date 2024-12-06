class profile::puppetdb {
  class { 'puppetdb': }
    
  class { 'puppetdb::master::config':
    enable_reports         => true,
    manage_report_processor => true,
   }
}

