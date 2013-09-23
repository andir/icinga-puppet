define icinga::server::host_template_definition (
  $register       = 0,
  $ensure         = present,
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
  $contact_groups = "admins",
  $target         = undef,) {
  include icinga::server::params

  if $target == undef {
    $real_target = inline_template($::icinga::server::host_params::host_template_template)
  } else {
    $real_target = $target
  }

  file { "${name}-${real_target}":
    ensure  => present,
    path    => $real_target,
    content => template("etc/icinga/host_template.cfg.erb"),
    owner   => $::icinga::params::icinga_user,
    group   => $::icinga::params::icinga_group,
    mode    => 640,
    notify  => Service['icinga']
  }

}