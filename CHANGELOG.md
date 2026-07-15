# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).  
Versionamento: [Semantic Versioning](https://semver.org/lang/pt-BR/).

---

## [Unreleased]

---

## [1.1.4] — 2026-07-15

### Alterado

- **Manuscrito Cap. 8 + Ap. C:** caminho canônico Debian = scripts `gs-whonix-*` (install → MOK → sign → verify-host → import); `dist-installer-cli` como Opção B alternativa
- **`compila.ps1`:** raiz do repo via `$PSScriptRoot` (não depende mais do drive `I:\`)
- **PDF/EPUB/MOBI** recompilados com o manuscrito atualizado

### Release

- [v1.1.4](https://github.com/VIPs-com/Guardiao-Soberano/releases/tag/v1.1.4) — PDF, EPUB, MOBI, gráfica

> Tags intermediárias sem artefatos de livro: [v1.1.2](https://github.com/VIPs-com/Guardiao-Soberano/releases/tag/v1.1.2) (fixes lab Whonix) · [v1.1.3](https://github.com/VIPs-com/Guardiao-Soberano/releases/tag/v1.1.3) (sanitize `virtualbox.list`).

---

## [1.1.1] — 2026-07-04

### Adicionado

- **Laboratório N3/01:** scripts `gs-whonix-install-virtualbox.sh`, `gs-whonix-import-ova.sh`, `gs-verificar-tor.sh` (trilha Whonix 18.x LXQt autocontida)

### Alterado

- **Manuscrito:** Caps. 08, C e Ap. D — fluxo `derivative.asc` (sem keyserver)
- Lab `01-whonix-virtualbox-completo.md` e `03-verificacao-pgp-downloads.md` — VirtualBox verificado + Whonix 18 LXQt
- PDF/EPUB/MOBI recompilados com manuscrito atualizado

### Release

- [v1.1.1](https://github.com/VIPs-com/Guardiao-Soberano/releases/tag/v1.1.1) — PDF, EPUB, MOBI, gráfica

---

## [1.1.0] — 2026-06-28

### Adicionado

- **Mapa de ambientes:** Cap. 13.4–13.8 (matriz operação × ambiente, PSBT, migração Tails→Whonix, `/psbt_bridge`)
- **Cap. 14.0b** — air-gap vs Tails vs Whonix vs mobile; árvore de decisão
- **Apêndice H** — consulta rápida (três perguntas + matriz + fluxos)
- **Glossário:** entradas expandidas air-gap, PSBT bridge, watch-only, Tails A/B, Whonix
- **Labs no miolo:** blocos **Lab:** Caps. 9–10 (N4 Whirlpool, N5 swap/ABCTracer)
- Manuscrito v1.1 completo (31 arquivos `.md`); trilha N0–N7 (~46k palavras)
- **Laboratório:** 29 labs + 2 opcionais; scripts Tails (`start-sparrow`, `start-keepass`, `start-electrum`, `start-feather`, `start-retoswap`, `backup-persistencia`)
- **Ícones de nível:** redesign N0–N7 (SVG paths, fundo escuro, 30mm no PDF)
- **Capa:** Canva — cadeado geométrico + ₿; `cover-master.png`, `cover-a4.png`, `cover.jpg`
- **Imagens P&B:** `imagens/pb/` — 5 diagramas para miolo gráfico
- **Scripts:** `export-cover-portrait.ps1`; pipeline `compila.ps1` (PDF, EPUB, MOBI, PDF/X-1a)
- **Apêndice D:** Feather Wallet + Electrum ThomasV fingerprints completos
- `LICENSE`, `CONTRIBUTING.md`, `SECURITY.md`; CI de links; templates de issue
- **Release GitHub:** [v1.1.0](https://github.com/VIPs-com/Guardiao-Soberano/releases/tag/v1.1.0) com PDF, EPUB e MOBI

### Alterado

- Prefácio, Parte III, Ap. G — referências ao mapa de ambientes
- Caps. 7, 8, 11, 15, 16 — cross-links Ap. H e labs
- **Rodada 2 (IA):** links labs Caps. 5–8, 11–12; Cap. 6 Passo 1.4 alinhado com lab N1/01
- **Tipografia PDF/EPUB:** IBM Plex Serif + IBM Plex Sans
- **Tabelas:** pipe tables reformatadas em todos os caps e apêndices
- Caps 05–12: complementos técnicos integrados/limpos (~29K palavras de duplicatas removidas)

### Corrigido

- Fluxo eigenwallet (BTC→XMR) / RetoSwap (XMR→BTC) em caps 8, 10 e matriz G
- **Preços hardware:** Coldcard MK5 US$150→US$170; Jade → Jade Plus US$169
- **RetoSwap/Haveno** → **RetoSwap (ex-Haveno)** (glossário, cap. 14, matriz G)
- **IN 2291/2025 — DeCripto** (caps 10, 11); vigência 01/07/2026
- Fingerprints PGP, versões de software (jun/2026); links EPUB internos (19 IDs)
- **Electrum** 4.5.5→4.7.2; **Feather** 2.7.0→2.8.1; hierarquia H2→H3 (caps 7, 10)

---

## [1.0.0] — 2026-06-24

### Adicionado

- Estrutura inicial do repositório
- Trilha do Guardião (8 níveis) extraída e complementada
- Script `compila.ps1`
- Revisão técnica inicial

---

[Unreleased]: https://github.com/VIPs-com/Guardiao-Soberano/compare/v1.1.4...HEAD
[1.1.4]: https://github.com/VIPs-com/Guardiao-Soberano/releases/tag/v1.1.4
[1.1.1]: https://github.com/VIPs-com/Guardiao-Soberano/releases/tag/v1.1.1
[1.1.0]: https://github.com/VIPs-com/Guardiao-Soberano/releases/tag/v1.1.0
