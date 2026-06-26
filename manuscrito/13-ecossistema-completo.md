# Capítulo 13 — O Ecossistema Completo

> "Nenhum terceiro tem acesso a tudo ao mesmo tempo"

---

## Objetivo

Apresentar o diagrama completo do ecossistema soberano, explicando como cada componente se conecta e qual sua função na arquitetura geral.

---

## 13.1 Visão Geral

Após completar os sete níveis da trilha, você construiu um ecossistema completo de auto-custódia com privacidade. Este capítulo serve como mapa de referência — quando você precisar explicar seu setup para alguém, ou quando quiser revisar se todas as peças estão no lugar.

O ecossistema tem um princípio fundamental: **nenhum terceiro tem acesso a todas as informações ao mesmo tempo.**

- Seu dispositivo air-gapped guarda as chaves, mas nunca vê a internet
- Seu computador vê a blockchain, mas nunca vê as chaves
- Seu nó valida transações, mas não conhece sua identidade
- Seu ambiente de swap opera sobre Tor, mas não guarda estado entre sessões
- Seus backups físicos garantem recuperação mesmo se todos os dispositivos forem perdidos

---

## 13.2 O Diagrama

    ┌──────────────────────── INTERNET (TOR) ──────────────────────────┐
    │  Whirlpool .onion  │  eigenwallet .onion  │  Rede Bitcoin/Monero  │
    └───────────────────────────────────────────────────────────────────┘
                              ↕ (só via Tor)
    ┌──────────────────────── HOST FÍSICO ─────────────────────────────┐
    │  ┌──────────────┐   ┌───────────────────┐   ┌────────────────┐   │
    │  │   Gateway    │   │   Workstation     │   │  Bitcoin-Node  │   │
    │  │10.152.152.10 │↔  │  10.152.152.20   │↔  │ 10.152.152.30  │   │
    │  │ (verde)      │   │  (roxo)           │   │  (laranja)     │   │
    │  │ Tor daemon   │   │  Sparrow Wallet   │   │  Bitcoin Core  │   │
    │  │ Kill switch  │   │  eigenwallet      │   │  Fulcrum/EPS   │   │
    │  │ Stream isol. │   │  Feather Wallet   │   │  +Tor .onion   │   │
    │  └──────────────┘   │  Whirlpool        │   └────────────────┘   │
    │                     └───────────────────┘                         │
    │              Pasta Compartilhada: /psbt_bridge                    │
    └───────────────────────────────────────────────────────────────────┘
                            ↕ (air-gap: QR ou SD card)
    ┌──────────────────── DISPOSITIVOS FÍSICOS ────────────────────────┐
    │  Coldcard MK5    │  2x Aço Inox     │  Passphrase  │  Celular    │
    │  (cold storage)  │  (seed backup)   │  (local sep) │  CalyxOS/   │
    │  + MicroSD       │  Local A + B     │              │  GrapheneOS  │
    └───────────────────────────────────────────────────────────────────┘

![Ecossistema completo: Tor, três VMs no host e dispositivos físicos air-gapped](../imagens/diagrama-ecossistema.png)

O diagrama mostra três camadas principais:

### Camada 1: Internet (Rede Tor)

Todo tráfego do ecossistema passa pela rede Tor. O Whonix-Gateway força isso — nenhum pacote sai sem ser roteado por pelo menos três relays.

### Camada 2: Host Físico

Três máquinas virtuais rodam sobre um hipervisor:

- **Whonix-Gateway:** Força Tor, firewall, kill switch
- **Whonix-Workstation:** Onde você opera Sparrow, Whirlpool, eigenwallet, Feather
- **Bitcoin-Node:** Bitcoin Core + Electrum Personal Server (EPS)

Uma pasta compartilhada (`/psbt_bridge`) conecta o host físico ao mundo air-gapped.

### Camada 3: Dispositivos Físicos

- **Coldcard MK5:** Guarda a seed, assina PSBTs, nunca online
- **Placas de aço:** Duas cópias da seed em locais diferentes
- **Passphrase:** Em local separado, memorizada
- **Celular com CalyxOS/GrapheneOS:** Watching-only para uso diário
- **Pendrive Tails:** Ambiente cirúrgico para swaps de alto valor

---

## 13.3 Inventário de Componentes

### Hardware Físico

  Componente             Função                       Custo Estimado
  ---------------------- ---------------------------- -----------------
  Coldcard MK5           Assinar transações offline   US$ 170
  Placas de aço (2x)     Backup da seed               R$ 100-300
  Dados de casino (2x)   Gerar entropia               R$ 10-20
  MicroSD (2x)           Ponte PSBT                   R$ 40-60
  Pendrive USB (2x)      Tails OS                     R$ 40-60
  Celular Pixel          CalyxOS/GrapheneOS           R$ 1.000-2.000
  PC Host (16+ GB RAM)   Virtualização                R$ 3.000-6.000

### Máquinas Virtuais

  -----------------------------------------------------------------------------------------
  VM                   SO                RAM          Disco             Função
  -------------------- ----------------- ------------ ----------------- -------------------
  Whonix-Gateway       Debian (Whonix)   2 GB         20 GB             Forçar Tor

  Whonix-Workstation   Debian (Whonix)   6 GB         50 GB             Operação cripto

  Bitcoin-Node         Debian minimal    4-8 GB       400 GB            Validação + EPS
  -----------------------------------------------------------------------------------------

### Aplicações

  Aplicação        Local                   Função
  ---------------- ----------------------- ---------------------------
  Sparrow Wallet   Whonix, Tails, Mobile   Coordinator BTC
  Whirlpool        Whonix (Sparrow)        CoinJoin
  eigenwallet      Whonix, Tails           Swap BTC→XMR
  RetoSwap         Whonix                  Swap XMR→BTC
  Feather Wallet   Whonix, Tails, Mobile   Carteira XMR
  KeePassXC/DX     Todos                   Senhas e metadados
  Electrum         Tails (pré-instalado)   Alternativa BTC
  Bitcoin Core     Node VM                 Validação
  EPS              Node VM                 Servidor Electrum próprio

---

## 13.4 Fluxos Principais

### Fluxo 1: Depósito → Mixagem → Swap → Cold Storage

1.  Adquirir BTC (RoboSats, RetoSwap, venda direta)
2.  Sparrow mostra UTXO na aba Transactions
3.  Whirlpool: criar Premix → assinar → aguardar rounds
4.  UTXO pós-coinjoin (anonset ≥ 5) → Postmix_Whonix
5.  Isolar 1 UTXO → Swap_Ready_Whonix
6.  eigenwallet: BTC→XMR
7.  Aguardar 24h+ (defesa ABCTracer)
8.  RetoSwap: XMR→BTC (endereço virgem Coldcard)
9.  BTC limpo em cold storage

### Fluxo 2: Recuperação de Desastre

1.  Perdeu VM Whonix → restaurar snapshot/backup
2.  Perdeu Persistent Storage → Restaurar a partir da seed no Sparrow (Arquivo → Restaurar carteira)
3.  Perdeu Coldcard → comprar novo, restaurar seed do aço
4.  Perdeu placa de aço (local A) → usar backup do local B
5.  Esqueceu passphrase → sem recuperação (memorize!)

---

## 13.5 Matriz de Resiliência

  ---------------------------------------------------------------------------------------------------------
  Cenário                      Impacto                       Recuperação                       Tempo
  ---------------------------- ----------------------------- --------------------------------- ------------
  VM corrompida                Perda do ambiente             Restaurar snapshot                Minutos

  Persistent Storage perdido   Perda do estado Whirlpool     Restaurar seed no Sparrow           10-40 min

  Pendrive Tails quebrado      Perda do ambiente cirúrgico   Recriar em novo USB               30 min

  Coldcard perdido             Sem capacidade de assinar     Comprar novo + restaurar seed     1-7 dias

  Placa de aço perdida         Sem backup primário           Usar backup local B               Imediato

  Passphrase esquecida         Carteira real inacessível     Sem recuperação                   ∞

  Host físico apreendido       Perda das VMs                 Restaurar VMs de backup externo   Dias
  ---------------------------------------------------------------------------------------------------------

---

## 13.6 Custos Totais Estimados

  Categoria                           Custo (Brasil)
  ----------------------------------- -----------------------
  Hardware (Coldcard + aço + dados)   R$ 800-1.200
  PC Host (se não tiver)              R$ 3.000-6.000
  Celular dedicado (usado)            R$ 1.000-2.000
  Pendrives e MicroSDs                R$ 100-150
  **TOTAL (sem PC)**                  **~R$ 2.000-3.500**
  **TOTAL (com PC)**                  **~R$ 5.000-9.500**

Comparado com o custo de ter fundos confiscados, hackeados ou bloqueados, é um investimento mínimo.

---

## 13.7 Princípios de design: por que cada camada existe

O ecossistema descrito neste livro não nasceu de uma lista aleatória de ferramentas. Cada escolha arquitetural responde a um modelo de ameaça específico. Esta seção explica o "porquê" por trás do "o quê".

### Por que Whonix e não apenas VPN?

Uma VPN substitui seu IP real pelo IP do provedor de VPN. Mas o provedor de VPN ainda vê todo o seu tráfego e pode ser obrigado (por lei, ou por compra) a entregar seus dados. Se o provedor for comprometido ou vendido, seu histórico inteiro vai junto.

O Whonix resolve isso de forma diferente. O Tor roteia seu tráfego por três nós (entry, middle, exit), cada um vendo apenas o fragmento necessário: o nó de entrada sabe quem você é mas não sabe o destino; o nó de saída sabe o destino mas não sabe quem você é; o nó do meio não sabe nenhum dos dois. Mesmo que um nó seja controlado por um adversário, a correlação de tráfego é difícil sem controlar múltiplos nós simultaneamente.

O Whonix-Gateway força que toda a Workstation use o Tor — não é opcional, não pode ser desabilitado por erro, não tem vazamentos de DNS. Essa garantia é estrutural, não dependente de configuração correta.

### Por que air-gap e não hardware wallet conectada?

Hardware wallets como Trezor e Ledger conectam-se via USB ao computador. Isso cria um canal de comunicação entre o dispositivo de assinatura e o ambiente potencialmente comprometido. Ataques sofisticados podem explorar esse canal — e já exploram, em cenários de alta sofisticação.

O air-gap elimina o canal físico. A Coldcard, SeedSigner e Krux nunca conectam à internet ou a computadores ao assinar. O PSBT viaja por QR code ou SD card — meios unidirecionais que um adversário não pode usar para extrair a chave privada.

### Por que duas cópias físicas da seed em locais diferentes?

A regra 3-2-1 existe porque nenhum local é inviolável. Um incêndio, uma enchente, um arrombamento, um descuido — qualquer um desses eventos pode destruir uma cópia. Com duas cópias em locais físicos diferentes, você precisa de dois eventos simultâneos para perder o backup.

A passphrase em um terceiro local adiciona uma camada de segurança lógica: se um ladrão encontrar uma das placas de aço, só tem as 24 palavras. Sem a passphrase, a carteira que ele consegue abrir tem apenas o saldo "decoy" que você colocou lá intencionalmente.

### Por que nó próprio e não servidor Electrum público?

Quando você usa um servidor Electrum público para consultar seu saldo, esse servidor vê quais endereços você está consultando. Se você consultar todos os endereços da sua carteira, o servidor pode inferir sua carteira completa — mesmo que as transações on-chain não a revelem.

Com seu próprio nó Bitcoin Core + EPS (Electrum Personal Server), as consultas ficam no seu servidor. Ninguém vê o que você consulta. Você valida suas próprias transações sem confiar em terceiros para dizer se foram confirmadas ou não.

### Por que Tails para operações cirúrgicas?

O Whonix persiste estado entre sessões — o que é conveniente para mixing contínuo mas deixa rastros em disco. O Tails não persiste nada por padrão (amnésico): ao desligar, tudo desaparece. Nenhuma chave residual, nenhum histórico de conexão, nenhum arquivo temporário.

Para operações que você quer que "nunca aconteceram" do ponto de vista forense — como um swap de alto valor, uma compra em exchange P2P, ou uma operação em viagem — o Tails é o ambiente correto. Nenhuma evidência fica no dispositivo.

---

## Resumo do Capítulo

O ecossistema soberano não é um produto — é uma arquitetura que você constrói. Cada componente tem função específica. Nenhum terceiro controla todas as peças. Você é o ponto central — e também o elo mais importante.

Guarde este capítulo como mapa. Quando algo falhar, você saberá exatamente onde está o problema e como recuperar.

---

No próximo capítulo, exploraremos as ferramentas alternativas — o que fazer se o Coldcard não estiver disponível, se o Whirlpool cair, ou se você precisar de um caminho diferente para a soberania.
