node 'web1.local' { include role::webserver1 }
node 'web2.local' { include role::webserver2 }
node 'puppet.local' { include role::puppetserver }
node 'db.local' { include role::db }
node 'lb.local' { include role::lb }
node default { include role::default }
