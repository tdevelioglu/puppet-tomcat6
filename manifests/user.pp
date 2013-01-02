class tomcat6::user {
  user {
    'tomcat6':
      ensure => present,
      uid    => $tomcat6::uid,
      gid    => $tomcat6::gid,
      home   => '/usr/share/tomcat6',
      shell  => '/bin/false';
  }
  group {
    'tomcat6':
      ensure => present,
      gid    => $tomcat6::gid;
  }
}
