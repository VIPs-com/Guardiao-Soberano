# Multisig 2-of-3 — Trilha A (Sparrow + air-gap)

> **Livro:** Capítulo 12 · Trilha A — Multisig 2-of-2 e 2-of-3  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Tails · Sparrow 2.5.2 · 2–3 signers air-gapped  

---

## Objetivo

Montar carteira **2-of-3** no Sparrow: três seeds independentes, backup do **output descriptor**, teste em testnet e primeiro gasto em mainnet com **duas** assinaturas via PSBT QR.

```
3 xpubs → descriptor backup → fundos teste → PSBT → 2 assinaturas → broadcast
```

Para 2-of-2 (mais rígido), use `M of N: 2 of 2` — comunidade prefere **2-of-3** em produção.

---

## Pré-requisitos

- [ ] Domínio do fluxo PSBT single-sig — [`../nivel-2-carteira-fria/02-primeiro-psbt.md`](../nivel-2-carteira-fria/02-primeiro-psbt.md)
- [ ] 2–3 dispositivos air-gapped **ou** combinação signer + seed offline
- [ ] Metal backup para **cada** seed + descriptor em local seguro

---

## Passo 1 — Gerar 3 seeds (offline)

Para cada keystore:

1. Novo dispositivo ou sessão limpa
2. **Dice rolls** — nunca reutilize seed do cofre principal
3. Backup em metal
4. Exporte **xpub/zpub** via QR (`m/84'/0'/0'`)

Sugestão: SeedSigner + Krux + terceira seed em segundo DIY.

---

## Passo 2 — Criar wallet no Sparrow

1. **File → New Wallet** → nome ex: `Vault2of3`
2. **Policy Type:** Multi Signature
3. **M of N:** **2 of 3**
4. **Script Type:** Native SegWit (P2WPKH)
5. Adicione 3 keystores → **Air Gapped** → Scan QR de cada xpub
6. **Apply / Create Wallet**

---

## Passo 3 — Backup do descriptor (obrigatório)

1. Wallet → **Settings**
2. Export **Output Descriptor** ou **BSMS**
3. Salve em:
   - USB LUKS criptografado
   - Papel em envelope selado (redundância)
4. **Sem descriptor + 2 seeds, recuperação é difícil**

---

## Passo 4 — Testnet primeiro

1. **File → Preferences → Testnet**
2. Receba faucet BTC testnet
3. Envie gasto assinando com **2 de 3** signers:
   - Sparrow cria PSBT QR
   - Signer 1 assina → QR parcial
   - Sparrow importa → Signer 2 assina
   - Broadcast quando "2 of 2 signatures" (de 3 possíveis)

---

## Passo 5 — Mainnet (valor pequeno)

1. Desative testnet
2. Deposite quantia mínima
3. Repita fluxo PSBT QR
4. Verifique txid via Tor

---

## 2-of-2 vs 2-of-3

| Config | Perde 1 seed | Segurança |
| --- | --- | --- |
| 2-of-2 | Fundos **presos** | Máxima exigência de ambas |
| 2-of-3 | Ainda gasta com 2 restantes | **Recomendado** produção |

---

## Como confirmar que deu certo

- [ ] Descriptor exportado e armazenado em 2+ locais
- [ ] Testnet: gasto com 2 assinaturas OK
- [ ] Mainnet: tx pequena confirmada
- [ ] Você sabe qual par de signers usa no dia a dia (terceiro = backup/offsite)

---

## Se der errado

| Problema | Ação |
| --- | --- |
| "1 of 2" travado | Falta segunda assinatura — importe QR do 2º signer |
| Endereço diferente após restore | Descriptor ou ordem dos xpubs errada |
| Livro | Cap. 12 Trilha A · Apêndice F |

---

## Próximo (Nível 7)

[`02-qubes-whonix-opcional.md`](02-qubes-whonix-opcional.md) — Trilha D defesa máxima
