$vmName = 'test-vm'

$vm = Get-VM -Name $vmName 

#Remove VM from Hyper-V
Remove-VM -Name $vmName
#Remove VM files from disk
Remove-Item -Confirm -Recurse -Path $vm.ConfigurationLocation