################
# Step Function
################

module "step_function" {
  source  = "terraform-aws-modules/step-functions/aws"
  version = "~> 2.0"

  name = "processor"

  definition = jsonencode(yamldecode(templatefile("sfn.asl.json", {})))

  trusted_entities = ["events.amazonaws.com"]

  service_integrations = {
    stepfunction = {
      stepfunction = ["*"]
    }

    eventbridge = {
      eventbridge = ["*"]
    }
  }
}
