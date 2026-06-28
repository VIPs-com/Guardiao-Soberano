# Imagens — Guardião Soberano v1.1

Inventário de ativos visuais do livro e laboratório. **Fonte editável:** `.drawio` ou `.svg` · **Publicação:** `.png` / `.jpg`.

---

## Status geral (jun/2026)

| Categoria | Qtd | No manuscrito (embed) | Nos labs |
| --- | --- | --- | --- |
| Diagramas coloridos | 5 | Cap. 6, 9, 10, 13 (92–95% largura) | N1, N4, N5 |
| Diagramas P&B | 5 | Só `-Grafica` (`imagens/pb/`) | auto |
| Ícones N0–N7 | 8 | Cap. 5–12 (badge **30 mm**) | — |
| Capa e-book | `recursos/cover.jpg` / `imagens/cover.png` | EPUB/MOBI vertical | — |
| Capa A4 gráfica | `recursos/cover-a4.jpg` / `imagens/cover-a4.png` | Impressão A4 @300 DPI | — |

Legenda: ✅ incorporado · 📁 só referência textual · 🔧 editar fonte `.drawio`/`.svg`

---

## Diagramas

| Arquivo PNG | Fontes | Capítulo | Lab |
| --- | --- | --- | --- |
| `diagrama-ecossistema.png` | `.drawio`, `.svg` | Cap. 13 | — |
| `diagrama-psbt.png` | `.drawio`, `.svg` | Cap. 6 | N1/03, N2/02 |
| `diagrama-whirlpool.png` | `.drawio`, `.svg` | Cap. 9 | N4/01 |
| `diagrama-swap.png` | `.drawio`, `.svg` | Cap. 10 | N5/01, N5/03 |
| `fluxo-abctracer.png` | `.drawio`, `.svg` | Cap. 10 | N5/04 |

**Alinhamento com a trilha atual:** eigenwallet (BTC→XMR) + RetoSwap (XMR→BTC) no `diagrama-swap.png`. JoinMarket (N4/03) não tem diagrama dedicado — intencional (backup P2P).

Versões P&B automáticas: `imagens/pb/*.png` (geradas por `compila.ps1 -Grafica`).

---

## Ícones (`icones/`)

Redesenhados em jun/2026: **SVG paths puros** (sem emoji), fundo escuro com gradiente radial, símbolo geométrico por nível. Tamanho de exibição no PDF: **30 mm**.

| Arquivo | Nível | Símbolo | Cor destaque | Fundo |
| --- | --- | --- | --- | --- |
| `nivel-0.png` | N0 — A Semente | Broto (caule + folhas) | `#52C858` verde | `#0a1e0c`→`#1a4a1e` |
| `nivel-1.png` | N1 — O Cofre | Cadeado (arco + corpo + buraco) | `#F7931A` laranja | `#050c18`→`#0d1b2e` |
| `nivel-2.png` | N2 — Carteira Fria | Floco de neve (3 eixos + pontas) | `#5BB8F5` azul | `#060e22`→`#0d1e42` |
| `nivel-3.png` | N3 — O Observador | Olho (amêndoa + íris + pupila) | `#9B70DB` roxo | `#0e061e`→`#1e0d3e` |
| `nivel-4.png` | N4 — O Misturador | Seta circular "CJ" | `#26C6C6` teal | `#051818`→`#0a2e2e` |
| `nivel-5.png` | N5 — O Trocador | BTC↔XMR (setas duplas) | `#FFA040` laranja | `#140a00`→`#2a1400` |
| `nivel-6.png` | N6 — O Soberano | Coroa (3 pontas + gemas) | `#FFD700` ouro | `#0e0c00`→`#1e1800` |
| `nivel-7.png` | N7 — O Mestre | Estrela 8 pontas + brilho | `#C8C8FF` prata | `#060610`→`#0d0d20` |

Fonte SVG em `imagens/icones/nivel-N.svg`. Reexportar PNG: abrir SVG no Inkscape → Export PNG → 512×512 px.

---

## Capa

### Master aprovado (Canva, jun/2026)

| Arquivo | Descrição |
| --- | --- |
| `imagens/cover-masters-aprovada.png` | **Original Canva** (992×1586) — arquivo-mestre, não editar |
| `imagens/cover-master.png` | Upscale bicúbico 1600×2560 — e-book |
| `imagens/cover-a4.png` | Upscale bicúbico 2480×3508 — A4 @300 DPI gráfica |
| `recursos/cover.jpg` | JPEG e-book — **usado pelo `compila.ps1`** |
| `recursos/cover-a4.jpg` | JPEG A4 — **usado pelo `compila.ps1 -Grafica`** |

Para regenerar exports a partir do master aprovado:

```powershell
.\scripts\export-cover-portrait.ps1
```

> **Não edite** `cover-master.png` diretamente. Se a arte da capa mudar, substitua `cover-masters-aprovada.png` e rode o script acima.

### Legado (não usar para compilação)

| Arquivo | Status |
| --- | --- |
| `imagens/cover.svg` | SVG geométrico anterior — substituído pela versão Canva |
| `imagens/cover-master-letterbox.png` | Variante horizontal — não usada |
| `imagens/cover-master-landscape.png` | Variante paisagem — não usada |

---

## Caminhos no Markdown

| Origem | Caminho relativo |
| --- | --- |
| `manuscrito/*.md` | `../imagens/nome.png` |
| `laboratorio/nivel-X/*.md` | `../../imagens/nome.png` |

---

## Manutenção

1. **Diagramas:** editar `.drawio` → exportar PNG colorido (1920×1080) → rodar `compila.ps1 -All`.
2. **Ícones:** editar `.svg` → exportar PNG 512×512 → `compila.ps1 -All`.
3. **Capa:** substituir `cover-masters-aprovada.png` → `export-cover-portrait.ps1` → `compila.ps1 -All`.
4. **P&B gráfica:** gerado automaticamente por `compila.ps1 -Grafica` (não editar `imagens/pb/` manualmente).
5. Se o fluxo eigenwallet/RetoSwap mudar, atualizar legenda do `diagrama-swap.png`.

---

*Última revisão: 27 jun 2026 — ícones redesenhados (SVG paths), capa Canva integrada, badge 30 mm.*
