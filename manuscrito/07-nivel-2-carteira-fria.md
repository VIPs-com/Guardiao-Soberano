# Capítulo 7 — Nível 2: A Carteira Fria

> "Enxergar sem tocar"

---

## Objetivo

Criar uma carteira **somente leitura** (*watching-only*) no Tails: o Sparrow monitora saldo e monta transações usando só a **xpub** (chave pública) — a seed **nunca** entra no computador. Fazer a primeira transação de teste (receber e enviar via PSBT).

**Tempo estimado:** 2–3 dias | **Dificuldade:** 3/5

**Pré-requisitos:** Nível 1 concluído.

---

### Passo 2.1 — Instalar Tails OS (primeiro ambiente)

- [ ] Em computador COM internet e Tor Browser:
  - Acessar tails.boum.org
  - Baixar a ISO do Tails
  - Baixar a assinatura OpenPGP (.sig)
  - Verificar: `gpg --verify tails*.img.sig tails*.img`

- [ ] Gravar em pendrive USB (8GB ou mais):
  - Usar balenaEtcher (gráfico) ou dd (terminal)
  - Este será seu "Tails Final"

- [ ] Boot pelo pendrive:
  - Reiniciar computador
  - Entrar na BIOS/UEFI (F2, F12, Del)
  - Selecionar boot pelo USB
  - Tails inicia

- [ ] Configurar Persistent Storage:
  - Applications → Tails → Persistent Storage
  - Marcar: Personal Data, GnuPG, Bitcoin Client, Additional Software
  - Criar senha forte (20+ caracteres, sem dados pessoais)
  - Anotar esta senha em Local Físico D (separado de tudo)

---

### Passo 2.2 — Baixar ferramentas no Tails

- [ ] Abrir Tor Browser (já está no Tails)
- [ ] Baixar Sparrow Wallet:
  - sparrowwallet.com
  - Baixar AppImage + assinatura .asc
  - Importar chave PGP do Craig Raw
  - Verificar: `gpg --verify sparrow*.AppImage.asc sparrow*.AppImage`
  - Tornar executável: `chmod +x sparrow*.AppImage`

- [ ] Alternativa: use scurl-download (wrapper seguro do Tails)
  - `scurl-download https://sparrowwallet.com/downloads/sparrow*.AppImage`

- [ ] Instalar KeePassXC (já vem no Tails):
  - Applications → Accessories → KeePassXC
  - Criar banco de dados cifrado (AES-256)
  - Guardar aqui: PINs, endereços .onion, metadados
  - NUNCA guardar a seed aqui

---

### Passo 2.3 — Exportar xpub do dispositivo air-gapped

- [ ] No seu dispositivo (Coldcard/Krux/SeedSigner/Jade):
  - Opção Export Wallet → Sparrow Wallet
  - Arquivo .json gerado no MicroSD ou xpub via QR

- [ ] Copiar para o **Tails** (pendrive, SD ou QR — nunca abrir no Windows/macOS habitual)
- [ ] Pode importar no Sparrow **com Tor ativo** — o arquivo traz só xpub, sem seed

- [ ] O arquivo contém APENAS a chave PÚBLICA (xpub)
- [ ] Não contém seed, não contém chave privada
- [ ] Mesmo assim: trate o .json como dado sensível (privacidade de saldo)

---

### Passo 2.4 — Criar carteira watching-only

- [ ] Sparrow → Arquivo (File) → Nova carteira (New Wallet)
- [ ] Nome: "Minha_Carteira_Fria"
- [ ] Importar arquivo (Import File) → selecionar o .json
- [ ] Verificar:
  - Aba "Signing" (Assinatura) **vazia** — sem chave privada
  - Aba "Addresses" (Endereços) mostra endereços
  - Aba "Transactions" vazia (ainda)
- [ ] Carteira **somente leitura** pronta para monitorar e criar transações

---

### Passo 2.5 — Receber primeiro BTC (teste)

- [ ] Sparrow → Receive → copiar primeiro endereço
- [ ] Enviar PEQUENO valor de teste:
  - ~R$ 50–100 em BTC
  - **Recomendado:** RoboSats (Cap. 5, Passo 0.7) ou conhecido
  - RetoSwap: avançado — Nível 5
  - NÃO use exchange KYC para este teste
- [ ] Aguardar 1 confirmação (~10 minutos)
- [ ] Sparrow mostra transação na aba Transactions
- [ ] PRIMEIRA TRANSAÇÃO AUTO-CUSTODIADA!

---

### Passo 2.6 — Testar envio (ciclo PSBT completo)

- [ ] Sparrow → Enviar (Send) → criar transação de 0,00005 BTC
  - Enviar para outro endereço seu (ou de um amigo)
  - Exportar PSBT para assinatura offline:
    - **MicroSD:** salvar PSBT no cartão → dispositivo → Ready to Sign
    - **QR:** Show QR no Sparrow → escanear no SeedSigner/Krux (Cap. 6 / lab N1/03)

- [ ] No dispositivo air-gapped:
  - Conferir endereço destino, valor e taxa NA TELA DO DISPOSITIVO
  - Se estiver correto, confirmar e assinar

- [ ] Devolver PSBT assinada ao Sparrow (Load Transaction ou Scan QR)
  - Broadcast Transaction (transmitir via Tor)

- [ ] Aguardar confirmação
- [ ] CICLO COMPLETO: criar → assinar offline → transmitir

---

### Verificação do Nível 2

**Obrigatório antes de operar com valor real:**

- [ ] Carteira watching-only mostra saldo corretamente
- [ ] PSBT criado, assinado no dispositivo offline, transmitido
- [ ] Sei que a seed NUNCA tocou o computador

**Ambiente configurado:**

- [ ] Tails instalado com Persistent Storage
- [ ] Sparrow verificado (PGP) e funcional
- [ ] KeePassXC com banco cifrado (metadados — sem seed)
- [ ] Entendo: computador cria, dispositivo assina, computador transmite

---

## Conquista: "A Carteira Fria"

> Meu computador vê meus Bitcoins mas nunca toca minhas chaves. A ponte PSBT conecta dois mundos sem expor o segredo. Sou guardião, não portador.

---

## Leitura opcional — após Nível 2

As seções abaixo aprofundam KeePassXC, Electrum (alternativa ao Sparrow) e montagem SeedSigner. **Não são obrigatórias** para concluir o Nível 2.

---

## Ferramentas no Tails (aprofundamento)

Os passos 2.1–2.2 introduzem Tails, Sparrow e KeePassXC. As seções abaixo detalham o cofre KeePassXC e o Electrum com stream isolation — **específicos do ambiente Tails** (Nível 2). No Nível 3 você migrará para Whonix; lá o KeePassXC vem pré-instalado na Workstation (Passo 3.3).

## Ferramenta Complementar: KeePassXC no Ambiente Persistente

**KEEPASSXC NO TAILS: O COFRE DENTRO DO COFRE**

> _"A persistência guarda os arquivos. O KeePassXC guarda os segredos. E você guarda a chave na mente."_

Você já tem a persistência LUKS no pendrive — uma fortaleza criptografada. Colocar **seeds** ou senhas em texto puro na persistência ainda é arriscado. O KeePassXC cria **uma segunda camada** para **metadados operacionais** (PINs, .onion, notas de conta) — **nunca** a seed BIP39 Bitcoin (Lei 4; Passo 2.2).

Aqui está o método correto para instalar, configurar e usar no Tails.

---

## Objetivo

Instalar o KeePassXC de forma persistente e criar um banco cifrado para **PINs, endereços .onion, metadados de operações** (conta RetoSwap no N5, restore height Monero como **número**, não seed) e senhas GPG de backup — **sem** armazenar seed BIP39 Bitcoin.

---

## Mão na Massa

### Baixar o AppImage na persistência

O Tails é amnésico. Se você instalar o KeePassXC pelo Synaptic, perderá na reinicialização. Melhor usar o **AppImage** oficial, armazenado na partição persistente.

```
mkdir -p /home/amnesia/Persistent/Apps

# Baixe AppImage + .sig (keepassxc.org — verifique versão jun/2026)
KP_VER=2.7.9
KP_ORG="keepassxreboot/keepassxc/releases/download"
KP_BASE="https://github.com/${KP_ORG}/${KP_VER}"
KP_FILE="KeePassXC-${KP_VER}-x86_64"
torsocks wget -P /home/amnesia/Persistent/Apps/ \
  "${KP_BASE}/${KP_FILE}.AppImage" \
  "${KP_BASE}/${KP_FILE}.AppImage.sig"
```

> Verifique assinatura GPG (Apêndice D). Confira se há release mais recente que v2.7.9 antes de instalar.

### Tornar executável e criar um lançador

```
chmod +x /home/amnesia/Persistent/Apps/KeePassXC-*.AppImage
```

Crie um script para iniciar facilmente:

```
echo '#!/bin/bash
/home/amnesia/Persistent/Apps/KeePassXC-*.AppImage &
' > /home/amnesia/Persistent/start-keepass.sh

chmod +x /home/amnesia/Persistent/start-keepass.sh
```

Agora, após cada boot, você executa `./Persistent/start-keepass.sh` e o programa abre.

### Criar o banco de dados (o cofre)

1. Abra o KeePassXC.
2. Clique em **"Create new database"**.
3. Nome: `fortaleza_cofre` (exemplo).
4. Senha: **use uma frase longa (7+ palavras diceware)**. Ela deve ser diferente da senha da persistência Tails e diferente da sua senha GPG do backup.
5. (Opcional, mas fortíssimo) Adicione um **Key File**: um arquivo que, junto com a senha, desbloqueia o cofre. Você pode guardar esse key file em um pendrive separado ou, melhor para o nômade, **memorizar o conteúdo dele** (um texto curto que você digita em um arquivo no próprio Tails toda vez que for abrir o cofre — mais complexo, mas inviabiliza acesso sem esse texto). Para começar, use apenas uma senha robusta.
6. Salve o arquivo `.kdbx` na persistência:
 
 ```
 /home/amnesia/Persistent/fortaleza_cofre.kdbx
 ```

### Configurações de segurança essenciais

No menu **Tools → Settings**, ajuste:

* **Security:**
 * _Clear clipboard after_: 30 segundos (padrão, mas reduza para 20 se quiser).
 * _Lock database after inactivity of_: 2 minutos.
 * _Automatically lock database when minimized_: LIGADO.
* **General:**
 * _Start minimized_ e _Show tray icon_ (se disponível) podem ajudar.

### Estruturando o cofre (metadados — sem seeds)

Crie grupos (pastas) dentro do KeePassXC:

| Grupo | Conteúdo |
| --- | --- |
| **Bitcoin** | Fingerprint Sparrow, label da wallet, **nunca** as 24 palavras |
| **Monero (N5+)** | Restore height, endereços públicos — seed XMR só em metal |
| **RetoSwap (N5+)** | ID da conta, notas de pares — backup `.zip` separado |
| **Senhas Web** | Logins .onion, bridges Tor |
| **Backup** | Senha do GPG de backup, local do offsite |

**Exemplo: entrada RoboSats / metadados**

1. Crie uma entrada: «RoboSats — trades».
2. No campo **Password**, use senha gerada ou token da sessão (não seed).
3. Em **Notes**: data, valor, método Pix, txid Bitcoin.
4. **Nunca** cole seed BIP39 ou seed Monero no KeePassXC.

> **AVISO — Lei 4:** seed Bitcoin = metal + dispositivo air-gapped. KeePassXC guarda **operação**, não custódia.

### Usando no dia a dia

* Ao iniciar o Tails, abra o KeePassXC pelo script.
* Desbloqueie o cofre com a frase-senha.
* Quando precisar de senha ou nota, abra a entrada, copie (Ctrl+C) e cole no local. O clipboard será limpo automaticamente.
* Após usar, **trave o cofre** (Ctrl+L ou clique no cadeado). Não mantenha aberto.

---

## Dicas de Novato

* **Nunca armazene a senha do KeePassXC no próprio KeePassXC** (óbvio, mas acontece).
* **A senha do cofre deve ser memorizada.** Se precisar de backup da senha, use local separado (nunca junto ao pendrive Tails).
* **Use o gerador de senhas** do KeePassXC para criar senhas aleatórias para contas web e serviços.
* **Não use a extensão de navegador** (KeePassXC-Browser) no Tor Browser. O Tails isola o navegador por segurança; a integração pode vazar metadados. Digite as senhas manualmente.
* **Faça backup do arquivo** `.kdbx` junto com seu backup 3-2-1 (ele já está incluído se você seguiu o método com tar/gpg). O arquivo é pequeno (poucos KB).

---

## Teste de Recuperação

1. No mesmo Tails ou em um Tails limpo com persistência restaurada, execute o KeePassXC.
2. Abra o arquivo `/home/amnesia/Persistent/fortaleza_cofre.kdbx`.
3. Digite a senha do cofre. Deve abrir normalmente.
4. Verifique se entradas e senhas de teste estão lá (não seeds).

**Simule o desastre:** Apague o arquivo `.kdbx` da persistência (faça isso apenas em um Tails de testes). Restaure do backup GPG. Tudo deve voltar.

---

## Perigos Reais

* **Esquecer a senha do KeePassXC:** sem ela, o conteúdo do `.kdbx` é **irrecuperável**. Não há "esqueci minha senha". É tão seguro quanto sua memória.
* **Senha fraca no KeePassXC:** se sua persistência for descriptografada, um ataque de força bruta ao `.kdbx` pode quebrar senhas curtas. Use frases longas.
* **Keylogger no host:** se você digitar a senha do cofre em um computador comprometido, ela pode ser capturada. Use o teclado virtual do Tails (Onboard) em máquinas suspeitas.
* **Arquivo** `.kdbx` **corrompido:** raríssimo, mas possível. O backup resolve.

---

O KeePassXC é o cérebro da sua fortaleza. Com ele, mesmo que a muralha externa (LUKS) caia, seus segredos ainda dormem atrás de outra tranca. Duas senhas, duas camadas, uma só mente soberana.

> _"O verdadeiro cofre não é o que se carrega, é o que se sabe."_

---

## Alternativa: Electrum com Stream Isolation

> _Alternativa ao Sparrow — mesma ideia watch-only + PSBT. Trilha principal: Passos 2.1–2.6._

A trilha deste livro usa **Sparrow** no Tails. O **Electrum** é opção madura para quem já conhece a interface ou quer servidores `.onion` dedicados. **Feather** (Monero) e **RetoSwap** entram nos Níveis 5–6 — não são pré-requisito aqui.

Instale o Electrum na persistência, conecte via Tor e use **carteira somente leitura** com xpub do dispositivo air-gapped (Cap. 6) — **não** gere seed principal no Tails (Lei 1).

---

## Objetivo

Instalar o Electrum no Tails (persistência + Tor) e configurar carteira **watching-only** importando xpub — ou PSBT com dispositivo air-gapped. Integração opcional com backup GPG da persistência.

---

## Pré‑requisitos

* Tails iniciado com **persistência desbloqueada** e a opção _Personal Data_ ativa (para acessarmos `/home/amnesia/Persistent/`).
* Pasta de aplicativos pronta: `/home/amnesia/Persistent/Apps/` (se não existir, crie com `mkdir -p`).
* Conexão Tor funcional (o Tails já faz isso).

---

## Passo a passo

### Baixar e verificar o Electrum (AppImage)

O Electrum distribui um AppImage oficial. Vamos baixá‑lo com `torsocks` e verificar a assinatura.

```bash
VERSION=4.5.5
BASE="https://download.electrum.org/${VERSION}"

torsocks wget -P /home/amnesia/Persistent/Apps/ \
  "${BASE}/electrum-${VERSION}-x86_64.AppImage" \
  "${BASE}/electrum-${VERSION}-x86_64.AppImage.asc"
```

**Verifique a assinatura GPG** — fingerprint ThomasV no site [electrum.org](https://electrum.org) e **Apêndice D** (nunca use placeholder):

```bash
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys <FINGERPRINT-ELECTRUM-APD-D>
gpg --verify \
  /home/amnesia/Persistent/Apps/electrum-$VERSION-x86_64.AppImage.asc \
  /home/amnesia/Persistent/Apps/electrum-$VERSION-x86_64.AppImage
```

Se a verificação passar, o binário é confiável. Torne‑o executável:

```bash
chmod +x /home/amnesia/Persistent/Apps/electrum-$VERSION-x86_64.AppImage
```

---

### Criar o lançador rápido

Crie um script na persistência para abrir o Electrum com um clique:

```bash
cat > /home/amnesia/Persistent/start-electrum.sh << 'EOF'
/home/amnesia/Persistent/Apps/electrum-*-x86_64.AppImage \
  --datadir /home/amnesia/Persistent/electrum-data "$@"
EOF
chmod +x /home/amnesia/Persistent/start-electrum.sh
```

A opção `--datadir` força o Electrum a guardar todas as carteiras, configurações e logs na pasta persistente. Sem isso, ele usaria `~/.electrum` (tmpfs, volátil).

---

### Primeiro lançamento e configuração Tor

1. Execute o script:

```bash
/home/amnesia/Persistent/start-electrum.sh
```

2. Na primeira tela, escolha o modo **Standard wallet** (ou outro, conforme sua necessidade).

#### Configurar a rede

Antes de criar ou conectar a carteira:

- Vá em **Ferramentas → Rede** (*Tools → Network*)
- Guia **Proxy** — marque **Usar proxy** e preencha:
  - Tipo: `SOCKS5`
  - Host: `127.0.0.1`
  - Porta: `9050` (ou `9150` com Tor Browser; no Tails o proxy do sistema é `9050`)
- Guia **Servidores** — mantenha *Selecionar servidor automaticamente*
  - Depois, adicione servidores Tor `.onion` para maior privacidade

> **Dica cypherpunk:** Prefira servidores onion. Você pode encontrá-los em [electrum.org](https://electrum.org) ou usar a lista pública. Adicione-os manualmente e desabilite servidores em plaintext.

#### Privacidade das transações

- Vá em **Ferramentas → Preferências** → aba **Transações**
- Marque **Usar múltiplas mudanças** (dificulta análise)
- Marque **Desabilitar endereços com prefixo público** (se aparecer)
- Ajuste as taxas manualmente se quiser evitar rastreio por valores

---

### Carteira Bitcoin — watch-only (recomendado)

* **Importar xpub** exportada do dispositivo air-gapped (Cap. 6) — mesma seed, mesmos endereços que Sparrow.
* **Não** use «Standard wallet» com nova seed de 12 palavras no Tails para patrimônio principal (**Lei 1**).
* **Carteira de exercício:** se precisar testar Electrum isolado, use **testnet** ou valor mínimo — seed em metal, não na persistência como único backup.

A carteira watch-only fica em:

```
/home/amnesia/Persistent/electrum-data/wallets/sua_carteira
```

---

## Persistência automática: tudo salvo na pasta certa

Com `--datadir`, o Electrum grava diretamente na persistência. Você não precisa criar links simbólicos. A estrutura fica assim:

```
/home/amnesia/Persistent/electrum-data/
├── config
├── wallets/
│ └── fortaleza_btc
│ ├── wallet
│ └── ... 
├── logs/
└── …
```

Ao reiniciar o Tails, execute o script e tudo estará como você deixou.

---

## Teste de sobrevivência

1. Importe xpub / confirme saldo watch-only.
2. Feche o Electrum, reinicie o Tails.
3. Execute o script de inicialização.
4. Verifique se saldo e transações reaparecem (sem digitar seed no PC).

---

## Integração com o backup 3-2-1

O seu ritual de backup já incluía o `.electrum` (se você seguiu o módulo anterior). Como agora a pasta é `Persistent/electrum-data`, ajuste o comando do backup:

```bash
tar czf - \
  /home/amnesia/.config/feather \
  /home/amnesia/Persistent/electrum-data \
  /home/amnesia/Persistent/fortaleza_cofre.kdbx \
  /home/amnesia/Persistent/reto_swap_backup_amnesia.zip \
  | gpg --symmetric --cipher-algo AES256 \
    --output /media/backup/fortaleza_backup_$(date +%Y%m%d).tar.gz.gpg
```

**Lembre‑se:** Custódia Bitcoin = dispositivo air-gapped + metal (Cap. 5–6). Backup GPG da persistência cobre **metadados**, não substitui seed.

---

## Dicas de segurança e privacidade

* **Use servidores onion:** Na aba Rede, adicione manualmente endereços `.onion` confiáveis e desmarque os servidores clearnet. Exemplo:
 
 ```
 electrumx6k3k4xyz.onion 50002 s
 ```
* **Não misture carteiras de identidades diferentes** na mesma sessão Tails (Ex.: carteira pessoal vs. carteira anônima).
* **A senha da carteira** (que protege o arquivo wallet) é adicional. Se você a esquecer, ainda pode restaurar com a seed. Mas se o arquivo wallet for roubado e a senha for fraca, o ladrão pode gastar seus fundos. Use senha forte.
* **Nunca exporte seed** pelo Electrum em ambiente online. Visualização de seed = dispositivo air-gapped ou metal.
* **Feche o Electrum completamente** antes de fazer backup manual ou desligar.

---

## Perigo: confundir ferramentas

Sparrow/Electrum (Bitcoin, xpub) ≠ Feather (Monero, Nível 5+) ≠ RetoSwap (N5). Rotule entradas no KeePassXC e papéis de backup.

---

## Convivência com outras ferramentas (níveis futuros)

No **Nível 5** você usará Feather + RetoSwap (Monero). O Electrum/Sparrow (Bitcoin) roda em paralelo no Tails quando a RAM permitir — Tor compartilhado pelo sistema.

---

Com o Electrum como alternativa, você reforça a mesma arquitetura: **Tails observa, dispositivo assina.**

---

## Aprofundamento: SeedSigner, SeedQR e PSBT via QR

> **Nota:** Material expandido do **Capítulo 6** e lab `laboratorio/nivel-1-cofre/03-psbt-via-qr.md`. Leitura opcional para montagem DIY detalhada.

**Filosofia SeedSigner:** peças genéricas compradas separadamente, de múltiplos fornecedores, sem identidade ligada a "hardware wallet". Custo total abaixo de €50. Código auditável por qualquer pessoa. Zero confiança no fabricante.

### Componentes obrigatórios

| Peça | Especificação | Preço (aprox.) |
| --- | --- | --- |
| **Pi Zero v1.3** | 512 MB, sem rádio, GPIO | €12–18 |
| **Waveshare 1,3" LCD HAT** | 240×240 px, joystick + 3 botões, GPIO | €12–15 |
| **Câmera OV5647** | 5 MP, cabo ribbon 160 mm, remover película | €8–12 |
| **MicroSD** | 8 GB+, Classe 10 (só para firmware) | €5 |
| **Enclosure 3D** | Orange Pill ou Open Pill (STL no GitHub) | ~€2 |
| **Cabo microUSB** | Somente alimentação — nunca USB de dados | €3 |

> **AVISO — Pi Zero W vs v1.3:** o Zero W/2W tem rádio integrado. Preferido: v1.3 (sem rádio). Se usar W, desative WiFi/Bluetooth em `config.txt`.

### Montagem (sem solda, com headers)

1. **Câmera no CSI:** abra a aba do conector, insira o ribbon (contatos para baixo), feche sem forçar.
2. **Display no GPIO:** alinhe pino 1 e pressione uniformemente.
3. **Teste antes do case:** MicroSD com firmware, energia, ~45 s até o logo. Teste joystick, botões e câmera:

```bash
# SeedSigner: Menu → Ferramentas → Testar câmera
# Aponte para um QR genérico na tela — deve ler
```

4. **Montar no enclosure** (Orange Pill ou Open Pill).

O SeedSigner é **stateless**: ao desligar, a seed some da memória. Carregue, assine, desligue.

### Firmware — download e verificação

```bash
# github.com/SeedSigner/seedsigner/releases
# Pi Zero v1.3: seedsigner_os.0.8.6.pi0.img (+ .sha256 + .sig)
sha256sum -c seedsigner_os.0.8.6.pi0.img.sha256
gpg --verify seedsigner_os.0.8.6.pi0.img.sig \
  seedsigner_os.0.8.6.pi0.img
# Parar se SHA256 ou GPG falhar
```

Grave com Balena Etcher ou Raspberry Pi Imager (verificação automática após flash).

**Primeira inicialização (Mainnet):**

- Configurações → Avançado → Rede Bitcoin → Mainnet
- Unidades → BTC ou sats
- Coordenador → Sparrow
- Modo de assinatura → Auto-finalize: **OFF**

Pratique em **testnet** antes de mainnet.

**Atualização:** sem OTA — baixe novo `.img`, verifique GPG/SHA256, reflash. Mantenha dois MicroSDs (estável + teste).

### SeedQR — backup em metal

Cada palavra BIP39 vira número (1–2048). O SeedQR compacta isso em QR para gravar em metal.

> **AVISO:** nunca aponte câmera conectada à internet para o SeedQR. É sua chave em formato QR.

**Gerar seed (entropia da câmera ou dados):**

```bash
# SeedSigner → Seeds → Generate a seed
# → Image Capture (50+ fotos) OU Dice rolls OU ambos
# Anotar imediatamente em metal — não desligar antes do backup
```

**Exportar SeedQR:**

```bash
# Seeds → [sua seed] → Backup Seed → Export SeedQR
# Template: github.com/SeedSigner/seedsigner (seedqr-templates)
# Transferir para aço/titanium — verificar escaneando de volta
```

**Carregar seed no uso diário:** Scan SeedQR (rápido) ou digitar palavras no joystick (mais lento, sem expor QR).

### xpub → Sparrow (carteira somente leitura)

1. SeedSigner: Seeds → Export Xpub → QR animado (UR2.0)
2. Sparrow: Nova carteira → Hardware air-gapped → SeedSigner → Scan QR
3. Sparrow fica **watching-only** — sem chave privada

**Verificar endereço de recebimento:** Sparrow → Receive → Verify Address → QR → SeedSigner → Tools → Verify address. Só use se o SeedSigner confirmar.

### Fluxo PSBT via QR (6 passos)

| # | Onde | Ação |
| --- | --- | --- |
| 1 | Sparrow | Enviar → criar transação → Finalizar → **Mostrar QR** |
| 2 | Sparrow | QR animado UR2.0 (PSBT) — manter janela aberta |
| 3 | SeedSigner | Scan → apontar câmera para o Sparrow |
| 4 | SeedSigner | Revisar destino, valor, taxa, troco — confirmar na tela |
| 5 | SeedSigner | Assinar → exibir QR assinado |
| 6 | Sparrow | Scan QR de volta → Broadcast via Tor |

> Verifique o **endereço completo** na tela do SeedSigner — não só os primeiros dígitos. Chaves privadas nunca saem do dispositivo; só a assinatura volta ao Sparrow.

**Sparrow watching-only (SeedSigner desligado):** ver saldo, receber, montar PSBT — assinar exige o SeedSigner.

---

No próximo capítulo, construiremos a fortaleza digital com Whonix e nó próprio.
