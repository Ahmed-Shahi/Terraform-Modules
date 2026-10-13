#!/bin/bash
apt update
apt upgrade -y


apt install -y
apt install -y

hostnamectl set-hostname prod-webserver

apt install nginx -y

systemctl enable nginx
systemctl start nginx

systemctl reboot