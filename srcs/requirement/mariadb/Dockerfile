FROM Debian::bullesey

RUN apt update -y && \
    apt install mariadb-server -y \

COPY    conf/50-server.cnf /etc/mysql/mariadb.conf.d/50.server.cnf


