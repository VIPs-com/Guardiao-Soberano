# Feather Wallet no Tails — instalação e persistência

> **Livro:** Capítulo 10 · Passo 5.2 · Apêndice D (PGP)  
> **Último teste:** 2026-06-25 (conteúdo extraído — revalidar em hardware)  
> **Software:** Tails 7.9 · Feather 2.8.1  

---

## Objetivo

Instalar a Feather como AppImage na persistência do Tails, verificar a assinatura PGP, forçar `--datadir` persistente e criar carteira XMR com **restore height** anotado.

---

## Pré-requisitos

- [ ] Tails com persistência desbloqueada (**Personal Data** ativado)
- [ ] Lab [`../nivel-2-carteira-fria/03-keepassxc-tails.md`](../nivel-2-carteira-fria/03-keepassxc-tails.md) — cofre `.kdbx` para anotar seed XMR e restore height
- [ ] Tor funcionando (`check.torproject.org`)

---

## Passo 1 — Estrutura de pastas

```bash
mkdir -p /home/amnesia/Persistent/Apps
mkdir -p /home/amnesia/Persistent/feather-data
```

---

## Passo 2 — Baixar AppImage e assinatura

Use o **Tor Browser** em https://featherwallet.org/download/ ou o terminal:

```bash
VERSION=2.8.1
APPS=/home/amnesia/Persistent/Apps

torsocks wget -P "${APPS}" \
  "https://featherwallet.org/files/releases/linux/feather-${VERSION}-x86_64.AppImage" \
  "https://featherwallet.org/files/releases/linux/feather-${VERSION}-x86_64.AppImage.asc"
```

> Confira a versão atual no site antes de fixar `VERSION`.

---

## Passo 3 — Verificar PGP (obrigatório)

Importe a chave de release e confira a fingerprint em **duas fontes** (site + GitHub/docs):

```bash
# Fonte 1: keyserver (fingerprint oficial)
gpg --keyserver hkps://keys.openpgp.org --recv-keys 8185E158A33330C7FD61BC0D1F76E155CEFBA71C
gpg --fingerprint 8185E158A33330C7FD61BC0D1F76E155CEFBA71C
# Esperado: 8185 E158 A333 30C7 FD61 BC0D 1F76 E155 CEFB A71C

# Verificar o AppImage
gpg --verify /home/amnesia/Persistent/Apps/feather-${VERSION}-x86_64.AppImage.asc \
  /home/amnesia/Persistent/Apps/feather-${VERSION}-x86_64.AppImage
# Esperado: Good signature from "FeatherWallet <dev@featherwallet.org>"
```

Fontes cruzadas oficiais:

- https://docs.featherwallet.org/guides/release-signing-key  
- https://github.com/feather-wallet/feather  

**Não execute** o AppImage se a assinatura falhar.

```bash
chmod +x /home/amnesia/Persistent/Apps/feather-${VERSION}-x86_64.AppImage
```

Detalhes: livro **Apêndice D**.

---

## Passo 4 — Script de inicialização

Copie o script do repositório ou crie manualmente:

```bash
cp laboratorio/scripts/tails/start-feather.sh /home/amnesia/Persistent/start-feather.sh
chmod +x /home/amnesia/Persistent/start-feather.sh
```

O script usa:

- `--datadir /home/amnesia/Persistent/feather-data` — dados sobrevivem ao reboot  
- `--use-tor` — reforço além do Tor do Tails  

**Regra:** nunca abra a AppImage direto sem `--datadir` — `~/.config/feather` evapora no desligamento.

---

## Passo 5 — Primeira execução

```bash
/home/amnesia/Persistent/start-feather.sh
```

1. Rede: **Tor (recommended)** — proxy `127.0.0.1:9050`  
2. **Create new wallet** (ou restore se já tiver seed)  
3. Nome sugestivo: ex. `fortaleza_xmr`  
4. Na tela final, anote no KeePassXC:
   - **25 palavras** (seed Monero — **não** é BIP39 Bitcoin)
   - **Restore height** (ex. `3185000`) ou data `YYYYMMDD`  
5. Aguarde sincronização (minutos via nó remoto Tor)

---

## Passo 6 — Teste de sobrevivência

```bash
ls /home/amnesia/Persistent/feather-data/
```

Reinicie o Tails → desbloqueie persistência → `start-feather.sh` → carteira e histórico devem reaparecer.

---

## Passo 7 — Subendereço para swaps

Antes de cada operação (eigenwallet / RetoSwap):

1. Feather → **Receive** → **New address**  
2. Anote subendereço + timestamp no KeePassXC  
3. Nunca reutilize o mesmo subendereço em dois swaps  

Restore height aprofundado: livro **Cap. 10** (seção dedicada) · lab futuro `04-defesa-abctracer.md`.

---

## Integração com backup 3-2-1

Inclua `feather-data` no tarball de backup da persistência (sem colocar seed em texto claro no tar — use KeePassXC cifrado ou metal):

```bash
tar czf - /home/amnesia/Persistent/feather-data \
  /home/amnesia/Persistent/electrum-data \
  /home/amnesia/Persistent/fortaleza_cofre.kdbx \
| gpg --symmetric --cipher-algo AES256 \
  --output /media/amnesia/backup/fortaleza_$(date +%Y%m%d).tar.gz.gpg
```

---

## Como confirmar que deu certo

- [ ] `gpg --verify` → **Good signature**  
- [ ] `feather-data/` contém arquivos da carteira após criar wallet  
- [ ] Reinício do Tails mantém saldo e histórico  
- [ ] Settings → Network → tráfego via Tor  
- [ ] Restore height anotado no KeePassXC  
- [ ] Você consegue gerar subendereço novo para um swap de teste  

---

## Se der errado

| Problema | Solução |
| --- | --- |
| Carteira sumiu após reboot | Abriu AppImage sem `--datadir` — restaure com seed + restore height |
| Sync lenta na restauração | Restore height errado ou ausente — ajuste em Wallet → Information |
| BAD signature | Não execute — baixe de featherwallet.org via Tor |
| Polyseed vs 25 palavras | Feather pode usar Polyseed (16) ou seed clássica — rotule no KeePassXC |
| RAM baixa com Electrum aberto | Feche outros AppImages — 8 GB mínimo, 16 GB ideal |

Livro: **Apêndice F** · Cap. 10 passos 5.2 e 5.5  

---

## Próximo passo na trilha

- Swap BTC→XMR: livro Cap. 10 + lab futuro `01-eigenwallet-whonix-btc-xmr.md`  
- Setup Tails completo: [`../nivel-2-carteira-fria/05-tails-setup-btc-xmr-completo.md`](../nivel-2-carteira-fria/05-tails-setup-btc-xmr-completo.md) (visão geral — este lab é o detalhe Feather)

---

## Referências

- https://docs.featherwallet.org/guides/linux  
- https://docs.featherwallet.org/guides/release-signing-key  
- Livro: `manuscrito/D-guia-verificacao-pgp.md` (seção Feather)

---

*Extraído do complemento removido do Cap. 10 + Manual da Fortaleza. Conteúdo reescrito no template do laboratório.*
