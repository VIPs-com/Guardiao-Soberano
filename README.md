# Guardião Soberano

[![Licença: CC BY-NC-SA 4.0](https://img.shields.io/badge/Licença-CC%20BY--NC--SA%204.0-lightgrey.svg)](LICENSE)
[![Labs](https://img.shields.io/badge/Labs-8%20níveis-blue.svg)](laboratorio/)
[![Manuscrito](https://img.shields.io/badge/Livro-v1.1-green.svg)](manuscrito/)

**Manual Prático de Auto-Custódia Bitcoin com Privacidade** — *Da Semente ao Ecossistema Completo*  
Versão 1.1 — Junho de 2026 | Português (Brasil)

---

## O que é este projeto

| Camada | Pasta | No git? | Função |
| --- | --- | --- | --- |
| **Livro** | [`manuscrito/`](manuscrito/) | ✅ | Trilha — 8 níveis (0–7), ~71k palavras (32 arquivos + Ap. H) |
| **Laboratório** | [`laboratorio/`](laboratorio/) | ✅ | Tutoriais passo a passo e scripts |
| **Compilação** | [`compila.ps1`](compila.ps1) | ✅ | PDF, EPUB, MOBI, PDF gráfica → `saida/` |
| **Equipe / validação** | `soberano-equipe-dev/` | ❌ local | Checklists, agentes, relatórios |
| **Saída compilada** | `saida/` | ❌ local | Binários gerados |

Leia o livro para entender **por quê**; use o laboratório para **como fazer**.

---

## Começar rápido

### Ler o livro

```powershell
.\compila.ps1 -PDF
# Abrir: saida/guardiao-soberano-v1.1.pdf
```

Ou navegue [`manuscrito/`](manuscrito/) no explorador de arquivos.

### Prática guiada (laboratório)

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

### Validação (equipe — pasta local)

Checklists e bateria de testes dos agentes:

```
soberano-equipe-dev/docs/validacao/VERIFICACAO-v1.1.md
soberano-equipe-dev/docs/processo/BATERIA-TESTES-v1.1.md
```

*(Não versionados — ver `.gitignore`.)*

---

## Estrutura do repositório

```
├── manuscrito/       # Livro (versionado)
├── laboratorio/      # Labs + scripts (versionado)
├── recursos/         # CSS, metadata, capa
├── imagens/          # Diagramas, ícones
├── compila.ps1
└── .gitignore        # soberano-equipe-dev/, saida/, old/, CLAUDE.md, docs/, .claude/
```

**Offline (não entram no git):** `soberano-equipe-dev/` · `saida/` · `old/` · `CLAUDE.md` · `.claude/` · `docs/` (legado — usar `soberano-equipe-dev/docs/`)

Detalhes: [`CONTRIBUTING.md`](CONTRIBUTING.md)

---

## Status

| Item | Status |
| --- | --- |
| Livro v1.1 | ✅ Editorial + mapa ambientes (13.4–13.8, 14.0/14.0b, Ap. H) |
| PDF / EPUB / MOBI | ✅ `.\compila.ps1 -All` → `saida/` |
| Laboratório | 🟡 29/29 extraídos · 0/18 🔴 em hardware |
| Validação equipe | 📋 `soberano-equipe-dev/docs/` — rodada 2 |
| Git | ✅ **Local** (`main`) — **sem remote** configurado |
| GitHub | ⏸ Não publicado — configurar só após aprovação explícita |

---

## Git local (fluxo padrão)

```powershell
git status
git add manuscrito/ laboratorio/   # nunca saida/ ou soberano-equipe-dev/
git commit -m "descricao"
# Sem git push ate remote aprovado
```

### Publicar no GitHub (futuro — requer aprovação)

```powershell
# So depois de alinhar com a equipe:
git remote add origin <URL-APROVADA>
git push -u origin main
```

Artefatos `saida/` → Releases manuais ou distribuição local, **não** versionar no git.

---

## Contribuir

Leia [`CONTRIBUTING.md`](CONTRIBUTING.md). Labs: [`laboratorio/_template-lab.md`](laboratorio/_template-lab.md).

---

## Licença

[Creative Commons BY-NC-SA 4.0](LICENSE) — scripts `.sh` sob MIT.
