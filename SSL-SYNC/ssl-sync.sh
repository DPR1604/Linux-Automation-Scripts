#!/bin/bash

#Author: Gareth Jones

#Defines the certificate to sync
CERT=$1

SERVERLIST=$2

#Defines the Privkey location
PRIVKEY="/etc/letsencrypt/live/$CERT/privkey.pem"

#Defines the fullchain location
FULLCHAIN="/etc/letsencrypt/live/$CERT/fullchain.pem"

#Defines the cert path the cert are moved to
CERTSYNCPATH="/certsync/live/$CERT"

#Defines the location to copy the privkey to
PRIVKEYFILE="$CERTSYNCPATH/privkey.pem"

#Defines the location ti copy the fullchain to
FULLCHAINFILE="$CERTSYNCPATH/fullchain.pem"

#Checks if the cert directory exsists
if  [ ! -d "$CERTSYNCPATH" ]
then
        mkdir $CERTSYNCPATH
        chmod 700 $CERTSYNCPATH
fi

#Emptys the priv key file
>$PRIVKEYFILE

#emptys the fullchain file
>$FULLCHAINFILE

#copies the content of the symlink letsencypt files to file that can be syncd
cat $PRIVKEY > $PRIVKEYFILE
cat $FULLCHAIN > $FULLCHAINFILE

#Modifies the permissions so the file are only visible by the certsync user.
chown -R certsync:certsync $CERTSYNCPATH
chmod 600 {$PRIVKEYFILE,$FULLCHAINFILE}

#Reads the server list file to sync the certifucates the different servers
while IFS= read -r line; do
        sudo -u certsync rsync -azvp $CERTSYNCPATH $line:/certsync/live/
done < "$SERVERLIST"
