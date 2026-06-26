# Primeiro PSBT — criar, assinar offline, transmitir

> **Livro:** Capítulo 7 · Passo 2.6 · Cap. 6 (fluxo PSBT QR)  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Tails 7.9 · Sparrow 2.5.2 · dispositivo air-gapped (Coldcard / SeedSigner / Krux)  

---

## Objetivo

Executar o **ciclo PSBT completo** pela primeira vez: Sparrow (watching-only) cria a transação → dispositivo offline **assina** → Sparrow **transmite** via Tor. A seed **nunca** entra no Tails.

```
Sparrow (online)  →  air-gap (SD ou QR)  →  HW assina  →  Sparrow broadcast
```

Diagrama: `../../imagens/diagrama-psbt.png`

---

## Pré-requisitos

- [ ] Lab [`01-sparrow-watching-only.md`](01-sparrow-watching-only.md) — carteira watching-only com saldo de teste
- [ ] Dispositivo air-gapped com seed carregada (Nível 1)
- [ ] Endereço de destino anotado **fora** do Tails (papel) para comparar na tela do HW
- [ ] Valor de teste pequeno: ex. **0.00005 BTC** (~5.000 sats)

---

## Antes de começar — regra de ouro

| Onde verificar | O quê |
| --- | --- |
| **Tela do dispositivo air-gapped** | Endereço destino, valor, taxa, change |
| **Nunca só no Sparrow** | Um malware no Tails poderia mostrar dados falsos |

Confirme **na tela física** do signer antes de apertar o botão de assinar.

---

## Parte 1 — Criar transação no Sparrow

1. Abra Sparrow (`start-sparrow.sh`) → carteira watching-only
2. Aba **Send**
3. Preencha:
   - **Pay to:** endereço de destino (seu ou de teste)
   - **Amount:** `0.00005` BTC (ou mínimo que cubra fee)
   - **Fee:** medium ou manual (use **Calculate**)
4. **Create Transaction**
5. Revise na tela:
   - Inputs (UTXOs corretos?)
   - Outputs (destino + change)
   - Change address é **seu** (derivado da mesma xpub)
6. **Finalize Transaction for Signing**

Você deve ver opções de exportar para assinatura (QR ou arquivo).

---

## Trilha A — MicroSD (Coldcard e similares)

### A1. Exportar PSBT para o SD

1. Sparrow → **Save Transaction** (ou **Export** → PSBT to file)
2. Salve no MicroSD: ex. `tx.psbt`
3. Ejeta o SD com segurança

### A2. Assinar no Coldcard (offline)

1. Insira o SD no **Coldcard** (sem USB conectado ao PC)
2. Menu: **Ready To Sign** → selecione `tx.psbt`
3. Tela mostra:
   - Endereço de destino (compare dígitos **início e fim**)
   - Valor em sats/BTC
   - Network fee
   - Change address
4. Se **tudo** confere → confirme com botão físico
5. Coldcard grava PSBT assinado no SD (ex. `tx-signed.psbt`)

### A3. Importar e transmitir

1. SD de volta ao Tails
2. Sparrow → **File → Open Transaction** → selecione PSBT assinado
3. Verifique assinaturas: **1 of 1** (single-sig)
4. **Broadcast Transaction**
5. Copie TXID → aguarde confirmação na aba **Transactions**

---

## Trilha B — QR animado (SeedSigner / Krux)

### B1. Sparrow exibe PSBT como QR

1. Após **Finalize Transaction for Signing** → **Show QR** (ou **Show BBQR**)
2. Janela com QR animado **UR:CRYPTO-PSBT**
3. Mantenha visível até o signer terminar de escanear

> Tails: habilite webcam em **Applications → Webcam** se necessário.

### B2. SeedSigner escaneia e assina

1. SeedSigner ligado, seed carregada
2. **Scan** (ou Sign → PSBT → Scan QR)
3. Aponte câmera do SeedSigner para o monitor do Tails
4. Aguarde todos os frames (pode levar segundos)
5. **Revise na tela do SeedSigner:**
   - Destination address
   - Amount
   - Fee
   - Change address
6. Confirme → SeedSigner exibe **QR assinado** (novo animado)

### B3. Krux (alternativa)

1. **Sign → PSBT → Load from camera**
2. Escaneie QR do Sparrow
3. Revise → **Sign to QR code**

### B4. Sparrow importa assinatura e transmite

1. Feche janela do QR de saída (se ainda aberta)
2. Sparrow → **Scan QR** / **Scan BBQR**
3. Webcam apontada para tela do signer
4. Assinatura importada → **1 of 1**
5. **Broadcast Transaction** → anote TXID

---

## Diagrama do fluxo

```
┌─────────────┐     PSBT      ┌──────────────┐     assinado    ┌─────────────┐
│   Sparrow   │ ────────────► │  SD ou QR    │ ──────────────► │  HW offline │
│  (Tails)    │               │  (air-gap)   │                 │  Coldcard/  │
│ watch-only  │ ◄──────────── │              │ ◄────────────── │  SeedSigner │
└─────────────┘   PSBT signed └──────────────┘                 └─────────────┘
       │
       ▼ Broadcast via Tor
   Rede Bitcoin
```

---

## Como confirmar que deu certo

- [ ] Transação aparece em **Transactions** com status confirmando
- [ ] TXID consultável em explorer via Tor (ou Sparrow)
- [ ] Saldo diminuiu (valor + fee)
- [ ] Destino recebeu os sats esperados
- [ ] Aba **Signing** do Sparrow **continua vazia** (sem chave privada local)
- [ ] Você assinou **somente** após verificar na tela do HW
- [ ] Consegue repetir o fluxo sem anotar a seed em lugar nenhum do Tails

### Teste de conforto (recomendado)

Repita 2–3 vezes com valores mínimos até o fluxo for automático antes de valores maiores.

---

## Se der errado

| Problema | Solução |
| --- | --- |
| QR não escaneia | Iluminação, distância, câmera estável; tente BBQR |
| "Insufficient funds" | Aguarde confirmação do receive anterior |
| Fee muito alta | Ajuste fee rate; verifique tamanho da transação |
| Assinatura rejeitada | Script type mismatch (segwit vs taproot) — refaça wallet export |
| Broadcast falha | Tor/conexão servidor Electrum — ver lab 01 passo servidor |
| Change para endereço estranho | **Não assine** — pode ser ataque ou wallet errada |

Livro: **Apêndice F** · Cap. 6 tutorial PSBT QR

---

## Multisig (nota)

Fluxo idêntico, mas Sparrow mostra **1 of 2** (ou M-of-N) até todas as assinaturas. Cada signer assina o mesmo PSBT em sequência. Aprofundamento: Cap. 12 — Trilha A multisig.

---

## O que você provou ao concluir

> O computador **cria** e **transmite**. O dispositivo **assina**. A seed **nunca** tocou a rede.

Isso completa o **Nível 2 — A Carteira Fria** no aspecto operacional. Próximo marco: **Nível 3 — Whonix e nó próprio** (livro Cap. 8).

---

## Referências

- Livro: `manuscrito/07-nivel-2-carteira-fria.md` (passo 2.6)
- Livro: `manuscrito/06-nivel-1-cofre.md` (tutorial PSBT QR)
- [Sparrow — Send transactions](https://sparrowwallet.com/docs/send-transactions.html)

---

*Extraído do manuscrito caps 6–7. Duas trilhas: SD (Coldcard) e QR (SeedSigner/Krux).*
