

##login 
Connect-AzureRmAccount -Environment AzureChinaCloud

Select-AzureRmSubscription -Subscription ' '

## Connect-AzAccount -Environment AzureChinaCloud
## Select-AzSubscription -Subscription 'your subscription id'


az login
az account set --subscription "your subscription id"
##deploy
$projectName = Read-Host -Prompt "Enter a project name (limited to eight characters) that is used to generate Azure resource names"
$location = Read-Host -Prompt "Enter the location (for example, chinaeast)"
$adminUsername = Read-Host -Prompt "Enter the administrator username for the virtual machine"
$adminPassword = Read-Host -Prompt "Enter the administrator password for the virtual machine" -AsSecureString
$dnsPrefix = Read-Host -Prompt "Enter the unique DNS Name for the Public IP used to access the virtual machine"

$resourceGroupName = "${projectName}rg"
#$templateUri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-recovery-services-create-vm-and-configure-backup/azuredeploy.json"
$templateUri =".\vmbackup.json"

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri -projectName $projectName -adminUsername $adminUsername -adminPassword $adminPassword -dnsLabelPrefix $dnsPrefix


az group create --name $resourceGroupName --location $location
az deployment group create --name $projectName  --resource-group $resourceGroupName --template-file $templateUri #--adminUsername $adminUsername --adminPassword $adminPassword --dnsLabelPrefix $dnsPrefix


#2020-11-11

New-AzResourceGroup -Name sfnetworkingexistingvnet -Location chinanorth
New-AzResourceGroupDeployment -Name deployment -ResourceGroupName sfnetworkingexistingvnet -TemplateFile C:\SFSamples\Final\template\_existingvnet.json


az login
az account set --subscription "your subscription id"

az group create --name sfnetworkingexistingvnet --location chinanorth
az deployment group create --name deployment  --resource-group sfnetworkingexistingvnet --template-file .\exsitvnet.json



//2020-11-26
az deployment group create --name deployment  --resource-group vanke-rg --template-file .\exsitvnet.json

