package main

import (
	"github.com/xfyun/lb/daemon"
	_ "net/http/pprof"
)

func main() {
	daemon.Version()
	if err := daemon.RunServer(); err != nil {
		daemon.Std.Println("error running server:", err)
		return
	}
}
