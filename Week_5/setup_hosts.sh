rm -f /etc/hosts

cat <<EOT >> /etc/hosts
127.0.0.1 localhost.localdomain localhost
50.97.248.172 master.hadoop.mids.lulz.bz master
50.97.248.170 slave1.hadoop.mids.lulz.bz slave1
169.53.129.180 slave2.hadoop.mids.lulz.bz slave2
EOT
