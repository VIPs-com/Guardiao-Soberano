# Capítulo 3 — Chaves, Carteiras e Sementes

## 3.1 O que é uma seed (semente)?

Gerar uma chave privada diretamente é complicado. Ela é um número de 256 bits — algo como uma sequência interminável de zeros e uns. Ninguém consegue memorizar ou digitar isso sem errar.

A solução veio com o BIP39 (Bitcoin Improvement Proposal 39): um padrão que converte entropia (aleatoriedade) em palavras humanas.

Sua seed (semente) é uma lista de 12 ou 24 palavras comuns em inglês. A lista BIP39 tem 2048 palavras. A posição de cada palavra na lista representa 11 bits da sua chave privada.

24 palavras = 24 × 11 = 264 bits = 256 bits de entropia + 8 bits de checksum (verificação de integridade).

---

## 3.2 Por que 24 palavras?

Você pode usar 12 palavras (128 bits de entropia) ou 24 palavras (256 bits).

12 palavras já são extremamente seguras contra força bruta. Mas 24 palavras oferecem uma margem de segurança muito maior contra avanços futuros em computação quântica.

Neste livro, padronizamos 24 palavras. É o que as melhores carteiras de hardware (*hardware wallets*) usam por padrão.

---

## 3.3 A passphrase (25ª palavra)

A passphrase é uma palavra ou frase que VOCÊ escolhe. Ela é adicionada à sua seed para gerar uma carteira completamente diferente.

**Seed pura (24 palavras):** Gera a Carteira A. **Seed + passphrase:** Gera a Carteira B (totalmente diferente).

Por que isso é poderoso?

**Proteção contra coerção:** Se alguém roubar sua seed ou te obrigar a revelá-la, verá apenas a Carteira A. Você pode colocar um valor pequeno nela. Sua carteira real é a Carteira B, que só existe com a passphrase.

**Negabilidade plausível:** Você pode honestamente dizer "minha seed é essa" e entregar as 24 palavras. Sem a passphrase, a carteira real permanece invisível.

**Segurança adicional:** Mesmo que alguém encontre sua placa de aço com as 24 palavras, não poderá acessar seus fundos sem a passphrase.

---

## 3.4 Tipos de carteira

### Carteira quente (hot wallet)

A chave privada está em um dispositivo conectado à internet (celular, computador). Mais conveniente, menos segura. Use apenas para valores pequenos do dia a dia.

### Carteira fria (cold wallet)

A chave privada NUNCA toca um dispositivo conectado. Use hardware wallet ou dispositivo air-gapped dedicado. *Paper wallet* (papel) é legado e **não recomendado** — prefira metal + dispositivo.

### Carteira watching-only (somente leitura)

Conhece apenas a chave PÚBLICA. Pode ver seu saldo e criar transações para assinar, mas NÃO pode gastar. Ideal para monitorar sua carteira fria sem expor as chaves.

### Carteira multisig (múltiplas assinaturas)

Requer duas ou mais chaves privadas para autorizar uma transação. Exemplo: "2 de 3" — qualquer combinação de 2 entre 3 chaves pode gastar. Útil para organizações, herança e segurança adicional.

---

## 3.5 Hardware wallets

### Carteira de hardware (*hardware wallet*)

Um dispositivo físico dedicado que guarda suas chaves privadas e assina transações offline, sem expor a seed ao computador.

As melhores carteiras de hardware NUNCA expõem a chave privada ao computador. Elas recebem a transação não assinada (PSBT), mostram os detalhes na tela para você revisar, e devolvem a transação assinada. A chave privada nunca sai do dispositivo.

No Nível 1, escolheremos e configuraremos uma hardware wallet.

---

## 3.6 Output Descriptor — o backup que ninguém conta

Existe um tipo de backup que a maioria dos guias esquece — e que pode tornar seus fundos irrecuperáveis em configurações avançadas.

O **Output Descriptor** é uma string de texto que descreve exatamente como sua carteira deriva endereços: qual chave pública, qual caminho de derivação (BIP84, BIP86), qual tipo de endereço.

**Para carteiras simples (1-de-1):** Sua seed + passphrase é suficiente para recuperar tudo. O descriptor é opcional.

**Para carteiras multisig (2-de-3 etc.):** O descriptor é OBRIGATÓRIO. Sem ele, mesmo que você tenha todas as seeds, pode não conseguir reconstruir os endereços corretos para encontrar seus fundos. Já houve casos de bitcoins bloqueados por falta do descriptor.

**Como fazer o backup:**

- Sparrow Wallet → Arquivo → Exportar carteira → Salvar Output Descriptor (File → Export Wallet → Save Output Descriptor)
- O descriptor **não** contém chaves privadas — pode ser armazenado digitalmente com risco menor que a seed
- Guarde em local seguro mesmo assim — revela a estrutura da carteira

**Onde adicionar ao seu sistema de backup:**

- KeePassXC: uma cópia cifrada (metadados — sem seed)
- MicroSD em local seguro: cópia opcional do descriptor

---

## 3.7 SeedQR — seed em formato visual

O SeedQR é um formato que codifica toda a seed BIP39 em um único código QR. Permite gravar a seed em metal ou plástico como imagem em vez de palavras.

Compatível com: SeedSigner, Krux, Blockstream Jade, Foundation Passport.

Vantagem: mais rápido de escanear do que digitar 24 palavras. Desvantagem: requer câmera funcional para restaurar — se a câmera do dispositivo quebrar, você precisa das palavras.

Recomendação: mantenha AMBOS os backups — as 24 palavras gravadas em metal E opcionalmente um SeedQR em metal para agilidade.

---

## 3.8 O padrão BIP39 na prática

Sua seed BIP39 pode ser restaurada em qualquer carteira compatível. Isso significa que você não está preso a um fabricante. Se sua Coldcard quebrar, você pode restaurar a mesma seed em uma Jade, uma Passport, ou até em software (apenas em emergência e offline).

A interoperabilidade é uma das maiores forças do Bitcoin. Suas chaves são suas — independentemente de quem fabricou o dispositivo.

---

## 3.9 Setup vs. Seed: o que sobrevive ao apocalipse

Existe uma hierarquia clara entre o que é essencial e o que é apenas conveniente no seu ecossistema de auto-custódia. Muita gente inverte essa hierarquia sem perceber.

| Elemento | O que é? | Se perdido... |
|----------|----------|---------------|
| Hardware wallet | Dispositivo de acesso | Compra outro, restaura com a seed |
| Software (Sparrow, Feather) | Ferramenta de interface | Reinstala, funciona igual |
| Backup dos dados de configuração | Agiliza a recuperação | Sem ele, recuperação demora mais |
| **Seed de 24 palavras** | **A raiz criptográfica** | **Sem ela, os fundos somem para sempre** |

Perdeu a hardware wallet? Com a seed, você a restaura em qualquer dispositivo compatível em minutos. Sem a seed, não há suporte ao cliente que resolva — nenhuma empresa tem acesso ao que está protegido pela sua chave privada.

Queimou o computador com o Sparrow? Com a seed, instala o Sparrow em outro computador e reconstrói tudo. Sem a seed, não há nada a reconstruir.

> *"O setup é a máscara. A seed é o rosto. Troque a máscara quantas vezes quiser, mas nunca mostre o rosto."*

A seed é o único ativo que você não pode substituir, não pode recuperar e não pode delegar. Tudo o mais é logística.

---

## 3.10 A hierarquia da soberania

Se tivéssemos que ordenar o que proteger em ordem decrescente de importância:

**1. Seed de 24 palavras** — o elo de ouro. Nada mais importa se você perdê-la.

**2. Passphrase (25ª palavra)** — se você usa passphrase (e deve usar), ela é tão crítica quanto a seed. Seed sem passphrase abre a carteira errada. Passphrase sem seed não abre nada. Ambas precisam sobreviver, separadas.

**3. Output Descriptor** — obrigatório em multisig. Sem ele, mesmo com todas as seeds, pode ser impossível encontrar os endereços corretos onde seus fundos estão.

**4. Backup de configuração** — acelera a recuperação mas não é estritamente necessário se você tem os itens acima.

**5. O hardware** — descartável. A Coldcard que você usa hoje pode ser substituída por uma Jade, uma SeedSigner, uma Krux, ou qualquer dispositivo compatível com BIP39. Os fundos não estão no hardware — estão na blockchain, protegidos pela seed.

Essa hierarquia deve guiar suas decisões de segurança. Antes de proteger seu laptop com biometria, certifique-se de que suas 24 palavras estão gravadas em aço em dois locais físicos diferentes.

---

## 3.11 Geração segura de entropia: por que não confiar em software

A segurança da sua seed começa antes de qualquer software. Ela começa na aleatoriedade.

Quando uma hardware wallet gera uma seed "automaticamente", ela usa um gerador de números pseudo-aleatórios (PRNG — Pseudo-Random Number Generator). A qualidade da aleatoriedade depende do quão bem o fabricante implementou esse gerador. Fabricantes respeitados (Coldcard, Jade, SeedSigner, Krux) têm implementações auditadas e abertas.

Mas existe uma alternativa que não depende de confiar no software de ninguém: **dados de casino**.

Dados físicos de casino, quando lançados sobre uma superfície plana, produzem entropia verdadeira — imprevisível mesmo para o adversário mais sofisticado. Não há como prever 99 lançamentos de dados físicos.

O processo:
1. Lance os dados 99 vezes (ou mais).
2. Anote os resultados em papel.
3. Insira os números na hardware wallet que suporta "dice roll input" (Coldcard, SeedSigner, Krux).
4. O dispositivo converte os dados em seed BIP39, usando os números como fonte de entropia.

O resultado é uma seed cuja aleatoriedade você verificou com suas próprias mãos — não confiando em nenhum chip, nenhum firmware, nenhum fabricante.

---

## Resumo do Capítulo

| Conceito | Significado |
|----------|-------------|
| BIP39 | Padrão que converte entropia em palavras (PBKDF2-HMAC-SHA512, 2048 iterações) |
| Seed | 24 palavras que geram suas chaves |
| Passphrase | 25ª palavra escolhida por você (gera carteira completamente diferente) |
| Output Descriptor | String que descreve a carteira — backup obrigatório em multisig |
| SeedQR | Seed em formato QR, gravável em metal |
| Hot wallet | Chave privada online |
| Cold wallet | Chave privada offline |
| Watching-only | Apenas chave pública |
| Hardware wallet | Dispositivo dedicado para assinar offline |
| Hierarquia | Seed > Passphrase > Descriptor > Config > Hardware |
| Dados de casino | Fonte de entropia verdadeira, verificável fisicamente |

---

No próximo capítulo, entenderemos a diferença entre privacidade e anonimato, e por que a blockchain transparente do Bitcoin exige cuidados especiais.
