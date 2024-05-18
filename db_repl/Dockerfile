#db repl
FROM postgres:15

ENV DB_REPL_PASSWORD="Qq12345"
ENV DB_REPL_USER="repl_user"
ENV DB_PORT="5432"
ENV DB_REPL_PORT="5432"
ENV DB_HOST="172.20.0.101"
ENV POSTGRES_USER="postgres"
ENV POSTGRES_PASSWORD="Qq12345"

RUN chmod 750 /var/lib/postgresql/data

RUN echo "listen_addresses = 'localhost, ${DB_HOST}" > /etc/postgresql/postgresql.conf
RUN echo "port = ${DB_REPL_PORT}" >> /etc/postgresql/postgresql.conf

RUN rm -rf /var/lib/postgresql/data/*

ENTRYPOINT [ "bash", "-c", "sleep 10 && echo ${DB_REPL_PASSWORD} | pg_basebackup -v -R -h ${DB_HOST} -p ${DB_PORT} -U ${DB_REPL_USER} -W -P -D /var/lib/postgresql/data && docker-entrypoint.sh $@"]

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]