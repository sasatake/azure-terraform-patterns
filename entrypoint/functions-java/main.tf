module "functions_java" {
  source = "../../modules/functions-java/"
  region = var.region
  prefix = var.prefix
}
