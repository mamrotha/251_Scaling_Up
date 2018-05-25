#gpfs1
cat .ssh/id_rsa_3.pub | ssh root@host 'cat >> .ssh/authorized_keys'

#gpfs2
cat .ssh/id_rsa_3.pub | ssh root@host 'cat >> .ssh/authorized_keys'

#gpfs3
cat .ssh/id_rsa_3.pub | ssh root@host 'cat >> .ssh/authorized_keys'
