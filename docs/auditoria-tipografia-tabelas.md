# Auditoria v1.2 — Tipografia, Tabelas e Quebras de Página

**Livro:** Guardião Soberano v1.1 → v1.2 (miolo)  
**Formato:** A4 (210×297 mm) · PDF XeLaTeX · EPUB reflowable  
**Data:** junho 2026

---

## 1. Diagnóstico (capturas da prova)

| Página | Arquivo | Problema observado | Causa provável |
| --- | --- | --- | --- |
| ~248 | `14-ferramentas-alternativas.md` | URL longa cortada à direita | Texto corrido em bullet, não tabela — falta quebra (`\url` / backticks curtos) |
| ~251 | `14-ferramentas-alternativas.md` | Tabelas ASCII estreitas, muito espaço vazio | Grid tables Pandoc com colunas fixas em caracteres, não `%` da página |
| ~309 | `D-guia-verificacao-pgp.md` | Coluna fingerprint estoura margem | 3ª coluna com 40+ chars + URL na mesma célula |
| ~331 | `G-matriz-decisao.md` | Tabelas “flutuando”, linhas quebradas feio | Mesmo padrão ASCII + `\small` global insuficiente |

**Padrão raiz:** o manuscrito ainda mistura **tabelas ASCII** (grid) com **tabelas pipe** (`| |`). No A4, grid tables herdam largura do texto monospace do `.md` e **não respeitam** a largura útil (~175 mm).

---

## 2. Inventário automático (rodar antes de cada lote)

```powershell
Set-Location "I:\VIPs-com\Guardião-Soberano"
.\scripts\auditoria-layout.ps1
```

### Arquivos com tabelas ASCII (prioridade alta — converter para pipe)

| Arquivo | Blocos ASCII | Agente |
| --- | --- | --- |
| `G-matriz-decisao.md` | 7 | 10 |
| `13-ecossistema-completo.md` | 5 | 10 |
| `F-troubleshooting.md` | 2 | 10 |
| `14-ferramentas-alternativas.md` | 2 | 10 |
| `15-itens-que-salvam-vidas.md` | 1 | 10 |
| `E-aspectos-legais-brasil.md` | 1 | 10 |
| `17-12-leis-do-guardiao.md` | 1 | 10 |

### Arquivos com tabelas pipe (revisar colunas largas)

Caps. 1, 6–8, 10–12, 16, Ap. D, `parte-II-trilha.md` — **Agente 10** valida fingerprints, URLs e colunas > 35 caracteres.

---

## 3. Equipe de agentes (paralelo)

```
┌─────────────────────────────────────────────────────────────┐
│  COORDENADOR (você ou IA principal)                         │
│  · Roda auditoria-layout.ps1 + compila.ps1 -All             │
│  · Distribui lotes · Marca ✅ no checklist abaixo           │
└─────────────────────────────────────────────────────────────┘
         │              │              │              │
         ▼              ▼              ▼              ▼
   AGENTE 09      AGENTE 10      AGENTE 11      AGENTE 08
   Tipografia      Tabelas        Quebras        Comandos
   LaTeX/CSS       MD→pipe        de página      (já feito)
```

### Agente 09 — Tipografia moderna

**Entrada:** `compila.ps1`, `recursos/latex-header.tex`, `recursos/stylesheet.css`

**Stack proposta (OFL, boa cobertura PT-BR):**

| Papel | Fonte | Fallback |
| --- | --- | --- |
| Corpo | **IBM Plex Serif** 10 pt | DejaVu Serif |
| Títulos | **IBM Plex Sans** Bold | DejaVu Sans |
| Código | **IBM Plex Mono** 8 pt (Scale 0.85) | DejaVu Sans Mono |

Alternativa: **Source Serif 4** + **Source Sans 3** + **Source Code Pro**.

**Instalação Windows (uma vez):**

1. Baixar IBM Plex em https://github.com/IBM/plex/releases  
2. Instalar `.ttf` no sistema (clique direito → Instalar para todos)  
3. Recompilar: `.\compila.ps1 -PDF`

**Critérios de aceite:**

- [ ] PDF abre sem fallback para Cambria/Consolas  
- [ ] Títulos visualmente distintos do corpo (sans vs serif)  
- [ ] EPUB/CSS alinhado à mesma família  

### Agente 10 — Tabelas

**Regra:** nenhuma tabela ASCII no manuscrito final. Usar **pipe tables** Markdown:

```markdown
| Situação | Ferramenta | Notas |
| --- | --- | --- |
| Swap BTC→XMR | eigenwallet | Tor nativo |
```

**Colunas largas (fingerprints, URLs):**

- Opção A: duas linhas na célula — fingerprint numa linha, URL na seguinte (sem barra longa)  
- Opção B: tabela de 2 colunas (Projeto | Fingerprint) + lista separada de URLs  
- Opção C: `\footnotesize` só na tabela via bloco raw LaTeX (último recurso)

**Modelo Ap. D (PGP):**

```markdown
| Projeto | Fingerprint |
| --- | --- |
| Sparrow | `D4D0D320…674B40` |
| Whonix | `916B8D99…ACCDA` |

Fontes oficiais: sparrowwallet.com/download/ · whonix.org/wiki/Signing_Key · …
```

**Lotes sugeridos:**

| Lote | Arquivos |
| --- | --- |
| T1 | `G-matriz-decisao.md`, `14-ferramentas-alternativas.md` |
| T2 | `13-ecossistema-completo.md`, `F-troubleshooting.md` |
| T3 | `15`, `E`, `17` + revisão pipe em `D-guia-verificacao-pgp.md` |
| T4 | Caps. 6–8, 10–12 (tabelas pipe já existentes — só QA) |

**Critérios de aceite (por tabela):**

- [ ] Nenhum texto cortado na margem direita  
- [ ] Cabeçalho repetido se tabela > 1 página (`longtable` automático do Pandoc)  
- [ ] Máx. 4 colunas no A4; se 5+, dividir em duas tabelas  

### Agente 11 — Quebras de página e “tabulação”

**Entrada:** `latex-header.tex` + revisão visual PDF

**Ajustes LaTeX (já iniciados em `latex-header.tex`):**

- `needspace` / `penalty` — evitar título órfão no fim da página  
- `longtable` + `tabularx` — tabelas multi-página  
- `\AtBeginEnvironment{table}{\small}` — miolo de tabela menor que corpo  

**Padrões editoriais:**

| Elemento | Regra |
| --- | --- |
| `##` título | Nunca sozinho na última linha da página (`needspace{3\baselineskip}` antes de seções) |
| Tabela | Preferir começar após título; se < 4 linhas, manter bloco junto |
| Blockquote AVISO | Não partir entre páginas se < 6 linhas |
| Lista `- [ ]` checklist | OK partir; evitar 1 item solto no fim |

**Páginas-spot (conferir na prova impressa):**

| Faixa | Conteúdo |
| --- | --- |
| 240–255 | Cap. 14 ferramentas |
| 305–315 | Ap. D PGP |
| 325–335 | Ap. G matriz |
| 275–295 | Ap. A glossário |

**Critérios de aceite:**

- [ ] Nenhuma tabela partida com 1 linha órfã  
- [ ] Nenhum `##` isolado no rodapé  
- [ ] URLs longas quebram dentro da margem (pacote `xurl` / `\url`)  

### Agente 08 — Comandos (regressão)

Revalidar após mudanças: blocos `bash` ≤ 72 caracteres, Ap. C/D, Caps. 7–10.

---

## 4. Como avaliar (fluxo humano + agentes)

### Passo A — Automático (5 min)

```powershell
.\scripts\auditoria-layout.ps1
.\compila.ps1 -All
```

Registrar: contagem ASCII tables, linhas > 72 em código, URLs > 50 chars em tabelas.

### Passo B — PDF digital (30 min)

Abrir `saida/guardiao-soberano-v1.1.pdf`:

1. Sumário → saltar para Ap. D, G, Cap. 14  
2. Zoom 100% — verificar margem direita em **cada** tabela  
3. Buscar “github.com” — nenhuma URL cortada  

### Passo C — Prova gráfica (humano)

Usar [`recursos/prova-grafica-checklist.md`](../recursos/prova-grafica-checklist.md) + esta auditoria.

### Passo D — Fechamento lote

Para cada lote concluído:

1. `git diff manuscrito/`  
2. Recompilar  
3. Marcar checklist §6  
4. Commit: `fix(layout): lote T1 tabelas Cap 14 e Ap G`  

---

## 5. Ordem de execução recomendada

| Fase | Escopo | Duração est. |
| --- | --- | --- |
| **F0** | Rodar script + baseline PDF | 15 min |
| **F1** | LaTeX header (tabelas + quebras) | 1 h |
| **F2** | Agente 10 — converter 7 arquivos ASCII | 2–3 h |
| **F3** | Agente 09 — IBM Plex + CSS | 1 h |
| **F4** | Agente 11 — spot review 20 páginas | 1 h |
| **F5** | Prova gráfica 1 cópia | humano |

---

## 6. Checklist de fechamento v1.2

```
□ scripts/auditoria-layout.ps1 → 0 tabelas ASCII
□ Ap. D PGP sem overflow
□ Ap. G e Cap. 14 tabelas pipe
□ Cap. 17 resumo 12 leis em pipe table
□ F-troubleshooting legível (ou dividido em 2 tabelas)
□ Fonte IBM Plex (ou Source) no PDF
□ EPUB/CSS sincronizado
□ prova-grafica-checklist preenchido
□ PDF gráfica recompilado
```

---

## 7. Prompts prontos para subagentes

### Agente 10 — Lote T1

```
Converta TODAS as tabelas ASCII em G-matriz-decisao.md e
14-ferramentas-alternativas.md para pipe tables Markdown.
A4: máx. 4 colunas; fingerprints em linha própria; URLs curtas
ou lista abaixo da tabela. Não altere conteúdo técnico.
Rode mentalmente: largura útil ~55 caracteres por coluna.
```

### Agente 09 — Fontes

```
Instale IBM Plex no sistema, atualize compila.ps1 e stylesheet.css
para IBM Plex Serif/Sans/Mono. Mantenha DejaVu como fallback.
Teste compila.ps1 -PDF e confirme ausência de Cambria no log.
```

### Agente 11 — Quebras

```
Revise latex-header.tex: needspace, longtable, penalties.
Recompile e liste páginas 240-255, 305-335 com problemas
de título órfão ou tabela partida. Sugira \newpage apenas
onde necessário no .md (último recurso).
```

---

## 8. Referências

- Pipeline: `compila.ps1`, `recursos/latex-header.tex`  
- Prova: `recursos/prova-grafica-checklist.md`  
- Spec A4: `compila.ps1` (margens, 10 pt, IBM Plex)  
