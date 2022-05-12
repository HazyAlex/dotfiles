Set-Alias -Name fb -Value "C:\Program Files (x86)\foobar2000\foobar2000.exe"


function GotoDir([string]$directory) {
    if ($directory.ToUpper() -eq "DEV") {
        Set-Location "C:\dev"
        return
    }

    Set-Location $directory
}

New-Alias goto GotoDir


function shorten-path([string] $path) {
   return $path.Replace($HOME, '~')
}

function global:prompt {
   $cdelim = [ConsoleColor]::DarkCyan
   $cloc = [ConsoleColor]::Yellow

   write-host (shorten-path (pwd).Path) -n -f $cloc
   write-host ' $' -n -f $cdelim
   return ' '
}


$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
