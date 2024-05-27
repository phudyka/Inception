FROM debian:buster

RUN apt update && \
    apt upgrade -y && \
    apt install -y mariadb-server vim curl && \
    apt clean

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh

RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

CMD ["mysqld_safe"]