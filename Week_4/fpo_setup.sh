cat <<EOT >> /root/diskfile.fpo
%pool:
pool=system
allowWriteAffinity=yes
writeAffinityDepth=1

%nsd:
device=/dev/xvdc
servers=gpfs1
usage=dataAndMetadata
pool=system
failureGroup=1

%nsd:
device=/dev/xvdc
servers=gpfs2
usage=dataAndMetadata
pool=system
failureGroup=2

%nsd:
device=/dev/xvdc
servers=gpfs3
usage=dataAndMetadata
pool=system
failureGroup=3
EOT
