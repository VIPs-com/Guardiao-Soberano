# organizar-casa.ps1
# Reorganiza o repo local: laboratorio/, old/, docs internos.
# Executado pela primeira vez em jun/2026. Re-executar apenas se restaurar de backup.
#
# Uso: .\organizar-casa.ps1

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

Write-Host "Guardiao Soberano — organizar casa" -ForegroundColor Cyan
Write-Host "Se pastas old/ e laboratorio/ ja existem, movimentos duplicados serao ignorados.`n"

# Criar estrutura minima
@(
    "old/manuscrito-backups",
    "old/equipe-dev/zips",
    "old/equipe-dev/html-exports",
    "old/equipe-dev/fontes-brutas",
    "laboratorio/scripts/tails",
    "laboratorio/scripts/whonix"
) | ForEach-Object { New-Item -ItemType Directory -Force -Path $_ | Out-Null }

# Backups manuscrito -> old
Get-ChildItem "manuscrito" -Directory -Filter "backup-*" -ErrorAction SilentlyContinue | ForEach-Object {
    $dest = Join-Path "old/manuscrito-backups" $_.Name
    if (-not (Test-Path $dest)) {
        Move-Item $_.FullName "old/manuscrito-backups/" -Force
        Write-Host "  backup: $($_.Name)" -ForegroundColor Green
    }
}

# Docs internos na raiz -> equipe-dev
@("analise-pesquisas.md", "RELATORIO-INTEGRACAO-COMPLEMENTOS.md", "VERIFICACAO-TECNICA-PENDENTE.md") | ForEach-Object {
    if (Test-Path $_) {
        Move-Item $_ "soberano-equipe-dev/" -Force
        Write-Host "  doc interno: $_" -ForegroundColor Green
    }
}
if (Test-Path "CLAUDE.md") {
    Move-Item "CLAUDE.md" "soberano-equipe-dev/CLAUDE-projeto-raiz.md" -Force
    Write-Host "  CLAUDE.md -> equipe-dev" -ForegroundColor Green
}

Write-Host "`nConcluido. Ver CONTRIBUTING.md para o que publicar no remoto." -ForegroundColor Cyan
