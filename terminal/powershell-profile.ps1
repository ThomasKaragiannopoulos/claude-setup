Set-PSReadLineOption -Colors @{
    Parameter = '#39FF14'
    Operator  = '#A8A8A8'
}

function claude {
    if ($args[0] -eq 'yolo') {
        $rest = if ($args.Length -gt 1) { $args[1..($args.Length-1)] -join ' ' } else { '' }
        $argStr = ('--dangerously-skip-permissions ' + $rest).Trim()
    } else {
        $argStr = $args -join ' '
    }
    & "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe" --window 0 new-tab --profile "Claude" -- powershell.exe -NoExit -Command "claude.exe $argStr"
}
