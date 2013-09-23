class icinga::server::webserver {
  file { '/etc/apache2/mods-enabled/php5.conf':
    ensure  => link,
    target  => '/etc/apache2/mods-available/php5.conf',
    require => Package['libapache2-mod-php5'],
    notify  => Service['apache2']
  }

  file { '/etc/apache2/mods-enabled/php5.load':
    ensure  => link,
    target  => '/etc/apache2/mods-available/php5.load',
    require => Package['apache2-php5'],
    notify  => Service['apache2']
  }

  file { '/etc/apache2/mods-enabled/rewrite.load':
    ensure  => link,
    target  => '/etc/apache2/mods-available/rewrite.load',
    require => Package['apache2'],
    notify  => Service['apache2']
  }

  service { 'apache2': ensure => running }

}

