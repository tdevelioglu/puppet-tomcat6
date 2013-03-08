tomcat6
===========

A puppet module that manages tomcat6

Requires R.I. Pienaar's concat module.

Usage:
------
 class { 'tomcat6':; }

 tomcat6::executor { 'tomcatThreadPool':
   maxthreads      => '256',
   minsparethreads => '16';
 }

 tomcat6::connector { '80':
   backlog              => '1024',
   compression          => '2048',
   connectiontimeout    => '20000',
   executor             => 'tomcatThreadPool',
   keepalivetimeout     => '1200000',
   maxkeepaliverequests => '-1',
   maxpostsize          => '10485760',
   pollersize           => '65536',
   protocol             => 'org.apache.coyote.http11.Http11AprProtocol',
   uriencoding          => 'utf-8';
 }

 tomcat6::users_role { 'Jolokia': }
 tomcat6::users_user { 'jolokia':
     password => hiera('jolokia_tomcat6_password'),
     roles    => 'Jolokia';
 }
</pre>