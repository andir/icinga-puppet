class icinga::server::database {
  class { 'postgresql::server': require => Class['icinga::server::packages'] }
}
