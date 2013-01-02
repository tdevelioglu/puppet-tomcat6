define tomcat6::connector (
  $acceptcount                      = undef,
  $acceptorthreadcount              = undef,
  $acceptorthreadpriority           = undef,
  $address                          = undef,
  $algorithm                        = undef,
  $allowtrace                       = undef,
  $allowunsafelegacyrenegotiation   = undef,
  $buffersize                       = undef,
  $ciphers                          = undef,
  $clientauth                       = undef,
  $clientcertprovider               = undef,
  $command_line_options             = undef,
  $compressablemimetype             = undef,
  $compression                      = undef,
  $connectionlinger                 = undef,
  $connectiontimeout                = undef,
  $crlfile                          = undef,
  $disableuploadtimeout             = undef,
  $emptysessionpath                 = undef,
  $enablelookups                    = undef,
  $executor                         = undef,
  $keepalivetimeout                 = undef,
  $keyalias                         = undef,
  $keystorefile                     = undef,
  $keystorepass                     = undef,
  $keystoreprovider                 = undef,
  $keystoretype                     = undef,
  $maxheadercount                   = undef,
  $maxhttpheadersize                = undef,
  $maxkeepaliverequests             = undef,
  $maxparametercount                = undef,
  $maxpostsize                      = undef,
  $maxsavepostsize                  = undef,
  $maxthreads                       = undef,
  $nocompressionuseragents          = undef,
  $oomparachute                     = undef,
  $parsebodymethods                 = undef,
  $pollersize                       = undef,
  $pollerthreadcount                = undef,
  $pollerthreadpriority             = undef,
  $polltime                         = undef,
  $port                             = $name,
  $processorcache                   = undef,
  $protocol                         = undef,
  $proxyname                        = undef,
  $proxyport                        = undef,
  $redirectport                     = undef,
  $restricteduseragents             = undef,
  $scheme                           = undef,
  $secure                           = undef,
  $selectorpool_maxselectors        = undef,
  $selectorpool_maxspareselectors   = undef,
  $selectortimeout                  = undef,
  $sendfilesize                     = undef,
  $sendfilethreadcount              = undef,
  $server                           = undef,
  $sessioncachesize                 = undef,
  $sessiontimeout                   = undef,
  $socket_appreadbufsize            = undef,
  $socket_appwritebufsize           = undef,
  $socket_bufferpoolsize            = undef,
  $socket_bufferpool                = undef,
  $socketbuffer                     = undef,
  $socket_directbuffer              = undef,
  $socket_eventcache                = undef,
  $socket_keycache                  = undef,
  $socket_oobinline                 = undef,
  $socket_performancebandwidth      = undef,
  $socket_performanceconnectiontime = undef,
  $socket_performancelatency        = undef,
  $socket_processorcache            = undef,
  $socket_rxbufsize                 = undef,
  $socket_sokeepalive               = undef,
  $socket_solingeron                = undef,
  $socket_solingertime              = undef,
  $socket_soreuseaddress            = undef,
  $socket_sotimeout                 = undef,
  $socket_sotrafficclass            = undef,
  $socket_tcpnodelay                = undef,
  $socket_txbufsize                 = undef,
  $socket_unlocktimeout             = undef,
  $sslcacertificatefile             = undef,
  $sslcacertificatepath             = undef,
  $sslcarevocationfile              = undef,
  $sslcarevocationpath              = undef,
  $sslcertificatechainfile          = undef,
  $sslcertificatefile               = undef,
  $sslcertificatekeyfile            = undef,
  $sslciphersuite                   = undef,
  $sslenabled                       = undef,
  $sslpassword                      = undef,
  $sslprotocol                      = undef,
  $sslverifyclient                  = undef,
  $sslverifydepth                   = undef,
  $tcpnodelay                       = undef,
  $threadpriority                   = undef,
  $trustmanagerclassname            = undef,
  $truststorefile                   = undef,
  $truststorepass                   = undef,
  $truststoreprovider               = undef,
  $truststoretype                   = undef,
  $uriencoding                      = undef,
  $usebodyencodingforuri            = undef,
  $usecomet                         = undef,
  $useexecutor                      = undef,
  $useipvhosts                      = undef,
  $usesendfile                      = undef,
  $xpoweredby                       = undef
  ) {
  concat::fragment {
    "server_xml_connector_${port}":
      target  => '/etc/tomcat6/server.xml',
      content => template('tomcat6/etc/tomcat6/server.xml/connector.erb'),
      order   => 102,
      notify  => $tomcat6::notify;
  }
}
