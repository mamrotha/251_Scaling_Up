ssh-copy-id -i ~/.ssh/mykey root@host

cat /root/.ssh/id_rsa.pub | ssh root@host 'cat >> /root/.ssh/authorized_keys'
