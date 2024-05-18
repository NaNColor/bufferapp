#db repl
FROM postgres:15
RUN chmod 750 /var/lib/postgresql/data
RUN rm -rf /var/lib/postgresql/data/*

ENTRYPOINT [ "bash", "-c", "\
sleep 10 \n\
echo ${DB_REPL_PASSWORD} | pg_basebackup -v -R -h ${DB_HOST} -p ${DB_PORT} -U ${DB_REPL_USER} -W -P -D /var/lib/postgresql/data \n\
cat <<EOF > /etc/postgresql/postgresql.conf \n\
listen_addresses = 'localhost, ${DB_REPL_HOST}' \n\
port = ${DB_REPL_PORT} \n\
EOF\n\
docker-entrypoint.sh $@"]

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]