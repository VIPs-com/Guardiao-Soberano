# Defesa ABCTracer — exercício sem/com proteção

> **Livro:** Capítulo 10 · Passos 5.1, 5.7 · `../../imagens/fluxo-abctracer.png`  
> **Último teste:** 2026-06-25 (roteiro conceitual — revalidar com swaps reais)  
> **Referência:** arXiv:2504.01822 (ABCTracer, 2025)  

---

## Objetivo

Internalizar as **três defesas** contra correlação cross-chain: **tempo**, **valor** e **endereços virgens** — comparando cenário vulnerável vs. protegido.

---

## O que o ABCTracer explora

Um analista com visão da blockchain Bitcoin **e** metadados de bridge pode correlacionar:

| Sinal | Exemplo vulnerável |
| --- | --- |
| **Intervalo** | 1.0 BTC swap 14:00 → ~0.98 XMR 14:25 (25 min) |
| **Proporção valor/fee** | Entrada e saída com mesma taxa relativa |
| **Destino** | Mesmo endereço BTC reutilizado |

Resultado publicado: até **~91,75%** de rastreabilidade em cenários descuidados.

---

## Cenário A — ❌ SEM DEFESA (não reproduza com fundos reais)

```
Dia único:
  14:00  → 1.0 BTC  → eigenwallet (BTC→XMR)
  14:25  → ~0.98 XMR aparece na Feather
  15:00  → RetoSwap (XMR→BTC) mesmo dia
  15:30  → BTC em endereço já usado antes

Metadado: CORRELACIONADO (alta confiança para analista)
```

**Por que falha:** intervalo curto + valor único + endereço reutilizado.

---

## Cenário B — ✅ COM DEFESA (modelo do livro)

```
Dia 1:  0.4 BTC → swap → XMR (Feather subaddress A)
        [aguardar 48–72 h — desligar Tails/Whonix]

Dia 3:  0.3 BTC → outro swap → XMR (subaddress B)
        [aguardar]

Dia 5:  0.5 BTC → swap → XMR (subaddress C)
        [aguardar 3–7 dias desde PRIMEIRO XMR]

Dia 10: RetoSwap XMR→BTC → endereço BTC virgem #1
Dia 12: outro lote XMR→BTC → endereço virgem #2

Metadado: NÃO CORRELACIONADO (analista perde ligação óbvia)
```

---

## Checklist operacional (cole no KeePassXC)

Antes de **cada** swap reverso XMR→BTC:

- [ ] Passou **≥24 h** desde o BTC→XMR correspondente? (ideal ≥72 h)
- [ ] Valor deste swap é **diferente** dos anteriores?
- [ ] Subendereço XMR é **novo**?
- [ ] Endereço BTC de destino é **virgem** (nunca recebeu fundos)?
- [ ] Tor ativo; sem clearnet na operação?
- [ ] Registrei timestamp no cofre (prova de intervalo para você mesmo)?

---

## Exercício de mesa (sem blockchain)

1. Desenhe duas linhas do tempo em papel — cenário A e B
2. Marque onde um analista **ligaria** as pontas no cenário A
3. Marque onde a ligação **quebra** no cenário B
4. Compare com `../../imagens/fluxo-abctracer.png` do repositório

---

## Exercício prático (quando tiver hardware)

Usando valores mínimos de teste:

1. Execute **um** swap BTC→XMR (lab `01`)
2. **Pare.** Anote hora. Não abra RetoSwap por 48 h mínimo
3. Execute XMR→BTC (lab `03`) com endereço novo
4. Revise se você resistiu à tentação do “swap rápido de volta”

---

## Como confirmar que deu certo

- [ ] Você articula os 3 sinais do ABCTracer sem consultar o livro
- [ ] Seu plano de swap inclui intervalo em **dias**, não minutos
- [ ] Cada operação tem subendereço + endereço BTC novos anotados
- [ ] Você entende por que eigenwallet→RetoSwap imediato é perigoso

---

## Referências

- Livro: `manuscrito/10-nivel-5-trocador.md` (passo 5.7, aprofundamento ABCTracer)
- Imagem: `../../imagens/fluxo-abctracer.png`
- Paper: arXiv:2504.01822
