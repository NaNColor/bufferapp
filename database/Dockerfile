FROM postgres:15
COPY init.sh /docker-entrypoint-initdb.d/init.sh
COPY init.sql /docker-entrypoint-initdb.d/init.sql
RUN createuser --replication -P repl_user
RUN mkdir -p /oracle/pg_data/archive && chown -R postgres:postgres /oracle

RUN apt-get update && apt-get install -y openssh-server openssh-client
RUN mkdir /var/run/sshd
RUN echo 'root:Qq12345' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
#EXPOSE 5432

CMD ["/usr/sbin/sshd", "-D"]
