#db
FROM postgres:15

#for envsubst
RUN apt-get update && apt-get install gettext-base

COPY ./init.sql /docker-entrypoint-initdb.d/init.sql.raw
RUN mkdir -p /oracle/pg_data/archive/
RUN chown postgres:postgres /oracle/pg_data/archive/

RUN chown postgres:postgres /var/log/postgresql
RUN echo "listen_addresses = '*'" > /etc/postgresql/postgresql.conf 
RUN echo "log_destination = 'stderr'" >> /etc/postgresql/postgresql.conf 
RUN echo "logging_collector = on" >> /etc/postgresql/postgresql.conf 
RUN echo "log_directory = '/var/log/postgresql/'" >> /etc/postgresql/postgresql.conf 
RUN echo "log_filename = 'postgresql.log'" >> /etc/postgresql/postgresql.conf 
RUN echo "archive_mode = on" >> /etc/postgresql/postgresql.conf 
RUN echo "archive_command = 'cp %p /oracle/pg_data/archive/%f'" >> /etc/postgresql/postgresql.conf 
RUN echo "max_wal_senders = 10" >> /etc/postgresql/postgresql.conf 
RUN echo "wal_level = replica" >> /etc/postgresql/postgresql.conf 
RUN echo "wal_log_hints = on" >> /etc/postgresql/postgresql.conf 
RUN echo "log_replication_commands = on" >> /etc/postgresql/postgresql.conf 

RUN echo "host all all 0.0.0.0/0 password" > /etc/postgresql/pg_hba.conf 

ENTRYPOINT [ "bash", "-c", "\
envsubst < /docker-entrypoint-initdb.d/init.sql.raw > /docker-entrypoint-initdb.d/init.sql \n\
cat <<EOF >> /etc/postgresql/postgresql.conf \n\
port = ${DB_PORT} \n\
EOF\n\
cat <<EOF > /etc/postgresql/pg_hba.conf \n\
local all ${POSTGRES_USER} peer \n\
host replication ${DB_REPL_USER} ${DB_REPL_HOST} trust \n\
EOF\n\
docker-entrypoint.sh $@"]

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf", "-c", "hba_file=/etc/postgresql/pg_hba.conf" ]