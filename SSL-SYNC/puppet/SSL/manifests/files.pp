class ssl::files {

  file { '/certsync':
    ensure => 'directory',
    owner  => 'certsync',
    group  => 'certsync',
    mode   => '700',
  }

  file { '/certsync/live':
    ensure => 'directory',
    owner  => 'certsync',
    group  => 'certsync',
    mode   => '700',
  }

  file { '/scripts/ssl-sync/':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '700',
  }

  file { '/scripts/ssl-sync/ssl-sync-node.sh':
    mode  => '0700',
    owner   => 'root',
    group => 'root',
    ensure  => present,
    source  => "puppet:///modules/ssl/ssl-sync-node.sh",
  }

}
