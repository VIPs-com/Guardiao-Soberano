# Capítulo 12 — Nível 7: O Mestre

> "Além da soberania pessoal"

---

## Objetivo

Expandir conhecimento, contribuir com a comunidade, adaptar-se a novas ameaças e construir legado.

**Tempo estimado:** Jornada contínua | **Dificuldade:** ★★★★★

**Pré-requisitos:** Nível 6 concluído + mentalidade de aprendizado contínuo.

---

### Trilhas de Especialização

Escolha uma ou mais. Não precisa fazer todas.

---

### Trilha A: Infraestrutura Avançada

```
□ Migrar node Bitcoin para hardware dedicado (Raspberry Pi 5)
□ Rodar Lightning Network (LND + Tor)
□ Ser maker no JoinMarket (ganhar fees fornecendo liquidez)
□ Automatizar swaps com scripts seguros
□ Adicionar Liana Wallet:
 - Miniscript + timelocks para herança
 - "Se eu não mover por 6 meses, herdeiro pode resgatar"
 - Compatível com Coldcard
```

---

### Trilha B: Privacidade Avançada

```
□ Estudar WabiSabi (Wasabi Wallet) como alternativa
□ Explorar Silent Payments (BIP352)
□ Acompanhar FCMP++ (Monero)
□ Ler papers: ABCTracer, Haveno vulnerability
□ Entender limites: não existe "privacidade absoluta"
```

---

### Trilha C: Comunidade

```
□ Traduzir documentação para português
□ Criar tutoriais (texto ou vídeo)
□ Participar de fóruns (Reddit, Matrix, SimpleX)
□ Revisar código de ferramentas open-source
□ Reportar bugs com responsabilidade
□ Mentorar iniciantes na trilha
```

---

### Trilha D: Defesa Máxima

```
□ Migrar para Qubes OS como host:
 - VM separada para cada função
 - VM offline só para assinatura (split wallet)
 - VM para eigenwallet, VM para Feather, VM para Sparrow
 - Comunicação via qrexec
 - Nenhuma VM acessa outra diretamente
 - Resolve o problema do "host comprometido"
```

---

### Hábitos do Mestre

```
□ Ler changelogs de todas as ferramentas que usa
□ Verificar PGP de cada atualização
□ Testar recuperação semestralmente (de verdade)
□ Revisar coordinators .onion trimestralmente
□ Participar de 1 discussão técnica por mês
□ Ensinar 1 pessoa nova por ano
□ Questionar sempre: "Isso ainda é seguro em 2026? 2027?"
□ Adaptar a trilha conforme novas ameaças e ferramentas surgem
```

---

### Verificação do Nível 7

**Obrigatório — mentalidade Mestre:**

```
□ Escolhi pelo menos 1 trilha e avancei nela
□ Contribuí com a comunidade de alguma forma
□ Revisei meu ecossistema este ano
□ Sei que a jornada NUNCA termina
```

**Integração com a trilha:**

```
□ Ensinei pelo menos 1 pessoa nos Níveis 0–1 (Cap. 11) — ideal: 2+ ao longo do tempo
□ O Guardião Soberano não é um destino — é um caminho
```

---

## 🏅 Conquista: "O Mestre"

> Não acumulo apenas moedas — acumulo conhecimento. Não protejo apenas a mim — protejo a rede. Ensino o que aprendi. Questiono o que sei. O Guardião Soberano é um caminho que se renova a cada bloco.

---

Na **Parte III**, consulte referência permanente: ecossistema (Cap. 13), ferramentas (Cap. 14), checklist (Cap. 16) e as 12 Leis (Cap. 17).

---

## 📎 Leitura opcional — após Nível 7

Tabela resumo, rituais, novidades 2025–2026, tutorial multisig e palavras finais. **Não são obrigatórias** para concluir o Nível 7.

---

## Tabela Resumo da Trilha

| Nível | Nome | Tempo | Dificuldade | Essência |
| --- | --- | --- | --- | --- |
| 0 | 🌱 A Semente | 2–4 dias | ★★☆☆☆ | Gerar seed com dados, backup em aço, primeiros sats sem KYC |
| 1 | 🔒 O Cofre | 1–2 sem | ★★★☆☆ | Dispositivo air-gapped, teste de restauração |
| 2 | 👁️ A Carteira Fria | 2–3 dias | ★★★☆☆ | Watching-only, primeiro PSBT completo |
| 3 | 🏰 O Observador | 1–2 sem | ★★★★☆ | Whonix, node próprio, EPS .onion |
| 4 | 🔀 O Misturador | 2–4 sem | ★★★★☆ | Whirlpool, JoinMarket, Coin Control |
| 5 | 🔄 O Trocador | 1–2 sem | ★★★★★ | eigenwallet, RetoSwap, defesa ABCTracer |
| 6 | 👑 O Soberano | 1–2 meses | ★★★★★ | Mobile, backups, legal, diversificação, ensino |
| 7 | 🧙 O Mestre | Contínuo | ★★★★★ | Comunidade, Qubes, herança, contribuição |

---

## Rituais de Passagem

Ao completar cada nível:

1. **Anote a data** no KeePassXC: "Nível X conquistado em DD/MM/AAAA"
2. **Revise o que aprendeu** (15 minutos de reflexão)
3. **Compartilhe** com 1 pessoa de confiança
4. **Descanse** 1 dia antes de começar o próximo nível
5. **Nunca delete** o ambiente do nível anterior (são camadas, não substituições)

---

## As 12 Leis do Guardião

As **12 Leis completas** — seed, rede, swaps e a Lei Mestra — estão no **Capítulo 17**. Use-as como referência permanente; não duplique anotações em vários lugares.

---

## Referência na Parte III

| Capítulo | Conteúdo |
| --- | --- |
| 13 | Ecossistema completo (diagrama e arquitetura) |
| 14 | Ferramentas e alternativas |
| 15 | Itens que salvam vidas (ABCTracer, Coin Control) |
| 16 | Checklist operacional (28 itens) |
| 17 | As 12 Leis do Guardião |

---

## Atualizações: Novidades Tecnológicas 2025–2026

### FCMP++ (Full-Chain Membership Proofs)

**O que é:** Upgrade do protocolo Monero que expande o **anonymity set** de 16 decoys (ring size atual) para **toda a blockchain**.

| Aspecto | Antes (RingCT atual) | Depois (FCMP++) |
| --- | --- | --- |
| Tamanho do anonimato | 16 decoys | Toda a blockchain |
| Resistência a análise | Alta | Extremamente alta |
| Tamanho das transações | ~2,5 KB | ~4–6 KB (estimado) |
| Status | Mainnet desde ~2021 | Stressnet out/2025; beta oficial v0.19.0.0 em 6 mai/2026; mainnet prevista 2026 |

**Impacto no ecossistema:** Quando ativado, swaps BTC→XMR se tornam ainda mais privados. A defesa contra ABCTracer fica criptograficamente mais forte — mesmo análises com recursos estatais teriam dificuldade.

---

### Vulnerabilidade Haveno (arXiv:2505.02392, Maio 2025)

**Descoberta:** Pesquisadores identificaram que certas transações do Haveno podem ser detectadas on-chain, permitindo vincular transações Monero às contrapartes Bitcoin.

**Causa:** Seed nodes centralizados e padrões de transação previsíveis.

**Mitigações:**

* Usar **eigenwallet** ou **BasicSwap** para trustlessness total
* Aguardar correções do Haveno/RetoSwap
* Diversificar entre ferramentas (não usar só uma)

---

### ABCTracer (arXiv:2504.01822, Abril 2025)

**Reforço:** O paper demonstrou 91,75% de rastreabilidade cross-chain. Nossas defesas (intervalo temporal, valores diferentes, churn) continuam válidas e são a proteção recomendada.

---

### Taproot no Bitcoin

Já ativo desde 2021, mas cada vez mais relevante:

* Transações Taproot são indistinguíveis de outras na blockchain
* **Krux** e **Liana** já suportam Taproot
* Sparrow suporta envio para endereços Taproot (bc1p)

---

## Trilha A — Aprofundamento: Multisig 2-of-2 e 2-of-3

**Tutorial: Configurar Multisig 2-of-2 no Sparrow Wallet (com Air-Gapped Signers – Tails OS)**

Uma **2-of-2 multisig** exige **as duas assinaturas** para qualquer gasto. Protege contra roubo de uma chave (atacante precisa das duas), mas **não tolera perda**: se perder uma das duas seeds, os fundos ficam inacessíveis — por isso muitos preferem **2-of-3**. Use com **pequenas quantias** no início e teste tudo.

**Fluxo recomendado para seu setup**:

* Keystore 1: SeedSigner ou Krux (air-gapped principal).
* Keystore 2: Outro SeedSigner/Krux com seed diferente (sempre em metal, Lei 4).

### Passo 1: Prepare as Seeds (Offline/Air-Gapped)

1. Ligue seu **SeedSigner** ou **Krux**.
2. Gere uma **nova seed BIP39** (use dice rolls para máxima entropia).
3. Gravar a seed em **metal** (Lei 4 — nunca digital, nunca papel fotografável).
4. Repita para a **segunda seed** (em outro dispositivo ou Tails air-gapped).
5. Exporte o **xpub/zpub** de cada um via QR code.

**Dica**: Faça isso em ambientes completamente offline.

### Passo 2: Crie a Multisig 2-of-2 no Sparrow (Tails)

1. Abra o Sparrow no Tails (com persistência).
2. Vá em **Arquivo → Nova carteira** (File → New Wallet).
3. Dê um nome (Ex.: "MinhaVault2of2") e clique **Criar nova carteira** (Create new wallet).
4. Na tela de configuração:
 * **Tipo de política** (Policy Type): **Multi Signature**.
 * **M de N**: **2 of 2**.
 * Tipo de script: **Native Segwit** (P2WPKH) — fees baixas.
5. Clique **Avançar** (Next) ou **Continuar** (Continue).

### Passo 3: Adicione os Keystores (Cosigners)

Sparrow vai pedir os dois keystores:

**Para cada Keystore (faça um de cada vez):**

* Clique em **Add Keystore** ou no botão correspondente.
* Escolha **Air Gapped Hardware Wallet** (para SeedSigner/Krux).
* Selecione o tipo (SeedSigner, Krux ou "Other" se não listar).
* **Scan QR**:
 * No seu signer air-gapped, gere e mostre o QR do xpub/zpub (geralmente em "Export → XPUB" ou "Multisig").
 * No Sparrow, aponte a webcam e escaneie.
* Repita para o **segundo keystore**.

Após adicionar os dois, revise os detalhes (derivation path geralmente `m/84'/0'/0'` para Native Segwit).

Clique **Apply** ou **Create Wallet**.

### Passo 4: Backup Importante (OBRIGATÓRIO)

1. Vá na aba **Settings** da wallet.
2. Exporte o **Output Descriptor** (ou BSMS file):
 * Salve em múltiplos lugares seguros (USB criptografado, papel, etc.).
 * Este arquivo é essencial para recuperar a wallet se precisar recriar no Sparrow.
3. Backup das duas seeds em metal + descriptor.

**Teste o restore** com Testnet ou small amount antes de usar mainnet.

### Passo 5: Receber Fundos

* Na aba **Receive**, gere um endereço.
* Verifique o mesmo endereço nos dois signers (se possível) ou confira o descriptor.
* Envie fundos de teste.

### Passo 6: Enviar com PSBT QR (2-of-2)

1. Na aba **Send**, crie a transação normalmente.
2. Finalize → Sparrow vai mostrar QR para assinatura.
3. Assine com o **primeiro signer** (escaneie QR → assine → gere QR de volta).
4. Importe a assinatura parcial no Sparrow (Scan QR).
5. Repita com o **segundo signer** (agora precisa das duas assinaturas).
6. Após a segunda assinatura, clique **Broadcast**.

Sparrow mostra quantas assinaturas faltam (ex: "1 of 2").

### Dicas de Segurança (Novato)

* Sempre verifique endereços de change e destino.
* Use **Testnet** no Sparrow primeiro (File → Preferences → Testnet).
* Guarde as duas seeds em locais físicos diferentes.
* Nunca armazene seeds no Tails online.
* Exporte o descriptor e teste recuperação completa.
* Para maior segurança: Use dois dispositivos diferentes (ex: SeedSigner + Krux) ou adicione uma terceira seed para virar 2-of-3.

**2-of-2 vs 2-of-3**: A comunidade geralmente recomenda **2-of-3** para produção (melhor equilíbrio).

### Configurar Multisig 2-of-3 no Sparrow (Tails + Air-Gapped)

**Por que 2-of-3?**

* Mais seguro e prático: você perde uma seed/dispositivo e ainda consegue acessar os fundos.
* Equilíbrio ideal para quem está começando.

### Keystores Recomendados (3 no total):

1. **SeedSigner ou Krux** (principal air-gapped)
2. **Segundo SeedSigner/Krux** (seed em metal)
3. **Terceira seed** (dispositivo air-gapped ou metal dedicado)

---

### Passo a Passo (2-of-3)

1. **Gere as 3 Seeds Offline**
 * Use SeedSigner/Krux para gerar 2 ou 3 seeds (dice rolls).
 * Backup em metal de todas.
2. **Crie a Wallet no Sparrow**
 * File → **New Wallet**
 * Nome: ex: "Vault2of3"
 * **Policy Type**: Multi Signature
 * **M of N**: **2 of 3**
 * Script Type: **Native Segwit** (recomendado)
 * Clique Next
3. **Adicione os 3 Keystores**
 * Para cada um:
 * Escolha **Air Gapped Hardware Wallet** (ou "Other")
 * Escaneie o **xpub/zpub** via QR do signer correspondente
 * Após os 3, revise derivation paths (geralmente `m/84'/0'/0'`)
 * Clique **Apply / Create**
4. **Backup Essencial**
 * Vá em **Settings** da wallet → Export **Output Descriptor** (ou BSMS)
 * Salve em vários lugares seguros (USB criptografado + papel)
 * Este descriptor é crítico para recuperar a wallet depois
5. **Teste com Testnet (Muito Importante)**
 * File → Preferences → marque **Testnet**
 * Crie/receba fundos de teste
 * Faça uma transação completa com PSBT QR (assinando com 2 dos 3 signers)
6. **Enviar Fundos (Mainnet)**
 * Crie transação → Finalize
 * Assine com **dois** dos três signers (via QR)
 * Depois da segunda assinatura → Broadcast

---

**Fluxo PSBT QR** segue o mesmo padrão do Capítulo 7 (Nível 2): a diferença é exigir **duas assinaturas** em vez de uma.

---

## Palavras Finais

> Esta trilha não é uma corrida. É uma peregrinação.
> 
> Alguns levarão meses. Outros, anos. O tempo não importa — a solidez importa.
> 
> Cada nível conquistado é uma camada de liberdade que ninguém pode tirar de você. Não há banco que confisque. Não há governo que congele. Não há exchange que bloqueie.
> 
> Mas lembre-se: **com grande poder vem grande responsabilidade**. Você é o único responsável por seus backups. O único guardião de suas chaves. O único auditor de sua segurança.
> 
> Plante em aço. Guarde em silício. Misture na multidão. Troque na névoa.
> 
> **Seja o Guardião. Seja Soberano. Seja Livre.**

---

```
┌─────────────────────────────────────────────────────────────┐
│ │
│ 🌱 NÍVEL 0: A SEMENTE 🏅 │
│ 🔒 NÍVEL 1: O COFRE 🏅 │
│ 👁️ NÍVEL 2: A CARTEIRA FRIA 🏅 │
│ 🏰 NÍVEL 3: O OBSERVADOR 🏅 │
│ 🔀 NÍVEL 4: O MISTURADOR 🏅 │
│ 🔄 NÍVEL 5: O TROCADOR 🏅 │
│ 👑 NÍVEL 6: O SOBERANO 🏅 │
│ 🧙 NÍVEL 7: O MESTRE 🏅 │
│ │
│ Versão 1.1 — Consolidada após revisão da comunidade │
│ Junho de 2026 │
│ │
└─────────────────────────────────────────────────────────────┘
```

---

