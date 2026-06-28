# Capítulo 5 — Nível 0: A Semente

![](../imagens/icones/nivel-0.png){fig-align=center width=30mm}

> "Tudo começa com entropia verdadeira"

---

## Objetivo

Gerar uma seed BIP39 com entropia própria, sem confiar em nenhum software. Adquirir os primeiros **satoshis** (a menor unidade de Bitcoin — 100 milhões de satoshis = 1 BTC) sem KYC (identificação na exchange).

**Tempo estimado:** 2–4 dias | **Dificuldade:** 2/5

> **Nota:** O Passo 0.7 (primeiros satoshis) pode ser adiado até o Nível 2, quando você tiver endereço de recebimento no Sparrow.

**Pré-requisitos:** Nenhum. Você começa aqui.

> **Labs:** `01-gerar-seed-dados` (simulação offline) → Nível 1 HW (seed real) → `02-backup-aco` (metal) — pasta `laboratorio/nivel-0-semente/`.

> **Dica — uma trilha, não dez tutoriais:** Este livro segue um stack coerente (Caps. 5–12): seed em metal → hardware air-gapped → Sparrow na Whonix → PSBT, Whirlpool, swaps. Se fóruns ou vídeos citarem outras marcas **antes** de você terminar a trilha, **não migre no impulso**. Quando precisar saber se algo é alternativa ou concorrente do Sparrow, leia **Capítulo 14.0** (Parte III) ou o **Apêndice G**.

---

## Abertura Narrativa

Maria sempre guardou dinheiro em casa. Quando o banco fechou por três dias durante a crise bancária, ela não conseguiu pagar as contas. Foi ali que decidiu: precisava de um dinheiro que ninguém pudesse bloquear.

Ela ouviu falar de Bitcoin. Mas quando tentou comprar em uma exchange, pediram foto do documento, selfie, comprovante de endereço. "Isso não é liberdade", pensou.

A liberdade começa antes da primeira compra. Começa com uma semente.

Uma semente que você — e apenas você — planta. Em aço. Com entropia gerada pelas suas próprias mãos.

Este capítulo é o fundamento sobre o qual todo o resto será construído. Não tenha pressa. Cada minuto gasto aqui é um minuto que protege o resto da sua vida financeira.

Vamos começar pelo físico — antes de abrir qualquer programa.

---

### Passo 0.1 — Comprar os materiais físicos

Antes de qualquer software, você precisa de coisas tangíveis.

- [ ] Comprar 2 dados de casino (6 faces, cores diferentes)
  - Em loja de jogos ou na internet
  - Cores diferentes ajudam a não confundir
- [ ] Comprar material para backup físico:
  - Opção A: Placa de aço inox + gravador elétrico (~R$ 100)
  - Opção B: Kit de arruelas (washers) inox + estilete (~R$ 50)
  - Opção C: Cryptosteel ou similar (~R$ 500)
  - Opção D: SeedQR estampado em metal (~R$ 150)
- [ ] Comprar envelope pardo (para papel intermediário)
- [ ] Nunca use APENAS papel. Fogo e água destroem papel.

---

### Passo 0.2 — Estudar o básico

Antes de gerar sua seed, entenda o que está fazendo. Pesquise estes conceitos:

- [ ] O que são palavras BIP39?
  - Lista de 2048 palavras padronizadas
  - Cada palavra = 11 bits de entropia (aleatoriedade imprevisível)
  - 24 palavras = 256 bits = segurança astronômica
- [ ] Por que 24 palavras?
  - 12 palavras = 128 bits (seguro, mas margem menor)
  - 24 palavras = 256 bits (padrão ouro)
- [ ] O que é uma passphrase (25ª palavra)?
  - É uma palavra ou frase que VOCÊ escolhe
  - Sem ela, sua seed gera uma carteira VAZIA
  - Com ela, gera sua carteira REAL
  - Protege contra coerção: entregue a seed sem passphrase
- [ ] Por que NUNCA gerar seed em software?
  - Computadores podem ser comprometidos
  - RNG (gerador de números aleatórios) pode ser previsível
  - Dados físicos = entropia verdadeira

---

### Passo 0.3 — Gerar entropia com dados físicos

Este é o momento mais importante do Nível 0. Faça com calma.

- [ ] Sentar em local sem câmeras (celular longe)
- [ ] Pegar os 2 dados de casino
- [ ] Lançar os dois simultaneamente
- [ ] Anotar EM PAPEL o resultado (Ex.: Dado vermelho=3, Dado azul=5 → anote "35")
- [ ] Repetir 100 vezes (50 pares de lançamentos)
- [ ] Você terá 100 números entre 11 e 66

> **AVISO — NUNCA:**
>
> - Filmar ou fotografar os lançamentos
> - Ditar os números para um dispositivo
> - Fazer perto de webcam ou celular
> - Pular lançamentos ("99 está bom")

### Dica de João

João, um bitcoiner de São Paulo, comprou dois dados por R$12 na loja de jogos do bairro. Sentou na cozinha, desligou o celular, fechou a cortina e passou 30 minutos lançando dados. "Parecia um ritual", ele contou depois. "E era."

---

### Passo 0.4 — Converter entropia em seed (SIMULAÇÃO OFFLINE)

> **Lab:** `laboratorio/nivel-0-semente/01-gerar-seed-dados.md` — passo a passo + checklist.

Agora você vai **simular** a geração da seed para validar o processo. As palavras deste exercício **não** são sua seed definitiva — **não envie fundos** para elas. A seed **real** será gerada no **dispositivo air-gapped** que você escolher no Capítulo 6 (Coldcard, SeedSigner, Krux, Jade ou similar).

- [ ] Em um computador COM INTERNET:
  - Baixar o arquivo de iancoleman.io/bip39
  - É um único arquivo .html (standalone)
  - Copiar para um pendrive
  - (Ideal: baixar via Tails + Tor — ver seção opcional no final do capítulo)
- [ ] DESCONECTAR o computador da internet:
  - Desligar WiFi
  - Remover cabo ethernet
  - Modo avião LIGADO
- [ ] Abrir o bip39.html no navegador (funciona offline)
- [ ] Na seção "Entropy", colar seus 100 números de dados
- [ ] O site gera 24 palavras BIP39 de EXERCÍCIO
- [ ] Copiar as palavras EM PAPEL (manualmente, sem imprimir)
- [ ] Fechar o navegador
- [ ] Desligar o computador (isso limpa a memória)
- [ ] **Queimar ou picar** este papel — são palavras de treino, não a seed final

---

### Passo 0.5 — Gravar seed em metal (após Nível 1)

> **Quando fazer:** depois de gerar a seed **real** no dispositivo air-gapped (Capítulo 6). O Passo 0.4 foi só simulação — **não grave em metal** palavras de exercício.

Use os materiais que comprou no Passo 0.1. O lab `laboratorio/nivel-0-semente/02-backup-aco.md` (repositório do projeto) detalha a gravação.

- [ ] Conferir as 24 palavras no dispositivo (3 leituras em voz alta)
- [ ] Gravar na placa de aço com gravador elétrico
  - Ou gravar nas arruelas (uma palavra por arruela)
- [ ] Conferir novamente (mais 2 leituras)
- [ ] Guardar placa em Local Físico A (seguro, discreto)
- [ ] Fazer SEGUNDA CÓPIA:
  - Gravar outra placa/kit de arruelas
  - Guardar em Local Físico B (diferente do A)
  - Ex.: A = sua casa, B = casa de um familiar de confiança
  - Incêndio não pode destruir os dois ao mesmo tempo
- [ ] Opção complementar: SeedQR
  - Gerar QR code compacto da seed
  - Estampar em metal
  - Compatível com SeedSigner, Krux, Jade, Passport
  - Ter palavras + SeedQR = redundância
- [ ] Queimar/picar qualquer papel intermediário restante
- [ ] NUNCA: foto, nuvem, email, WhatsApp, PDF da seed

---

### Passo 0.6 — Criar passphrase (25ª palavra)

- [ ] Criar uma frase memorável e ÚNICA
  - Exemplo BOM: "MinhaAvóNasceuEm1920NoInterior"
  - Exemplo RUIM: "123456" ou "bitcoin"
- [ ] Regras para passphrase forte:
  - Mínimo 8 caracteres (ideal 20+)
  - Misturar maiúsculas, minúsculas, números
  - NUNCA usar dados pessoais reais (data nascimento, nome)
  - NUNCA usar frases de livros, filmes, músicas
  - Pode incluir espaços ("Minha Avó Nasceu em 1920")
- [ ] Anotar passphrase em papel SEPARADO da seed
- [ ] Guardar em Local Físico C (diferente de A e B)
- [ ] Memorizar (repetir 10x por dia durante 1 semana)
- [ ] Apenas você deve conhecer a passphrase — não compartilhe com terceiros

---

### Passo 0.7 — Como adquirir os primeiros satoshis sem KYC

Por que sem KYC? Se você comprar em exchange (Binance, Coinbase), seu nome e documentos ficam vinculados ao primeiro endereço Bitcoin. Isso cria um elo permanente entre sua identidade civil e seus fundos.

**Para o primeiro teste**, a opção mais simples costuma ser **C (venda direta)** ou **A (RoboSats)** — depois que você tiver endereço de recebimento no Nível 2. As opções B e D são válidas, mas B é avançada (Nível 5).

- [ ] **Opção C (recomendada para primeiro teste):** Venda direta
  - Comprar de conhecido que tem BTC
  - Pagar em dinheiro físico
  - Encontro presencial
  - Mais simples; requer confiança
- [ ] **Opção A:** RoboSats (Pix → BTC Lightning)
  - Após Nível 2 (Sparrow com endereço de recebimento)
  - Abra o Tor Browser (rede anônima — Capítulo 4)
  - Acesse o .onion oficial do RoboSats (Apêndice B)
  - Gere um avatar (token único para este trade)
  - Escolha oferta: comprar BTC, pagar com Pix
  - BTC fica em garantia (escrow) na rede Lightning (pagamentos rápidos sobre Bitcoin)
  - Faça o Pix para o vendedor
  - Vendedor confirma → BTC liberado
  - Transfira para Sparrow (on-chain)
  - **AVISO:** Pix tem registro bancário. Para anonimato máximo, use conta sem vínculo óbvio.
- [ ] **Opção D:** Trabalho/freelance
  - Oferecer serviços e receber em BTC
  - Cliente envia diretamente para seu endereço
  - BTC entra sem exchange
- [ ] **Opção B (avançado — Nível 5):** RetoSwap (ex-Haveno)
  - Dinheiro físico → XMR → BTC
  - Instale o RetoSwap (nível 5)
  - Procure oferta "cash by mail" (dinheiro por correio)
  - XMR entra em escrow multisig
  - Envie dinheiro físico pelo correio
  - Vendedor confirma → XMR liberado
  - Depois: swap XMR→BTC (nível 5)
  - Zero registro digital do pagamento
- [ ] Para começar, qualquer valor serve (R$ 50–100)
- [ ] Anote em papel: método, valor, data (no Nível 2, migre para KeePassXC)

---

### Verificação do Nível 0

- [ ] Entropia gerada com dados físicos (100 lançamentos)
- [ ] Simulação bip39 offline concluída; papel de exercício destruído
- [ ] Materiais de backup em metal adquiridos (gravação após seed real — Cap. 6)
- [ ] Passphrase criada e backup em local separado (Local C)
- [ ] Entendo o que é BIP39 e por que 24 palavras
- [ ] Sei que passphrase gera carteira diferente da seed pura
- [ ] Primeiros satoshis (de preferência sem KYC) — ou rota escolhida anotada
- [ ] Nunca digitalizei seed ou passphrase (foto, nuvem, email)

---

## Conquista: "A Semente"

> Validei o caminho da entropia até as 24 palavras — no papel e offline, sem pressa. Minha seed **definitiva** nascerá no cofre air-gapped do próximo capítulo; nenhuma câmera viu meus lançamentos de dados. O fundamento está fincado. Quando os primeiros satoshis chegarem, chegarão sem que a exchange saiba meu nome.

---

## Leitura opcional — após Níveis 1–2

As seções abaixo aprofundam passphrase e métodos alternativos (SeedSigner/Krux). **Não são obrigatórias** para concluir o Nível 0.

---

## Aprofundamento: Passphrase BIP39 na Prática

**Uso completo da passphrase BIP39 (25ª palavra)**

A **passphrase BIP39** (25ª palavra) é uma funcionalidade poderosa do padrão BIP39. Ela transforma sua seed de 24 palavras em uma **carteira totalmente diferente**. É como adicionar uma senha extra que ninguém consegue adivinhar.

### Como Funciona

* Seed normal (24 palavras) → Carteira A
* Seed + Passphrase → Carteira B (diferente)

Mesmo que alguém roube sua seed física, **sem a passphrase exata** não consegue acessar os fundos.

### Vantagens

* Proteção extra contra roubo físico da seed.
* Permite ter várias carteiras a partir da mesma seed (Ex.: uma com passphrase para reservas maiores, outra sem para testes).
* Muito usado em multisig (assinatura com várias chaves — Capítulo 12).

### Desvantagens / Riscos

* Se esquecer a passphrase → fundos perdidos para sempre.
* Digitação errada = carteira errada.
* Mais um item para fazer backup seguro.

### Recomendação para Novatos

**Use uma passphrase forte**, mas **teste tudo** com valores pequenos antes de colocar dinheiro real.

**Exemplos de formato** (nunca use padrões previsíveis — invente o seu):

* Caracteres aleatórios: `K7#mP2xQ9vL4nR8wT1`
* Palavras inventadas longas: `Xk9mP2vL4nR8wT1qZ3`
* Mistura longa: `Z9!kL2mN4pQ7rS1tU3vW5xY8`

### No dispositivo air-gapped (Capítulo 6)

* Ao criar ou carregar a seed → **Aplicar passphrase** (menu *Apply Passphrase* no dispositivo).
* Digite com joystick e confirme.
* Exporte a chave pública estendida (xpub) — ela já inclui o efeito da passphrase.

### No Krux

* Mais fácil: teclado virtual na maioria dos modelos.
* **Carteira → Personalizar → Passphrase** (*Wallet → Customize → Passphrase*).
* Digite e confirme.

### No Sparrow Wallet (Tails)

* Você **não digita** a passphrase no Sparrow.
* O xpub exportado do SeedSigner/Krux **já carrega** a carteira com a passphrase.
* Basta importar o xpub no Sparrow (modo **somente leitura** — *watch-only*).

### Backup seguro (obrigatório)

1. Anote a **seed de 24 palavras** em um local.
2. Anote a **passphrase** em **local completamente separado** (outro país, casa de familiar de confiança, cofre etc.).
3. Grave **ambos em metal** (Ex.: duas placas diferentes).
4. Escreva também o **descritor de saída** completo do Sparrow (*Output Descriptor*).

### Teste de recuperação (faça isso)

1. Crie uma **carteira** de teste com passphrase.
2. Envie uma quantia pequena (Ex.: 0,0001 BTC).
3. Apague a carteira do Sparrow.
4. Recrie importando o xpub do dispositivo de assinatura (com passphrase ativa).
5. Verifique se o saldo aparece.

### Dicas finais de segurança operacional

* **Nunca** digite a passphrase em qualquer computador online.
* Use o SeedSigner/Krux para aplicar a passphrase.
* Em multisig 2-de-3: coloque a passphrase em apenas **uma** das chaves (keystores).
* A passphrase do Passo 0.6 é a que você usará na seed real — teste a recuperação com valor mínimo antes de depositar.

---

## Alternativa: Gerar seed com dados e SeedSigner/Krux

**Gerador de sementes seguras (BIP39) — método no dispositivo**

Gerar a **seed BIP39** (24 palavras neste livro) é um dos passos mais críticos na auto-custódia. O método mais seguro é **offline + alta entropia** (lançamentos de dados).

### Opção preferida no Capítulo 6: SeedSigner ou Krux

Se você montar o **SeedSigner**:

**No SeedSigner**:

1. Ligue o dispositivo (air-gapped).
2. Vá em **Nova seed** ou **Carteira → Nova carteira** (*New Seed* / *Wallet → New Wallet*).
3. Escolha **Gerar com lançamentos de dados** (*Generate with Dice Rolls* — o método mais seguro).
4. Role um dado de 6 faces **várias vezes** (o SeedSigner indica quantas roladas são necessárias):
 * Para **24 palavras**: ~256 bits (cerca de 100–200 roladas, alinhado ao Passo 0.3).
5. Digite os números no SeedSigner com o joystick.
6. O dispositivo calcula o checksum automaticamente e mostra as 24 palavras.
7. **Anote imediatamente em papel/metal** (nunca tire foto ou digite em outro lugar).
8. Confirme as palavras (o SeedSigner mostra novamente para verificação).

**No Krux**: processo similar (**Carteira → Nova → Lançamentos de dados**).

**Vantagem**: Tudo fica 100% offline, sem estado persistente no PC.

### Método manual com lançamentos de dados (máxima soberania — sem dispositivo)

Se ainda não montou o signer:

**Ferramentas**:

* Um dado de 6 faces (ou vários).
* Tails OS em modo air-gapped (sem rede).

**Passo a Passo**:

1. Boot no **Tails** sem conexão de rede (desative WiFi).
2. Abra o Terminal.
3. Use este comando simples para registrar roladas:

```bash
echo "Role o dado e digite o número (1-6):"
```

4. **Quantidade recomendada** (24 palavras):
 * Alinhe ao Passo 0.3: **100 pares de lançamentos** (ou siga a contagem do dispositivo no Cap. 6).
5. Concatene todos os números (Ex.: 4256134...) e converta offline conforme o **Passo 0.4** (Ian Coleman no Tails, sem rede).

### Boas práticas de segurança (obrigatório)

* **Nunca** gere seed em computador conectado à internet.
* Use **lançamentos de dados** (não use geradores online ou `/dev/urandom` sozinho).
* Guarde a seed em **metal** (Billfodl, Cryptosteel ou placa de aço + punção).
* Faça **backup em 2–3 locais físicos diferentes**.
* Teste a **recuperação** com valor mínimo antes de usar com quantias reais.
* Use **passphrase** extra (25ª palavra BIP39) para segurança adicional.
* Nunca diga as palavras para ninguém.

### Fluxo recomendado com SeedSigner

Se escolher o **SeedSigner**:

1. Termine a montagem + flash.
2. Gere a seed **direto no SeedSigner** com lançamentos de dados.
3. Exporte o xpub via QR.
4. Importe no Sparrow como carteira somente leitura (*watch-only*).

---

No próximo capítulo, escolheremos e configuraremos o **dispositivo air-gapped** (Coldcard, SeedSigner, Krux, Jade ou similar) que guardará a semente definitiva como um cofre offline.
