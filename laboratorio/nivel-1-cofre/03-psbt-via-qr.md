# Fluxo PSBT via QR — xpub e assinatura air-gap

> **Livro:** Capítulo 6 · tutorial PSBT QR · Cap. 7 passo 2.6  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Sparrow 2.5.2 · SeedSigner / Krux / Jade / Passport (QR)  

---

## Objetivo

Dominar o **caminho QR** do PSBT: exportar xpub por QR, assinar transação com QR animado (UR/BBQR) e devolver assinatura — sem MicroSD.

```
Sparrow (xpub QR) → watch-only → PSBT QR out → signer → PSBT QR in → broadcast
```

Para ciclo completo com valores de teste, combine com [`../nivel-2-carteira-fria/02-primeiro-psbt.md`](../nivel-2-carteira-fria/02-primeiro-psbt.md).

Diagrama: `imagens/diagrama-psbt.png`

---

## Pré-requisitos

- [ ] Dispositivo com **câmera** e suporte PSBT QR (SeedSigner, Krux, Jade, Passport…)
- [ ] Labs N1/01 e N1/02 concluídos
- [ ] Sparrow instalado (Tails ou Whonix) — ver Nível 2
- [ ] Boa iluminação e webcam estável (QR animado)

---

## Parte 1 — Exportar xpub via QR

**No dispositivo air-gapped (offline):**

1. Menu → **Export** / **XPUB** / **Multisig setup**
2. Exiba QR do xpub/zpub (derivation `m/84'/0'/0'`)

**No Sparrow:**

1. **File → New Wallet** → importar keystore
2. **Connected Hardware Wallet** ou **Airgapped** → **Scan QR**
3. Aponte webcam para o signer
4. Confirme fingerprint e derivation path
5. Crie carteira **watching-only**

---

## Parte 2 — Criar PSBT (online coordinator)

1. Sparrow → **Send** → preencha destino, valor, fee
2. **Create Transaction** → revise inputs/outputs
3. **Finalize Transaction for Signing**
4. **Show QR** (ou **Show BBQR** se transação grande)

Deixe o QR **animado** na tela do Sparrow.

---

## Parte 3 — Assinar no signer

**SeedSigner / Krux:**

1. **Sign → PSBT → Scan QR**
2. Aponte câmera do signer para o monitor
3. Revise na **tela do signer**: destino, valor, fee, change
4. Confirme fisicamente → **Sign to QR**

**Jade / Passport:** fluxo equivalente (Load from camera → Sign).

> **Regra de ouro:** confie na tela do **signer**, não só no Sparrow.

---

## Parte 4 — Importar assinatura

1. Sparrow → **Scan QR** / **Scan BBQR**
2. Aponte webcam para QR do signer assinado
3. Status: assinatura completa
4. **Broadcast Transaction** (via Tor)

---

## Dicas QR

| Problema | Solução |
| --- | --- |
| QR não lê | Ajuste distância, brilho da tela, luz ambiente |
| Tx grande | BBQR/UR em múltiplos frames — mantenha câmera fixa |
| Falha parcial | Use MicroSD como fallback (lab N2/02 Trilha A) |

---

## Como confirmar que deu certo

- [ ] xpub importada — endereço Receive bate com o dispositivo
- [ ] PSBT assinado sem a seed no PC online
- [ ] Tx com txid no mempool/explorer via Tor
- [ ] Você alterna SD ↔ QR conforme o cenário

---

## Se der errado

- Assinatura rejeitada → fee ou inputs alterados; recrie PSBT
- Endereço change estranho → **não assine** — malware ou carteira errada
- Livro: Cap. 6 tutorial QR · Apêndice F
