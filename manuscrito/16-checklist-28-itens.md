# Capítulo 16 — Checklist Operacional (28 Itens)

> "Não confie na memória. Confira a lista"

---

## Objetivo

Fornecer um checklist completo e acionável para verificar cada componente do ecossistema antes de operações críticas.

---

## A — Hardware (antes de qualquer software)

- [ ] **A1** — Adquirir Coldcard MK5 (ou SeedSigner/Krux/Jade/Passport)
- [ ] **A2** — Verificar integridade física (bag antiviolação, número de série)
- [ ] **A3** — Preparar material de backup físico (placa de aço, kit de arruelas)
- [ ] **A4** — Preparar dados de casino para entropia (99+ lançamentos)

---

## B — Geração de Seed (air-gapped, offline)

- [ ] **B1** — Inicializar dispositivo com dice rolls (99 lançamentos mínimo)
- [ ] **B2** — Anotar e gravar seed BIP39 em metal (24 palavras)
- [ ] **B3** — Configurar passphrase BIP39 forte (25ª palavra)
- [ ] **B4** — Validar seed com Ian Coleman OFFLINE (Tails sem rede)
- [ ] **B5** — Testar recuperação: apagar dispositivo e restaurar com seed

---

## C — Ambiente Tails (por sessão)

- [ ] **C1** — Baixar e verificar Tails OS (OpenPGP)
- [ ] **C2** — Configurar Persistent Storage com senha forte
- [ ] **C3** — Confirmar conexão Tor (check.torproject.org)

---

## D — Instalar e verificar ferramentas

- [ ] **D1** — Electrum (pré-instalado) conectado a servidor `.onion`
- [ ] **D2** — Sparrow Wallet AppImage verificada (PGP Craig Raw)
- [ ] **D3** — Feather Wallet AppImage verificada (PGP)
- [ ] **D4** — eigenwallet AppImage verificada (PGP binarybaron)
- [ ] **D5** — RoboSats acessível via Tor Browser (`.onion` verificado)
- [ ] **D6** — KeePassXC configurado com banco cifrado (AES-256)

---

## E — Watching-only wallet (Sparrow + dispositivo)

- [ ] **E1** — Exportar xpub do dispositivo para Sparrow (`.json` ou QR)
- [ ] **E2** — Sparrow configurado em modo watching-only (sem chave privada)
- [ ] **E3** — Testar ciclo PSBT completo com valor mínimo (0.00005 BTC)

---

## F — Primeiro swap BTC→XMR (teste)

- [ ] **F1** — Gerar subendereço XMR fresco no Feather
- [ ] **F2** — Preparar endereço BTC de change virgem no Sparrow
- [ ] **F3** — Executar swap de teste (~0.003 BTC) no eigenwallet
- [ ] **F4** — Confirmar recebimento XMR no Feather (10 confirmações)
- [ ] **F5** — Aguardar intervalo mínimo de 24h antes de qualquer saída do XMR

---

## G — CoinJoin (Whirlpool)

- [ ] **G1** — Configurar Sparrow para pool Whirlpool (coordinator `.onion`)
- [ ] **G2** — Executar primeiro mix e aguardar pelo menos 2 remixes adicionais

---

## Resumo

| Seção | Itens |
| --- | --- |
| A — Hardware | 4 |
| B — Geração de Seed | 5 |
| C — Ambiente Tails | 3 |
| D — Ferramentas | 6 |
| E — Watching-only | 3 |
| F — Primeiro swap | 5 |
| G — CoinJoin | 2 |
| **TOTAL** | **28** |

---

## Instruções de Uso

1. **Antes de cada operação crítica** (swap, transferência grande), revise este checklist.
2. **Marque mentalmente** cada item. Se algo falhar, PARE e resolva antes de prosseguir.
3. **Atualize o checklist** quando novas ferramentas ou procedimentos forem adicionados ao ecossistema.
4. **Guarde uma cópia física** deste checklist junto com seus backups (em papel, não digital).

---

No próximo capítulo, as 12 Leis do Guardião — regras imutáveis que, se quebradas, anulam toda a proteção técnica.
