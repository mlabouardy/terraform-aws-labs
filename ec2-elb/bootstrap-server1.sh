#!/bin/sh
yum install -y httpd
service start httpd
chkconfig httpd on
echo "hello world server 1" > /var/www/html/index.html
