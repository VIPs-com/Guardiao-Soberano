# Checklist mestre Fase 1 — visão dos 7 níveis (opcional)

> **Livro:** Cap. 5–12 (trilha completa)  
> **Último teste:** 2026-06-25 (conteúdo consolidado — revalidar em hardware)  
> **Fonte:** pesquisa `fase1 checklist mestre autocus` (adaptado para labs atuais)  

---

## Objetivo

Ter **uma página** que mapeia a jornada “Fase 1 — porta de entrada” (Tails + air-gap) para os **labs já extraídos**, sem duplicar passos. Use como mapa de progresso antes de avançar para Whonix (Fase 2).

---

## A — Hardware (antes de software)

| Item | Lab / livro |
| --- | --- |
| Adquirir dispositivo air-gapped | N1 [`01-hw-wallet-inicializacao.md`](../nivel-1-cofre/01-hw-wallet-inicializacao.md) |
| Verificar integridade física | N1/01 Passo 2 |
| Backup metal + dice | N0 [`01`](../nivel-0-semente/01-gerar-seed-dados.md) + [`02`](../nivel-0-semente/02-backup-aco.md) |
| Dice rolls no dispositivo | N1/01 Passo 4 |

---

## B — Seed (air-gapped)

| Item | Lab |
| --- | --- |
| Inicializar com dice rolls | N1/01 |
| Passphrase 25ª palavra | N0/02 |
| Validar Ian Coleman offline | N0/01 + N1/01 Passo 6 |
| **Restore antes de fundos** | N1 [`02-teste-restauracao.md`](../nivel-1-cofre/02-teste-restauracao.md) |

---

## C — Tails (por sessão)

| Item | Lab |
| --- | --- |
| Tails verificado + persistência | N2 [`05-tails-setup-btc-xmr-completo.md`](../nivel-2-carteira-fria/05-tails-setup-btc-xmr-completo.md) |
| Tor ativo | N2/05 + Apêndice F |
| KeePassXC | N2 [`03-keepassxc-tails.md`](../nivel-2-carteira-fria/03-keepassxc-tails.md) |

---

## D — Ferramentas no Tails

| Ferramenta | Lab | Script |
| --- | --- | --- |
| Sparrow + PGP | N2/01, N3/03 | `start-sparrow.sh` |
| Electrum | N2/04 | `start-electrum.sh` |
| Feather | N5/02 | `start-feather.sh` |
| eigenwallet | N5/01 (Whonix) ou N2/05 | — |
| RoboSats | N0/03 | Tor Browser |
| RetoSwap | N5/03 | `start-retoswap.sh` |

---

## E — Watching-only + PSBT

| Item | Lab |
| --- | --- |
| Import xpub | N2 [`01-sparrow-watching-only.md`](../nivel-2-carteira-fria/01-sparrow-watching-only.md) |
| PSBT SD ou QR | N1 [`03-psbt-via-qr.md`](../nivel-1-cofre/03-psbt-via-qr.md) + N2 [`02-primeiro-psbt.md`](../nivel-2-carteira-fria/02-primeiro-psbt.md) |

---

## F — Primeiro swap (teste pequeno)

| Item | Lab |
| --- | --- |
| Subendereço XMR novo | N5/02 |
| BTC→XMR eigenwallet | N5/01 |
| Intervalo temporal (ABCTracer) | N5 [`04-defesa-abctracer.md`](../nivel-5-trocador/04-defesa-abctracer.md) |
| XMR→BTC RetoSwap | N5/03 |

---

## Critério “Fase 1 completa”

- [ ] N0 + N1 verificados (seed, metal, restore)
- [ ] N2 labs 01–05 em Tails real
- [ ] N5 labs 02–04 com valor mínimo
- [ ] Backup 3-2-1 rodado uma vez — N6 [`01`](../nivel-6-soberano/01-backup-3-2-1.md)

Depois: migrar ou paralelizar **Whonix** (N3) para mixagem e node próprio.

---

## Referência

Mapa completo de validação em hardware: `soberano-equipe-dev/VALIDACAO-LABORATORIO-29.md` (equipe interna).
