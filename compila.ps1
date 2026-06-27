# Guardiao Soberano — Script de Compilacao
# Gera PDF, EPUB e MOBI em saida/
#
# INSTALACAO DOS REQUISITOS (Windows, uma vez):
#   winget install JohnMacFarlane.Pandoc
#   winget install MiKTeX.MiKTeX         # XeLaTeX — instala pacotes sob demanda
#   winget install calibre.calibre        # opcional, para MOBI
#
# PRIMEIRA EXECUCAO MiKTeX:
#   Apos instalar MiKTeX, abrir "MiKTeX Console" e fazer:
#   Settings > Install missing packages on-the-fly: Yes
#   Packages > Check for updates > Apply
#
# USO:
#   .\compila.ps1 -PDF        # gera so PDF (miolo A4, margens para grafica)
#   .\compila.ps1 -EPUB       # gera so EPUB
#   .\compila.ps1 -MOBI       # converte EPUB existente para MOBI
#   .\compila.ps1 -Grafica    # miolo P&B otimizado + PDF/X-1a (diagramas de imagens/pb/)
#   .\compila.ps1 -All        # gera tudo (PDF + EPUB + MOBI + PDF grafica)

param(
    [switch]$PDF,
    [switch]$EPUB,
    [switch]$MOBI,
    [switch]$Grafica,   # Miolo com diagramas P&B + PDF/X-1a para graficas
    [switch]$All
)

if ($All) { $PDF = $true; $EPUB = $true; $MOBI = $true; $Grafica = $true }
if (-not ($PDF -or $EPUB -or $MOBI -or $Grafica)) { $PDF = $true }

# --- Localizar executaveis (PATH atual ou caminhos conhecidos) ---
function Find-Exe($name, $fallbacks) {
    $cmd = Get-Command $name -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    foreach ($path in $fallbacks) { if (Test-Path $path) { return $path } }
    return $null
}

$pandocExe = Find-Exe "pandoc" @(
    "${env:LOCALAPPDATA}\Pandoc\pandoc.exe",
    "C:\Program Files\Pandoc\pandoc.exe"
)
$xelatexExe = Find-Exe "xelatex" @(
    "${env:LOCALAPPDATA}\Programs\MiKTeX\miktex\bin\x64\xelatex.exe",
    "C:\Program Files\MiKTeX\miktex\bin\x64\xelatex.exe"
)

if (($PDF -or $EPUB) -and -not $pandocExe) {
    Write-Host "ERRO: pandoc nao encontrado." -ForegroundColor Red
    Write-Host "  Instalar: winget install JohnMacFarlane.Pandoc" -ForegroundColor Yellow
    exit 1
}
if ($PDF -and -not $xelatexExe) {
    Write-Host "ERRO: xelatex nao encontrado." -ForegroundColor Red
    Write-Host "  Instalar: winget install MiKTeX.MiKTeX" -ForegroundColor Yellow
    exit 1
}
if ($Grafica -and -not $xelatexExe) {
    Write-Host "ERRO: xelatex nao encontrado (necessario para miolo grafica)." -ForegroundColor Red
    exit 1
}
if ($pandocExe) {
    $ver = & $pandocExe --version | Select-Object -First 1
    Write-Host "pandoc: $pandocExe ($ver)" -ForegroundColor Gray
}
if ($xelatexExe) {
    # Adicionar diretorio do xelatex ao PATH da sessao
    $xeDir = Split-Path $xelatexExe
    if ($env:PATH -notlike "*$xeDir*") { $env:PATH = "$xeDir;$env:PATH" }
    Write-Host "xelatex: $xelatexExe" -ForegroundColor Gray
}

$a   = [char]0x00E3
$base = "i:\VIPs-com\Guardi" + $a + "o-Soberano"
$ms   = "$base\manuscrito"

# Ordem explicita dos arquivos (glob nao garante sequencia correta)
$arquivos = @(
    "$ms\frontmatter-01-folha-de-rosto.md",
    "$ms\frontmatter-02-creditos.md",
    "$ms\frontmatter-03-dedicatoria.md",
    "$ms\00-prefacio.md",
    "$ms\parte-I-fundacoes.md",
    "$ms\01-dinheiro-era-digital.md",
    "$ms\02-entendendo-bitcoin.md",
    "$ms\03-chaves-carteiras-sementes.md",
    "$ms\04-privacidade-vs-anonimato.md",
    "$ms\parte-II-trilha.md",
    "$ms\05-nivel-0-semente.md",
    "$ms\06-nivel-1-cofre.md",
    "$ms\07-nivel-2-carteira-fria.md",
    "$ms\08-nivel-3-observador.md",
    "$ms\09-nivel-4-misturador.md",
    "$ms\10-nivel-5-trocador.md",
    "$ms\11-nivel-6-soberano.md",
    "$ms\12-nivel-7-mestre.md",
    "$ms\parte-III-referencia.md",
    "$ms\13-ecossistema-completo.md",
    "$ms\14-ferramentas-alternativas.md",
    "$ms\15-itens-que-salvam-vidas.md",
    "$ms\16-checklist-28-itens.md",
    "$ms\17-12-leis-do-guardiao.md",
    "$ms\A-glossario.md",
    "$ms\B-servidores-onion.md",
    "$ms\C-comandos-essenciais.md",
    "$ms\D-guia-verificacao-pgp.md",
    "$ms\E-aspectos-legais-brasil.md",
    "$ms\F-troubleshooting.md",
    "$ms\G-matriz-decisao.md"
)

# Verificar se todos os arquivos existem
$faltando = $arquivos | Where-Object { -not (Test-Path $_) }
if ($faltando) {
    Write-Host "ERRO: Arquivos faltando:" -ForegroundColor Red
    $faltando | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
    exit 1
}

# Criar pasta de saida
$saida = "$base\saida"
if (-not (Test-Path $saida)) { New-Item -ItemType Directory -Path $saida | Out-Null }

$recursos = "$base\recursos"
$imagens  = "$base\imagens"
$css      = "$recursos\stylesheet.css"
$meta     = "$recursos\metadata.opf"
$cover    = "$recursos\cover.jpg"
$versao   = "1.1"
$nome     = "guardiao-soberano-v$versao"
# Pandoc procura recursos (imagens) nestes diretorios — necessario para embed no EPUB/MOBI
$lab     = "$base\laboratorio"
$resourcePath = "$base;$ms;$imagens;$lab;$recursos"
$imagensPb = "$imagens\pb"
$resourcePathGrafica = "$base;$ms;$imagensPb;$imagens;$lab;$recursos"

function Invoke-PdfMiolo {
    param(
        [string]$OutFile,
        [string]$ResPath,
        [string]$Label = "PDF"
    )
    Write-Host "Gerando $Label (XeLaTeX)..." -ForegroundColor Cyan
    $args_pdf = @($arquivos) + @(
        "--from", "markdown",
        "--to", "pdf",
        "--pdf-engine=xelatex",
        "--resource-path=$ResPath",
        "-V", "geometry:a4paper",
        "-V", "geometry:inner=20mm,outer=15mm,top=18mm,bottom=18mm,includeheadfoot",
        "-V", "fontsize=10pt",
        "-V", "linestretch=1.5",
        "--include-in-header=$recursos\font-path.tex",
        "--include-in-header=$recursos\latex-header.tex",
        "-V", "secnumdepth=1",
        "-M", "lang=pt-BR",
        "--toc", "--toc-depth=2",
        "--number-sections",
        "-o", $OutFile
    )
    & $pandocExe @args_pdf 2>&1 | Where-Object { $_ -match "Error|fatal" }
    if (Test-Path $OutFile) {
        $sz = [math]::Round((Get-Item $OutFile).Length / 1KB)
        Write-Host "$Label gerado: $OutFile ($sz KB)" -ForegroundColor Green
        return $true
    }
    Write-Host "ERRO ao gerar $Label" -ForegroundColor Red
    return $false
}

# Caminho absoluto das fontes IBM Plex (XeLaTeX fontspec)
$fontDir = ($recursos + "\fonts\").Replace('\', '/') 
@"
% Auto-gerado por compila.ps1 — nao editar
\newcommand{\GuardiaoFontPath}{$fontDir}
"@ | Set-Content -Path "$recursos\font-path.tex" -Encoding UTF8


if ($PDF) {
    Invoke-PdfMiolo -OutFile "$saida\$nome.pdf" -ResPath $resourcePath -Label "PDF digital (colorido)" | Out-Null
}

if ($EPUB) {
    Write-Host "Gerando EPUB..." -ForegroundColor Cyan
    $args_epub = @($arquivos) + @(
        "--from", "markdown",
        "--to", "epub3",
        "--resource-path=$resourcePath",
        "--css", $css,
        "--epub-metadata=$meta",
        "-M", "lang=pt-BR",
        "--toc", "--toc-depth=3",
        "-o", "$saida\$nome.epub"
    )
    Get-ChildItem "$recursos\fonts\*.ttf" -ErrorAction SilentlyContinue | ForEach-Object {
        $args_epub += "--epub-embed-font=$($_.FullName)"
    }
    if (Test-Path $cover) {
        $args_epub += "--epub-cover-image=$cover"
    } else {
        Write-Host "AVISO: Capa nao encontrada em $cover" -ForegroundColor Yellow
    }
    & $pandocExe @args_epub 2>&1 | Where-Object { $_ -match "Error|fatal" }
    if (Test-Path "$saida\$nome.epub") {
        $sz = [math]::Round((Get-Item "$saida\$nome.epub").Length/1KB)
        Write-Host "EPUB gerado: $saida\$nome.epub ($sz KB)" -ForegroundColor Green
    } else {
        Write-Host "ERRO ao gerar EPUB" -ForegroundColor Red
    }
}

if ($MOBI) {
    $epubPath = "$saida\$nome.epub"
    if (-not (Test-Path $epubPath)) {
        Write-Host "AVISO: EPUB nao encontrado em $epubPath" -ForegroundColor Yellow
        Write-Host "  Execute: .\compila.ps1 -EPUB -MOBI" -ForegroundColor Yellow
    } else {
        Write-Host "Gerando MOBI via Calibre..." -ForegroundColor Cyan
        $ebook_convert = (Get-Command ebook-convert -ErrorAction SilentlyContinue)
        if ($ebook_convert) {
            & ebook-convert $epubPath "$saida\$nome.mobi" --output-profile kindle
            if ($?) { Write-Host "MOBI gerado: $saida\$nome.mobi" -ForegroundColor Green }
            else     { Write-Host "ERRO ao gerar MOBI" -ForegroundColor Red }
        } else {
            Write-Host "Calibre nao encontrado." -ForegroundColor Yellow
            Write-Host "  Instalar: winget install calibre.calibre" -ForegroundColor Yellow
        }
    }
}

if ($Grafica) {
    Write-Host "Preparando diagramas P&B para grafica..." -ForegroundColor Cyan
    & (Join-Path $base "scripts\export-diagramas-pb.ps1")

    $pdfGraficaSrc = "$saida\$nome-grafica-miolo.pdf"
    if (-not (Invoke-PdfMiolo -OutFile $pdfGraficaSrc -ResPath $resourcePathGrafica -Label "PDF miolo grafica (diagramas P&B)")) {
        exit 1
    }

    Write-Host "Gerando PDF/X-1a para grafica via Ghostscript..." -ForegroundColor Cyan

    $mgsExe = Find-Exe "mgs" @(
        "${env:LOCALAPPDATA}\Programs\MiKTeX\miktex\bin\x64\mgs.exe"
    )
    if (-not $mgsExe) {
        Write-Host "ERRO: mgs.exe (MiKTeX Ghostscript) nao encontrado." -ForegroundColor Red
    } else {
        $tmpDir  = "$env:TEMP\gs-grafica"
        if (-not (Test-Path $tmpDir)) { New-Item -ItemType Directory -Path $tmpDir | Out-Null }
        $tmpIn   = "$tmpDir\input.pdf"
        $tmpOut  = "$tmpDir\grafica.pdf"

        $marks = "$tmpDir\pdfmarks.ps"
        @(
            "[ /Title (Guardiao Soberano -- Da Semente ao Ecossistema Completo)",
            "  /Author (VIPs-com)",
            "  /Subject (Manual Pratico de Auto-Custodia Bitcoin com Privacidade)",
            "  /Keywords (Bitcoin privacidade auto-custodia Monero)",
            "  /Creator (XeLaTeX via Pandoc 3.10)",
            "  /DOCINFO pdfmark"
        ) | Set-Content -Path $marks -Encoding ASCII

        Copy-Item $pdfGraficaSrc $tmpIn -Force

        $gsArgs = @(
            "-dNOPAUSE", "-dBATCH", "-dSAFER",
            "-sDEVICE=pdfwrite",
            "-dCompatibilityLevel=1.3",
            "-dPDFX",
            "-sColorConversionStrategy=Gray",
            "-dProcessColorModel=/DeviceGray",
            "-dEmbedAllFonts=true",
            "-dSubsetFonts=true",
            "-dOptimize=true",
            "-r300",
            "-sOutputFile=$tmpOut",
            $marks, $tmpIn
        )
        & $mgsExe @gsArgs 2>&1 | Where-Object { $_ -match "Error|fatal" }

        if (Test-Path $tmpOut) {
            $graficaPdf = "$saida\$nome-grafica.pdf"
            Copy-Item $tmpOut $graficaPdf -Force
            $sz = [math]::Round((Get-Item $graficaPdf).Length / 1KB)
            Write-Host "PDF/X-1a gerado: $graficaPdf ($sz KB)" -ForegroundColor Green
            Write-Host "  Miolo: diagramas P&B (verde 40%, laranja 60%) + icones em cinza" -ForegroundColor Gray
            Write-Host "  PDF 1.3, grayscale, fontes embarcadas, 300 DPI" -ForegroundColor Gray
            Write-Host "  NOTA: validacao PDF/X-1a estrita - Acrobat Pro ou veraPDF" -ForegroundColor Gray
        } else {
            Write-Host "ERRO ao gerar PDF/X-1a" -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host "Conclusao. Arquivos em: $saida\" -ForegroundColor Green
Get-ChildItem "$saida\*.pdf", "$saida\*.epub", "$saida\*.mobi" -ErrorAction SilentlyContinue |
    ForEach-Object { "  $($_.Name)  ($([math]::Round($_.Length/1KB, 0)) KB)" }
