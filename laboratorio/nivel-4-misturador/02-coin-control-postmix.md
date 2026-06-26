# Coin control pós-coinjoin

> **Livro:** Capítulo 9 · Passos 4.6, 4.8  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Sparrow 2.5.2 (Whonix ou Tails)  

---

## Objetivo

Dominar **coin control** após Whirlpool: congelar UTXOs, rotular, evitar auto-sabotagem ao gastar ou preparar swaps.

---

## Pré-requisitos

- [ ] Lab [`01-whirlpool-primeiro-mix.md`](01-whirlpool-primeiro-mix.md) — pelo menos um UTXO Postmix
- [ ] Três carteiras Sparrow (Whirlpool / Postmix / Swap_Ready)

---

## Regras que salvam anonimato

| ❌ Nunca | ✅ Sempre |
| --- | --- |
| Consolidar Postmix + não-misturado numa tx | Gastar UTXOs **homogêneos** (só limpos ou só sujos) |
| **Send Max** sem olhar inputs | Selecionar inputs manualmente |
| Reutilizar endereço de receive | Endereço novo por operação |
| Misturar UTXO KYC com pós-CJ | Rotular origem de cada UTXO |

---

## Passo 1 — Congelar (Freeze)

1. Sparrow → UTXOs view
2. UTXOs **não misturados** ou reservados → botão direito → **Freeze**
3. Impede gasto acidental em "Send"

---

## Passo 2 — Rotular tudo

Exemplos de labels no Sparrow:

| Label | Significado |
| --- | --- |
| `KYC Exchange 2026-01` | Entrada identificada |
| `CJ anonset 7` | Pós-Whirlpool |
| `Swap Ready #2` | Reservado eigenwallet |
| `RoboSats 2026-06` | Entrada sem KYC |

Registre no KeePassXC: TXID + label + data.

---

## Passo 3 — Mover para Swap_Ready (Nível 5)

Quando for fazer swap BTC→XMR:

1. Postmix → selecione UTXO com anonset ≥ 5
2. **Send to** → `Swap_Ready_Whonix` (1 confirmação)
3. Só então abra eigenwallet — lab N5 `01`

---

## Passo 4 — Auto-auditoria (opcional)

Via Tor Browser → explorador (ex. OXT) → cole **seu** endereço de receive de teste.

Objetivo: ver se clusters parecem óbvios **antes** de operar com valores maiores. Não é prova formal — é higiene.

---

## Exercício de mesa

Cenário: você tem 0.02 BTC Postmix e 0.05 BTC não misturado.

1. Quanto você envia se clicar **Send Max** na carteira unificada?
2. Por que isso destrói anonimato?
3. Qual o fluxo correto para gastar 0.01 BTC limpo?

Resposta: selecionar **apenas** inputs Postmix; nunca os dois grupos na mesma transação.

---

## Como confirmar que deu certo

- [ ] Todos os UTXOs relevantes têm label
- [ ] UTXOs sujos/reservados estão Frozen
- [ ] Você consegue explicar common-input-ownership heuristic
- [ ] Transferiu UTXO limpo para Swap_Ready sem misturar inputs

---

## Referências

- Livro: `manuscrito/09-nivel-4-misturador.md` (passo 4.8)
- Próximo nível: [`../nivel-5-trocador/`](../nivel-5-trocador/)
