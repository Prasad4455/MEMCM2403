# PowerShell_Gather
PowerShell script to replace MDT Gather in Windows OSD.

It collects information from a device and stores these as variables which can then be utilised as SCCM Task Sequence variables to set logic for various actions.

The advantage of this is that in most scenarios, you not longer need to use MDT-integrated Task Sequences and can therefore avoid using and maintaining the various MDT components required otherwise.

Script can be run in a Task in an SCCM Task Sequence - easiest way is to add the script content as a "Run PowerShell Script' step with the Execution Policy set to 'Bypass'.

For testing, the script can be run locally by using the '-Debug' parameter as per the example below from an Administrator PowerShell prompt:

**PS C:\Users\\Documents\PowerShell_Gather> .\Gather.ps1 -Debug**


Variables currently gathered are shown in the example output below:

-	Architecture = X64
-	AssetTag =           4455
-	BIOSReleaseDate = 01/29/2024 05:30:00
-	BIOSVersion = Q50 Ver. 01.08.09
-	BitlockerEncryptionMethod = N/A
-	DefaultGateway = 192.168.0.1
-	IPAddress = 192.168.0.127
-	IsBDE = False
-	IsCoffeeLakeOrLater = False
-	IsDesktop = True
-	IsLaptop = False
-	IsOnBattery = False
-	IsOnEthernet = False
-	IsServer = False
-	IsTablet = False
-	IsVM = False
-	MacAddress = 98:BD:54:99:AA:EF
-	Make = HP
-	Memory = 65344.65625
-	Model = HP Z2 Mini G4 Workstation
-	OSBuildNumber = 22635.3807
-	OSCurrentBuild = 22635
-	OSCurrentVersion = 10.0.22635
-	OsInWinPE = False
-	OsLocale = te-IN
-	OsTimeZone = (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
-	OsWindowsInstallationType = Client
-	OsWindowsProductName = Windows 10 Pro
-	ProcessorFamily = 2286
-	ProcessorManufacturer = GenuineIntel
-	ProcessorName = Intel(R) Core(TM) Xeon-E-2286G @ 4.0GHz
-	ProcessorSpeed = 3192
-	Product = 8458
-	SerialNumber = 5DF0234FGJ
-	SystemSKU = 9SP50UC#ACJ
-	UUID = 2D940A37-2017-00D3-523B-5444D222B6DE
-	Vendor = HP
-	VMPlatform = N/A
