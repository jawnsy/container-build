package main

import (
	"github.com/dgrijalva/jwt-go"
	"github.com/docker/cli/cli"
	"k8s.io/kubernetes/staging/src/k8s.io/client-go/kubernetes"
)

func main() {
	_ = cli.StatusError{}

	var _ kubernetes.Interface
	var _ jwt.Claims
}
