sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install python-pip

pip install --upgrade pip

pip2 install softlayer

cat <<EOT >> ~/.softlayer
[softlayer]
username = SL1655535
api_key = 96a97f03850db360f57e21ed7b05dfd3080050cf7f9c8d832627b90e66a3a346
endpoint_url = https://api.softlayer.com/xmlrpc/v3.1/
timeout = 0
EOT

slcli virtual list
