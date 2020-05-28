# Redis编译安装流程

## 下载

wget http://download.redis.io/releases/redis-5.0.8.tar.gz

## 解压

tar -zxvf redis-5.0.8.tar.gz

## 编译与安装

- cd redis-5.0.8
- make && make PREFIX=/usr/local/bin/redis install (指定在`/usr/local/bin/redis`路径安装)
- cp -ri /usr/local/bin/redis/bin/. /usr/local/bin
- rm -rf /usr/local/bin/redis

##  复制配置文件

- `mkdir /etc/redis`
- `cp redis.conf /etc/redis/`

