FROM golang:1.14 as builder

# 环境变量设置

ENV GOPROXY=https://goproxy.cn,https://goproxy.io,direct \
    GO111MODULE=on \
    CGO_ENABLED=1

# 跳转指定目录路径

WORKDIR /go/src/balance

# 源文件复制操作

COPY /balance /go/src/balance/

# 编译

RUN go build

# 执行打包文件 docker run --rm 镜像名

ENTRYPOINT ["./balance"]

# ENTRYPOINT ["go", "run", "main.go"]

# 制作小体积镜像文件 只将编译后文件放进镜像里

FROM scratch

COPY --from=builder /go/src/balance/balance /

ENTRYPOINT ["./balance"]
