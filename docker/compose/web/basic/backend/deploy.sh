CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server main.go

cp .env ../builder
mv server ../builder
