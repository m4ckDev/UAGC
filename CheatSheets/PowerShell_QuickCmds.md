# PowerShell Quick Commands (CPT201)

## Help + Discovery
- `Get-Command`
- `Get-Help Get-Process -Full`
- `Get-Alias`
- `Get-Member`
- `Get-Command *event*`

## Variables + Output
- `$x = 5`
- `Write-Host "Hello"`
- `"Hello $env:USERNAME"`
- `"{0} {1}" -f "Hello","World"`

## Files + Folders
- `Get-ChildItem -Recurse`
- `Get-Item .\file.txt`
- `Test-Path .\file.txt`
- `New-Item -ItemType Directory -Path .\Output`
- `Copy-Item .\a.txt .\Backup\`
- `Move-Item .\a.txt .\Archive\`
- `Remove-Item .\temp.txt -Force`

## Search Text
- `Select-String -Path .\log.txt -Pattern "error"`
- `Get-Content .\log.txt | Select-String "failed"`

## Processes + Services
- `Get-Process | Sort CPU -Descending | Select -First 10`
- `Stop-Process -Name notepad -Force`
- `Get-Service | Where Status -eq Running`
- `Restart-Service -Name spooler`

## Network Basics
- `Test-Connection 8.8.8.8 -Count 2`
- `Test-NetConnection google.com -Port 443`
- `Get-NetIPAddress`
- `Get-NetTCPConnection | Select -First 20`

## Users + System Info
- `whoami`
- `Get-ComputerInfo`
- `Get-LocalUser`
- `Get-LocalGroupMember Administrators`

## Event Logs (CPT201 Core)
- `Get-WinEvent -ListLog * | Select -First 20`
- `Get-WinEvent -LogName Security -MaxEvents 20`
- `Get-WinEvent -FilterHashtable @{LogName="Security"; Id=4625} -MaxEvents 20`
- `Get-WinEvent -FilterHashtable @{LogName="Security"; StartTime=(Get-Date).AddDays(-1)} -MaxEvents 50`

## CSV + JSON
- `Import-Csv .\data.csv`
- `$rows | Export-Csv .\out.csv -NoTypeInformation`
- `Get-Content .\file.json | ConvertFrom-Json`
- `$obj | ConvertTo-Json -Depth 5 | Set-Content .\out.json`

## Useful Patterns
### Filter, sort, pick columns
- `Get-Process | Where CPU -gt 100 | Sort CPU -Desc | Select Name,CPU,Id`
### Loop
- `foreach ($u in $users) { Write-Host $u }`
### Error handling
- `try { ... } catch { $_.Exception.Message }`

## Output to a report folder (best practice)
- `$outDir = ".\Output"; New-Item -ItemType Directory -Force $outDir | Out-Null`
- `Get-Date | Out-File "$outDir\runlog.txt" -Append`
