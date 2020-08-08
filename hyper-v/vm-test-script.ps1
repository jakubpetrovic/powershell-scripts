function Test-VMActions {
    param (
        $name
    )

    new-labvm -vmName $name -Path "C:\vhd\" -NewVHDSizeBytes 10GB -MemoryStartupBytes 1GB -Linux
    # new VM was created
    get-vm | ft

    remove-labvm  -vmName $name
    # new vm was removed
    get-vm | ft
    
}

#Create a new VM 
function New-LabVM {
    param (
        [Parameter(Mandatory=$true)]
        [string]$VMName,

        [Parameter(Mandatory=$true)]
        [string]$Path,

        [Parameter(Mandatory=$true)]
        [Int64]$NewVHDSizeBytes,

        [Parameter(Mandatory=$true)]
        [int64]$MemoryStartupBytes,

        [Parameter(Mandatory=$false)]
        [switch]$Linux,

        [Parameter(Mandatory=$false)]
        [switch]$Windows,

        [Parameter(Mandatory=$false)]
        [int32]$Count
    )

    $vmNewVHDPath = $Path + $vmName + "\Virtual Hard Disks\" + $vmName + ".vhdx"
    New-VM -Name $VMName -Path $Path -MemoryStartupBytes $MemoryStartupBytes -NewVHDPath $vmNewVHDPath -NewVHDSizeBytes $NewVHDSizeBytes -Generation 2
    
    #Linux wont boot with MicrosoftWindows Secure Boot template
    if ($Linux) {
        Get-VM -Name $VMName | Set-VMFirmware -EnableSecureBoot On -SecureBootTemplate MicrosoftUEFICertificateAuthority
    }

    if ($Windows) {
        Get-VM -Name $VMName | Set-VMFirmware -EnableSecureBoot On -SecureBootTemplate MicrosoftWindows
    }
    
}

#remove vm function
function Remove-LabVM {

    param (
        [Parameter(Mandatory=$true)][string]$VMName
    )

    $vm = Get-VM -Name $vmName
    Remove-VM -Name $vmName
    Remove-Item -Force -Recurse -Path $vm.ConfigurationLocation
    Write-Output "VM $vmName was removed from Hyper-V and from the disk"

}

Test-VMActions -name test-vm
