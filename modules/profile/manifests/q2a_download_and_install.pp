class profile::q2a_download_and_install {
  $q2a_version = 'master'
  $q2a_url     = "https://github.com/q2a/question2answer/archive/${q2a_version}.zip"
  $install_dir = '/var/www/q2a'

   package { 'curl':
    ensure => installed,
  }

  exec { 'download_q2a':
    command => "/usr/bin/curl -L ${q2a_url} -o /tmp/q2a.zip",
    creates => '/tmp/q2a.zip',
    require => Package['curl'],
  }

  exec { 'extract_q2a':
    command => '/usr/bin/unzip /tmp/q2a.zip -d /tmp',
    creates => '/tmp/question2answer-master',
    require => Exec['download_q2a'],
  }

  file { $install_dir:
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    #require => Package['apache2'],
  }

  exec { 'move_q2a_files':
    command => "/usr/bin/rsync -a --remove-source-files /tmp/question2answer-master/ ${install_dir}/ &&
                cp ${install_dir}/qa-config-example.php ${install_dir}/qa-config.php &&
                cp ${install_dir}/.htaccess-example ${install_dir}/.htaccess",
    require => [Exec['extract_q2a'], File[$install_dir]],
  }
}
