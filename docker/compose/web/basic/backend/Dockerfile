FROM golang:1.14 as builder

ENV GOPROXY=https://goproxy.cn,https://goproxy.io,direct \
    GO111MODULE=on \
    CGO_ENABLED=0

WORKDIR /go/src/demo
COPY . .

RUN go build -o server .

FROM scratch

EXPOSE 8000

COPY --from=builder /go/src/demo/server /server

# copy the env config file

COPY --from=builder /go/src/demo/.env /.env

ENTRYPOINT ["./server"]

# CMD ["/server"]
