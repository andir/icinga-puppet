define icinga::client::host (
  $real_fqdn              = $fqdn,
  $ensure                 = 'present',
  $use                    = 'generic-host',
  $alias                  = undef,
  $address                = undef,
  $flap_detection_enabled = undef,
  $target                 = undef,
  $expire_time            = undef,) {
  include icinga::client::params

  if $alias == undef {
    $real_alias = $real_fqdn
  } else {
    $real_alias = $alias
  }

  if $address == undef {
    $real_address = $real_fqdn
  } else {
    $real_address = $address
  }

  if $flap_detection_enabled == undef {
    $real_flap_detection_enabled = $::icinga::client::params::flap_detection_enabled
  } else {
    $real_flap_detection_enabled = $flap_detection_enabled
  }

  if $expire_time {
    $seconds_to_expire = $expire_time
  } else {
    $seconds_to_expire = $::icinga::client::host_params::host_expire
  }

  if $seconds_to_expire {
    $real_expire_time = inline_template("<%= (Time.now + seconds_to_expire).strftime('%Y-%m-%dT%H:%M:%S%z') %>")
  } else {
    $real_expire_time = undef
  }

  @@icinga::server::host { $real_fqdn:
    ensure                 => $ensure,
    expire_time            => $real_expire_time,
    tag                    => $::icinga::client::params::icinga_server_fqdn,
    alias                  => $real_alias,
    address                => $real_address,
    use                    => $use,
    flap_detection_enabled => $real_flap_detection_enabled,
    target                 => $target,
    require                => Icinga::Server::Host_template[$use]
  }
}
