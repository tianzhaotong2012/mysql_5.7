#!/bin/sh

if [ `whoami` != "root" ];then
su root
echo "run again"
exit 1
fi 

useradd mysql

echo "下一步手动把生成的mysql-bin-5_7_11.tar.gz 解压到目标机器的/home/mysql/目录下完成部署"




