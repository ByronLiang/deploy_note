CGO_ENABLED=0 go build -o server main.go

cp .env ../builder
mv server ../builder
