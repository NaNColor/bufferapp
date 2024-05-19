FROM postgres:15.6
RUN mkdir -p /var/log/postgres && chown postgres:postgres /var/log/postgres
COPY init.sql /docker-entrypoint-initdb.d/