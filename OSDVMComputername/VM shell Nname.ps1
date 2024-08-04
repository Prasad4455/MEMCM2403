<#

Fetch the VM shell name (hostname) using VMware Tools on the guest OS without connecting to vCenter using PowerCLI:
VMware Tools provides a command-line utility called vmtoolsd that can be used to retrieve various VM information directly from within the guest OS.
To get the VM's hostname (shell name), you can use the following command in a PowerShell window on the guest OS:

powershell 
& "C:\Program Files\VMware\VMware Tools\vmtoolsd.exe" --cmd "info-get guestinfo.hostname"

This command uses the VMware Tools daemon to retrieve the hostname information.
If you want to get the VM name as it appears in vCenter (which might be different from the hostname), you can use:

powershell
& "C:\Program Files\VMware\VMware Tools\vmtoolsd.exe" --cmd "info-get guestinfo.vmname"

These commands work directly on the guest OS and do not require a connection to vCenter or the use of PowerCLI.
You can incorporate these commands into your OSD (Operating System Deployment) scripts to dynamically fetch the VM's hostname or name during the imaging process.
If you need to use this information in a script, you can assign the output to a variable:
allows  to retrieve the VM's shell name and VM name directly from within the guest OS, without needing to connect to vCenter or use PowerCLI. 
It's particularly useful in scenarios where you don't have or don't want to use vCenter credentials within your scripts
#>


$shellName = & "C:\Program Files\VMware\VMware Tools\vmtoolsd.exe" --cmd "info-get guestinfo.hostname"
$vmName = & "C:\Program Files\VMware\VMware Tools\vmtoolsd.exe" --cmd "info-get guestinfo.vmname"

Write-Host "Shell Name (Hostname): $shellName"
Write-Host "VM Name: $vmName"