# Guardiao Soberano - Varredura de layout (tabelas ASCII, URLs, codigo longo)
# Uso: .\scripts\auditoria-layout.ps1
# Limites calibrados para miolo A4 (largura util ~175 mm, 10 pt)

$ErrorActionPreference = "Stop"
$maxCellChars = 125   # pipe table cells (A4; era 85 no A5)
$maxCodeChars = 100   # linhas em blocos bash (A4; era 72 no A5)
$base = Split-Path $PSScriptRoot -Parent
$ms = Join-Path $base "manuscrito"

Write-Host ""
Write-Host "=== Auditoria de layout - Guardiao Soberano ===" -ForegroundColor Cyan
Write-Host "Pasta: $ms"
Write-Host ""

$asciiPattern = '^\s{2,}-{10,}'
$pipePattern  = '^\| --- \|'
$issues = @{
    AsciiTables   = @()
    PipeTables    = @()
    LongCode      = @()
    LongTableCell = @()
    LongBullets   = @()
}

Get-ChildItem "$ms\*.md" | Sort-Object Name | ForEach-Object {
    $file = $_.Name
    $lines = Get-Content $_.FullName -Encoding UTF8
    $codeFence = $false

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        $n = $i + 1

        if ($line -match '^```') {
            $codeFence = -not $codeFence
            continue
        }

        if (-not $codeFence) {
            if ($line -match $asciiPattern) {
                $t = $line.Trim()
                if ($t.Length -gt 60) { $t = $t.Substring(0, 60) }
                $issues.AsciiTables += [PSCustomObject]@{ File = $file; Line = $n; Text = $t }
            }
            if ($line -match $pipePattern) {
                $issues.PipeTables += [PSCustomObject]@{ File = $file; Line = $n }
            }
            if ($line -match '^\| .+\| .+\|' -and $line.Length -gt $maxCellChars) {
                $t = $line.Trim()
                if ($t.Length -gt 70) { $t = $t.Substring(0, 70) }
                $issues.LongTableCell += [PSCustomObject]@{ File = $file; Line = $n; Len = $line.Length; Text = $t }
            }
            if ($line -match '^\*\*.*\*\*.*github\.com' -and $line.Length -gt 78) {
                $issues.LongBullets += [PSCustomObject]@{ File = $file; Line = $n; Len = $line.Length }
            }
        }
        else {
            if ($line.Length -gt $maxCodeChars -and $line -notmatch '^\s*#' -and $line -notmatch '^\s*$') {
                $t = $line.Trim()
                if ($t.Length -gt 60) { $t = $t.Substring(0, 60) }
                $issues.LongCode += [PSCustomObject]@{ File = $file; Line = $n; Len = $line.Length; Text = $t }
            }
        }
    }
}

function Show-Group {
    param($Title, $Items, $Color = "Yellow")
    Write-Host ""
    Write-Host "--- $Title ($($Items.Count)) ---" -ForegroundColor $Color
    if ($Items.Count -eq 0) {
        Write-Host "  (nenhum)" -ForegroundColor Green
        return
    }
    $Items | Group-Object File | ForEach-Object {
        Write-Host "  $($_.Name): $($_.Count) ocorrencia(s)" -ForegroundColor White
        $_.Group | Select-Object -First 3 | ForEach-Object {
            $msg = "    L$($_.Line)"
            if ($_.Len) { $msg += " [$($_.Len) chars]" }
            if ($_.Text) { $msg += " - $($_.Text)" }
            Write-Host $msg -ForegroundColor Gray
        }
    }
}

Show-Group "Tabelas ASCII (converter para pipe)" $issues.AsciiTables "Red"
Show-Group "Celulas pipe largas (risco overflow A4)" $issues.LongTableCell
Show-Group "Bullets longos com URL" $issues.LongBullets
Show-Group "Linhas codigo longas" $issues.LongCode

$pipeFiles = ($issues.PipeTables | Select-Object -ExpandProperty File -Unique).Count
Write-Host ""
Write-Host "--- Resumo ---" -ForegroundColor Cyan
Write-Host "  Arquivos .md: $((Get-ChildItem "$ms\*.md").Count)"
Write-Host "  Arquivos com pipe tables: $pipeFiles"
Write-Host "  Linhas grid ASCII: $($issues.AsciiTables.Count)"
Write-Host "  Celulas largas: $($issues.LongTableCell.Count)"
Write-Host "  Codigo longo: $($issues.LongCode.Count)"

if ($issues.AsciiTables.Count -gt 0) {
    Write-Host ""
    Write-Host "  ACAO: ver docs/auditoria-tipografia-tabelas.md (Agente 10)" -ForegroundColor Yellow
    exit 1
}
Write-Host ""
Write-Host "  OK: sem tabelas ASCII detectadas." -ForegroundColor Green
exit 0
