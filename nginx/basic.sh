#!/bin/bash

CURRENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

echo $CURRENT_DIR

read -r -p "请输入项目名：" project

read -r -p "请输入站点域名（多个域名用空格隔开）：" domains

read -r -p "请输入项目路径：" project_dir

echo "域名列表：${domains}"
echo "项目名：${project}"
echo "项目目录：${project_dir}"

read -r -p "是否确认？ [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        ;;
    *)
        echo "用户取消"
        exit 1
        ;;
esac

cat ${CURRENT_DIR}/templates/basic.tpl |
    sed "s|{{domains}}|${domains}|g" |
    sed "s|{{project}}|${project}|g" |
    sed "s|{{project_dir}}|${project_dir}|g" > /etc/nginx/sites-available/${project}.conf

ln -sf /etc/nginx/sites-available/${project}.conf /etc/nginx/sites-enabled/${project}.conf
echo "配置文件创建成功"

nginx -t

service nginx restart
