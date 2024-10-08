terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = "1.52.0"
    }

    google = {
      source = "hashicorp/google"
      version = "6.5.0"
    }
  }
}