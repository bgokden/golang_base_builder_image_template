// +build tools

package main

import (
    _ "github.com/golang/protobuf/protoc-gen-go"
    _ "github.com/golangci/golangci-lint/cmd/golangci-lint"
    _ "github.com/spf13/cobra/cobra"
    _ "golang.org/x/lint/golint"
    _ "golang.org/x/perf/cmd/benchstat"
    _ "golang.org/x/tools/cmd/stringer"
)

