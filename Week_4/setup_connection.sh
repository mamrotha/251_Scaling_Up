#gpfs1
cat .ssh/id_rsa_3.pub | ssh root@host 'cat >> .ssh/authorized_keys'
ssh root@host "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"

#gpfs2
cat .ssh/id_rsa_3.pub | ssh root@host 'cat >> .ssh/authorized_keys'
ssh root@host "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"

#gpfs3
cat .ssh/id_rsa_3.pub | ssh root@host 'cat >> .ssh/authorized_keys'
ssh root@host "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
