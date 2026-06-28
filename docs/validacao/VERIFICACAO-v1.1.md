# Verificação técnica v1.1 — Guardião Soberano

**Criado:** 24 jun 2026 · **Atualizado:** 24 jun 2026 (pós mapa de ambientes + Ap. H)  
**Objetivo:** Fechar lacunas antes do tag `v1.1.0`  
**Como usar:** marque ☐ → ☑ · registre data e validador · falhas → issue GitHub ou Ap. F

Documento irmão (agentes): [`../equipe/BATERIA-TESTES-v1.1.md`](../equipe/BATERIA-TESTES-v1.1.md)

---

## Resumo executivo

| Área | Doc / manuscrito | Hardware | Bloqueia release? |
| --- | --- | --- | --- |
| Mapa ambientes (13.4–13.8, 14.0b, Ap. H) | ✅ | N/A | Não |
| Glossário air-gap / PSBT / watch-only | ✅ Ap. A | N/A | Não |
| Labs N0–N7 (29 + 2 opc.) | ✅ extraídos | ⏳ 0/18 🔴 | **Sim** |
| Ap. B — .onion | ✅ jun/2026 | ⏳ | **Sim** (semana do release) |
| Ap. D — PGP | ✅ | ⏳ | **Sim** |
| Ap. C — comandos em VM | ✅ | ⏳ | **Sim** |
| Ap. E — DeCripto / IN 2291 | ✅ | ⏳ advogado N6/04 | Parcial |
| Ap. F — troubleshooting | ✅ | ⏳ conforme testes | Não |
| Prova gráfica A5 | ✅ compilável | ⏳ 1× impressa | Recomendado |
| `compila.ps1 -All` | ✅ 24/06 | Repetir se diff | Antes do tag |

---

## Três perguntas (sanidade operacional)

Antes de cada sessão de teste, o validador confirma:

1. **Onde está a seed?** → metal + HW offline apenas  
2. **Onde está a rede?** → Tor forçado ou offline total  
3. **Rotina ou cirúrgico?** → Whonix vs Tails (Cap. **13.4**, Ap. **H**)

---

## Apêndice B — Servidores .onion

> Testar na **semana do release**. v3 = 56 caracteres base32 + `.onion`.

| # | Item | Fonte oficial | Testado ☐ | Data | Notas |
| --- | --- | --- | --- | --- | --- |
| B1 | RoboSats principal | GitHub RoboSats README | ☐ | | `manuscrito/B-servidores-onion.md` |
| B2 | Coordinator Whirlpool (Sparrow auto) | Sparrow + Tor | ☐ | | Registrar se offline |
| B3 | EPS próprio (hidden service) | Cap. 8, lab N3/02 | ☐ | | Preferido vs público |
| B4 | RetoSats / federação (se usado) | README RetoSwap | ☐ | | |
| B5 | Nó Monero .onion (Feather) | Feather docs | ☐ | | |

**Comando teste EPS/Electrum (Whonix WS):**

```bash
torify nc -zv SEU_ENDERECO_V3.onion 50002
```

---

## Apêndice D — Verificação PGP

Executar no ambiente real (Tails ou Whonix), não só no papel.

| # | Software | Fingerprint (manuscrito) | VM | ☐ | Data |
| --- | --- | --- | --- | --- | --- |
| D1 | Sparrow | Craig Raw — Ap. D | Whonix | ☐ | |
| D2 | Feather 2.8.1 | `8185E158…CEFBA71C` | Tails + Whonix | ☐ | |
| D3 | Electrum | ThomasV — Ap. D | Tails | ☐ | |
| D4 | eigenwallet 4.11.3 | binarybaron — Ap. D | Whonix | ☐ | |
| D5 | RetoSwap v1.8.0-reto | Ap. D | Whonix | ☐ | |
| D6 | Whonix OVA | Patrick Schleizer — Ap. D | Host | ☐ | |
| D7 | Tails ISO | tails.net OpenPGP | Host | ☐ | |

**Critério:** `gpg --verify` → *Good signature* + fingerprint idêntico ao site oficial **no dia do teste**.

---

## Apêndice C — Comandos críticos

| # | Fluxo | Onde testar | ☐ |
| --- | --- | --- | --- |
| C1 | `scurl-download` + verify Sparrow | Whonix WS | ☐ |
| C2 | `scurl-download` + verify eigenwallet | Whonix WS | ☐ |
| C3 | Import xpub Sparrow watch-only | Tails N2 / Whonix | ☐ |
| C4 | Ciclo PSBT SD + `/psbt_bridge` | Whonix + HW | ☐ |
| C5 | Ciclo PSBT QR | HW SeedSigner/Passport | ☐ |
| C6 | Whirlpool premix + 2 remixes | Whonix | ☐ |
| C7 | eigenwallet swap teste (valor mínimo) | Whonix | ☐ |
| C8 | RetoSwap XMR→BTC teste | Whonix ou Tails | ☐ |
| C9 | Scripts `laboratorio/scripts/tails/*.sh` | Tails persistência | ☐ |

Desvios → atualizar `manuscrito/F-troubleshooting.md` + lab afetado.

---

## Apêndice E — Aspectos legais (Brasil)

| # | Item | ☐ | Responsável |
| --- | --- | --- | --- |
| E1 | IN RFB 2291/2025 (DeCripto) vigente em jul/2026 | ☐ | Revisar texto Cap. 11, Ap. E |
| E2 | Lab `N6/04-declaracao-cripto-brasil.md` — parecer profissional | ☐ | Humano (não IA) |

---

## Apêndice F — Troubleshooting

| # | Item | ☐ |
| --- | --- | --- |
| F1 | Cada falha de lab documentada com sintoma + fix | ☐ |
| F2 | Entradas KruxMobileApp / Specter / ambientes (Cap. 13) revisadas após testes | ☐ |

---

## Labs — ordem de execução (🔴 obrigatórios)

Detalhe linha a linha: copiar matriz de `soberano-equipe-dev/docs/validacao/VALIDACAO-LABORATORIO-29.md` (equipe local) ou seguir fases abaixo.

### Fase A — Físico (sem rede sensível)

| Lab | Arquivo | ☐ |
| --- | --- | --- |
| N0/01 | `laboratorio/nivel-0-semente/01-gerar-seed-dados.md` | ☐ |
| N0/02 | `laboratorio/nivel-0-semente/02-backup-aco.md` | ☐ |
| N1/01 | `laboratorio/nivel-1-cofre/01-hw-wallet-inicializacao.md` | ☐ |
| N1/02 | `laboratorio/nivel-1-cofre/02-teste-restauracao.md` | ☐ |
| N1/03 | `laboratorio/nivel-1-cofre/03-psbt-via-qr.md` | ☐ |

### Fase B — Tails (N2 + Feather)

| Lab | Arquivo | ☐ |
| --- | --- | --- |
| N2/01–05 | `laboratorio/nivel-2-carteira-fria/` | ☐ |
| N5/02 | `laboratorio/nivel-5-trocador/02-feather-tails-instalacao.md` | ☐ |

### Fase C — Whonix (N3–N5)

| Lab | Arquivo | ☐ |
| --- | --- | --- |
| N3/01 | `01-whonix-virtualbox-completo.md` | ☐ |
| N3/02 | `02-bitcoin-node-eps-onion.md` | ☐ |
| N3/04 | `04-migracao-tails-whonix.md` | ☐ |
| N4/01–02 | Whirlpool + coin control | ☐ |
| N5/01, 03, 04 | eigenwallet, RetoSwap, ABCTracer | ☐ |

### Fase D — Soberano + Mestre

| Lab | Arquivo | ☐ |
| --- | --- | --- |
| N6/01–03 | backup, scripts, mobile | ☐ |
| N7/01 | multisig (opcional release) | ☐ |

**Regra 🟢:** cabeçalho do lab `**Último teste:** AAAA-MM-DD` + linha no `laboratorio/README.md`.

---

## Prova gráfica

| # | Item | ☐ |
| --- | --- | --- |
| P1 | Imprimir `saida/guardiao-soberano-v1.1-grafica.pdf` (1 cópia A5) | ☐ |
| P2 | Sumário, Ap. H, tabelas 13.4–13.5 legíveis | ☐ |
| P3 | Diagramas P&B + ícones N0–N7 | ☐ |
| P4 | Notas de rodapé não cortadas | ☐ |

Checklist: [`recursos/prova-grafica-checklist.md`](../../recursos/prova-grafica-checklist.md)

---

## Novo conteúdo editorial (verificar na prova)

| Seção | O que conferir | ☐ |
| --- | --- | --- |
| Cap. 13.4–13.8 | Mapa ambientes, matriz, PSBT, migração, bridge | ☐ |
| Cap. 14.0 / 14.0b | Trilha vs alternativas vs ambientes | ☐ |
| Ap. H | Consulta rápida imprime legível | ☐ |
| Ap. A | Entradas air-gap, PSBT bridge, watch-only | ☐ |
| Caps. 9–10 | Blocos **Lab:** apontam para arquivos corretos | ☐ |

---

## Fechamento release

```powershell
# Após todos os 🔴 acima
.\compila.ps1 -All
git tag -a v1.1.0 -m "Guardião Soberano v1.1.0 — validado hardware"
# Anexar PDF/EPUB via GitHub Releases (opcional; saida/ não versionada)
```

---

*Atualize este arquivo quando um item for validado. Versão espelhada em `soberano-equipe-dev/docs/validacao/` (cópia local da equipe).*
