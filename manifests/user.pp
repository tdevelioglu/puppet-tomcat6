# == Class: tomcat6::user
#
# Configure Tomcat user and group ID.
#
# === Parameters
#
# [*gid*]
#   Tomcat group ID.
#   e.g.: '$uid'
#
# [*uid*]
#   Tomcat user ID.
#   e.g.: '120'
#
# === Examples
#
#   class tomcat6::user (
#     $uid = 120,
#     $gid = $uid
#     ) {
#
#     user { 'tomcat6':
#       ensure  => present,
#       uid     => $uid,
#       gid     => 'tomcat6',
#       home    => '/usr/share/tomcat6',
#       shell   => '/bin/false';
#     }
#
#     group { 'tomcat6':
#       ensure => present,
#       gid    => $gid;
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
class tomcat6::user (
  $uid = 120,
  $gid = $uid
  ) {

  user { 'tomcat6':
    ensure  => present,
    uid     => $uid,
    gid     => 'tomcat6',
    home    => '/usr/share/tomcat6',
    shell   => '/bin/false';
  }

  group { 'tomcat6':
    ensure => present,
    gid    => $gid;
  }

}
