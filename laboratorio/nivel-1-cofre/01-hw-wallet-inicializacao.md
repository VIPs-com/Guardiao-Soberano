# Inicialização air-gapped (genérico)

> **Livro:** Capítulo 6 · Passos 1.0–1.6  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Hardware:** Coldcard · Jade · Passport · SeedSigner · Krux (escolha um)  

---

## Objetivo

Adquirir, verificar e configurar um **dispositivo air-gapped** com seed de dados físicos, passphrase e validação de endereços — **sem** a seed tocar um PC online.

```
Compra discreta → firmware PGP → dice rolls → passphrase → validar xpub OFFLINE
```

---

## Pré-requisitos

- [ ] Nível 0 — entropia com dados + backup em metal planejado
- [ ] MicroSD dedicado (firmware + export xpub)
- [ ] `bip39.html` no pendrive para validação offline (Passo 1.6)

---

## Passo 1 — Escolha e compra (Passo 1.0–1.1)

Escolha **um** dispositivo (livro: tabela Coldcard, Jade, Passport, SeedSigner, Krux).

| Ação | Detalhe |
| --- | --- |
| Compra | Site oficial ou peças (DIY) |
| Entrega | PO Box, familiar, ou retirada — evite nome óbvio |
| Pagamento | BTC ou gift card, se possível |

---

## Passo 2 — Integridade física (Passo 1.2)

- [ ] Embalagem antiviolação intacta (HW comercial)
- [ ] Número de série caixa = tela do dispositivo
- [ ] DIY: firmware flashado por você + hash verificado

**Suspeita de adulteração → devolver, não usar.**

---

## Passo 3 — Firmware (Passo 1.3)

1. Em PC **com internet**: baixe firmware do site oficial
2. Verifique **assinatura PGP** (Apêndice D)
3. Copie para MicroSD
4. No dispositivo **sem USB de dados**: Upgrade Firmware
5. Confirme versão na tela

**Nunca** conecte o signer à internet via USB.

---

## Passo 4 — Seed com dice rolls (Passo 1.4)

1. Menu: **New Wallet** → **Dice Rolls** (não "Quick Generate")
2. Insira os lançamentos do Nível 0 (100+)
3. Dispositivo exibe 24 palavras
4. Anote em papel temporário → grave em metal (lab N0/02)
5. Confirme palavras na tela do dispositivo

---

## Passo 5 — Passphrase (Passo 1.5)

1. **Add Passphrase** — use a frase do Nível 0
2. Tela: `Passphrase: Set`
3. Sem passphrase = carteira **vazia** (proteção sob coerção)

---

## Passo 6 — Validar endereços (Passo 1.6)

1. Exporte **xpub** para MicroSD ou QR
2. PC **offline** + `bip39.html`:
   - Insira 24 palavras + passphrase
   - Derive `m/84'/0'/0'/0/0` (Native SegWit)
3. Compare com endereço na tela do dispositivo
4. Confira também o **5º** e **15º** endereços

**Não bate → pare. Regrave seed ou refaça setup.**

---

## Como confirmar que deu certo

- [ ] Firmware atualizado e PGP verificado
- [ ] Seed gerada por dice rolls, não RNG rápido
- [ ] Passphrase ativa; você sabe o efeito da carteira "vazia"
- [ ] Endereços BIP84 batem offline
- [ ] Dispositivo nunca conectado à internet
- [ ] 2 backups metal + passphrase em local separado

---

## Próximos labs

- [`02-teste-restauracao.md`](02-teste-restauracao.md) — **obrigatório** antes de fundos
- [`03-psbt-via-qr.md`](03-psbt-via-qr.md) — export xpub e fluxo QR
- Nível 2 — Sparrow watching-only + primeiro PSBT

---

## Se der errado

- Endereços não batem → seed/passphrase/derivation path incorretos
- Firmware falha → rebaixe para release anterior assinada
- Livro: Cap. 6 · Apêndice D · Apêndice F
