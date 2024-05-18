package test

import (
    "testing"
	"strconv"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerragrunt(t *testing.T) {
    t.Parallel()

    opts := &terraform.Options{
        TerraformDir: "../terragrunt/infra-module",
        TerraformBinary : "terragrunt",
    }

    defer terraform.TgDestroyAll(t, opts)
    terraform.TgApplyAll(t, opts)
	// First check. We expect that tfoutput will return 'true' as proof that instances' state is 'running'
	instancesState, err := strconv.ParseBool(terraform.Output(t, opts, "instances_state"))
	if err != nil {
        t.Fatalf("Failed to parse bool: %v", err)
    }
	assert.True(t, instancesState)
	// Third check. We expect that tfoutput will return 'false' as proof that there are any autoassigned public IPs on db instances
	dbIps, err := strconv.ParseBool(terraform.Output(t, opts, "db_public_access"))
	if err != nil {
        t.Fatalf("Failed to parse bool: %v", err)
    }
	assert.True(t, dbIps)
	//
}
