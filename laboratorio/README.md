# Laboratório Prático — Guardião Soberano

Extensão **viva** do livro: tutoriais passo a passo, checklists de verificação e scripts auditáveis.

| Camada | Onde | Função |
| --- | --- | --- |
| **Livro** | `../manuscrito/` | Por quê, quando, decisões (PDF/EPUB estável) |
| **Laboratório** | `laboratorio/` (esta pasta) | Como fazer, comando a comando |
| **Scripts** | `laboratorio/scripts/` | Automação em texto claro (`.sh`) |

> Versão alvo do livro: **1.1** · Idioma: **pt-BR** · Licença: **CC BY-NC-SA 4.0**

---

## Índice por nível

| Nível | Pasta | Capítulo do livro | Status |
| --- | --- | --- | --- |
| 0 — A Semente | [nivel-0-semente/](nivel-0-semente/) | Cap. 5 | 🟡 Esqueleto |
| 1 — O Cofre | [nivel-1-cofre/](nivel-1-cofre/) | Cap. 6 | 🟡 Esqueleto |
| 2 — A Carteira Fria | [nivel-2-carteira-fria/](nivel-2-carteira-fria/) | Cap. 7 | 🟡 3 labs extraídos |
| 3 — O Observador | [nivel-3-observador/](nivel-3-observador/) | Cap. 8 | 🟡 Esqueleto |
| 4 — O Misturador | [nivel-4-misturador/](nivel-4-misturador/) | Cap. 9 | 🟡 Esqueleto |
| 5 — O Trocador | [nivel-5-trocador/](nivel-5-trocador/) | Cap. 10 | 🟡 Esqueleto |
| 6 — O Soberano | [nivel-6-soberano/](nivel-6-soberano/) | Cap. 11 | 🟡 Esqueleto |
| 7 — O Mestre | [nivel-7-mestre/](nivel-7-mestre/) | Cap. 12 | 🟡 Esqueleto |

Legenda: 🟢 Pronto · 🟡 Esqueleto / a recuperar das pesquisas · 🔴 Bloqueado (aguarda teste em ambiente real)

---

## Matriz de escolha (qual lab seguir?)

| Se você escolheu… | Labs prioritários |
| --- | --- |
| **Tails** (amnésico + persistência) | N2 KeePassXC/Electrum · N5 Feather + RetoSwap no Tails |
| **Whonix** (Gateway + Workstation) | N3 setup VirtualBox · N4 Whirlpool · N5 eigenwallet |
| **SeedSigner / Krux** (sem HW comercial) | N1 air-gap QR · N2 PSBT via QR |
| **Coldcard / Jade** (HW wallet) | N1 backup e teste de restauração · N2 PSBT via SD/QR |

---

## Template de cada lab

Todo exercício novo deve seguir [`_template-lab.md`](_template-lab.md):

1. Pré-requisitos e versões pinadas  
2. Passos numerados (copy-paste)  
3. **Como confirmar que deu certo**  
4. Troubleshooting → Apêndice F do livro  

---

## Inventário de recuperação

Material bruto a transformar em labs: [`INVENTARIO-RECUPERACAO.md`](INVENTARIO-RECUPERACAO.md)

Fontes internas (equipe): `soberano-equipe-dev/Markdown-organizado/` e `old/manuscrito-backups/`

---

## Contribuir

1. Teste o lab em Tails ou Whonix real antes de marcar 🟢  
2. Atualize `last-tested:` no cabeçalho do lab  
3. Não colar complementos brutos — reescreva no template  
4. Abra issue se versão de software mudou
