terraform {
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
    }
  }
}

locals {
  organization_name = "qeuzjiq"
  account_name      = "oza27213"
  private_key_path  = "snowflake_tf_key_final.pem"
}

provider "snowflake" {
  organization_name = local.organization_name
  account_name      = local.account_name
  user              = "TERRAFORM_SVC"
  role              = "SYSADMIN"
  authenticator     = "SNOWFLAKE_JWT"
  # La línea private_key se ha eliminado.
  # El proveedor la encontrará automáticamente en la variable de entorno.
}

resource "snowflake_database" "tf_db" {
  name         = "TF_DEMO_DB"
  is_transient = false
}

resource "snowflake_warehouse" "tf_warehouse" {
  name                      = "TF_DEMO_WH"
  warehouse_type            = "STANDARD"
  warehouse_size            = "XSMALL"
  max_cluster_count         = 1
  min_cluster_count         = 1
  auto_suspend              = 60
  auto_resume               = true
  enable_query_acceleration = false
  initially_suspended       = true
}