# Compose sample web application

基于docker-compose 与 Dockerfile 组合编译示例

## Go server with a MySQL database

- 在config文件夹放置`db_password.txt`文件 作为MySQL初始密码

```
secrets:
  db-password:
    file: config/db_password.txt
```

### compile local backend file

```
CGO_ENABLED=0 go build -o server main.go
```

### Deploy with docker-compose

```
docker-compose up -d 编译全部服务

docker-compose up -d db 单独编译MySQL服务

docker-compose up -d backend 单独编译后端golang服务

```

## Expected result

```
$ curl localhost:8000
["Blog post #0","Blog post #1","Blog post #2","Blog post #3","Blog post #4"]
```

Stop and remove the containers
```
$ docker-compose down
```
