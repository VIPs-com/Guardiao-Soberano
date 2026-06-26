# Backup em aço + passphrase em local separado

> **Livro:** Capítulo 5 · Passos 0.5–0.6  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Material:** placa inox ou kit arruelas · gravador ou estilete  

---

## Objetivo

Gravar a seed em **duas cópias físicas** em locais diferentes, criar **passphrase** (25ª palavra) guardada separadamente, e destruir papel intermediário.

```
Seed (2× metal, locais A+B) + Passphrase (local C, memorizada)
```

---

## Pré-requisitos

- [ ] Lab [`01-gerar-seed-dados.md`](01-gerar-seed-dados.md) ou seed já gerada no dispositivo (Nível 1)
- [ ] Placa de aço **ou** arruelas numeradas (1 palavra por arruela)
- [ ] Local seguro para gravar (sem observadores)

---

## Passo 1 — Conferir palavras

1. Leia as 24 palavras em voz alta **3 vezes**
2. Outra pessoa confere (opcional) — **sem** gravar passphrase junto
3. Confira ortografia contra lista BIP39

---

## Passo 2 — Gravar cópia A

**Opção placa:** gravador elétrico, uma palavra por linha numerada  
**Opção arruelas:** palavra gravada na face da arruela, ordem em saco numerado

Marque: `Cópia A — [data]` apenas se útil para **você** (evite identificar o conteúdo para terceiros).

---

## Passo 3 — Gravar cópia B

Repita o processo em **segundo** suporte físico.

| Cópia | Local sugerido |
| --- | --- |
| A | Sua residência (escondido) |
| B | Familiar de confiança **ou** cofre **ou** outro município |

Regra: incêndio/roubo em um local não pode destruir as duas.

---

## Passo 4 — Passphrase (25ª palavra)

1. Crie frase **longa e única** (20+ caracteres, não de livro/filme)
2. Anote em papel **separado** da seed
3. Guarde em **Local C** (diferente de A e B)
4. Memorize — repita 10×/dia por uma semana

Exemplo de estrutura (não copie): `MinhaAvóNasceuEm1920NoInterior`

---

## Passo 5 — SeedQR (opcional)

- Gere QR compacto da seed **offline** (ferramenta compatível com seu signer)
- Estampe em metal como **redundância** — palavras + QR
- Compatível: SeedSigner, Krux, Jade, Passport

---

## Passo 6 — Destruir rastros

- [ ] Queimar ou picar papel com as 24 palavras
- [ ] Nunca: foto, nuvem, e-mail, WhatsApp, PDF
- [ ] Limpar lixo de rascunhos

---

## Como confirmar que deu certo

- [ ] 2 cópias em metal legíveis após 2ª leitura
- [ ] Passphrase em local **C**, separada da seed
- [ ] Você recita a passphrase de memória (teste sem olhar)
- [ ] Papel intermediário destruído
- [ ] Teste de restauração agendado para **Nível 1** (obrigatório antes de fundos)

---

## Se der errado

- Palavra ilegível na placa → regrave **antes** de enviar BTC
- Perdeu passphrase → com seed ainda pode acessar carteira **sem** passphrase (se não usou uma) — se usou, sem passphrase = carteira vazia por design
- Livro: Cap. 5 · Cap. 15 (OpSec)

---

## Próximo lab

[`03-primeiros-sats-sem-kyc.md`](03-primeiros-sats-sem-kyc.md)
