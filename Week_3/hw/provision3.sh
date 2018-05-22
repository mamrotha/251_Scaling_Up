ssh-keygen -f ~/.ssh/id_rsa_3 -b 2048 -t rsa -C 'made for HW3'
slcli sshkey add -f ~/.ssh/id_rsa_3.pub --note 'added during HW 3' homework_3

slcli vs create -d hou02 --os UBUNTU_LATEST_64 --cpu 2 --memory 2048 --hostname mosquito --domain someplace.net --key homework_3
