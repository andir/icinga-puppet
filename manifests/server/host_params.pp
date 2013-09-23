class icinga::server::host_params (
  $host_target_template   = "<%= scope.lookup('icinga::params::icinga_resource_dir') %>/host_<%=@real_fqdn%>.cfg",
  $host_template_template = "<%= scope.lookup('icinga::params::icinga_resource_dir') %>/host_template_<%=@name%>.cfg") inherits 
icinga::server::params {
  # nop
}
