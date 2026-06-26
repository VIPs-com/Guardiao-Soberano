# Como contribuir

Obrigado por ajudar a manter o **Guardião Soberano** — livro e laboratório prático.

---

## O que vai para o repositório público

```
Guardião-Soberano/
├── README.md, LICENSE, CHANGELOG.md, SECURITY.md
├── CONTRIBUTING.md          # este arquivo
├── compila.ps1
├── manuscrito/              # livro
├── laboratorio/             # tutoriais e scripts
├── recursos/, imagens/
└── .github/                 # templates e CI
```

**Não publicar** (`.gitignore`):

| Pasta | Motivo |
| --- | --- |
| `soberano-equipe-dev/` | Pipeline interno — ver estrutura abaixo |
| `old/` | Backups e duplicatas históricas |
| `saida/` | Binários compilados → usar **GitHub Releases** |

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
prompts/            Contexto IA
```

(Scripts e docs internos não vão ao remoto.)

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

## Releases e versionamento

| Tag | Conteúdo |
| --- | --- |
| `v1.0.0` | Livro inicial |
| `v1.1.0` | Livro revisado + auditoria |
| `v1.1-labs` | Laboratório com labs testados (futuro) |

Ao publicar PDF/EPUB na Release, inclua **SHA-256** do arquivo no corpo da release.

---

## Documentação interna da equipe

Relatórios de processo ficam em `soberano-equipe-dev/` (não versionados no remoto público):

- `docs/validacao/VALIDACAO-LABORATORIO-29.md` — testes dos 29 labs
- `docs/validacao/VERIFICACAO-TECNICA-PENDENTE.md`
- `docs/relatorios/RELATORIO-INTEGRACAO-COMPLEMENTOS.md`
- `config/relatorio-repositorio-guardiao-soberano.md` — padrões OSS e checklist de push

---

## Código de conduta

Seja respeitoso. Este projeto trata de soberania financeira — iniciantes são bem-vindos.
Não humilhar por erros; corrigir com clareza e paciência.

---

## Licença das contribuições

Ao contribuir, você concorda que o conteúdo será licenciado sob **CC BY-NC-SA 4.0**
(scripts sob **MIT** quando aplicável). Ver [`LICENSE`](LICENSE).
