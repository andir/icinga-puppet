class icinga::server::packages {
  case $::operatingsystem {
    Ubuntu  : { include ::icinga::server::packages::debian }
    default : { fail("Sorry, server is currently only supported on Ubuntu.") }
  }
}