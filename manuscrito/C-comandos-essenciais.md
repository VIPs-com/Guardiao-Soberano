# Apêndice C — Comandos Essenciais

Aqui está uma referência rápida de comandos que você usará com frequência.

## Verificação de ambiente

    # Verificar se está usando Tor
    curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org

    # Verificar integridade de arquivo baixado
    sha256sum arquivo_baixado

    # Verificar assinatura PGP
    gpg --verify arquivo.asc arquivo

## Whonix

    # Atualizar sistema
    sudo apt update && sudo apt full-upgrade -y

    # Baixar arquivo via Tor (wrapper seguro)
    scurl-download https://exemplo.com/arquivo

    # Verificar IP (deve mostrar IP do Tor)
    curl --socks5-hostname 127.0.0.1:9050 https://api.ipify.org

## Sparrow Wallet

    # Tornar AppImage executável
    chmod +x sparrow-*.AppImage

    # Executar
    ./sparrow-*.AppImage

## Bitcoin Core

    # Iniciar como daemon
    bitcoind -daemon

    # Verificar status
    bitcoin-cli getblockchaininfo

    # Verificar peers
    bitcoin-cli getpeerinfo

    # Parar
    bitcoin-cli stop

## EPS (Electrum Personal Server)

    # Iniciar
    python3 electrum-personal-server.py config.ini

    # Verificar logs
    tail -f ~/.electrum-personal-server/log.txt

## Coldcard

    # Exportar xpub (via MicroSD)
    # Coldcard → Advanced → MicroSD → Export Wallet → Sparrow Wallet

    # Assinar PSBT
    # Coldcard → Ready to Sign → selecionar arquivo .psbt

    # Gerar seed com dice rolls (entropia máxima)
    # Coldcard → New Seed Words → Dice Rolls → Enter 99+ rolls → Confirm

---

## Tails OS

``` {.sourceCode .bash}
# Verificar imagem Tails após download
gpg --keyid-format long --verify tails-amd64-*.img.sig tails-amd64-*.img

# Saída esperada:
# gpg: Good signature from "Tails developers <tails@boum.org>"

# Verificar hash SHA256
sha256sum tails-amd64-*.img
```

---

## Whonix — Verificação de Tor

``` {.sourceCode .bash}
# Verificar se a Workstation está roteando via Tor
# Execute na Whonix Workstation:
curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org/api/ip

# Saída esperada:
# {"IsTor":true,"IP":"xxx.xxx.xxx.xxx"}

# Alternativa (sem proxy manual — o Whonix já roteia tudo):
curl https://check.torproject.org/api/ip
```

---

## Ian Coleman BIP39 (validação offline)

``` {.sourceCode .bash}
# Usar no Tails SEM REDE ATIVA:
# 1. Baixar bip39-standalone.html em máquina segura
# 2. Transferir via MicroSD
# 3. No Tails (Tails → sem rede): abrir bip39-standalone.html no browser
# 4. Inserir seed → verificar endereços derivados
# 5. Confirmar que batem com os endereços do Sparrow

# NUNCA abrir online com sua seed real
```

---

## eigenwallet (Whonix Workstation)

``` {.sourceCode .bash}
# Download seguro no Whonix/Tails (verifique a versão em github.com/eigenwallet/core/releases)
EW_VER=4.11.3
scurl-download "https://github.com/eigenwallet/core/releases/download/${EW_VER}/eigenwallet_${EW_VER}_amd64.AppImage"
scurl-download "https://github.com/eigenwallet/core/releases/download/${EW_VER}/eigenwallet_${EW_VER}_amd64.AppImage.asc"

# Importar chave PGP (arquivo .asc na mesma página de releases do GitHub)
# gpg --import binarybaron.asc

# Verificar assinatura
gpg --verify "eigenwallet_${EW_VER}_amd64.AppImage.asc" "eigenwallet_${EW_VER}_amd64.AppImage"

# Tornar executável e rodar
chmod +x "eigenwallet_${EW_VER}_amd64.AppImage"
./"eigenwallet_${EW_VER}_amd64.AppImage"

# Verificar que eigenwallet detectou o Tor daemon
# (deve aparecer "Tor detected" na inicialização)

# Estado persistente no Tails — link para Persistent
ln -s ~/.local/share/eigenwallet ~/Persistent/eigenwallet-state

# Se eigenwallet não encontra Tor:
# Verificar se o Whonix Gateway está rodando
# Verificar se a porta 9050 está acessível na Workstation
curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org/api/ip
```

---

## SeedSigner (verificação de firmware)

``` {.sourceCode .bash}
# Verificar hash SHA256 do firmware
sha256sum -c seedsigner_os.0.8.6.pi0.img.sha256

# Verificar assinatura PGP
gpg --verify seedsigner_os.0.8.6.pi0.img.sig seedsigner_os.0.8.6.pi0.img

# Gravar firmware no MicroSD (Linux/Tails)
# Substituir /dev/sdX pelo seu MicroSD (verificar com lsblk)
sudo dd if=seedsigner_os.0.8.6.pi0.img of=/dev/sdX bs=4M status=progress
```

---

## Whonix — Instalação e configuração

``` {.sourceCode .bash}
# Instalar Whonix via auto-installer (Linux host)
bash dist-installer-cli --install --ci

# Importar chaves GPG do Whonix
gpg --recv-keys 916B8D99C38EAC5B7B9A C2A8EB1C87E20F8E

# Verificar imagem Whonix após download
gpg --verify Whonix-*.ova.asc Whonix-*.ova

# IMPORTANTE: Alterar senhas padrão na primeira inicialização
# Usuário padrão: user/changeme → alterar
# Root padrão: root/changeme → alterar
passwd
```

---

## Electrum — stream isolation (Whonix)

``` {.sourceCode .bash}
# Conectar a servidor .onion específico com stream isolation
electrum --oneserver --server meu-servidor.onion:50002:s

# Verificar conexão (deve mostrar servidor .onion)
electrum getinfo
```

---

## Sparrow — dados persistentes no Tails

``` {.sourceCode .bash}
# Executar Sparrow com dados em Persistent Storage
~/Persistent/apps/sparrow/bin/Sparrow -d ~/Persistent/sparrow-data

# Exportar Output Descriptor de uma carteira
# Sparrow → File → Export Wallet → Save Descriptor
```

---

## Feather Wallet (Monero)

``` {.sourceCode .bash}
# Importar chave e conferir fingerprint (Apêndice D)
gpg --keyserver hkps://keys.openpgp.org --recv-keys 8185E158A33330C7FD61BC0D1F76E155CEFBA71C
gpg --fingerprint 8185E158A33330C7FD61BC0D1F76E155CEFBA71C

# Verificar assinatura do binário
gpg --verify feather-*.AppImage.asc feather-*.AppImage

# Tornar executável e rodar
chmod +x feather-*.AppImage
./feather-*.AppImage

# Gerar subendereço fresco (sempre use um novo por transação)
# Feather → Receive → Create new address
```

---
