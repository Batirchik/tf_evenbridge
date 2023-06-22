module "lambda_function_response" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "lambda-response"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = "./src/lambda-response"

  attach_policy_statements = true
  publish = true

  allowed_triggers = {
    OneRule = {
      principal  = "events.amazonaws.com"
      source_arn = "arn:aws:events:eu-west-1:${data.aws_caller_identity.current.account_id}:rule/*"
    }
  }

  policy_statements = {
    lambda_invoke = {
      effect    = "Allow",
      actions   = ["lambda:InvokeFunction","lambda:InvokeAsync",],
      resources = ["arn:aws:lambda:eu-west-1:${data.aws_caller_identity.current.account_id}:function:*"]
      resources = ["*"]
    },
    events = {
      effect    = "Allow",
      actions   = ["events:PutEvents"],
      resources = ["arn:aws:events:eu-west-1:${data.aws_caller_identity.current.account_id}:event-bus/*"]
    }
  }
}