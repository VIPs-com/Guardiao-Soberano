# SeedSigner vs Krux — escolha DIY (opcional)

> **Livro:** Capítulo 6 · comparativo SeedSigner vs Krux  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Hardware:** Raspberry Pi Zero (SeedSigner) **ou** Maix Amigo / M5StickV (Krux)  

---

## Objetivo

Escolher e montar um **signer DIY** air-gapped, flashar firmware verificado, e integrar com Sparrow via PSBT QR — alternativa a Coldcard/Jade.

---

## Comparação rápida

| Aspecto | SeedSigner | Krux |
| --- | --- | --- |
| Custo | ~US$30–50 (Pi Zero + câmera) | ~US$15–60 (placa K210) |
| Montagem | Média (montar Pi) | Fácil–média (muitas placas prontas) |
| Stateless | Sim | Sim (ou SD criptografado) |
| Air-gap | QR | QR + SD |
| Sparrow | PSBT QR | PSBT QR/SD |
| Melhor para | DIY total, comunidade madura | Flash rápido, hardware variado |

Ambos: BIP39, passphrase, multisig, xpub para watch-only.

---

## Trilha SeedSigner

### Hardware (oficial: seedsigner.com)

- Raspberry Pi Zero **1.3** (sem Wi‑Fi/Bluetooth)
- Waveshare 1.3" LCD HAT
- Câmera Pi
- Case (opcional)

### Instalação

1. Baixe imagem no [GitHub SeedSigner](https://github.com/SeedSigner/seedsigner/releases)
2. Verifique hash / assinatura da release
3. Flash no SD (`dd` ou Raspberry Pi Imager)
4. Monte hardware, ligue
5. Gere seed com **dice rolls** — N0/01 + N1/01
6. Backup metal — N0/02

### Com Sparrow

1. Export xpub via QR
2. PSBT: Sparrow Show QR → SeedSigner Scan → Sign to QR → Sparrow Scan
3. Lab completo: [`03-psbt-via-qr.md`](03-psbt-via-qr.md)

---

## Trilha Krux

### Hardware

- Maix Amigo, M5StickV, ou placa compatível K210 (ver [krux docs](https://selfcustody.github.io/krux/))

### Instalação

1. Baixe firmware em [github.com/selfcustody/krux](https://github.com/selfcustody/krux)
2. Verifique build reproduzível / hash publicado
3. Flash na placa (ferramenta do fabricante)
4. Dice rolls + metal backup (mesmos labs N0/N1)

### Com Sparrow

- Mesmo fluxo PSBT QR; Krux também aceita PSBT via **SD** se preferir

---

## Side-by-side (validação equipe)

Execute **um** exercício em cada plataforma (testnet ou mainnet mínimo):

| Critério | SeedSigner ☐ | Krux ☐ |
| --- | --- | --- |
| Flash firmware verificado | | |
| Dice roll seed | | |
| Export xpub QR → Sparrow | | |
| PSBT assinado e broadcast | | |
| Restore testado | | |
| Tempo até operacional | | |

Anote preferência pessoal no KeePassXC — não há resposta única.

---

## Supply chain

- Compre peças de **fornecedores diferentes** quando possível
- DIY: você audita; HW comercial: você confia no fabricante + verificação física

---

## Próximo

- N2 watching-only + PSBT
- N7 multisig com 2 signers diferentes (ex.: SeedSigner + Krux) — [`../nivel-7-mestre/01-multisig-2of3-trilha-a.md`](../nivel-7-mestre/01-multisig-2of3-trilha-a.md)

---

## Referências

- [seedsigner.com](https://seedsigner.com/)
- [Krux documentation](https://selfcustody.github.io/krux/)
- Livro Cap. 6 — comparativo completo
