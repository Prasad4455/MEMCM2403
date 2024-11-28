# Define the list of remote machines
$remoteMachines = @("Machine1", "Machine2", "Machine3")  # Replace with actual machine names

# Ask for user credentials
$credential = Get-Credential -Message "Please enter your credentials for the remote machines"

# Define the log file path
$logFile = "C:\Path\To\Your\LogFile.log"  # Change to your desired log file path

# Function to log messages to the log file
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -FilePath $logFile -Append
}

# Start processing each machine
foreach ($machine in $remoteMachines) {
    Log-Message "Starting process for $machine"

    # Test if the machine is reachable
    if (Test-Connection -ComputerName $machine -Count 2 -Quiet) {
        Log-Message "$machine is reachable."

        # Define the script block to delete the ccmcache folder
        $scriptBlock = {
            param($folderPath)

            # Check if the folder exists
            if (Test-Path -Path $folderPath) {
                try {
                    # Remove the folder recursively
                    Remove-Item -Path $folderPath -Recurse -Force
                    Write-Output "Successfully deleted $folderPath"
                } catch {
                    Write-Output "Error deleting $folderPath: $_"
                    Log-Message "Error deleting $folderPath on $env:COMPUTERNAME: $_"
                }
            } else {
                Write-Output "$folderPath does not exist."
                Log-Message "$folderPath does not exist on $env:COMPUTERNAME."
            }
        }

        # Execute the script block on the remote machine
        Invoke-Command -ComputerName $machine -Credential $credential -ScriptBlock $scriptBlock -ArgumentList "C:\Windows\ccmcache"

    } else {
        Log-Message "$machine is not reachable."
        Write-Output "$machine is not reachable."
    }
}

Log-Message "Script execution completed."