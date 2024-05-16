FROM debian
RUN apt-get update && apt-get install -y postgresql-15 postgresql-contrib openssh-server
ENV DB_REPL_HOST="172.20.0.102"
ENV DB_PASSWORD="Qq12345"
EXPOSE 22
EXPOSE 5432
RUN mkdir -p /oracle/pg_data/archive && chown -R postgres:postgres /oracle

COPY init.* /initdb/

CMD ["bash", "/initdb/init.sh"]