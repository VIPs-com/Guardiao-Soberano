# Sparrow — carteira watching-only (xpub)

> **Livro:** Capítulo 7 · Passos 2.2–2.5  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em Tails real)  
> **Software:** Tails 7.9 · Sparrow 2.5.2 · Craig Raw GPG `D4D0D320…4C674B40`  

---

## Objetivo

Instalar o **Sparrow** na persistência do Tails, importar a **xpub** do dispositivo air-gapped e criar uma carteira **watching-only** — monitorar saldo e receber BTC sem a seed tocar o computador.

> Envio (PSBT): lab [`02-primeiro-psbt.md`](02-primeiro-psbt.md).

---

## Pré-requisitos

- [ ] **Nível 1** concluído — dispositivo air-gapped inicializado (Cap. 6)
- [ ] Lab [`05-tails-setup-btc-xmr-completo.md`](05-tails-setup-btc-xmr-completo.md) — Tails + persistência + Tor
- [ ] Lab [`03-keepassxc-tails.md`](03-keepassxc-tails.md) — registrar xpub/fingerprint no cofre
- [ ] MicroSD limpo (ou QR) para exportar wallet do HW — **nunca** usar SD que já guardou seed em texto

---

## Passo 1 — Instalar Sparrow na persistência

Confira versão em [sparrowwallet.com/download](https://sparrowwallet.com/download/). Jun/2026: **2.5.2**.

```bash
VERSION=2.5.2
APPS=/home/amnesia/Persistent/apps/sparrow
DATA=/home/amnesia/Persistent/sparrow-data
mkdir -p "$APPS" "$DATA"

cd /home/amnesia/Persistent/Apps 2>/dev/null || mkdir -p /home/amnesia/Persistent/Apps && cd /home/amnesia/Persistent/Apps

torsocks wget \
  "https://github.com/sparrowwallet/sparrow/releases/download/${VERSION}/sparrow-${VERSION}-x86_64.tar.gz" \
  "https://github.com/sparrowwallet/sparrow/releases/download/${VERSION}/sparrow-${VERSION}-x86_64.tar.gz.asc"
```

Verificar assinatura **Craig Raw**:

```bash
gpg --keyserver hkps://keys.openpgp.org --recv-keys D4D0D3202FC06849A257B38DE94618334C674B40

gpg --verify "sparrow-${VERSION}-x86_64.tar.gz.asc" "sparrow-${VERSION}-x86_64.tar.gz"
```

Extrair e testar:

```bash
tar -xf "sparrow-${VERSION}-x86_64.tar.gz" -C /home/amnesia/Persistent/apps/sparrow
/home/amnesia/Persistent/apps/sparrow/bin/Sparrow -d /home/amnesia/Persistent/sparrow-data
```

**Alternativa Tails:** `scurl-download` (wrapper com verificação HTTPS via Tor).

### Script de inicialização

Copie `laboratorio/scripts/tails/start-sparrow.sh` para `~/Persistent/start-sparrow.sh` ou use o conteúdo do repositório.

```bash
chmod +x /home/amnesia/Persistent/start-sparrow.sh
/home/amnesia/Persistent/start-sparrow.sh
```

---

## Passo 2 — Exportar xpub no dispositivo air-gapped

O arquivo exportado contém **somente chave pública** — seguro no Tails com Tor.

| Dispositivo | Caminho típico |
| --- | --- |
| **Coldcard** | Advanced/Tools → Export Wallet → **Sparrow Wallet** → grava `sparrow-coldcard.json` no SD |
| **SeedSigner** | Seeds → [sua seed] → Export Xpub → QR animado (UR) na tela |
| **Krux** | Wallet → Export → Sparrow / xpub → QR ou arquivo |
| **Jade** | Export xpub via app Blockstream (modo air-gap conforme doc) |

**Regras:**

- Exporte **offline** no dispositivo
- Transfira SD ou QR para o Tails — nunca abra o JSON em PC com internet fora do Tails
- Anote fingerprint da xpub no KeePassXC

### SeedSigner via QR (sem SD)

1. SeedSigner: Export Xpub → Native Segwit (P2WPKH) ou Taproot (P2TR)
2. Sparrow: **File → New Wallet** → nome → **Airgapped Hardware Wallet** → **SeedSigner** → **Scan QR**
3. Aponte webcam para a tela do SeedSigner até importar

---

## Passo 3 — Criar carteira watching-only (arquivo JSON)

1. **File → New Wallet**
2. Nome: `Minha_Carteira_Fria` (exemplo)
3. **Airgapped Hardware Wallet** → **Import File** → selecione `sparrow-coldcard.json` (ou equivalente)
4. **Apply**

### Verificações obrigatórias

| Aba | O que deve aparecer |
| --- | --- |
| **Signing** | **Vazia** — sem chave privada, sem botão de assinar local |
| **Addresses** | Lista de endereços derivados da xpub |
| **Transactions** | Vazia (antes do primeiro receive) |

Se a aba Signing mostrar chave privada, **pare** — você importou seed por engano.

---

## Passo 4 — Conectar servidor via Tor

**File → Preferences → Server**

| Campo | Valor |
| --- | --- |
| Type | Private Electrum (ou servidor público só para teste inicial) |
| URL | `seu-servidor.onion:50002` (preferido) |
| Use SSL | ✓ |
| Proxy | `127.0.0.1:9050` (SOCKS5) |

> Servidores Electrum clearnet correlacionam seus endereços. Prefira `.onion` próprio (Nível 3) ou lista auditada.

**Test Connection** → OK.

---

## Passo 5 — Verificar endereço de recebimento (opcional, recomendado)

1. Sparrow → **Receive** → copie endereço ou clique **Verify Address** (QR)
2. No dispositivo air-gapped: **Verify address** → escaneie o QR do Sparrow
3. Dispositivo confirma **Verified** — só então use o endereço

> Nunca confie só no monitor do Tails para endereço de recebimento alto.

---

## Passo 6 — Receber primeiro BTC (teste)

1. **Receive** → primeiro endereço não usado
2. Envie quantia pequena (~R$ 50–100 em sats):
   - RoboSats, conhecido, ou UTXO já soberano
   - **Evite** exchange KYC para este teste
3. Aguarde **1 confirmação** (~10 min)
4. Aba **Transactions** deve mostrar a entrada

Registre no KeePassXC: TXID, data, endereço usado.

---

## Como confirmar que deu certo

- [ ] `gpg --verify` do Sparrow passou antes da instalação
- [ ] Após reboot, `start-sparrow.sh` abre a mesma carteira
- [ ] Aba **Signing** permanece vazia
- [ ] Saldo de teste visível após 1+ confirmação
- [ ] Servidor conectado via proxy Tor (sem erro na barra de status)
- [ ] Você consegue explicar: *computador vê, dispositivo assina* (PSBT no lab 02)

---

## Se der errado

| Problema | Ação |
| --- | --- |
| Sparrow não conecta | Verifique Tor; teste `curl --socks5-hostname 127.0.0.1:9050 check.torproject.org/api/ip` |
| Endereços não batem com HW | Refaça export (mesmo script type: segwit vs taproot) |
| Importou seed por engano | Apague wallet no Sparrow; nunca digite seed no Tails |
| JSON não abre | Confirme export "Sparrow Wallet", não "Electrum" |

Livro: **Apêndice F** · Cap. 6 (fluxo PSBT QR)

---

## Matriz de dispositivos (export xpub)

| HW | Método | Arquivo / QR |
| --- | --- | --- |
| Coldcard MK5 | SD | `sparrow-coldcard.json` |
| SeedSigner | QR UR | Scan no Sparrow |
| Krux | QR / SD | Conforme menu Krux |
| Jade Plus | QR | App + Sparrow watch-only |

---

## Próximo lab

- [`02-primeiro-psbt.md`](02-primeiro-psbt.md) — Send → assinar no HW → Broadcast  
- [`04-electrum-tails.md`](04-electrum-tails.md) — alternativa leve ao Sparrow  

---

## Referências oficiais

- [Sparrow Wallet — Download](https://sparrowwallet.com/download/)
- [Sparrow — Documentation](https://sparrowwallet.com/docs/)
- Livro: `manuscrito/D-guia-verificacao-pgp.md` (Craig Raw)
- Livro: `manuscrito/06-nivel-1-cofre.md` (fluxo PSBT QR)

---

*Extraído de `manuscrito/07-nivel-2-carteira-fria.md` (passos 2.2–2.5) e `05-tails-setup`.*
