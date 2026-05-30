# ==========================================
# VARIABLES
# ==========================================
$ResourceGroup = "SplunkSOC-Lab-RG"
$Location      = "uksouth" 
$EHNamespace   = "SplunkHubNamespace3957" 
$EventHubName  = "splunk-syslog-ingest"
$ClientId      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# ==========================================
# CREATE EVENT HUB PIPELINE
# ==========================================
Write-Host "Creating Event Hubs Namespace [$EHNamespace]..." -ForegroundColor Cyan
$namespace = New-AzEventHubNamespace -ResourceGroupName $ResourceGroup -Name $EHNamespace -Location $Location -SkuName Standard

Write-Host "Creating Event Hub [$EventHubName]..." -ForegroundColor Cyan
$eventhub = New-AzEventHub -ResourceGroupName $ResourceGroup -NamespaceName $EHNamespace -Name $EventHubName

# ==========================================
# LINK EXISTING PERMISSIONS
# ==========================================
Write-Host "Retrieving existing Service Principal..." -ForegroundColor Cyan
$sp = Get-AzADServicePrincipal -ApplicationId $ClientId

Write-Host "Granting Splunk App 'Azure Event Hubs Data Receiver' access..." -ForegroundColor Cyan
New-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionName "Azure Event Hubs Data Receiver" -Scope $namespace.Id

# ==========================================
# FINAL CLEAN OUTPUT
# ==========================================
Write-Host "`n=========================================================" -ForegroundColor Green
Write-Host "AZURE PIPELINE RECOVERED AND DEPLOYED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "Copy these exact values into your Splunk MSCS Add-on UI:" -ForegroundColor Yellow
Write-Host "---------------------------------------------------------" -ForegroundColor Yellow
Write-Host "Tenant ID: $((Get-AzContext).Tenant.Id)"
Write-Host "Client ID: $ClientId"
Write-Host "Secret:    xxxxx~xxxxxxxxxx~xxxx-xxxxxxxxxxxxxxxxx"
Write-Host "Event Hub Namespace: $EHNamespace"
Write-Host "Event Hub Name:      $EventHubName"
Write-Host "=========================================================" -ForegroundColor Green

