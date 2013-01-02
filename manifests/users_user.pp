define tomcat6::users_user (
  $password,
  $roles
  ) {
  concat::fragment {
    "tomcat-users.xml_user_${name}":
      target  => '/etc/tomcat6/tomcat-users.xml',
      content => template('tomcat6/etc/tomcat6/tomcat-users.xml/user.erb'),
      order   => 002,
      notify  => $tomcat6::notify;
  }
}
