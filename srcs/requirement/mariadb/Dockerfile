
# FROM debian:bullseye
# RUN apt update -y && \
#     apt install -y mariadb-server



# COPY	tools/init_db.sh	/
# RUN 	chmod 755 init_db.sh
# CMD 	["bash", "init_db.sh"]

FROM debian:bullseye

RUN apt update -y && apt install -y mariadb-server && \
     mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY tools/init_db.sh /init_db.sh
RUN chmod +x /init_db.sh

ENTRYPOINT ["/init_db.sh"]

CMD ["mysqld_safe"]
