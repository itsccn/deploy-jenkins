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
echo -e "\033[36m Jenkins启动成功，下面日志内包含首次登录jenkins密码 也可以在 jenkins/secrets/initialAdminPassword 内找到 \033[0m"
docker-compose logs -f
