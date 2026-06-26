# Capítulo 8 - Nível 3: O Observador

> "Construindo a fortaleza digital"

---

## Objetivo

Migrar para ambiente Whonix com node próprio, eliminando dependência de servidores públicos. Construir independência total de rede.

**Tempo estimado:** 1-2 semanas | **Dificuldade:** ★★★★☆

**Pré-requisitos:** Nível 2 concluído + computador com 16GB RAM.

---

---

### Passo 3.1 — Instalar VirtualBox no host

```
□ Baixar VirtualBox de virtualbox.org
□ Instalar no seu sistema operacional principal

□ Conceitos para entender:
 - Máquina Virtual (VM): computador dentro do computador
 - Rede NAT: VM acessa internet via host
 - Rede Interna: VMs conversam entre si, sem internet direta
 - Snapshots: "foto" do estado da VM para voltar atrás

□ Se seu host é Linux, considere KVM:
 - Mais performance que VirtualBox
 - Hypervisor nativo do Linux
 - VirtualBox é mais simples para começar
 - KVM é para quando você estiver confortável
```

---

### Passo 3.2 — Instalar Whonix

```
□ Baixar Whonix de whonix.org (via Tor Browser)
□ Baixar assinatura .asc e verificar (chave 2EEACCDA)
□ VirtualBox → Import Appliance → selecionar arquivo .ova
□ Duas VMs são criadas:
 - Whonix-Gateway (força Tor)
 - Whonix-Workstation (onde você trabalha)

□ INICIAR GATEWAY PRIMEIRO
 - Aguardar ícone Tor ficar verde
 - Só depois iniciar a Workstation

□ Na Workstation, verificar Tor:
 curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org
 Deve mostrar: "Congratulations. You are using Tor."

□ Trocar senha padrão (changeme → sua senha forte)
 passwd
```

---

### Passo 3.3 — Instalar ferramentas na Workstation

```
□ Sparrow Wallet (mesmo processo do Tails):
 - Baixar AppImage + verificar PGP
 - Tornar executável e rodar

□ KeePassXC:
 sudo apt install keepassxc -y
 Criar banco "whonix_crypto.kdbx"
 Guardar: senhas, .onions, metadados
 NUNCA guardar seed

□ Electrum (opcional, já que Sparrow é o foco):
 Pode instalar para ter alternativa
```

---

### Passo 3.4 — Entender Stream Isolation

```
□ Conceito: cada app usa circuito Tor SEPARADO
□ Impede que um app revele identidade de outro
□ Sparrow: Tor integrado nativo (automático)
□ Electrum: --oneserver --server .onion (isolado)
□ Whonix: uwt (Usability Wrapper for Tor) gerencia isso
□ Verificar: cada conexão de app deve ter circuito diferente
```

---

### Passo 3.5 — Criar VM para Bitcoin Core + EPS

```
□ VirtualBox → New VM → "Bitcoin-Node"
□ SO: Debian minimal
□ RAM: 4-8 GB (full node: 8 GB, pruned: 4 GB)
□ Disco: 400 GB (pruned) ou 800 GB (full)
□ Rede: Internal Network "Whonix"

□ Instalar Debian, atualizar sistema
□ Instalar Bitcoin Core:
 - Baixar de bitcoincore.org
 - Verificar PGP (chaves dos desenvolvedores)
 - Configurar bitcoin.conf para Tor (onlynet=onion)

□ Instalar EPS (Electrum Personal Server):
 - git clone do repositório oficial
 - Configurar com sua xpub
 - Configurar Tor hidden service
 - Anotar endereço .onion gerado

□ Sincronização inicial: 2-7 dias via Tor
 - Pode acelerar sincronizando via clearnet primeiro
 - Depois ativar onlynet=onion
```

---

### Passo 3.6 — Conectar Sparrow ao seu EPS

```
□ Sparrow → Preferences → Server → Private Electrum
□ URL: seu_onion.onion:50002
□ Test Connection → VERDE
□ Console Sparrow → getinfo → confirmar servidor

□ AGORA VOCÊ É INDEPENDENTE
 - Nenhum servidor público sabe seus endereços
 - Nenhum terceiro correlaciona suas transações
 - Seu node, seu EPS, sua privacidade
```

---

### Passo 3.7 — Configurar pasta compartilhada para PSBT

```
□ Criar pasta no host: /psbt_bridge
□ VirtualBox → Settings → Shared Folders → adicionar
□ Workstation acessa em: /mnt/psbt_bridge
□ Testar: criar arquivo no host, ver na Workstation
□ Fluxo PSBT: Sparrow → /mnt/psbt_bridge → MicroSD → Dispositivo
```

---

### Passo 3.8 — Entender o risco do Host OS

```
⚠️ ADVERTÊNCIA IMPORTANTE:

□ Whonix protege DENTRO das VMs
□ Mas se o HOST (seu Windows/Linux/macOS) estiver comprometido:
 → Keylogger pode capturar tudo que você digita na VM
 → Malware pode ver sua tela
 → Senhas, endereços, metadados podem vazar

□ Mitigações:
 → Manter host LIMPO e ATUALIZADO
 → Não instalar software pirata ou suspeito
 → Ideal: host Linux dedicado só para isso
 → Máximo: Qubes OS (Nível 7) resolve esse problema
 → As CHAVES PRIVADAS nunca estão no computador
 (Coldcard assina offline — isso salva mesmo com host comprometido)
```

---

### Verificação do Nível 3

```
□ Whonix Gateway + Workstation funcionando
□ Stream Isolation compreendido
□ Node Bitcoin sincronizado (ou sincronizando)
□ EPS rodando com .onion próprio
□ Sparrow conectado ao SEU servidor, não público
□ Fluxo PSBT funcionando via pasta compartilhada
□ Sei fazer snapshot da VM antes de operações críticas
□ Entendo o risco do host OS e como mitigar
```

---

> Não dependo de servidores alheios. Meu node valida minhas transações. Meu EPS responde só a mim. A fortaleza digital está de pé — e sei onde estão suas muralhas e suas brechas.

---

## 🏅 Conquista: "O Observador"

> Não dependo de servidores alheios. Meu node valida minhas transações. Meu EPS responde só a mim. A fortaleza digital está de pé — e sei onde estão suas muralhas e suas brechas.

---

---

## Aprofundamento: Configuração Completa do Whonix

**Diferença fundamental do Whonix:** persistência por design. Ao contrário do Tails, configurações, wallets, estado de swaps e histórico sobrevivem ao reboot — em discos virtuais cifrados pelo VirtualBox.

### Como o Whonix se divide

Host OS (Linux / Windows / macOS) — VirtualBox rodando aqui

Whonix-Gateway (sys-whonix)

• Roda o daemon Tor 
• Firewall bloqueia tudo que não é Tor 
• Stream isolation por porta 
• Kill switch: sem Tor = sem rede 
• IP real **nunca** exposto à Workstation 
• **RAM: 512MB** (suficiente)

⇄ 
rede 
interna

Whonix-Workstation (anon-whonix)

• Electrum + Sparrow + Feather 
• eigenwallet + RetoSwap 
• KeePassXC + dados persistentes 
• Sem acesso direto à internet 
• Todo tráfego → Gateway → Tor 
• **RAM: 2–4GB** (recomendado)

Coldcard / SeedSigner (externo) — comunica via SD card / QR — nunca via rede

### Requisitos mínimos de hardware

8 GB

RAM total

16GB ideal

50 GB

Disco livre

+300GB c/ nó BTC

x86-64

CPU

VT-x/AMD-V ativo

VBox 7+

VirtualBox

\+ Extension Pack

2 núcleos

CPU mín. por VM

4 ideal

SSD

Tipo de disco

HDD lento demais

**⚠ Ponto de risco vs Tails:** o Host OS é a superfície de ataque do Whonix. Se o Windows/macOS/Linux host for comprometido, as VMs podem ser monitoradas. Para máxima segurança: usar Linux dedicado como host, sem outros apps instalados.

O projeto Whonix oferece um instalador automático para Linux que baixa e configura VirtualBox + ambas as VMs com um único comando. Para Windows/macOS o fluxo é manual via OVA.

1

Opção A — Linux: instalador automático (recomendado)

O instalador do Whonix para Linux verifica nested virtualization, secure boot, e instala VirtualBox + ambas as VMs automaticamente. Transparente: todas as operações com root são listadas no output.

\# Em host Linux (Debian/Ubuntu/Fedora): # Baixar o instalador via Tor Browser (whonix.org/wiki/Linux) # Verificar SHA512 antes de executar: sha512sum dist-installer-cli # Rodar: bash dist-installer-cli --install --ci # O script instala: # → VirtualBox (última versão compatível) # → Whonix-Gateway OVA # → Whonix-Workstation OVA # → Importa ambas no VirtualBox automaticamente Verificação automáticaUm comando

2

Opção B — Windows/macOS: importar OVA manualmente

Baixar o arquivo OVA do Whonix (contém Gateway + Workstation), verificar a assinatura GPG, depois importar no VirtualBox. O OVA inclui ambas as VMs.

\# 1. Instalar VirtualBox (virtualbox.org) + Extension Pack # 2. Baixar Whonix OVA + assinatura: # whonix.org → Download → VirtualBox → .ova + .ova.asc # 3. Verificar GPG: gpg --keyserver keys.openpgp.org \\ --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA gpg --verify Whonix\*.ova.asc Whonix\*.ova # Saída: "Good signature from Patrick Schleizer" # 4. VirtualBox → File → Import Appliance # → selecionar o .ova → Import # → aceitar licença das duas VMs GPG obrigatório antes de importar

3

Primeira inicialização — Gateway SEMPRE primeiro

O Gateway deve estar completamente inicializado antes de ligar a Workstation. Se ligar na ordem errada, a Workstation fica sem rede e pode tentar conectar diretamente, o que falha mas é confuso.

\# Ordem obrigatória: # 1. VirtualBox → Whonix-Gateway → Start # Aguardar inicialização completa (~30-60s) # Wizard: aceitar termos → Connect (Tor direto) # Se rede censurada: Configure → Bridges # 2. VirtualBox → Whonix-Workstation → Start # Aguardar desktop Xfce carregar # Verificar Tor na Workstation: # Abrir Tor Browser → check.torproject.org # Deve mostrar: "Congratulations. This browser is configured to use Tor" # Default credentials (mudar imediatamente): # user: user / senha: changeme # root: root / senha: changeme Mudar senhas padrão imediatamente

4

Primeira configuração: senhas + atualizações

Fazer nas DUAS VMs (Gateway e Workstation). As atualizações no Whonix vão automaticamente via Tor — não é necessário configurar nada.

\# Em CADA VM (Gateway e Workstation): # Terminal → mudar senha do usuário: passwd # → digitar nova senha forte (20+ chars) # Mudar senha root: sudo passwd root # Atualizar pacotes (vai via Tor automaticamente): sudo apt update && sudo apt full-upgrade -y # Reiniciar após updates: sudo reboot # Repetir nas duas VMs Senhas únicas por VMUpdates via Tor

O Whonix tem persistência por design — os discos virtuais (.vdi) ficam no host. Para proteger esses dados em repouso (se alguém pegar o computador), é necessário cifrar os discos das VMs.

A criptografia do VirtualBox (AES-XTS256) protege os dados quando as VMs estão **desligadas**. Com as VMs rodando, os dados estão descriptografados em memória — proteger o host também é fundamental.

1

Instalar VirtualBox Extension Pack (obrigatório para cifragem)

A criptografia de disco do VirtualBox requer o Extension Pack. Sem ele, a opção de disk encryption não aparece no menu.

\# Baixar Extension Pack (mesmo número de versão do VirtualBox): # virtualbox.org/wiki/Downloads → VirtualBox Extension Pack # Linux — instalar via terminal: sudo VBoxManage extpack install --replace \\ Oracle\_VirtualBox\_Extension\_Pack-7.x.x.vbox-extpack # Windows/macOS: clicar duas vezes no arquivo .vbox-extpack # VirtualBox pedirá confirmação → aceitar licença → Install # Verificar instalação: VBoxManage list extpacks # → "Oracle VirtualBox Extension Pack" deve aparecer Mesmo número de versão do VirtualBox

2

Cifrar os discos das VMs — Gateway e Workstation

Fazer nas DUAS VMs separadamente, com as VMs desligadas. Usar AES-XTS256-PLAIN64 — o cipher mais forte disponível no VirtualBox.

\# VMs precisam estar DESLIGADAS # VirtualBox → selecionar VM → Settings (Configurações) # → General → Disk Encryption # → ✓ Enable Disk Encryption # → Cipher: AES-XTS256-PLAIN64 # → Digitar senha forte (diferente da senha do usuário) # → OK → aguardar cifragem (pode demorar) # Repetir para Gateway e Workstation separadamente # USAR SENHAS DIFERENTES POR VM # Via CLI (alternativa): VBoxManage encryptmedium \\ "/path/to/Whonix-Workstation.vdi" \\ --newpassword - \\ --cipher AES-XTS256-PLAIN64 \\ --newpasswordalign 1 AES-XTS256-PLAIN64Senhas diferentes por VMBackup das senhas no KeePassXC

3

Cifrar o Host OS — LUKS (Linux) ou BitLocker (Windows)

A criptografia do VirtualBox protege os .vdi quando as VMs estão desligadas. Mas os arquivos ficam no host — se o host não tiver FDE, qualquer pessoa com acesso físico pode copiar os .vdi e tentar quebrar a senha offline.

\# Linux host — LUKS (configurar durante instalação do OS): # Durante instalação: ✓ Encrypt the new Ubuntu installation # Senha LUKS forte e diferente de tudo # Ou post-install com cryptsetup: # (operação destrutiva — fazer backup antes) sudo cryptsetup luksFormat /dev/sda sudo cryptsetup open /dev/sda crypthome # Windows host — BitLocker: # Painel de Controle → BitLocker → Ativar # (requer Windows Pro/Enterprise) # macOS host — FileVault: # Preferências do Sistema → Segurança → FileVault → Ativar LUKS no Linux = mais forteFDE no host é fundamental

4

Backup cifrado das VMs

Os discos .vdi ficam no host. Fazer backup periódico para HD externo cifrado. Uma VM corrompida sem backup = perda de toda a configuração (mas não dos fundos, que ficam na seed do Coldcard).

\# Localização padrão dos .vdi no Linux: ~/VirtualBox VMs/Whonix-Gateway/ ~/VirtualBox VMs/Whonix-Workstation/ # Backup para HD externo cifrado com VeraCrypt: # 1. Criar volume VeraCrypt no HD externo # 2. Montar o volume # 3. Copiar as pastas das VMs para dentro do volume # 4. Desmontar → dados cifrados em repouso # Frequência recomendada: mensal ou após grandes mudanças # (instalação de novos apps, mudanças de configuração)

A vantagem do Whonix sobre Tails: todas as ferramentas ficam instaladas permanentemente na Workstation, com configurações salvas e sem precisar baixar ou verificar a cada sessão. A Workstation tem stream isolation automático por porta.

₿

Electrum — já incluso, verificar versão

O Whonix inclui Electrum por padrão. A wiki do Whonix documenta instalação manual apenas para versões mais recentes que a empacotada. O Electrum no Whonix já usa stream isolation automático via SocksPort dedicado.

\# Verificar versão instalada: electrum --version # Para versão mais recente (whonix.org/wiki/Electrum): scurl-download https://download.electrum.org/4.x.x/electrum-4.x.x-x86\_64.AppImage scurl-download https://download.electrum.org/4.x.x/electrum-4.x.x-x86\_64.AppImage.asc # Verificar GPG: gpg --verify electrum-\*.AppImage.asc electrum-\*.AppImage # Rodar com servidor .onion + stream isolation: electrum --oneserver \\ --server seu-servidor.onion:50002:s \\ --proxy socks5:127.0.0.1:9111 # porta isolada do Whonix Stream isolation por portaPorta 9111 = isolada

₿

Sparrow Wallet — instalar persistente

O próprio fórum de desenvolvimento do Whonix debateu substituir o Electrum pelo Sparrow como padrão, citando builds determinísticos, suporte a Taproot, UTXO control e privacidade superior. Sparrow tem Tor integrado nativo.

\# Baixar via scurl (wrapper seguro do curl no Whonix): scurl-download https://github.com/sparrowwallet/sparrow/releases/latest/download/sparrow-server-\*.tar.gz scurl-download https://github.com/sparrowwallet/sparrow/releases/latest/download/sparrow-\*.tar.gz.asc # Verificar GPG (Craig Raw): gpg --keyserver keys.openpgp.org --recv-keys D4D0D3202FC06849A257B38DE94618334C674B40 gpg --verify sparrow-\*.tar.gz.asc sparrow-\*.tar.gz # Instalar no home: tar -xf sparrow-\*.tar.gz -C ~/apps/ chmod +x ~/apps/Sparrow/bin/Sparrow # Configurar Tor: # Preferences → Server → Private Electrum # URL: sparrowa7io5pz6ud3ehqzosvepbxbxt2zphmkjsylp2zgxooko23pqd.onion:50001 # Proxy: 127.0.0.1:9050 Builds determinísticos.onion oficial

◎

Feather Wallet — XMR com Tor nativo

A comunidade do Whonix discutiu incluir o Feather por padrão — é considerado ideal para XMR no Whonix por ser leve, focado em privacidade e ter Tor integrado que detecta automaticamente o daemon Tor do Gateway.

\# Baixar + verificar: scurl-download https://featherwallet.org/files/releases/linux/feather-\*.AppImage scurl-download https://featherwallet.org/files/releases/linux/feather-\*.AppImage.asc gpg --keyserver hkps://keys.openpgp.org --recv-keys 8185E158A33330C7FD61BC0D1F76E155CEFBA71C gpg --fingerprint 8185E158A33330C7FD61BC0D1F76E155CEFBA71C gpg --verify feather-\*.AppImage.asc feather-\*.AppImage # Tornar executável e mover: chmod +x feather-\*.AppImage mv feather-\*.AppImage ~/apps/feather.AppImage # Feather detecta Tor do Whonix automaticamente (porta 9050) # Settings → Network → Always route over Tor Tor automático no Whonix

↔

eigenwallet — atomic swap BTC→XMR

O eigenwallet detecta automaticamente o daemon Tor na porta 9050 — que no Whonix é o Gateway. Toda comunicação com sellers vai automaticamente via Tor sem configuração adicional. Estado do swap persiste entre sessões.

\# Baixar + verificar: scurl-download https://github.com/eigenwallet/core/releases/latest/download/eigenwallet-x86\_64.AppImage scurl-download https://github.com/eigenwallet/core/releases/latest/download/eigenwallet-x86\_64.AppImage.asc gpg --import binarybaron.asc gpg --verify eigenwallet-\*.AppImage.asc eigenwallet-\*.AppImage chmod +x eigenwallet-\*.AppImage mv eigenwallet-\*.AppImage ~/apps/eigenwallet.AppImage # Estado do swap salvo em: ~/.local/share/eigenwallet/ # → persiste automaticamente entre sessões no Whonix Estado persisteTor automático via Gateway

🔑

KeePassXC — já instalado no Whonix

O KeePassXC vem pré-instalado na Workstation. O banco de dados fica no disco da VM, que está cifrado pelo VirtualBox. Dupla camada: VirtualBox AES-XTS256 + KeePassXC AES-256.

\# Abrir: Applications → Accessories → KeePassXC # File → New Database → salvar em ~/keepass/cripto.kdbx # Senha mestra: 20+ chars, única, não reutilizada # O que guardar: # → PIN Coldcard (principal, duress, brick) # → Passphrase BIP39 (25ª palavra) # → xpub / MPK das carteiras # → Subendereços XMR usados (com data e operação) # → Hashes GPG das ferramentas verificadas # → Senhas de cifragem das VMs (VirtualBox AES) # → Tokens de trades RoboSats/RetoSwap

No Whonix, uso diário é diferente do Tails. Apps ficam abertos, swaps rodam em background, estado persiste. A disciplina é diferente — não é mais "boot, opera, desliga", é um ambiente de trabalho permanente.

①

Rotina de início de sessão

A ordem é sempre a mesma. O VirtualBox pedirá a senha de cifragem do disco ao iniciar cada VM.

1\. Ligar o computador 2. VirtualBox → Whonix-Gateway → Start → digitar senha de cifragem do disco (AES-XTS256) → aguardar Tor inicializar (~30s) → ícone Tor verde na bandeja do sistema 3. VirtualBox → Whonix-Workstation → Start → digitar senha de cifragem do disco → desktop Xfce carrega 4. Verificar Tor: Tor Browser → check.torproject.org 5. Abrir KeePassXC com senha mestra 6. Abrir apps necessários (Feather, Sparrow, eigenwallet) Gateway SEMPRE antes da Workstation

②

Stream isolation — circuitos Tor separados por app

A vantagem do Whonix sobre outras configurações Tor: cada aplicação usa um SocksPort diferente, o que cria circuitos Tor separados. Um atacante que monitore o Electrum não consegue correlacionar com o Feather ou eigenwallet.

\# Portas Tor disponíveis no Whonix para isolamento: # 9050 → padrão (SocksPort geral) # 9100 → Tor Browser # 9111 → uso dedicado (ex: Electrum) # 9114 → uso dedicado (ex: eigenwallet) # 9115 → uso dedicado (ex: Feather) # Configurar Electrum com porta isolada: electrum --proxy socks5:127.0.0.1:9111 \\ --server meu-electrumx.onion:50002:s \\ --oneserver # Cada app em porta diferente = circuito Tor diferente Circuito separado por appPadrão único do Whonix

③

Swap eigenwallet em background — vantagem do Whonix

No Tails, era necessário manter o computador ligado durante o swap. No Whonix, você pode minimizar a VM e fazer outras coisas no host. O estado do swap persiste mesmo se a Workstation for suspensa (não desligada).

\# Iniciar swap: ~/apps/eigenwallet.AppImage # Minimizar a VM (não desligar): # VirtualBox → View → Minimize # O swap continua rodando em background # Monitorar progresso via CLI: ~/apps/eigenwallet.AppImage swap resume \\ --swap-id SEU\_SWAP\_ID # Verificar estado salvo: ls ~/.local/share/eigenwallet/ # → arquivos de estado do swap (retomáveis) Swap em backgroundEstado persiste

④

Rotina de encerramento seguro

Nunca forçar o desligamento das VMs (botão X do VirtualBox). Usar shutdown limpo para garantir que os arquivos das wallets sejam escritos corretamente no disco cifrado.

\# Na Workstation (primeiro): sudo shutdown now # Aguardar a VM fechar completamente # No Gateway (depois): sudo shutdown now # Alternativa via VirtualBox: # Machine → ACPI Shutdown (não "Power Off" forçado) # Verificar que os .vdi estão cifrados: # VirtualBox → Settings → Disk Encryption → deve mostrar "Enabled" # Em emergência (alguém na porta): # Fechar o laptop = suspende as VMs # Os discos cifrados ficam inacessíveis sem a senha Nunca forçar Power OffShutdown limpo = dados íntegros

⑤

Atualizações — rotina mensal

O Whonix atualiza via apt automaticamente via Tor. Os AppImages (Sparrow, Feather, eigenwallet) precisam ser verificados e atualizados manualmente — criar lembrete mensal.

\# Atualizar sistema (nas duas VMs): sudo apt update && sudo apt full-upgrade -y # Verificar updates de AppImages (mensalmente): # → sparrowwallet.com # → featherwallet.org # → github.com/eigenwallet/core/releases # Para cada AppImage atualizado: # 1. scurl-download nova versão + .asc # 2. gpg --verify # 3. chmod +x + substituir o antigo em ~/apps/ # 4. Testar antes de usar com fundos reais Sistema: automático via TorAppImages: manual mensal


> **Tails vs Whonix:** comparação resumida acima; tabela completa, matriz de decisão e estratégia híbrida na seção *Referência: Tails vs Whonix* (final deste capítulo).

## Referência: Arquitetura de Segurança do Whonix

Host OS (Linux / Windows / macOS) Whonix-Gateway sys-whonix Tor Network todo tráfego roteia aqui Stream Isolation circuito separado por app Firewall + Kill switch bloqueia vazamento de IP IP real nunca exposto → Internet (via Tor) nós Bitcoin / Electrum servers Whonix-Workstation anon-whonix — sem acesso direto à internet Electrum BIP39 seed local stream isolation ativado → ElectrumX local ou .onion Sparrow Wallet UTXO control Tor integrado nativo multisig + PSBT Specter Desktop interface para Bitcoin Core multisig avançado ElectrumX / Bitcoin Core nó próprio (opcional) máxima privacidade Hardware Wallet (air-gapped) Coldcard / SeedSigner / Jade — chaves privadas nunca entram na VM assina transações via PSBT / QR / SD card tráfego Gateway (Tor) Workstation HW Wallet (externo)

Electrum

Já incluído no Whonix

Pré-instalado na Workstation. Configure stream isolation para circuito Tor dedicado. Conecte ao seu ElectrumX local para não expor endereços a servidores de terceiros.

BIP39 Stream isolation Lightning HW wallet

Sparrow Wallet

Recomendado para privacidade avançada

Tor integrado nativo, controle total de UTXOs, suporte a multisig e PSBT. Conecta via endereço .onion do seu nó. Disponível via .onion oficial do Sparrow.

Tor nativo UTXO control Multisig PSBT / QR

Specter Desktop

Coordenador multisig

Interface gráfica para Bitcoin Core. Ideal para configurar multisig com múltiplas hardware wallets air-gapped. Pode expor como serviço Tor oculto.

Bitcoin Core Multisig Coldcard SeedSigner

ElectrumX + Bitcoin Core

Nó próprio — máxima privacidade

Cadeia: Electrum → ElectrumX → Bitcoin Core → Tor → rede. Nenhum servidor externo sabe quais endereços são seus. Exige ~100–300 GB de disco.

Nó próprio Zero trust externo 100–300 GB

1

Baixar e importar Whonix

Baixe os arquivos OVA (Gateway + Workstation) de **whonix.org** via Tor Browser. Verifique a assinatura GPG antes de importar. Suporta VirtualBox, KVM e Qubes OS.

gpg --verify whonix\*.ova.asc

2

Iniciar Gateway primeiro

Sempre suba o Gateway antes da Workstation. Ele estabelece o túnel Tor. O assistente Anon-Connection-Wizard guia a conexão inicial (direto ou via bridges).

3

Instalar a wallet na Workstation

Use `scurl-download` (wrapper seguro do curl) para baixar o AppImage do Electrum ou Sparrow. Sempre verifique a assinatura GPG do desenvolvedor.

scurl-download https://download.electrum.org/4.7.0/electrum-4.7.0-x86\_64.AppImage 
gpg --verify electrum\*.asc electrum\*.AppImage

4

Ativar Stream Isolation

Garante que o Electrum use um circuito Tor separado de outros apps, impedindo correlação de identidades entre carteiras diferentes.

electrum --oneserver --server seu-servidor.onion:50002:s

5

Gerar seed BIP39 com HW Wallet

Nunca gere a seed dentro da VM. Use uma hardware wallet air-gapped (Coldcard, SeedSigner). Importe apenas a xpub (chave pública) na Workstation para criar uma watching-only wallet.

6

Assinar transações via PSBT

A Workstation cria a transação não assinada (PSBT). Você exporta via QR code ou SD card para a HW wallet air-gapped, assina, e devolve para broadcast via Tor.

✓

IP real protegido mesmo com malware

Mesmo que a Workstation seja comprometida, o malware só enxerga o IP do Gateway Tor — nunca o IP real do host. Essa é a vantagem fundamental da arquitetura dual-VM.

⚠

Electrum com servidores públicos expõe endereços

Por padrão, o Electrum conecta a servidores de terceiros que podem correlacionar todos os seus endereços. Sempre use ElectrumX próprio ou configure conexão manual para um servidor .onion confiável.

⚠

Seed gerada dentro da VM não é air-gapped

Gerar a seed BIP39 na Workstation cria risco: se a VM for comprometida agora ou no futuro, a seed pode ser extraída. Sempre gere seeds em hardware dedicado air-gapped.

⚠

Análise de blockchain não é impedida

Whonix protege seu IP e identidade de rede, mas não ofusca o grafo de transações on-chain. Para maior privacidade de saldo, considere coin control, CoinJoin (Whirlpool/JoinMarket) ou Monero.

✗

Whonix não protege contra erros humanos

Login em contas pessoais, reúso de endereços, copiar seed em texto claro — qualquer desses gestos desfaz toda a proteção técnica. O elo mais fraco é sempre o comportamento do usuário.

✗

Host OS comprometido compromete tudo

Whonix protege dentro das VMs, mas se o sistema operacional host for comprometido (keylogger, rootkit), as VMs podem ser monitoradas. Para máximo isolamento: use Qubes OS como host.

---

## Referência: Tails vs Whonix

Escolher entre Tails e Whonix define como você opera daqui em diante — coinjoins, swaps, monitoramento de carteira. Este capítulo ensina Whonix; a tabela abaixo ajuda a decidir **quando** usar cada ambiente.

### Tabela comparativa direta

| Critério | Tails com Persistent Storage | Whonix (VirtualBox ou KVM) |
| --- | --- | --- |
| **Persistência dos dados do Whirlpool** | Frágil — depende de arquivo criptografado no USB. Corrupção do Persistent Storage = perda do estado local | Robusta — disco virtual da VM é um arquivo comum, facilmente backupeável e restaurador |
| **Restauração após falha** | Trabalhosa — reinstalar Tails, reconfigurar Persistent Storage, rodar Restore from Seed (10-40 min) | Rápida — substituir o arquivo .vdi/.qcow2 pelo backup. Whirlpool retoma em segundos |
| **Facilidade de backup** | Baixa — precisa clonar o USB inteiro ou copiar a partição persistente manualmente | Alta — copiar o arquivo da VM ou tirar snapshot do hipervisor. Automação via script |
| **Anonimato de rede** | Tor forçado no sistema todo. Nenhum tráfego clearnet possível (fail-closed) | Tor forçado via Gateway VM isolada. Workstation não tem IP real, nem sabe sua localização. Fail-closed também |
| **Isolamento de processos** | Moderado — AppArmor por perfil. Whirlpool roda no mesmo kernel que o navegador | Alto — VM separada. Se o Sparrow for comprometido, o host e a rede Tor estão em outra VM |
| **Proteção contra malware persistente** | Alta — sistema é imutável por design. Malware morre no reboot | Média — malware pode persistir na VM se infectar o disco virtual. Mitigável com snapshots |
| **Conveniência para uso diário** | Baixa — boot lento, precisa do USB físico, sessões longas exigem cuidado extra | Média — VM roda dentro do seu sistema host. Pode ficar semanas ligada mixando sem interrupção |
| **Complexidade de configuração inicial** | Média — Persistent Storage, instalar ferramentas, verificar PGP a cada atualização | Alta — duas VMs, configurar rede interna, instalar Guest Additions, entender VirtualBox/KVM |
| **Consumo de recursos** | Baixo — roda direto no hardware, 2-4 GB RAM bastam | Alto — precisa de RAM para host + Gateway VM + Workstation VM. Mínimo 8 GB RAM, recomendado 16 GB |
| **Integração com Coldcard (PSBT via MicroSD)** | Nativa — USB do Coldcard e do Tails no mesmo hardware físico. Passar SD card é direto | Indireta — Coldcard no host físico, Sparrow na VM. Precisa de pastas compartilhadas ou USB passthrough. Funciona, mas com atrito |
| **Integração com EPS (Electrum Personal Server)** | Mesmo hardware, pode usar localhost se EPS rodar no Tails (não ideal) ou .onion externo | Perfeita — EPS pode rodar em outra VM na mesma rede interna Whonix, ou no host com túnel .onion |
| **Tempo de uptime para mixagem longa** | Limitado — Tails não foi feito para ficar dias ligado. Suspensão pode quebrar Tor | Ilimitado — VM pode ficar semanas mixando 24/7, com snapshots para recuperação |
| **Risco de perda de fundos** | Nenhum, mas perda de estado do Whirlpool gera retrabalho | Nenhum, e o estado está sempre backupeável |
| **Perfil do usuário ideal** | Quem faz coinjoins esporádicos, em sessões dedicadas, com paciência para rebuild | Quem faz coinjoins frequentes, mantém node próprio, quer automação e resiliência |

---

### Análise qualitativa

### Tails: o cofre portátil que você abre só quando precisa

**Vantagens reais:**

* Não deixa rastro no hardware. Se você mora em país hostil a cripto, o Tails não deixa vestígio no disco do computador.
* O sistema inteiro é imutável. Um malware que infecte o Sparrow morre no reboot (a não ser que grave no Persistent Storage, o que é difícil).
* Portabilidade extrema: cabe num pendrive no bolso. Você pode mixar em qualquer laptop emprestado.
* Custo zero em infraestrutura: não precisa de hypervisor, nem de VM, nem de node dedicado.

**Desvantagens reais:**

* A persistência é uma gambiarra elegante, mas gambiarra. O Tails não foi projetado para manter estado de aplicações complexas como o Whirlpool.
* Cada sessão de mixagem longa é uma oração silenciosa para a energia não cair e o USB não pifar.
* Restaurar o estado do Whirlpool após perda do Persistent Storage é chato e demorado, embora seguro.
* Se você mixa com frequência (vários UTXOs, vários pools), o ciclo de boot → carregar carteira → iniciar Whirlpool → esperar rounds → desligar fica desgastante.

**Conclusão para Tails:** 
Use Tails se você faz **coinjoins táticos** — uma vez por mês, prepara UTXOs para swaps futuros, não tem pressa. É o cofre que você vai buscar no banco quando precisa, não o cofre que fica aberto no quarto.

---

### Whonix: a fortaleza que fica de prontidão

**Vantagens reais:**

* A arquitetura de duas VMs é uma obra-prima: a Workstation **não tem IP real**, não conhece sua localização geográfica, não sabe seu endereço MAC. Mesmo que o Sparrow seja 0-day explorado, o atacante está preso numa VM sem rota para a internet — ele só vê o Gateway, que só fala Tor.
* Snapshots são um superpoder. Antes de cada round de Whirlpool, tire snapshot. Se algo corromper, volta em 30 segundos.
* Pode mixar 24/7. Deixa a VM rodando enquanto trabalha, dorme, viaja. O Whirlpool adora tempo de uptime — mais rounds, mais pares, anonset sobe mais rápido.
* Integração com node próprio (EPS) é natural e elegante. Você pode ter uma terceira VM só com Bitcoin Core + EPS, toda comunicação interna criptografada e via Tor.
* Backup é copiar arquivo. Sem ritual de clonagem de USB, sem `dd` nervoso.

**Desvantagens reais:**

* Complexidade de setup não é trivial. Instalar Whonix, configurar rede interna, pastas compartilhadas, USB passthrough — leva uma tarde inteira na primeira vez.
* Exige hardware parrudo. Com host Linux + Gateway VM + Workstation VM + (opcional) Node VM, 16 GB de RAM é o mínimo confortável.
* O host não é anônimo. Seu sistema operacional base (Windows, Linux, macOS) sabe que você está rodando Whonix. Em país opressor, isso pode ser um problema. O Tails não deixa rastro; o Whonix deixa a VM no seu disco.
* Malware que escape da VM para o host é cenário de ataque avançado (ex: hipervisor escape), mas não impossível. No Tails, não há host para escapar — é o hardware direto.

**Conclusão para Whonix:** 
Use Whonix se você é **operador frequente** — mantém node próprio, faz coinjoins semanais, swaps regulares, e quer a conveniência de um sistema sempre pronto, com backup fácil e resiliência contra falhas. É a fortaleza que fica de prontidão no terreno, não o cofre que você vai buscar.

---

### Matriz de decisão rápida

| Seu perfil | Escolha |
| --- | --- |
| Faço coinjoin 1x por mês, não tenho pressa, não quero hardware extra | **Tails** |
| Faço coinjoins toda semana, tenho node próprio, quero automação | **Whonix** |
| Moro em país com risco de apreensão de equipamento | **Tails** (pendrive escondível) |
| Tenho desktop com 16+ GB RAM e SSD sobrando | **Whonix** |
| Uso laptop emprestado ou de trabalho | **Tails** |
| Quero mixar 24/7 para anonset alto rápido | **Whonix** |
| Não quero aprender VirtualBox/KVM agora | **Tails** |
| Já sei VirtualBox e quero o melhor setup possível | **Whonix** |
| Preciso de portabilidade total (viajar, levar no bolso) | **Tails** |
| Quero integrar com EPS, node, eigenwallet tudo junto | **Whonix** |

---

### Estratégia híbrida recomendada

Com base no protocolo completo da trilha (Tails para swaps pontuais, Whonix para operações persistentes), você pode ter **os dois**, em funções separadas:

| Ambiente | Função |
| --- | --- |
| **Whonix Workstation persistente** | Whirlpool 24/7 + Sparrow watching-only + consultas ao node EPS |
| **Tails (sessões dedicadas)** | Swap BTC→XMR (eigenwallet) + XMR→BTC (RetoSwap) + Feather + RoboSats |

**Fluxo:**

1. No Whonix, você mixa BTC continuamente até ter outputs pós-coinjoin prontos.
2. Move os outputs limpos para uma carteira Postmix no Whonix.
3. Quando vai fazer um swap, **transfere só o necessário** do Whonix para um endereço da carteira no Tails.
4. No Tails, executa o swap (eigenwallet), recebe XMR no Feather.
5. O Whonix nunca toca em Monero; o Tails nunca guarda estado de longo prazo. Segregação de funções = segurança em camadas.

Isso resolve o dilema: Whonix para o trabalho pesado e persistente (coinjoin), Tails para a operação cirúrgica e descartável (swap).

---

No próximo capítulo, desapareceremos na multidão com CoinJoin e Whirlpool.
