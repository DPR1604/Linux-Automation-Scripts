#!/bin/bash

#Defines the cerlist configuration file.
CERTLIST=$1

#Defines the directory the certs are temporarily stored in.
CERTSYNCDIR="/certsync/live"

# Starts the Loop for each line of the config file.
while IFS= read -r line; do

        #Defines the certs final location reusing the certbot directory for convenience.
        CERTDIR="/etc/letsencrypt/live/$line"

        #Checks if there is a new certificate to replace the current one.
        if [[ -f "$CERTSYNCDIR/$line/fullchain.pem" && -f "$CERTSYNCDIR/$line/privkey.pem" ]]
        then

                #checks the if the cert directory exsists if it dosent then creates it.
                if [ ! -d "$CERTDIR" ]
                then
                        mkdir $CERTDIR
                fi

                #removes the old fullchain
                rm $CERTDIR/fullchain.pem

                #moves the new fullchain from the temp location to the correct directory
                mv {$CERTSYNCDIR/$line,$CERTDIR}/fullchain.pem

                #corrects the file permission from the transfer
                chmod 644 $CERTDIR/fullchain.pem

                #removes the old private key
                rm $CERTDIR/privkey.pem

                #moves the new private key to the correct directory.
                mv {$CERTSYNCDIR/$line,$CERTDIR}/privkey.pem

                #changes owner of the fullchain & privkey to root
                chown root:root $CERTDIR/{privkey,fullchain}.pem

                #reloads nginx
                systemctl reload nginx
        fi

done < "$CERTLIST"
