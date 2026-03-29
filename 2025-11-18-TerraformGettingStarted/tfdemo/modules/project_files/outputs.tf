output "project_name" {
  description = "The generated project name"
  value       = random_pet.project_name.id
}

output "project_id" {
  description = "The unique hex project ID"
  value       = random_id.project_id.hex
}

output "port" {
  description = "The randomly assigned port"
  value       = random_integer.port.result
}

output "config_file_path" {
  description = "Path to the generated config file"
  value       = local_file.project_config.filename
}
