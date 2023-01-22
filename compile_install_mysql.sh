#!/bin/sh

if [ `whoami` != "root" ];then
su root
echo "run again"
exit 1
fi 



#wget "https://src.fedoraproject.org/lookaside/extras/community-mysql/mysql-5.7.11.tar.gz/f84d945a40ed876d10f8d5a7f4ccba32/mysql-5.7.11.tar.gz" -O mysql-5.7.11.tar.gz 

tar zxf mysql-5.7.11.tar.gz

tar zxf boost_1_59_0.tar.gz

sleep 1

cp -r boost_1_59_0 ./mysql-5.7.11/

cd mysql-5.7.11

yum install -y gcc gcc-c++ ncurses-devel
yum -y install cmake

mkdir -p /home/mysql/mysql

cmake -DCMAKE_INSTALL_PREFIX=/home/mysql/mysql -DMYSQL_DATADIR=/home/mysql/mysql/var -DSYSCONFDIR=/home/mysql/mysql/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS=all -DMYSQL_TCP_PORT=5100 -DMYSQL_UNIX_ADDR=/home/mysql/mysql/tmp/mysql.sock -DENABLED_PROFILING=1 -DENABLED_LOCAL_INFILE=1 -DWITH_DEBUG=0 -DINSTALL_SBINDIR=/home/mysql/mysql/libexec/ -DINSTALL_SCRIPTDIR=/home/mysql/mysql/share/script/ -DINSTALL_SUPPORTFILESDIR=/home/mysql/mysql/share/support-files/ -DINSTALL_MYSQLTESTDIR=/home/mysql/mysql/share/mysql-test/ -DINSTALL_MANDIR=/home/mysql/mysql/share/man/ -DINSTALL_DOCREADMEDIR=/home/mysql/mysql/share/ -DINSTALL_DOCDIR=/home/mysql/mysql/share/docs/ -DWITH_BOOST=./boost_1_59_0

make -j 8

make install

cd ..

useradd mysql

mkdir -p /home/mysql/mysql/log
mkdir -p /home/mysql/mysql/tmp
mkdir -p /home/mysql/mysql/etc
mkdir -p /home/mysql/mysql/var

cp my.cnf /home/mysql/mysql/etc/my.cnf
cp mysqld.cnf /home/mysql/mysql/etc/mysqld.cnf
cp user.root.cnf /home/mysql/mysql/etc/user.root.cnf
cp user.admin.cnf /home/mysql/mysql/etc/user.admin.cnf

chown -R mysql.mysql /home/mysql

cp /home/mysql/mysql/share/support-files/mysql.server /home/mysql/mysql/bin/

cd /home/mysql/

tar czf /home/mysql/mysql-bin-5_7_11.tar.gz *

echo "/home/mysql/mysql-bin-5_7_11.tar.gz is ready to deploy "

#下一步手动把生成的mysql-bin-5_7_11.tar.gz 解压到目标机器的/home/mysql/目录下完成部署


