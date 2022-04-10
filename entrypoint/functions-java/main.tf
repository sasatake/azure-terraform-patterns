module "functions_java" {
  source = "../../modules/functions-java/"
  region = var.main_region
  prefix = var.admin_user_name
}
