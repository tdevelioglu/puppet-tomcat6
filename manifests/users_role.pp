# == Define: tomcat6::users_role
#
#
#
# === Parameters
#
# [*name*]
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
define tomcat6::users_role () {

  concat::fragment { "tomcat-users.xml_role_${name}":
    target  => '/etc/tomcat6/tomcat-users.xml',
    content => "  <role rolename=\"${name}\"/>\n",
    order   => 001,
    notify  => $tomcat6::notify;
  }

}
