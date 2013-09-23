class icinga::server::icinga_web {
  file { '/etc/icinga-web/conf.d/auth.xml':
    content => template('etc/icinga-web/conf.d/auth.xml.erb'),
    ensure  => present,
    notify  => Exec['clean-icinga-web-cache'],
    require => Class['icinga::server::packages']
  }

  exec { 'clean-icinga-web-cache':
    command     => '/usr/bin/find /var/cache/icinga-web/config/ -type f -iname "*.php" -exec rm {} \;',
    refreshonly => true,
    require     => File['/etc/icinga-web/conf.d/auth.xml']
  }
}