#db
FROM postgres:alpine
ADD init.sql /docker-entrypoint-initdb.d
RUN chmod a+r /docker-entrypoint-initdb.d/*
EXPOSE 5432
RUN echo 'host replication repl_user 0.0.0.0/0 scram-sha-256' >> /etc/postgresql/*/main/pg_hba.conf
RUN echo 'host all all all password' >> /etc/postgresql/*/main/pg_hba.conf