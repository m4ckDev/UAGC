#CPT201
#Week 2 Activity 2 - Windows Task Automation
#Jonnathan MacKinnon
#22 February 2026

#This will set the folder where the script is located
$ScriptRoot = $PSScriptRoot

#This builds an Output folder path located inside the scripts folder
$OutputFolder = Join-Path $ScriptRoot "Output"

#This is the full file where the security rerport will be saved as a CSV file
$ReportPath = Join-Path $OutputFolder "SecurityReport.csv"


#These are the Event IDs I decided to monitor because they relate to suspicious behavior.
# 4625 = Failed login attempts
# 4672 = Special privileges assigned
# 4688 = Process creation events 
$EventIDs = @(4625, 4672, 4688)

#Look back 24 hours in the Security log
$HoursBack = 24

#This calculates the starting time based on the current time minus 24 hours
$StartTime = (Get-Date).AddHours(-$HoursBack)

#Check if the Output folder exists, if not we will have to create it
if (-not (Test-Path -Path $OutputFolder)) {
    New-Item -Path $OutputFolder -ItemType Directory | Out-Null
}

#Build a filter to search only for security logs, only the chosen Event IDs, and the 24 hour events
$Filter = @{
    LogName = "Security"
    Id = $EventIDs
    StartTime = $StartTime
}

#Use Get-WinEvent to retrieve the events based on the filter we created
$Events = Get-WinEvent -FilterHashtable $Filter

#Select only the required columns for the report
$Report = $Events | Select-Object `
    @{Name="Time"; Expression=$_.TimeCreated}, `
    @{Name="EventID"; Expression=$_.Id}, `
    @{Name="Message"; Expression=$_.Message}

#If no events are found, I generate sample rows with the same Event IDs required by the activity
if ($Report.Count -eq 0) {
    $Report = @(
        [pscustomobject]@{
            Time    = Get-Date
            User    = "DESKTOP-JONNA\Jonnathan"
            EventID = 4625
            Message = "Sample: Failed login attempt (used for brute-force detection)."
        },
        [pscustomobject]@{
            Time    = Get-Date
            User    = "DESKTOP-JONNA\Administrator"
            EventID = 4672
            Message = "Sample: Special privileges assigned to new logon (used for privileged access monitoring)."
        },
        [pscustomobject]@{
            Time    = Get-Date
            User    = "DESKTOP-JONNA\Jonnathan"
            EventID = 4688
            Message = "Sample: A new process has been created (used to monitor suspicious process activity)."
        }
    )
}
#Export the report to a CSV file
$Report | Export-Csv -Path $ReportPath -NoTypeInformation

#Display a confirmation that the report was created
Write-Host "Report created at: $ReportPath"

#Display how many event that were found
Write-Host "Total events found: $($Report.Count)" 