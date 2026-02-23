#Name: Jonnathan MacKinnon
#Course: CPT201 - Week 1: Activity 2

Write-Output " Name: Jonnathan MacKinnon"
Write-Output "PowerShell Week1 Script for basic automation scripts and security checks"

#Display current date and time
Get-Date

#List running processes
Get-Process | Select-Object -First 3

#List running services
Get-Service | Select-Object -First 3

#Use pipeline to sort the processes by their CPU usage
Get-process | Sort-Object CPU -Descending | Select-Object -First 3


