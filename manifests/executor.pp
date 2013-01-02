define tomcat6::executor (
  $classname       = undef,
  $daemon          = undef,
  $maxidletime     = undef,
  $maxthreads      = undef,
  $maxqueuesize    = undef,
  $minsparethreads = undef,
  $nameprefix      = undef,
  $threadpriority  = undef,
  ) {
  concat::fragment {
    "server_xml_executor_${name}":
      target  => '/etc/tomcat6/server.xml',
      content => template('tomcat6/etc/tomcat6/server.xml/executor.erb'),
      order   => 101,
      notify  => $tomcat6::notify;
  }
}
