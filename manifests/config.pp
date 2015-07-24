# Class: jetty::config
#
# Class which configures the jetty service
class jetty::config {

  file { [
      '/var/log/jetty',
      '/var/lib/jetty',
      '/var/lib/jetty/webapps'
    ]:
      ensure => 'directory',
      owner  => 'jetty',
      group  => 'jetty',
      mode   => '0644'
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
    ensure => 'link',
    target => '/opt/jetty/bin/jetty.sh'
  }

  file { '/etc/default/jetty':
    content => template('jetty/jetty.erb')
  }
}
