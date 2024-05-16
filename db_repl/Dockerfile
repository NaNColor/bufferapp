FROM debian
RUN apt-get update && apt-get install -y postgresql-15 postgresql-contrib
ENV DB_HOST="172.20.0.101"
ENV DB_REPL_PASSWORD="Qq12345"
EXPOSE 5432
RUN mkdir -p /oracle/pg_data/archive && chown -R postgres:postgres /oracle
COPY init.sh /initdb/init.sh
CMD["bash", "/initdb/init.sh"]