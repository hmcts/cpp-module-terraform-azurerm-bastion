package test

import (
	"testing"
    "github.com/stretchr/testify/assert"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformBastion(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../example",
		VarFiles: []string{"terratest.tfvars"},
		Upgrade: true,
	}

	// Defer the destroy to cleanup all created resources
	defer terraform.Destroy(t, terraformOptions)

	// This will init and apply the resources and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Assert outputs
	id := terraform.Output(t, terraformOptions, "id")
	name := terraform.Output(t, terraformOptions, "name")
	dnsName := terraform.Output(t, terraformOptions, "dns_name")
	ipConfigurations := terraform.OutputListOfObjects(t, terraformOptions, "ip_configurations")
    bastionNameOutput := terraform.Output(t, terraformOptions, "bastion_name")


	assert.NotEmpty(t, id, "id should not be empty")
	assert.Equal(t, bastionNameOutput, name, "name should be equal to the bastion_name output")
	assert.NotEmpty(t, dnsName, "dns_name should not be empty")
	assert.Contains(t, dnsName, name, "dns_name should contain the bastion name")
	assert.NotEmpty(t, ipConfigurations, "ip_configurations should not be empty")
    assert.Len(t, ipConfigurations, 1, "ip_configurations should have one element")
}
