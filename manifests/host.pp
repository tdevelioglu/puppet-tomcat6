define tomcat6::host (
  $appbase                  = undef,
  $autodeploy               = undef,
  $backgroundprocessordelay = undef,
  $classname                = undef,
  $deployignore             = undef,
  $deployonstartup          = undef,
  $deployxml                = undef,
  $errorreportvalveclass    = undef,
  $unpackwars               = undef,
  $workdir                  = undef
  ) {
  concat::fragment {
    "server_xml_host_${name}":
      target  => '/etc/tomcat6/server.xml',
      content => template('tomcat6/etc/tomcat6/server.xml/host.erb'),
      order   => 201,
      notify  => $tomcat6::notify;
  }
}
