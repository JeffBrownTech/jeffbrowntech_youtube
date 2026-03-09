# Create original resource
# resource "local_file" "original" {
#   filename = "./files/original.txt"
#   content  = "I want to keep this file content."
# }

# Move the created/existing resource to another resource declaration
resource "local_file" "moved" {
  filename = "./files/original.txt"
  content  = "I want to keep this file content."
}

# Move the resource using code
# moved {
#   from = local_file.original
#   to   = local_file.moved
# }


# Remove a resource from state file but don't delete it
# resource "local_file" "dont_destroy" {
#   filename = "./files/dont_destroy.txt"
#   content  = "Forget about me!"
# }

# Remove using code
removed {
  from = local_file.dont_destroy

  lifecycle {
    destroy = false
  }
}

# Import existing resource into code
# resource "random_string" "imported" {
#   length  = 4
# }

import {
  to = random_string.imported
  id = "abcd"
}

resource "random_string" "imported" {
  keepers          = null
  length           = 4
  lower            = true
  min_lower        = 0
  min_numeric      = 0
  min_special      = 0
  min_upper        = 0
  numeric          = true
  override_special = null
  special          = true
  upper            = true
}
