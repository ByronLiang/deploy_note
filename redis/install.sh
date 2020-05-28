#!/bin/bash

wget http://download.redis.io/releases/redis-5.0.8.tar.gz
tar -zxvf redis-5.0.8.tar.gz
cd redis-5.0.8
make && make PREFIX=/usr/local/bin/redis install
# cp -ri /usr/local/bin/redis/bin/. /usr/local/bin
# rm -rf /usr/local/bin/redis
# mkdir /etc/redis
# cp redis.conf /etc/redis/
