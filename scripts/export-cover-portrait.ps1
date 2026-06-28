# Capa master -> retrato A4 + e-book
# Master aprovado: imagens/cover-a4.png (2480x3508). Legado letterbox: cover-master-letterbox.png
# Uso: .\scripts\export-cover-portrait.ps1

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

$root = Split-Path $PSScriptRoot -Parent

$targets = @(
    @{ W = 2480; H = 3508; Jpg = (Join-Path $root "recursos\cover-a4.jpg"); Png = (Join-Path $root "imagens\cover-a4.png") },
    @{ W = 1600; H = 2560; Jpg = (Join-Path $root "recursos\cover.jpg");     Png = (Join-Path $root "imagens\cover.png") }
)

function Resolve-CoverMaster($root) {
    $candidates = @(
        (Join-Path $root "imagens\cover-master.png"),
        (Join-Path $root "imagens\cover-a4.png")
    )
    foreach ($path in $candidates) {
        if (-not (Test-Path $path)) { continue }
        $probe = [System.Drawing.Bitmap]::FromFile($path)
        $w = $probe.Width
        $h = $probe.Height
        $probe.Dispose()
        if ($h -gt $w -and $w -ge 1500) { return $path }
    }
    $legacy = Join-Path $root "imagens\cover-master-letterbox.png"
    if (Test-Path $legacy) { return $legacy }
    throw "Master nao encontrado em imagens/cover-master.png ou imagens/cover-a4.png"
}

function Test-MasterIsFinalPortrait($path) {
    $probe = [System.Drawing.Bitmap]::FromFile($path)
    $ok = ($probe.Height -gt $probe.Width -and $probe.Width -ge 1500)
    $probe.Dispose()
    return $ok
}

function Sync-MasterCanonical($root, $approvedPath) {
    $canonical = Join-Path $root "imagens\cover-master.png"
    if ($approvedPath -eq $canonical) { return }
    if (-not (Test-Path $approvedPath)) { return }
    try {
        Copy-Item $approvedPath $canonical -Force -ErrorAction Stop
    } catch {
        Write-Host "cover-master.png em uso; master efetivo: $approvedPath" -ForegroundColor DarkYellow
    }
}

function Get-SafeMargins($tw, $th) {
    @{
        Top    = [int][math]::Round(18 / 25.4 * 300 * ($th / 3508.0))
        Bottom = [int][math]::Round(22 / 25.4 * 300 * ($th / 3508.0))
        Side   = [int][math]::Round(15 / 25.4 * 300 * ($tw / 2480.0))
    }
}

function Get-RowSignal($bmp, $y) {
    $sum = 0L
    $peak = 0
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $c = $bmp.GetPixel($x, $y)
        $lum = $c.R + $c.G + $c.B
        $sum += $lum
        if ($lum -gt $peak) { $peak = $lum }
    }
    $avg = [int]($sum / $bmp.Width)
    return [int][math]::Max($avg, [int]($peak * 0.55))
}

function Get-HorizontalBounds($bmp, $y0, $y1) {
    $minX = $bmp.Width
    $maxX = 0
    for ($y = $y0; $y -le $y1; $y++) {
        for ($x = 0; $x -lt $bmp.Width; $x++) {
            $c = $bmp.GetPixel($x, $y)
            if (($c.R + $c.G + $c.B) -gt 40) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
            }
        }
    }
    if ($maxX -lt $minX) { return @{ MinX = 0; MaxX = ($bmp.Width - 1) } }
    return @{ MinX = $minX; MaxX = $maxX }
}

function Get-RowPeak($bmp, $y) {
    $peak = 0
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $c = $bmp.GetPixel($x, $y)
        $lum = $c.R + $c.G + $c.B
        if ($lum -gt $peak) { $peak = $lum }
    }
    return $peak
}

function Get-VerticalBands($bmp, $yMin, $yMax, [int]$darkThreshold = 14, [int]$minGap = 8) {
    $bands = New-Object System.Collections.Generic.List[object]
    $y = $yMin
    while ($y -le $yMax) {
        while ($y -le $yMax -and (Get-RowSignal $bmp $y) -lt $darkThreshold) { $y++ }
        if ($y -gt $yMax) { break }
        $start = $y
        $darkRun = 0
        while ($y -le $yMax) {
            if ((Get-RowSignal $bmp $y) -lt $darkThreshold) {
                $darkRun++
                if ($darkRun -ge $minGap) { break }
            } else {
                $darkRun = 0
            }
            $y++
        }
        $end = $y - $darkRun - 1
        if (($end - $start + 1) -ge 3) {
            $bands.Add(@{ Y = $start; H = ($end - $start + 1) })
        }
        $y = $end + $darkRun + 1
    }
    return $bands
}

function Split-MasterRegions($bmp) {
    $mountainStart = 0
    for ($y = [int]($bmp.Height * 0.30); $y -lt $bmp.Height; $y++) {
        if ((Get-RowSignal $bmp $y) -gt 250) { $mountainStart = $y; break }
    }
    if ($mountainStart -eq 0) { $mountainStart = [int]($bmp.Height * 0.40) }

    $iconStart = 0
    for ($y = $mountainStart + 60; $y -lt ($bmp.Height - 40); $y++) {
        if ((Get-RowSignal $bmp $y) -gt 55 -and (Get-RowSignal $bmp ($y - 1)) -lt 20) {
            $iconStart = $y
            break
        }
    }
    if ($iconStart -eq 0) { $iconStart = [int]($bmp.Height * 0.66) }

    $mountainEnd = $iconStart - 1
    while ($mountainEnd -gt $mountainStart -and (Get-RowSignal $bmp $mountainEnd) -lt 18) { $mountainEnd-- }

    $regions = New-Object System.Collections.Generic.List[object]
    $textTop = [int]($bmp.Height * 0.20)
    $textBands = Get-VerticalBands $bmp $textTop ($mountainStart - 3)

    if ($textBands.Count -gt 0) {
        $y0 = ($textBands | ForEach-Object { $_.Y } | Measure-Object -Minimum).Minimum
        $y1 = ($textBands | ForEach-Object { ($_.Y + $_.H - 1) } | Measure-Object -Maximum).Maximum
        $y1 = [math]::Min($y1, $mountainStart - 4)
        while ($y1 -gt $y0 -and (Get-RowSignal $bmp $y1) -lt 45) { $y1-- }
        $hx = Get-HorizontalBounds $bmp $y0 $y1
        $regions.Add(@{ X = $hx.MinX; Y = $y0; W = ($hx.MaxX - $hx.MinX + 1); H = ($y1 - $y0 + 1) })
    }

    if ($mountainEnd -gt $mountainStart + 20) {
        $mx = Get-HorizontalBounds $bmp $mountainStart $mountainEnd
        $regions.Add(@{ X = $mx.MinX; Y = $mountainStart; W = ($mx.MaxX - $mx.MinX + 1); H = ($mountainEnd - $mountainStart + 1) })
    }

    $footerEnd = $iconStart
    for ($y = ($bmp.Height - 1); $y -ge $iconStart; $y--) {
        if ((Get-RowPeak $bmp $y) -gt 110) { $footerEnd = $y; break }
    }

    $fx = Get-HorizontalBounds $bmp $iconStart $footerEnd
    $regions.Add(@{ X = $fx.MinX; Y = $iconStart; W = ($fx.MaxX - $fx.MinX + 1); H = ($footerEnd - $iconStart + 1) })

    if ($regions.Count -eq 0) {
        $regions.Add(@{ X = 0; Y = 0; W = $bmp.Width; H = $bmp.Height })
    }

    return $regions
}

function Save-BitmapOutputs($bmp, $jpg, $png) {
    foreach ($dir in @((Split-Path $jpg -Parent), (Split-Path $png -Parent))) {
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    }
    $bmp.Save($png, [System.Drawing.Imaging.ImageFormat]::Png)
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
    $enc = New-Object System.Drawing.Imaging.EncoderParameters 1
    $enc.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 96L)
    $bmp.Save($jpg, $codec, $enc)
}

function Export-PortraitScaled($src, $tw, $th, $jpg, $png) {
    $srcFull = [System.Drawing.Bitmap]::FromFile($src)
    $skipPng = ([System.IO.Path]::GetFullPath($src) -eq [System.IO.Path]::GetFullPath($png))
    if ($srcFull.Width -eq $tw -and $srcFull.Height -eq $th) {
        $srcFull.SetResolution(300, 300)
        if (-not $skipPng) {
            Save-BitmapOutputs $srcFull $jpg $png
        } else {
            foreach ($dir in @((Split-Path $jpg -Parent))) {
                if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
            }
            $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
            $enc = New-Object System.Drawing.Imaging.EncoderParameters 1
            $enc.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 96L)
            $srcFull.Save($jpg, $codec, $enc)
        }
        $srcFull.Dispose()
        return
    }
    $bmp = New-Object System.Drawing.Bitmap $tw, $th
    $bmp.SetResolution(300, 300)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.DrawImage($srcFull, 0, 0, $tw, $th)
    $g.Dispose()
    $srcFull.Dispose()
    Save-BitmapOutputs $bmp $jpg $png
    $bmp.Dispose()
}

function Export-Portrait($src, $tw, $th, $jpg, $png) {
    if (Test-MasterIsFinalPortrait $src) {
        Export-PortraitScaled $src $tw $th $jpg $png
        return
    }

    $srcFull = [System.Drawing.Bitmap]::FromFile($src)
    $regions = Split-MasterRegions $srcFull

    $m = Get-SafeMargins $tw $th
    $contentX = $m.Side
    $contentY = $m.Top
    $contentW = $tw - (2 * $m.Side)
    $contentH = $th - $m.Top - $m.Bottom
    $baseGap = [int][math]::Round(18 * ($th / 3508.0))
    $sumH = ($regions | ForEach-Object { $_.H } | Measure-Object -Sum).Sum
    $minW = ($regions | ForEach-Object { $_.W } | Measure-Object -Minimum).Minimum
    $scaleW = $contentW / $minW
    $scaleH = ($contentH - ($baseGap * ($regions.Count - 1))) / $sumH
    $baseScale = [math]::Min($scaleW, $scaleH)

    $heights = @()
    foreach ($r in $regions) { $heights += [int][math]::Round($r.H * $baseScale) }
    $totalGaps = $baseGap * ($regions.Count - 1)
    $totalH = ($heights | Measure-Object -Sum).Sum + $totalGaps

    $extra = [math]::Max(0, $contentH - $totalH)
    $topPad = [int][math]::Round($extra / 2)
    $bottomPad = $extra - $topPad
    $cursorY = $contentY + $topPad

    $bmp = New-Object System.Drawing.Bitmap $tw, $th
    $bmp.SetResolution(300, 300)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Black)

    for ($i = 0; $i -lt $regions.Count; $i++) {
        $r = $regions[$i]
        $destW = [int][math]::Round($r.W * $baseScale)
        $destH = $heights[$i]
        $destX = $contentX + [int][math]::Round(($contentW - $destW) / 2)
        $srcRect = [System.Drawing.Rectangle]::new($r.X, $r.Y, $r.W, $r.H)
        $destRect = [System.Drawing.Rectangle]::new($destX, $cursorY, $destW, $destH)
        $g.DrawImage($srcFull, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
        if ($i -lt ($regions.Count - 1)) { $cursorY += $destH + $baseGap } else { $cursorY += $destH + $bottomPad }
    }

    $g.Dispose()
    $srcFull.Dispose()
    Save-BitmapOutputs $bmp $jpg $png
    $bmp.Dispose()
}

$master = Resolve-CoverMaster $root
Sync-MasterCanonical $root $master
Write-Host ("Master: {0}" -f $master) -ForegroundColor Cyan

foreach ($t in $targets) {
    Export-Portrait $master $t.W $t.H $t.Jpg $t.Png
    $kb = [math]::Round((Get-Item $t.Jpg).Length / 1KB)
    Write-Host ("{0}x{1} -> {2} ({3} KB)" -f $t.W, $t.H, $t.Jpg, $kb) -ForegroundColor Green
}

if (-not (Test-MasterIsFinalPortrait $master)) {
    $probe = [System.Drawing.Bitmap]::FromFile($master)
    $r = Split-MasterRegions $probe
    Write-Host ("Blocos detectados: {0}" -f $r.Count) -ForegroundColor DarkGray
    $probe.Dispose()
} else {
    Write-Host "Master final A4 - exportacao direta (sem remontagem)" -ForegroundColor DarkGray
}
