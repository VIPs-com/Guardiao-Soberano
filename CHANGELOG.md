# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).  
Versionamento: [Semantic Versioning](https://semver.org/lang/pt-BR/).

---

## [Unreleased]

### Adicionado

- **Mapa de ambientes:** Cap. 13.4–13.8 (matriz operação × ambiente, PSBT, migração Tails→Whonix, `/psbt_bridge`)
- **Cap. 14.0b** — air-gap vs Tails vs Whonix vs mobile; árvore de decisão
- **Apêndice H** — consulta rápida (três perguntas + matriz + fluxos)
- **Glossário:** entradas expandidas air-gap, PSBT bridge, watch-only, Tails A/B, Whonix
- **Docs versionados:** movidos para `soberano-equipe-dev/docs/` (offline, `.gitignore`)
- **Labs no miolo:** blocos **Lab:** Caps. 9–10 (N4 Whirlpool, N5 swap/ABCTracer)
- **KruxMobileApp, Specter, mapa 14.0** (rodada anterior consolidada neste push)

### Alterado

- Prefácio, Parte III, Ap. G — referências ao mapa de ambientes
- Caps. 7, 8, 11, 15, 16 — cross-links Ap. H e labs
- `README.md` — git local, pasta equipe offline
- `compila.ps1` — inclui `H-ambientes-fluxos.md`

### Próximo (rodada 2 — git local)

- Validação hardware 18 labs 🔴 — `soberano-equipe-dev/docs/validacao/VERIFICACAO-v1.1.md`
- Prova gráfica 1× · tag `v1.1.0` **local** (sem push)

---

## [Unreleased — histórico jun 2026]

### Adicionado (jun 2026)

- **Ícones de nível:** redesign completo N0–N7 com SVG paths puros (sem emoji); fundo escuro radial consistente com a capa; símbolos corretos: N2 floco (carteira fria), N3 olho (observador), N5 BTC↔XMR; tamanho 30mm no PDF
- **Capa:** redesign completo (Canva) — cadeado geométrico 3D com glow laranja Bitcoin ₿, fundo azul profundo radial, tipografia Montserrat Black em duas cores; `cover-masters-aprovada.png` preservado como original aprovado
- **Scripts:** `export-cover-portrait.ps1` unificado — gera e-book (1600×2560) e A4 gráfica (2480×3508 @300 Dpi) a partir do mesmo master
- **Integração complementos caps 05–12:** ~29K palavras de lixo/duplicatas removidas; `RELATORIO-INTEGRACAO-COMPLEMENTOS.md` criado
- **Imagens P&B:** `imagens/pb/` — 5 diagramas em preto e branco para miolo gráfico
- **Laboratório:** trilha N0–N7 completa (29 labs + 2 opcionais); scripts Tails (`start-sparrow`, `start-keepass`, `start-electrum`, `start-feather`, `start-retoswap`, `backup-persistencia`)
- **Livro:** Feather no Apêndice D (fingerprint + seção 2.8.1); leitura complementar no Cap. 11
- **Repositório:** `LICENSE`, `CONTRIBUTING.md`, `SECURITY.md`, `CHANGELOG.md`; CI de links; templates de issue

### Alterado

- **Capa:** `imagens/cover-master.png` (1600×2560), `cover-a4.png` (2480×3508), `recursos/cover.jpg` (674 KB), `recursos/cover-a4.jpg` (1210 KB) — versão Canva aprovada
- **Tipografia PDF/EPUB:** IBM Plex Serif + IBM Plex Sans (Agente 09)
- **Tabelas:** pipe tables reformatadas em todos os caps e apêndices (Agente 10)
- **Layout:** quebras de página e tabelas Apêndice G (Agente 11)
- **`compila.ps1`:** pipeline P&B separado (miolo gráfica ≠ PDF digital); capa A4; fontes IBM Plex
- Caps 05–12: complementos técnicos integrados/limpos (word count final ~45.948)
- Correções técnicas jun/2026: fingerprints PGP, Krux v26.04.0, Coldcard US$170, Jade Plus US$169, Feather 2.8.1, RetoSwap v1.8.0-reto, FCMP++ datas, links EPUB internos
- Triagens T5–T6 + links lab EPUB-safe; fechamento editorial v1.1
- `README.md` com badges e mapa livro + laboratório

### Corrigido (Agentes A–D, 27 jun 2026)

- **Preços hardware** (G-matriz-decisao.md, frontmatter-02-creditos.md, F-troubleshooting.md): Coldcard MK5 US$150→US$170; "Blockstream Jade" → "Blockstream Jade Plus US$169"
- **RetoSwap/Haveno** (G-matriz-decisao.md ×2, A-glossario.md, 14-ferramentas-alternativas.md): "Haveno (RetoSwap)" → "RetoSwap (ex-Haveno)"; glossário reformulado com RetoSwap como nome primário
- **IN 2291/2025 — DeCripto** (11-nivel-6-soberano.md ×2, 10-nivel-5-trocador.md): referências à IN 1888 atualizadas para mencionar substituição por IN 2291/2025 a partir de 01/07/2026
- **Link lab N1/03** (07-nivel-2-carteira-fria.md): `(Cap. 6 / lab N1/03)` → backtick com caminho completo (EPUB-safe)
- **metadata.opf:** `<dc:title>` recebia `id="title"` ausente; `<meta refines="#title">` agora resolve corretamente; data dcterms:modified atualizada para 2026-06-27
- **Hierarquia H2→H3** (07-nivel-2-carteira-fria.md): 14 sub-headings nas seções KeePassXC e Electrum corrigidos de `##` para `###`
- **Hierarquia H2→H3** (10-nivel-5-trocador.md): 13 sub-headings nas seções Restore Height e eigenwallet corrigidos de `##` para `###`
- **Electrum ThomasV fingerprint** (D-guia-verificacao-pgp.md, 07-nivel-2-carteira-fria.md): placeholder `<FINGERPRINT-ELECTRUM-APD-D>` substituído pelo fingerprint real `6694D8DE7BE8EE5631BED9502BD5824B7F9470E6` (verificado em electrum.org + github.com/spesmilo/electrum/pubkeys/ThomasV.asc); versão atualizada 4.5.5→4.7.2; seção de verificação completa adicionada ao Ap. D

---

## [1.1.0] — 2026-06-25

### Adicionado

- Manuscrito v1.1 completo (31 arquivos `.md`)
- Integração e limpeza dos complementos técnicos (caps 5–12)
- Auditoria pré-publicação (Fase 10)
- Compilação: PDF digital, EPUB, MOBI, PDF/X-1a gráfica
- Diagramas, ícones de níveis, capa EPUB

### Corrigido

- Fluxo eigenwallet (BTC→XMR) / RetoSwap (XMR→BTC) em caps 8, 10 e matriz G
- Blocos Conquista e transições caps 5–12
- Fingerprints PGP, versões de software (jun/2026)

---

## [1.0.0] — 2026-06-24

### Adicionado

- Estrutura inicial do repositório
- Trilha do Guardião (8 níveis) extraída e complementada
- Script `compila.ps1`
- Revisão técnica Fases 4–7

---

<!-- Links de release: preencher quando houver remote aprovado -->
<!-- [Unreleased]: ... -->
<!-- [1.1.0]: ... -->
<!-- [1.0.0]: ... -->
