if [ -z "${VAR}" ]; then
export VAR="SET"
service postgresql stop
echo "listen_addresses = 'localhost, $DB_HOST'" >> /etc/postgresql/15/main/postgresql.conf
#echo "host all all all password" >> /etc/postgresql/15/main/pg_hba.conf
echo "postgres:$DB_REPL_PASSWORD" | chpasswd 
rm -rf /var/lib/postgresql/15/main/*
echo $DB_REPL_PASSWORD | pg_basebackup -R -h $DB_HOST -U repl_user -D /var/lib/postgresql/15/main -P
service postgresql start
else
echo "Settings are set"
fi

trap "exit 0" SIGINT
while true
do
    sleep 1
done
