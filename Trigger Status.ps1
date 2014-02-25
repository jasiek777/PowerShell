﻿#
# This will verify whether the "SampleTrigger" in our Samples Folder is online
# This job can be scheduled to run throughout the day to ensure no defined Triggers have
# Accidentally been disabled and are running properly.
#
$Trig = Get-ChildItem JD:\Samples\SampleTrigger

#
# Define the Triggers name and Status
#
$Status = $Trig.Status
$Name = $Trig.Name

#
# Is the status Enabled or Disabled?
#
if ($Status -eq "Enabled") {
    Write-Host "$name is currently Enabled"
}

#
# Status is Disabled - send a notification
#
else {
    Write-Host "Trigger $name is currently Disabled"
    $SMTP = "smtpserver"
	$Subject = "$name has become Disabled"
	$Body = "Trigger: $name - is currently disabled"
	$FromAddress = "From@YourDomain.com"
	$ToAddress = "Notify@YourDomain.com"
	Send-MailMessage -To $ToAddress -Subject "$Subject" -SMTPServer $SMTP -From $FromAddress -body "$Body"
}