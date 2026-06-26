# Inventário de recuperação — Labs

Mapa do conteúdo **removido do livro** (mas valioso para prática) → pasta de lab alvo.

> **Atualização 2026-06-25:** trilha N0–N7 com **29 labs extraídos**. Pendente: testes em hardware (fase final) e itens opcionais abaixo.

Fontes para mineração:

| Fonte | Local |
| --- | --- |
| Backups pré-integração | `old/manuscrito-backups/backup-pre-complemento-20260624-1726/` |
| Pesquisas organizadas | `soberano-equipe-dev/pesquisas/canonico/03-adendos/` |
| Manual da Fortaleza (adaptar) | `soberano-equipe-dev/pesquisas/canonico/04-manual-fortaleza/` |
| Relatório de integração | `soberano-equipe-dev/docs/relatorios/RELATORIO-INTEGRACAO-COMPLEMENTOS.md` |

---

## Nível 0 — A Semente

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Gerador de sementes com dados | cap. 5 | 🟡 `01-gerar-seed-dados.md` |
| Backup em aço + passphrase | cap. 5 | 🟡 `02-backup-aco.md` |
| Primeiros sats sem KYC | cap. 5 | 🟡 `03-primeiros-sats-sem-kyc.md` |
| Checklist mestre fase 1 (7 níveis) | pesquisas equipe | 🟡 `04-checklist-fase1-opcional.md` |

---

## Nível 1 — O Cofre

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| HW wallet inicialização | cap. 6 | 🟡 `01-hw-wallet-inicializacao.md` |
| Teste de restauração | cap. 6 | 🟡 `02-teste-restauracao.md` |
| Fluxo PSBT via QR | cap. 6 | 🟡 `03-psbt-via-qr.md` |
| SeedSigner vs Krux — comparação | cap. 6 | 🟡 `04-seedsigner-vs-krux-opcional.md` |
| HW wallets — panorama | cap. 6 | 🟢 Referência no livro |

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
| Whonix VirtualBox — setup completo | integrado parcial cap. 8 | 🟡 Labs `01`–`03` extraídos |
| Arquitetura Gateway/Workstation/Node | integrado cap. 8 | 🟢 Referência |
| EPS .onion + verificação PGP downloads | cap. 8 + Apêndice D | 🟡 Lab `02` + `03` |
| Migração Tails → Whonix | removido do cap. 9 (só tabela) | 🟡 Lab `04-migracao-tails-whonix.md` |

---

## Nível 4 — O Misturador

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Whirlpool — primeiro mix | cap. 9 | 🟡 `01-whirlpool-primeiro-mix.md` |
| Coin control pós-mix | cap. 9 | 🟡 `02-coin-control-postmix.md` |
| JoinMarket backup P2P | cap. 9 + 15.2 + adendo equipe | 🟡 `03-joinmarket-opcional.md` |
| Tails vs Whonix para Whirlpool | cap. 9 | 🟢 Tabela no livro + lab N3/04 |

---

## Nível 5 — O Trocador

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| eigenwallet no Whonix — swap BTC→XMR | integrado cap. 10 | 🟡 Lab `01-eigenwallet-whonix-btc-xmr.md` |
| RetoSwap — swap XMR→BTC | livro cap. 10 | 🟡 Lab `03-retoswap-xmr-btc.md` + `start-retoswap.sh` |
| **Feather Wallet no Tails — instalação** | REMOVIDO do cap. 10 | 🟡 Lab `02-feather-tails-instalacao.md` + `start-feather.sh` |
| Restore height Monero | integrado cap. 10 | 🟡 No lab `02` + cap. 10 |
| ABCTracer — defesa | integrado cap. 10 | 🟡 Lab `04-defesa-abctracer.md` |

---

## Nível 6 — O Soberano

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Regra backup 3-2-1 | cap. 11 | 🟡 `01-backup-3-2-1.md` |
| Scripts do operador | Manual Fortaleza / scripts | 🟡 `02-scripts-operador-tails.md` + 6/6 em `scripts/tails/` |
| Mobile CalyxOS + Sparrow | cap. 11 | 🟡 `03-mobile-calyxos.md` |
| Declaração cripto Brasil | cap. 11 + Ap. E | 🟡 `04-declaracao-cripto-brasil.md` |

---

## Nível 7 — O Mestre

| Lab proposto | Fonte original | Status |
| --- | --- | --- |
| Multisig 2-of-3 Trilha A | cap. 12 | 🟡 `01-multisig-2of3-trilha-a.md` |
| Qubes + Whonix opcional | cap. 12 Trilha D | 🟡 `02-qubes-whonix-opcional.md` |
| Ensinar outro Guardião | cap. 11 + 12 | 🟡 `03-ensinar-guardiao.md` |
| JoinMarket como maker | cap. 12 | 🟢 Coberto em N4/03 (`yield-generator.py`) |

---

## Scripts a curar (`laboratorio/scripts/`)

| Script | Fonte | Ambiente |
| --- | --- | --- |
| `start-sparrow.sh` | cap. 7 / lab N2 | Tails | 🟡 Extraído |
| `start-keepass.sh` | Manual Fortaleza / lab N2 | Tails | 🟡 Extraído |
| `start-electrum.sh` | Manual Fortaleza / cap. 7 | Tails | 🟡 Extraído |
| `start-feather.sh` | Manual Fortaleza / lab N5 | Tails | 🟡 Extraído |
| `start-retoswap.sh` | Manual Fortaleza / cap. 10 | Tails | 🟡 Extraído |
| `backup-persistencia.sh` | cap. 7 / Manual Fortaleza | Tails | 🟡 Extraído |

> **Regra:** texto claro, comentado linha a linha. Nunca binário de terceiros.
