mkdir /data
mkfs.ext4 /dev/xvdc

echo "/dev/xvdc /data                   ext4    defaults,noatime        0 0" >> /etc/fstab

mount /data
chmod 1777 /data
