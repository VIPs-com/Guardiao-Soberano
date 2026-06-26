# eigenwallet — swap BTC→XMR (Whonix)

> **Livro:** Capítulo 10 · Passos 5.3, 5.5, 5.6  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Whonix WS · eigenwallet 4.11.3 · Sparrow · Feather  

---

## Objetivo

Executar o primeiro **swap BTC→XMR** como taker no eigenwallet: UTXO pós-coinjoin → PSBT assinado no air-gap → XMR recebido na Feather.

> **Direção:** eigenwallet = **BTC→XMR**. Para XMR→BTC use RetoSwap — lab [`03-retoswap-xmr-btc.md`](03-retoswap-xmr-btc.md).

Diagrama do fluxo completo: `../../imagens/diagrama-swap.png` (coluna BTC→XMR).

---

## Pré-requisitos

- [ ] Whonix operacional — lab [`../nivel-3-observador/01-whonix-virtualbox-completo.md`](../nivel-3-observador/01-whonix-virtualbox-completo.md)
- [ ] Sparrow na Workstation (watching-only) + pasta `/mnt/psbt_bridge`
- [ ] Feather na Workstation (ou Tails com lab `02-feather-tails-instalacao.md`)
- [ ] UTXO **pós-coinjoin** com anonset ≥ 5 (Nível 4)
- [ ] Valor de teste: ex. **0.003 BTC**

---

## Passo 1 — Instalar eigenwallet

Na Whonix-Workstation:

```bash
mkdir -p ~/Applications && cd ~/Applications

scurl-download https://github.com/eigenwallet/core/releases/download/4.11.3/eigenwallet_4.11.3_amd64.AppImage
scurl-download https://github.com/eigenwallet/core/releases/download/4.11.3/eigenwallet_4.11.3_amd64.AppImage.asc

gpg --verify eigenwallet_4.11.3_amd64.AppImage.asc eigenwallet_4.11.3_amd64.AppImage
chmod +x eigenwallet_4.11.3_amd64.AppImage
```

Tor automático via Gateway Whonix (porta 9050).

---

## Passo 2 — Zonas no Sparrow

| Carteira (mesma xpub) | Função |
| --- | --- |
| `Postmix_Whonix` | UTXOs pós-coinjoin |
| `Swap_Ready_Whonix` | UTXO isolado para este swap |

1. Em Postmix: selecione UTXO de teste → **Send to** → Swap_Ready (1 confirmação)
2. Anote TXID no KeePassXC

---

## Passo 3 — Endereços frescos

**XMR (Feather):** Receive → New address → anotar `Swap eigen YYYY-MM-DD #1`

**BTC change (Sparrow):** Swap_Ready → Addresses → endereço **nunca usado** → anotar `Change eigen #1`

---

## Passo 4 — Executar swap

```bash
~/Applications/eigenwallet_4.11.3_amd64.AppImage
```

1. Direção: **BTC → XMR**
2. List Sellers → escolha maker (≥10 swaps, bond alto)
3. Preencha:
   - Bitcoin amount (ex. 0.003)
   - Refund/change address (Sparrow)
   - Monero address (Feather subaddress)
4. Criar transação → exportar PSBT

---

## Passo 5 — Assinar PSBT (air-gap)

**Via pasta compartilhada:**

```
eigenwallet → salvar PSBT → /mnt/psbt_bridge/swap.psbt
host → MicroSD → Coldcard Ready to Sign → assinar
SD → /mnt/psbt_bridge/swap-signed.psbt → eigenwallet importar
```

Alternativa: lab N2 [`02-primeiro-psbt.md`](../nivel-2-carteira-fria/02-primeiro-psbt.md) (QR/SD).

---

## Passo 6 — Aguardar conclusão

- Não suspender VMs (25–90 min típico)
- eigenwallet monitora BTC + XMR via Tor
- Feather → History → XMR aparece
- Aguardar **10 confirmações** Monero (~20 min)

Registre no KeePassXC: TXID BTC, TXID/valor XMR, timestamp, maker.

---

## Como confirmar que deu certo

- [ ] `gpg --verify` do AppImage antes do uso
- [ ] Swap completou sem timeout/refund inesperado
- [ ] XMR no Feather bate (menos fee do maker)
- [ ] Change BTC em endereço virgem no Sparrow
- [ ] Você **não** iniciou swap reverso no mesmo dia (ver lab ABCTracer)

---

## Próximo passo

Aguardar intervalo (24h–7 dias) → [`03-retoswap-xmr-btc.md`](03-retoswap-xmr-btc.md) · [`04-defesa-abctracer.md`](04-defesa-abctracer.md)

---

## Referências

- Livro: `manuscrito/10-nivel-5-trocador.md` (tutorial eigenwallet)
- https://github.com/eigenwallet/core
