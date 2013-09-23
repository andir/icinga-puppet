define icinga::server::host_template (
  $name,
  $ensure         = present,
  $expire_time    = undef,
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
  $contact_groups = "admins",
  $host_fqdn      = undef) {
  if is_array($contact_groups) {
    $real_contact_groups = $contact_groups
  } else {
    $real_contact_groups = [$contact_groups]
  }

  if $expire_time and inline_template("<%= require 'time'; Time.now - Time.parse(expire_time) %>") > 0 {
    $real_ensure = "absent"
  } else {
    $real_enure = $ensure
  }

  if $real_ensure != "absent" {
    if defined(Icinga::Server::Host_template_defintion[$name]) {
      Icinga::Server::Host_template_defintition <| name == $name |> {
        contact_groups +> $real_contact_groups
      }
    } else {
      icinga::server::host_template_defintion { $name:
        name   => $name,
        ensure => $ensure,
        notification_enabled      => $notification_enabled,
        event_handler_enabled     => $event_handler_enabled,
        flap_detection_enabled    => $flap_detection_enabled,
        process_perf_data         => $process_perf_data,
        retain_status_information => $retain_status_information,
        check_command             => $check_command,
        max_check_attempts        => $max_check_attempts,
        notification_interval     => $notification_interval,
        notification_period       => $notification_period,
        notification_options      => $notification_options,
        contact_groups            => $real_contact_groups
      }

    }
  } else {
    if not defined(Notify["host_template_${name}_${host_fqdn}"]) {
      notify { "host_template_${name}_${host_fqdn}": message => "host template ${name} expired on one host (${host_fqdn})." }  
    }
  }

}