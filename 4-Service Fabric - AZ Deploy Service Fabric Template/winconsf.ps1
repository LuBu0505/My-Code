
#Provide the subscription Id
$subscriptionId = 'your subscription id'

# Certificate variables.
$certpwd="Password#1234" | ConvertTo-SecureString -AsPlainText -Force
$certfolder="C:\LBWorkSpace\Cert\"

# Variables for VM admin.
$adminuser="testadmin"
$adminpwd="Password#1234" | ConvertTo-SecureString -AsPlainText -Force 

# Variables for common values
$clusterloc="chinanorth2"
$clustername = "sfvanketest01"
$groupname="vanke-rg"       
$vmsku = "Standard_D2_v2"
$vaultname = "mysfkv11261056"
$subname="$clustername.$clusterloc.cloudapp.chinacloudapi.cn"

# Set the number of cluster nodes. Possible values: 1, 3-99
$clustersize=3 

# Set the context to the subscription Id where the cluster will be created
# Select-AzSubscription -SubscriptionId $subscriptionId
# Connect-AzAccount -Environment AzureChinaCloud
az cloud set --name AzureChinaCloud
az login
az account set --subscription $subscriptionId


# # Create the Service Fabric cluster.
# New-AzServiceFabricCluster -Name $clustername -ResourceGroupName $groupname -Location $clusterloc `
# -ClusterSize $clustersize -VmUserName $adminuser -VmPassword $adminpwd -CertificateSubjectName $subname `
# -CertificatePassword $certpwd -CertificateOutputFolder $certfolder `
# -OS WindowsServer2016DatacenterwithContainers -VmSku $vmsku -KeyVaultName $vaultname

##Create a new Azure Service Fabric cluster.

az sf cluster create --cluster-name $clustername --resource-group $groupname --location $clusterloc `
 --cluster-size $clustersize --vm-user-name $adminuser --vm-password $adminpwd --certificate-subject-name $subname `
 --certificate-password $certpwd --certificate-output-folder  $certfolder `
 --os WindowsServer2016DatacenterwithContainers --vm-sku $vmsku --vault-name $vaultname --debug



 #WindowsServer2019DatacenterwithContainers

# az sf cluster create --location
#                      --resource-group
#                      [--cert-out-folder]
#                      [--cert-subject-name]
#                      [--certificate-file]
#                      [--certificate-password]
#                      [--cluster-name]
#                      [--cluster-size]
#                      [--os {UbuntuServer1604, WindowsServer1709, WindowsServer1709withContainers, WindowsServer1803withContainers, WindowsServer1809withContainers, WindowsServer2012R2Datacenter, WindowsServer2016Datacenter, WindowsServer2016DatacenterwithContainers, WindowsServer2019Datacenter, WindowsServer2019DatacenterwithContainers}]
#                      [--parameter-file]
#                      [--secret-identifier]
#                      [--subscription]
#                      [--template-file]
#                      [--vault-name]
#                      [--vault-resource-group]
#                      [--vm-password]
#                      [--vm-sku]
#                      [--vm-user-name]