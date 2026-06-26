# Capítulo 7 — Nível 2: A Carteira Fria

> "Enxergar sem tocar"

---

## Objetivo

Criar uma carteira **somente leitura** (*watching-only*) no Tails: o Sparrow monitora saldo e monta transações usando só a **xpub** (chave pública) — a seed **nunca** entra no computador. Fazer a primeira transação de teste (receber e enviar via PSBT).

**Tempo estimado:** 2–3 dias | **Dificuldade:** ★★★☆☆

**Pré-requisitos:** Nível 1 concluído.

---

### Passo 2.1 — Instalar Tails OS (primeiro ambiente)

```
□ Em computador COM internet e Tor Browser:
 - Acessar tails.boum.org
 - Baixar a ISO do Tails
 - Baixar a assinatura OpenPGP (.sig)
 - Verificar: gpg --verify tails*.img.sig tails*.img

□ Gravar em pendrive USB (8GB ou mais):
 - Usar balenaEtcher (gráfico) ou dd (terminal)
 - Este será seu "Tails Final"

□ Boot pelo pendrive:
 - Reiniciar computador
 - Entrar na BIOS/UEFI (F2, F12, Del)
 - Selecionar boot pelo USB
 - Tails inicia

□ Configurar Persistent Storage:
 - Applications → Tails → Persistent Storage
 - Marcar: Personal Data, GnuPG, Bitcoin Client, Additional Software
 - Criar senha forte (20+ caracteres, sem dados pessoais)
 - Anotar esta senha em Local Físico D (separado de tudo)
```

---

### Passo 2.2 — Baixar ferramentas no Tails

```
□ Abrir Tor Browser (já está no Tails)
□ Baixar Sparrow Wallet:
 - sparrowwallet.com
 - Baixar AppImage + assinatura .asc
 - Importar chave PGP do Craig Raw
 - Verificar: gpg --verify sparrow*.AppImage.asc sparrow*.AppImage
 - Tornar executável: chmod +x sparrow*.AppImage

□ Alternativa: use scurl-download (wrapper seguro do Tails)
 - scurl-download https://sparrowwallet.com/downloads/sparrow*.AppImage

□ Instalar KeePassXC (já vem no Tails):
 - Applications → Accessories → KeePassXC
 - Criar banco de dados cifrado (AES-256)
 - Guardar aqui: PINs, endereços .onion, metadados
 - NUNCA guardar a seed aqui
```

---

### Passo 2.3 — Exportar xpub do dispositivo air-gapped

```
□ No seu dispositivo (Coldcard/Krux/SeedSigner/Jade):
 - Opção Export Wallet → Sparrow Wallet
 - Arquivo .json gerado no MicroSD ou xpub via QR

□ Copiar para o **Tails** (pendrive, SD ou QR — nunca abrir no Windows/macOS habitual)
□ Pode importar no Sparrow **com Tor ativo** — o arquivo traz só xpub, sem seed

□ O arquivo contém APENAS a chave PÚBLICA (xpub)
□ Não contém seed, não contém chave privada
□ Mesmo assim: trate o .json como dado sensível (privacidade de saldo)
```

---

### Passo 2.4 — Criar carteira watching-only

```
□ Sparrow → File → New Wallet
□ Nome: "Minha_Carteira_Fria"
□ Import File → selecionar arquivo .json
□ Verificar:
 - Aba "Signing" deve estar VAZIA (sem chave privada)
 - Aba "Addresses" mostra endereços
 - Aba "Transactions" vazia (ainda)
□ Sua carteira está PRONTA para monitorar e criar transações
```

---

### Passo 2.5 — Receber primeiro BTC (teste)

```
□ Sparrow → Receive → copiar primeiro endereço
□ Enviar PEQUENO valor de teste:
 - ~R$ 50–100 em BTC
 - **Recomendado:** RoboSats (Cap. 5, Passo 0.7) ou conhecido
 - RetoSwap: avançado — Nível 5
 - NÃO use exchange KYC para este teste
□ Aguardar 1 confirmação (~10 minutos)
□ Sparrow mostra transação na aba Transactions
□ PRIMEIRA TRANSAÇÃO AUTO-CUSTODIADA!
```

---

### Passo 2.6 — Testar envio (ciclo PSBT completo)

```
□ Sparrow → Send → criar transação de 0,00005 BTC
 - Enviar para outro endereço seu (ou de amigo)
 - Exportar PSBT para assinatura offline:
   • **MicroSD:** salvar PSBT no cartão → dispositivo → Ready to Sign
   • **QR:** Show QR no Sparrow → escanear no SeedSigner/Krux (Cap. 6 / lab N1/03)

□ No dispositivo air-gapped:
 - Conferir endereço destino, valor e taxa NA TELA DO DISPOSITIVO
 - Se estiver correto, confirmar e assinar

□ Devolver PSBT assinada ao Sparrow (Load Transaction ou Scan QR)
 - Broadcast Transaction (transmitir via Tor)

□ Aguardar confirmação
□ CICLO COMPLETO: criar → assinar offline → transmitir
```

---

### Verificação do Nível 2

```
□ Tails instalado e funcionando com Persistent Storage
□ Sparrow Wallet verificado (PGP) e funcional
□ KeePassXC configurado com banco cifrado
□ Carteira watching-only mostra saldo corretamente
□ PSBT criado, assinado no dispositivo offline, transmitido
□ Sei que a seed NUNCA tocou o computador
□ Entendo: computador cria, dispositivo assina, computador transmite
```

---

## 🏅 Conquista: "A Carteira Fria"

> Meu computador vê meus Bitcoins mas nunca toca minhas chaves. A ponte PSBT conecta dois mundos sem expor o segredo. Sou guardião, não portador.

---

## 📎 Leitura opcional — após Nível 2

As seções abaixo aprofundam KeePassXC, Electrum (alternativa ao Sparrow) e montagem SeedSigner. **Não são obrigatórias** para concluir o Nível 2.

---

## Ferramentas no Tails (aprofundamento)

Os passos 2.1–2.2 introduzem Tails, Sparrow e KeePassXC. As seções abaixo detalham o cofre KeePassXC e o Electrum com stream isolation — **específicos do ambiente Tails** (Nível 2). No Nível 3 você migrará para Whonix; lá o KeePassXC vem pré-instalado na Workstation (Passo 3.3).

## Ferramenta Complementar: KeePassXC no Ambiente Persistente

🔐 KEEPASSXC NO TAILS: O COFRE DENTRO DO COFRE

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

# Baixe AppImage + .sig da release atual em keepassxc.org (verifique versão jun/2026)
torsocks wget -P /home/amnesia/Persistent/Apps/ \
 https://github.com/keepassxreboot/keepassxc/releases/download/v2.7.9/KeePassXC-2.7.9-x86_64.AppImage \
 https://github.com/keepassxreboot/keepassxc/releases/download/v2.7.9/KeePassXC-2.7.9-x86_64.AppImage.sig
```

> 🔍 Verifique assinatura GPG (Apêndice D). Confira se há release mais recente que v2.7.9 antes de instalar.

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

> ⚠️ **Lei 4:** seed Bitcoin = metal + dispositivo air-gapped. KeePassXC guarda **operação**, não custódia.

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
* **Faça backup do arquivo** `**.kdbx**` junto com seu backup 3-2-1 (ele já está incluído se você seguiu o método com tar/gpg). O arquivo é pequeno (poucos KB).

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
* **Arquivo** `**.kdbx**` **corrompido:** raríssimo, mas possível. O backup resolve.

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

```
VERSION=4.5.5

torsocks wget -P /home/amnesia/Persistent/Apps/ \
 https://download.electrum.org/$VERSION/electrum-$VERSION-x86_64.AppImage \
 https://download.electrum.org/$VERSION/electrum-$VERSION-x86_64.AppImage.asc
```

**Verifique a assinatura GPG** — fingerprint ThomasV no site [electrum.org](https://electrum.org) e **Apêndice D** (nunca use placeholder):

```
gpg --keyserver hkps://keys.openpgp.org --recv-keys <FINGERPRINT-ELECTRUM-APD-D>
gpg --verify /home/amnesia/Persistent/Apps/electrum-$VERSION-x86_64.AppImage.asc \
 /home/amnesia/Persistent/Apps/electrum-$VERSION-x86_64.AppImage
```

Se a verificação passar, o binário é confiável. Torne‑o executável:

```
chmod +x /home/amnesia/Persistent/Apps/electrum-$VERSION-x86_64.AppImage
```

---

### Criar o lançador rápido

Crie um script na persistência para abrir o Electrum com um clique:

```
cat > /home/amnesia/Persistent/start-electrum.sh << 'EOF'
/home/amnesia/Persistent/Apps/electrum-*-x86_64.AppImage --datadir /home/amnesia/Persistent/electrum-data "$@"
EOF
chmod +x /home/amnesia/Persistent/start-electrum.sh
```

A opção `--datadir` força o Electrum a guardar todas as carteiras, configurações e logs na pasta persistente. Sem isso, ele usaria `~/.electrum` (tmpfs, volátil).

---

### Primeiro lançamento e configuração Tor

1. Execute o script:
 
 ```
 /home/amnesia/Persistent/start-electrum.sh
 ```
2. Na primeira tela, escolha o modo: **"Standard wallet"** (ou outro, conforme sua necessidade).
3. **Configurar a rede** antes de criar/conectar a carteira:
 
 * Vá em **Ferramentas → Rede** (ou **Tools → Network**).
 * Guia **Proxy**: Marque **"Usar proxy"** e preencha:
 * Tipo: `SOCKS5`
 * Host: `127.0.0.1`
 * Porta: `9050` (ou `9150` se estiver usando o Tor Browser; no Tails o proxy do sistema é `9050`)
 * Guia **Servidores**: Mantenha "Selecionar servidor automaticamente". Você pode, mais tarde, adicionar servidores Tor `.onion` para maior privacidade.
 
 > 💡 **Dica cypherpunk:** Prefira servidores onion. Você pode encontrá‑los em [electrum.org](https://electrum.org) ou usar a lista pública. Adicione‑os manualmente e desabilite servidores em plaintext.
4. **Aumente a privacidade da carteira**:
 * Vá em **Ferramentas → Preferências** → Aba **Transações**:
 * Marque **"Usar múltiplas mudanças"** (dificulta análise).
 * Marque **"Desabilitar endereços com prefixo público"** (se aparecer).
 * Ajuste as taxas manualmente se quiser evitar rastreio por valores.

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

```
tar czf - \
 /home/amnesia/.config/feather \
 /home/amnesia/Persistent/electrum-data \
 /home/amnesia/Persistent/fortaleza_cofre.kdbx \
 /home/amnesia/Persistent/reto_swap_backup_amnesia.zip \
| gpg --symmetric --cipher-algo AES256 --output /media/backup/fortaleza_backup_$(date +%Y%m%d).tar.gz.gpg
```

**Lembre‑se:** Custódia Bitcoin = dispositivo air-gapped + metal (Cap. 5–6). Backup GPG da persistência cobre **metadados**, não substitui seed.

---

## Dicas de segurança e privacidade

* **Use servidores onion:** Na aba Rede, adicione manualmente endereços `.onion` confiáveis e desmarque os servidores clearnet. Exemplo:
 
 ```
 electrumx6k3k4xyz.onion 50002 s
 ```
* **Não misture carteiras de identidades diferentes** na mesma sessão Tails (ex: carteira pessoal vs. carteira anônima).
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

> **Nota:** Material expandido do **Capítulo 6** e lab [`N1/03-psbt-via-qr.md`](../laboratorio/nivel-1-cofre/03-psbt-via-qr.md). Leitura opcional para montagem DIY detalhada.

**Filosofia SeedSigner:** peças genéricas compradas separadamente, de múltiplos fornecedores, sem identidade ligada a "hardware wallet". Custo total abaixo de €50. Código auditável por qualquer pessoa. Zero confiança no fabricante.

### Componentes obrigatórios

🍓

Raspberry Pi Zero v1.3

1GHz CPU · 512MB RAM 
Sem WiFi/Bluetooth 
v1.3 preferido — sem rádio 
Com headers GPIO soldados

~€12–18

📺

Waveshare 1.3" LCD HAT

240×240 pixels (obrigatório) 
Joystick + 3 botões embutidos 
Conecta direto no GPIO 
NÃO comprar versão diferente

~€12–15

📷

Câmera OV5647 (Pi Zero)

5MP · OV5647 sensor 
Cabo ribbon 160mm dourado 
HBV-Raspberry-160FPC 
Remover película antes de usar

~€8–12

💾

MicroSD Card

8GB+ · Classe 10 
Para flashear o firmware 
Não precisa pré-formatar 
Balena Etcher grava direto

~€5

📦

Enclosure 3D (Orange Pill)

Imprimir em FDM (~2h) 
Ou Open Pill (mais simples) 
STL disponível no GitHub 
Sem soldagem necessária

~€2 filamento

🔌

Cabo microUSB (power only)

Para alimentar o Pi Zero 
USB DATA nunca conectado 
Power bank ou carregador 
Porta de dados fica livre

~€3

**⚠ Pi Zero W vs v1.3:** o Zero W e 2W têm WiFi e Bluetooth integrados. São aceitáveis se desativar o rádio (editar config.txt), mas o v1.3 é o preferido pela comunidade — sem rádio por design, elimina o risco na raiz. Se só encontrar o W, desativar o WiFi é suficiente.

### Montagem (sem solda se comprar "with headers")

1

Conectar câmera ao CSI port do Pi Zero

Abrir o conector CSI (aba plástica). Inserir o cabo ribbon com contatos dourados virados para baixo. Fechar a aba. O cabo deve encaixar sem força excessiva.

2

Encaixar o display Waveshare nos pinos GPIO

Alinhar pinos GPIO do Pi (canto com pino 1) com os furos do display. Pressionar gradualmente e uniformemente. Não forçar — desalinhamento pode danificar.

3

Testar ANTES de montar no enclosure

Inserir o MicroSD com o firmware. Conectar energia. Aguardar ~45 segundos. Logo do SeedSigner deve aparecer. Testar joystick, botões e câmera. Só então montar no enclosure.

\# Testar câmera no SeedSigner: # Main menu → Tools → Test camera # Mostrar QR code genérico na tela → câmera deve ler

4

Montar no enclosure Orange Pill ou Open Pill

Open Pill: mais simples, imprime em ~2h, sem hardware extra. Orange Pill: visual mais acabado, requer botões e joystick em TPU (impressão resin ideal). Ambos disponíveis no GitHub do SeedSigner.

O SeedSigner é **stateless por design**: ao desligar, toda memória é apagada. Seeds nunca ficam armazenadas entre sessões. A cada uso, você carrega a seed, assina, e desliga — a seed some. Isso elimina o risco de extração de dados do dispositivo.

1

Baixar firmware e verificar — obrigatório

Baixar o .img correto para o modelo do Pi (pi0 para Pi Zero v1.3) e os dois arquivos de verificação. Desde v0.7.0, os builds são reproduzíveis — você pode compilar do código e comparar o hash.

\# github.com/SeedSigner/seedsigner/releases # Baixar 3 arquivos para Pi Zero v1.3: # seedsigner\_os.0.8.6.pi0.img ← firmware # seedsigner\_os.0.8.6.pi0.img.sha256 ← hash # seedsigner\_os.0.8.6.pi0.img.sig ← assinatura GPG # Verificar hash SHA256: sha256sum -c seedsigner\_os.0.8.6.pi0.img.sha256 # → "OK" = arquivo íntegro # Verificar assinatura GPG: gpg --verify seedsigner\_os.0.8.6.pi0.img.sig \\ seedsigner\_os.0.8.6.pi0.img # → "Good signature" = autêntico Parar se SHA256 ou GPG falharBuilds reproduzíveis v0.7.0+

2

Flashear o MicroSD com Balena Etcher

Etcher ou Raspberry Pi Imager gravam o .img direto no MicroSD. Não é necessário pré-formatar. O processo inclui verificação automática após gravação.

\# balena.io/etcher → baixar Etcher # Etcher → Flash from file → seedsigner\_os.\*.pi0.img # → Select target → MicroSD card # → Flash! → aguardar gravação + verificação # → "Flash Complete!" → MicroSD pronto # Alternativa: Raspberry Pi Imager # → CHOOSE OS → Use custom → .img # → CHOOSE STORAGE → MicroSD # → WRITE

3

Primeira inicialização — configurar para Mainnet

Por padrão, o SeedSigner inicia em Mainnet. Verificar as configurações antes do primeiro uso. O SeedSigner tem um SettingsQR: gerar um QR de configurações e escanear para aplicar preferências instantaneamente.

\# No SeedSigner após boot (~45s): Settings → Advanced → Bitcoin Network → Mainnet ✓ Settings → Display Units → BTC (ou sats) Settings → Coordinator → Sparrow (selecionar) Settings → Signing Mode → Auto-finalize: OFF (revisar manualmente antes de assinar) # Para testnet (praticar sem fundos reais): Settings → Advanced → Bitcoin Network → Testnet # → SEMPRE usar testnet para aprender o fluxo primeiro Praticar em testnet antes do mainnet

4

Atualizar firmware — reflashear o MicroSD

Atualizações NÃO são feitas OTA (over the air). Você baixa o novo .img, verifica GPG e SHA256, e reflasha o MicroSD. Manter o MicroSD antigo como backup caso a nova versão tenha bugs.

\# Manter dois MicroSDs: # → MicroSD A: versão atual estável # → MicroSD B: nova versão para teste # Processo de atualização: # 1. Baixar novo .img + verificar GPG + SHA256 # 2. Flashear no MicroSD B # 3. Testar com fundos mínimos # 4. Se ok → MicroSD B vira o principal # 5. Guardar MicroSD A como fallback Nunca OTADois MicroSDs = backup

**SeedQR** é a inovação central do SeedSigner para backup e carregamento de seeds: a seed BIP39 é codificada em um QR code compacto que pode ser gravado em metal. Você escaneia o QR com o SeedSigner e a seed é derivada instantaneamente.

Como o SeedQR funciona

Cada palavra BIP39 tem um número (0001–2048). O SeedQR codifica esses números em um QR compacto. Em vez de digitar 24 palavras toda vez que usa o SeedSigner, você aponta a câmera para o QR gravado na placa de metal e a seed é carregada em segundos. 
 
**Backup físico:** gravar o SeedQR em titanium ou aço inox com um punção ou a laser. Resistente a fogo (~1700°C para titanium), água, corrosão. 
 
**⚠ Nunca apontar câmera conectada à internet para o SeedQR.** O SeedQR é sua chave privada em formato QR.

1

Gerar seed com entropia da câmera (image capture)

O SeedSigner usa fotos capturadas pela câmera como fonte de entropia — o ruído visual da imagem é aleatoriedade imprevisível. Você pode complementar com dice rolls para entropia adicional.

\# SeedSigner → Seeds → Generate a seed # → Image Capture (câmera → 50+ fotos consecutivas) # OU # → Dice rolls (50 lançamentos de dado) # OU # → Combinação: Image Capture + Dice rolls # Resultado: seed de 12 ou 24 palavras # → ANOTAR imediatamente na placa de metal # → NÃO desligar antes de fazer o backup Câmera = entropia visual aleatóriaDados = complemento

2

Exportar SeedQR e gravar em metal

O SeedSigner exibe o SeedQR na tela. Você transcreve manualmente para um template em papel (disponível no GitHub) e depois transfere para metal com punção. O QR deve ser coberto imediatamente após o uso.

\# SeedSigner → Seeds → \[sua seed\] → Backup Seed # → Export SeedQR → exibe o QR na tela do SeedSigner # (não na webcam do computador!) # Transcrever para template: # github.com/SeedSigner/seedsigner → seedqr-templates # Imprimir em papel → pontuar os quadradinhos com caneta # Transferir para metal: # → Placa de aço inox ou titanium # → Punção manual ou elétrico # → Cada ponto = pixel escuro do QR # VERIFICAR antes de finalizar: # → Escanear com o SeedSigner → palavras devem bater Titanium = mais resistenteCobrir imediatamente após uso

3

Carregar seed existente (uso recorrente)

A cada uso do SeedSigner, você carrega a seed do zero — o dispositivo é stateless. Duas formas: digitar as palavras manualmente pelo joystick ou escanear o SeedQR da placa de metal.

\# Método 1 — SeedQR (mais rápido): # SeedSigner → Scan → Scan a SeedQR # → Apontar câmera para a placa de metal com o SeedQR # → Seed derivada em ~2 segundos # → Cobrir a placa imediatamente # Método 2 — Palavras manuais: # SeedSigner → Seeds → Enter a seed phrase # → Digitar cada palavra com o joystick # → 12 ou 24 palavras # → Mais lento mas sem expor o QR fisicamente # Após uso: # → SeedSigner → \[seed\] → Discard seed # OU simplesmente desligar o SeedSigner SeedQR = segundosPalavras = mais lento mas sem expor QR

O Sparrow é o coordinator: conhece só a xpub (chave pública), gera endereços de recebimento, monitora saldos e constrói PSBTs. Nunca tem acesso à chave privada — que fica exclusivamente no SeedSigner.

1

Exportar xpub do SeedSigner → QR → Sparrow

O SeedSigner exibe a xpub como QR animado (UR2.0). Sparrow escaneia com a webcam do computador. Nenhum dado transita por cabo ou rede — só luz da tela do SeedSigner para a câmera do computador.

\# SeedSigner (com seed carregada): # Seeds → \[sua seed\] → Export Xpub # → Single Sig (ou Multisig para 2-de-3) # → Native Segwit (P2WPKH) ou Taproot (P2TR) # → Exibe QR animado na tela # Sparrow (no computador): # File → New Wallet → dar nome # → Airgapped Hardware Wallet → SeedSigner # → Scan QR → apontar webcam para tela do SeedSigner # → xpub importada → Apply # → Sparrow agora é watching-only Sem caboSó QR — zero risco de conexãoTaproot = mais privado em 2026

2

Verificar endereços de recebimento no SeedSigner

Antes de dar um endereço de recebimento para alguém, verificar no SeedSigner que aquele endereço realmente pertence à sua seed. Protege contra address substitution em software comprometido.

\# Sparrow → Receive → copiar endereço # → clicar em "Verify Address" # → exibe QR do endereço # SeedSigner (com seed carregada): # Tools → Verify address → Scan QR # → Escanear o QR do Sparrow # → SeedSigner confirma: "Verified ✓" ou "Not found" # Só usar o endereço se SeedSigner confirmar # NUNCA confiar só no Sparrow para verificar Sempre verificar antes de receber

3

Uso diário: monitorar sem o SeedSigner

Com a watching-only wallet configurada, você usa o Sparrow normalmente para receber BTC e monitorar o saldo — sem precisar ligar o SeedSigner. O SeedSigner só é necessário quando for gastar.

\# Sparrow watching-only permite: # ✓ Gerar endereços de recebimento # ✓ Ver saldo e histórico de transações # ✓ Ver UTXOs individuais # ✓ Construir transações (PSBT não assinado) # ✓ Estimar fees # ✗ Assinar transações (requer SeedSigner) # ✗ Broadcast sem assinatura SeedSigner desligado = seed segura

O fluxo PSBT via QR é o coração do SeedSigner. Sparrow constrói a transação → exibe QR animado → SeedSigner escaneia, revisa e assina → exibe QR assinado → Sparrow escaneia de volta → broadcast via Tor. Chaves privadas nunca saem do SeedSigner.

Sparrow

① Construir a transação no Sparrow

Send → destinatário → valor → fee → Create Transaction → revisar inputs/outputs → Finalize Transaction for Signing → aparece o botão "Show QR"

Sparrow → Send → Pay to: endereço Bitcoin de destino → Label: descrição (local, não vai para blockchain) → Amount: valor em BTC ou sats → Fee: selecionar (low/medium/high ou manual) → Create Transaction → Inspecionar: inputs, outputs, change address → Finalize Transaction for Signing → Show QR ← botão que aparece agora

Sparrow

② Sparrow exibe PSBT como QR animado (UR2.0)

O PSBT é codificado em múltiplos frames QR animados usando o padrão UR2.0. Isso permite transmitir PSBTs de qualquer tamanho (incluindo multisig) via QR, sem limite de dados por frame.

Sparrow → Show QR → Janela abre com QR animado (UR:CRYPTO-PSBT) → Manter janela aberta e visível → NÃO fechar antes do SeedSigner terminar de escanear

SeedSigner

③ SeedSigner escaneia o PSBT animado

Com a seed carregada, SeedSigner escaneia o QR animado exibido pelo Sparrow. A câmera captura todos os frames até ter o PSBT completo. Pode levar alguns segundos dependendo do tamanho.

\# SeedSigner (seed já carregada): # Main menu → Scan # → Apontar câmera para a tela do Sparrow # → Aguardar leitura de todos os frames QR # → SeedSigner exibe resumo da transação

SeedSigner

④ Revisar transação na tela do SeedSigner

O SeedSigner mostra TODOS os detalhes da transação na tela: endereço de destino, valor, fee, change address. Verificar cada detalhe antes de confirmar. Esta é a última barreira de segurança.

\# SeedSigner exibe: # → Destination address (verificar dígitos finais) # → Amount (verificar valor exato em BTC/sats) # → Network fee (verificar se razoável) # → Change address (deve ser do seu wallet) # Verificação crítica: # Comparar endereço de destino com o que você escreveu # Confirmar que change vai para seu wallet # Verificar fee não está absurda (>5% do valor = revisar) # Confirmar: botão físico no SeedSigner Verificar endereço COMPLETO — não só os primeiros dígitos

SeedSigner

⑤ SeedSigner assina e exibe QR com assinatura

Após confirmação, SeedSigner adiciona a assinatura ao PSBT e exibe o PSBT assinado como novo QR animado. Nenhuma chave privada sai do dispositivo — apenas a assinatura.

\# SeedSigner: # → Botão de confirmação → assina o PSBT # → Exibe QR animado com PSBT assinado # → Manter a tela visível para o Sparrow escanear # O que sai do SeedSigner: APENAS a assinatura # O que NÃO sai: chave privada, seed, xpriv

Sparrow

⑥ Sparrow escaneia de volta → broadcast via Tor

Sparrow fecha a janela do QR animado, abre o scanner de webcam, escaneia o QR assinado do SeedSigner, adiciona a assinatura ao PSBT e faz o broadcast para a rede Bitcoin via Tor.

Sparrow: → Fechar janela do QR animado do PSBT → Scan QR (botão aparece após fechar) → Apontar webcam para tela do SeedSigner → PSBT assinado importado → Broadcast Transaction → TX ID gerado → confirmar no block explorer Broadcast via Tor no Whonix/Tails Chaves privadas nunca tocaram a rede

---

No próximo capítulo, construiremos a fortaleza digital com Whonix e nó próprio.
