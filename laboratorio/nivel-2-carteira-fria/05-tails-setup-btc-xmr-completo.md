# Tails — Setup completo BTC + XMR (ambiente base)

> **Livro:** Capítulo 7 (Nível 2) · Passos 2.1–2.4 e seções KeePassXC/Electrum  
> **Último teste:** 2026-06-25 (estrutura recuperada — aguarda revalidação em hardware)  
> **Software:** Tails 7.9 · Sparrow 2.5.2 · Feather 2.8.1 · eigenwallet · RetoSwap  

---

## Objetivo

Montar o **ambiente Tails** como fortaleza amnésica: persistência cifrada, Tor confirmado, cofre KeePassXC e mapa do que roda onde (BTC, XMR, swaps, RoboSats). Ao terminar, você boota no Tails com Persistent Storage desbloqueado e sabe qual app usar para cada função.

---

## Visão geral — o que roda onde

| Função | App | Onde ficam os dados |
| --- | --- | --- |
| BTC (coordinator) | Sparrow (watching-only) | `~/Persistent/sparrow-data` |
| BTC (rápido) | Electrum (pré-instalado) | `~/.electrum` na persistência |
| XMR | Feather (AppImage) | `~/Persistent/feather-wallets/` |
| BTC→XMR | eigenwallet (AppImage) | estado em `~/.local/share/eigenwallet/` |
| XMR→BTC | RetoSwap (AppImage) | conforme doc RetoSwap |
| Lightning P2P | RoboSats (.onion no Tor Browser) | token por trade no KeePassXC |
| Segredos | KeePassXC | `~/Persistent/*.kdbx` |

**Hardware air-gapped** (Coldcard, SeedSigner, etc.) fica **fora** do Tails — comunicação via SD ou QR apenas.

```
[Coldcard offline] ⇄ SD/QR ⇄ [Tails: Sparrow + apps] → Tor → [Internet .onion]
```

---

## Pré-requisitos

- [ ] USB 16 GB+ para Tails (dedicado; não reutilizar pendrive suspeito)
- [ ] Host com 8 GB RAM mínimo (**16 GB recomendado**)
- [ ] Coldcard ou outro dispositivo air-gapped já inicializado (Nível 1)
- [ ] Acesso a `tails.net` via Tor Browser no host (para download inicial)

---

## Passo 1 — Baixar e verificar o Tails

1. No **host**, abra Tor Browser e acesse [https://tails.net/install/](https://tails.net/install/).
2. Baixe a imagem `.img` e o arquivo `.sig`.
3. Verifique a assinatura OpenPGP (**obrigatório**):

```bash
wget https://tails.net/tails-signing.key
gpg --import tails-signing.key
gpg --verify tails-amd64-*.img.sig tails-amd64-*.img
```

Resultado esperado: `Good signature from "Tails developers..."`

4. Grave no USB com [balenaEtcher](https://etcher.balancer.io/) ou `dd` (cuidado com o dispositivo correto).

---

## Passo 2 — Criar Persistent Storage

1. Boot no Tails pelo USB.
2. **Applications → Tails → Persistent Storage → Enable**.
3. Senha forte (20+ caracteres ou frase longa).
4. Ative:

| Opção | Para quê |
| --- | --- |
| Personal Data | `~/Persistent/` — arquivos gerais |
| GnuPG | chaves GPG sobrevivem ao reboot |
| Bitcoin Client | carteira Electrum persiste |
| Additional Software | apps instalados persistem |
| Dotfiles | configs (Sparrow, atalhos) |

5. **Reinicie** e desbloqueie a persistência no boot.

---

## Passo 3 — Confirmar Tor a cada sessão

Antes de qualquer operação com cripto:

**Tor Browser:** acesse [https://check.torproject.org](https://check.torproject.org)

**Terminal:**

```bash
curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org/api/ip
```

Deve retornar JSON com `"IsTor": true`.

---

## Passo 4 — KeePassXC (primeiro app)

1. Abra **KeePassXC** (pré-instalado).
2. Crie banco em `~/Persistent/guardiao.kdbx` com senha forte.
3. Registre **antes** de abrir qualquer wallet:

- PIN do dispositivo air-gapped (e duress, se houver)
- Passphrase BIP39 (25ª palavra), se usada
- xpub / fingerprint da carteira BTC
- Subendereços XMR usados (com data)
- SHA-256 dos AppImages verificados
- Tokens RoboSats (um por trade)

> Aprofundamento no livro: `manuscrito/07-nivel-2-carteira-fria.md` → seção KeePassXC.

---

## Passo 5 — Instalar Sparrow (persistente)

```bash
# Via Tor Browser: https://sparrowwallet.com/download/
# Verificar assinatura Craig Raw (ver Apêndice D do livro)

mkdir -p ~/Persistent/apps/sparrow ~/Persistent/sparrow-data
tar -xf sparrow-*.tar.gz -C ~/Persistent/apps/sparrow

~/Persistent/apps/sparrow/bin/Sparrow -d ~/Persistent/sparrow-data
```

**Watching-only:** ver lab dedicado [`01-sparrow-watching-only.md`](01-sparrow-watching-only.md).

---

## Passo 6 — Feather Wallet (XMR)

```bash
# https://featherwallet.org — baixar AppImage + .asc
gpg --verify feather-*.AppImage.asc feather-*.AppImage

mkdir -p ~/Persistent/apps ~/Persistent/feather-wallets
cp feather-*.AppImage ~/Persistent/apps/feather.AppImage
chmod +x ~/Persistent/apps/feather.AppImage
```

Na interface:

- New Wallet → Polyseed (16 palavras) — backup em metal
- Settings → Network → **Always over Tor**
- Wallet data: `~/Persistent/feather-wallets/`
- Cada operação: **Receive → New address** (subendereço novo)

> Feather **não** recebe atualizações automáticas no Tails — verificar mensalmente.

---

## Passo 7 — eigenwallet e RetoSwap (visão)

| Direção | Ferramenta | Lab futuro |
| --- | --- | --- |
| BTC → XMR | eigenwallet | `nivel-5-trocador/01-eigenwallet-whonix-btc-xmr.md` (Whonix) ou expansão Tails |
| XMR → BTC | RetoSwap | `nivel-5-trocador/03-retoswap-xmr-btc.md` |

**Regra crítica (ABCTracer):** após receber XMR, **feche o Tails e aguarde horas ou dias** antes de trocar de volta para BTC. Nunca swap imediato.

---

## Passo 8 — RoboSats (sem instalação)

1. Tor Browser → URL `.onion` oficial (consulte [github.com/RoboSats/robosats](https://github.com/RoboSats/robosats)).
2. **Não** use clearnet para operações reais.
3. Gere Robot → salve token no KeePassXC (um robot = um trade).

---

## Como confirmar que deu certo

- [ ] `check.torproject.org` mostra conexão Tor
- [ ] `~/Persistent/` existe e sobrevive ao reboot
- [ ] KeePassXC abre o `.kdbx` após reiniciar
- [ ] Sparrow mostra saldo watching-only (xpub importada)
- [ ] Feather sincroniza com Tor (blocos avançando)
- [ ] Nenhuma seed de **assinatura** foi digitada no Tails (apenas xpub / endereços)

---

## Se der errado

- Livro: **Apêndice F** — Troubleshooting  
- Persistência não monta: senha errada ou USB corrompido — ver docs Tails  
- RAM insuficiente: feche apps não usados; host 16 GB recomendado  

---

## Próximos labs

| Lab | Arquivo |
| --- | --- |
| KeePassXC + Electrum aprofundado | `03-keepassxc-tails.md`, `04-electrum-tails.md` |
| Primeiro PSBT | `02-primeiro-psbt.md` |
| Swap completo | `nivel-5-trocador/` |

---

## Referências oficiais

- [Tails — Persistent Storage](https://tails.net/doc/persistent_storage/)
- [Sparrow Wallet](https://sparrowwallet.com/docs/)
- [Feather Wallet](https://featherwallet.org/docs/)
- [eigenwallet](https://github.com/eigenwallet/eigenwallet)
- [RetoSwap / Haveno Reto](https://github.com/retoaccess1/haveno-reto)

---

*Recuperado e reformatado a partir da pesquisa `tails-setup-btc-xmr-completo` — backup `old/manuscrito-backups/backup-pre-complemento-20260624-1726/`.*
