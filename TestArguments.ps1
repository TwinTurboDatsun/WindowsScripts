# Pass argument to PS script
$System = $args[0]

Send-Mailmessage -to  lumd@ochin.org -Subject "[CitrixManagement] Maintenance mode OFF for server $System" -body "Called from scheduled task script C:\Automate\Scripts\PRDOBINDEX003_MaintenanceMode-ON.ps1

" -SmtpServer esyrelay.community-health.org -From pdxrds2@ochin.org