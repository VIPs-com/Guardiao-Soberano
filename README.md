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
| 0 | [nivel-0-semente](laboratorio/nivel-0-semente/) | [Seed com dados](laboratorio/nivel-0-semente/01-gerar-seed-dados.md) · [Backup aço](laboratorio/nivel-0-semente/02-backup-aco.md) |
| 1 | [nivel-1-cofre](laboratorio/nivel-1-cofre/) | [HW init](laboratorio/nivel-1-cofre/01-hw-wallet-inicializacao.md) · [Restore](laboratorio/nivel-1-cofre/02-teste-restauracao.md) |
| 2 | [nivel-2-carteira-fria](laboratorio/nivel-2-carteira-fria/) | [Sparrow watch-only](laboratorio/nivel-2-carteira-fria/01-sparrow-watching-only.md) · [Primeiro PSBT](laboratorio/nivel-2-carteira-fria/02-primeiro-psbt.md) · [KeePassXC](laboratorio/nivel-2-carteira-fria/03-keepassxc-tails.md) · [Electrum](laboratorio/nivel-2-carteira-fria/04-electrum-tails.md) · [Tails setup](laboratorio/nivel-2-carteira-fria/05-tails-setup-btc-xmr-completo.md) |
| 3 | [nivel-3-observador](laboratorio/nivel-3-observador/) | [Whonix VirtualBox](laboratorio/nivel-3-observador/01-whonix-virtualbox-completo.md) · [Node + EPS](laboratorio/nivel-3-observador/02-bitcoin-node-eps-onion.md) · [Migração Tails](laboratorio/nivel-3-observador/04-migracao-tails-whonix.md) |
| 4 | [nivel-4-misturador](laboratorio/nivel-4-misturador/) | [Whirlpool](laboratorio/nivel-4-misturador/01-whirlpool-primeiro-mix.md) · [Coin control](laboratorio/nivel-4-misturador/02-coin-control-postmix.md) · [JoinMarket](laboratorio/nivel-4-misturador/03-joinmarket-opcional.md) |
| 5 | [nivel-5-trocador](laboratorio/nivel-5-trocador/) | [eigenwallet](laboratorio/nivel-5-trocador/01-eigenwallet-whonix-btc-xmr.md) · [Feather](laboratorio/nivel-5-trocador/02-feather-tails-instalacao.md) · [RetoSwap](laboratorio/nivel-5-trocador/03-retoswap-xmr-btc.md) |
| 6 | [nivel-6-soberano](laboratorio/nivel-6-soberano/) | [Backup 3-2-1](laboratorio/nivel-6-soberano/01-backup-3-2-1.md) · [Scripts Tails](laboratorio/nivel-6-soberano/02-scripts-operador-tails.md) |
| 7 | [nivel-7-mestre](laboratorio/nivel-7-mestre/) | [Multisig 2-of-3](laboratorio/nivel-7-mestre/01-multisig-2of3-trilha-a.md) |

Índice completo: [`laboratorio/README.md`](laboratorio/README.md)

---

## Estrutura do repositório

```
├── manuscrito/       # Livro (31 .md)
├── laboratorio/      # Extensão prática
├── recursos/         # CSS, metadata, capa
├── imagens/          # Diagramas, ícones, capa (ver imagens/README.md)
├── LICENSE           # CC BY-NC-SA 4.0 (+ MIT para scripts)
├── CONTRIBUTING.md   # Como contribuir
├── CHANGELOG.md      # Histórico de versões
└── SECURITY.md       # Reportar problemas em scripts
```

Pastas locais (não versionadas): `soberano-equipe-dev/`, `old/`, `saida/`, `CLAUDE.md` — ver [`CONTRIBUTING.md`](CONTRIBUTING.md).

---

## Status

Legenda laboratório: 🟢 testado em hardware · 🟡 extraído (aguarda hardware) · 🔴 bloqueado.

| Item | Status |
| --- | --- |
| Livro v1.1 (manuscrito) | ✅ Editorial IA fechado — Fase 4: validação humano + hardware |
| PDF / EPUB / MOBI | ✅ Compilável localmente (IBM Plex Serif/Sans/Mono; fallback DejaVu) |
| Prova gráfica | 📋 [`recursos/prova-grafica-checklist.md`](recursos/prova-grafica-checklist.md) |
| Auditoria layout v1.2 | 📋 [`docs/auditoria-tipografia-tabelas.md`](docs/auditoria-tipografia-tabelas.md) · `.\scripts\auditoria-layout.ps1` |
| Laboratório | 🟡 **29/29 extraídos** · **0/18** labs 🔴 validados em hardware |
| Scripts Tails | 🟡 6/6 extraídos — aguarda teste com labs N2/N5/N6 |
| CI (links) | ✅ `.github/workflows/check-links.yml` |
| Remote GitHub | ⏳ Sem `origin` — ver [Publicar no GitHub](#publicar-no-github) |

---

## Publicar no GitHub

Repositório local pronto; ainda não há remote configurado. Conta `VIPs-com` autenticada no `gh`.

```powershell
# Criar repo público e enviar (ajuste visibilidade se preferir private)
gh repo create VIPs-com/Guardiao-Soberano --public `
  --description "Manual de Auto-Custódia Bitcoin com Privacidade (v1.1)" `
  --source=. --remote=origin --push

# Se o repo já existir, só adicionar remote e push:
git remote add origin https://github.com/VIPs-com/Guardiao-Soberano.git
git push -u origin main
```

Arquivos de saída (`saida/`) e pastas locais (`soberano-equipe-dev/`, `old/`) permanecem no `.gitignore`.

---

## Contribuir

Leia [`CONTRIBUTING.md`](CONTRIBUTING.md). Labs devem seguir [`laboratorio/_template-lab.md`](laboratorio/_template-lab.md).

---

## Licença

[Creative Commons BY-NC-SA 4.0](LICENSE) — scripts `.sh` sob MIT. Ver [`LICENSE`](LICENSE).
