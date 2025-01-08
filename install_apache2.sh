#!/bin/bash

sudo yum update -y 
sudo dnf install httpd -y 
sudo systemctl enable httpd
sudo systemctl start httpd
sudo bash -c echo my very first web server > /var/www/html/index.html'