class ssl::cron {
  cron {'ssl-sync-node':
    command => '/scripts/ssl-sync-node.sh /scripts/certlist',
    user    => 'root',
    hour    => '3',
    minute  => '0',
  }
}
