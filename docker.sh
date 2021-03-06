#!/bin/bash
#docker-machine ssh default "sudo mkdir /sys/fs/cgroup/systemd"
#docker-machine ssh default "sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd"
#docker-machine ssh default "docker network create --driver bridge --subnet=10.10.10.0/24 --gateway=10.10.10.1 mynet"
docker network create --driver bridge --subnet=10.10.10.0/24 --gateway=10.10.10.1 mynet


#docker run --privileged --name=myredis --restart=always -d \
#    --network=mynet --ip 10.10.10.23 \
#    docker.io/redis --requirepass "123456"


workpace=/d/HashiCorp
db_name=o39


# 开发环境容器启动
docker run --privileged --name=test1 --restart=always -d \
    --network=mynet --ip 10.10.10.10 \
    -v $workpace:$workpace \
    -v $workpace/root/.jenkins/:/root/.jenkins/ \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/test:latest

docker run --privileged --name=test1 --restart=always -d \
    --network=mynet --ip 10.10.10.10 \
    -v /d/HashiCorp:/d/HashiCorp \
    -v /d/HashiCorp/root/.jenkins/:/root/.jenkins/ \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/linux:centos7

# ..
sudo docker run --privileged --name=centos --restart=always -d \
    --network=mynet --ip 10.10.10.10 \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/linux:centos7


sudo docker run --privileged --name=centos1 --restart=always -d \
    --network=mynet --ip 10.10.10.11 \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/linux:centos7

sudo docker run --privileged --name=centos2 --restart=always -d \
    --network=mynet --ip 10.10.10.12 \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/linux:centos7

sudo docker run --privileged --name=centos3 --restart=always -d \
    --network=mynet --ip 10.10.10.13 \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/linux:centos7

sudo docker run --privileged --name=centos4 --restart=always -d \
    --network=mynet --ip 10.10.10.14 \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/linux:centos7


docker run --privileged --name=ubuntu --restart=always -d \
    --network=mynet --ip 10.10.10.09 \
    -v /d/HashiCorp:/d/HashiCorp \
    -v /d/HashiCorp/root/.jenkins/:/root/.jenkins/ \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/ubuntu-18-16:latest


# mysql数据库容器启动
docker run --privileged --name=mymysql --restart=always -d \
    -p 3306:3306 \
    --network=mynet --ip 10.10.10.24 \
    -v $workpace/mymysql/conf:/etc/mysql \
    -v $workpace/mymysql/logs:/logs \
    -v $workpace/mymysql/mysql:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=123456 \
    mysql:5.7.18

#docker run --name=mymysql \
#    -u root \
#    -it -p 3306:3306 \
#    -v /d/HashiCorp/mymysql/mysql:/data/mysql \
#    -e MYSQL_ROOT_PASSWORD=123456 \
#    mysql:5.7.18  mysqld --datadir=/data/mysql

##docker run --name=jenkins --restart=always -d \
##  -u root \
##  -p 9090:8080 \
##  -v $workpace/var/jenkins_home:/var/jenkins_home \
##  jenkins/jenkins
#
# jenkins容器启动
docker run --privileged --name=jenkins_1 --restart=always -d \
    --network=mynet --ip 10.10.10.1 \
    -u root \
    -v $workpace/root/.jenkins_1/:/root/.jenkins/ \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/test:latest


docker run --privileged --name=jenkins_2 -it \
    --network=mynet --ip 10.10.10.2  --rm=true\
    -u root \
    -p 8082:8080 \
    -v $workpace/root/.jenkins_2/:/root/.jenkins/ \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/test:latest \
    java -jar /root/jenkins.war

docker run --privileged --name=jenkins_3 --restart=always -d \
    --network=mynet --ip 10.10.10.3 \
    -u root \
    -p 2003:22 \
    -p 8083:8080 \
    -v $workpace/root/.jenkins_3/:/root/.jenkins/ \
    registry.cn-hangzhou.aliyuncs.com/lch_docker_k/test:latest


#mysql允许远程连接
#docker-machine ssh default \
#    "docker exec -d mymysql " \
#    "mysql -uroot -p123456 -e\"" \
#    "CREATE DATABASE $db_name CHARACTER SET utf8 COLLATE utf8_general_ci;" \
#    "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';" \
#    "FLUSH PRIVILEGES;\""
#
# 启动三个jenkins服务
docker exec -d jenkins_1 java -jar /root/jenkins.war
docker exec -d jenkins_1 \cp -r  ~/.ssh/id_rsa ~/.jenkins/
docker exec -d jenkins_2 java -jar /root/jenkins.war
docker exec -d jenkins_2 \cp -r  ~/.ssh/id_rsa ~/.jenkins/
docker exec -d jenkins_3 java -jar /root/jenkins.war
docker exec -d jenkins_3 \cp -r  ~/.ssh/id_rsa ~/.jenkins/

#docker-machine ssh default "sudo rm -rf /root/.ssh/known_hosts"
#docker-machine ssh default "docker exec -d jenkins_1 java -jar /root/jenkins.war"
#docker-machine ssh default "docker exec -d jenkins_1 \cp -r  ~/.ssh/id_rsa ~/.jenkins/"
#docker-machine ssh default "docker exec -d jenkins_2 java -jar /root/jenkins.war"
#docker-machine ssh default "docker exec -d jenkins_2 \cp -r  ~/.ssh/id_rsa ~/.jenkins/"
#docker-machine ssh default "docker exec -d jenkins_3 java -jar /root/jenkins.war"
#docker-machine ssh default "docker exec -d jenkins_3 \cp -r  ~/.ssh/id_rsa ~/.jenkins/"

