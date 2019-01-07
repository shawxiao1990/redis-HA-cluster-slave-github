#!/bin/sh
set -e

sed -i s"/\$REDIS_PASSWORD/$REDIS_PASSWORD/g" /etc/redis/redis-master.conf
sed -i s"/\$REDIS_PASSWORD/$REDIS_PASSWORD/g" /etc/redis/redis-slave.conf
sed -i s"/\$REDIS_HOST1/$REDIS_HOST1/g" /etc/redis/redis-slave.conf
sed -i s"/\$REDIS_PORT1/$REDIS_PORT1/g" /etc/redis/redis-slave.conf
sed -i s"/\$REDIS_HOST1/$REDIS_HOST1/g" /etc/redis/sentinel.conf
sed -i s"/\$REDIS_HOST2/$REDIS_HOST2/g" /etc/redis/sentinel.conf
sed -i s"/\$REDIS_HOST3/$REDIS_HOST3/g" /etc/redis/sentinel.conf
sed -i s"/\$REDIS_PORT1/$REDIS_PORT1/g" /etc/redis/sentinel.conf
sed -i s"/\$REDIS_PORT2/$REDIS_PORT2/g" /etc/redis/sentinel.conf
sed -i s"/\$REDIS_PORT3/$REDIS_PORT3/g" /etc/redis/sentinel.conf

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- redis-server "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
#	chown -R redis .
    find . \! -user redis -exec chown redis '{}' +
	exec gosu redis "$0" "$@"
fi

bash run-sentinel.sh &

exec "$@"
