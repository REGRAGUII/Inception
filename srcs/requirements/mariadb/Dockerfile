FROM debian:bullseye

RUN apt update -y && apt install -y mariadb-server 

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf 
COPY tools/init_db.sh /init_db.sh

RUN chmod +x /init_db.sh

ENTRYPOINT ["/init_db.sh"]
EXPOSE 3306

CMD ["mysqld_safe"]
