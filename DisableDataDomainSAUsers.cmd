@echo off
: 8/10/2016 Dave Lum
: Cleanup script to disable old or unused datacenter user accounts
: Searches only the "Service Area Accounts" OU
: Selects only accounts with a last logon timestamp of 180 days or more
: The "-safety 200" allows the script to only change 200 records at a time (to prevent accidentally selecting all accounts if
: someone edits this file and accidentally sets age to 1 instead of 100 or something)
:
: Requires OLDCMP.EXE from joeware.net to exist in same folder as this batch file
: Expected folder structure 
: C:\Automate\Scripts\
: Calls Powershell script C:\Automate\Scripts\DisableDatadomainUsers.ps1 which emails the file created below (c:\automate\reports\UserReport-"%fullstamp%".htm)

: ---- Create reports folder if it does not already exist ----
if exist C:\Automate\reports\nul goto ReportsFolderExists
C:
cd\
MD automate
CD automate
CD scripts
MD reports
:ReportsFolderExists
: --------------------------------------------------------------

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo datestamp: "%datestamp%"
echo timestamp: "%timestamp%"
echo fullstamp: "%fullstamp%"

oldcmp -b OU="Service Area Accounts",DC="community-health",DC="org" -users -llts -realage -age 160 -disable -forreal -safety 200 -file c:\automate\reports\UserReport-"%fullstamp%".htm > c:\automate\reports\UsersDisabled"%fullstamp%".txt
Powershell.exe -executionpolicy remotesigned -File C:\Automate\Scripts\DisableDatadomainUsers.ps1 c:\automate\reports\UsersDisabled"%fullstamp%".txt

