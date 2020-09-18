package main

import (
    "fmt"
    "balance/app"
)

var factory *app.BalanceFactory

func init()  {
    factory = app.NewBalanceFactory()
    factory.AddContainer("robin", app.NewRoundRobinBalance(0))
}

func main()  {
    data := app.InitBalanceData(4, 8080)
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
