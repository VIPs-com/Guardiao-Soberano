# Exporta capa A4 (2480x3508 px, 300 DPI) para impressao
# Requer: pip install cairosvg pillow
# Uso: .\scripts\export-cover-a4.ps1

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$svg  = Join-Path $root "imagens\cover-a4.svg"
$png  = Join-Path $root "imagens\cover-a4.png"
$jpg  = Join-Path $root "recursos\cover-a4.jpg"

python -m pip install cairosvg pillow --quiet 2>$null

$py = @"
import cairosvg
from PIL import Image
from pathlib import Path

svg = Path(r'$svg')
png = Path(r'$png')
jpg = Path(r'$jpg')

cairosvg.svg2png(url=str(svg), write_to=str(png), output_width=2480, output_height=3508)
img = Image.open(png).convert('RGB')
img.save(jpg, 'JPEG', quality=95, dpi=(300, 300), optimize=True)
print(f'OK: {jpg} ({jpg.stat().st_size // 1024} KB)')
"@

python -c $py
