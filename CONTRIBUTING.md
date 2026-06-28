# Como contribuir

Obrigado por ajudar a manter o **Guardião Soberano** — livro e laboratório prático.

---

## O que entra no git (repositório local)

```
Guardião-Soberano/
├── README.md, LICENSE, CHANGELOG.md, SECURITY.md
├── CONTRIBUTING.md          # este arquivo
├── compila.ps1
├── scripts/                 # build publico (capa, P&B, auditoria)
├── manuscrito/              # livro
├── laboratorio/             # tutoriais e scripts
├── recursos/, imagens/
└── .github/                 # templates e CI (so roda se houver remote)
```

**Não versionar** (`.gitignore`):

| Pasta / arquivo | Motivo |
| --- | --- |
| `soberano-equipe-dev/` | Pipeline interno, validação, relatórios agentes |
| `old/` | Backups e duplicatas históricas |
| `saida/` | Binários compilados (PDF, EPUB, MOBI) |
| `docs/` | Legado — usar `soberano-equipe-dev/docs/` |
| `CLAUDE.md` / `.claude/` | Contexto IA local |
| `analise-pesquisas.md` | Notas de pesquisa local |

Reorganizar localmente após restaurar backup:

```powershell
.\soberano-equipe-dev\scripts\organizar-casa.ps1
```

Estrutura interna (`soberano-equipe-dev/`):

```
docs/validacao/     Checklists de hardware e PGP
docs/relatorios/    Entregas e integração
pesquisas/canonico/ Fonte para extrair labs
scripts/            organizar-casa.ps1, etc.
prompts/            Contexto IA (ex.: Privacy-OS-Hub) + cópia Guardião
```

**Mantenedores:** leia **`CLAUDE.md` na raiz** (gitignored) e **`soberano-equipe-dev/docs/processo/RETOMAR-AGENTES.md`** antes de sessões de validação.

---

## Git — local → remoto (fase final)

- Commits no disco: `git commit` — **sem push** até checklist [`CONFIRM-PRE-REMOTO`](soberano-equipe-dev/docs/CONFIRM-PRE-REMOTO.md) (R1–R10).
- Não versionar: `soberano-equipe-dev/`, `saida/*` (exc. `saida/README.md`), `old/`, `CLAUDE.md`.
- **Backup** antes do primeiro push: `.\soberano-equipe-dev\scripts\bkp\backup-camada-local.ps1`

### Release vs git

| Destino | Conteúdo |
| --- | --- |
| **Git** | Fontes: manuscrito, labs, recursos, imagens |
| **GitHub Release** | `saida/*.pdf` (digital), `*.epub`, `*.mobi` |
| **Só local** | `*-grafica*.pdf`, pesquisas, prompts agentes |

(Scripts e docs internos não entram no git.)

---

## Contribuir com o livro (`manuscrito/`)

1. Nunca alterar conteúdo técnico sem verificar **fontes oficiais**.
2. Preservar o tom mentor (Maria, João, metáforas da trilha).
3. Contradições: o arquivo `.md` individual mais recente prevalece.
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
5. Não colar “complementos técnicos” brutos — reescreva no template.

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

## Releases e versionamento (local)

Tags locais quando a validação hardware fechar:

```powershell
git tag -a v1.1.0 -m "Guardião Soberano v1.1.0"
```

PDF/EPUB ficam em `saida/` — distribuição manual, não versionada no git.

| Tag | Conteúdo |
| --- | --- |
| `v1.0.0` | Livro inicial |
| `v1.1.0` | Livro revisado + mapa ambientes (após hardware 🔴) |
| `v1.1-labs` | Labs testados em hardware (futuro) |

---

## Documentação interna da equipe

Relatórios de processo ficam em `soberano-equipe-dev/` (não versionados):

- `docs/processo/RETOMAR-AGENTES.md` — prompt rodada 2
- `docs/validacao/VERIFICACAO-v1.1.md` — checklist Ap. B–F
- `docs/validacao/VALIDACAO-LABORATORIO-29.md` — matriz dos labs

---

## Código de conduta

Seja respeitoso. Este projeto trata de soberania financeira — iniciantes são bem-vindos.
Não humilhar por erros; corrigir com clareza e paciência.

---

## Licença das contribuições

Ao contribuir, você concorda que o conteúdo será licenciado sob **CC BY-NC-SA 4.0**
(scripts sob **MIT** quando aplicável). Ver [`LICENSE`](LICENSE).
