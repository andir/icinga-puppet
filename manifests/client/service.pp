define icinga::client::service (
  $name,
  $host_name,
  $service_description,
  $check_command,
  $check_interval = 5,
  $retry_interval = 1,
  $expire_time    = undef) {
  if $expire_time {
    $seconds_to_expire = $expire_time
  } else {
    $seconds_to_expire = $::icinga::client::params::service_expire
  }

  if $seconds_to_expire {
    $real_expire_time = inline_template("<%= (Time.now + seconds_to_expire).strftime('%Y-%m-%dT%H:%M:%S%z') %>")
  } else {
    $real_expire_time = undef
  }

  @@icinga::server::service { $title:
    host_name           => $host_name,
    name                => $name,
    service_description => $service_description,
    check_command       => $check_command,
    check_interval      => $check_interval,
    retry_interval      => $retry_interval,
    expire_time         => $expire_time,
  }
}