
# ------------------------ RETRIEVE USER INFORMATION ------------------------
# To retrieve a property that is not a member of the default 10 properties, you must select it by using the –property parameter. 
# The reason that Get-ADUser does not automatically return all properties and their associated values is because of performance reasons on large networks—there is 
# no reason to return a large dataset when a small dataset will perfectly suffice

$Datetime01 = Get-Date -DisplayHint datetime -Format MM-dd-yy-HHmmss
# Write-Output $Datetime01

# Get input and search only under a specific OU (user imput), get last logon date as well
Function Input1 {
$ServiceArea = Read-Host "Service Area"
$EmailAddr = Read-Host "Report email destination"
Get-ADUser -Filter * -Searchbase "OU=SA$ServiceArea,OU=Service Area Accounts,dc=community-health,dc=org" -Properties Displayname, LastLogonDate | sort-object displayname | ft displayname, LastLogonDate, enabled -autosize | Out-File C:\Automate\Reports\SA$ServiceArea"DataDomainUserReport"$Datetime01".txt"
Send-MailMessage -to $EmailAddr -Subject "User Report for SA$ServiceArea" -Body "Remote acces user report as requested, see attached." -SMTPSERVER mailhost.community-health.org -From DCUTILS01@ochin.org -Attachments C:\Automate\Reports\SA$ServiceArea"DataDomainUserReport"$Datetime01".txt"
}

# call external command to create file, then use PS to distribute
Function External-OldCMP {
& C:\Automate\Scripts\oldcmp.exe -b OU="Service Area Accounts",DC="community-health",DC="org" -users -llts -age 60 -report -format csv -file C:\Automate\Reports\SA$ServiceArea"DataDomainUserReport"$Datetime01".txt"
Send-MailMessage -to $EmailAddr -Subject "User Report for SA$ServiceArea" -Body "As requested" -SMTPSERVER esyrelay.community-health.org -From DCUTILS01@ochin.org -Attachments C:\Automate\Reports\SA$ServiceArea"DataDomainUserReport"$Datetime01".txt"
}

Function LastDate {
$logonDate = New-Object System.DateTime(2016, 1, 1)
 Get-ADUser -f {lastlogon -gt $logonDate} -Properties LastLogondate  | Ft Name, sAMAccountname, lastLogondate -autosize
}

# ----------------------- GUI INPUT -----------------------
# Variables set: $ServiceArea, $EmailAddr
# -NoNewLine allows the variable from the GUI to be placed in the same line as other variables/information
#
Function InputTest1 {
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
$Servicearea =[Microsoft.VisualBasic.Interaction]::InputBox("Service area ID","Service Area")
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic") 
$Emailaddr = [Microsoft.VisualBasic.Interaction]::InputBox("Email address to send report","Email recipient")

Write-host -NoNewLine "SA$ServiceArea"  
}

Function DisableOld{
# --------------------  Disable inactive user accounts --------------------
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
$NumOfDays =[Microsoft.VisualBasic.Interaction]::InputBox("Days account ihas bene inactive","Employee name")
 # Search-ADAccount -SearchBase "OU=SA131,OU=Service Area Accounts,DC=Community-health,DC=org" -AccountInactive -TimeSpan ([timespan]10d) -UsersOnly | Set-ADUser -Enabled $false -WhatIf
 Search-ADAccount -SearchBase "OU=SA131,OU=Service Area Accounts,DC=Community-health,DC=org" -AccountInactive -TimeSpan $NumOfDays -UsersOnly | Set-ADUser -Enabled $false -WhatIf
}


Function SAUserSearch {
. InputTest1
Get-ADUser -Filter * -Searchbase "OU=SA$ServiceArea,OU=Service Area Accounts,dc=community-health,dc=org" -Properties Displayname, LastLogonDate | sort-object displayname | ft displayname, LastLogonDate, enabled -autosize | Out-File C:\Automate\Reports\SA$ServiceArea"DataDomainUserReport"$Datetime01".txt"
Send-MailMessage -to $EmailAddr -Subject "User Report for SA$ServiceArea" -Body "Remote acces user report as requested, see attached." -SMTPSERVER esyrelay.community-health.org -From DCUTILS01@ochin.org -Attachments C:\Automate\Reports\SA$ServiceArea"DataDomainUserReport"$Datetime01".txt"
}

. disableold

Function SimpleEmployeeSearchBox{
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
$EmployeeDisplayName =[Microsoft.VisualBasic.Interaction]::InputBox("User name, wildcard use (*) is acceptible","Employee name")
}


. SimpleEmployeeSearchBox


# Get-ADUser -Filter {displayname -like $EmployeeDisplayName} -Searchbase 'OU=OCHIN,dc=community-health,dc=org' -Properties Displayname, LastLogonDate | sort-object displayname | ft displayname, LastLogonDate, enabled -autosize  | Out-File C:\Automate\Reports\"DataDomainUserReport"$Datetime01".txt"
# & notepad C:\Automate\Reports\"DataDomainUserReport"$Datetime01".txt"

# ------------------------- GUI OUTPUT WINDOW samples -------------------------
# [System.Windows.MessageBox]::Show($ShowName,'Results')

#Get-ADUser -Filter * -Searchbase "OU=SA$ServiceArea,OU=Service Area Accounts,dc=community-health,dc=org" -Properties Displayname, LastLogonDate | sort-object displayname | ft displayname, LastLogonDate, enabled -autosize | Out-File C:\Automate\Reports\SA$ServiceArea"DataDomainUserReport"$Datetime01".txt"
#Send-MailMessage -to $EmailAddr -Subject "User Report for SA$ServiceArea" -Body "Remote acces user report as requested, see attached." -SMTPSERVER mailhost.community-health.org -From DCUTILS01@ochin.org -Attachments C:\Automate\Reports\SA$ServiceArea"DataDomainUserReport"$Datetime01".txt"
