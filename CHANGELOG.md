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
- **Labs no miolo:** blocos **Lab:** Caps. 9–10 (N4 Whirlpool, N5 swap/ABCTracer)
- **KruxMobileApp, Specter, mapa 14.0** (consolidado neste push)
- **Ícones de nível:** redesign completo N0–N7 com SVG paths puros; fundo escuro radial; símbolos corretos (N2 floco, N3 olho, N5 BTC↔XMR); tamanho 30mm no PDF
- **Capa:** redesign completo (Canva) — cadeado geométrico 3D com glow laranja ₿, fundo azul profundo, tipografia Montserrat Black; `cover-masters-aprovada.png` preservado como original aprovado
- **Scripts:** `export-cover-portrait.ps1` — gera e-book (1600×2560) e A4 gráfica (2480×3508 @300 dpi) a partir do mesmo master
- **Integração complementos caps 05–12:** ~29K palavras de lixo/duplicatas removidas
- **Imagens P&B:** `imagens/pb/` — 5 diagramas em preto e branco para miolo gráfico
- **Laboratório:** trilha N0–N7 completa (29 labs + 2 opcionais); scripts Tails (`start-sparrow`, `start-keepass`, `start-electrum`, `start-feather`, `start-retoswap`, `backup-persistencia`)
- **Apêndice D:** Feather Wallet fingerprint + seção 2.8.1; Electrum ThomasV fingerprint completo

### Alterado

- Prefácio, Parte III, Ap. G — referências ao mapa de ambientes
- Caps. 7, 8, 11, 15, 16 — cross-links Ap. H e labs
- **Rodada 2 (IA):** links labs Caps. 5–8, 11–12; Cap. 6 Passo 1.4 alinhado com lab N1/01
- **Tipografia PDF/EPUB:** IBM Plex Serif + IBM Plex Sans
- **Tabelas:** pipe tables reformatadas em todos os caps e apêndices
- **Layout:** quebras de página e tabelas Apêndice G
- **`compila.ps1`:** pipeline P&B separado (miolo gráfica ≠ PDF digital); capa A4; fontes IBM Plex
- Caps 05–12: complementos técnicos integrados/limpos (word count final ~46k)
- **Capa:** `cover-master.png` (1600×2560), `cover-a4.png` (2480×3508), `cover.jpg` (674 KB)

### Corrigido

- **Preços hardware:** Coldcard MK5 US$150→US$170; Blockstream Jade → Jade Plus US$169
- **RetoSwap/Haveno** (glossário, cap. 14, matriz G): "Haveno (RetoSwap)" → "RetoSwap (ex-Haveno)"
- **IN 2291/2025 — DeCripto** (caps 10, 11): referências à IN 1888 atualizadas; vigência 01/07/2026
- **Link lab N1/03** (cap. 7): backtick com caminho completo (EPUB-safe)
- **metadata.opf:** `<dc:title id="title">` e `<meta refines="#title">` corrigidos
- **Hierarquia H2→H3** (caps 7, 10): 27 sub-headings corrigidos
- **Electrum ThomasV fingerprint** (Ap. D, cap. 7): `6694D8DE7BE8EE5631BED9502BD5824B7F9470E6`; versão 4.5.5→4.7.2
- **Feather Wallet** (caps 8, 11): feather-2.7.0 → feather-2.8.1

---

## [1.1.0] — 2026-06-25

### Adicionado

- Manuscrito v1.1 completo (31 arquivos `.md`)
- Integração e limpeza dos complementos técnicos (caps 5–12)
- Compilação: PDF digital, EPUB, MOBI, PDF/X-1a gráfica
- Diagramas, ícones de níveis, capa EPUB
- `LICENSE`, `CONTRIBUTING.md`, `SECURITY.md`; CI de links; templates de issue

### Corrigido

- Fluxo eigenwallet (BTC→XMR) / RetoSwap (XMR→BTC) em caps 8, 10 e matriz G
- Blocos Conquista e transições caps 5–12
- Fingerprints PGP, versões de software (jun/2026)
- Links EPUB internos (19 links corrigidos para IDs reais)

---

## [1.0.0] — 2026-06-24

### Adicionado

- Estrutura inicial do repositório
- Trilha do Guardião (8 níveis) extraída e complementada
- Script `compila.ps1`
- Revisão técnica inicial

---

<!-- Links de release: preencher após publicação no GitHub -->
<!-- [Unreleased]: https://github.com/VIPs-com/guardiao-soberano/compare/v1.1.0...HEAD -->
<!-- [1.1.0]: https://github.com/VIPs-com/guardiao-soberano/releases/tag/v1.1.0 -->
<!-- [1.0.0]: https://github.com/VIPs-com/guardiao-soberano/releases/tag/v1.0.0 -->
