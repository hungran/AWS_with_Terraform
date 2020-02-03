#! /bin/bash
sudo apt-get upgrade
sudo apt-get update -y
sudo apt-get install awscli -y
sudo apt-get install apache2 -y
sudo apt-get install stress -y
sudo service apache2 start
sudo echo "public ip is $(curl http://169.254.169.254/latest/meta-data/public-ipv4), " >> hung.txt
sudo echo "instance id is $(curl  http://169.254.169.254/latest/meta-data/instance-id)," >> hung.txt
sudo echo "instance-type is $(curl  http://169.254.169.254/latest/meta-data/instance-type) " >> hung.txt
sudo cat hung.txt > /var/www/html/index.html
mkfs.ext4 /dev/xvdh
mount /dev/xvdh /mnt
echo /dev/xvdh /mnt defaults,nofail 0 2 >> /etc/fstab