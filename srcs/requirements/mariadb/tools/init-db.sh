#!/bin/bash

LOCKFILE="/var/lib/mysql/.lockfile_mysql"

if [ -f "$LOCKFILE" ]; then
	echo "MySQL already initialized"

else
	echo "Initialising MySQL"

	service mysql start

	sleep 3

	mysql -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
	
	touch "$LOCKFILE"

	echo "MariaDB has been succesfully configured"

fi

exec mysqld --bind-address=0.0.0.0