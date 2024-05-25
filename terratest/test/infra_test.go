package infra_test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func GetFirstThreeOctets(fullIp string) string {
	ipAddrOctets := strings.Split(fullIp, ".")
	return ipAddrOctets[0] + "." + ipAddrOctets[1] + "." + ipAddrOctets[2]
}

func TestInfra(t *testing.T) {

	// awsRegion := "eu-north-1"

	// Expected network values
	// expectedVpcCidr := "200.100.0.0/16"
	// expectedHttpSubnetCidr := "200.100.1.0/24"
	// expectedDbSubnetCidr := "200.100.2.0/24"

	// // Expected EC2 values
	// expectedInstanceType := "t3.micro"
	// expectedInstanceNames := []string{
	// 	"test-instance-http-1",
	// 	"test-instance-http-2",
	// }

	// Expected DB values
	// expectedDbInstanceType := "t3.micro"
	// expectedDbInstanceNames := []string{
	// 	"test-instance-db-1",
	// 	"test-instance-db-2",
	// 	"test-instance-db-3",
	// }

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:    "../terragrunt/infra-module",
		TerraformBinary: "terragrunt",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Extracting test data from terragrunt apply
	instanceData := terraform.OutputMap(t, terraformOptions, "http_ip")
	dbInstanceData := terraform.OutputMap(t, terraformOptions, "db_ip")

	// Tests
	for _, instanceIp := range instanceData {
		assert.Equal(t, "200.100.1", GetFirstThreeOctets(instanceIp))
	}
	for _, dbInstanceIp := range dbInstanceData {
		assert.Equal(t, "200.100.2", GetFirstThreeOctets(dbInstanceIp))
	}
}
