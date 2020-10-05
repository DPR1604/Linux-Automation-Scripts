# SSL SYNC


#### Senario

Each server that is running a service also runs certbot to retrive a free SSL Certificate to secure the connection to application the previous solution was generateing a wildcard certicate for each server to cover multiple subdomains per server. The request was to centralize this from the management servers by requesting one wildcard certicate per doamin and sync that accross the estate of servers. 

#### Solution

There were a couple of problems to consider the primary problems being maintaining the security of the servers and the SSL certificate's private key.

The solution I created was to use a seperate user (certsync) to transfer the certificate files from the management server to the node servers the user esentially exsists to run a single rsync command, this was chosen because root access has been locked down so the ability to log into root via ssh is not possible 
