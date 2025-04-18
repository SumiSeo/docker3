#!/bin/bash

#--------------mariadb start--------------#
service mariadb start # start mariadb
sleep 5 # wait for mariadb to start

#--------------mariadb config--------------#
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"

mariadb -e "FLUSH PRIVILEGES;"

#--------------mariadb restart--------------#
# Shutdown mariadb to restart with new config
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# Restart mariadb with new config in the background to keep the container running
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'