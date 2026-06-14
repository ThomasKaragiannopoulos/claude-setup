Set-PSReadLineOption -Colors @{
    Parameter = '#39FF14'
    Operator  = '#A8A8A8'
}

function claude {
    $argStr = $args -join ' '
    & "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe" --window 0 new-tab --profile "Claude" -- powershell.exe -NoExit -Command "claude.exe $argStr"
}
