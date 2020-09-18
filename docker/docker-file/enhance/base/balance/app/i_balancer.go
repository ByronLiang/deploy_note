package app

type Balance interface {
    DoBalance(ins []*Instance) (*Instance, error)
}
