#!/bin/bash
command -v docker >/dev/null 2>&1 || {
  echo >&2 -e "\033[31m 请先安装docker，安装文档地址 -> https://docs.docker.com/engine/install/ \033[0m"
  exit 1
}
command -v docker-compose >/dev/null 2>&1 || {
  echo >&2 -e "\033[31m 请先安装docker-compose，安装文档地址 -> https://docs.docker.com/compose/install/ \033[0m"
  exit 1
}

if [ ! -d "./jenkins" ]; then
  echo "Jenkins目录不存在，准备创建目录并添加权限"
  mkdir "./jenkins"
  sudo chmod -R 777 jenkins
  echo "Jenkins目录创建成功"
fi
echo $(ls)
echo "开始创建Jenkins容器"
docker-compose up -d
success=0
failCount=0
while [ "$success" -eq 0 -a "$failCount" -lt 10 ]; do
  if [ -f "./jenkins/secrets/initialAdminPassword" ]; then
    echo -e "\033[36m Jenkins启动成功，下面日志内为首次登录jenkins密码 也可以在 jenkins/secrets/initialAdminPassword 内找到 \033[0m"
    echo -e "\033[36m \n******密码开始******\n \033[0m"
    cat "./jenkins/secrets/initialAdminPassword"
    echo -e "\033[36m \n******密码结束******\n \033[0m"
    success=1
  else
    sudo cat "./jenkins/secrets/initialAdminPassword"
    echo -e "\033[36m Jenkins正在启动，请等待... \033[0m"
    sleep 3
    failCount=$(("$failCount" + 1))
  fi
done
if [ "$success" -eq 0 ]; then
  echo >&2 -e "\033[31m Jenkins可能启动失败，请检查端口是否占用，稍后为您输出日志 \033[0m"
  sleep 5
  docker-compose logs
fi
