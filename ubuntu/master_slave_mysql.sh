#!/usr/bin/env bash

# 主从MySQl配置

mkdir /var/log/mysql_bin_log

chown -R mysql:mysql /var/log/mysql_bin_log

# setting master MySQL

echo "log-bin=/var/log/mysql_bin_log/mysql-bin
binlog_format=row
server-id = 1
binlog-do-db=
binlog-ignore-db=mysql" >> /etc/mysql/my.cnf

# setting slave MySQL

echo "log-bin=/var/log/mysql_bin_log/mysql-bin
binlog_format=row
server-id = 2
binlog-do-db=
binlog-ignore-db=mysql" >> /etc/mysql/my.cnf
