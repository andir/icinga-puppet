class icinga::server::collect {
  # Collect all the Config files
  Nagios_host <<| tag == $fqdn |>> {
    notify => Service['icinga']
  } ->
  Nagios_command <<| tag == $fqdn |>> {
    notify => Service['icinga']
  } ->
  Nagios_service <<| tag == $fqdn |>> {
    notify => Service['icinga']
  } ->
  Nagios_hostextinfo <<| tag == $fqdn |>> {
    notify => Service['icinga']
  } ->
  Icinga::Server::Host_template <<| tag == $fqdn |>> ->
  Icinga::Server::Host <<| tag == $fqdn |>> ->
  File <<| tag == $fqdn |>> {
    notify => Service['icinga']
  }
}