@echo off
cd /D "%~dp0"
title Windows Config Saver

set > Environment.txt

netsh advfirewall export "Firewall.wfw"

mkdir Reg
reg export HKCR Reg\HKCR.reg /y
reg export HKCU Reg\HKCU.reg /y
reg export HKLM Reg\HKLM.reg /y
reg export HKU Reg\HKU.reg /y
reg export HKCC Reg\HKCC.reg /y

powershell -command "Get-Service | Select-Object -Property * | Export-CSV -Path Services.csv"
powershell -command "Get-Service | Format-List -Property * | Out-File -FilePath Services.txt"

powershell -command "Get-CimInstance -ClassName SoftwareLicensingService | Format-List -Property * | Out-File -FilePath License.txt"

pause
