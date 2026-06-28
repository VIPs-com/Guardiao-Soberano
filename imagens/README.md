# Imagens — Guardião Soberano v1.1

Inventário de ativos visuais do livro e laboratório. **Fonte editável:** `.drawio` ou `.svg` · **Publicação:** `.png`.

---

## Status geral (jun/2026)

| Categoria | Qtd | No manuscrito (embed) | Nos labs |
| --- | --- | --- | --- |
| Diagramas | 5 | Cap. 6, 9, 10, 13 (92–95% largura) | N1, N4, N5 |
| Ícones N0–N7 | 8 | Cap. 5–12 (badge 22 mm) | — |
| Capa e-book | `cover.jpg` / `cover.png` | EPUB/MOBI vertical | — |
| Capa A4 | pendente (`recursos/cover-a4.jpg`) | Impressão | — |
| Diagramas P&B | `imagens/pb/*.png` | Só `-Grafica` | auto |

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

---

## Ícones (`icones/`)

| Arquivo | Nível | Emoji | Cor de fundo |
| --- | --- | --- | --- |
| `nivel-0.png` | N0 A Semente | 🌱 | `#EAF3DE` |
| `nivel-1.png` | N1 O Cofre | 🔒 | `#FCEBEB` |
| `nivel-2.png` | N2 Carteira Fria | 👁️ | `#E6F1FB` |
| `nivel-3.png` | N3 Observador | 🏰 | `#EEEDFE` |
| `nivel-4.png` | N4 Misturador | 🔀 | `#FAEEDA` |
| `nivel-5.png` | N5 Trocador | 🔄 | `#E1F5EE` |
| `nivel-6.png` | N6 Soberano | 👑 | `#EAF3DE` |
| `nivel-7.png` | N7 Mestre | 🧙 | `#EEEDFE` |

Dimensão: 512×512 px (PNG). SVG = fonte leve para reexportar.

**Uso previsto:** capa (`cover.jpg` já inclui faixa N0–N6), futuras páginas de transição entre partes, site/README. Não obrigatório no miolo do PDF v1.1.

---

## Capa

| Arquivo | Uso |
| --- | --- |
| `imagens/cover.png` | Master 1600×2560 (reexportar) |
| `imagens/cover.svg` | Fonte vetorial |
| `recursos/cover.jpg` | **EPUB/MOBI** — `compila.ps1` usa este caminho |

Ao alterar a capa: editar `cover.svg` → exportar PNG → copiar/converter para `recursos/cover.jpg`.

---

## Caminhos no Markdown

| Origem | Caminho relativo |
| --- | --- |
| `manuscrito/*.md` | `../imagens/nome.png` |
| `laboratorio/nivel-X/*.md` | `../../imagens/nome.png` |

---

## Manutenção

1. Editar `.drawio` (diagramas 1, 4) ou `.svg` (demais).
2. Reexportar PNG colorido (1920x1080 diagramas; 512 icones).
3. `.\scripts\export-diagramas-pb.ps1` (ou `.\compila.ps1 -Grafica`).
4. Recompilar: `.\compila.ps1 -All` - PDF colorido + grafica P&B.
5. Se coordinator Whirlpool ou fluxo swap mudar, atualizar legenda do diagrama.

---

*Última revisão: 25 jun 2026 — pós-trilha 29 labs + reorganização equipe-dev.*
