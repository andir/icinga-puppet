class icinga::params (
  $icinga_resource_dir    = "/etc/icinga/objects/puppet_objects.d",
  $icinga_user            = "nagios",
  $icinga_group           = "nagios",
  $resource_expire        = undef,
  $host_template_template = "<%=scope.lookupvar('::icinga::params::icinga_resource_dir')%>/host_template_<%=@name%>.cfg") {
  # NoOp.
}
