class icinga::client::params (
  $host_expire          = $::icinga::params::resource_expire_time,
  $host_template_expire = $::icinga::params::resource_expire_time,
  $service_expire       = $::icinga::params::resource_expire_time) inherits icinga::params {
  # NoOp.
}