# Apêndice A — Glossário Técnico

---

## A — ABCTracer a Atomic Swap {-}

**ABCTracer** — Paper acadêmico (arXiv:2504.01822) que demonstrou 91,75% de rastreabilidade em pontes cross-chain usando correlação temporal, proporção valor/taxa e análise de endereços de destino.

**Air-gap** — Isolamento físico total entre um dispositivo e qualquer rede. Um dispositivo air-gapped nunca se conecta à internet, WiFi, Bluetooth ou qualquer forma de comunicação digital.

**Anonset (Anonymity Set)** — O número de possíveis remetentes de uma transação. Anonset 5 significa que um analista vê 5 possíveis donos para aquele output. Quanto maior, melhor a privacidade.

**Atomic Swap** — Troca de criptomoedas entre blockchains diferentes sem intermediário. Usa contratos HTLC que garantem que ou ambas as partes cumprem o acordo, ou ninguém perde nada.

---

## B — BIP39 e Blockchain {-}

**BasicSwap** — DEX descentralizado para swaps entre blockchains (incluindo XMR↔︎BTC), auto-hospedado. Alternativa trustless ao Haveno/RetoSwap para alguns fluxos.

**BIP39** — Bitcoin Improvement Proposal 39. Padrão que converte entropia em uma lista de palavras humanas (seed). A lista tem 2048 palavras. 24 palavras = 256 bits de entropia.

**Blockchain** — Livro-razão público, distribuído e imutável que registra todas as transações Bitcoin desde o primeiro bloco.

**Build Reproduzível** — Software que pode ser compilado por qualquer pessoa e gerar um binário idêntico bit a bit. Permite verificar que o código-fonte corresponde exatamente ao executável distribuído.

---

## C — CoinJoin e Coldcard {-}

**Change (troco)** — Output de uma transação que retorna ao remetente. Quando você gasta um UTXO de 0.05 BTC enviando 0.03 BTC, os \~0.0199 BTC restantes voltam como troco para um novo endereço seu.

**Coin Control** — Prática de selecionar manualmente quais UTXOs gastar em cada transação, em vez de deixar a carteira escolher automaticamente.

**CoinJoin** — Técnica de privacidade onde múltiplas pessoas combinam seus bitcoins em uma única transação, misturando os inputs e outputs. Após o CoinJoin, um observador externo não consegue determinar qual output pertence a qual input.

**Coldcard** — Hardware wallet fabricada pela Coinkite. Considerada o padrão ouro para Bitcoin. Opera totalmente air-gapped via SD card ou QR code.

**Cold Storage** — Armazenamento de chaves privadas em dispositivo completamente offline. O oposto de hot wallet.

**Coordinator** — Servidor que organiza os rounds de CoinJoin, agrupando participantes e coordenando a criação da transação conjunta.

---

## D — DeCripto e Dice Rolls {-}

**DeCripto** — Declaração de Criptoativos instituída pela IN RFB 2291/2025. Substitui o reporte mensal da IN 1888 a partir de 01/07/2026, com limite de R$ 35.000/mês para operações sem exchange brasileira.

**Dice Rolls** — Lançamentos de dados físicos usados para gerar entropia verdadeiramente aleatória. O Coldcard e outros dispositivos aceitam dice rolls como entrada para gerar a seed BIP39.

**Dust** — UTXO de valor tão pequeno que a taxa para gastá-lo é maior ou igual ao seu valor. Acumular dust polui a carteira.

---

## E — EPS e eigenwallet {-}

**EPS (Electrum Personal Server)** — Servidor Electrum que você roda em seu próprio nó Bitcoin. Permite que sua carteira Electrum/Sparrow consulte a blockchain sem usar servidores públicos de terceiros.

**eigenwallet** — Cliente de atomic swap **BTC→XMR** (direção taker). Trustless, sem KYC, com Tor integrado. Para **XMR→BTC**, use RetoSwap na prática (jun/2026).

---

## F — FCMP++ e Feather Wallet {-}

**FCMP++ (Full-Chain Membership Proofs)** — Upgrade do protocolo Monero em desenvolvimento. Stressnet beta desde mai/2026; **ainda não ativo em mainnet** (jun/2026). Expande o anonymity set de 16 decoys para toda a blockchain quando ativado.

**Feather Wallet** — Carteira Monero desktop leve com Tor integrado nativamente. Alternativa mais rápida e leve que a Monero GUI oficial.

---

## H — Hardware Wallet e HTLC {-}

**Hardware Wallet** — Dispositivo físico dedicado a guardar chaves privadas e assinar transações. Opera offline e nunca expõe as chaves ao computador conectado à internet.

**Heurística** — Regra prática usada por analistas de blockchain para inferir propriedade de endereços. Exemplo: common-input-ownership assume que todos os inputs de uma transação pertencem à mesma pessoa.

**Hot Wallet** — Carteira onde as chaves privadas estão em dispositivo conectado à internet. Mais conveniente, menos segura.

**HTLC (Hash Time-Locked Contract)** — Contrato inteligente que garante a atomicidade de swaps entre blockchains. Se uma parte não cumprir, a outra recebe reembolso automaticamente após um timeout.

---

## J — JoinMarket {-}

**JoinMarket** — Implementação de CoinJoin descentralizada (P2P). Makers fornecem liquidez ganhando fees; takers iniciam coinjoins pagando fees. Não depende de coordenador central.

---

## K — KeePassXC e Krux {-}

**KEF (Krux Encrypted File)** — Formato proprietário do Krux para backup criptografado de seeds e configurações. Protegido com senha forte.

**Kill Switch** — Mecanismo do Whonix-Gateway: se o Tor cair ou a conexão for interrompida, todo tráfego de rede da Workstation é bloqueado imediatamente. Impede vazamento acidental de IP real.

**KeePassXC** — Gerenciador de senhas open source com criptografia AES-256. Usado para armazenar PINs, metadados de transações, endereços .onion e notas seguras.

**Krux** — Firmware open source para microcontroladores Kendryte K210 (Maix Amigo, M5StickV). Funciona como dispositivo air-gapped stateless com suporte a Taproot.

**KYC (Know Your Customer)** — Processo de identificação exigido por exchanges. Requer envio de documentos pessoais e vincula sua identidade civil aos seus endereços Bitcoin.

---

## L — Liana e Lightning Network {-}

**Liana Wallet** — Carteira Bitcoin que usa Miniscript para codificar políticas de gasto complexas, como herança com timelock.

**Lightning Network** — Camada de segunda ordem sobre o Bitcoin que permite transações instantâneas e de baixo custo usando canais de pagamento.

---

## M — Monero e Multisig {-}

**Miniscript** — Linguagem para codificar condições de gasto Bitcoin de forma estruturada e analisável.

**Monero (XMR)** — Criptomoeda focada em privacidade por padrão. Usa Ring Signatures, Stealth Addresses e RingCT para ocultar remetente, destinatário e valor.

**Multisig** — Carteira que requer múltiplas assinaturas (ex: 2 de 3) para autorizar uma transação.

---

## N — Nó (Node) {-}

**Nó (Node)** — Computador que roda software de validação (ex: Bitcoin Core) e mantém uma cópia da blockchain, verificando cada transação e bloco.

---

## O — Output Descriptor {-}

**Output Descriptor** — String padronizada que descreve completamente como uma carteira deriva endereços: quais chaves públicas, qual caminho de derivação (ex: m/84'/0'/0'), qual tipo de script. **Backup obrigatório em configurações multisig** — sem o descriptor, os fundos podem ser irrecuperáveis mesmo com todas as seeds. Sparrow Wallet permite exportar via Arquivo → Exportar carteira → Salvar Output Descriptor.

---

## P — Passphrase e PSBT {-}

**Passphrase (BIP39)** — Palavra ou frase adicional escolhida pelo usuário que, combinada com a seed de 24 palavras, gera uma carteira completamente diferente. Também chamada de "25ª palavra".

**Plausible Deniability** — Capacidade de negar a posse de fundos de forma crível. No contexto da passphrase BIP39: qualquer passphrase (inclusive uma errada) gera uma carteira válida diferente. Você pode mostrar uma carteira vazia (sem passphrase) enquanto sua carteira real existe em outro lugar.

**Polyseed** — Formato de seed de 16 palavras usado pelo Feather Wallet (XMR). **Incompatível com BIP39 de 24 palavras.** Não pode ser restaurado em hardware wallets BIP39 padrão. Requer backup separado da seed Bitcoin.

**PayJoin (P2EP)** — Transação colaborativa onde pagador e recebedor contribuem inputs, quebrando a heurística de common-input-ownership.

**PGP (Pretty Good Privacy)** — Sistema de criptografia usado para assinar e verificar arquivos. Toda ferramenta neste livro deve ter sua assinatura PGP verificada antes do uso.

**PSBT (Partially Signed Bitcoin Transaction)** — Formato padronizado para transações Bitcoin parcialmente assinadas. Permite criar a transação em um dispositivo online, assinar em dispositivo offline, e transmitir de volta no online.

---

## R — RetoSwap e RoboSats {-}

**RetoSwap** — Interface do Haveno, uma exchange P2P descentralizada focada em Monero. Permite (1) comprar/vender XMR com fiat (dinheiro físico, Pix, transferência) sem KYC e (2) fazer swaps XMR→BTC em sentido inverso ao eigenwallet. Ver também: eigenwallet, arXiv:2505.02392.

**RingCT (Ring Confidential Transactions)** — Tecnologia Monero que oculta os valores das transações. Combinada com Ring Signatures e Stealth Addresses, torna as transações Monero privadas por padrão em três dimensões: remetente, destinatário e valor.

**Ring Signature** — Técnica criptográfica onde uma transação é assinada por um grupo. O observador externo sabe que alguém do grupo assinou, mas não sabe quem. Monero usa ring size 16 (16 possíveis remetentes).

**RoboSats** — Exchange P2P sobre Tor e Lightning Network. Permite comprar/vender BTC com Pix sem criar conta. Usa avatares descartáveis.

---

## S — Seed e Sparrow Wallet {-}

**scurl-download** — Wrapper seguro do Whonix que força downloads a passarem pela rede Tor.

**Seed (Semente)** — Lista de 12 ou 24 palavras BIP39 que geram todas as chaves privadas da sua carteira.

**SeedSigner** — Dispositivo DIY (faça você mesmo) construído com Raspberry Pi Zero e câmera. Opera como hardware wallet air-gapped stateless.

**SeedQR** — Padrão que codifica uma seed BIP39 em um QR code compacto, que pode ser estampado em metal.

**Snapshot** — Cópia do estado de uma máquina virtual em um momento específico. Permite restaurar a VM exatamente como estava.

**Sparrow Wallet** — Carteira Bitcoin desktop com foco em privacidade. Suporta PSBT, Whirlpool (CoinJoin), multisig e Tor integrado.

**Stateless** — Dispositivo que não mantém estado entre sessões. Ao desligar, todas as informações (incluindo a seed) são apagadas da memória.

**Stealth Address** — Endereço único gerado automaticamente para cada transação Monero. O remetente gera um endereço de uso único a partir do endereço público do destinatário.

**Stream Isolation** — Técnica que atribui circuitos Tor separados para diferentes aplicações, impedindo correlação entre identidades.

---

## T — Tails e Tor {-}

**Trustless** — Sem necessidade de confiar em um intermediário; a segurança vem de contratos ou provas criptográficas (ex.: atomic swap). Em português, costuma-se dizer *sem custódia* ou *sem confiança em terceiros*.

**Tails** — Sistema operacional amnésico que roda a partir de um pendrive USB. Não deixa rastros no computador host. Todo tráfego passa por Tor.

**Taproot** — Atualização do Bitcoin ativada em 2021. Melhora privacidade, eficiência e capacidade de smart contracts.

**Timelock** — Condição em uma transação Bitcoin que impede o gasto antes de um determinado tempo ou altura de bloco.

**Tor** — Rede de anonimato que roteia o tráfego de internet através de múltiplos relays, ocultando o endereço IP de origem.

---

## U — UTXO {-}

**UTXO (Unspent Transaction Output)** — "Nota" de Bitcoin não gasta. Seu saldo é a soma de todos os seus UTXOs.

---

## W — Whirlpool e Whonix {-}

**Watching-only** — Carteira que conhece apenas a chave pública (xpub). Pode ver o saldo e criar transações para assinar, mas não pode gastar.

**Whirlpool** — Implementação de CoinJoin com coordenador central, integrada ao Sparrow Wallet. Usa pools de valores fixos (0.001, 0.01, 0.05, 0.5 BTC).

**Whonix** — Sistema operacional que roda em duas máquinas virtuais: Gateway (força todo tráfego por Tor) e Workstation (onde o usuário opera, sem IP real).

---

## X — XMR e xpub {-}

**XMR** — Símbolo da criptomoeda Monero.

**xpub** — Extended Public Key. Chave pública mestra que pode derivar todos os endereços da carteira, mas não pode gastar. É segura para compartilhar e usar em carteiras watching-only.
