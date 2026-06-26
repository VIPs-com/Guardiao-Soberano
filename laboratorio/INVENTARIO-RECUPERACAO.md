# Inventário de recuperação — Labs pendentes

Mapa do conteúdo **removido do livro** (mas valioso para prática) → pasta de lab alvo.

Fontes para mineração:

| Fonte | Local |
| --- | --- |
| Backups pré-integração | `old/manuscrito-backups/backup-pre-complemento-20260624-1726/` |
| Pesquisas organizadas | `soberano-equipe-dev/Markdown-organizado/03-adendos/` |
| Manual da Fortaleza (adaptar) | `soberano-equipe-dev/Markdown-organizado/04-manual-fortaleza/` |
| Relatório de integração | `soberano-equipe-dev/RELATORIO-INTEGRACAO-COMPLEMENTOS.md` |

---

## Nível 0 — A Semente

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Checklist mestre fase 1 (7 níveis) | `fase1 checklist mestre autocus` | 🔴 Recuperar de backup; limpar JS |
| Passphrase BIP39 na prática | integrado no livro cap. 5 | 🟢 No livro; lab opcional |
| Gerador de sementes com dados | integrado no livro cap. 5 | 🟢 No livro; lab opcional |

---

## Nível 1 — O Cofre

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Fluxo PSBT completo via QR | integrado cap. 6 | 🟡 Expandir com screenshots |
| SeedSigner vs Krux — comparação prática | integrado cap. 6 | 🟡 Lab side-by-side |
| HW wallets air-gapped — panorama | integrado cap. 6 | 🟢 Referência no livro |

---

## Nível 2 — A Carteira Fria

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Sparrow watching-only + primeiro PSBT | livro cap. 7 | 🟡 Labs `01` + `02` extraídos |
| KeePassXC na persistência Tails | integrado cap. 7 | 🟡 Lab `03-keepassxc-tails.md` + `start-keepass.sh` |
| Electrum no Tails + backup 3-2-1 | integrado cap. 7 | 🟡 Lab `04-electrum-tails.md` + `start-electrum.sh` |
| **Tails setup BTC+XMR completo** | `tails setup btc xmr completo` — REMOVIDO | 🟡 Lab extraído — `nivel-2/05-tails-setup-btc-xmr-completo.md` |

---

## Nível 3 — O Observador

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Whonix VirtualBox — setup completo | integrado parcial cap. 8 | 🟡 Lab expandido |
| Arquitetura Gateway/Workstation/Node | integrado cap. 8 | 🟢 Referência |
| EPS .onion + verificação PGP downloads | cap. 8 + Apêndice D | 🟡 Lab unificado |
| Migração Tails → Whonix | removido do cap. 9 (só tabela) | 🔴 Recuperar passo a passo |

---

## Nível 4 — O Misturador

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Whirlpool — primeiro mix | livro cap. 9 | 🟡 Lab com verificação anonset |
| Tails vs Whonix para Whirlpool | integrado parcial cap. 9 | 🟢 Tabela no livro |

---

## Nível 5 — O Trocador

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| eigenwallet no Whonix — swap BTC→XMR | integrado cap. 10 | 🟡 Lab expandido |
| RetoSwap — swap XMR→BTC | livro cap. 10 | 🟡 Lab + defesa ABCTracer |
| **Feather Wallet no Tails — instalação** | REMOVIDO do cap. 10 | 🟡 Lab `02-feather-tails-instalacao.md` + `start-feather.sh` |
| Restore height Monero | integrado cap. 10 | 🟡 Lab curto |

---

## Nível 6 — O Soberano

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Regra backup 3-2-1 | integrado parcial cap. 11 | 🟡 Lab com tar/verificação |
| **Scripts do operador (start-*.sh)** | Manual Fortaleza módulo 10 — REMOVIDO | 🟡 4/6 em `scripts/tails/` (falta retoswap, backup) |
| Mobile CalyxOS + Sparrow | livro cap. 11 | 🟡 Lab futuro |

---

## Nível 7 — O Mestre

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Multisig 2-of-2 / 2-of-3 | integrado cap. 12 | 🟡 Lab Trilha A |
| Qubes + Whonix (opcional) | cap. 12 | 🔴 Avançado |

---

## Scripts a curar (`laboratorio/scripts/`)

| Script | Fonte | Ambiente |
| --- | --- | --- |
| `start-feather.sh` | Manual Fortaleza módulo 10 / lab N5 | Tails | 🟡 Extraído |
| `start-electrum.sh` | Manual Fortaleza / cap. 7 | Tails | 🟡 Extraído |
| `start-retoswap.sh` | Manual Fortaleza | Tails |
| `backup-persistencia.sh` | cap. 7 / Manual Fortaleza | Tails |

> **Regra:** texto claro, comentado linha a linha. Nunca binário de terceiros.
