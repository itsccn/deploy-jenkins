#!/bin/bash

command -v docker >/dev/null 2>&1 || { echo >&2 "I require docker but it's not installed.  Aborting."; exit 1; }
command -v docker-compose  >/dev/null 2>&1 || { echo >&2 "I require docker-compose but it's not installed.  Aborting."; exit 1; }

if [ ! -d "$PWD/jenkins" ];then
	 echo "Jenkins目录不存在，准备创建目录并添加权限"
	 mkdir $PWD/jenkins
	 chmod 777 jenkins
	 echo "Jenkins目录创建成功"
fi

echo "开始创建Jenkins容器"
docker-compose up -d 
echo "请使用下面密码登录Jenkins控制台"
cat $PWD/jenkins/secrets/initialAdminPassword
echo "Jenkins部署成功"
