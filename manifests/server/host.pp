define icinga::server::host (
  $real_fqdn,
  $expire,
  $expire_time,
  $ensure,
  $icinga_server_fqdn,
  $alias,
  $address,
  $use,
  $flap_detection_enabled,
  $target = undef) {
  include icinga::server::host_params

  if $target == undef {
    $real_target = inline_template($::icinga::server::host_params)
  } else {
    $real_target = $target
  }

  if $ensure {
    if $expire_time and inline_template("<%= require 'time'; Time.now - Time.parse(expire_time) %>") > 0 {
      $real_ensure = absent
    } else {
      $real_enure = $ensure
    }
  }

  nagios_host { $real_fqdn:
    ensure                 => $real_ensure,
    tag                    => $::icinga::client::params::icinga_server_fqdn,
    alias                  => $alias,
    address                => $address,
    use                    => $use,
    flap_detection_enabled => $flap_detection_enabled,
    target                 => $real_target,
    notify                 => File[$real_target],
    require                => Icinga::Server::Host_template[$use]
  }

  file { $real_target:
    group  => $::icinga::params::icinga_group,
    mode   => 640,
    require =>
    notify => Service['icinga']
  }

}

