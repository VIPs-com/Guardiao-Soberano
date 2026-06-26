# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).  
Versionamento: [Semantic Versioning](https://semver.org/lang/pt-BR/).

---

## [Unreleased]

### Adicionado

- **Laboratório:** trilha N0–N7 completa (29 labs + 2 opcionais); scripts Tails (`start-sparrow`, `start-keepass`, `start-electrum`, `start-feather`, `start-retoswap`, `backup-persistencia`)
- **Livro:** Feather no Apêndice D (fingerprint + seção 2.8.1); leitura complementar no Cap. 11
- **Repositório:** `LICENSE`, `CONTRIBUTING.md`, `SECURITY.md`, `CHANGELOG.md`; CI de links; templates de issue
- **Equipe (local, gitignored):** `VALIDACAO-AMBIENTE.md`, `VALIDACAO-LABORATORIO-29.md`; reorganização `soberano-equipe-dev/`

### Alterado

- Cap. 7 (N2): revisão P0–P1 — watching-only, KeePassXC sem seed, Electrum xpub, PSBT SD/QR
- Cap. 6 (N1): revisão P0–P1 + passada estilo/gramática
- Cap. 5 (N0): revisão P0–P2 + passada estilo/gramática
- Manuscrito: diagramas incorporados nos Caps. 6, 9, 10 e 13 (`../imagens/*.png`)
- Labs: caminhos relativos corrigidos para `../../imagens/`
- `compila.ps1`: `--resource-path` para embutir diagramas no EPUB/MOBI
- `README.md`: status remote GitHub pendente aprovação
- Cap. 8 e Apêndice C: verificação PGP Feather alinhada ao Apêndice D (keyserver + fingerprint)
- Cap. 11: seção de leitura complementar (ponte ao Cap. 13)
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
