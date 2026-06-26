# Whonix no VirtualBox — Gateway + Workstation

> **Livro:** Capítulo 8 · Passos 3.1–3.2, 3.3, 3.7–3.8  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** VirtualBox 7.x · Whonix 17+ · host com 16 GB RAM  

---

## Objetivo

Importar e operar o par **Whonix-Gateway + Whonix-Workstation** no VirtualBox, verificar Tor, trocar senhas padrão e preparar pasta compartilhada para PSBT.

---

## Pré-requisitos

- [ ] **Nível 2** concluído (Tails + Sparrow watch-only + PSBT)
- [ ] Host com **16 GB RAM** (mínimo 8 GB apertado)
- [ ] ~50 GB disco livre (Workstation + snapshots)
- [ ] Tor Browser no host para baixar o `.ova` (recomendado)

---

## Passo 1 — VirtualBox no host

1. Baixe VirtualBox em https://www.virtualbox.org/ (ou use KVM no Linux avançado — fora deste lab)
2. Instale extensão pack se precisar de USB 3.0 / pastas compartilhadas
3. Conceitos úteis:
   - **NAT:** VM acessa internet via host
   - **Rede interna:** VMs conversam sem expor IP real à Workstation
   - **Snapshot:** foto da VM antes de operações críticas

---

## Passo 2 — Baixar e verificar Whonix

```bash
# Via Tor Browser: whonix.org → Download → VirtualBox .ova + .asc
# Apêndice D — Patrick Schleizer:
gpg --keyserver hkps://keys.openpgp.org --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
gpg --fingerprint 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
gpg --verify Whonix*.asc Whonix*.ova
```

---

## Passo 3 — Importar appliances

1. VirtualBox → **File → Import Appliance** → selecione o `.ova`
2. Duas VMs aparecem:
   - `Whonix-Gateway`
   - `Whonix-Workstation`
3. Ajuste RAM se necessário (Gateway ~512 MB–1 GB; Workstation 4–6 GB)

---

## Passo 4 — Primeiro boot (ordem obrigatória)

```
1. Iniciar Whonix-Gateway
2. Aguardar ícone Tor VERDE na bandeja (~30–90 s)
3. Só então iniciar Whonix-Workstation
4. Login: user `user` / senha `changeme` (trocar imediatamente)
```

Na **Workstation**:

```bash
curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org | grep -i congratulations
passwd   # trocar changeme
```

Repita `passwd` na **Gateway** também.

---

## Passo 5 — Ferramentas básicas na Workstation

```bash
sudo apt update && sudo apt install -y keepassxc
mkdir -p ~/apps
```

| Ferramenta | Lab / nota |
| --- | --- |
| Sparrow | Mesmo fluxo PGP do Apêndice D → `~/apps/` |
| KeePassXC | `whonix_crypto.kdbx` — senhas, .onions, metadados (**nunca** seed) |
| Feather / eigenwallet | Labs Nível 5 |

---

## Passo 6 — Pasta compartilhada PSBT (`psbt_bridge`)

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

## Passo 7 — Risco do host OS

Whonix protege **dentro** das VMs. Se o host estiver comprometido (keylogger, malware), metadados podem vazar.

Mitigações:

- Host limpo e atualizado
- Chaves privadas **só** no dispositivo air-gapped (Coldcard assina offline)
- Evolução futura: Qubes + Whonix (Nível 7)

---

## Como confirmar que deu certo

- [ ] Gateway Tor verde antes da Workstation
- [ ] `check.torproject.org` via curl na Workstation → Congratulations
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
