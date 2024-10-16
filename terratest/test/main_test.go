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
	httpdState, err := strconv.ParseBool(terraform.Output(t, opts, "httpd_state"))
    databasesState, err := strconv.ParseBool(terraform.Output(t, opts, "db_state"))
	assert.True(t, httpdState)
    assert.True(t, databasesState)
    // Second check. We expect that tfoutput will return 'true' as proof that CIDRs for VPC and subnets are correct
    cidrs, err := strconv.ParseBool(terraform.Output(t, opts, "cidr"))
    assert.True(t, cidrs)
    //
	// Third check. We expect that tfoutput will return 'false' as proof that there are neither autoassigned public IPs on db instances
	dbIps, err := strconv.ParseBool(terraform.Output(t, opts, "db_public_access"))
	assert.False(t, dbIps)
	//
    if err != nil {
        t.Fatalf("Failed to parse bool: %v", err)
    }
}
