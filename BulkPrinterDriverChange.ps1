# BulkPrinterChange.PS1
# 2/1/2019 Tyler Applebaum and Dave Lum
# Use this script to make driver changes to multiple printers at one time

$Printers = Import-CSV C:\Automate\Scripts\SA60Printers.csv

# Sample content of .CSV file:

# EPIC_ID,Print_Server,Printer_Name,Tray_Number,Comment,Location
# 2010003,mchdps,mchdmcyptr17,T1,mchdps,McCoy Building Workroom - 360
# 2010004,mchdps,mchdmcyptr17,T2,mchdps,McCoy Building Workroom - 360

# *** NOTE: If exporting from Webtools, use the "print queue" column as the "printer_name" field ***
# *** because the Webtools export includes the tray identifier in its native "printer" column    ***


# Limit $driver to one of these options

# "HP LaserJet 4100 Series PCL6"
# "HP Universal Printing PCL 5 (v5.7.0)"
# "Kyocera TASKalfa 7551ci"
# "Sharp MX-3500N"
# "Xerox Global Print Driver PCL"

$Driver = "Sharp MX-3500N"

ForEach ($Printer in $Printers) {
	C:\Printer_Build\Remote.ps1 -PrinterName $Printer.EPIC_ID -PrintServerName $Printer.Print_Server -QueueName $Printer.Printer_Name -DriverName $Driver -Tray $Printer.Tray_Number -Comment $Printer.Comment -Location $Printer.Location
}