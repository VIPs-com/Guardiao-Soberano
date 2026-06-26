# Whirlpool — primeiro mix (Sparrow no Whonix)

> **Livro:** Capítulo 9 · Passos 4.2–4.6  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Whonix WS · Sparrow 2.5.2 · Whirlpool (coordinator comunitário)  

---

## Objetivo

Executar o **primeiro CoinJoin Whirlpool** com anonset ≥ 5: estrutura de carteiras, premix, rounds automáticos, mover para Postmix.

```
UTXO sujo → Premix → Whirlpool (rounds) → Postmix (anonset ≥ 5)
```

Diagrama: `../../imagens/diagrama-whirlpool.png`

---

## Pré-requisitos

- [ ] Whonix operacional — [`../nivel-3-observador/01-whonix-virtualbox-completo.md`](../nivel-3-observador/01-whonix-virtualbox-completo.md)
- [ ] Sparrow na Workstation (watching-only, mesma xpub do air-gap)
- [ ] **≥ 0.01 BTC** para pool 0.01 (teste) + fees
- [ ] VM pode ficar ligada **horas** (ideal 24/7 durante rounds)

---

## Passo 1 — Três carteiras (mesma xpub)

No Sparrow, crie **três carteiras** importando a **mesma** xpub:

| Nome | Função |
| --- | --- |
| `Whirlpool_Whonix` | UTXOs a misturar ("sujos") |
| `Postmix_Whonix` | UTXOs pós-CJ com anonset ≥ 5 |
| `Swap_Ready_Whonix` | Reservado para Nível 5 (swap) |

**Regra de ouro:** nunca consolidar Postmix com não-misturado.

---

## Passo 2 — Configurar Whirlpool

Sparrow → aba **Whirlpool** → **Settings**:

| Campo | Valor |
| --- | --- |
| Coordinator | Automático (comunitário via Tor — Apêndice B) |
| Pool | **0.01 BTC** (primeiro teste) |
| Target anonset | **5** mínimo, **10+** ideal |
| Modo | **Remix automático** |

> O Sparrow conecta ao coordinator comunitário via Tor. Não configure clearnet.

---

## Passo 3 — Premix

1. Em `Whirlpool_Whonix`, selecione UTXO ≥ 0.01 BTC (não misturado)
2. Botão direito → **Mix to Whirlpool** → pool 0.01
3. Revise outputs, change, coordinator fee
4. PSBT → assinar no air-gap → transmitir
5. Aguarde **1 confirmação**

---

## Passo 4 — Mixagem (deixar rodando)

1. Aba Whirlpool → **Start**
2. Estados esperados:
   - `Registered` → output no coordinator
   - `Signing` → round ativo
   - `Remixing` → completou round, entra em outro

| Rounds | Tempo típico |
| --- | --- |
| 1 | 20–60 min |
| 5 | 2–8 h |
| 10 | 5–20 h |

- Não desligar VM durante round ativo
- Snapshot VirtualBox antes de sessão longa: `pre_whirlpool_YYYY-MM-DD`

---

## Passo 5 — Mover para Postmix

1. UTXOs com **anonset ≥ 5** → ícone azul no Sparrow
2. Selecionar → **Send to** → `Postmix_Whonix`
3. PSBT → air-gap → transmitir
4. Rotular no Sparrow: `CJ Round N — anonset X`

---

## Como confirmar que deu certo

- [ ] Pelo menos um UTXO em Postmix com anonset ≥ 5
- [ ] Você entende a diferença Premix / Postmix / Swap_Ready
- [ ] Não consolidou UTXO limpo com sujo
- [ ] Coordinator acessível só via Tor (sem erro de rede clearnet)
- [ ] Snapshot da VM salvo antes da sessão longa

---

## Se der errado

| Problema | Solução |
| --- | --- |
| Round travado em Signing | Aguardar; verificar Tor; reiniciar Sparrow (não a VM no meio do round) |
| Anonset não sobe | Poucos peers no pool; deixar remix automático mais tempo |
| Perdeu estado após reboot | Whonix persiste — reabrir Sparrow; se Tails, prefira Whonix para CJ |
| Coordinator offline | Alternativa: lab `03-joinmarket-opcional.md` (futuro) |

Livro: **Cap. 9** · Apêndice B (coordinator) · Apêndice F

---

## Próximo lab

Coin control e rotulagem: [`02-coin-control-postmix.md`](02-coin-control-postmix.md)

---

## Referências

- Livro: `manuscrito/09-nivel-4-misturador.md`
- Apêndice B: Whirlpool coordinator comunitário
- https://sparrowwallet.com/docs/coinjoin.html
