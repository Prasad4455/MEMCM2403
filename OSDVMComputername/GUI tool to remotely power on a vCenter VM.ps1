<# 

This script does the following:
It creates a simple Windows Forms GUI with input fields for the vCenter server address and VM name.
It includes a "Power On VM" button.
When the button is clicked, it:
Connects to the specified vCenter server
Retrieves the specified VM
Powers on the VM
Waits for the VM to fully power on
Updates the status label with the result
It handles errors and displays them in the status label.
It disconnects from the vCenter server after the operation is complete.
To use this tool:
Ensure you have VMware PowerCLI installed (Install-Module VMware.PowerCLI if you don't have it).
Run the script in PowerShell ISE or a PowerShell console.
Enter the vCenter server address and VM name in the respective fields.
Click the "Power On VM" button.
The status label will update with the progress and final state of the operation. 
This tool provides a simple interface for powering on a VM and checking its status remotely through vCenter.

#>


Add-Type -AssemblyName System.Windows.Forms
Import-Module VMware.PowerCLI

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "vCenter VM Power Control"
$form.Size = New-Object System.Drawing.Size(400,250)

# vCenter Server input
$vcenterLabel = New-Object System.Windows.Forms.Label
$vcenterLabel.Location = New-Object System.Drawing.Point(10,20)
$vcenterLabel.Size = New-Object System.Drawing.Size(120,20)
$vcenterLabel.Text = "vCenter Server:"
$form.Controls.Add($vcenterLabel)

$vcenterInput = New-Object System.Windows.Forms.TextBox
$vcenterInput.Location = New-Object System.Drawing.Point(130,20)
$vcenterInput.Size = New-Object System.Drawing.Size(200,20)
$form.Controls.Add($vcenterInput)

# VM Name input
$vmLabel = New-Object System.Windows.Forms.Label
$vmLabel.Location = New-Object System.Drawing.Point(10,50)
$vmLabel.Size = New-Object System.Drawing.Size(120,20)
$vmLabel.Text = "VM Name:"
$form.Controls.Add($vmLabel)

$vmInput = New-Object System.Windows.Forms.TextBox
$vmInput.Location = New-Object System.Drawing.Point(130,50)
$vmInput.Size = New-Object System.Drawing.Size(200,20)
$form.Controls.Add($vmInput)

# Power On button
$powerOnButton = New-Object System.Windows.Forms.Button
$powerOnButton.Location = New-Object System.Drawing.Point(130,80)
$powerOnButton.Size = New-Object System.Drawing.Size(100,30)
$powerOnButton.Text = "Power On VM"
$form.Controls.Add($powerOnButton)

# Status label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Location = New-Object System.Drawing.Point(10,120)
$statusLabel.Size = New-Object System.Drawing.Size(350,60)
$statusLabel.Text = "Status: Not connected"
$form.Controls.Add($statusLabel)

# Power On button click event
$powerOnButton.Add_Click({
    $vcenter = $vcenterInput.Text
    $vmName = $vmInput.Text

    try {
        # Connect to vCenter
        Connect-VIServer -Server $vcenter -ErrorAction Stop

        # Get the VM
        $vm = Get-VM -Name $vmName -ErrorAction Stop

        # Power on the VM
        Start-VM -VM $vm -Confirm:$false

        # Wait for the VM to power on
        do {
            Start-Sleep -Seconds 2
            $vm = Get-VM -Name $vmName
        } while ($vm.PowerState -ne "PoweredOn")

        $statusLabel.Text = "Status: VM '$vmName' is now powered on."
    }
    catch {
        $statusLabel.Text = "Error: $($_.Exception.Message)"
    }
    finally {
        # Disconnect from vCenter
        Disconnect-VIServer -Server $vcenter -Confirm:$false
    }
})

# Show the form
$form.ShowDialog()
