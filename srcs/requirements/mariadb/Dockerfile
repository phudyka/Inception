FROM debian:buster

RUN apt update && \
    apt upgrade -y && \
    apt install -y mariadb-server vim curl && \
    apt clean

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY /tools/init-db.sh /docker-entrypoint-initdb.d/init-db.sh

RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

CMD ["./docker-entrypoint-initdb.d/init-db.sh"]