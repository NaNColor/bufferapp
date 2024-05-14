echo "listen_addresses = '*'" >> /etc/postgresql/15/main/postgresql.conf
echo "archive_mode = on" >> /etc/postgresql/15/main/postgresql.conf
echo "archive_command = 'cp %p /oracle/pg_data/archive/%f'" >> /etc/postgresql/15/main/postgresql.conf
echo "max_wal_senders = 10" >> /etc/postgresql/15/main/postgresql.conf
echo "wal_level = replica" >> /etc/postgresql/15/main/postgresql.conf
echo "wal_log_hints = on" >> /etc/postgresql/15/main/postgresql.conf
echo "host replication repl_user 172.20.0.102/32 scram-sha-256" >> /etc/postgresql/15/main/pg_hba.conf
echo "host all all all password" >> /etc/postgresql/15/main/pg_hba.conf
#systemctl restart postgresql