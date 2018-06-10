echo 'export PATH=$PATH:/usr/lpp/mmfs/bin' >> /root/.bash_profile

rm /etc/hosts

cat <<EOT >> /etc/hosts
127.0.0.1 localhost.localdomain localhost
10.122.6.68 gpfs1
10.122.6.70 gpfs2
10.122.6.71 gpfs3
EOT

cat <<EOT >> /root/nodefile
gpfs1:quorum:
gpfs2::
gpfs3::
EOT
