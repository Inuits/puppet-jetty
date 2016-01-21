# Class: jetty::config
#
# Class which configures the jetty service
class jetty::config (
  $jetty_user  = 'jetty',
  $jetty_group = 'jetty',
  $jetty_home  = '/opt/jetty',
) {

  group { $jetty_group:
    ensure => present,
  }

  user { $jetty_user:
    ensure  => present,
    groups  => $jetty_group,
    home    => $jetty_home,
    require => Group[$jetty_group],
  }

  file { [
      '/opt/jetty',
      '/var/log/jetty',
      '/var/lib/jetty',
      '/var/lib/jetty/webapps'
    ]:
      ensure  => 'directory',
      owner   => $jetty_user,
      group   => $jetty_group,
      mode    => '0644',
      require => User[$jetty_user],
  }

  file { '/opt/jetty/logs':
    ensure => 'link',
    target => '/var/log/jetty',
  }

  file { '/opt/jetty/webapps':
    ensure => 'link',
    force  => true,
    target => '/var/lib/jetty/webapps'
  }

  file { '/etc/init.d/jetty':
    ensure => present,
    sourve => "${jetty_home}/bin/jetty.sh",
  }

  file { '/etc/default/jetty':
    content => template('jetty/jetty.erb')
  }
}
