package test

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerraformModule(t *testing.T) {
    t.Parallel()

    opts := &terraform.Options{
        TerraformDir: "../terragrunt/infra-module",
        TerraformBinary : "terragrunt",
    }

    defer terraform.TgDestroyAll(t, opts)
    terraform.TgApplyAll(t, opts)
	// First check. We expect that tfoutput will return 'true' as proof that instances' state is 'running'
	instancesState := terraform.Output(t, opts, "instances_state")
	assert.True(t, instances_state)
	// Third check. We expect that tfoutput will return 'false' as proof that there are any autoassigned public IPs on db instances
	dbIps := terraform.Output(t, opts, "db_public_access")
	assert.False(t, db_public_access)
	//
}
