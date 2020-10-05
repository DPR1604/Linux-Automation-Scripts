class ssl::account {

  group { 'certsync':
    ensure => present,
  }

  user { 'certsync':
    ensure     => present,
    home       => '/home/certsync',
    shell      => '/bin/bash',
    managehome => true,
    gid        => 'certsync',
  }
}
