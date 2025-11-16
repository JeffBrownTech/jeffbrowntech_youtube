# Terraform: Getting Started

## Introduction
- Terraform is an Infrastructure as Code (IaC) tool from HashiCorp.
- It lets you define, provision, and manage infrastructure in a declarative way.
- It supports hundreds of providers (Azure, AWS, Google Cloud, GitHub, etc.).
- Terraform uses .tf configuration files to describe desired infrastructure.
- In this video:
  - Install Terraform on Windows.
  - Create your first Terraform project folder.
  - Add resources to Terraform configuration.
  - Run commands for Terraform workflow.

## Install Terraform
[Hashicorp: Install Terraform](https://developer.hashicorp.com/terraform/install)

Add Terraform binary to system's ```PATH``` so the ```terraform``` command is recognized globally.

| OS          | Method to Add Terraform to PATH                                                                                                 | Typical Path Example                                   |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| **Windows** | Control Panel → System → Advanced System Settings → Environment Variables → Edit `PATH` → Add folder containing `terraform.exe` | `C:\Terraform` or `C:\Program Files\Terraform`         |
| **macOS**   | Add export line to your shell profile (`~/.zshrc` or `~/.bash_profile`)                                                         | `export PATH=$PATH:/usr/local/bin`                     |
| **Linux**   | Add export line to `~/.bashrc` or place binary in a directory already in PATH                                                   | `/usr/local/bin/terraform` or `~/.local/bin/terraform` |

If necessary, restart your shell and run ```terraform -version``` to confirm ```PATH``` configuration works.

## Create Project
- Create a folder ```tfdemo``` with a ```main.tf``` file.
- Add content to ```main.tf```:
  ```terraform
  terraform {
    required_version = ">= 1.0"
  }

  # Placeholder for provider configuration
  provider "local" {}

  # Example resource
  resource "local_file" "example" {
    content  = "Hello Terraform!"
    filename = "${path.module}/hello.txt"
  }
  ```

### Defining resources

A resource block describes one real-world object—such as a file, virtual machine, or storage account—that Terraform should create, update, or destroy.

```terraform
resource "<PROVIDER>_<TYPE>" "<NAME>" {
  # configuration arguments
}
```

Here's the resource defined in the example project:

```terraform
resource "local_file" "example" {
    content  = "Hello Terraform!"
    filename = "${path.module}/hello.txt"
}
```

- ```resource```: keyword declaring the block.
- ```"local_file"```: the type, which combines the provider (```local```) and the specific resource (```file```).
- ```"example"```: a local name used to reference this resource in other parts of the configuration.
- The body defines arguments that control how the resource is created or managed.

The type and local name form a unique resource name of ```local_file.example``` within the Terraform configuration.

Each resource corresponds to an actual object tracked in Terraform’s **state file**, so Terraform can compare the current real-world infrastructure with your configuration and determine what changes to make.

## Terraform Workflow
The Terraform CLI provides several commands for setting up, planning, applying, and deleting resources defined in the Terraform configuration.

| Command             | Purpose                                                              |
| ------------------- | -------------------------------------------------------------------- |
| `terraform init`    | Initializes the working directory and downloads necessary providers. |
| `terraform plan`    | Previews changes Terraform will make.                                |
| `terraform apply`   | Executes the plan and creates infrastructure.                        |
| `terraform destroy` | Removes all resources defined in your configuration.                 |
