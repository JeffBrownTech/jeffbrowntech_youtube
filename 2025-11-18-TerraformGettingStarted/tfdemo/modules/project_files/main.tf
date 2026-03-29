terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# Generate a random pet name for the project
resource "random_pet" "project_name" {
  length    = 2
  separator = "-"
  prefix    = var.name_prefix
}

# Generate a random ID for a unique identifier
resource "random_id" "project_id" {
  byte_length = 4
}

# Generate a random integer for a port number
resource "random_integer" "port" {
  min = 8000
  max = 9000
}

# Write project config to a local file
resource "local_file" "project_config" {
  filename = "${path.root}/projects/${random_pet.project_name.id}.txt"
  content  = <<-EOT
    Project Name : ${random_pet.project_name.id}
    Project ID   : ${random_id.project_id.hex}
    Environment  : ${var.environment}
    Port         : ${random_integer.port.result}
    Generated At : ${timestamp()}
  EOT
}
