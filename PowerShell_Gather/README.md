# ZTI_Gather
PowerShell script to replace MDT Gather in Windows OSD.
It collects information from a device and stores these as variables which can then be utilised as SCCM Task Sequence variables to set logic for various actions.
The advantage of this is that in most scenarios, you not longer need to use MDT-integrated Task Sequences and can therefore avoid using and maintaining the various MDT components required otherwise.
Script can be run in a Task in an SCCM Task Sequence - easiest way is to add the script content as a "Run PowerShell Script' step with the Execution Policy set to 'Bypass'.
For testing, the script can be run locally by using the '-Debug' parameter as per the example below from an Administrator PowerShell prompt:

***************************************************************************
Copyright (c) Devi Eadala All rights reserved.

.DESCRIPTION
    This is an Upgraded version from original MDT ZTI Gather to use with MEMCM Task Sequences
	from MEMCM Deployment Toolkit Solution Accelerator
	
.EXAMPLE
	Usage:		PowerShell.exe -ExecutionPolicy ByPass -File <ScriptName>.ps1 [-Debug]

.NOTES
    Author(s):  Devi Eadala
    Modified:   01/08/2024
	File:		ZTI_Gather.Ps1
	Version:	2.12
	Purpose:	Gather information and process rules controlling deployment
	Below is the current list as of version 3.7.1 posted 5/24/2022.
	https://www.dmtf.org/standards/smbios  main standards site
	https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.7.1.pdf 2024 Standards doc
	Detect chassis type, match your string requirement to one of the follow: IsLaptop, IsDesktop, IsTablet, or IsServer
	Make sure to test in your enviroment to fit your needs. Microsoft Surface 4 is a type 9 which is "laptop" even though its a tablet device
	Lenovo X1Tablet First Gen are 32 "Detatachable"
	
	# Other (1)
	# Unknown (2)
	# Desktop (3)
	# Low Profile Desktop (4)
	# Pizza Box (5)
	# Mini Tower (6)
	# Tower (7)
	# Portable (8)
	# Laptop (9)
	# Notebook (10)
	# Hand Held (11)
	# Docking Station (12)
	# All in One (13)
	# Sub Notebook (14)
	# Space-Saving (15)
	# Lunch Box (16)
	# Main System Chassis (17)
	# Expansion Chassis (18)
	# SubChassis (19)
	# Bus Expansion Chassis (20)
	# Peripheral Chassis or Dock  (21)
	# RAID Chassis (22)
	# Rack Mount Chassis (23)
	# Sealed-case PC (24)
	# Multi-system chassis (25)
	# Compact PCI (26)
	# Advanced TCA (27)
	# Blade (28)
	# Blade Enclosure (29)
	# Tablet (30)
	# Convertible (31) 
	# Detachable (32)
	# IoT Gateway (33)
	# Embedded PC (34)
	# Mini PC (35)
	# Stick PC (36)

***************************************************************************

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

