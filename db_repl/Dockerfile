#db repl
FROM postgres:alpine
EXPOSE 5432
RUN echo "listem_addresses = '*'" >> /etc/postgresql/*/main/postgresql.conf
RUN rm -rf /var/lib/postgresql/data/*