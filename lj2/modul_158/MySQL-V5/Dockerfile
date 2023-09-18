FROM mysql:5.7.20
ENV MYSQL_ROOT_PASSWORD=sml12345
ENV MYSQL_DATABASE=sourcedb
ENV MYSQL_USER=dbadmin
ENV MYSQL_PASSWORD=sml12345
COPY my.cnf /etc/mysql/my.cnf
#COPY init.sql /docker-entrypoint-initdb.d/
COPY ./dumpfiles/*.sql /tmp/
COPY ./dumpfiles/*.dump /tmp/
COPY mkdb.sh /tmp/
RUN chmod +x /tmp/mkdb.sh<
EXPOSE 3306
CMD ["mysqld"]
CMD /tmp/mkdb.sh