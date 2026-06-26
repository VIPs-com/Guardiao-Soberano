# Bitcoin Node + EPS (.onion próprio)

> **Livro:** Capítulo 8 · Passos 3.5–3.6  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Bitcoin Core · Electrum Personal Server (EPS) · Debian VM  

---

## Objetivo

Rodar um nó Bitcoin (pruned ou full) com EPS expondo **seu** servidor Electrum via `.onion`, e conectar o Sparrow na Whonix-Workstation a esse endpoint — sem servidores públicos.

---

## Pré-requisitos

- [ ] Lab [`01-whonix-virtualbox-completo.md`](01-whonix-virtualbox-completo.md)
- [ ] xpub da carteira watching-only (Cap. 7)
- [ ] Disco: **~50 GB** (pruned) ou **~800 GB** (full)
- [ ] Paciência: sync inicial **2–7 dias** via Tor (ou acelerar conforme nota abaixo)

---

## Passo 1 — Criar VM Bitcoin-Node

VirtualBox → **New**:

| Campo | Valor sugerido |
| --- | --- |
| Nome | `Bitcoin-Node` |
| SO | Debian 12 minimal |
| RAM | 4 GB (pruned) / 8 GB (full) |
| Disco | 50 GB (pruned) / 800 GB (full) |
| Rede | **Internal Network** `Whonix` (mesma da Gateway) |

Instale Debian, atualize:

```bash
sudo apt update && sudo apt full-upgrade -y
```

---

## Passo 2 — Instalar Bitcoin Core

```bash
# Baixar de bitcoincore.org + verificar PGP (Apêndice D / site oficial)
# Exemplo após instalação:
bitcoin-cli -version
```

`bitcoin.conf` mínimo (Tor-only após sync):

```ini
# ~/.bitcoin/bitcoin.conf
server=1
txindex=0
prune=550
onlynet=onion
proxy=127.0.0.1:9050
listen=0
```

> **Nota sync:** muitos operadores sincronizam primeiro via clearnet/I2P em rede isolada, depois ativam `onlynet=onion`. Documente sua escolha no KeePassXC.

Inicie o daemon e aguarde `bitcoin-cli getblockchaininfo` → `verificationprogress` → 1.0.

---

## Passo 3 — Instalar EPS

```bash
sudo apt install -y git python3-pip
git clone https://github.com/chris-belcher/electrum-personal-server.git
cd electrum-personal-server
pip3 install --user .
```

Configure `config.ini` com sua **xpub** (watching-only):

```ini
[master-public-keys]
wallet = zpub6...   # sua xpub Sparrow/Coldcard

[bitcoin-rpc]
host = 127.0.0.1
port = 8332
# user/password em ~/.bitcoin/.cookie ou rpcauth

[watch-only-addresses]
# opcional — endereços avulsos

[electrum-server]
host = 127.0.0.1
port = 50002
```

Teste local:

```bash
electrum-personal-server --config config.ini
```

---

## Passo 4 — Hidden service Tor (.onion)

Na VM do node (Tor instalado ou via proxy da Gateway — arquitetura varia):

```bash
# /etc/tor/torrc (exemplo)
HiddenServiceDir /var/lib/tor/electrum_eps/
HiddenServicePort 50002 127.0.0.1:50002
```

```bash
sudo systemctl restart tor
sudo cat /var/lib/tor/electrum_eps/hostname
# anote: xxxxx.onion
```

Guarde o `.onion` no KeePassXC da Workstation.

---

## Passo 5 — Conectar Sparrow (Whonix-Workstation)

Sparrow → **Preferences → Server → Private Electrum**

| Campo | Valor |
| --- | --- |
| URL | `seu_eps.onion:50002` |
| Proxy | Tor automático no Whonix (`127.0.0.1:9050`) |

**Test Connection** → verde.

Console Sparrow (opcional): confirme que não está usando servidor público.

---

## Passo 6 — Stream isolation (revisão)

Cada app na Workstation deve usar circuito Tor separado quando possível (Cap. 8 · passo 3.4):

- Sparrow: Tor nativo
- Electrum: `--proxy socks5:127.0.0.1:9111` (porta dedicada)
- Feather: porta 9115 (exemplo do livro)

---

## Como confirmar que deu certo

- [ ] `bitcoin-cli getblockchaininfo` sincronizado
- [ ] EPS inicia sem erro com sua xpub
- [ ] Arquivo `hostname` gera `.onion` estável após restart Tor
- [ ] Sparrow conecta ao **seu** `.onion` (não servidor público)
- [ ] Receive de teste aparece no Sparrow após confirmação on-chain
- [ ] Nenhum servidor Electrum de terceiros nas preferências

---

## Se der errado

| Problema | Solução |
| --- | --- |
| Sparrow não conecta ao .onion | Tor na Workstation; porta 50002; firewall interno |
| EPS não vê transações | xpub errada; rescan; wallet não derivada igual ao HW |
| Sync eterno via Tor | Considerar bootstrap pruned + depois onlynet=onion |
| VM sem rede | Internal Network ligada à Gateway |

Livro: **Apêndice F** · Cap. 8 aprofundamento

---

## Referências

- https://github.com/chris-belcher/electrum-personal-server
- Livro: `manuscrito/08-nivel-3-observador.md` (passos 3.5–3.6)
- Apêndice B: lista de .onion de referência (EPS **próprio** é o padrão deste lab)
