[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $StorageAccountName,

    [Parameter(Mandatory)]
    [string]
    $ResourceGroup,

    [Parameter(Mandatory)]
    [ValidateSet("Dev", "Test", "Prod")]
    [string]
    $Environment
)

# Define the hash table to store properties about the storage account
$stgAcctArgs = @{
    "AccountName" = $StorageAccountName
    "ResourceGroupName" = $ResourceGroup
    "Location" = $null
    "SkuName" = $null
}

# Update properties of the hash table based on the environment
# Prod condition adds more key/value pairs to the hash table
switch ($Environment) {
    "Dev" { 
        $stgAcctArgs.AccountName += "dev"
        $stgAcctArgs.Location = "westus"
        $stgAcctArgs.SkuName = "Standard_LRS"
        break
    }
    
    "Test" { 
        $stgAcctArgs.AccountName += "test"
        $stgAcctArgs.Location = "eastus"
        $stgAcctArgs.SkuName = "Standard_LRS"
        break
    }

    "Prod" { 
        $stgAcctArgs.AccountName += "prod"
        $stgAcctArgs.Location = "southcentralus"
        $stgAcctArgs.SkuName = "Premium_LRS"
        $stgAcctArgs.EnableHttpsTrafficOnly = $true
        $stgAcctArgs.MinimumTlsVersion = "TLS1_2"
        break
    }
}

# Create the storage account, passing the splatted hash table
New-AzStorageAccount @stgAcctArgs