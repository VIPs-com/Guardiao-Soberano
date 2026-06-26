# Capítulo 6 — Nível 1: O Cofre

> "O dispositivo que guarda o segredo"

---

## Objetivo

Adquirir e configurar um dispositivo **air-gapped** (sem WiFi, Bluetooth ou USB de dados durante a assinatura) como guardião das chaves privadas. A seed **nunca** tocará um computador conectado à rede.

**Tempo estimado:** 1–2 semanas | **Dificuldade:** ★★★☆☆

**Pré-requisitos:** Nível 0 concluído.

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
│ • Trick PIN, carteira de coerção (duress), Brick PIN │
│ • Bitcoin-only, open source firmware │
│ • Ideal: quem quer o melhor │
│ │
│ 💰 BLOCKSTREAM JADE PLUS (Econômico) — ~US$169 │
│ • Câmera para QR airgap │
│ • Open source, preço acessível │
│ • Ideal: orçamento limitado │
│ │
│ 📱 FOUNDATION PASSPORT BATCH 2 (QR) — ~US$ 150–200 │
│ • QR nativo, UX mais amigável │
│ • Open source, modular │
│ • Ideal: prefere QR a SD card │
│ │
│ 🔧 SEEDSIGNER (DIY) — ~US$ 50 em peças │
│ • Raspberry Pi Zero + câmera │
│ • Stateless (apaga a seed da memória ao desligar) │
│ • Você monta e verifica cada componente │
│ • Ideal: quer construir o próprio │
│ │
│ 🔧 KRUX (DIY Firmware) — ~US$ 40–60 em hardware │
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
□ Jade Plus: blockstream.com
□ Passport: foundationdevices.com
□ SeedSigner: comprar peças em lojas de eletrônica
□ Krux: comprar Maix Amigo/M5StickV + flashear firmware

□ Se possível, pagar com BTC (mais privacidade)
□ Ou cartão presente (gift card)
□ Enviar para endereço sem seu nome:
 - PO Box (caixa postal)
 - Casa de um amigo ou familiar
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
□ Dispositivo → New Wallet → Dice Rolls (nova seed / lançamentos de dados)
□ Usar seus 100+ lançamentos de dados do Nível 0 (lista anotada em papel)
□ Se perdeu a lista: refaça os lançamentos — não reutilize palavras de exercício do Passo 0.4
□ Inserir um por um, conferindo na tela
□ Dispositivo gera 24 palavras BIP39
□ NUNCA usar "Quick Generate" (RNG interno do chip — você confia no fabricante)
□ Anotar as 24 palavras EM PAPEL (temporário — metal no Passo 1.6b)
```

---

### Passo 1.5 — Adicionar passphrase

```
□ Dispositivo → Passphrase → Add Passphrase
□ Digitar a passphrase que você criou no Nível 0
□ Dispositivo mostra "Passphrase: Set"
□ Agora sua carteira REAL está ativa
□ Sem passphrase = carteira **diferente** (decoy — proteção sob coerção)
```

---

### Passo 1.6 — Validar endereços (OFFLINE)

```
□ Exportar xpub (chave pública estendida — não gasta fundos) para MicroSD ou QR
□ Verificar hash SHA256 do bip39.html antes de abrir (mesmo arquivo do Nível 0)
□ Em computador OFFLINE, nunca conectado à internet, com bip39.html:

⚠️ ÚNICA exceção à Lei 4 (nunca digitar seed em PC):
   validação em máquina dedicada offline. Apague o histórico do navegador após.
   Alternativa futura: comparar só xpub exportado, quando o dispositivo permitir.

 - Inserir 24 palavras + passphrase
 - Verificar se o primeiro endereço BIP84 / Native SegWit (m/84'/0'/0'/0/0, bc1…)
   BATE EXATAMENTE com o endereço mostrado no dispositivo
 - Verificar 5º e 15º endereços também
 - Se NÃO bater: ALGO ERRADO. Recomece.
```

---

### Passo 1.6b — Gravar seed em metal (obrigatório antes do Passo 1.7)

> **Ordem crítica:** faça **antes** do teste destrutivo (1.7). Se apagar a seed do dispositivo sem backup em metal, pode perder tudo.

Siga o **Capítulo 5, Passo 0.5** e o lab [`02-backup-aco.md`](../laboratorio/nivel-0-semente/02-backup-aco.md).

```
□ Conferir as 24 palavras no dispositivo (3 leituras em voz alta)
□ Gravar 2 cópias em metal — Locais Físicos A e B (diferentes)
□ Passphrase permanece em Local C (Capítulo 5, Passo 0.6)
□ Queimar/picar papel temporário das palavras
□ NUNCA: foto, nuvem, email, WhatsApp da seed
```

---

### Passo 1.7 — Teste de recuperação (CRÍTICO)

> **Pré-requisito:** Passo 1.6b concluído (2 cópias em metal).

```
□ Apagar seed do dispositivo (menu varia por modelo):
 - Coldcard: Advanced → Danger Zone → Destroy Seed
 - SeedSigner/Krux: opção equivalente de apagar / factory reset
□ Dispositivo sem seed
□ Import Existing → Restore from 24 words
□ Digitar 24 palavras + passphrase
□ Exportar endereços novamente
□ Comparar com os endereços anotados no Passo 1.6
□ DEVEM BATER EXATAMENTE

□ Se NÃO bater: sua seed gravada está ERRADA
 - Regrave a seed em metal
 - Refaça o teste
 - NUNCA envie fundos antes deste teste passar

□ Se SIM: seu backup FUNCIONA. Pode confiar.
```

---

### Verificação do Nível 1

**Obrigatório antes de enviar fundos:**

```
□ Endereços validados offline (Passo 1.6)
□ 2 backups em metal + passphrase em local separado (Passo 1.6b / Cap. 5)
□ Teste de restauração bem-sucedido (Passo 1.7)
```

**Opsec contínua:**

```
□ Dispositivo air-gapped configurado e funcional
□ Firmware atualizado (PGP verificado)
□ Seed gerada com dados físicos, não RNG interno
□ Sei que sem passphrase = carteira decoy diferente
□ Nunca conectei o dispositivo à internet
```

---

## 🏅 Conquista: "O Cofre"

> Meu dispositivo é uma fortaleza offline. Se perdê-lo, a semente de aço me salva. Se me coagirem, a passphrase me protege. O cofre está selado e testado.

---

## 📎 Leitura opcional — após Níveis 1–2

As seções abaixo aprofundam catálogo de hardware, fluxo PSBT e comparativo DIY. **Não são obrigatórias** para concluir o Nível 1.

---

### Referência rápida — hardware air-gapped

Catálogo completo e alternativas: **Capítulo 14** e **Apêndice G**.

| Dispositivo | Tipo | Comunicação | Notas |
| --- | --- | --- | --- |
| Coldcard MK5 | Comercial | SD / QR | ⭐ Recomendado — Passo 1.0 |
| Blockstream Jade Plus | Comercial | QR | Econômico, Bitcoin-only |
| Foundation Passport B2 | Comercial | QR / microSD | UX amigável |
| SeedSigner | DIY | QR | Stateless, ~US$ 50 em peças |
| Krux | DIY | QR / SD | K210, builds reproduzíveis |

Outros (Keystone, NGRAVE, ELLIPAL, Specter DIY): ver Cap. 14 — fora do guia inicial para não paralisar a escolha.

**Ferramentas offline:** Ian Coleman BIP39 (HTML standalone, verificar SHA256), rolls.py para dice rolls — **sempre** em máquina air-gapped ou Tails offline.

---

### Fluxo PSBT (visão geral)

**PSBT** (*Partially Signed Bitcoin Transaction* — transação parcialmente assinada): o **coordenador** (Sparrow/Electrum) prepara a transação; o dispositivo air-gapped assina offline.

1. **Coordenador cria a transação (online)** — só conhece a xpub; gera PSBT ou QR.
2. **Transferência air-gapped** — QR animado (UR/BBQR) ou arquivo em SD card.
3. **Dispositivo verifica e assina (offline)** — você confirma endereço, valor e taxa.
4. **Devolução da PSBT assinada** — QR ou SD de volta ao coordenador.
5. **Broadcast via Tor** — chaves privadas nunca tocaram o PC online.

![Fluxo PSBT: coordinator online → air-gap → assinatura offline → broadcast via Tor](../imagens/diagrama-psbt.png)

**Backup:** metal + SeedQR opcional (SeedSigner, Krux, Jade, Passport). Teste de recuperação **antes** de enviar fundos.

---

## Tutorial: Fluxo PSBT via QR — após Capítulo 7

> **Pré-requisitos:** Tails + Sparrow instalados (Capítulo 7). Lab: [`03-psbt-via-qr.md`](../laboratorio/nivel-1-cofre/03-psbt-via-qr.md)

**Fluxo PSBT via QR com Sparrow + dispositivo air-gapped (SeedSigner ou Krux)**

Este é o **fluxo padrão air-gapped** usado pela comunidade em 2026. Funciona excelente no **Tails OS** com Sparrow persistente.

### Pré-requisitos

* Sparrow Wallet configurado no Tails (carteira somente leitura — watch-only).
* Carteira criada com o **xpub/zpub** do SeedSigner/Krux (Air-gapped Hardware Wallet).
* Seed gerada **offline** no dispositivo air-gapped.
* Câmera funcionando no Tails (webcam do laptop).

---

### Passo a passo — Sparrow (Tails, online)

1. Abra a carteira **somente leitura** (watch-only).
2. Aba **Send** (Enviar).
3. Preencha endereço de destino, quantia e taxa (fee rate — use **Calculate** ou defina manualmente).
4. **Create Transaction** (Criar transação).
5. Revise inputs, outputs, taxa e endereço de troco (change address).
6. **Finalize Transaction for Signing** (Finalizar para assinatura).

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
4. Verifique as **assinaturas** (deve aparecer «1 of 1» ou o número correto no multisig).
5. Clique em **Broadcast Transaction** para enviar para a rede.

---

### Dicas Importantes de Segurança e Usabilidade

* **QR Animado (BBQR/UR)**: Sparrow e os signers DIY lidam bem com transações grandes dividindo em múltiplos QRs ou usando animação. Mantenha a câmera estável e boa iluminação.
* **Teste primeiro**: Faça com valores muito pequenos (Ex.: 0,0001 BTC) várias vezes até se sentir confortável.
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

## Comparativo: SeedSigner vs Krux (opcional)

> Lab detalhado: [`04-seedsigner-vs-krux-opcional.md`](../laboratorio/nivel-1-cofre/04-seedsigner-vs-krux-opcional.md)

**SeedSigner e Krux — alternativas DIY air-gapped para Sparrow no Tails**

Esses dois projetos são **excelentes opções open-source e baratas** para quem não quer comprar hardware wallet comercial (Coldcard, Jade etc.). Ambos permitem **assinatura air-gapped** (via QR) e integram com **Sparrow Wallet** no Tails.

### Comparação Rápida (2026)

| Aspecto | **SeedSigner** | **Krux** |
| --- | --- | --- |
| **Custo** | ~US$ 30–50 (Raspberry Pi Zero 1.3 + peças) | ~US$ 15–60 (Maix Amigo, M5StickV ou Yahboom) |
| **Dificuldade** | Média (precisa montar) | Fácil a Média (muitas placas "plug-and-play") |
| **Stateless** | Sim (não guarda seed permanentemente) | Sim (pode ser stateless ou usar SD criptografada) |
| **Air-Gapped** | QR codes (câmera + tela) | QR codes + SD card |
| **Integração Sparrow** | Excelente (PSBT via QR) | Excelente (PSBT via QR/SD) |
| **Vantagens** | Totalmente stateless, comunidade madura, barato | Mais opções de hardware, mais rápido em alguns casos, fácil de flash |
| **Desvantagens** | Montagem manual, Raspberry Pi específico | Hardware genérico (verificar supply chain) |
| **Melhor para** | Quem gosta de DIY completo e máxima stateless | Quem quer algo mais simples de comprar/pronto |

Ambos suportam **multisig**, BIP39, passphrase e export de xpub/zpub para carteira somente leitura no Sparrow.

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
 * No Sparrow: crie carteira multisig ou single-sig somente leitura (watch-only).
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
 * M5StickV (prefira revendedor listado no site Krux — evite marketplaces não verificados)
* **Instalação básica**:
 1. Baixe o Krux Installer ou firmware no GitHub (selfcustody.github.io/krux) — **verifique a release atual** no site oficial.
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
 4. No Tails + Sparrow: carteira watch-only + PSBT via QR.
 5. Use para transações sensíveis; mobile para valores pequenos.

**Dicas de Segurança (Importante!)**:

* Compre peças de fontes confiáveis (evite ataques na cadeia de entrega — supply chain).
* Verifique hashes e builds reproduzíveis.
* Sempre teste com pequenas quantias.
* Combine com multisig (Ex.: SeedSigner + outra seed em papel).
* Use Tails amnésico para Sparrow.

---

No próximo capítulo, criaremos a carteira fria somente leitura (watch-only) no Tails para enxergar o saldo sem expor a seed.
