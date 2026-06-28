# Apêndice D — Guia de Verificação PGP

## O que é PGP

PGP (Pretty Good Privacy) é um sistema de criptografia que permite verificar a autenticidade e integridade de arquivos.

Quando um desenvolvedor assina um arquivo com sua chave PGP, ele prova que foi realmente ele quem publicou aquele arquivo — e que o arquivo não foi adulterado.

## Verificar um arquivo (passo a passo)

    # 1. Importar a chave pública do desenvolvedor
    curl https://exemplo.com/chave.asc | gpg --import

    # 2. Verificar a impressão digital (fingerprint)
    gpg --fingerprint "Nome do Dev"

    # 3. Comparar a fingerprint com a publicada em:
    #    - Site oficial
    #    - Twitter/X oficial
    #    - GitHub
    #    - Matrix/SimpleX

    # 4. Baixar o arquivo E a assinatura
    scurl-download https://exemplo.com/arquivo.AppImage
    scurl-download https://exemplo.com/arquivo.AppImage.asc

    # 5. Verificar
    gpg --verify arquivo.AppImage.asc arquivo.AppImage

    # 6. Saída esperada:
    # gpg: Good signature from "Nome do Dev"

## Principais chaves PGP

| Projeto | Desenvolvedor | Fingerprint |
| --- | --- | --- |
| Sparrow Wallet | Craig Raw | `D4D0D3202FC06849A257B38DE94618334C674B40` |
| Specter Desktop | Specter Signer | `785A2269EE3A9736AC1A4F4C864B7CF9A811FEF7` |
| Electrum | ThomasV (Thomas Voegtlin) | `6694D8DE7BE8EE5631BED9502BD5824B7F9470E6` |
| Whonix | Patrick Schleizer | `916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA` |
| Tails | Tails Project | `A490D0F4D311A4153E2BB7CADBB802B258ACD84F` |
| Feather (Monero) | Feather Wallet | `8185E158A33330C7FD61BC0D1F76E155CEFBA71C` |
| eigenwallet | binarybaron | Assinaturas `.asc` nas releases |
| Coldcard | Coinkite | Ver site oficial (firmware) |
| SeedSigner | SeedSigner | Assinaturas `.asc` nas releases |

**Fontes oficiais para conferir fingerprints:**

- Sparrow: sparrowwallet.com/download/
- Specter Desktop: specter.solutions/downloads
- Electrum: electrum.org/#download · github.com/spesmilo/electrum/blob/master/pubkeys/ThomasV.asc
- Whonix: whonix.org/wiki/Signing_Key
- Tails: tails.net/doc/about/openpgp_keys/
- Feather: docs.featherwallet.org/guides/release-signing-key
- eigenwallet: github.com/eigenwallet/core/releases
- Coldcard: coldcard.com/docs/upgrade
- SeedSigner: github.com/SeedSigner/seedsigner/releases

> **AVISO:** SEMPRE compare a fingerprint com **pelo menos duas fontes independentes** antes de importar.

## Por que a verificação PGP importa

Imagine que você baixa um software de um site que parece idêntico ao oficial — mesmo layout, mesmo nome de domínio com uma letra diferente, mesmo arquivo `.AppImage`. Você executa. O software parece funcionar normalmente. Mas enquanto você digita sua seed para importar na carteira, o software a captura e envia para um servidor remoto.

Isso não é ficção científica. É um vetor de ataque real chamado **supply chain attack** (ataque à cadeia de suprimentos), que já afetou usuários de várias ferramentas cripto.

A verificação PGP resolve esse problema: mesmo que um atacante substitua o arquivo em um servidor comprometido, ele não tem acesso à chave privada do desenvolvedor para assinar o arquivo malicioso. A assinatura não confere. Você percebe antes de executar.

**O processo completo — sem atalhos:**

```bash
# Passo 1: baixe o arquivo e a assinatura separadamente
# Nunca use o mesmo link para ambos — se o servidor estiver
# comprometido, ele pode fornecer assinatura falsa para arquivo falso.

# Passo 2: importe a chave pública do desenvolvedor
gpg --keyserver hkps://keys.openpgp.org --recv-keys FINGERPRINT_AQUI

# Passo 3: verifique a fingerprint ANTES de usar a chave
gpg --fingerprint FINGERPRINT_AQUI
# Compare o resultado com pelo menos DUAS fontes:
# - Site oficial do projeto
# - Repositório GitHub oficial
# - Canal de comunicação verificado do desenvolvedor

# Passo 4: verifique a assinatura do arquivo
gpg --verify arquivo.AppImage.asc arquivo.AppImage

# Saída esperada (procure por "Good signature"):
# gpg: Good signature from "Nome do Desenvolvedor <email>"
# gpg: WARNING: This key is not certified with a trusted signature!
# (O aviso é normal se você não assinou a chave —
# o que importa é "Good signature")

# Saída de ALERTA (não execute o arquivo):
# gpg: BAD signature from ...
```

**O aviso "key not certified"** aparece quando você importou a chave mas não a assinou como "confiável" no seu keyring. Isso é esperado e não é problema — o que importa é "Good signature", que confirma que o arquivo foi assinado pela chave correta.

**O erro "BAD signature"** significa que o arquivo foi modificado após a assinatura. Não execute. Reporte ao projeto.

## Verificação de hash SHA256 (alternativa rápida)

Quando o projeto distribui apenas um arquivo de hash (sem assinatura PGP), você pode verificar a integridade — mas não a autenticidade:

```bash
# Compare o hash do arquivo baixado com o publicado pelo projeto
sha256sum arquivo.AppImage
# Copie a saída e compare com o hash no site oficial
```

O hash verifica que o arquivo não foi corrompido durante o download. Mas não prova que o arquivo publicado é legítimo — um site comprometido pode publicar um arquivo malicioso com seu hash correto. Por isso, quando disponível, prefira sempre a verificação PGP completa.

### Electrum 4.7.2 — download verificado (jun/2026)

Release atual: **4.7.2**. Assinado por ThomasV (Thomas Voegtlin) e outros 3 developers do core team (SomberNight, Emzy, felixb_f321x). Verificação pelo ThomasV é suficiente.

```bash
# Importar chave de ThomasV
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys 6694D8DE7BE8EE5631BED9502BD5824B7F9470E6

# Conferir fingerprint
gpg --fingerprint 6694D8DE7BE8EE5631BED9502BD5824B7F9470E6
# Esperado: 6694 D8DE 7BE8 EE56 31BE  D950 2BD5 824B 7F94 70E6
# Email: thomasv@electrum.org

# Baixar AppImage + assinatura (Tails — torsocks)
VERSION=4.7.2
torsocks wget -P /home/amnesia/Persistent/Apps/ \
  "https://download.electrum.org/${VERSION}/electrum-${VERSION}-x86_64.AppImage" \
  "https://download.electrum.org/${VERSION}/electrum-${VERSION}-x86_64.AppImage.asc"

# Verificar assinatura
gpg --verify \
  /home/amnesia/Persistent/Apps/electrum-${VERSION}-x86_64.AppImage.asc \
  /home/amnesia/Persistent/Apps/electrum-${VERSION}-x86_64.AppImage
# Esperado: Good signature from "Thomas Voegtlin (Thomas Voegtlin) <thomasv@electrum.org>"
```

> **Fontes cruzadas obrigatórias (conferir antes de usar):**
> - electrum.org/#download — fingerprint listado na página oficial
> - github.com/spesmilo/electrum/blob/master/pubkeys/ThomasV.asc — chave pública no repositório

### Sparrow Wallet 2.5.2 — download verificado (jun/2026)

Release atual: **2.5.2** (lançado 31/05/2026).

```bash
# Importar chave de Craig Raw
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys D4D0D3202FC06849A257B38DE94618334C674B40
gpg --fingerprint \
  D4D0D3202FC06849A257B38DE94618334C674B40
# Saída esperada: D4D0 D320 2FC0 6849 A257  B38D E946 1833 4C67 4B40

# Baixar e verificar (no Whonix com scurl):
SP_VER=2.5.2
SP_BASE="https://github.com/sparrowwallet/sparrow/releases/download"
SP_FILE="sparrow-${SP_VER}-x86_64"
scurl-download "${SP_BASE}/${SP_VER}/${SP_FILE}.tar.gz"
scurl-download "${SP_BASE}/${SP_VER}/${SP_FILE}.tar.gz.asc"
gpg --verify \
  sparrow-${SP_VER}-x86_64.tar.gz.asc \
  sparrow-${SP_VER}-x86_64.tar.gz
```

### Specter Desktop — download verificado (jun/2026)

Distribuição oficial: [specter.solutions/downloads](https://specter.solutions/downloads). Binários (GUI ou `specterd`) acompanham `SHA256SUMS` assinado pela chave **Specter Signer**.

```bash
# Importar chave Specter Signer
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys 785A2269EE3A9736AC1A4F4C864B7CF9A811FEF7
gpg --fingerprint \
  785A2269EE3A9736AC1A4F4C864B7CF9A811FEF7
# Saída esperada: 785A 2269 EE3A 9736 AC1A  4F4C 864B 7CF9 A811 FEF7

# Baixar release (Whonix — scurl-download; conferir versão na página)
# Exemplo genérico — ajuste VERSAO e ARQUIVO conforme a release atual:
scurl-download https://github.com/cryptoadvance/specter-desktop/releases/download/VERSAO/SHA256SUMS
scurl-download https://github.com/cryptoadvance/specter-desktop/releases/download/VERSAO/SHA256SUMS.asc
scurl-download https://github.com/cryptoadvance/specter-desktop/releases/download/VERSAO/ARQUIVO

# 1) Verificar assinatura do arquivo de hashes
gpg --verify SHA256SUMS.asc SHA256SUMS
# Esperado: Good signature from "Specter Signer" (ou nome equivalente)

# 2) Conferir hash do binário baixado
sha256sum -c SHA256SUMS --ignore-missing
```

> **Fontes cruzadas obrigatórias (conferir antes de usar):**
> - [specter.solutions/downloads](https://specter.solutions/downloads) — fingerprint publicada na seção “Signatures and hashes”
> - [github.com/cryptoadvance/specter-desktop/releases](https://github.com/cryptoadvance/specter-desktop/releases) — artefatos e `SHA256SUMS`

> **Uso no livro:** Specter é **alternativa** ao Sparrow para multisig + Bitcoin Core (Cap. 14, Nível 7). Não use como substituto do Sparrow para Whirlpool (Cap. 9).

### Tails 7.9 — download verificado (jun/2026)

Release atual: **7.9** (lançado 18/06/2026). Chave do projeto Tails (RSA 4096, expira 2027-01-13):

```bash
# Importar chave do Tails Project
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys A490D0F4D311A4153E2BB7CADBB802B258ACD84F
gpg --fingerprint \
  A490D0F4D311A4153E2BB7CADBB802B258ACD84F
# Saída esperada: A490 D0F4 D311 A415 3E2B  B7CA DBB8 02B2 58AC D84F
# Email: tails@boum.org
```

Verificação completa: tails.net/install/download/index.en.html

### Whonix — comando verificado (jun/2026)

``` {.sourceCode .bash}
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
gpg --fingerprint \
  916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
```

### SeedSigner 0.8.6 — arquivos de verificação (jun/2026)

Release atual: **0.8.6** (jun/2025). Arquivos no GitHub:

- `seedsigner_os.0.8.6.pi0.img` (+ variantes pi02w, pi2, pi4)
- `seedsigner.0.8.6.sha256.txt` e `seedsigner.0.8.6.sha256.txt.sig`

``` {.sourceCode .bash}
sha256sum -c seedsigner.0.8.6.sha256.txt
gpg --verify seedsigner.0.8.6.sha256.txt.sig seedsigner.0.8.6.sha256.txt
```

### eigenwallet — download verificado (jun/2026)

Release atual: **4.11.3**. Linux Whonix:

```bash
EW_VER=4.11.3
EW_ORG="eigenwallet/core/releases/download"
EW_BASE="https://github.com/${EW_ORG}/${EW_VER}"
EW_FILE="eigenwallet_${EW_VER}_amd64"
scurl-download "${EW_BASE}/${EW_FILE}.AppImage"
scurl-download "${EW_BASE}/${EW_FILE}.AppImage.asc"
```

> **AVISO (jun/2026):** O nome mudou de `eigenwallet-x86_64.AppImage` para `eigenwallet_VERSAO_amd64.AppImage`. Sempre use a release mais recente do GitHub.

### Feather Wallet 2.8.1 — download verificado (jun/2026)

Release atual: **2.8.1**. Chave de release **FeatherWallet** (`dev@featherwallet.org`).

```bash
# Importar e conferir fingerprint (compare com docs + GitHub)
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys 8185E158A33330C7FD61BC0D1F76E155CEFBA71C
gpg --fingerprint \
  8185E158A33330C7FD61BC0D1F76E155CEFBA71C
# Saída esperada: 8185 E158 A333 30C7 FD61 BC0D 1F76 E155 CEFB A71C

# Baixar (Tails — torsocks; Whonix — scurl-download)
VERSION=2.8.1
FW_BASE="https://featherwallet.org/files/releases/linux"
torsocks wget -P ~/Downloads \
  "${FW_BASE}/feather-${VERSION}-x86_64.AppImage" \
  "${FW_BASE}/feather-${VERSION}-x86_64.AppImage.asc"

gpg --verify \
  feather-${VERSION}-x86_64.AppImage.asc \
  feather-${VERSION}-x86_64.AppImage
# Esperado: Good signature from "FeatherWallet <dev@featherwallet.org>"
```

Fontes cruzadas obrigatórias:

- https://docs.featherwallet.org/guides/release-signing-key  
- https://github.com/feather-wallet/feather (README — seção GPG)  
- `drill -D key.featherwallet.net TXT` (DNS, Linux)

Lab passo a passo no Tails: `laboratorio/nivel-5-trocador/02-feather-tails-instalacao.md`

---
