node 'web1.local' { include role::webserver }
node 'web2.local' { include role::webserver }
node 'puppet.local' { include role::puppetserver }
node 'db.local' { include role::db }
node default { include role::default }
