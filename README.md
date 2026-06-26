# Guardião Soberano

[![Licença: CC BY-NC-SA 4.0](https://img.shields.io/badge/Licença-CC%20BY--NC--SA%204.0-lightgrey.svg)](LICENSE)
[![Labs](https://img.shields.io/badge/Labs-8%20níveis-blue.svg)](laboratorio/)
[![Manuscrito](https://img.shields.io/badge/Livro-v1.1-green.svg)](manuscrito/)

**Manual Prático de Auto-Custódia Bitcoin com Privacidade** — *Da Semente ao Ecossistema Completo*  
Versão 1.1 — Junho de 2026 | Português (Brasil)

---

## O que é este projeto

| Camada | Pasta | Função |
| --- | --- | --- |
| **Livro** | [`manuscrito/`](manuscrito/) | Trilha conceitual — 8 níveis (0–7), ~46k palavras na Parte II |
| **Laboratório** | [`laboratorio/`](laboratorio/) | Tutoriais passo a passo, checklists e scripts |
| **Compilação** | [`compila.ps1`](compila.ps1) | PDF, EPUB, MOBI, PDF gráfica |

Leia o livro para entender **por quê**; use o laboratório para **como fazer** com verificação no final de cada exercício.

---

## Começar rápido

### Ler o livro

```powershell
.\compila.ps1 -PDF
# Abrir: saida/guardiao-soberano-v1.1.pdf
```

Ou navegue [`manuscrito/`](manuscrito/) diretamente no GitHub.

### Prática guiada (laboratório)

| Nível | Pasta | Primeiro lab |
| --- | --- | --- |
| 0 | [nivel-0-semente](laboratorio/nivel-0-semente/) | Em preparação |
| 1 | [nivel-1-cofre](laboratorio/nivel-1-cofre/) | Em preparação |
| 2 | [nivel-2-carteira-fria](laboratorio/nivel-2-carteira-fria/) | [Sparrow watch-only](laboratorio/nivel-2-carteira-fria/01-sparrow-watching-only.md) · [KeePassXC](laboratorio/nivel-2-carteira-fria/03-keepassxc-tails.md) · [Electrum](laboratorio/nivel-2-carteira-fria/04-electrum-tails.md) · [Tails setup](laboratorio/nivel-2-carteira-fria/05-tails-setup-btc-xmr-completo.md) |
| 3 | [nivel-3-observador](laboratorio/nivel-3-observador/) | Em preparação |
| 4 | [nivel-4-misturador](laboratorio/nivel-4-misturador/) | Em preparação |
| 5 | [nivel-5-trocador](laboratorio/nivel-5-trocador/) | Em preparação |
| 6 | [nivel-6-soberano](laboratorio/nivel-6-soberano/) | Em preparação |
| 7 | [nivel-7-mestre](laboratorio/nivel-7-mestre/) | Em preparação |

Índice completo: [`laboratorio/README.md`](laboratorio/README.md)

---

## Estrutura do repositório

```
├── manuscrito/       # Livro (31 .md)
├── laboratorio/      # Extensão prática
├── recursos/         # CSS, metadata, capa
├── imagens/          # Diagramas e ícones
├── LICENSE           # CC BY-NC-SA 4.0 (+ MIT para scripts)
├── CONTRIBUTING.md   # Como contribuir
├── CHANGELOG.md      # Histórico de versões
└── SECURITY.md       # Reportar problemas em scripts
```

Pastas locais (não versionadas): `soberano-equipe-dev/`, `old/`, `saida/` — ver [`CONTRIBUTING.md`](CONTRIBUTING.md).

---

## Status

| Item | Status |
| --- | --- |
| Livro v1.1 | ✅ Publicável |
| PDF / EPUB / MOBI | ✅ Compilável localmente |
| Laboratório | 🟡 4 labs Nível 2 extraídos (falta `02` PSBT) |
| CI (links) | ✅ `.github/workflows/check-links.yml` |

---

## Contribuir

Leia [`CONTRIBUTING.md`](CONTRIBUTING.md). Labs devem seguir [`laboratorio/_template-lab.md`](laboratorio/_template-lab.md).

---

## Licença

[Creative Commons BY-NC-SA 4.0](LICENSE) — scripts `.sh` sob MIT. Ver [`LICENSE`](LICENSE).
