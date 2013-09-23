class icinga::server::packages::debian {
  apt::key { 'ubuntu-icinga':
    key    => '36862847',
    ensure => present,
  }

  apt::source { 'ubuntu-icinga':
    location => "http://ppa.launchpad.net/formorer/icinga/ubuntu",
    release  => "${::lsbdistcodename}",
    repos    => "main",
    ensure   => "present",
    require  => Apt::Key['ubuntu-icinga']
  }

  apt::source { 'ubuntu-icinga-web':
    location => "http://ppa.launchpad.net/formorer/icinga-web/ubuntu",
    release  => "${::lsbdistcodename}",
    repos    => "main",
    ensure   => "present",
    require  => Apt::Key['ubuntu-icinga']
  }

  package { "apache2-php5":
    ensure => latest,
    name   => "libapache2-mod-php5",
  }

  package { ['dbconfig-common', "php5-pgsql",]: ensure => latest, }

  package { [
    "icinga",
    "icinga-web",
    "icinga-core",
    "icinga-common",
    "icinga-web-pnp",
    "icinga-cgi",
    "nagios-plugins",
    "icinga-idoutils",
    ]:
    ensure  => latest,
    require => [
      Apt::Source['ubuntu-icinga-web'],
      Apt::Source['ubuntu-icinga'],
      Package['php5-pgsql'],
      Package['apache2-php5'],
      Class['icinga::server::database'],
      Package['dbconfig-common'],
      ]
  }
}