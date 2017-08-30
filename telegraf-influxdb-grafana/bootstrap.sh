#!/bin/sh
yum update
yum install -y docker curl
service docker start
usermod -aG docker ec2-user
curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
