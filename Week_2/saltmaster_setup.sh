sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install python-pip

pip install --upgrade pip

pip2 install softlayer

cat <<EOT >> ~/.softlayer
[softlayer]
username = YOUR_SL_API_ID
api_key = YOUR_SL_API_KEY
endpoint_url = https://api.softlayer.com/xmlrpc/v3.1/
timeout = 0
EOT

slcli virtual list
