# Checklist — Prova Gráfica (1 cópia)

Use este roteiro antes de aprovar a tiragem final. Arquivo para enviar à gráfica: `saida/guardiao-soberano-v1.1-grafica.pdf`.

Gerar arquivos atualizados:

```powershell
.\compila.ps1 -All
```

---

## Antes de enviar à gráfica

- [ ] PDF gráfica gerado hoje (`guardiao-soberano-v1.1-grafica.pdf`)
- [ ] Capa: `recursos/cover.jpg` (1600×2560 px, 300 DPI) incluída no EPUB; confirmar arte separada se a gráfica imprimir capa própria
- [ ] Metadados: título, subtítulo, versão 1.1, CC BY-NC-SA 4.0
- [ ] Formato miolo: **A4** (210×297 mm)
- [ ] Sangria: **3 mm** em todos os lados (confirmar com a gráfica na arte final)
- [ ] Margens: interna 20 mm (lombada), externa 15 mm, superior/inferior 18 mm
- [ ] Miolo: **P&B**, IBM Plex Serif 10 pt, títulos Plex Sans, código Plex Mono ~8 pt
- [ ] PDF: 1.3, grayscale, fontes embarcadas, 300 DPI (Ghostscript via `compila.ps1 -Grafica`)

---

## Páginas críticas (conferir na prova impressa)

| Página (aprox.) | O que verificar |
| --- | --- |
| Folha de rosto | Título, subtítulo, versão jun/2026 |
| Sumário | Caps. 1–17 + apêndices A–G; sem numeração em prefácio/partes |
| Cap. 5–12 (Trilha) | Checklists ☐ legíveis; comandos sem overflow |
| Cap. 7 | Aprofundamento SeedSigner + Electrum (listas não coladas) |
| Cap. 8 | Tabelas Whonix; blocos bash quebrados |
| Cap. 10 | Tabelas ABCTracer/cenários; tutorial eigenwallet |
| Cap. 16 | Checklist 28 itens (A1–G2) |
| Ap. B | Avisos `.onion` v3; sem linhas cortadas |
| Ap. C/D | Comandos curl/gpg dentro da margem |
| Diagramas | 5 PNGs em `imagens/` renderizados com legível contraste |

---

## Qualidade de impressão

- [ ] Texto nítido (sem blur ou toner falhando)
- [ ] Margem interna (lombada) confortável para leitura
- [ ] Código monospace legível (não menor que ~7 pt efetivo)
- [ ] Tabelas largas (Cap. 8, Ap. F) não cortadas
- [ ] Quebras de página aceitáveis (título órfão, bloco de código partido)
- [ ] Links URL no PDF digital OK; na prova impressa URLs legíveis se aparecerem

---

## Capa e acabamento (confirmar com gráfica)

- [ ] Capa colorida, laminação **fosca**
- [ ] Brochura com orelhas (se orçado)
- [ ] Papel miolo: offset 75 g/m² ou pólen bold 80 g/m²
- [ ] Lombada com título legível (espessura ~168 páginas no A4 atual)

---

## Validação técnica PDF/X (opcional)

- [ ] Abrir `guardiao-soberano-v1.1-grafica.pdf` no **Acrobat Pro** → Preflight → PDF/X-1a
- [ ] Ou validar com [veraPDF](https://verapdf.org/) (CLI ou GUI)

---

## Aprovação

| Campo | Valor |
| --- | --- |
| Data da prova | |
| Gráfica | |
| Aprovado por | |
| Alterações solicitadas | |
| Tiragem final autorizada | ☐ Sim ☐ Não — corrigir e reimprimir prova |

---

## Se encontrar erro

1. Anote página, seção e descrição (screenshot ou foto).
2. Corrija o `.md` correspondente em `manuscrito/`.
3. Recompile: `.\compila.ps1 -All`.
4. Solicite nova prova só do miolo (ou capa, se for o caso).
