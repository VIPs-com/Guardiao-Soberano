# Verificação PGP — stack Whonix/Tails

> **Livro:** Apêndice D · Capítulo 8  
> **Último teste:** 2026-06-25 (roteiro — revalidar em hardware)  
> **Ambientes:** Tails 7.9 · Whonix-Workstation  

---

## Objetivo

Executar o ritual completo de verificação PGP para **cada** binário da trilha antes do primeiro uso real — sem atalhos.

---

## Regra de ouro

1. Baixar arquivo **e** `.asc` por caminhos independentes (Tor)
2. Importar chave → conferir **fingerprint** em ≥2 fontes
3. `gpg --verify` → **Good signature**
4. Só então executar ou instalar

Livro: `manuscrito/D-guia-verificacao-pgp.md`

---

## Checklist por ferramenta

### Tails (imagem USB)

| Passo | Comando / fonte |
| --- | --- |
| Fingerprint | `A490D0F4D311A4153E2BB7CADBB802B258ACD84F` |
| Fontes | tails.net · Apêndice D |
| Verificar | Imagem ISO + `.sig` conforme guia oficial Tails |

### Whonix (.ova)

| Passo | Comando / fonte |
| --- | --- |
| Fingerprint | `916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA` |
| Fontes | whonix.org/wiki/Signing_Key |
| Verificar | `gpg --verify Whonix*.asc Whonix*.ova` |

### Sparrow Wallet

| Passo | Comando / fonte |
| --- | --- |
| Fingerprint | `D4D0D3202FC06849A257B38DE94618334C674B40` (Craig Raw) |
| Tails | `torsocks wget` releases GitHub |
| Whonix | `scurl-download` |
| Lab | N2 [`01-sparrow-watching-only.md`](../nivel-2-carteira-fria/01-sparrow-watching-only.md) |

### Feather Wallet

| Passo | Comando / fonte |
| --- | --- |
| Fingerprint | `8185E158A33330C7FD61BC0D1F76E155CEFBA71C` |
| Fontes | docs.featherwallet.org · GitHub feather-wallet |
| Lab | N5 [`02-feather-tails-instalacao.md`](../nivel-5-trocador/02-feather-tails-instalacao.md) |

### Electrum (ThomasV)

| Passo | Comando / fonte |
| --- | --- |
| Chave | ThomasV — download.electrum.org |
| Lab | N2 [`04-electrum-tails.md`](../nivel-2-carteira-fria/04-electrum-tails.md) |

### eigenwallet (binarybaron)

| Passo | Comando / fonte |
| --- | --- |
| Assinatura | `.asc` em github.com/eigenwallet/core/releases |
| Versão pinada | `eigenwallet_4.11.3_amd64.AppImage` (jun/2026) |
| Lab | N5 [`01-eigenwallet-whonix-btc-xmr.md`](../nivel-5-trocador/01-eigenwallet-whonix-btc-xmr.md) |

### RetoSwap (haveno-reto)

| Passo | Comando / fonte |
| --- | --- |
| Release | `v1.8.0-reto` — github.com/retoaccess1/haveno-reto/releases |
| Verificar | `.asc` junto ao tarball — conferir instruções da release |
| Lab | N5 [`03-retoswap-xmr-btc.md`](../nivel-5-trocador/03-retoswap-xmr-btc.md) |

### SeedSigner / Coldcard

| Item | Fonte |
| --- | --- |
| SeedSigner 0.8.6 | `sha256sum -c` + `.sig` (Apêndice D) |
| Coldcard firmware | coldcard.com/docs/upgrade |

---

## Rotina mensal (AppImages)

O Whonix atualiza `apt` via Tor automaticamente. **AppImages não.**

```bash
# Mensalmente, para cada app em ~/apps/ ou ~/Persistent/Apps/:
# 1. Baixar nova versão + .asc via Tor
# 2. gpg --verify
# 3. Substituir binário antigo
# 4. Testar com valor simbólico antes de fundos reais
```

---

## Como confirmar que deu certo

- [ ] Você completou `gpg --verify` para **todos** os itens que usa
- [ ] Nenhum `BAD signature` ignorado
- [ ] Fingerprints anotados no KeePassXC com data da verificação
- [ ] Scripts `start-*.sh` apontam para binários já verificados

---

## Saídas de alerta

| Saída GPG | Ação |
| --- | --- |
| `Good signature` | OK para prosseguir |
| `WARNING: This key is not certified` | Normal se você não assinou a chave |
| `BAD signature` | **Não execute.** Reporte ao projeto. |

---

## Referências

- `manuscrito/D-guia-verificacao-pgp.md`
- `manuscrito/C-comandos-essenciais.md`
