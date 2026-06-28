# Guardião Soberano

[![Licença: CC BY-NC-SA 4.0](https://img.shields.io/badge/Licença-CC%20BY--NC--SA%204.0-lightgrey.svg)](LICENSE)
[![Labs](https://img.shields.io/badge/Labs-8%20níveis-blue.svg)](laboratorio/)
[![Manuscrito](https://img.shields.io/badge/Livro-v1.1-green.svg)](manuscrito/)

**Manual Prático de Auto-Custódia Bitcoin com Privacidade** — *Da Semente ao Ecossistema Completo*  
Versão 1.1 — Junho de 2026 | Português (Brasil)

---

## O que é este projeto

Livro + laboratório prático para quem quer sair da custódia de terceiros e controlar seus próprios bitcoins com privacidade real — do primeiro passo até multisig e nós soberanos.

| Camada | Pasta | Função |
| --- | --- | --- |
| **Livro** | [`manuscrito/`](manuscrito/) | Trilha conceitual — 8 níveis (0–7), ~46k palavras, 17 caps + 7 apêndices |
| **Laboratório** | [`laboratorio/`](laboratorio/) | 29 tutoriais passo a passo + scripts Tails/Whonix |
| **Compilação** | [`compila.ps1`](compila.ps1) | Gera PDF, EPUB, MOBI e PDF gráfica localmente |

Leia o livro para entender **por quê**; use o laboratório para **como fazer**.

---

## Começar

### Baixar o livro

Acesse a [página de Releases](https://github.com/VIPs-com/Guardiao-Soberano/releases) para baixar PDF, EPUB ou MOBI sem precisar compilar.

### Compilar localmente

**Requisitos:** [Pandoc](https://pandoc.org), [MiKTeX](https://miktex.org) (XeLaTeX), [Calibre](https://calibre-ebook.com) (MOBI).

```powershell
.\compila.ps1 -PDF        # PDF digital
.\compila.ps1 -EPUB       # EPUB
.\compila.ps1 -MOBI       # MOBI (requer Calibre)
.\compila.ps1 -All        # todos os formatos
# Saída: saida/guardiao-soberano-v1.1.pdf
```

Ou navegue [`manuscrito/`](manuscrito/) diretamente aqui no GitHub.

### Laboratório prático

| Nível | Pasta | Primeiro lab |
| --- | --- | --- |
| 0 | [nivel-0-semente](laboratorio/nivel-0-semente/) | [Seed com dados](laboratorio/nivel-0-semente/01-gerar-seed-dados.md) · [Backup aço](laboratorio/nivel-0-semente/02-backup-aco.md) |
| 1 | [nivel-1-cofre](laboratorio/nivel-1-cofre/) | [HW init](laboratorio/nivel-1-cofre/01-hw-wallet-inicializacao.md) · [Restore](laboratorio/nivel-1-cofre/02-teste-restauracao.md) |
| 2 | [nivel-2-carteira-fria](laboratorio/nivel-2-carteira-fria/) | [Sparrow watch-only](laboratorio/nivel-2-carteira-fria/01-sparrow-watching-only.md) · [Primeiro PSBT](laboratorio/nivel-2-carteira-fria/02-primeiro-psbt.md) |
| 3 | [nivel-3-observador](laboratorio/nivel-3-observador/) | [Whonix](laboratorio/nivel-3-observador/01-whonix-virtualbox-completo.md) · [Migração Tails](laboratorio/nivel-3-observador/04-migracao-tails-whonix.md) |
| 4 | [nivel-4-misturador](laboratorio/nivel-4-misturador/) | [Whirlpool](laboratorio/nivel-4-misturador/01-whirlpool-primeiro-mix.md) · [Coin control](laboratorio/nivel-4-misturador/02-coin-control-postmix.md) |
| 5 | [nivel-5-trocador](laboratorio/nivel-5-trocador/) | [eigenwallet](laboratorio/nivel-5-trocador/01-eigenwallet-whonix-btc-xmr.md) · [ABCTracer](laboratorio/nivel-5-trocador/04-defesa-abctracer.md) |
| 6 | [nivel-6-soberano](laboratorio/nivel-6-soberano/) | [Backup 3-2-1](laboratorio/nivel-6-soberano/01-backup-3-2-1.md) |
| 7 | [nivel-7-mestre](laboratorio/nivel-7-mestre/) | [Multisig](laboratorio/nivel-7-mestre/01-multisig-2of3-trilha-a.md) |

Índice completo: [`laboratorio/README.md`](laboratorio/README.md)

---

## Estrutura do repositório

```
├── manuscrito/       # Livro (17 caps + 7 apêndices)
├── laboratorio/      # Labs + scripts Tails/Whonix
├── recursos/         # CSS, metadata, capa
├── imagens/          # Diagramas, ícones dos níveis
├── scripts/          # Build: capa, diagramas P&B
├── compila.ps1       # Pipeline de compilação
└── saida/            # Gerada localmente (gitignored) — veja Releases
```

---

## Status

| Item | Status |
| --- | --- |
| Livro v1.1 | ✅ 17 caps + 7 apêndices (~46k palavras) |
| PDF / EPUB / MOBI | ✅ `.\compila.ps1 -All` |
| Laboratório | 29 labs · validação em hardware em andamento |
| Versão | ✅ [v1.1.0](https://github.com/VIPs-com/Guardiao-Soberano/releases/tag/v1.1.0) publicada · validação hardware em andamento |

---

## Contribuir

Leia [`CONTRIBUTING.md`](CONTRIBUTING.md). Template de lab: [`laboratorio/_template-lab.md`](laboratorio/_template-lab.md).

---

## Licença

[Creative Commons BY-NC-SA 4.0](LICENSE) — scripts `.sh` sob MIT.
