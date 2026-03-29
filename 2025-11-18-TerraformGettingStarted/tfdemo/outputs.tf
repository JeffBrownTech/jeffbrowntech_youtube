output "integer" {
  value = random_integer.integer.result
}

output "project_name" {
  value = module.project_hail_mary.project_name
}

output "project_id" {
  value = module.project_hail_mary.project_id
}

output "project_port" {
  value = module.project_hail_mary.port
}

output "config_file_path" {
  value = module.project_hail_mary.config_file_path
}