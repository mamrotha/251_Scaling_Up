scp setup_hosts.sh root@198.11.209.166:/root/setup_hosts.sh
scp setup_hosts.sh root@50.97.255.58:/root/setup_hosts.sh
scp setup_hosts.sh root@198.11.209.165:/root/setup_hosts.sh

ssh root@198.11.209.166 'chmod +x /root/setup_hosts.sh'
ssh root@50.97.255.58 'chmod +x /root/setup_hosts.sh'
ssh root@198.11.209.165 'chmod +x /root/setup_hosts.sh'

ssh root@198.11.209.166 'bash -s' < /root/setup_hosts.sh
ssh root@50.97.255.58 './root/setup_hosts.sh'
ssh root@198.11.209.165 './root/setup_hosts.sh'

rm -f /etc/hosts

cat <<EOT >> /etc/hosts
127.0.0.1 localhost.localdomain localhost
198.11.209.166 master.hadoop.mids.lulz.bz master
50.97.255.58 slave1.hadoop.mids.lulz.bz slave1
198.11.209.165 slave2.hadoop.mids.lulz.bz slave2
EOT

