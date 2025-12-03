#!/bin/bash
apt update -y
apt upgrade -y
apt install -y nginx
echo "<h1>Kenny's AWS Server - Deployed via User Data</h1><p>Hostname: $(hostname)</p>" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx
