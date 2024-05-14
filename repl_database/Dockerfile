FROM postgres:15
RUN echo "listen_addresses = '*'" >> /etc/postgresql/15/main/postgresql.conf
CMD["systemctl", "restart", "postgresql"]