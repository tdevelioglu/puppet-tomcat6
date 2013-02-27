# == Class: tomcat6::init
#
# Ensure that the libtcnative-1 and the tomcat6 deb packages are installed.
#
# === Parameters
#
# [*authbind*]
#   If you run Tomcat on port numbers that are all higher than 1023, then you
#   do not need authbind. It is used for binding Tomcat to lower port numbers.
#   NOTE: authbind works only with IPv4. Do not enable it when using IPv6.
#   e.g.: 'no'
#
# [*cms_oc_fraction*]
#   A concurrent collection will also start if the occupancy of the tenured
#   generation exceeds an initiating occupancy, a percentage of the tenured
#   generation. The default value of this initiating occupancy threshold is
#   approximately 92%, but the value is subject to change from release to
#   release.
#   e.g.: 'false'
#   * http://www.oracle.com/technetwork/java/javase/gc-tuning-6-140523.html#cms.starting_a_cycle
#
# [*extra_jopts*]
#   Extra Oracle Java options.
#   e.g.: 'false'
#
# [*fdlimit*]
#   Increase max nr of open file descriptors.
#   e.g.: 'false'
#
# [*jmx_passfile*]
#
#   e.g.: ' '
#
# [*jmx_port*]
#
#   e.g.: ' '
#
# [*jsp_compiler*]
#
#   e.g.: ' '
#
# [*jvmroute*]
#
#   e.g.: ' '
#
# [*jvm_tmp*]
#
#   e.g.: ' '
#
# [*logfile_days*]
#
#   e.g.: ' '
#
# [*max_heapsize*]
#
#   e.g.: ' '
#
# [*max_newsize*]
#
#   e.g.: ' '
#
# [*max_permsize*]
#
#   e.g.: ' '
#
# [*min_heapsize*]
#
#   e.g.: ' '
#
# [*min_newsize*]
#
#   e.g.: ' '
#
# [*min_permsize*]
#
#   e.g.: ' '
#
# [*notify*]
#
#   e.g.: ' '
#
# [*restart*]
#
#   e.g.: ' '
#
# [*security*]
#
#   e.g.: ' '
#
# [*server_port*]
#
#   e.g.: ' '
#
# [*shutdown*]
#
#   e.g.: ' '
#
# === Examples
#
#   class tomcat6(
#     $authbind        = 'no',
#     $cms_oc_fraction = false,
#     $extra_jopts     = false,
#     $fdlimit         = false,
#     $jmx_port        = false,
#     $jmx_passfile    = '/etc/tomcat6/jmxremote.password',
#     $jsp_compiler    = false,
#     $jvmroute        = $::hostname,
#     $logfile_days    = '14',
#     $max_heapsize    = 128m,
#     $min_heapsize    = false,
#     $max_newsize     = false,
#     $min_newsize     = false,
#     $max_permsize    = false,
#     $min_permsize    = false,
#     $restart         = false,
#     $security        = false,
#     $server_port     = '8005',
#     $shutdown        = 'SHUTDOWN',
#     ) {
#
#     class { 'tomcat6::user':; }
#
#     case $restart {
#       true: { $notify = Service['tomcat6'] }
#       default: { $notify = undef }
#     }
#
#     package {
#       'libtcnative-1':
#         ensure => present;
#       'tomcat6':
#         ensure  => present,
#         require => Class['tomcat6::user'];
#     }
#
#     service { 'tomcat6':
#       require => Package['tomcat6', 'libtcnative-1'];
#     }
#
#     file {
#       '/etc/tomcat6':
#         ensure => directory,
#         owner  => root,
#         group  => root,
#         mode   => '0644';
#       '/etc/default/tomcat6':
#         ensure  => file,
#         owner   => root,
#         group   => root,
#         mode    => '0644',
#         content => template('tomcat6/etc/default/tomcat6.erb'),
#         before  => Package['tomcat6'];
#     }
#
#     Concat {
#       require => Class['tomcat6::user'],
#       before  => Package['tomcat6']
#     }
#     concat {
#       '/etc/tomcat6/server.xml':
#         owner   => root,
#         group   => tomcat6,
#         mode    => '0644',
#         require => File['/etc/tomcat6'];
#       '/etc/tomcat6/tomcat-users.xml':
#         owner   => root,
#         group   => tomcat6,
#         mode    => '0640',
#         require => File['/etc/tomcat6'];
#     }
#
#     Concat::Fragment {
#       before => Package['tomcat6']
#     }
#     concat::fragment {
#       'server.xml_server':
#         target  => '/etc/tomcat6/server.xml',
#         content => template('tomcat6/etc/tomcat6/server.xml/server.erb'),
#         order   => 000,
#         notify  => $notify;
#       'server.xml_service':
#         target  => '/etc/tomcat6/server.xml',
#         content => template('tomcat6/etc/tomcat6/server.xml/service.erb'),
#         order   => 100,
#         notify  => $notify;
#       'server.xml_engine':
#         target  => '/etc/tomcat6/server.xml',
#         content => template('tomcat6/etc/tomcat6/server.xml/engine.erb'),
#         order   => 200,
#         notify  => $notify;
#       'server.xml_footer':
#         target  => '/etc/tomcat6/server.xml',
#         content => template('tomcat6/etc/tomcat6/server.xml/footer.erb'),
#         order   => 999,
#         notify  => $notify;
#     }
#     concat::fragment {
#       'tomcat-users.xml_header':
#         target  => '/etc/tomcat6/tomcat-users.xml',
#         content => template('tomcat6/etc/tomcat6/tomcat-users.xml/header.erb'),
#         order   => 000,
#         notify  => $notify;
#       'tomcat-users.xml_footer':
#         target  => '/etc/tomcat6/tomcat-users.xml',
#         content => template('tomcat6/etc/tomcat6/tomcat-users.xml/footer.erb'),
#         order   => 999,
#         notify  => $notify;
#     }
#
#   }
#
# === Resources
#
# * http://tomcat.apache.org/tomcat-6.0-doc/
#
# === Authors
#
# * Taylan Develioglu <taylan.develioglu@gmail.com>
#
class tomcat6(
  $authbind        = false,
  $cms_oc_fraction = false,
  $extra_jopts     = false,
  $fdlimit         = false,
  $java_home       = false,
  $jmx_port        = false,
  $jmx_passfile    = '/etc/tomcat6/jmxremote.password',
  $jsp_compiler    = false,
  $jvmroute        = $::hostname,
  $jvm_tmp         = false,
  $logfile_days    = '14',
  $max_heapsize    = 128m,
  $min_heapsize    = false,
  $max_newsize     = false,
  $min_newsize     = false,
  $max_permsize    = false,
  $min_permsize    = false,
  $remote_debug    = false,
  $restart         = false,
  $security        = false,
  $server_port     = '8005',
  $shutdown        = 'SHUTDOWN'
  ) {

  class { 'tomcat6::user':; }

  case $restart {
    true: { $notify = Service['tomcat6'] }
    default: { $notify = undef }
  }

  package {
    'libtcnative-1':
      ensure => present;
    'tomcat6':
      ensure  => present,
      require => Class['tomcat6::user'];
  }

  service { 'tomcat6':
    require => Package['tomcat6', 'libtcnative-1'];
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
