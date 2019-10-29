﻿Import-Module ActiveDirectory

# Set the number of days since last logon
$DaysInactive = 365
$InactiveDate = (Get-Date).Adddays(-($DaysInactive))
$ADlocation = “OU=Disabled Users,dc=acuereqol,dc=local”
  
#-------------------------------
# FIND INACTIVE USERS
#-------------------------------
# Below are four options to find inactive users. Select the one that is most appropriate for your requirements:

# Get AD Users that haven't logged on in xx days
# $Users = Get-ADUser -Filter { LastLogonDate -lt $InactiveDate -and Enabled -eq $true } -Properties LastLogonDate | Select-Object @{ Name="Username"; Expression={$_.SamAccountName} }, Name, LastLogonDate, DistinguishedName

# Get AD Users that haven't logged on in xx days and are not Service Accounts
$Users = Get-ADUser -SearchBase $ADlocation -Filter { LastLogonDate -lt $InactiveDate -and Enabled -eq $true -and SamAccountName -notlike "*svc*" } -Properties LastLogonDate | Select-Object @{ Name="Username"; Expression={$_.SamAccountName} }, Name, LastLogonDate, DistinguishedName

# Get AD Users that have never logged on
# $Users = Get-ADUser -Filter { LastLogonDate -notlike "*" -and Enabled -eq $true } -Properties LastLogonDate | Select-Object @{ Name="Username"; Expression={$_.SamAccountName} }, Name, LastLogonDate, DistinguishedName

# Automated way (includes never logged on users)
# $Users = Search-ADAccount -AccountInactive -DateTime $InactiveDate -UsersOnly | Select-Object @{ Name="Username"; Expression={$_.SamAccountName} }, Name, LastLogonDate, DistinguishedName

#-------------------------------
# REPORTING
#-------------------------------
# Export results to CSV
$Users | Export-Csv C:\Automate\InactiveUsers.csv -NoTypeInformation

#-------------------------------
# INACTIVE USER MANAGEMENT
#-------------------------------
# Below are two options to manage the inactive users that have been found. Either disable them, or delete them. Select the option that is most appropriate for your requirements:

# Disable Inactive Users - UnRem lines 36-40
 ForEach ($Item in $Users){
  $DistName = $Item.DistinguishedName
  Disable-ADAccount -Identity $DistName
  Get-ADUser -Filter { DistinguishedName -eq $DistName } | Select-Object @{ Name="Username"; Expression={$_.SamAccountName} }, Name, Enabled
}

# Delete Inactive Users - UnRem line 43-46
# ForEach ($Item in $Users){
#  Remove-ADUser -Identity $Item.DistinguishedName -Confirm:$false
#  Write-Output "$($Item.Username) - Deleted"
#}