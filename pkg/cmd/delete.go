package cmd

import (
	"fmt"
	"net/http"

	"github.com/spf13/cobra"

	"github.com/stripe/stripe-cli/pkg/requests"
	"github.com/stripe/stripe-cli/pkg/validators"
)

type deleteCmd struct {
	reqs requests.Base
}

func newDeleteCmd() *deleteCmd {
	gc := &deleteCmd{}

	gc.reqs.Method = http.MethodDelete
	gc.reqs.Profile = &Config.Profile
	gc.reqs.Cmd = &cobra.Command{
		Use:   "delete <path>",
		Args:  validators.ExactArgs(1),
		Short: "Make a DELETE request to the Stripe API",
		Long: fmt.Sprintf(`%s

Make DELETE requests to the Stripe API using your test mode key.

You can only delete data in test mode, the delete command does not work for
live mode.

For a full list of supported paths, see the API reference:
https://stripe.com/docs/api

To delete a charge:

  $ stripe delete /customers/cus_FROPkgsHVRRspg`,
			getBanner(),
		),
		RunE: gc.reqs.RunRequestsCmd,
	}

	gc.reqs.InitFlags(true)

	return gc
}
