# Capítulo 5 - Nível 0: A Semente

> "Tudo começa com entropia verdadeira"

---

## Objetivo

Gerar uma seed BIP39 com entropia própria, sem confiar em nenhum software. Adquirir os primeiros satoshis sem KYC.

**Tempo estimado:** 2-4 dias | **Dificuldade:** ★★☆☆☆

**Pré-requisitos:** Nenhum. Você começa aqui.

---

## Abertura Narrativa

Maria sempre guardou dinheiro em casa. Quando o banco fechou por três dias durante a crise bancária, ela não conseguiu pagar as contas. Foi ali que decidiu: precisava de um dinheiro que ninguém pudesse bloquear.

Ela ouviu falar de Bitcoin. Mas quando tentou comprar em uma exchange, pediram foto do documento, selfie, comprovante de endereço. "Isso não é liberdade", pensou.

A liberdade começa antes da primeira compra. Começa com uma semente.

Uma semente que você — e apenas você — planta. Em aço. Com entropia gerada pelas suas próprias mãos.

Este capítulo é o fundamento sobre o qual todo o resto será construído. Não tenha pressa. Cada minuto gasto aqui é um minuto que protege o resto da sua vida financeira.

---

### Passo 0.1 — Comprar os materiais físicos

Antes de qualquer software, você precisa de coisas tangíveis.

```
□ Comprar 2 dados de casino (6 faces, cores diferentes)
 - Qualquer loja de jogos ou internet
 - Cores diferentes ajudam a não confundir

□ Comprar material para backup físico:
 Opção A: Placa de aço inox + gravador elétrico (~R$100)
 Opção B: Kit de arruelas (washers) inox + estilete (~R$50)
 Opção C: Cryptosteel ou similar (~R$500)
 Opção D: SeedQR estampado em metal (~R$150)

□ Comprar envelope pardo (para papel intermediário)

□ Nunca use APENAS papel. Fogo e água destroem papel.
```

---

### Passo 0.2 — Estudar o básico

Antes de gerar sua seed, entenda o que está fazendo. Pesquise estes conceitos:

```
□ O que são palavras BIP39?
 - Lista de 2048 palavras padronizadas
 - Cada palavra = 11 bits de entropia
 - 24 palavras = 256 bits = segurança astronômica

□ Por que 24 palavras?
 - 12 palavras = 128 bits (seguro, mas margem menor)
 - 24 palavras = 256 bits (padrão ouro)

□ O que é uma passphrase (25ª palavra)?
 - É uma palavra ou frase que VOCÊ escolhe
 - Sem ela, sua seed gera uma carteira VAZIA
 - Com ela, gera sua carteira REAL
 - Protege contra coerção: entregue a seed sem passphrase

□ Por que NUNCA gerar seed em software?
 - Computadores podem ser comprometidos
 - RNG (gerador de números aleatórios) pode ser previsível
 - Dados físicos = entropia verdadeira
```

---

### Passo 0.3 — Gerar entropia com dados físicos

Este é o momento mais importante do Nível 0. Faça com calma.

```
□ Sentar em local sem câmeras (celular longe)
□ Pegar os 2 dados de casino
□ Lançar os dois simultaneamente
□ Anotar EM PAPEL o resultado (ex: Dado vermelho=3, Dado azul=5 → anote "35")
□ Repetir 100 vezes (50 pares de lançamentos)
□ Você terá 100 números entre 11 e 66

⚠️ NUNCA:
- Filmar ou fotografar os lançamentos
- Ditar os números para um dispositivo
- Fazer perto de webcam ou celular
- Pular lançamentos ("99 está bom")
```

### Dica de João

João, um bitcoiner de São Paulo, comprou dois dados por R$12 na loja de jogos do bairro. Sentou na cozinha, desligou o celular, fechou a cortina, e passou 30 minutos lançando dados. "Parecia um ritual", ele contou depois. "E era."

---

### Passo 0.4 — Converter entropia em seed (SIMULAÇÃO OFFLINE)

Agora você vai simular a geração da seed para VALIDAR o processo. A seed REAL será gerada no Coldcard (Nível 1).

```
□ Em um computador COM INTERNET:
 - Baixar o arquivo de iancoleman.io/bip39
 - É um único arquivo .html (standalone)
 - Copiar para um pendrive

□ DESCONECTAR o computador da internet:
 - Desligar WiFi
 - Remover cabo ethernet
 - Modo avião LIGADO

□ Abrir o bip39.html no navegador (funciona offline)
□ Na seção "Entropy", colar seus 100 números de dados
□ O site gera 24 palavras BIP39
□ Copiar as palavras EM PAPEL (manualmente, sem imprimir)
□ Fechar o navegador
□ Desligar o computador (isso limpa a memória)
□ Agora você tem 24 palavras no papel
```

---

### Passo 0.5 — Gravar seed em metal

```
□ Conferir as 24 palavras (3 leituras em voz alta)
□ Gravar na placa de aço com gravador elétrico
 Ou gravar nas arruelas (uma palavra por arruela)
□ Conferir novamente (mais 2 leituras)
□ Guardar placa em Local Físico A (seguro, discreto)

□ Fazer SEGUNDA CÓPIA:
 - Gravar outra placa/kit de arruelas
 - Guardar em Local Físico B (diferente do A)
 - Ex: A = sua casa, B = casa de familiar confiável
 - Incêndio não pode destruir os dois ao mesmo tempo

□ Opção complementar: SeedQR
 - Gerar QR code compacto da seed
 - Estampar em metal
 - Compatível com SeedSigner, Krux, Jade, Passport
 - Ter palavras + SeedQR = redundância

□ Queimar/picar o papel intermediário
□ NUNCA: foto, nuvem, email, WhatsApp, PDF da seed
```

---

### Passo 0.6 — Criar passphrase (25ª palavra)

```
□ Criar uma frase memorável e ÚNICA
 Exemplo BOM: "MinhaAvóNasceuEm1920NoInterior"
 Exemplo RUIM: "123456" ou "bitcoin"

□ Regras para passphrase forte:
 - Mínimo 8 caracteres (ideal 20+)
 - Misturar maiúsculas, minúsculas, números
 - NUNCA usar dados pessoais reais (data nascimento, nome)
 - NUNCA usar frases de livros, filmes, músicas
 - Pode incluir espaços ("Minha Avó Nasceu em 1920")

□ Anotar passphrase em papel SEPARADO da seed
□ Guardar em Local Físico C (diferente de A e B)
□ Memorizar (repetir 10x por dia durante 1 semana)
□ Peça a 1 pessoa de confiança para também memorizar
 (mas NUNCA revele a seed junto)
```

---

### Passo 0.7 — Como adquirir os primeiros satoshis sem KYC

Por que sem KYC? Se você comprar em exchange (Binance, Coinbase), seu nome e documentos ficam vinculados ao primeiro endereço Bitcoin. Isso cria um elo permanente entre sua identidade civil e seus fundos.

```
□ Opção A: RoboSats (Pix → BTC Lightning)
 - Abra o Tor Browser
 - Acesse o .onion oficial do RoboSats
 - Gere um avatar (token único para este trade)
 - Escolha oferta: comprar BTC, pagar com Pix
 - BTC fica em escrow Lightning
 - Faça o Pix para o vendedor
 - Vendedor confirma → BTC liberado
 - Transfira para Sparrow (on-chain)
 ⚠️ Pix tem registro bancário. Para anonimato máximo, use conta sem vínculo óbvio.

□ Opção B: RetoSwap/Haveno (dinheiro físico → XMR → BTC)
 - Instale o RetoSwap (nível 5)
 - Procure oferta "cash by mail" (dinheiro por correio)
 - XMR entra em escrow multisig
 - Envie dinheiro físico pelo correio
 - Vendedor confirma → XMR liberado
 - Depois: swap XMR→BTC (nível 5)
 ✅ Zero registro digital do pagamento

□ Opção C: Venda direta
 - Comprar de conhecido que tem BTC
 - Pagar em dinheiro físico
 - Encontro presencial
 ✅ Mais simples, requer confiança

□ Opção D: Trabalho/freelance
 - Oferecer serviços e receber em BTC
 - Cliente envia diretamente para seu endereço
 ✅ BTC entra sem exchange

□ Para começar, qualquer valor serve (R$50-100)
□ Anote no KeePassXC: método, valor, data (para controle próprio)
```

---

### Verificação do Nível 0

```
□ Placa de aço (ou arruelas) gravada e guardada em 2 locais
□ Passphrase memorizada e backup em local separado
□ Entendo o que é BIP39 e por que 24 palavras
□ Sei que passphrase gera carteira diferente da seed pura
□ Tenho meus primeiros satoshis (de preferência sem KYC)
□ Nunca digitalizei a seed (foto, nuvem, email)
```

---

> Plantei minha soberania em aço. Nenhum software gerou minhas chaves. Nenhuma câmera viu minhas palavras. O fundamento está fincado. Os primeiros satoshis chegaram sem que ninguém soubesse meu nome.

---

## 🏅 Conquista: "A Semente"

> Plantei minha soberania em aço. Nenhum software gerou minhas chaves. Nenhuma câmera viu minhas palavras. O fundamento está fincado. Os primeiros satoshis chegaram sem que ninguém soubesse meu nome.

---

## Aprofundamento: Passphrase BIP39 na Prática

**Uso Completo da BIP39 Word 25 (Passphrase)**

A **BIP39 Word 25** (ou **passphrase**) é uma funcionalidade poderosa da padrão BIP39. Ela transforma sua seed de 12/24 palavras em uma wallet **totalmente diferente**. É como adicionar uma senha extra que ninguém consegue adivinhar.

### Como Funciona

* Seed normal (12/24 palavras) → Wallet A
* Seed + Passphrase → Wallet B (diferente)

Mesmo que alguém roube sua seed física, **sem a passphrase exata** não consegue acessar os fundos.

### Vantagens

* Proteção extra contra roubo físico da seed.
* Permite ter várias wallets a partir da mesma seed (ex: uma com passphrase para holdings grandes, outra sem para testes).
* Muito usado em multisig (colocar passphrase em apenas um dos 3 keystores).

### Desvantagens / Riscos

* Se esquecer a passphrase → fundos perdidos para sempre.
* Digitação errada = wallet errada.
* Mais um item para fazer backup seguro.

### Recomendação para Novatos

**Use uma passphrase forte**, mas **teste tudo** com valores pequenos antes de colocar dinheiro real.

**Exemplos de boas passphrases** (nunca use estes!):

* Frase longa: `MinhaCasaVerde2026BitcoinSoberania`
* Palavras aleatórias: `correct horse battery staple purple`
* Mistura: `T3st3S3gur0!2026@Bitcoin`

### Como Usar no Seu Setup

### No SeedSigner (como vimos antes)

* Ao criar ou carregar a seed → **Apply Passphrase**.
* Digite com joystick e confirme.
* Exporte o xpub (esse xpub já inclui o efeito da passphrase).

### No Krux

* Mais fácil: teclado virtual na maioria dos modelos.
* **Wallet → Customize → Passphrase**.
* Digite e confirme.

### No Sparrow Wallet (Tails)

* Você **não digita** a passphrase no Sparrow.
* O xpub exportado do SeedSigner/Krux **já carrega** a wallet com a passphrase.
* Basta importar o xpub normalmente (watch-only ou multisig).
* Sparrow trata a passphrase como parte da wallet.

### Backup Seguro (Obrigatório)

1. Anote a **seed de 12/24 palavras** em um local.
2. Anote a **passphrase** em **local completamente separado** (outro país, casa de familiar de confiança, cofre etc.).
3. Grave **ambos em metal** (ex: duas placas diferentes).
4. Escreva também o **Output Descriptor** completo do Sparrow.

### Teste de Restore (Faça Isso!)

1. Crie uma wallet de teste com passphrase.
2. Envie uma quantia pequena (ex: 0.0001 BTC).
3. Apague a wallet do Sparrow.
4. Recrie a wallet importando o xpub do signer (com passphrase ativa).
5. Verifique se o saldo aparece.

### Dicas Finais de OPSEC

* **Nunca** digite a passphrase em qualquer computador online.
* Use o SeedSigner/Krux para aplicar a passphrase.
* Em multisig 2-of-3: coloque a passphrase em apenas **um** dos keystores (melhor equilíbrio).
* Comece **sem passphrase** para aprender o fluxo, depois adicione.

Estamos construindo um setup bem sólido.

---

## Alternativa: Gerar Seed com Dados e SeedSigner/Krux

**Gerador de Sementes Seguras (BIP39) — Método Recomendado para Novatos**

Gerar a **seed BIP39** (12 ou 24 palavras) é um dos passos mais críticos na auto-custódia. O método mais seguro é **offline + alta entropia** (dice rolls).

### Melhor Opção: Gerar Direto no SeedSigner ou Krux (Recomendado)

Se você montar o **SeedSigner**:

**No SeedSigner**:

1. Ligue o dispositivo (air-gapped).
2. Vá em **New Seed** ou **Wallet → New Wallet**.
3. Escolha **Generate with Dice Rolls** (o método mais seguro).
4. Role um dado de 6 faces **várias vezes** (o SeedSigner indica quantas roladas são necessárias):
 * Para **12 palavras**: ~128 bits de entropia (cerca de 50-100 roladas).
 * Para **24 palavras**: ~256 bits (cerca de 100-200 roladas).
5. Digite os números no SeedSigner com o joystick.
6. O dispositivo calcula o checksum automaticamente e mostra as 12/24 palavras.
7. **Anote imediatamente em papel/metal** (nunca tire foto ou digite em outro lugar).
8. Confirme as palavras (o SeedSigner mostra novamente para verificação).

**No Krux**: O processo é similar (Wallet → New → Dice Rolls).

**Vantagem**: Tudo fica 100% offline e stateless.

### Método Manual com Dice Rolls (Máxima Soberania — Sem Dispositivo)

Se ainda não montou o signer:

**Ferramentas**:

* Um dado de 6 faces (ou vários).
* Tails OS em modo air-gapped (sem rede).

**Passo a Passo**:

1. Boot no **Tails** sem conexão de rede (desative WiFi).
2. Abra o Terminal.
3. Use este comando simples para registrar roladas:

```
echo "Role o dado e digite o número (1-6):"
```

4. **Quantidade recomendada**:
 * 12 palavras → mínimo 128 bits → **99 roladas** de dado de 6 faces.
 * 24 palavras → **198-256 roladas**.
5. Concatene todos os números (ex: 4256134...) e use uma ferramenta offline confiável.

**Ferramenta Offline Recomendada**:

* Baixe o **Ian Coleman BIP39 Tool** (versão HTML offline):
 1. No Tails online, baixe: https://iancoleman.io/bip39/
 2. Salve a página HTML completa no volume persistente.
 3. Reinicie o Tails **sem rede**.
 4. Abra o arquivo HTML no navegador (Firefox) offline.
 5. Cole a sequência de números do dado no campo "Entropy".
 6. Escolha **BIP39** → 24 palavras → Native Segwit.
 7. Anote as palavras + passphrase (opcional).

**Nunca** use este site online.

### Boas Práticas de Segurança (Obrigatório)

* **Nunca** gere seed em computador conectado à internet.
* Use **dice rolls** (não use geradores online ou `/dev/urandom` sozinho).
* Guarde a seed em **metal** (Billfodl, Cryptosteel, ou placa de aço + punção).
* Faça **backup em 2-3 locais físicos diferentes**.
* Teste o restore com small amount antes de usar com valores reais.
* Use **passphrase** extra (BIP39 Word 25) para segurança adicional.
* Nunca diga as palavras para ninguém.

### Fluxo recomendado com SeedSigner

Se escolher o **SeedSigner**:

1. Termine a montagem + flash.
2. Gere a seed **direto no SeedSigner** com dice rolls.
3. Exporte o xpub via QR.
4. Importe no Sparrow como watch-only.

---

No próximo capítulo, escolheremos e configuraremos o dispositivo que guardará esta semente como um cofre offline: a hardware wallet air-gapped.
