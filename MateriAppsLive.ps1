[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [switch]$force,
    [Parameter(Mandatory=$true)]
    [string]$source
)

$DISKLIVE = [System.IO.Path]::GetTempFileName()
New-Item -Path $DISKLIVE -itemtype file -force | OUT-NULL
Add-Content -Path $DISKLIVE "LIST DISK"
$LISTDISK=(diskpart.exe /s $DISKLIVE)
Remove-Item -Force $DISKLIVE
$TOTALDISK=$LISTDISK.count
if ($TOTALDISK -eq 0) {
    Write-Output 'Please run as Administrator.'
    Pause
    exit
}
$TOTALDISK=($LISTDISK.count)-9
$DISKID=$LISTDISK[-1].substring(7,5).trim()
$j = @()
$DLs = @()
for ($i=0; $i -le $DISKID; $i++) {
    $DISKDETAIL = [System.IO.Path]::GetTempFileName()
    New-Item -Path $DISKDETAIL -itemtype file -force | OUT-NULL
    Add-Content -Path $DISKDETAIL "SELECT DISK $i"
    Add-Content -Path $DISKDETAIL "DETAIL DISK"
    $DETAIL=(diskpart.exe /s $DISKDETAIL)
    $TYPE=$DETAIL[10].substring(11).trim()
    $LABEL=$DETAIL[-1].substring(18,11).trim()
    if ($TYPE -eq "USB") {
        if (($LABEL -ne  "MATERIAPPS") -or ($FORCE)) {
            $DISKFORMAT = [System.IO.Path]::GetTempFileName()
            New-Item -Path $DISKFORMAT -ItemType file -Force | OUT-NULL
            Add-Content -Path $DISKFORMAT "SELECT DISK $i"
            Add-Content -Path $DISKFORMAT "CLEAN"
            Add-Content -Path $DISKFORMAT "CONVERT GPT"
            Add-Content -Path $DISKFORMAT "CREATE PARTITION PRIMARY"
            Add-Content -Path $DISKFORMAT "FORMAT QUICK FS=FAT32 LABEL=`"MATERIAPPS`""
            Add-Content -Path $DISKFORMAT "ASSIGN"
            Add-Content -Path $DISKFORMAT "EXIT"
            $FORMAT=(diskpart.exe /s $DISKFORMAT)
        }
        $DETAIL=(diskpart.exe /s $DISKDETAIL)
        $DRIVELETTER=$DETAIL[-1].substring(15,1)
        $j += Start-Job -ScriptBlock {param($SOURCE, $DESTINATION) Copy-Item $SOURCE -Destination $DESTINATION -Recurse -Force} -Argumentlist $source,${DRIVELETTER}:\
        $DLs += $DRIVELETTER
    }
    Remove-Item -Force $DISKDETAIL
}
