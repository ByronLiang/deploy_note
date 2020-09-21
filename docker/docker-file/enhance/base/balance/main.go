package main

import (
    "fmt"
    "balance/app"
    "flag"
)

var (
    factory *app.BalanceFactory
    port, len int
)

func init()  {
    factory = app.NewBalanceFactory()
    factory.AddContainer("robin", app.NewRoundRobinBalance(0))
    flag.IntVar(&port, "port", 8080, "set port")
    flag.IntVar(&len, "len", 4, "set init data length")
}

func main()  {
    flag.Parse()
    data := app.InitBalanceData(len, port)
    for _, res := range data {
        fmt.Println("origin: ", res.String())
    }
    i := 3
    for i > 0 {
        ins, err := factory.DoBalance("robin", data)
        if err != nil {
            fmt.Println(err.Error())
        } else {
            fmt.Println(ins.String())
        }
        i--
    }
}
