apt-get update
apt-get install mosquitto-clients

mosquitto_sub -t /applications/in/+/public/# -h 169.44.201.108
