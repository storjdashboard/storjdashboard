#!/bin/bash
clear
#sudo mkdir -p /storjdashboard && cd /storjdashboard && curl -s https://storjdashboard.com/install/installer.sh -o installer.sh && bash installer.sh

cd /
#log file date filename
log_filename="log_"$(date +'%Y-%m-%d_%H-%M')".log"
sudo mkdir -p /storjdashboard_logs
sudo mkdir -p /storjdashboard_logs/nginx/
sudo mkdir -p /storjdashboard_logs/php/
sudo mkdir -p /storjdashboard_logs/git/
clear
echo '------------------------------'
echo "Installing storjdashboard"
echo '------------------------------'
echo "(example.. storj.mydns.net)"
echo "(example.. 140.82.121.4)"
read -p "Public External Hostname/IP: " hostname_ip
echo ""
echo "(default 28000)"
read -p "Enter External Port: " hostname_port
echo ""
echo "(example.. 192.168.0.100:14002)"
read -p "Enter Internal storj dashboard IP:PORT: " storj_dashboard_ip_port

echo '------------------------------'
echo 'Host/IP: '$hostname_ip >> storjdashboard_logs/nginx/$log_filename
echo 'Internal Storj: '$storj_dashboard_ip_port >> storjdashboard_logs/nginx/$log_filename
echo 'Host/IP: '$hostname_ip
echo 'Internal Storj: '$storj_dashboard_ip_port
echo '------------------------------'
echo ""
echo 'Configuration Set.'
read -n 1 -s -r -p 'Press any key to start NGINX Install...'
echo ""
echo "waiting..."
sleep 3
echo "Installing NGINX..."

sudo apt-get install nginx -y >> storjdashboard_logs/nginx/$log_filename

sudo systemctl start nginx >> storjdashboard_logs/nginx/$log_filename
sudo systemctl enable nginx >> storjdashboard_logs/nginx/$log_filename

sudo nginx -v

echo ''
echo '------------------------------'
echo 'NGINX INSTALLED'
echo '------------------------------'
read -n 1 -s -r -p "Press any key to start PHP Install"
echo ""
echo "waiting..."
sleep 3
echo "Installing PHP..."

sudo apt-get install php-fpm -y >> storjdashboard_logs/php/$log_filename

sudo systemctl start php-fpm >> storjdashboard_logs/php/$log_filename
sudo systemctl enable php-fpm >> storjdashboard_logs/php/$log_filename

sudo php --version

echo ''
echo '------------------------------'
echo 'PHP INSTALLED'
echo '------------------------------'
read -n 1 -s -r -p "Press any key to start GIT file downloads"
echo ""
echo "waiting..."
sleep 3
echo "Downloading GIT files..."

sudo mkdir /var/www/$hostname_ip/

sudo chmod 0777 /var/www/$hostname_ip/

site_file="/etc/nginx/sites-enabled/$hostname_ip"

sudo touch $site_file

sudo chmod 0777 $site_file

sudo echo "server {" >> $site_file
sudo echo "        listen $hostname_port; " >> $site_file
sudo echo "        server_name $hostname_ip; " >> $site_file
sudo echo "        root /var/www/$hostname_ip; " >> $site_file
sudo echo "        index index.php; " >> $site_file
sudo echo "" >> $site_file
sudo echo "    location ~ \.php$ { " >> $site_file
sudo echo "        include snippets/fastcgi-php.conf; " >> $site_file
sudo echo "        fastcgi_pass unix:/run/php/php-fpm.sock; " >> $site_file
sudo echo "    } " >> $site_file
sudo echo "} ">> $site_file

sudo ln -s /etc/nginx/sites-available/$hostname_ip /etc/nginx/sites-enabled/

sudo nginx -t  >> storjdashboard_logs/nginx/$log_filename

sudo systemctl restart nginx

#1 index 
wget -O "/var/www/$hostname_ip/index.php" https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/index.php  >> /storjdashboard_logs/git/$log_filename
#2 daily
wget -O "/var/www/$hostname_ip/daily.php" https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/daily.php >> /storjdashboard_logs/git/$log_filename
#3 pay
wget -O "/var/www/$hostname_ip/pay.php" https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/pay.php >> /storjdashboard_logs/git/$log_filename
#4 audit
wget -O "/var/www/$hostname_ip/pay.php" https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/audit.php >> /storjdashboard_logs/git/$log_filename

#5 config
config_file="/var/www/$hostname_ip/config.php"
> $config_file
echo '<?php $ip="'$storj_dashboard_ip_port'"; ?>' >> $config_file


echo '------- TEST YOUR SERVER -------'
echo "-- http://$hostname_ip:$hostname_port/ --"
echo '-------------------------------'
echo '------ INSTALL COMPLETED ------'
echo '-------------------------------'
