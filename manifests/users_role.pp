define tomcat6::users_role (
  ) {
  concat::fragment {
    "tomcat-users.xml_role_${name}":
      target  => '/etc/tomcat6/tomcat-users.xml',
      content => "  <role rolename=\"${name}\"/>\n",
      order   => 001,
      notify  => $tomcat6::notify;
  }
}
