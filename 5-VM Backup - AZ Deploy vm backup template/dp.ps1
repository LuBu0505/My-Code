##login 
Connect-AzureRmAccount -Environment AzureChinaCloud

Select-AzureRmSubscription -Subscription 'subscription name'

## Connect-AzAccount -Environment AzureChinaCloud
## Select-AzSubscription -Subscription 'subscription id'


az login

##deploy
$projectName = Read-Host -Prompt "Enter a project name (limited to eight characters) that is used to generate Azure resource names"
$location = Read-Host -Prompt "Enter the location (for example, chinaeast)"
$adminUsername = Read-Host -Prompt "Enter the administrator username for the virtual machine"
$adminPassword = Read-Host -Prompt "Enter the administrator password for the virtual machine" -AsSecureString
$dnsPrefix = Read-Host -Prompt "Enter the unique DNS Name for the Public IP used to access the virtual machine"

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri -projectName $projectName -adminUsername $adminUsername -adminPassword $adminPassword -dnsLabelPrefix $dnsPrefix




$resourceGroupName = "vmbackup-rg"
#$templateUri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-recovery-services-create-vm-and-configure-backup/azuredeploy.json"
$templateUri =".\vmbackup.json"
$location = "chinaeast"
$projectName = "lbtvm01"


az group create --name $resourceGroupName --location $location
az deployment group create --name $projectName  --resource-group $resourceGroupName --template-file $templateUri --debug



### other

Install-Module -Name Az -AllowClobber -Scope CurrentUser


### Use REST API to get the resource List 

GET https://management.azure.com/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectableItems?api-version=2016-12-01


https://management.chinacloudapi.cn/subscriptions/subscription id/resourceGroups/vmtest01rg/providers/Microsoft.RecoveryServices/vaults/lbtvm01-vault/backupUsageSummaries?%24filter=type%20eq%20%27BackupProtectedItemCountSummary%27&api-version=2017-07-01

https://management.chinacloudapi.cn/subscriptions/subscription id/resourceGroups/vmtest01rg/providers/Microsoft.RecoveryServices/vaults/lbtvm01-vault/backupProtectableItems?api-version=2016-12-01


GET https://management.azure.com/Subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/SwaggerTestRg/providers/Microsoft.RecoveryServices/vaults/NetSDKTestRsVault/backupProtectableItems?api-version=2016-12-01&$filter=backupManagementType eq 'AzureIaasVM'


https://management.chinacloudapi.cn/subscriptions/subscription id/resourceGroups/vmbackup-rg/providers/Microsoft.RecoveryServices/vaults/lbtvm01-vault/backupUsageSummaries?%24filter=type%20eq%20%27BackupProtectedItemCountSummary%27&api-version=2017-07-01