if (which git -ErrorAction Ignore) {
    Enable-GitColors
}

function gitp {
    if (!(which git -ErrorAction Ignore)) {
        return
    }

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    # Git Prompt
    $realLASTEXITCODE = $LASTEXITCODE
    $status = Get-GitStatus
    $LASTEXITCODE = $realLASTEXITCODE

    if ($status) {
        Write-Host (" on ") -nonewline -foregroundcolor white
        Write-Host ("git: ") -nonewline -foregroundcolor green
        Write-Host ($status.Branch) -nonewline -foregroundcolor cyan
    }
}

function hgp {
    if (!(which hg -ErrorAction Ignore)) {
        return
    }

    $status = Get-HgStatus

    if ($status) {
        Write-Host (" on ") -nonewline -foregroundcolor white
        Write-Host ("mercurial: ") -nonewline -foregroundcolor green
        Write-Host ($status.Branch) -nonewline -foregroundcolor cyan
    }
}

function prompt {
    # Blank line for padding
    Write-Host

    # Current date time
    #Write-Host (get-date -Format "yyyy-MM-dd hh:mm:ss tt") -foregroundcolor white

    # Current path info
    #Write-Host " in " -nonewline -foregroundcolor white
    Write-Host $pwd -nonewline -foregroundcolor darkgray

    # DVCS status
    gitp
    hgp

    # Command prompt
    Write-Host

    # User and machine info
    if ($env:userdomain.ToUpper() -ne $env:computername.ToLower()) {
        Write-Host ($ENV:USERDOMAIN.ToUpper()) -nonewline -foregroundcolor green
        Write-Host (".") -nonewline -foregroundcolor white
        Write-Host ($ENV:USERNAME.ToUpper()) -nonewline -foregroundcolor green
        Write-Host ("@") -nonewline
        Write-Host ($ENV:COMPUTERNAME.ToUpper()) -nonewline -foregroundcolor darkgray
    } else {
        Write-Host ($ENV:USERNAME.ToUpper()) -nonewline -foregroundcolor green
        Write-Host ("@") -nonewline
        Write-Host ($ENV:COMPUTERNAME.ToUpper()) -nonewline -foregroundcolor darkgray
    }

    if (Test-IsAdmin) {
        #Write-Host " as " -nonewline
        Write-Host "[Admin]" -nonewline -foregroundcolor red
    }

    Write-Host "►" -nonewline -foregroundcolor darkred

    return " "
}