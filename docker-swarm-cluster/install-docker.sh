#!/bin/sh
yum update
yum install -y docker
service docker start
usermod -aG docker ec2-user
