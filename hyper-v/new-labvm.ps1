#TODO wrap in function
#TODO add parameters
#TODO add config file to check vm store, locations etc....
#TODO setup the config file on first run

$vmPath = "C:\vhd\" 
$vmName = "test-vm"
# $vmStartupMemory = 1G
$vmNewVHDPath = $vmPath + $vmName + "\Virtual Hard Disks\" + $vmName + ".vhdx"

#Create VM
New-VM -Name $vmName -Path $vmPath -MemoryStartupBytes 1024MB -NewVHDPath $vmNewVHDPath -NewVHDSizeBytes 20GB