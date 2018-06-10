#gpfs1
cat /root/.ssh/id_rsa.pub | ssh root@host 'cat >> /root/.ssh/authorized_keys'
ssh root@host "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
scp setup_node.sh root@host:setup_node.sh

wget http://1d7c9.http.dal05.cdn.softlayer.net/icp-artifacts/GPFS_4.1_STD_LSX_QSG.tar

#gpfs2
cat /root/.ssh/id_rsa.pub | ssh root@host 'cat >> /root/.ssh/authorized_keys'
ssh root@host "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
scp setup_node.sh root@host:setup_node.sh

#gpfs3
cat /root/.ssh/id_rsa.pub | ssh root@host 'cat >> /root/.ssh/authorized_keys'
ssh root@host "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
scp setup_node.sh root@host:setup_node.sh
