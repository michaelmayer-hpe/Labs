#!/bin/bash

# Create the Lab env in Azure (! I know !)
# Log in on http://portal.azure.com

cat > az.sh << EOF
az login
az resource group create -l eastus -n LabDck
# We have 20 groups
for i in 0 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
#for i in 1; do
    # we have 5 VMs per group
    for j in 1 2 3 4 5; do
    #for j in 1; do
        az vm create -g LabDck -n gr\$i-vm\$j --image OpenLogic:CentOS:7.2:latest --authentication-type ssh --admin-username az --ssh-key-value /root/.ssh/id_az.pub --public-ip-address-dns-name gr\$i-vm\$j --size Basic_A0 -l eastus --storage-type Standard_LRS
    done
done
sleep 100000
az resource group delete -n LabDck
EOF
chmod 755 az.sh
cat > Dockerfile.az << EOF
FROM azuresdk/azure-cli-python:latest
COPY az.sh /tmp
CMD /tmp/az.sh
EOF
if [ ! -f $HOME/.ssh/id_az ]; then
    ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/id_az -q -N ""
fi
docker build -f ./Dockerfile.az -t azure .
docker run -v $HOME:/root --rm azure
