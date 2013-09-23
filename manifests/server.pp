# Class: icinga
#
# This module manages icinga
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class icinga::server (
  $ldap_server      = "corp.tld",
  $ldap_start_tls   = true,
  $ldap_basedn      = "CN=Users,DC=corp,DC=tld",
  $ldap_binddn      = "CN=icinga,CN=Users,DC=corp,DC=tld",
  $ldap_bindpw      = "PASSWORD",
  $ldap_userattr    = "sAMAccountName",
  $ldap_filter_user = "(&(sAMAccountName=__USERNAME__))",) inherits icinga::params {
    

  Class['icinga::server::packages'] -> Class['icinga::server::collect']

  include icinga::server::packages
  include icinga::server::database
  include icinga::server::webserver
  include icinga::server::idodb
  include icinga::server::icinga_web
  include icinga::server::collect


  file { $icinga::params::icinga_resource_dir:
    ensure  => directory,
    owner   => $icinga::params::icinga_user,
    group   => $icinga::params::icinga_group,
    require => Package['icinga'],
  }
  
  
  service {'icinga':
    ensure    => running,
    require   => Package['icinga'],
    subscribe => Class['icinga::server::collect]
     
   }
}


