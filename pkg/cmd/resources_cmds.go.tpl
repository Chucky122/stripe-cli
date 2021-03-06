// This file is generated; DO NOT EDIT.

package cmd

import (
	"net/http"

	"github.com/spf13/cobra"

	"github.com/stripe/stripe-cli/pkg/cmd/resource"
)

func addAllResourcesCmds(rootCmd *cobra.Command) {
	// Namespace commands
	_ = resource.NewNamespaceCmd(rootCmd, ""){{ range $nsName, $_ := .Namespaces }}{{ if ne $nsName "" }}
	ns{{ $nsName | ToCamel }}Cmd := resource.NewNamespaceCmd(rootCmd, "{{ $nsName }}"){{ end }}{{ end }}

	// Resource commands{{ range $nsName, $nsData := .Namespaces }}{{ range $resName, $_ := $nsData.Resources }}
	r{{ (printf "%s_%s" $nsName $resName) | ToCamel }}Cmd := resource.NewResourceCmd({{ if ne $nsName "" }}ns{{ $nsName | ToCamel }}Cmd.Cmd{{ else }}rootCmd{{ end }}, "{{ $resName }}"){{ end }}
	{{ end }}
	// Operation commands{{ range $nsName, $nsData := .Namespaces }}{{ range $resName, $resData := $nsData.Resources }}{{ range $opName, $opData := $resData.Operations }}
	resource.NewOperationCmd(r{{ (printf "%s_%s" $nsName $resName) | ToCamel }}Cmd.Cmd, "{{ $opName }}", "{{ $opData.Path }}", http.Method{{ $opData.HTTPVerb | ToCamel }}, &Config){{ end }}
	{{ end }}{{ end }}}
