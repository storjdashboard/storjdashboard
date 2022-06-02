#!/bin/bash
#sudo mkdir -p /storjdashboard && cd /storjdashboard && curl -s https://storjdashboard.com/install/uninstall.sh -o uninstall.sh && bash uninstall.sh

clear
cd /

read -p "Enter external Hostname/IP: " hostname_ip

read -n 1 -s -r -p "Press any key to start the uninstall of storjdashboard"
echo "" 
echo "------------------------------"
#log file date filename
log_filename="log_"$(date +'%Y-%m-%d_%H-%M')".log"
sudo mkdir -p /storjdashboard_logs
sudo mkdir -p /storjdashboard_logs/uninstall/

echo ""
echo "Uninstalling storjdashboard..."
echo ""
echo "--- Stopping Services"
echo "------------------------------"
sudo systemctl stop nginx >> /storjdashboard_logs/uninstall/$log_filename
sudo systemctl stop apache2 >> /storjdashboard_logs/uninstall/$log_filename
sudo systemctl stop php7.4-fpm >> /storjdashboard_logs/uninstall/$log_filename

echo ""
echo "--- Uninstalling NGINX/PHP"
echo "------------------------------"
sudo apt-get purge apache2 apache2-utils apache2-bin apache2.2-common php7.* nginx nginx-common -y >> /storjdashboard_logs/uninstall/$log_filename
echo "--- Completing AutoRemove"
echo "------------------------------"
sudo apt autoremove

echo ""
echo "--- Removing Directories"
echo "------------------------------"
sudo rm -r "/etc/nginx/sites-available/$hostname_ip" >> /storjdashboard_logs/uninstall/$log_filename

sudo rm -r "/etc/nginx/sites-enabled/$hostname_ip" >> /storjdashboard_logs/uninstall/$log_filename

sudo rm -r "/var/www/$hostname_ip" >> /storjdashboard_logs/uninstall/$log_filename

echo ""
echo "---- UNINSTALLED ----"
