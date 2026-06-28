# Apêndice H — Mapa de Ambientes e Fluxos (consulta rápida)

---

Use esta página **durante a operação** — quando você sabe *o que* fazer, mas hesita *onde* fazer. Narrativa completa: **Capítulos 13.4–13.8** e **14.0b**.

---

## Três perguntas (sempre)

1. **Onde está a seed?** → Metal + HW offline. Em nenhum PC, Tails ou celular da trilha.
2. **Onde está a rede?** → Tor forçado (Whonix/Tails) ou offline total (HW).
3. **Rotina ou cirúrgico?** → Whonix persiste; Tails apaga ao desligar.

Se alguma resposta conflitar com a ação, **pare**.

---

## Matriz operação × ambiente

| Operação | Onde | Nunca |
| --- | --- | --- |
| Gerar/restaurar seed | HW air-gapped | Whonix, Tails, mobile, site online |
| Validar BIP39 | Tails **offline** | Internet |
| Saldo / UTXO / criar tx | Sparrow **Whonix WS** | Seed no WS |
| Enviar (cold) | WS → PSBT → **HW** → WS transmit | Assinar online |
| Whirlpool | Sparrow **Whonix WS** | Trocar app no meio do mix |
| BTC → XMR | eigenwallet **WS** | Exchange KYC |
| XMR → BTC | RetoSwap **WS** | Pressa sem intervalo ABCTracer |
| Compra P2P / RoboSats | **Tails** | Conta pessoal logada |
| “Nunca existiu” | **Tails** amnésico | Whonix com histórico |
| Ver saldo rápido | Mobile **watch-only** | Seed no celular pessoal |

---

## Fluxo PSBT (SD — trilha)

```
Sparrow (WS) → export PSBT → /psbt_bridge → MicroSD
    → HW verifica display → assina → SD → bridge → Sparrow → Transmit (Tor)
```

**Regras bridge:** só PSBT; apagar após transmitir; SD dedicado; host = hostil.

**Fluxo QR:** Sparrow QR ↔ HW ↔ Sparrow — sem nuvem, sem WhatsApp.

Lab: `laboratorio/nivel-2-carteira-fria/02-primeiro-psbt.md`

---

## Tails: dois pendrives (A / B)

| Pendrive | Função | Persistência |
| --- | --- | --- |
| **A — rotina** | Updates, ferramentas, configs genéricas | Persistent Storage OK |
| **B — cirúrgico** | Swap alto valor, P2P sensível | **Sem** persistência sensível; descartável mentalmente |

Nunca misture “sessão suja” (conta pessoal, download aleatório) no **B**.

---

## Migração Tails → Whonix (N3)

| Migra | Não migra |
| --- | --- |
| xpub, wallet Sparrow **sem chaves** | Seed (nunca esteve no Tails) |
| Hábito: Tails = pontual | Copiar PS Tails inteiro sem revisar |

Lab: `laboratorio/nivel-3-observador/04-migracao-tails-whonix.md`

---

## Celular — três posturas

| Postura | Seed? |
| --- | --- |
| Watch-only (Sparrow xpub) | **Não** |
| Coordinator PSBT → QR | **Não** |
| AirGap Vault / cofre no phone | **Sim** — só emergência / valores pequenos |

---

## Árvore de decisão (1 linha)

**Seed?** → HW · **Rede rotina?** → Whonix WS · **Sessão única sem rastro?** → Tails · **Só olhar?** → mobile watch-only

---

## Onde ler mais

| Tópico | Onde |
| --- | --- |
| Mapa de camadas | Cap. **13.4** |
| Matriz operacional | Cap. **13.5** |
| PSBT + bridge | Cap. **13.6–13.8** |
| Ferramentas vs trilha | Cap. **14.0** |
| Ambientes vs nomes | Cap. **14.0b** |
| Matriz expandida | Apêndice **G** |
| Dois pendrives / SSD | Cap. **15** |
| Troubleshooting | Apêndice **F** |
| Definições (air-gap, PSBT, watch-only…) | Apêndice **A** |

---
