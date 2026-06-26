# Teste de restauração (antes de enviar fundos)

> **Livro:** Capítulo 6 · Passo 1.7  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Hardware:** mesmo dispositivo ou segundo signer limpo  

---

## Objetivo

Provar que o **backup em metal funciona**: apagar a seed do dispositivo, restaurar das 24 palavras + passphrase e confirmar que os **mesmos endereços** reaparecem.

```
Anotar endereços → Destroy Seed → Restore → endereços IDÊNTICOS
```

> **Nunca envie BTC** antes deste teste passar.

---

## Pré-requisitos

- [ ] Lab [`01-hw-wallet-inicializacao.md`](01-hw-wallet-inicializacao.md) concluído
- [ ] Seed gravada em metal (2 cópias) + passphrase memorizada
- [ ] Endereços `0/0`, `0/4`, `0/14` anotados em papel (do Passo 1.6)

---

## Passo 1 — Registrar endereços atuais

Antes de apagar, anote **fora** do dispositivo:

| Índice | Endereço (bc1…) |
| --- | --- |
| `m/84'/0'/0'/0/0` | |
| `m/84'/0'/0'/0/4` | |
| `m/84'/0'/0'/0/14` | |

Exporte xpub novamente se necessário (SD ou QR).

---

## Passo 2 — Apagar seed do dispositivo

Menu típico: **Advanced → Danger Zone → Destroy Seed** (Coldcard e similares).

- Dispositivo deve indicar **sem wallet** / pedir setup inicial
- SeedSigner/Krux: desligar = stateless (já "limpo")

---

## Passo 3 — Restaurar

1. **Import Existing** / **Restore from 24 words**
2. Digite as 24 palavras **do metal** (não do papel destruído)
3. Aplique **passphrase**
4. Aguarde derivação completa

---

## Passo 4 — Comparar endereços

Exporte endereços ou leia na tela:

| Índice | Antes | Depois | Bate? |
| --- | --- | --- | --- |
| 0/0 | | | ☐ |
| 0/4 | | | ☐ |
| 0/14 | | | ☐ |

**Todos devem ser idênticos, caractere por caractere.**

---

## Passo 5 — Se falhou

| Causa provável | Correção |
| --- | --- |
| Erro na placa de metal | Regrave com conferência tripla |
| Passphrase errada | Teste sem passphrase (deve dar carteira vazia diferente) |
| Path errado | Confirme BIP84 / Native SegWit no dispositivo |

Repita o teste até passar.

---

## Como confirmar que deu certo

- [ ] Restore completo sem erro
- [ ] 3 endereços conferidos = iguais aos anotados
- [ ] Você confia no metal **mais** que na memória
- [ ] Pronto para receber primeiros sats (Nível 0/03)

---

## Rotina futura

- **Semestral** (Cap. 11): repetir restore em dispositivo **diferente**, se possível
- Após qualquer regravação em metal: **novo** teste de restore

---

## Se der errado

Livro: Cap. 6 passo 1.7 · Cap. 15 (OpSec) · Apêndice F
