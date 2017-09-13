#/bin/sh
yum install -y httpd php php-zlib php-iconv php-gd php-mbstring php-fileinfo php-curl php-mysql
chkconfig httpd on
cd /var/www
wget www.wordpress.org/latest.zip
unzip latest.zip
rm latest.zip
mv wordpress/* html/
rm -r wordpress
chown -R apache:apache html/
apachectl start
