# Capítulo 2 — Entendendo o Bitcoin

## 2.1 O livro-razão global

Imagine um caderno onde são registradas todas as transações financeiras do mundo. Cada página é um bloco. Cada bloco contém várias transações. Quando uma página fica cheia, ela é numerada, carimbada e anexada às páginas anteriores.

Esse caderno é público. Qualquer pessoa pode ler. Está em milhões de computadores ao redor do mundo. Ninguém pode arrancar uma página ou alterar o que já foi escrito.

Isso é a blockchain do Bitcoin: um livro-razão público, distribuído, imutável.

---

## 2.2 Como funciona uma transação

Quando você envia Bitcoin, não está "transferindo moedas" como quem passa uma nota de mão em mão. Na verdade, você está criando uma mensagem que diz:

"Eu, dono do endereço X, autorizo que o valor Y seja enviado para o endereço Z."

Essa mensagem é assinada digitalmente com sua chave privada. Qualquer pessoa pode verificar que a assinatura é válida — sem precisar conhecer sua chave privada.

---

## 2.3 Chaves: a base de tudo

Existem dois tipos de chaves:

**Chave privada:** Um número secreto. Quem conhece esse número pode gastar os bitcoins associados a ele. Deve ser guardada com máxima segurança.

**Chave pública:** Derivada da chave privada. Pode ser compartilhada. Serve para receber bitcoins e verificar assinaturas.

A relação entre elas é matemática: é fácil gerar a chave pública a partir da privada. É impossível (computacionalmente inviável) fazer o contrário.

Pense assim: a chave privada é a senha do seu cofre. A chave pública é o número da sua conta. Você divulga o número da conta para receber dinheiro, mas guarda a senha para ninguém abrir o cofre.

---

## 2.4 Endereços: identidades na rede

Um endereço Bitcoin é derivado da chave pública. Parece algo assim:

`bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq`

Não contém seu nome. Não contém sua localização. É apenas um identificador na rede.

Você pode — e DEVE — gerar um novo endereço para cada transação que receber. Isso protege sua privacidade. Se você reutilizar o mesmo endereço, todas as pessoas que lhe pagaram saberão quanto você recebeu no total.

---

## 2.5 Carteiras: gerenciando chaves

Uma carteira Bitcoin é um software que gerencia suas chaves. Ela:

- Gera novos endereços para receber pagamentos
- Mantém registro do seu saldo (consultando a blockchain)
- Cria transações para enviar Bitcoin
- Assina transações com sua chave privada

Existem vários tipos de carteira, que veremos em detalhes no próximo capítulo. O importante agora é entender que a carteira não "guarda" seus bitcoins. Seus bitcoins estão na blockchain. A carteira guarda as chaves que permitem gastá-los.

---

## 2.6 Mineração: o motor da rede

Mineração é o processo que mantém a blockchain segura e adiciona novos blocos.

Mineradores competem para resolver um problema matemático. O primeiro que resolve ganha o direito de adicionar o próximo bloco — e recebe uma recompensa em bitcoins.

Esse mecanismo se chama Prova de Trabalho (Proof of Work). Ele torna extremamente caro e difícil alterar blocos passados. Para reescrever a história, um atacante precisaria de mais poder computacional que toda a rede honesta somada.

A cada 210.000 blocos (aproximadamente 4 anos), a recompensa dos mineradores cai pela metade. Esse evento se chama halving. É assim que o Bitcoin atinge seu limite de 21 milhões de unidades.

---

## 2.7 Nós: a espinha dorsal

Um nó é um computador que roda o software Bitcoin Core e mantém uma cópia completa da blockchain. Ele verifica cada transação, cada bloco, cada regra do protocolo.

Qualquer pessoa pode rodar um nó. Você não ganha dinheiro com isso — mas ganha a capacidade de verificar suas próprias transações sem confiar em terceiros.

Rodar um nó próprio é um dos pilares da soberania que construiremos neste livro.

---

## 2.8 A Lightning Network

O Bitcoin tem uma limitação: processa cerca de 7 transações por segundo. Para comparação, a Visa processa milhares. Isso torna o Bitcoin inviável para pagamentos diários — como comprar um café.

A Lightning Network é uma camada adicional sobre o Bitcoin. Ela permite transações instantâneas e com taxas mínimas, usando canais de pagamento entre os participantes.

Neste livro, mencionaremos a Lightning Network principalmente como ferramenta para adquirir Bitcoin sem KYC (RoboSats), mas não aprofundaremos sua operação.

---

## 2.9 O que é um UTXO?

UTXO significa Unspent Transaction Output — "saída de transação não gasta".

Quando você recebe Bitcoin, na verdade recebe um ou mais UTXOs. Pense neles como notas de dinheiro: você pode ter uma nota de R$ 50, duas de R$ 20 e três de R$ 10. Seu saldo é a soma de todas as notas.

Quando você gasta, seleciona quais UTXOs usar. Se o valor for menor que a soma, recebe "troco" — um novo UTXO de volta para sua carteira.

Entender UTXOs é fundamental para a privacidade. Analistas de blockchain usam o agrupamento de UTXOs para inferir quais endereços pertencem à mesma pessoa. A Parte II ensinará como gerenciar UTXOs com maestria.

---

## 2.10 Como verificar uma transação você mesmo

Uma das propriedades mais poderosas do Bitcoin é que qualquer pessoa pode verificar qualquer transação, a qualquer momento, sem precisar confiar em ninguém.

Para fazer isso, você precisa de um explorador de blockchain — um site (ou software local) que lê a blockchain e a exibe de forma legível.

**Exploradores públicos conhecidos:**
- `mempool.space` — open-source, mostra o estado da mempool em tempo real
- `blockstream.info` — mantido pela Blockstream
- `btcscan.org` — alternativa mais leve

Para máxima privacidade, acesse exploradores via `.onion` no Tor Browser, ou consulte seu próprio nó Bitcoin Core. Evite colar seus endereços em sites clearnet.

**O que você vê em uma transação:**

```
TXID:    a1b2c3d4e5f6...     ← identificador único
Entrada: bc1q...abc → 0.05 BTC
Saída:   bc1q...xyz → 0.03 BTC (pagamento)
         bc1q...def → 0.0195 BTC (troco)
Taxa:    0.0005 BTC (para o minerador)
Bloco:   #850.421
Status:  6 confirmações
```

Cada confirmação é um bloco adicional construído sobre aquele que contém sua transação. Com 6 confirmações, uma transação é considerada praticamente irreversível — seria necessário refazer mais de 6 blocos de trabalho para reverter, o que exigiria mais poder computacional do que o mundo inteiro dedicado ao Bitcoin.

**Na prática:** Se alguém lhe enviar Bitcoin e quiser saber se a transação foi confirmada, basta pegar o TXID (identificador de transação) e colá-lo em qualquer explorador. Você não precisa confiar no vendedor, na exchange ou em qualquer intermediário.

---

## 2.11 Taproot: a evolução silenciosa

Em novembro de 2021, o Bitcoin ativou seu upgrade mais significativo em quatro anos: o Taproot. Se você já usa Bitcoin há algum tempo, provavelmente não percebeu — e isso é exatamente o ponto.

O Taproot trouxe três melhorias principais:

**Assinaturas Schnorr.** Substituíram o algoritmo de assinatura anterior (ECDSA). Assinaturas Schnorr são menores, mais eficientes e permitem agregar múltiplas assinaturas em uma só — o que beneficia especialmente transações multisig, que ficaram mais baratas e indistinguíveis de transações simples.

**MAST (Merklized Alternative Script Trees).** Contratos complexos (como multisig, time-locks, contratos condicionais) agora revelam apenas a parte do contrato que foi satisfeita — não todo o script. Isso aumenta a privacidade e reduz o tamanho das transações.

**Maior flexibilidade para contratos inteligentes.** O Taproot pavimentou o caminho para contratos mais sofisticados no Bitcoin, mantendo a segurança e a descentralização que o distinguem de outras plataformas.

Para o usuário comum, o Taproot significa transações mais baratas, mais privadas e mais eficientes, especialmente em cenários avançados que exploraremos na Parte II.

---

## 2.12 A segurança do Bitcoin em números

É comum ouvir que o Bitcoin poderia ser "hackeado" ou "quebrado". Vamos colocar isso em perspectiva.

**A chave privada de Bitcoin é um número com 256 bits.** Existem 2^256 chaves privadas possíveis. Esse número é aproximadamente 10^77 — mais do que o número estimado de átomos no universo observável (10^80). Tentar adivinhar uma chave privada aleatória por força bruta é, na prática, impossível.

**O hashrate da rede Bitcoin.** Em 2026, a rede Bitcoin processa cerca de 600 exahashes por segundo — 600 quintilhões de cálculos criptográficos por segundo. Para realizar um ataque de 51% (controlar a maioria do poder de mineração para reorganizar blocos), um atacante precisaria de mais poder computacional do que toda a rede somada, por tempo suficiente para superar a cadeia honesta.

**Quanto custaria um ataque de 51%?** Estimativas para 2026 indicam que alugar poder computacional suficiente para atacar a rede por apenas uma hora custaria centenas de milhões de dólares — e o ataque ainda poderia falhar se os nós honestos rejeitassem a reorganização. Economicamente, atacar o Bitcoin é um jogo de perda certa.

**O que pode ser vulnerável não é o protocolo, são as pessoas.** Exchanges podem ser hackeadas. Software pode ter bugs. Usuários podem ser enganados. Por isso este livro existe: não para proteger o Bitcoin de ataques técnicos — a rede faz isso sozinha — mas para proteger você dos ataques humanos que ameaçam seu acesso aos seus próprios fundos.

---

## 2.13 Endereços e tipos: P2PKH, P2SH, P2WPKH, P2TR

Se você já recebeu Bitcoin, provavelmente notou que os endereços começam com letras diferentes. Isso não é aleatório — indica o tipo de script que protege aqueles fundos.

| Prefixo | Tipo | Nome popular | Uso |
|---------|------|--------------|-----|
| `1...` | P2PKH | Legacy | Formato original (mais antigo) |
| `3...` | P2SH | P2SH | Multisig e scripts avançados |
| `bc1q...` | P2WPKH | Native SegWit | Mais eficiente, taxas menores |
| `bc1p...` | P2TR | Taproot | Mais moderno, mais privado |

Neste livro, usaremos endereços **Native SegWit** (`bc1q`) e **Taproot** (`bc1p`) por padrão, pois oferecem as melhores taxas e privacidade. Os endereços Legacy ainda funcionam, mas são mais caros e menos privados.

**Para o iniciante:** Não se preocupe em memorizar isso agora. As carteiras modernas criam automaticamente os endereços do tipo correto. O que você precisa saber é que `bc1q` e `bc1p` são os formatos modernos e preferidos.

---

## 2.14 A mempool e as taxas de mineração

Quando você envia uma transação Bitcoin, ela não vai diretamente para um bloco. Ela entra primeiro na **mempool** (memory pool) — uma fila de transações aguardando confirmação.

Os mineradores escolhem quais transações incluir no próximo bloco com base principalmente na taxa: quanto você paga por byte de transação (medido em sat/vB — satoshis por byte virtual). Transações com taxas mais altas são selecionadas primeiro.

**O que determina a taxa certa:**

- A mempool está congestionada? As taxas sobem.
- A mempool está vazia? Você pode pagar menos.
- A urgência da sua transação: uma transferência para uma exchange que precisa ser confirmada em 1 hora exige taxa diferente de uma transferência para sua própria carteira onde 24h é aceitável.

**Como descobrir a taxa adequada:**

Acesse `mempool.space` (ou seu equivalente .onion via Tor) antes de enviar qualquer transação. O site mostra o estado atual da mempool e as taxas estimadas para confirmação em diferentes horizontes de tempo: 1 bloco (~10 min), 3 blocos (~30 min), 6 blocos (~1h).

No Sparrow Wallet, a aba de criação de transação exibe o fee rate atual e permite ajustá-lo manualmente. Para transações sem urgência, use a menor taxa que garante confirmação em 24 horas — economiza satoshis sem risco.

**RBF (Replace-By-Fee):** Se você enviou uma transação com taxa baixa e ela ficou presa na mempool, o Sparrow permite substituí-la por uma versão idêntica com taxa mais alta. Isso se chama Replace-By-Fee. Ative sempre o RBF ao criar transações — é uma rede de segurança que não custa nada.

---

## Resumo do Capítulo

| Conceito | Significado |
|----------|-------------|
| Blockchain | Livro-razão público, distribuído e imutável |
| Chave privada | Número secreto que permite gastar bitcoins |
| Chave pública | Derivada da privada, permite receber e verificar |
| Endereço | Identificador derivado da chave pública |
| Carteira | Software que gerencia chaves |
| Mineração | Prova de Trabalho que protege a rede |
| Nó | Computador que valida a blockchain |
| UTXO | "Nota" de Bitcoin não gasta |
| Taproot | Upgrade que melhora privacidade e eficiência |
| 6 confirmações | Padrão de segurança para transações irreversíveis |
| Mempool | Fila de transações aguardando confirmação |
| RBF | Substituir transação presa com taxa mais alta |

---

No próximo capítulo, mergulharemos nas chaves: como gerá-las com segurança, o que é BIP39, e por que uma passphrase pode salvar seus fundos.
