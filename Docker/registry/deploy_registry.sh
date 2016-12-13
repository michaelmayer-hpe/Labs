#!/bin/bash

# Checking tool deps
for tool in docker-compose sed docker
do
	echo "Checking $tool"
	which $tool || exit 1
done


echo "Enter the public fqdn of your registry (IP will not work)"
read FQDN
sed -i -r -e "s/PUBFQDN=.*/PUBFQDN=$FQDN/" docker-compose.yml
docker-compose up -d --build
