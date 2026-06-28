# Inicialização air-gapped (genérico)

> **Livro:** Capítulo 6 · Passos 1.0–1.7 (incl. 1.6b metal)
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Hardware:** Coldcard · Jade · Passport · SeedSigner · Krux (escolha um)  

---

## Objetivo

Adquirir, verificar e configurar um **dispositivo air-gapped** com seed de dados físicos, passphrase e validação de endereços — **sem** a seed tocar um PC online.

```
Compra discreta → firmware PGP → dice rolls → passphrase → validar offline → metal → restore test
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
2. Lance os dados **no próprio dispositivo** (100+ entradas) — **não** reutilize a simulação do N0/01; aqui nasce a seed **definitiva**
3. Dispositivo exibe 24 palavras
4. Anote em papel temporário → grave em metal (lab N0/02 ou Passo 6b)
5. Confirme palavras na tela do dispositivo

---

## Passo 5 — Passphrase (Passo 1.5)

1. **Add Passphrase** — use a frase do Nível 0
2. Tela: `Passphrase: Set`
3. Sem passphrase = carteira **decoy** (proteção sob coerção)

---

## Passo 6 — Validar endereços (Passo 1.6)

1. Exporte **xpub** para MicroSD ou QR
2. PC **offline** + `bip39.html` (hash SHA256 verificado)
3. Derive `m/84'/0'/0'/0/0` (Native SegWit) — compare 1º, 5º e 15º endereços
4. Ver caixa ⚠️ Lei 4 no livro (única exceção para digitar seed em PC)

**Não bate → pare. Regrave seed ou refaça setup.**

---

## Passo 6b — Gravar em metal (Passo 1.6b)

- [ ] **Antes** do teste destrutivo — Cap. 5 Passo 0.5 + lab [`N0/02-backup-aco.md`](../nivel-0-semente/02-backup-aco.md)
- [ ] 2 cópias metal + passphrase em Local C
- [ ] Queimar papel temporário

---

## Passo 7 — Teste de restauração (Passo 1.7)

1. Apague seed no dispositivo (menu varia — ver livro)
2. Restore from 24 words + passphrase
3. Exporte endereços e compare com Passo 6

**Não bate → nunca envie fundos. Regrave metal e repita.**

---

## Como confirmar que deu certo

- [ ] Firmware atualizado e PGP verificado
- [ ] Seed gerada por dice rolls, não RNG rápido
- [ ] Passphrase ativa; você sabe o efeito da carteira decoy
- [ ] Endereços BIP84 batem offline
- [ ] 2 backups metal **antes** do destroy test
- [ ] Teste de restauração (Passo 1.7) OK
- [ ] Dispositivo nunca conectado à internet

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
