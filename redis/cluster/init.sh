#!/bin/bash

PORT=7000
ENDPORT=7002

if [ "$1" == "start" ]
then
	while [ $((PORT < ENDPORT)) != "0" ]; do
        echo "Starting $PORT"
		mkdir $PORT
		cp ./demo.conf ./$PORT/redis-$PORT.conf
		sed -i "s/port 7000/port $PORT/" "./$PORT/redis-$PORT.conf"
		sed -i "s/dbfilename dump-7000.rdb/dbfilename dump-$PORT.rdb/" "./$PORT/redis-$PORT.conf"
		sed -i "s/cluster-config-file nodes-7000.conf/cluster-config-file nodes-$PORT.conf/" "./$PORT/redis-$PORT.conf"
		sed -i "s/appendfilename appendonly-7000.aof/appendfilename appendonly-$PORT.aof/" "./$PORT/redis-$PORT.conf"
		sed -i "s/dbfilename dump-7000.rdb/dbfilename dump-$PORT.rdb/" "./$PORT/redis-$PORT.conf"
		sed -i "s/logfile ''/logfile \/var\/log\/redis\/cluster\/redis-$PORT.log/" "./$PORT/redis-$PORT.conf"
		sed -i "s/pidfile ''/pidfile \/var\/run\/redis-$PORT.pid/" "./$PORT/redis-$PORT.conf"
        # 允许远程连接配置
        if [ "$2" == "remote" ]
        then
            sed -i "s/bind 127.0.0.1/# bind 127.0.0.1/" "./$PORT/redis-$PORT.conf"
            sed -i "s/protected-mode yes/protected-mode no/" "./$PORT/redis-$PORT.conf"
        fi
        PORT=$((PORT+1))
    done
    exit 0
fi

if [ "$1" == "open" ]
then
	while [ $((PORT < ENDPORT)) != "0" ]; do

        echo "Starting $PORT"
		redis-server "./$PORT/redis-$PORT.conf"
		PORT=$((PORT+1))
    done
    exit 0
fi

if [ "$1" == "close" ]
then
	while [ $((PORT < ENDPORT)) != "0" ]; do
        echo "close $PORT"
		redis-cli -p "$PORT" shutdown nosave
		PORT=$((PORT+1))
    done
    exit 0
fi

if [ "$1" == "build" ]
then
	HOSTS=""
    HOST="127.0.0.1"
    
# 对指定IP进行配置集群
    if [ -n "$2" ]
    then
        HOST="$2"
    fi
    
    while [ $((PORT < ENDPORT)) != "0" ]; do
        HOSTS="$HOSTS $HOST:$PORT"
		PORT=$((PORT+1))
    done
    redis-cli --cluster create $HOSTS --cluster-replicas 1
    exit 0
fi

if [ "$1" == "clean" ]
then
	# 移除集群里的快照数据
    cd /usr/local/etc/redis/cluster_data
    rm appendonly-*.aof
    rm dump-*.rdb
    rm nodes-*.conf
    # 移除相关日志
    cd /var/log/redis/cluster
    rm redis-*.log
    exit 0
fi

echo "Usage: $0 [start|open|build|close|clean]"

