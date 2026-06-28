# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).  
Versionamento: [Semantic Versioning](https://semver.org/lang/pt-BR/).

---

## [Unreleased]

### Adicionado

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

[Unreleased]: https://github.com/SEU-USUARIO/Guardiao-Soberano/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/SEU-USUARIO/Guardiao-Soberano/releases/tag/v1.1.0
[1.0.0]: https://github.com/SEU-USUARIO/Guardiao-Soberano/releases/tag/v1.0.0
