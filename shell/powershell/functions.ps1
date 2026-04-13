function Show-Contents {
    param([string]$Path = ".")

    function Test-IsBinary {
        param([string]$LiteralPath)
        try {
            $fs = [System.IO.FileStream]::new(
                $LiteralPath,
                [System.IO.FileMode]::Open,
                [System.IO.FileAccess]::Read,
                [System.IO.FileShare]::ReadWrite
            )
            try {
                $buf = New-Object byte[] 8192
                $read = $fs.Read($buf, 0, $buf.Length)
                if ($read -le 0) { return $false }
                if ([Array]::IndexOf($buf, [byte]0, 0, $read) -ge 0) { return $true }
                $nonText = 0
                for ($i=0; $i -lt $read; $i++) {
                    $b = $buf[$i]
                    if ($b -in 9,10,13) { continue }      # \t \n \r
                    if (($b -ge 32 -and $b -le 126) -or $b -ge 128) { continue }
                    $nonText++
                }
                return ($nonText -gt ($read * 0.30))
            } finally { $fs.Dispose() }
        } catch { return $true } # unreadable -> treat as binary/skip
    }

    try { $root = Resolve-Path -LiteralPath $Path -ErrorAction Stop }
    catch { throw "Path not found: $Path" }

    & git -C $root rev-parse --git-dir 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        $files = & git -C $root ls-files --cached --others --exclude-standard |
                 ForEach-Object { Join-Path $root $_ }
    } else {
        $files = Get-ChildItem -LiteralPath $root -File -Recurse -ErrorAction SilentlyContinue |
                 Select-Object -ExpandProperty FullName
    }

    foreach ($p in $files) {
        if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { continue }
        if (Test-IsBinary -LiteralPath $p) { continue }

        try {
            $content = Get-Content -LiteralPath $p -Raw -ErrorAction Stop
            $header  = "`n======== $p ========`n"
            Write-Output ($header + $content)
        } catch {
            Write-Warning "Error reading: $p - $($_.Exception.Message)"
        }
    }
}
