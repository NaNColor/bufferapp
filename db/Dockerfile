FROM postgres:15.6
RUN mkdir -p /tmp/postgres && chown postgres:postgres /tmp/postgres
COPY init.sql /docker-entrypoint-initdb.d/