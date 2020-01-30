#!/bin/bash
sudo mkdir -p /media/BACKUP/urbackup
sudo add-apt-repository -y ppa:uroni/urbackup  
sudo apt-get -y update
sudo apt-get -y install s3fs
#mount sf3s on /media/BACKUP/urbackup
sudo s3fs -o iam_role="urbackup" -o url="https://urbackup.s3.eu-central-1.amazonaws.com" -o endpoint=eu-central-1 -o dbglevel=info -o curldbg -o allow_other -o use_cache=/tmp -o nonempty -o umask=0007,uid=1000,gid=1000 bucket /media/BACKUP/urbackup
sudo apt-get -y install urbackup-server 
sudo apt-get -f install

#client
sudo apt install build-essential "g++" libwxgtk3.0-dev "libcrypto++-dev" libz-dev
# TF=$(mktemp) && wget "https://hndl.urbackup.org/Client/2.4.10/UrBackup%20Client%20Linux%202.4.10.sh" -O $TF && sudo sh $TF; rm -f $TF
# sudo urbackupclientbackend -v info
# get it from the server with encription key 
