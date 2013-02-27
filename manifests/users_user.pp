# == Define: tomcat6::users_user
#
#
#
# === Parameters
#
# [*name*]
#
#   e.g.: ' '
#
# [*password*]
#
#   e.g.: ' '
#
# [*roles*]
#
#   e.g.: ' '
#
# === Examples
#
# TODO
#
# === Resources
#
# * http://tomcat.apache.org/tomcat-6.0-doc/
#
# === Authors
#
# * Taylan Develioglu <taylan.develioglu@gmail.com>
#
define tomcat6::users_user (
  $password,
  $roles
  ) {

  concat::fragment { "tomcat-users.xml_user_${name}":
    target  => '/etc/tomcat6/tomcat-users.xml',
    content => template('tomcat6/etc/tomcat6/tomcat-users.xml/user.erb'),
    order   => 002,
    notify  => $tomcat6::notify;
  }

}
