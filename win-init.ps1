Set-ExecutionPolicy RemoteSigned -Scope CurrentUser


function InstallPackages {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
    
    # Add scoop buckets
    scoop bucket add main
    scoop bucket add extras
    scoop bucket add games
    scoop bucket add java
    scoop bucket add nonportable

    # Add scoop softwares
    scoop install 7zip
    scoop install adb
    scoop install aria2
    scoop install bitwarden
    scoop install busybox
    scoop install clash
    scoop install cloc
    scoop install clash
    scoop install cmake
    scoop install dismplusplus
    scoop install etcher
    scoop install ffmpeg
    scoop install gh
    scoop install git
    scoop install lsd
    scoop install make
    scoop install minecraft
    scoop install neovim
    scoop install nginx
    scoop install nodejs-lts
    scoop install nuget
    scoop install openjdk17
    scoop install openssl
    scoop install powertoys
    scoop install pwsh
    scoop install python 
    scoop install qbittorrent 
    scoop install rufus
    scoop install speedtest-cli 
    scoop install sudo 
    scoop install tcping
    scoop install telegram
    scoop install vim
    scoop install vlc

    scoop install vscode
    regedit.exe /s 'C:\Users\Gaein\scoop\apps\vscode\current\install-context.reg'
    regedit.exe /s 'C:\Users\Gaein\scoop\apps\vscode\current\install-associations.reg'

    scoop install wireguard-np
    scoop install wireshark
    
}


function Set-Config {
    param (
        [string]$deviceName
    )

    sudo Rename-Computer -NewName $deviceName    
    sudo New-Item -Path $PROFILE -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\.config\powershell_profile.ps1"

    
}