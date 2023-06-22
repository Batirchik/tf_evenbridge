
module "lambda_function_request" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "lambda-request-2"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = "./src/lambda-request"

  attach_policy_statements = true
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