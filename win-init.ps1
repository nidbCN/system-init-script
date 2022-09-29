Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

function Set-Packages {
    param (
        [string]$Path
    )

    Invoke-RestMethod get.scoop.sh -OutFile 'scoop.ps1'

    if ($Path -ne $null) {
        Write-Host "Install scoop to $Path"
        .\scoop.ps1 -ScoopDir $scoopPath -ScoopGlobalDir $Path
    }
    else {
        Write-Host "Install scoop to $env:USERPROFILE\scoop"
        .\scoop.ps1
    }

    scoop install git
    scoop install aria2
    scoop config aria2-warning-enabled false

    # Add scoop buckets
    Write-Host "Add buckets"
    scoop bucket add main
    scoop bucket add extras
    scoop bucket add games
    scoop bucket add java
    scoop bucket add nonportable
    scoop bucket add nerd-fonts

    # Add scoop softwares
    Write-Host "Install softwares"

    scoop install winget

    # Softwares
    scoop install bitwarden
    scoop install dismplusplus
    scoop install etcher
    scoop install minecraft
    scoop install qbittorrent 
    scoop install rufus
    scoop install telegram

    # Runtimes & SDKs
    scoop install dotnet-sdk
    scoop install nodejs-lts
    scoop install openjdk17
    scoop install python
    regedit "$Path\apps\python\current\install-pep-514.reg"

    # CLI Tools
    scoop install 7zip
    scoop install adb
    scoop install busybox
    scoop install cloc
    scoop install cmake
    dotnet tool install -g csharprepl
    scoop install ffmpeg
    scoop install gh
    scoop install git
    scoop install lsd
    scoop install make
    scoop install mediainfo
    scoop install neovim
    scoop install nuget
    scoop install pwsh
    scoop install vim
    scoop install oh-my-posh 
    scoop install sudo

    # Microsoft app
    winget install 'Microsoft.VisualStudio.2022.Community'
    winget install 'Microsoft.VisualStudioCode'
    winget install 'Microsoft.RemoteDesktopClient'
    winget install 'Microsoft.PowerToys'
    sudo scoop install office-365-apps-np

    # Network Softwares
    scoop install clash
    scoop install nginx
    scoop install openssl
    scoop install speedtest-cli 
    scoop install tcping
    sudo scoop install wireguard-np
    scoop install wireshark
    sudo scoop install zerotier-np

    # Jetbrains Softwares
    scoop install idea-ultimate
    scoop install clion
    scoop install webstorm

    # Install apps via winget
    winget install 'Valve.Steam'            # Steam
    winget install 'Wargaming.GameCenter'   # Wargaming
    winget install 'Wargaming.WorldOfWarshipsModStation'
    winget install 'XPDNH1FMW7NB40'         # 火绒安全软件
    winget install 'Tencent.TencentMeeting' # 腾讯会议
    winget install 'Tencent.WeChat'         # 微信
    winget install 'Tencent.QQ'             # QQ
    winget install 'ModernFlyouts.ModernFlyouts'
    winget install 'VideoLAN.VLC'
}

function Set-Config {
    param (
        [string]$DeviceName
    )  
    # Rename computer
    Write-Host "Rename computer"
    sudo Rename-Computer -NewName $DeviceName  

    # Link files
    Write-Host "Link files"
    sudo New-Item -Path $PROFILE -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\.config\powershell_profile.ps1"
    sudo New-Item -Path "$env:USERPROFIL\.ssh\config" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\.config\ssh\config.txt"
    sudo New-Item -Path "$env:USERPROFIL\.ssh\known_hosts" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\.config\ssh\known_hosts.txt"
    sudo New-Item -Path "$env:USERPROFIL\.ssh\$DeviceName" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\.config\ssh\$DeviceName"
    sudo New-Item -Path "$env:USERPROFIL\.ssh\$DeviceName.pub" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\.config\ssh\$DeviceName.pub"
}

$scoopPath = Read-Host "Set scoop path"
Set-Packages($scoopPath)
$computerName = Read-Host "Set device name"
Set-Config($computerName)
