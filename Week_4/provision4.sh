#Get three virtual servers provisioned, 2 vCPUs, 4G RAM, REDHAT_6_64, two local disks 25G each, in San Jose. 
#Make sure you attach a keypair. Pick intuitive names such as gpfs1, gpfs2, gpfs3. Note their internal (10.x.x.x) ip addresses.

slcli vs create --datacenter=sjc01 --domain=anywhere.com --hostname=gpfs1 --os=REDHAT_6_64 --cpu=2 --memory=4096 --disk=25 --disk=25 --billing=hourly --key Rupert

slcli vs create --datacenter=sjc01 --domain=anywhere.com --hostname=gpfs2 --os=REDHAT_6_64 --cpu=2 --memory=4096 --disk=25 --disk=25 --billing=hourly --key Rupert

slcli vs create --datacenter=sjc01 --domain=anywhere.com --hostname=gpfs3 --os=REDHAT_6_64 --cpu=2 --memory=4096 --disk=25 --disk=25 --billing=hourly --key Rupert
