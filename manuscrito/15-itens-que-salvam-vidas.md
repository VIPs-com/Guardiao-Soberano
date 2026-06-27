# Capítulo 15 — Itens que Salvam Vidas

> "ABCTracer, JoinMarket, PayJoin e Coin Control — as defesas que separam a privacidade real da ilusão"

---

## Objetivo

Apresentar conceitos avançados de defesa que protegem contra ameaças sofisticadas de análise de blockchain e correlação.

---

## 15.1 ABCTracer — A Ameaça de Correlação Temporal

Em abril de 2025, pesquisadores publicaram o paper ABCTracer (arXiv:2504.01822), demonstrando 91,75% de eficácia em rastrear fundos através de pontes cross-chain.

O ataque usa três sinais simultâneos:

1.  **Intervalo de tempo:** Se 1 BTC entra em um swap e ~1 BTC em XMR aparece minutos depois, a proximidade temporal é uma assinatura.
2.  **Proporção valor/taxa:** O valor de saída é quase idêntico ao de entrada (menos a taxa), criando uma correspondência numérica.
3.  **Endereço de destino:** Padrões de reutilização ou agrupamento de endereços revelam o destinatário.

### Como se defender

  -----------------------------------------------------------------------------------------------------
  Ataque                              Defesa
  ----------------------------------- -----------------------------------------------------------------
  Correlação temporal                 Aguardar MÍNIMO 24 horas (ideal 3-7 dias) entre entrada e saída

  Fingerprint de valor                Usar valores DIFERENTES em cada swap

  Endereço de destino                 Usar endereço VIRGEM para cada recebimento

  Múltiplos swaps                     Fazer vários swaps em paralelo com valores diferentes
  -----------------------------------------------------------------------------------------------------

---

## 15.2 JoinMarket — CoinJoin Descentralizado

O Whirlpool depende de um coordenador central (.onion). Se esse coordenador sair do ar — como aconteceu com o Samourai em 2024 — você perde a capacidade de fazer CoinJoin.

JoinMarket resolve isso: é totalmente P2P, sem ponto único de falha.

### Como funciona

- **Makers:** Pessoas que oferecem BTC para misturar, ganhando fees
- **Takers:** Pessoas que iniciam os coinjoins, pagando fees
- **Mercado:** O preço é determinado pela oferta e demanda

**Recomendação:** Instale e TESTE o JoinMarket com um valor pequeno. Não espere o Whirlpool cair para descobrir que você não sabe usar a alternativa.

---

## 15.3 PayJoin — Privacidade Colaborativa

PayJoin (Pay-to-EndPoint) é uma transação onde o pagador e o recebedor contribuem inputs para a mesma transação, quebrando a heurística de common-input-ownership.

**Transação normal:** Input 0.05 BTC → Output 0.03 BTC (pagamento) + Output 0.0199 BTC (troco). Analista vê: "1 pessoa gastou, recebeu troco".

**PayJoin:** Input 0.05 BTC (seu) + Input 0.02 BTC (recebedor) → Output 0.03 BTC (pagamento) + Output 0.0398 BTC (troco). Analista vê: "2 pessoas consolidaram — não sei quem pagou quem".

---

## 15.4 Coin Control — A Arte de Gerenciar UTXOs

Coin Control é a prática de selecionar manualmente quais UTXOs gastar em cada transação.

### Regras de Ouro

**✅ FAÇA:**

- Rotule cada UTXO por origem (KYC, RoboSats, CoinJoin Round 3, Swap)
- Congele UTXOs "sujos" para não gastar sem querer
- Gaste 1 UTXO por vez quando possível

**❌ NÃO FAÇA:**

- Consolidar 2+ UTXOs pós-coinjoin (reduz anonimato)
- Misturar UTXO de exchange KYC com UTXO de coinjoin (contaminação)
- Usar "Send Max" sem verificar quais UTXOs foram selecionados

---

## 15.5 Vulnerabilidade Haveno 2025

Em maio de 2025, pesquisadores identificaram que certas transações do Haveno podem ser detectadas on-chain (arXiv:2505.02392).

**Mitigações:** Usar eigenwallet ou BasicSwap para trustlessness total. Aguardar correções do Haveno/RetoSwap. Diversificar entre ferramentas de swap.

---

## 15.6 FCMP++ — O Futuro do Monero

FCMP++ (Full-Chain Membership Proofs) é um upgrade do protocolo Monero em desenvolvimento — **stressnet beta desde maio/2026**, mainnet ainda não ativada (mainnet Monero: v0.18.4.6).

**Antes:** Cada transação é misturada com 16 decoys. **Depois (quando ativar):** O anonimato se expande para TODA a blockchain Monero.

**Ação necessária:** Nenhuma até o hardfork de mainnet. Acompanhe anúncios oficiais.

---

## 15.7 Servidores Electrum .onion

Servidores Electrum públicos podem correlacionar todos os seus endereços. Seu EPS próprio resolve isso. Se precisar de servidor público, use apenas endereços **v3** (56 caracteres base32) listados em fontes oficiais — veja Apêndice B.

> ⚠️ *Atualização jun/2026:* Não use endereços no formato `site.com.onion` — não são v3 válidos.

---

## 15.8 OpSec: Os Erros Humanos que Destroem Décadas de Trabalho

A criptografia é inquebrável. A blockchain é imutável. Mas o operador é humano — e o ser humano comete erros que toda a matemática do mundo não consegue compensar.

Esta seção reúne os erros mais comuns observados em operadores de auto-custódia. Leia como uma lista de verificação negativa: cada item é um buraco na muralha que você precisa tapar.

### Senha fraca ou reutilizada

**O erro:** Usar senha curta, nome de familiar, data de nascimento, ou a mesma senha de outro serviço para criptografar cofres, pendrives ou bancos de dados KeePass.

**Por que quebra:** Uma senha de 8 caracteres, mesmo com símbolos, pode ser quebrada por força bruta com hardware moderno em horas ou dias. Reutilizar senhas significa que uma violação em qualquer serviço expõe todos os outros.

**Como evitar:** Use frases Diceware com 7+ palavras aleatórias (ex: `correto-fralda-bule-verde-iguana-piano-chuva`). Nunca reutilize senhas para dados sensíveis.

### Acessar contas pessoais durante sessão anônima

**O erro:** Abrir email pessoal, redes sociais ou conta bancária no mesmo navegador ou sessão usada para operações de privacidade.

**Por que quebra:** Você acabou de ligar sua identidade civil à sua identidade cripto. Os registros dos servidores mostram que o mesmo IP (ou até o mesmo perfil de fingerprint de navegador) acessou sua conta bancária e fez uma transação de swap no mesmo período.

**Como evitar:** Identidades digitais são como personas — nunca as misture. Use dispositivos separados, ou pelo menos perfis completamente isolados, para atividades com identidade real e atividades anônimas.

### Copiar seed ou chave privada para a área de transferência

**O erro:** Pressionar Ctrl+C em uma seed phrase ou chave privada e depois esquecer de limpar a área de transferência — ou pior, colar no lugar errado.

**Por que quebra:** Fora de ambientes controlados (como Tails), malwares de clipboard monitoram o que você copia e extraem automaticamente strings que parecem seeds ou chaves. Um único descuido desfaz anos de precauções.

**Como evitar:** Nunca copie seeds. Digite letra por letra, confirme visualmente, e prefira transferir por QR quando possível. Se precisar copiar algo sensível, sobrescreva o clipboard imediatamente com texto qualquer.

### Falar demais

**O erro:** Mencionar em fóruns, chats ou conversas informais que você usa determinadas ferramentas de privacidade, que tem Bitcoin em auto-custódia, ou que sabe fazer swaps sem KYC.

**Por que quebra:** Você se torna um alvo específico. O adversário agora sabe qual sistema você usa e pode direcionar ataques especificamente contra você — phishing personalizado, exploits para versões específicas de software, ou simplesmente uma chave inglesa à porta de casa.

**Como evitar:** Seja vago. "Uso Linux com foco em privacidade" em vez de nomear ferramentas. Não compartilhe o tamanho do seu patrimônio em cripto, nem com amigos. A soberania é silenciosa.

### Não verificar o software antes de executar

**O erro:** Baixar uma AppImage, um arquivo de configuração ou um script e executar sem verificar a assinatura PGP ou o hash.

**Por que quebra:** Um arquivo malicioso com o mesmo nome do software legítimo pode roubar sua seed no momento em que você a digita, ou substituir endereços de destino nas suas transações. Isso acontece via sites falsos, links maliciosos e ataques man-in-the-middle.

**Como evitar:** Verifique sempre. O Apêndice D deste livro explica o processo de verificação PGP passo a passo. Leva dois minutos e protege tudo.

---

## 15.9 A Sobrevivência do Hardware: Pendrives, SSDs e a Física do Descuido

Pendrives convencionais morrem. Não "podem morrer" — morrem, inevitavelmente, porque a física de células NAND de baixa qualidade tem um número limitado de ciclos de gravação. Um sistema operacional como o Tails, que escreve logs, cache e metadados constantemente, acelera esse desgaste.

**O que acontece quando o pendrive morre:** Você perde acesso ao ambiente configurado. Se não tiver backup, perde dados. Se não tiver seed gravada em metal, pode perder acesso aos seus fundos.

**Escolha melhor hardware:**

Os melhores "pendrives" para uso intenso não são pendrives — são SSDs externos em formato compacto. A diferença está no controlador interno:

| Tipo | Ciclos | Wear-level | Tails |
|------|--------|------------|-------|
| Pendrive barato | Centenas | Não | Evitar |
| Pendrive qualidade | Milhares | Básico | Aceitável |
| SSD externo¹ | Dezenas de milhares | Avançado | Ideal |

¹ Ex.: Samsung T7, SanDisk Extreme

**Regra de substituição:** Substitua o dispositivo principal a cada 6 meses se uso intenso diário, ou a cada 12 meses se uso esporádico. Hardware é barato. Perder fundos não é.

**Regra de backup:** Siga o padrão 3-2-1:
- **3** cópias dos dados de configuração
- **2** meios diferentes (dois pendrives SSD, ou pendrive + offsite cifrado)
- **1** cópia off-site (em local fisicamente diferente)

E mais importante: **teste a restauração**. Um backup não testado é um backup que pode falhar quando você mais precisa. A cada dois meses, pegue o pendrive de backup e restaure os dados em um dispositivo limpo. Confirme que tudo funciona. Só então você tem um backup real.

---

## Resumo do Capítulo

| Ameaça | Defesa |
|--------|--------|
| ABCTracer (correlação temporal) | Intervalo 24h+, valores diferentes, endereços virgens |
| Coordenador Whirlpool offline | JoinMarket instalado e testado |
| Heurística de propriedade comum | PayJoin + Coin Control |
| Vulnerabilidade Haveno | Diversificar ferramentas de swap |
| Privacidade Monero limitada (16 decoys) | FCMP++ (aguardar mainnet) |
| Senha fraca | Frase Diceware 7+ palavras |
| Mistura de identidades | Dispositivos e sessões separadas |
| Clipboard com seed | Nunca copiar — digitar ou usar QR |
| Falar demais | Nenhuma informação operacional em público |
| Software não verificado | Sempre verificar PGP antes de executar |
| Pendrive comum morrendo | SSD externo + backup 3-2-1 testado |

---

No próximo capítulo, apresentaremos o checklist operacional de 28 itens — seu guia rápido para verificar se tudo está em ordem antes de qualquer operação crítica.
