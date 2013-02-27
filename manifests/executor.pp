# == Define: tomcat6::executor
#
#
#
# === Parameters
#
# [*classname*]
#
#   e.g.: ' '
#
# [*daemon*]
#
#   e.g.: ' '
#
# [*maxidletime*]
#
#   e.g.: ' '
#
# [*maxthreads*]
#
#   e.g.: ' '
#
# [*maxqueuesize*]
#
#   e.g.: ' '
#
# [*minsparethreads*]
#
#   e.g.: ' '
#
# [*name*]
#
#   e.g.: ' '
#
# [*nameprefix*]
#
#   e.g.: ' '
#
# [*threadpriority*]
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
define tomcat6::executor (
  $classname       = false,
  $daemon          = false,
  $maxidletime     = false,
  $maxthreads      = false,
  $maxqueuesize    = false,
  $minsparethreads = false,
  $nameprefix      = false,
  $threadpriority  = false
  ) {

  concat::fragment { "server_xml_executor_${name}":
    target  => '/etc/tomcat6/server.xml',
    content => template('tomcat6/etc/tomcat6/server.xml/executor.erb'),
    order   => 101,
    notify  => $tomcat6::notify;
  }

}
