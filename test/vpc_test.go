package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformVpc(t *testing.T) {
	t.Parallel()

	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/test-fixture",
		Vars: map[string]interface{}{
			"project_name": fmt.Sprintf("t-%s", strings.ToLower(random.UniqueId())),
			"aws_region":   awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	assert.Equal(t, awsRegion, terraform.Output(t, terraformOptions, "region"))
}
