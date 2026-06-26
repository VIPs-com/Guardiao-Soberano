# Mobile CalyxOS — Sparrow watch-only + Tor

> **Livro:** Capítulo 11 · Passo 6.2  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** CalyxOS ou GrapheneOS · Sparrow Mobile · Orbot · KeePassDX  

---

## Objetivo

Configurar celular **dedicado** (não o pessoal) como terminal **watch-only**: ver saldo, montar PSBT, escanear QR do air-gap e transmitir — **sem chaves privadas** no telefone.

---

## Pré-requisitos

- [ ] Pixel 6a+ usado, bootloader desbloqueável
- [ ] xpub exportada do dispositivo air-gapped (N1)
- [ ] Entender: mobile **não** é cold storage

---

## Passo 1 — Hardware e OS

1. **Não** use o celular do dia a dia
2. Instale [CalyxOS](https://calyxos.org/) ou [GrapheneOS](https://grapheneos.org/)
3. Trave bootloader após instalação
4. Criptografia de disco **ativada** (setup inicial)

---

## Passo 2 — Apps (F-Droid / Aurora)

| App | Função |
| --- | --- |
| **Orbot** | Tor forçado para apps |
| **Sparrow Wallet** | BTC watch-only + PSBT QR |
| **Feather** (opcional) | Monitor XMR watch-only |
| **KeePassDX** | Senhas (cofre exportado com cuidado) |

Evite Google Play em conta pessoal.

---

## Passo 3 — Sparrow watch-only

1. Orbot → modo VPN ou per-app para Sparrow
2. Sparrow → **New Wallet** → importar xpub
3. Escaneie QR do dispositivo air-gapped (mesma xpub do Tails/Whonix)
4. Confira endereço Receive `0/0` com o signer

---

## Passo 4 — Fluxo PSBT no mobile

1. Sparrow mobile → **Send** → criar transação
2. **Show QR** para assinatura
3. Dispositivo air-gapped escaneia e assina
4. Sparrow mobile **Scan QR** da assinatura
5. **Broadcast** via Tor

Mesma regra: confirme valor/endereço na **tela do signer**.

---

## Passo 5 — Cake Wallet (opcional, casual)

Para valores **pequenos** e uso casual:

- Multi-coin, swap integrado
- **Não** substitui Tails/Whonix para swaps grandes
- Cap. 11: função secundária apenas

---

## Como confirmar que deu certo

- [ ] Sparrow mostra saldo correto (mesma xpub)
- [ ] Nenhuma seed/private key no telefone
- [ ] Tráfego via Tor (Orbot ativo)
- [ ] PSBT de teste assinado no air-gap e transmitido do mobile

---

## Se der errado

| Problema | Ação |
| --- | --- |
| Saldo zero | xpub errada ou derivation path diferente |
| Broadcast falha | Orbot desligado ou Tor lento |
| Livro | Cap. 11 passo 6.2 · Apêndice F |

---

## Referências

- [CalyxOS](https://calyxos.org/)
- [Sparrow Wallet](https://sparrowwallet.com/)
