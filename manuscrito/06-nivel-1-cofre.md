# Capítulo 6 - Nível 1: O Cofre

> "O dispositivo que guarda o segredo"

---

## Objetivo

Adquirir e configurar um dispositivo air-gapped como guardião das chaves privadas. A seed NUNCA tocará um computador conectado à rede.

**Tempo estimado:** 1-2 semanas | **Dificuldade:** ★★★☆☆

**Pré-requisitos:** Nível 0 concluído.

---

---

### Passo 1.0 — Escolher seu dispositivo

Você tem opções. Escolha UMA:

```
┌─────────────────────────────────────────────────────────────┐
│ GUIA DE ESCOLHA │
├─────────────────────────────────────────────────────────────┤
│ │
│ ⭐ COLDCARD MK5 (Recomendado) — ~US$170 │
│ • Padrão ouro da comunidade │
│ • Assina via SD card (PSBT) ou QR │
│ • Trick PIN, Brick PIN, duress wallet │
│ • Bitcoin-only, open source firmware │
│ • Ideal: quem quer o melhor │
│ │
│ 💰 BLOCKSTREAM JADE PLUS (Econômico) — ~US$169 │
│ • Câmera para QR airgap │
│ • Open source, preço acessível │
│ • Ideal: orçamento limitado │
│ │
│ 📱 FOUNDATION PASSPORT BATCH 2 (QR) — ~US$150-200 │
│ • QR nativo, UX mais amigável │
│ • Open source, modular │
│ • Ideal: prefere QR a SD card │
│ │
│ 🔧 SEEDSIGNER (DIY) — ~US$50 em peças │
│ • Raspberry Pi Zero + câmera │
│ • Stateless (apaga tudo ao desligar) │
│ • Você monta e verifica cada componente │
│ • Ideal: quer construir o próprio │
│ │
│ 🔧 KRUX (DIY Firmware) — ~US$40-60 em hardware │
│ • Firmware para Maix Amigo, M5StickV │
│ • Stateless, suporte a Taproot │
│ • Builds reproduzíveis │
│ • Ideal: alternativa moderna ao SeedSigner │
│ │
└─────────────────────────────────────────────────────────────┘
```

---

### Passo 1.1 — Adquirir sem vínculo ao seu nome

```
□ Coldcard: coinkite.com (fabricante oficial)
□ Jade: blockstream.com
□ Passport: foundationdevices.com
□ SeedSigner: comprar peças em lojas de eletrônica
□ Krux: comprar Maix Amigo/M5StickV + flashear firmware

□ Se possível, pagar com BTC (mais privacidade)
□ Ou cartão presente (gift card)
□ Enviar para endereço sem seu nome:
 - PO Box (caixa postal)
 - Casa de amigo/familiar
 - Receber em mãos (se loja física)
```

---

### Passo 1.2 — Verificar integridade física

```
□ Conferir embalagem:
 - Bag antiviolação intacta (Coldcard/Jade)
 - Sem rasgos, furos, sinais de abertura
 - Número de série na caixa = número na tela do dispositivo

□ Se for DIY (SeedSigner/Krux):
 - Comprar peças de fornecedores diferentes
 - Verificar se os chips não estão adulterados
 - Flashear firmware você mesmo
 - Verificar hash do firmware (build reproduzível)

□ Se HOUVER suspeita: DEVOLVER, não usar
```

---

### Passo 1.3 — Atualizar firmware (air-gapped)

```
□ Em computador COM internet:
 - Baixar firmware mais recente do site oficial
 - Verificar assinatura PGP do firmware
 - Copiar para MicroSD

□ MicroSD → dispositivo → opção Upgrade Firmware
□ Confirmar versão na tela
□ NUNCA conectar o dispositivo à internet via USB
```

---

### Passo 1.4 — Inicializar com dice rolls

```
□ Dispositivo → New Wallet → Dice Rolls
□ Usar seus 100+ lançamentos de dados do Nível 0
□ Inserir um por um, conferindo na tela
□ Dispositivo gera 24 palavras BIP39
□ NUNCA usar "Quick Generate" (usa RNG interno, menos confiável)
□ Anotar as 24 palavras EM PAPEL (depois gravará em metal)
```

---

### Passo 1.5 — Adicionar passphrase

```
□ Dispositivo → Passphrase → Add Passphrase
□ Digitar a passphrase que você criou no Nível 0
□ Dispositivo mostra "Passphrase: Set"
□ Agora sua carteira REAL está ativa
□ Sem passphrase = carteira vazia (proteção contra coerção)
```

---

### Passo 1.6 — Validar com Ian Coleman (OFFLINE)

```
□ Exportar xpub (chave pública) do dispositivo para MicroSD
□ Em computador OFFLINE com bip39.html (Nível 0):
 - Inserir 24 palavras + passphrase
 - Verificar se o primeiro endereço BIP84 (m/84'/0'/0'/0/0)
 BATE EXATAMENTE com o endereço mostrado no dispositivo
 - Verificar 5º e 15º endereços também
 - Se NÃO bater: ALGO ERRADO. Recomece.
```

---

### Passo 1.7 — Teste de recuperação (CRÍTICO)

```
□ Dispositivo → Advanced → Danger Zone → Destroy Seed
□ Dispositivo apagado (sem seed)
□ Dispositivo → Import Existing → Restore from 24 words
□ Digitar 24 palavras + passphrase
□ Exportar endereços novamente
□ Comparar com os endereços anotados no Passo 1.6
□ DEVEM BATER EXATAMENTE

□ Se NÃO bater: sua seed anotada está ERRADA
 - Regrave a seed em metal
 - Refaça o teste
 - NUNCA envie fundos antes deste teste passar

□ Se SIM: seu backup FUNCIONA. Pode confiar.
```

---

### Verificação do Nível 1

```
□ Dispositivo air-gapped configurado e funcional
□ Firmware atualizado (PGP verificado)
□ Seed gerada com dados físicos, não RNG interno
□ Teste de restauração bem-sucedido (ANTES de enviar fundos)
□ Sei que sem passphrase = carteira vazia
□ Nunca conectei o dispositivo à internet
□ Tenho 2 backups físicos da seed em locais diferentes
□ Tenho 1 backup da passphrase em local separado
```

---

> Meu dispositivo é uma fortaleza offline. Se perdê-lo, a semente de aço me salva. Se me coagirem, a passphrase me protege. O cofre está selado e testado.

---

## 🏅 Conquista: "O Cofre"

> Meu dispositivo é uma fortaleza offline. Se perdê-lo, a semente de aço me salva. Se me coagirem, a passphrase me protege. O cofre está selado e testado.

---

## Referência: Hardware Wallets Air-Gapped

Hardware wallets comerciais com modo AirGap real — sem USB, sem Bluetooth, sem WiFi durante assinar.

Coldcard MK5

Coinkite · Bitcoin-only

Referência

O padrão ouro para Bitcoiners. Assina via SD card (PSBT) ou QR. Dois secure elements de fabricantes diferentes. Sem Bluetooth nativo. Trick PIN, brick PIN, duress wallet.

SD cardPSBTQR (NFC opcional)Bitcoin onlyOpen source fw

Foundation Passport Batch 2

Foundation Devices

HW

Design modular, firmware open source, câmera integrada para QR. Assina via QR ou microSD. Suporte a multisig e PSBT. Filosofia similar ao Coldcard mas com UX mais amigável.

QR codemicroSDOpen sourceBitcoin only

Keystone 3 Pro

Keystone · Multi-coin

HW

Tela grande touchscreen, câmera integrada QR, firmware open source (MIT). Primeiro compatível com MetaMask mobile. Auditado por SlowMist e Keylabs. Firmware Bitcoin-only disponível.

QR nativoSparrow/ElectrumMulti-coinMetaMask

Blockstream Jade

Blockstream · Bitcoin-only

HW

Câmera integrada para QR airgap. Pode ser usado sem conexão de rede (modo QR puro). Virtual Secure Element. Open source, funciona com Sparrow, Electrum, Green. Preço acessível.

QR modeOpen sourceBitcoin onlySparrow/Electrum

NGRAVE ZERO

NGRAVE · Certificado EAL7

Premium

Único dispositivo com certificação EAL7 (nível mais alto possível). Comunicação exclusivamente via QR. Desenvolvido com KU Leuven (COSIC) e IMEC. Preço ~$398. Multi-chain.

EAL7QR onlyPreço alto15 chains nativas

ELLIPAL Titan 2.0

ELLIPAL · Multi-coin

HW

Carcaça de metal selada, sem portas físicas de dados. Assina exclusivamente por QR. App mobile complementar. Suporta 10.000+ moedas. Filosofia de isolamento físico total.

Sem portas físicasQR onlyMulti-coin

Projetos open source onde você constrói o próprio dispositivo. Zero confiança no fabricante — você verifica cada componente.

SeedSigner

Raspberry Pi Zero + câmera · Stateless

DIY ★

Considerado "Security Endgame" pela comunidade. Stateless — apaga tudo ao desligar, sem memória entre sessões. Você monta com peças genéricas (~$50), flasheia o firmware e verifica cada linha de código. QR puro. Suporte a multisig + PSBT + SeedQR.

Stateless100% open sourceQR / SeedQRSparrow / ElectrumMultisig

Krux

Firmware para Kendryte K210 · Stateless

DIY ★

Firmware open source para microcontroladores K210 (Maix Amigo, M5StickV). Stateless, builds reproduzíveis, tamper detection via hash de flash (desde v24.11). Suporte a Taproot, Miniscript, KEF encryption (v25.09). Versão atual: v26.04.0 (abr/2026). Alternativa direta ao SeedSigner.

TaprootMiniscriptBuilds reproduzíveisKEF encryptionQR / SD card

Specter DIY

STM32 F469-Discovery

DIY

Firmware DIY da Specter para placa STM32 F469-Discovery. QR airgap, multisig, PSBT. Compatível com Specter Desktop e Sparrow. Projeto menor que SeedSigner/Krux mas robusto.

QR codePSBTSpecter Desktop

Dice Rolls + rolls.py

Entropia manual · Comunidade Bitcoin

DIY

Gerar seeds com dados físicos de casino. Sem confiar em RNG de nenhum dispositivo. A comunidade usa rolls.py (Python offline) para converter os rolls em BIP39. Cruzado e validado com Ian Coleman, Coldcard e Cobo. Auditável por qualquer pessoa.

Zero confiança em RNGVerificávelColdcard / SeedSigner

⚠ Ferramentas de software offline: usar SEMPRE em máquina air-gapped ou Tails em modo offline. Nunca em computador conectado à internet.

Ian Coleman BIP39

iancoleman.io/bip39 · arquivo .html standalone

Ferramenta

Padrão da comunidade para derivar endereços, chaves e paths (BIP32/44/49/84) a partir de uma seed. Arquivo HTML único, verificável via SHA256. Comunidade usa no Tails offline — download no Tor Browser, desconecta da rede, abre no browser local. Indispensável para auditoria.

HTML standaloneVerificável SHA256BIP32/44/49/84Multi-coin

Liana Wallet

Wizardsardine · Miniscript + timelocks

Software

Wallet desktop (Win/Mac/Linux) que usa Miniscript para codificar políticas de gasto on-chain. Chave primária para uso normal + chave de recuperação com timelock (ativa só depois de N dias de inatividade). Ideal para herança, decaying multisig, backups sem papel. Open source, builds reproduzíveis.

MiniscriptTimelocks on-chainHerançaColdcard/BitBox/LedgerTaproot (v8)

Sparrow Wallet (offline)

Coordinator de carteira fria

Software

Sparrow pode rodar em modo offline como coordinator — cria PSBTs sem conexão. Usuário cria transação no Sparrow online, exporta PSBT para o dispositivo air-gapped via QR ou arquivo, recebe de volta assinado e faz broadcast. Tor integrado nativo.

PSBT coordinatorTor integradoSeedSigner/Krux/Coldcard

Electrum (modo offline)

Split wallet: cold + watching-only

Software

Instância offline só assina (cold). Instância online é watching-only (só xpub, sem chaves). Transferência de PSBT via arquivo. Padrão documentado na wiki do Whonix e Qubes. Comunidade usa há mais de uma década.

Split walletWatching-onlyPSBT via arquivo

O coração de qualquer setup airgap é o fluxo PSBT (Partially Signed Bitcoin Transaction). Aqui está o que a comunidade faz na prática.

1 · Coordinator cria a transação (online)

Sparrow / Electrum / Liana prepara a transação não assinada. Só conhece a xpub (chave pública). Gera o arquivo PSBT ou QR code com os detalhes da transação.

2 · Transferência air-gapped para o signatário

Via QR code animado (UR2.0): coordinator exibe na tela, dispositivo air-gapped (SeedSigner, Coldcard, Krux, Jade) escaneia com a câmera. Alternativa: arquivo PSBT em SD card ou microSD.

3 · Dispositivo offline verifica e assina

Dispositivo air-gapped carrega a seed (ou deriva do SeedQR), exibe detalhes da tx para o usuário revisar (endereço destino, valor, fee), solicita confirmação física, assina com a chave privada. Seed é apagada da memória após (stateless).

4 · Devolução da transação assinada

Dispositivo air-gapped exibe QR code com o PSBT assinado. Coordinator (Sparrow/Electrum) escaneia com a webcam do computador. Ou: exporta para SD card e copia o arquivo.

5 · Broadcast via Tor (coordinator online)

Sparrow ou Electrum (no computador online ou no Whonix) faz o broadcast da transação completa para a rede Bitcoin via Tor. Chaves privadas nunca tocaram o computador conectado.

Backup da seed: metal + SeedQR

A comunidade grava as 24 palavras em placa de aço ou titânio (resistente a fogo e água). Alternativa moderna: SeedQR — QR code compacto da seed, estampado em metal. Compatível com SeedSigner, Krux, Jade e Passport. Testar recuperação antes de enviar fundos.

---

## Tutorial: Fluxo PSBT Completo via QR Code

**Fluxo Completo: PSBT via QR Code com Sparrow Wallet + Air-Gapped Signer (SeedSigner ou Krux)**

Este é o **fluxo padrão air-gapped** usado pela comunidade em 2026. Funciona excelente no **Tails OS** com Sparrow persistente.

### Pré-requisitos

* Sparrow Wallet configurado no Tails (watch-only wallet).
* Wallet criada com o **xpub/zpub** do SeedSigner/Krux (importado como Air-gapped Hardware Wallet).
* Seed gerada **offline** no dispositivo air-gapped.
* Câmera funcionando no Tails (webcam do laptop).

---

### Passo a Passo do Fluxo PSBT QR

### No Sparrow (Máquina Online — Tails)

1. Abra sua wallet **watch-only**.
2. Vá na aba **Send**.
3. Preencha:
 * Endereço de destino
 * Quantia
 * Fee rate (use "Calculate" ou defina manualmente)
4. Clique em **Create Transaction**.
5. **Revise tudo com atenção** (inputs, outputs, fee, change address).
6. Clique em **Finalize Transaction for Signing**.

Agora você verá as opções de assinatura.

### Exportar PSBT como QR (Sparrow)

* Clique em **Show QR** (ou **Show BBQR** se for grande).
* Sparrow usa **UR (Uniform Resource)** ou **BBQR** (animated/fountain QR codes) para transmitir PSBTs grandes de forma confiável.
* Deixe a tela do Sparrow exibindo o QR animado (ou sequência de QRs).

### No Dispositivo Air-Gapped (SeedSigner ou Krux)

* **SeedSigner**:
 1. Ligue o dispositivo.
 2. Vá em **Sign → PSBT → Scan QR** (ou similar).
 3. Aponte a câmera para a tela do computador e escaneie o QR animado.
 4. O SeedSigner vai reconstruir a transação e **mostrar os detalhes** na tela (endereços, valores, fee).
 5. **Verifique cuidadosamente** se está correto.
 6. Confirme e assine → ele vai gerar QR(s) com a PSBT assinada.
* **Krux**:
 1. Vá em **Sign → PSBT → Load from camera**.
 2. Escaneie o QR animado do Sparrow.
 3. Revise os detalhes da transação.
 4. Confirme → **Sign to QR code**.

### Importar PSBT Assinada de Volta no Sparrow

1. No Sparrow, clique em **Scan QR** (ou Scan BBQR).
2. Aponte a câmera do laptop para a tela do SeedSigner/Krux (que está mostrando o QR da transação assinada).
3. Sparrow vai ler, combinar as partes (se for animado) e carregar a PSBT com a assinatura.
4. Verifique novamente as signatures (deve aparecer "1 of 1" ou o número correto no multisig).
5. Clique em **Broadcast Transaction** para enviar para a rede.

---

### Dicas Importantes de Segurança e Usabilidade

* **QR Animado (BBQR/UR)**: Sparrow e os signers DIY lidam bem com transações grandes dividindo em múltiplos QRs ou usando animação. Mantenha a câmera estável e boa iluminação.
* **Teste primeiro**: Faça com valores muito pequenos (ex: 0.0001 BTC) várias vezes até se sentir confortável.
* **Multisig**: O fluxo é o mesmo. Você assina com um signer, depois com o outro (pode usar o mesmo dispositivo com seeds diferentes ou dispositivos diferentes).
* **Problemas comuns**:
 * QR não escaneia → Ajuste distância, iluminação ou tente "Scan Static QR" se aplicável.
 * Transação grande → Sparrow usa automaticamente o formato fountain code.
* **No Tails**: Certifique-se de que a webcam está habilitada (Applications → Webcam).

### Vantagens deste Fluxo

* Totalmente **air-gapped** (chaves nunca saem do signer).
* Sem USB, sem SD card (mais simples e seguro).
* Excelente integração Sparrow + SeedSigner/Krux.

---

## Comparativo: SeedSigner vs Krux

**Exploração: SeedSigner e Krux (Alternativas DIY Air-Gapped para Sparrow no Tails)**

Esses dois projetos são **excelentes opções open-source e baratas** para quem não quer comprar hardware wallet comercial (Trezor, Coldcard etc.). Ambos permitem **assinatura air-gapped** (via QR codes) e integram muito bem com **Sparrow Wallet** no Tails. São populares na comunidade Bitcoin em 2026 por transparência, baixo custo e soberania.

### Comparação Rápida (2026)

| Aspecto | **SeedSigner** | **Krux** |
| --- | --- | --- |
| **Custo** | ~US$30-50 (Raspberry Pi Zero 1.3 + peças) | ~US$15-60 (placas genéricas como Maix Amigo, M5StickV ou Yahboom) |
| **Dificuldade** | Média (precisa montar) | Fácil a Média (muitas placas "plug-and-play") |
| **Stateless** | Sim (não guarda seed permanentemente) | Sim (pode ser stateless ou usar SD criptografada) |
| **Air-Gapped** | QR codes (câmera + tela) | QR codes + SD card |
| **Integração Sparrow** | Excelente (PSBT via QR) | Excelente (PSBT via QR/SD) |
| **Vantagens** | Totalmente stateless, comunidade madura, barato | Mais opções de hardware, mais rápido em alguns casos, fácil de flash |
| **Desvantagens** | Montagem manual, Raspberry Pi específico | Hardware genérico (verificar supply chain) |
| **Melhor para** | Quem gosta de DIY completo e máxima stateless | Quem quer algo mais simples de comprar/pronto |

Ambos suportam **multisig**, BIP39, passphrase, e export de xpub/zpub para watch-only no Sparrow.

### SeedSigner (Mais Popular para Stateless)

* **O que é**: Dispositivo air-gapped construído com Raspberry Pi Zero 1.3 (sem WiFi/Bluetooth) + tela Waveshare + câmera. Roda software 100% open-source.
* **Por que bom para novatos no seu setup**: Stateless = seed só fica na memória enquanto ligado. Perfeito para uso com Sparrow no Tails (crie PSBT online → escaneie QR → assine offline → escaneie de volta).
* **Hardware necessário** (links oficiais em seedsigner.com):
 * Raspberry Pi Zero 1.3
 * Waveshare 1.3" LCD HAT com controles
 * Câmera Raspberry Pi
 * Case opcional
* **Instalação básica**:
 1. Baixe a imagem mais recente no GitHub (seedsigner.com ou github.com/SeedSigner).
 2. Flash no SD card (use Raspberry Pi Imager ou `dd`).
 3. Monte o hardware (há muitos vídeos tutoriais passo a passo).
 4. Ligue → gere seed com dice rolls (alta entropia) → backup em metal.
* **Uso com Sparrow**:
 * No Sparrow: Crie wallet multisig ou single-sig watch-only.
 * Exporte PSBT via QR.
 * SeedSigner escaneia, assina e mostra QR de volta.
* **Recursos extras**: Suporte a Satochip (secure element), BIP85, etc.

**Site oficial**: seedsigner.com
**GitHub**: github.com/SeedSigner/seedsigner

### Krux (Mais Fácil de Começar)

* **O que é**: Firmware open-source que transforma placas baratas (Kendryte K210) em signers Bitcoin air-gapped.
* **Vantagens para novatos**: Menos montagem. Placas como Maix Amigo ou M5StickV já vêm com tela e câmera. Fácil de flashar o firmware.
* **Hardware recomendado**:
 * Maix Amigo
 * Yahboom K210
 * M5StickV (opções baratas no AliExpress ou lojas especializadas)
* **Instalação básica**:
 1. Baixe o Krux Installer ou firmware no GitHub (selfcustody.github.io/krux).
 2. Flash via USB (muitas placas têm ferramenta simples).
 3. Ative verificação de integridade do firmware (TC Flash Hash).
 4. Gere seed offline.
* **Uso com Sparrow**: Mesmo fluxo de QR codes para PSBT. Excelente suporte a multisig.

**Site oficial**: selfcustody.github.io/krux
**GitHub**: github.com/selfcustody/krux

### Recomendação para iniciantes (Sparrow no Tails)

* **Comece com Krux** se quiser algo mais simples e rápido de adquirir.
* **Vá de SeedSigner** se preferir máxima stateless e não se importar com montagem (muito elogiado pela comunidade).
* **Fluxo ideal**:
 1. Monte/flashe o dispositivo.
 2. Gere seed **offline** (dice rolls).
 3. Backup em metal + teste restore.
 4. No Tails + Sparrow: wallet watch-only + PSBT via QR.
 5. Use para transações sensíveis; mobile para valores pequenos.

**Dicas de Segurança (Importante!)**:

* Compre peças de fontes confiáveis (evite supply chain attack).
* Verifique hashes e builds reproduzíveis.
* Sempre teste com pequenas quantias.
* Combine com multisig (ex: SeedSigner + outra seed em papel).
* Use Tails amnésico para Sparrow.

---

No próximo capítulo, criaremos a carteira fria watching-only no Tails para enxergar o saldo sem expor a seed.
