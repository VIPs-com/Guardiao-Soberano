# Gerar seed com dados físicos + validação BIP39

> **Livro:** Capítulo 5 · Passos 0.1–0.4  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Material:** 2 dados de casino · papel · bip39.html (Ian Coleman, offline)  

---

## Objetivo

Gerar **entropia real** com dados físicos, converter em 24 palavras BIP39 em ambiente **offline** e validar o processo. **Destruir** o papel de exercício. A seed **definitiva** e a gravação em metal vêm no **Capítulo 6** (Nível 1), no dispositivo air-gapped.

```
Dados (100 lançamentos) → bip39.html OFFLINE → 24 palavras no PAPEL → Nível 1 (dice rolls no HW)
```

---

## Pré-requisitos

- [ ] 2 dados de casino (cores diferentes)
- [ ] Envelope pardo + caneta
- [ ] Pendrive com `bip39.html` copiado de [iancoleman.io/bip39](https://iancoleman.io/bip39) **antes** de ir offline
- [ ] Local sem câmeras — celular em outro cômodo

---

## Passo 1 — Materiais e estudo

Confira o checklist do livro (Passo 0.1–0.2):

- Placa de aço ou arruelas inox (para o lab [`02-backup-aco.md`](02-backup-aco.md))
- Entender: 24 palavras = 256 bits · passphrase = 25ª palavra opcional (Passo 0.6)

---

## Passo 2 — 100 lançamentos

1. Sente-se longe de telas e microfones
2. Lance os **dois dados juntos**, 100 vezes
3. Anote cada par no papel: ex. vermelho=3, azul=5 → `35`
4. Números válidos: **11 a 66** (dois dados de 6 faces concatenados)

**Nunca:** filmar, fotografar, ditar para assistente de voz, ou pular lançamentos.

---

## Passo 3 — Ambiente offline

1. Copie `bip39.html` para pendrive (com internet)
2. **Desconecte** Wi‑Fi e cabo ethernet
3. Modo avião ligado
4. Abra `bip39.html` no navegador (funciona sem rede)
5. Feche todas as outras abas

---

## Passo 4 — Converter entropia

1. Na seção **Entropy** do bip39.html, cole seus 100 números
2. O site gera **24 palavras** BIP39
3. **Transcreva manualmente** para o papel — sem imprimir
4. Leia em voz alta **3 vezes** conferindo com o site
5. Feche o navegador e desligue o PC (limpa RAM)

---

## Passo 5 — Simulação vs seed real

| Etapa | Onde |
| --- | --- |
| Esta simulação (Passo 0.4) | Valida que você entende o processo |
| Seed **definitiva** | Nível 1 — dice rolls **no dispositivo air-gapped** (Passo 1.4) |

A seed que guarda em metal deve ser a gerada **no hardware wallet**, não necessariamente a desta simulação no PC offline.

---

## Como confirmar que deu certo

- [ ] 100 lançamentos registrados no papel
- [ ] 24 palavras legíveis e da lista BIP39 (sem typos óbvios)
- [ ] Nenhuma foto/digital da seed existe
- [ ] Você explica por que **não** usar "Quick Generate" no dispositivo

Teste opcional (ainda offline): reinsira as 24 palavras no bip39.html — devem reproduzir os mesmos endereços derivados.

---

## Se der errado

- Palavra inválida → erro de transcrição; refaça a partir do papel de lançamentos
- Perdeu o papel dos dados → **recomece** os 100 lançamentos (não improvise)
- Livro: Cap. 5 · Apêndice F

---

## Próximo lab

[`02-backup-aco.md`](02-backup-aco.md) — gravar em metal e segunda cópia.
