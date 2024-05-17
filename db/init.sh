if [ -z "${VAR}" ]; then
export VAR="SET"
echo "listen_addresses = '*'" >> /etc/postgresql/15/main/postgresql.conf
echo "archive_mode = on" >> /etc/postgresql/15/main/postgresql.conf
echo "archive_command = 'cp %p /oracle/pg_data/archive/%f'" >> /etc/postgresql/15/main/postgresql.conf
echo "max_wal_senders = 10" >> /etc/postgresql/15/main/postgresql.conf
echo "wal_level = replica" >> /etc/postgresql/15/main/postgresql.conf
echo "wal_log_hints = on" >> /etc/postgresql/15/main/postgresql.conf
echo "log_replication_commands = on" >> /etc/postgresql/15/main/postgresql.conf
echo "host replication repl_user $DB_REPL_HOST/32 scram-sha-256" >> /etc/postgresql/15/main/pg_hba.conf
echo "host all all all password" >> /etc/postgresql/15/main/pg_hba.conf
#systemctl start postgresql
service postgresql start
service sshd start
echo "postgres:$DB_PASSWORD" | sudo chpasswd 
locale-gen en_US.UTF-8
su -c "cat /initdb/init.sql | psql" postgres

else
echo "Settings are set"
fi

trap "exit 0" SIGINT
while true
do
    sleep 1
done
