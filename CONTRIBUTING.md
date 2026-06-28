# Como contribuir

Obrigado por ajudar a manter o **Guardião Soberano** — livro e laboratório prático.

---

## O que entra no repositório

```
Guardião-Soberano/
├── README.md, LICENSE, CHANGELOG.md, SECURITY.md
├── CONTRIBUTING.md
├── compila.ps1
├── scripts/                 # build: capa, diagramas P&B
├── manuscrito/              # livro
├── laboratorio/             # tutoriais e scripts
├── recursos/, imagens/
└── .github/                 # templates e CI
```

**Não versionado** (`.gitignore`):

| Pasta / arquivo | Motivo |
| --- | --- |
| `saida/` | Binários compilados (PDF, EPUB, MOBI) — distribuídos via Releases |
| `old/` | Backups e duplicatas históricas |
| `CLAUDE.md` / `.claude/` | Contexto de IA local |

---

## Contribuir com o livro (`manuscrito/`)

1. Nunca alterar conteúdo técnico sem verificar **fontes oficiais** (fingerprints, versões, preços).
2. Preservar o tom mentor — didático, encorajador. Metáforas (semente, cofre, ponte) são intencionais.
3. Personagens de exemplo: **Maria** e **João** — manter consistência.
4. Abra uma **issue** antes de mudanças estruturais (reordenar capítulos, cortar trilha).

Compilar após editar:

```powershell
.\compila.ps1 -All
```

---

## Contribuir com labs (`laboratorio/`)

### Antes de abrir PR

1. Copie [`laboratorio/_template-lab.md`](laboratorio/_template-lab.md).
2. Teste em **Tails ou Whonix real** (não só leitura).
3. Atualize `last-tested:` e versões de software no cabeçalho.
4. Inclua seção **Como confirmar que deu certo** com checklist verificável.
5. Não colar notas brutas de pesquisa — reescreva no template.

### Padrão de branch

```
feat/lab-nivel-2-sparrow-watching-only
fix/lab-nivel-5-retoswap-passo-3
docs/changelog-v1.2
```

### Scripts (`.sh`)

- Licença **MIT** no cabeçalho (`SPDX-License-Identifier: MIT`).
- Texto claro, comentado linha a linha — sem binários de terceiros.
- Salvar em `laboratorio/scripts/tails/` ou `laboratorio/scripts/whonix/`.

### Reportar lab desatualizado

Use o template **Lab desatualizado** em Issues (nível, software, versão testada, o que falhou).

### Reportar erro de comando

Use o template **Erro de comando** (lab, passo, SO, mensagem de erro).

---

## Releases e versionamento

| Tag | Conteúdo |
| --- | --- |
| `v1.0.0` | Livro inicial |
| `v1.1.0` | Livro revisado + mapa ambientes |
| `v1.1-labs` | Labs validados em hardware (futuro) |

Os binários (PDF/EPUB/MOBI) são publicados como **GitHub Release** — não ficam no git.

---

## Código de conduta

Seja respeitoso. Este projeto trata de soberania financeira — iniciantes são bem-vindos.
Corrija com clareza e paciência.

---

## Licença das contribuições

Ao contribuir, você concorda que o conteúdo será licenciado sob **CC BY-NC-SA 4.0**
(scripts sob **MIT** quando aplicável). Ver [`LICENSE`](LICENSE).
