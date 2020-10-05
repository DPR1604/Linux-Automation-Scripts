# SSL SYNC


#### Senario

Each server that is running a service also runs certbot to retrive a free SSL Certificate to secure the connection to application the previous solution was generateing a wildcard certicate for each server to cover multiple subdomains per server. The request was to centralize this from the management servers by requesting one wildcard certicate per doamin and sync that accross the estate of servers. 

#### Problems to consider

The security of the servers.

The security of the private key.

Securly transferring the files 

#### Solution

Below is the entire process the solution runs from start to finish.

Certbot runs on the management server to pull a new wildcard certificate from letsencrypt, upon a successful renewal certbot runs a post-hook that calls the ssl-sync.sh script this then creates a copy of the certificate from the letsencrypt live directory to certsync/live, this is done because the live files a symlinked form the archive folder, creating a copy removes the risk of causing issue with certbot.

Once a copy of the certificate has been created the script will then read the list of servers from the respective config file and run a rsync command to each server in the list that copies the certicate files to /certsync/live/ on each node.

A cron is then run once a day on each node to run the ssl-sync-node.sh script this script moves the cert files from the /certsync/live to the letsencrypt live folder and restarts the nginx service furture interations will allow the service that is restarted to be customized.

Puppet is used to manage the cron jobs and user/user key on the node servers this allows changes to be centrally controled by the management server.

#### Config

Both scripts rely on a config file that is called each time the script is run for ssl-sync.sh each certificate that needs to be synced has it own file this is just a list of servers to sync the certicates to, each server ip/hostname should be on it's own line, as for ss-sync-node.sh this is a list of certicates to check /certsync/live for, the name of the file can be anything as this it is a variable when running the command.
