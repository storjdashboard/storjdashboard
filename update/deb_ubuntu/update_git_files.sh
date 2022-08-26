#!/bin/bash
clear
#sudo mkdir -p /storjdashboard && cd /storjdashboard && curl -s https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/update/deb_ubuntu/update_git_files.sh -o update_git_files.sh && bash update_git_files.sh
log_filename="log_"$(date +'%Y-%m-%d_%H-%M')".log"
echo '------------------------------'
echo "Updating storjDashboard GIT files"
echo '------------------------------'
echo "Displaying /var/www directories"
ls /var/www
echo '------------------------------'
echo "(example.. storj.mydns.net)"
echo "(example.. 140.82.121.4)"
read -p "Public External Hostname/IP: " hostname_ip
echo ""

#1 index 
wget -O "/var/www/$hostname_ip/index.php" https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/index.php  >> /storjdashboard_logs/git/$log_filename
chmod 0777 /var/www/$hostname_ip/index.php
#2 daily
wget -O "/var/www/$hostname_ip/daily.php" https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/daily.php >> /storjdashboard_logs/git/$log_filename
chmod 0777 /var/www/$hostname_ip/daily.php
#3 pay
wget -O "/var/www/$hostname_ip/pay.php" https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/pay.php >> /storjdashboard_logs/git/$log_filename
chmod 0777 /var/www/$hostname_ip/pay.php
#4 audit
wget -O "/var/www/$hostname_ip/audit.php" https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/audit.php >> /storjdashboard_logs/git/$log_filename
chmod 0777 /var/www/$hostname_ip/audit.php

echo '-------------------------------'
echo '-----  UPDATE COMPLETED  ------'
echo '-------------------------------'
