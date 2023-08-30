module "lambda_api_gateway" {
  source = "./terraform-aws-lambda-api-gateway"

  # tags
  project    = "todo-mvc"
  service    = "acme-corp"
  owner      = "Roadrunner"
  costcenter = "acme-abc"

  # vpc
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  nat_cidr             = ["10.0.5.0/24", "10.0.6.0/24"]
  igw_cidr             = "10.0.8.0/24"
  azs                  = ["eu-central-1a", "eu-central-1b"]

  # lambda
  lambda_zip_path      = "flask-app.zip"
  lambda_handler       = "run-lambda.http_server"
  lambda_runtime       = "python3.11"
  lambda_function_name = "HttpWebserver"

  # API gateway
  region     = "eu-central-1"
  account_id = "699663434651"
}