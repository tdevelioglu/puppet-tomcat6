# == Define: tomcat6::host
#
#
#
# === Parameters
#
# [*appbase*]
#
# e.g. : ' '
#
# [*autodeploy*]
#
# e.g. : ' '
#
# [*backgroundprocessordelay*]
#
# e.g. : ' '
#
# [*classname*]
#
# e.g. : ' '
#
# [*deployignore*]
#
# e.g. : ' '
#
# [*deployonstartup*]
#
# e.g. : ' '
#
# [*deployxml*]
#
# e.g. : ' '
#
# [*errorreportvalveclass*]
#
# e.g. : ' '
#
# [*tomcat6*]
#
# e.g. : ' '
#
# [*unpackwars*]
#
# e.g. : ' '
#
# [*workdir*]
#
# e.g. : ' '
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
define tomcat6::host (
  $appbase                  = false,
  $autodeploy               = false,
  $backgroundprocessordelay = false,
  $classname                = false,
  $deployignore             = false,
  $deployonstartup          = false,
  $deployxml                = false,
  $errorreportvalveclass    = false,
  $unpackwars               = false,
  $workdir                  = false
  ) {

  concat::fragment { "server_xml_host_${name}":
    target  => '/etc/tomcat6/server.xml',
    content => template('tomcat6/etc/tomcat6/server.xml/host.erb'),
    order   => 201,
    notify  => $tomcat6::notify;
  }

}
