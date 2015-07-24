# Class jetty::params
#
# This class contains every parameter which will be used in this puppet module
# for setting up the jetty service
class jetty::params {
  $pkg_name     = 'jetty-9-1.3'
  $java_options = undef
}
