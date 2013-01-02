# Class: tomcat6
#
# This class manages the installation and configuration of tomcat6
#
# == Parameters
#
# TODO
#
# == Actions
#
#   Configure and install tomcat6
#
# == Examples
#
# TODO
#
# == Resources
#
# http://tomcat.apache.org/tomcat-6.0-doc/
#
# == Authors
#
# Taylan Develioglu <taylan.develioglu@gmail.com>
#
class tomcat6(
  $authbind        = 'no',
  $cms_oc_fraction = undef,
  $extra_jopts     = undef,
  $fdlimit         = undef,
  $jmx_port        = undef,
  $jmx_passfile    = '/etc/tomcat6/jmxremote.password',
  $jvmroute        = $::hostname,
  $logfile_days    = '14',
  $max_heapsize    = 128m,
  $min_heapsize    = undef,
  $max_newsize     = undef,
  $min_newsize     = undef,
  $max_permsize    = undef,
  $min_permsize    = undef,
  $restart         = false,
  $server_port     = '8005',
  $shutdown        = 'SHUTDOWN',
  $uid             = undef,
  $gid             = undef
  ) {
  class {
    'tomcat6::user':;
  }

  case $restart {
    true:    { $notify = Service['tomcat6'] }
    default: { $notify = undef }
  }

  package {
    'libtcnative-1':
      before => Package['tomcat6'];
    'tomcat6':
      require => Class['tomcat6::user'];
  }

  service {
    'tomcat6':
      require => Package['tomcat6'];
  }

  file {
    '/etc/tomcat6':
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0644';
    '/etc/default/tomcat6':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('tomcat6/etc/default/tomcat6.erb'),
      before  => Package['tomcat6'];
  }

  Concat {
    require => Class['tomcat6::user'],
    before  => Package['tomcat6']
  }
  concat {
    '/etc/tomcat6/server.xml':
      owner   => root,
      group   => tomcat6,
      mode    => '0644',
      require => File['/etc/tomcat6'];
    '/etc/tomcat6/tomcat-users.xml':
      owner   => root,
      group   => tomcat6,
      mode    => '0640',
      require => File['/etc/tomcat6'];
  }

  Concat::Fragment {
    before => Package['tomcat6']
  }
  concat::fragment {
    'server.xml_server':
      target  => '/etc/tomcat6/server.xml',
      content => template('tomcat6/etc/tomcat6/server.xml/server.erb'),
      order   => 000,
      notify  => $notify;
    'server.xml_service':
      target  => '/etc/tomcat6/server.xml',
      content => template('tomcat6/etc/tomcat6/server.xml/service.erb'),
      order   => 100,
      notify  => $notify;
    'server.xml_engine':
      target  => '/etc/tomcat6/server.xml',
      content => template('tomcat6/etc/tomcat6/server.xml/engine.erb'),
      order   => 200,
      notify  => $notify;
    'server.xml_footer':
      target  => '/etc/tomcat6/server.xml',
      content => template('tomcat6/etc/tomcat6/server.xml/footer.erb'),
      order   => 999,
      notify  => $notify;
  }
  concat::fragment {
    'tomcat-users.xml_header':
      target  => '/etc/tomcat6/tomcat-users.xml',
      content => template('tomcat6/etc/tomcat6/tomcat-users.xml/header.erb'),
      order   => 000,
      notify  => $notify;
    'tomcat-users.xml_footer':
      target  => '/etc/tomcat6/tomcat-users.xml',
      content => template('tomcat6/etc/tomcat6/tomcat-users.xml/footer.erb'),
      order   => 999,
      notify  => $notify;
  }
}
