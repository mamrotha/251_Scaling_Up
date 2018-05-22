wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -

cat <<EOT >> /etc/apt/sources.list.d/saltstack.list
deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main
EOT

sudo apt-get update

sudo apt-get install -y salt-master salt-minion salt-ssh salt-syndic salt-cloud salt-api

service salt-master start

service salt-syndic start

service salt-api start

mkdir -p /etc/salt/{cloud.providers.d,cloud.profiles.d}

cat <<EOT >> /etc/salt/cloud.providers.d/softlayer.conf
sl:
  minion:
    master: YOUR_VM_PUBLIC_IP
  user: YOUR_SL_API_ID
  apikey: YOUR_SL_API_KEY
  driver: softlayer
EOT

cat /etc/salt/cloud.providers.d/softlayer.conf

cat <<EOT >> /etc/salt/cloud.profiles.d/softlayer.conf
sl_ubuntu_small:
  provider: sl
  image: UBUNTU_LATEST_64
  cpu_number: 1
  ram: 1024
  disk_size: 25
  local_disk: True
  hourly_billing: True
  domain: somewhere.net
  location: dal06
EOT

