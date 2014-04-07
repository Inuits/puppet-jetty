# Class: jetty
#
# Initialization class for the jetty service
class jetty (
  $pkg_name     = $jetty::params::pkg_name,
) inherits jetty::params {

  include jetty::install
  include jetty::config
  include jetty::service

  Class['jetty::install'] ->
  Class['jetty::config'] ->
  Class['jetty::service']
}
