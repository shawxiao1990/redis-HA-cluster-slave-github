FROM redis:4.0

RUN apt-get update
RUN apt-get install net-tools;\
    apt-get install psmisc
RUN apt-get install -y curl

RUN mkdir /var/log/redis/

COPY docker-entrypoint.sh /usr/local/bin/
COPY sentinel.conf /etc/redis/
COPY redis-master.conf /etc/redis/
COPY redis-slave.conf /etc/redis/
COPY run-sentinel.sh /usr/local/bin/

RUN chown -R redis /etc/redis && chown -R redis /var/log/redis

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server"]