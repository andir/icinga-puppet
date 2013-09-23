define icinga::client::host_template (
  $name,
  $ensure         = present,
  $expire_time    = undef, # 30 Days
  $register       = 0,
  $notification_enabled         = 1,
  $event_handler_enabled        = 1,
  $flap_detection_enabled       = 1,
  $failure_prediction_enabled   = 1,
  $process_perf_data            = 1,
  $retain_status_information    = 1,
  $retain_nonstatus_information = 1,
  $check_command  = "check-host-alive",
  $max_check_attempts           = 10,
  $notification_interval        = 0,
  $notification_period          = "24x7",
  $notification_options         = "d,u,r",
  $contact_groups = "admins",) {
  include icinga::client::params

  if $expire_time {
    $seconds_to_expire = $expire_time
  } else {
    $seconds_to_expire = $::icinga::client::params::host_template_expire
  }

  if $seconds_to_expire {
    $real_expire_time = inline_template("<%= (Time.now + seconds_to_expire).strftime('%Y-%m-%dT%H:%M:%S%z') %>")
  } else {
    $real_expire_time = undef
  }

  @@icinga::server::host_template { "${fqdn}-${name}":
    name           => $name,
    ensure         => $ensure,
    expire_time    => $real_expire_time,
    register       => $register,
    notification_enabled       => $notification_enabled,
    event_handler_enabled      => $event_handler_enabled,
    flap_detection_enabled     => $flap_detection_enabled,
    failure_prediction_enabled => $failure_prediction_enabled,
    process_perf_data          => $process_perf_data,
    retain_status_information  => $retain_status_information,
    check_command  => $check_command,
    max_check_attempts         => $max_check_attempts,
    notification_interval      => $notification_interval,
    notification_period        => $notification_period,
    notification_options       => $notification_options,
    contact_groups => $contact_groups,
  }
}

