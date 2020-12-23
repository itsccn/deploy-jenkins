# 基于docker快速部署jenkins

# 快速开始
``` git clone https://github.com/itsccn/deploy-jenkins.git && cd deploy-jenkins && chmod +x setup.sh && ./setup.sh ```

# 后续
## 修改映射端口
修改 `docker-compose.yaml` ports部分端口映射，左边宿主机端口，右边容器端口
## 升级
修改 `docker-compose.yaml` 镜像版本即可最新版本参照 https://hub.docker.com/r/jenkins/jenkins
## 迁移
 打包 jenkins目录 -> ``` tar -zcvf jenkins.tar jenkins/ ```
 移动到另一台服务器 deploy-jenkins 目录下，运行 `./setup.sh`
