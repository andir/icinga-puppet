class icinga::server::idodb {
  # cp /usr/share/doc/icinga-idoutils/examples/idoutils.cfg-sample idoutils.cfg
  file { "/etc/icinga/modules/idoutils.cfg":
    content => template("etc/icinga/modules/idoutils.cfg.erb"),
    ensure  => present,
    require => [Class['icinga::server::packages']],
    notify  => Service['ido2db']
  }

  # IDO2DB=yes
  augeas { 'enable_idodb2':
    changes => ["set /files/etc/default/icinga/IDO2DB yes"],
    require => [Class['icinga::server::packages'], File['/etc/icinga/modules/idoutils.cfg']],
    notify  => Service['ido2db']
  }

  service { 'ido2db':
    ensure  => running,
    require => [Class['icinga::server::packages']]
  }
}