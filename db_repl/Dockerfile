#db repl
FROM postgres:alpine

RUN mkdir /etc/postgresql/ 
RUN chmod 750 /var/lib/postgresql/data

RUN echo "listen_addresses = 'localhost, ${DB_REPL_HOST}" > /etc/postgresql/postgresql.conf
RUN echo "port = ${DB_REPL_PORT}" >> /etc/postgresql/postgresql.conf

RUN rm -rf /var/lib/postgresql/data/*

ENTRYPOINT [ "bash", "-c", "sleep 10 && echo ${DB_REPL_PASSWORD} | pg_basebackup -v -R -h ${DB_HOST} -p ${DB_PORT} -U ${DB_REPL_USER} -W -P -D /var/lib/postgresql/data && docker-entrypoint.sh $@"]

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]