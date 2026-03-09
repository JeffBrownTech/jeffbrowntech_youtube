# List all resources tracked in state file
```tf
terraform state list
```

# Show full state file
```tf
terraform show
```

# Show full state file in JSON format
```tf
terraform state pull
```

# Show detailed attributes of a specific resource
```tf
terraform state show <terraform resource name>
```

# Move or Rename Resources in State
Use when you refactor the code but don't want to destroy or recreate the resource

## Classic CLI Move
```tf
terraform state mv local_file.example local_file.renamed
```

## ```moved``` Block (Terraform 1.1+)
```tf
moved {
  from = local_file.original
  to   = local_file.moved
}
```

# Remove a Resource from State File
Remove a resource from state file but do not remove or delete the actual resource  
Make terraform "forget" the resource without deleting it  
⚠️ The file stays but Terraform will try to recreate it on the next ```apply``` unless removed from the ```.tf``` configuration

## Classic CLI Remove
```tf
terraform state rm <terraform resource name>
```

## ```removed``` Block (Terraform 1.7+)
```tf
removed {
  from = local_file.example

  lifecycle {
    destroy = false
  }
}
```

# Import Existing Resource
Import an existing resource into your state file. First, write the Terraform code to match the resource, then perform the import.

## Classic CLI Import
```tf
terraform import <terraform resource name> <resource address>
```

## ```import``` Block (Terraform 1.5+)
Use code in your configuration to import the resource  
❗Note: Not all providers support import

```tf
resource "random_string" "imported" {
  length  = 4
}

import {
  to = random_string.imported
  id = "abcd"
}
```

⭐ Bonus: pair with ```terraform plan -generate-config-out=generated.tf``` to auto-generate the resource block