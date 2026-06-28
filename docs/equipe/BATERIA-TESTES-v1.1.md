# Bateria de testes v1.1 — instruções para agentes

**Rodada:** 2 · **Data:** junho 2026  
**Meta:** trazer agentes de volta, fechar lacunas hardware + técnico, preparar tag `v1.1.0`

---

## Contexto (o que mudou desde a rodada 1)

| Entrega | Status |
| --- | --- |
| Editorial IA Caps. 1–17 + Ap. A–H | ✅ |
| Mapa ambientes Cap. 13.4–13.8, 14.0b, Ap. H | ✅ |
| Glossário air-gap / PSBT / watch-only | ✅ |
| Links **Lab:** Caps. 7–11, 9–10 | ✅ (esta rodada) |
| Labs 29/29 extraídos | ✅ |
| **Validação hardware** | ⏳ **0/18 🔴** |
| Push GitHub | ⏳ este commit |

---

## Antes de editar qualquer arquivo

1. Ler [`../../README.md`](../../README.md) e [`../validacao/VERIFICACAO-v1.1.md`](../validacao/VERIFICACAO-v1.1.md)  
2. **Não** reescrever trilha — corrigir só o que teste ou leitura humana provar errado  
3. **Não** commitar `saida/`, `soberano-equipe-dev/`, `old/`, seeds, `.onion` pessoais  
4. Compilar após mudança no manuscrito: `.\compila.ps1 -All`  
5. Relatórios de agente → `soberano-equipe-dev/docs/processo/relatorios-revisao/` (local)

---

## Papéis sugeridos (paralelo)

| Agente | Foco | Entrada | Saída |
| --- | --- | --- | --- |
| **Hardware A** | Fase A + B (N0–N2, Feather Tails) | Labs + scripts Tails | Labs 🟢 + `VALIDACAO-v1.1` ☐→☑ |
| **Hardware B** | Fase C (Whonix N3–N5) | eigenwallet, RetoSwap, Whirlpool | Idem |
| **Técnico C** | Ap. B + D + C | Tor Browser, gpg, VMs | Atualizar Ap. B/F se .onion morrer |
| **Editor D** | Prova gráfica + tabelas 13.x | PDF gráfica impresso | Issue layout ou fix CSS/LaTeX |
| **Legal E** | Ap. E + lab N6/04 | IN 2291 | Nota de rodapé se mudar norma |

Orquestrador: consolidar em [`VERIFICACAO-v1.1.md`](../validacao/VERIFICACAO-v1.1.md) e [`PENDENCIAS-EDITORIAL`](../../soberano-equipe-dev/docs/processo/PENDENCIAS-EDITORIAL.md) (local).

---

## Ordem de execução (não pular)

```
1. N0/N1 físico
2. Tails N2 completo (+ scripts start-*)
3. Whonix N3 + migração N3/04
4. N4 Whirlpool + coin control
5. N5 eigenwallet → intervalo ABCTracer → RetoSwap
6. N6 backup + mobile watch-only
7. PGP Ap. D (todos os binários usados)
8. .onion Ap. B (semana do release)
9. compila.ps1 -All → prova gráfica → tag v1.1.0
```

---

## Lacunas conhecidas (prioridade)

| # | Lacuna | Ação |
| --- | --- | --- |
| L1 | 0 labs 🟢 em hardware | Executar matriz § Labs em VERIFICACAO-v1.1 |
| L2 | .onion não testados desde jun/2026 | Agente C — semana do release |
| L3 | Triagem humana Caps. 5–12 | Humano marca MATRIZ (equipe local) |
| L4 | Lab N6/04 sem parecer jurídico | Humano E — não marcar 🟢 |
| L5 | Remote GitHub | Push deste commit; CI links |
| L6 | Pendrives Tails A/B | Validar prática Cap. 15 + Ap. H |

---

## Definição de pronto (rodada 2)

- [ ] Todos os labs 🔴 em VERIFICACAO-v1.1 marcados ☑ com data  
- [ ] `laboratorio/README.md` — pelo menos N0–N5 com 🟢 onde aplicável  
- [ ] Ap. B/D atualizados se fingerprints ou .onion mudaram  
- [ ] `compila.ps1 -All` sem erro  
- [ ] Prova gráfica P1–P4 ☑  
- [ ] Tag `v1.1.0` + Release opcional  

---

## Prompt curto para colar no agente

```
Projeto: Guardião Soberano v1.1 (repo Guardião-Soberano)
Leia: docs/equipe/BATERIA-TESTES-v1.1.md e docs/validacao/VERIFICACAO-v1.1.md
Tarefa: [Hardware A | Técnico C | …] — executar seção X e registrar ☐→☑
Não reescrever trilha. Falhas → manuscrito/F-troubleshooting.md + lab.
```

---

*Espelho local: `soberano-equipe-dev/docs/processo/` · Manuscrito: `manuscrito/` · Labs: `laboratorio/`*
