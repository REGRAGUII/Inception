# mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

FROM debian:bullseye

RUN apt update -y && apt install -y mariadb-server 

COPY tools/init_db.sh /init_db.sh
RUN chmod +x /init_db.sh

ENTRYPOINT ["/init_db.sh"]

CMD ["mysqld_safe"]
