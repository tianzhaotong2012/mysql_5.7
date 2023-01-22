#!/bin/sh

if [ `whoami` != "root" ];then
su root
echo "run again"
exit 1
fi 

rm -rf /etc/my.cnf

/home/mysql/mysql/libexec/mysqld --initialize --user=mysql --basedir=/home/mysql/mysql --datadir=/home/mysql/mysql/var

cat /home/mysql/mysql/log/mysql.err

echo -e "\033[41;36m read above message rememer root password \033[0m"

echo "0./home/mysql/mysql/bin/mysql.server start"
echo "1. login mysql"
echo "2. change password"
echo "======================"
echo "step 1: SET PASSWORD = PASSWORD('your new password'); 
step 2: ALTER USER 'root'@'localhost' PASSWORD EXPIRE NEVER; 
step 3: flush privileges;"
echo "======================"
echo "3. delete unsafe user "
echo "======================"
echo "mysql -hlocalhost -P5100 -uroot -p -Ne \"select concat('drop user \'',user,'\'@\'',host,'\';') from mysql.user where user='' or host not in ('127.0.0.1','localhost')\"  >> ./drop_illegal_user.sql"
echo ""
echo "mysql -hlocalhost -P5100 -uroot -p < ./drop_illegal_user.sql"
echo "======================"





