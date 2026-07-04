# Whonix no VirtualBox — Gateway + Workstation

> **Livro:** Capítulo 8 · Passos 3.1–3.2, 3.3, 3.7–3.8  
> **Último teste:** 2026-07-04 (roteiro atualizado — revalidar em hardware)  
> **Software:** VirtualBox 7.2 · Whonix 18.x LXQt · host com 16 GB RAM  

---

## Objetivo

Instalar o VirtualBox de fonte verificada, importar e operar o par **Whonix-Gateway + Whonix-Workstation**, confirmar Tor, trocar senhas padrão e preparar pasta compartilhada para PSBT.

---

## Pré-requisitos

- [ ] **Nível 2** concluído (Tails + Sparrow watch-only + PSBT)
- [ ] Host com **16 GB RAM** (mínimo 8 GB apertado)
- [ ] ~50 GB disco livre (Workstation + snapshots)
- [ ] Virtualização habilitada na BIOS/UEFI (VT-x / AMD-V)
- [ ] Tor Browser no host para baixar o `.ova` (recomendado)

---

## Passo 1 — VirtualBox no host

> 🔴 **Nunca instale VirtualBox de PPAs ou mirrors.** Use só `virtualbox.org` / `download.virtualbox.org`.

### Linux (Debian amd64) — manual ou script

**Manual (resumo):**

1. Instale headers, DKMS e build tools: `linux-headers-$(uname -r)`, `dkms`, `build-essential`
2. Importe a chave Oracle: `https://www.virtualbox.org/download/oracle_vbox_2016.asc`
3. Verifique fingerprint **obrigatório:** `B9F8 D658 297A F3EF C18D 5CDF A2F6 83C5 2980 AECF`
4. Configure o repo oficial e confirme `apt update` **sem** `NO_PUBKEY` / `BADSIG`
5. Instale `virtualbox-7.2` (revalide a série em [Linux Downloads](https://www.virtualbox.org/wiki/Linux_Downloads))
6. Adicione seu usuário ao grupo `vboxusers` e faça logout/login

**Automação (Debian):** [`../scripts/whonix/gs-whonix-install-virtualbox.sh`](../scripts/whonix/gs-whonix-install-virtualbox.sh)

```bash
cd laboratorio/scripts/whonix
chmod +x gs-whonix-install-virtualbox.sh
sudo ./gs-whonix-install-virtualbox.sh -e -y   # -e = Extension Pack (pastas compartilhadas)
```

Log: `/var/log/virtualbox-install.log`

### Windows / macOS

1. Baixe o instalador em https://www.virtualbox.org/wiki/Downloads
2. Instale o **Extension Pack** da **mesma versão** (necessário para pasta compartilhada PSBT)
3. Conceitos úteis:
   - **NAT:** VM acessa internet via host
   - **Rede interna:** VMs conversam; Workstation não expõe IP real
   - **Snapshot:** foto da VM antes de operações críticas

> Se Secure Boot (Linux) bloquear módulos `vboxdrv`, desabilite na UEFI ou assine via MOK.

---

## Passo 2 — Baixar imagens Whonix

Baixe **somente** de https://www.whonix.org/wiki/Download:

| Arquivo | Nota |
| --- | --- |
| `Whonix-LXQt-<versão>.Intel_AMD64.ova` | Variante com GUI atual (**LXQt**). Xfce foi descontinuada. |
| `.ova.asc` (ou `.sig`) | Assinatura do mesmo download |
| `derivative.asc` | Chave de assinatura — https://www.whonix.org/keys/derivative.asc |

Revalide nomes e versão em https://www.whonix.org/wiki/VirtualBox antes de cada uso.

---

## Passo 3 — Verificar assinatura (OBRIGATÓRIO)

**Não use keyserver como atalho.** Fingerprint e procedimento oficiais:

https://www.whonix.org/wiki/Verify_the_images

```bash
# Baixe derivative.asc conforme a wiki oficial
gpg --import derivative.asc

# Confira o fingerprint publicado NA PÁGINA OFICIAL (pode rotacionar)
gpg --keyid-format long --fingerprint <FINGERPRINT_DA_PÁGINA>

gpg --verify Whonix-LXQt-*.ova.asc Whonix-LXQt-*.ova
# Esperado: Good signature from "Patrick Schleizer ..."
```

> 🔴 **`BAD signature` ou fingerprint divergente → PARE.** Apague o `.ova` e baixe de novo.

**Automação (host Linux/macOS/Windows com VBoxManage no PATH):**

[`../scripts/whonix/gs-whonix-import-ova.sh`](../scripts/whonix/gs-whonix-import-ova.sh)

```bash
chmod +x gs-whonix-import-ova.sh

sudo ./gs-whonix-import-ova.sh \
     -i /caminho/Whonix-LXQt-VERSAO.Intel_AMD64.ova \
     -s /caminho/Whonix-LXQt-VERSAO.Intel_AMD64.ova.asc \
     -k /caminho/derivative.asc \
     -f "FINGERPRINT_CONFERIDO_NA_PAGINA_OFICIAL" \
     -t lxqt
```

| Flag | Função |
| --- | --- |
| `-f` | Fingerprint **obrigatório** (sempre da wiki no momento do download) |
| `-b` | Inicia Gateway e Workstation após import |
| `-t lxqt\|cli` | Variante esperada |
| `-y` | Modo não-interativo |

Log: `/var/log/whonix-install.log`

Checklist PGP unificado: [`03-verificacao-pgp-downloads.md`](03-verificacao-pgp-downloads.md)

---

## Passo 4 — Importar appliances (se não usou o script)

1. VirtualBox → **File → Import Appliance** → selecione o `.ova`
2. Duas VMs aparecem: `Whonix-Gateway` e `Whonix-Workstation`
3. Ajuste RAM se necessário (Gateway ~512 MB–1 GB; Workstation 4–6 GB)

---

## Passo 5 — Primeiro boot (ordem obrigatória)

```
1. Iniciar Whonix-Gateway
2. Anon Connection Wizard → aguardar Tor conectado (~30–90 s)
3. Só então iniciar Whonix-Workstation
4. Login: user `user` / senha `changeme` (trocar imediatamente)
```

Na **Workstation**, confirme Tor:

```bash
# Copie gs-verificar-tor.sh para a VM ou rode os comandos manualmente:
./gs-verificar-tor.sh

# Equivalente manual:
curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org | grep -i congratulations
passwd   # trocar changeme
```

Repita `passwd` na **Gateway** também.

Script: [`../scripts/whonix/gs-verificar-tor.sh`](../scripts/whonix/gs-verificar-tor.sh)

---

## Passo 6 — Ferramentas básicas na Workstation

```bash
sudo apt update && sudo apt full-upgrade
sudo apt install -y keepassxc
mkdir -p ~/apps
```

| Ferramenta | Lab / nota |
| --- | --- |
| Sparrow | Mesmo fluxo PGP do Apêndice D → `~/apps/` |
| KeePassXC | `whonix_crypto.kdbx` — senhas, .onions, metadados (**nunca** seed) |
| Feather / eigenwallet | Labs Nível 5 |

---

## Passo 7 — Pasta compartilhada PSBT (`psbt_bridge`)

No **host**:

```text
Criar pasta: C:\psbt_bridge  (ou /home/user/psbt_bridge no Linux)
```

VirtualBox → **Whonix-Workstation → Settings → Shared Folders**:

- Folder path: pasta do host
- Mount point: `psbt_bridge`
- Auto-mount + Make Permanent

Na Workstation (após reiniciar VM ou montar manualmente):

```bash
sudo mount -t vboxsf psbt_bridge /mnt/psbt_bridge
touch /mnt/psbt_bridge/teste.txt
# Verificar no host que o arquivo apareceu
```

**Fluxo PSBT:** Sparrow grava PSBT → `/mnt/psbt_bridge/` → MicroSD → dispositivo air-gapped → assinado de volta.

---

## Passo 8 — Risco do host OS

Whonix protege **dentro** das VMs. Se o host estiver comprometido (keylogger, malware), metadados podem vazar.

Mitigações:

- Host limpo e atualizado
- Chaves privadas **só** no dispositivo air-gapped (Coldcard assina offline)
- Evolução futura: Qubes + Whonix (Nível 7)

---

## Como confirmar que deu certo

- [ ] VirtualBox instalado de fonte verificada (Linux) ou site oficial (Windows)
- [ ] Assinatura Whonix: **Good signature** antes do import
- [ ] Gateway Tor verde antes da Workstation
- [ ] `gs-verificar-tor.sh` ou curl → Congratulations
- [ ] Senha `changeme` alterada em ambas VMs
- [ ] KeePassXC abre e salva `.kdbx` na Workstation
- [ ] Arquivo de teste visível em `/mnt/psbt_bridge/`
- [ ] Snapshot da Workstation criado (`pre_setup_YYYY-MM-DD`)

---

## Próximo lab

- Node + EPS: [`02-bitcoin-node-eps-onion.md`](02-bitcoin-node-eps-onion.md)
- PGP unificado: [`03-verificacao-pgp-downloads.md`](03-verificacao-pgp-downloads.md)

---

## Referências

- Livro: `manuscrito/08-nivel-3-observador.md`
- https://www.whonix.org/wiki/VirtualBox
- https://www.whonix.org/wiki/Verify_the_images
- Scripts: [`laboratorio/scripts/whonix/`](../scripts/whonix/)
