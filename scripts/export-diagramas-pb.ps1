# Exporta diagramas coloridos -> P&B otimizado para grafica (miolo impresso)
# Mapeamento: verde ~40%, laranja ~60%, vermelho ~30%, azul ~45%, demais por luminancia
# Uso: .\scripts\export-diagramas-pb.ps1

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

$root = Split-Path $PSScriptRoot -Parent
$src  = Join-Path $root "imagens"
$dst  = Join-Path $root "imagens\pb"
if (-not (Test-Path $dst)) { New-Item -ItemType Directory -Path $dst | Out-Null }

$diagramas = @(
    "diagrama-ecossistema.png",
    "diagrama-psbt.png",
    "diagrama-whirlpool.png",
    "diagrama-swap.png",
    "fluxo-abctracer.png"
)

$G_VERDE   = [byte]102
$G_LARANJA = [byte]153
$G_VERM    = [byte]77
$G_AZUL    = [byte]115
$G_ROXO    = [byte]130
$G_TEXTO   = [byte]15
$G_FUNDO   = [byte]252

function Get-GrayLevel([int]$r, [int]$g, [int]$b, [byte]$a) {
    if ($a -lt 20) { return $G_FUNDO }
    $maxC = [Math]::Max($r, [Math]::Max($g, $b))
    $minC = [Math]::Min($r, [Math]::Min($g, $b))
    $sat  = if ($maxC -eq 0) { 0.0 } else { ($maxC - $minC) / $maxC }
    if ($maxC -gt 235 -and $sat -lt 0.12) { return $G_FUNDO }
    if ($maxC -lt 55 -and $sat -lt 0.35) { return $G_TEXTO }
    if ($r -gt 170 -and $g -gt 90 -and $g -lt ($r - 10) -and $b -lt 100) { return $G_LARANJA }
    if ($r -gt 140 -and ($r - $g) -gt 35 -and ($r - $b) -gt 35) { return $G_VERM }
    if ($g -gt ($r + 18) -and $g -gt ($b + 12) -and $g -gt 70) { return $G_VERDE }
    if ($b -gt 120 -and $r -gt 100 -and ($b -ge $g) -and ($r - $g) -lt 40) { return $G_ROXO }
    if ($b -gt ($r + 15) -and $b -gt ($g + 5) -and $b -gt 80) { return $G_AZUL }
    if ($r -gt 160 -and $g -gt 140 -and $b -lt 120 -and $sat -gt 0.15) {
        return [byte][Math]::Min(255, [int](0.45 * $r + 0.45 * $g + 0.1 * $b))
    }
    $lum = [int](0.299 * $r + 0.587 * $g + 0.114 * $b)
    return [byte][Math]::Min(255, [Math]::Max(0, $lum))
}

function ConvertTo-PbPng([string]$inPath, [string]$outPath) {
    $bmp = [System.Drawing.Bitmap]::FromFile($inPath)
    try {
        $rect = [System.Drawing.Rectangle]::FromLTRB(0, 0, $bmp.Width, $bmp.Height)
        $srcData = $bmp.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadOnly, $bmp.PixelFormat)
        $pb = New-Object System.Drawing.Bitmap $bmp.Width, $bmp.Height, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        $dstData = $pb.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::WriteOnly, $pb.PixelFormat)
        try {
            $bytes = [Math]::Abs($srcData.Stride) * $bmp.Height
            $buffer = New-Object byte[] $bytes
            [System.Runtime.InteropServices.Marshal]::Copy($srcData.Scan0, $buffer, 0, $bytes)
            $outBuf = New-Object byte[] $bytes
            for ($i = 0; $i -lt $bytes; $i += 4) {
                $b = $buffer[$i]
                $g = $buffer[$i + 1]
                $r = $buffer[$i + 2]
                $a = $buffer[$i + 3]
                $gray = Get-GrayLevel $r $g $b $a
                $outBuf[$i]     = $gray
                $outBuf[$i + 1] = $gray
                $outBuf[$i + 2] = $gray
                $outBuf[$i + 3] = $a
            }
            [System.Runtime.InteropServices.Marshal]::Copy($outBuf, 0, $dstData.Scan0, $bytes)
        }
        finally {
            $bmp.UnlockBits($srcData)
            $pb.UnlockBits($dstData)
        }
        $pb.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $bmp.Dispose()
        if ($pb) { $pb.Dispose() }
    }
}

foreach ($nome in $diagramas) {
    $inPath  = Join-Path $src $nome
    $outPath = Join-Path $dst $nome
    if (-not (Test-Path $inPath)) {
        Write-Host "AVISO: nao encontrado $inPath" -ForegroundColor Yellow
        continue
    }
    ConvertTo-PbPng $inPath $outPath
    $kb = [math]::Round((Get-Item $outPath).Length / 1KB)
    Write-Host "OK $nome -> imagens/pb/ ($kb KB)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Diagramas P&B prontos em: $dst" -ForegroundColor Cyan
