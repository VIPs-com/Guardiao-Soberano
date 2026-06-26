# Capítulo 9 - Nível 4: O Misturador

> "Desaparecendo na multidão"

---

## Objetivo

Dominar CoinJoin com Whirlpool. Ter alternativa funcional com JoinMarket. Aprender Coin Control para nunca se auto-sabotar.

**Tempo estimado:** 2-4 semanas | **Dificuldade:** ★★★★☆

**Pré-requisitos:** Nível 3 concluído + pelo menos 0,01 BTC na carteira.

---

---

### Passo 4.1 — Estudar CoinJoin

```
Conceitos para pesquisar antes de começar:

□ O que é CoinJoin?
 - Transação onde várias pessoas misturam seus Bitcoins
 - Depois da mistura, não dá para saber qual input veio de quem
 - Como jogar moedas num pote, chacoalhar, e cada um tirar de volta

□ O que é anonset (anonymity set)?
 - Número de pessoas com quem você se misturou
 - Anonset 5 = analista vê 5 possíveis donos
 - Anonset 50 = analista vê 50 possíveis donos
 - Quanto maior, melhor

□ O que é common-input-ownership heuristic?
 - Regra que analistas usam: "todos os inputs de uma transação
 pertencem à mesma pessoa"
 - CoinJoin quebra essa regra
 - Mas se você CONSOLIDAR outputs pós-coinjoin, recria o vínculo

□ Diferença: Whirlpool vs JoinMarket
 - Whirlpool: coordenador central (.onion), pools fixos, mais fácil
 - JoinMarket: P2P descentralizado, qualquer valor, makers ganham fees
```

---

### Passo 4.2 — Criar estrutura de 3 carteiras

```
□ Todas usam a MESMA xpub (mesmo Coldcard)
□ São só "visões" diferentes dos mesmos fundos

□ Carteira 1: "Whirlpool_Whonix"
 - UTXOs que serão misturados
 - Status: "sujo" — NÃO gaste fora do Whirlpool

□ Carteira 2: "Postmix_Whonix"
 - UTXOs que já completaram CoinJoin (anonset ≥ 5)
 - Status: "limpo" — pronto para uso privado

□ Carteira 3: "Swap_Ready_Whonix"
 - UTXO isolado e rotulado, pronto para swap
 - Status: "reservado"

□ REGRA DE OURO:
 NUNCA consolidar UTXO pós-coinjoin com UTXO não-misturado
 Isso desfaz TODO o anonimato conquistado
```

---

### Passo 4.3 — Configurar Whirlpool no Sparrow

![Whirlpool: entradas → funil CoinJoin → saídas com anonset](../imagens/diagrama-whirlpool.png)

```
□ Aba Whirlpool → Settings
□ Coordinator: [.onion oficial do Sparrow — verificar no site]
□ Escolher pool: 0.01 BTC (recomendado para começar)
□ Target anonset: 5 (mínimo), 10+ (ideal)
□ Modo: Remix automático (continua misturando após cada round)
```

---

### Passo 4.4 — Primeira transação Premix

```
□ Selecionar 1 UTXO não-misturado (0.01 BTC ou mais)
□ Botão direito → Mix to Whirlpool
□ Escolher pool 0.01 BTC
□ Revisar:
 - Outputs de pool (ex: 1 output de 0.01 BTC)
 - Change (troco que volta para você)
 - Coordinator fee (taxa do coordenador)
□ Criar PSBT → Coldcard assinar → transmitir
□ Aguardar 1 confirmação
```

---

### Passo 4.5 — Mixagem (deixar rodando)

```
□ Aba Whirlpool → Start
□ Aguardar:
 - "Registered" → output registrado no coordenador
 - "Signing" → round em andamento
 - "Remixing" → completou 1 round, voltou para mais

□ Tempos típicos:
 - 1 round: 20-60 minutos
 - 5 rounds: 2-8 horas
 - 10 rounds: 5-20 horas

□ Deixar a VM rodando (não desligar durante round ativo)
□ Whonix é ideal para isso — pode ficar 24/7
□ Usar snapshots: tirar antes de cada sessão longa
```

---

### Passo 4.6 — Mover para Postmix

```
□ UTXOs com anonset ≥ 5 → ícone azul no Sparrow
□ Selecionar → Send to Postmix_Whonix
□ Assinar com Coldcard → transmitir
□ Agora você tem BTC "limpo"!
□ NUNCA gastar este BTC junto com BTC não-misturado
```

---

### Passo 4.7 — Instalar e TESTAR JoinMarket (backup)

```
□ NÃO basta instalar — precisa TESTAR
□ git clone JoinMarket no Whonix
□ Configurar para Tor
□ Fazer 1 coinjoin de teste (valor pequeno)
□ Confirmar que funciona como alternativa

□ Se o coordenador Whirlpool cair:
 - Você NÃO fica parado
 - Abre o JoinMarket e continua mixando

□ Anotar comandos essenciais no KeePassXC:
 - wallet-tool.py generate
 - sendpayment.py (taker)
 - yield-generator.py (maker, opcional)
```

---

### Passo 4.8 — Praticar Coin Control

```
□ Congelar UTXOs "sujos" (Freeze no Sparrow)
□ Rotular TUDO:
 - "KYC Exchange X" (se algum dia usou)
 - "RoboSats 2026-06"
 - "CJ Round 3" (coinjoin)
 - "Swap Ready"
□ NUNCA usar "Send Max" sem verificar quais UTXOs selecionados
□ Auto-auditar: OXT Explorer via Tor para ver clusters
```

---

### Verificação do Nível 4

```
□ Primeiro UTXO pós-coinjoin com anonset ≥ 5
□ JoinMarket instalado E TESTADO com valor real
□ Estrutura de 3 carteiras funcionando
□ Coin Control dominado (congelar, rotular, não consolidar)
□ Entendo o que é anonset e como ele sobe
□ Sei que consolidar UTXOs pós-coinjoin = PERDER anonimato
```

---

## Nota: ambiente para Whirlpool

O Whirlpool exige uptime e persistência — por isso este nível assume **Whonix** (Passo 4.5: deixar a VM rodando 24/7).

A comparação completa **Tails vs Whonix** — tabela detalhada, matriz de decisão e estratégia híbrida — está no **Capítulo 8** (Nível 3 — O Observador), seção *Referência: Tails vs Whonix*.

**Regra prática para CoinJoin:** use Tails para mixagem pontual ocasional; use Whonix para remixes automáticos ao longo de dias.

---

## 🏅 Conquista: "O Misturador"

> Meus Bitcoins dançam na multidão. A cada rodada, somem mais entre os pares. O analista olha e vê dezenas — não sabe qual sou eu. E se o maestro parar, tenho outra dança pronta.

---

No próximo capítulo, atravessaremos a ponte da privacidade com swaps BTC↔XMR.
