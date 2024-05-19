FROM postgres:15.6
COPY init.sql /docker-entrypoint-initdb.d/
RUN chown postgres:postgres /tmp