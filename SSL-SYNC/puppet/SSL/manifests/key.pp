class ssl::key {

   ssh_authorized_key { 'certsync@odin.man.valhallaonline.info':
     ensure => present,
     user    => 'certsync',
     type    => 'ssh-rsa',
     key     => '[private key here]',
   }
}
