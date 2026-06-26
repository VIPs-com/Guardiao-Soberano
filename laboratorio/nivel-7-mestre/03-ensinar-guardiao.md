# Ensinar outro Guardião — roteiro de mentoria

> **Livro:** Capítulo 11 · Passo 6.6 · Capítulo 12 (hábitos do Mestre)  
> **Último teste:** 2026-06-25 (conteúdo editorial)  

---

## Objetivo

Guiar **uma pessoa de confiança** pelos Níveis 0 e 1 com critérios de sucesso verificáveis — solidificando seu próprio conhecimento e criando redundância humana (sem compartilhar seeds).

---

## Pré-requisitos

- [ ] Você concluiu Níveis 0–5 (mínimo) ou 0–6 (ideal)
- [ ] Aluno com tempo: 2–4 dias (N0) + 1–2 semanas (N1)
- [ ] Ambiente presencial ou videochamada **sem** gravação da seed

---

## Princípios de mentoria

| Faça | Não faça |
| --- | --- |
| Perguntar "por quê?" a cada passo | Fazer clique a clique no lugar do aluno |
| Usar labs deste repositório | Enviar seed por mensagem |
| Celebrar conquistas (🏅) | Passar aluno que não restaurou seed |
| Parar se pressa ou distração | Misturar seed do mentor com do aluno |

---

## Sessão 1 — Nível 0 (A Semente)

**Material:** dados, papel, metal (aluno compra o próprio)

| Bloco | Lab | Critério de saída |
| --- | --- | --- |
| Entropia | [`nivel-0/01`](../nivel-0-semente/01-gerar-seed-dados.md) | Explica por que 100 lançamentos |
| Metal | [`nivel-0/02`](../nivel-0-semente/02-backup-aco.md) | 2 cópias em locais diferentes |
| Passphrase | Cap. 5 passo 0.6 | Recita sem olhar papel |
| Compra | [`nivel-0/03`](../nivel-0-semente/03-primeiros-sats-sem-kyc.md) | Escolhe método e justifica trade-off |

**Perguntas de verificação:**

1. O que acontece se alguém só roubar a placa sem passphrase?
2. Por que nunca fotografar os dados?
3. Qual diferença entre exchange KYC e RoboSats?

---

## Sessão 2 — Nível 1 (O Cofre)

| Bloco | Lab | Critério de saída |
| --- | --- | --- |
| Setup | [`nivel-1/01`](../nivel-1-cofre/01-hw-wallet-inicializacao.md) | Firmware PGP verificado |
| Restore | [`nivel-1/02`](../nivel-1-cofre/02-teste-restauracao.md) | 3 endereços batem pós-restore |
| PSBT QR | [`nivel-1/03`](../nivel-1-cofre/03-psbt-via-qr.md) | Descreve fluxo sem slides |

**Regra:** aluno **digita** seed no dispositivo — mentor olha de longe.

---

## Sessão 3 — Checkpoint (Cap. 11)

Aluno deve demonstrar **sozinho**:

- [ ] Restore da seed em dispositivo limpo
- [ ] Explicar PSBT em uma frase
- [ ] Explicar por que passphrase protege sob coerção

Se falhar → repetir N1/02, não avançar para Nível 2.

---

## Roteiro de acompanhamento (opcional)

Após N0–N1, o aluno segue sozinho com o livro + labs:

| Semana | Nível sugerido |
| --- | --- |
| 1–2 | 2 — Carteira Fria |
| 3–5 | 3 — Observador |
| 6–8 | 4 — Misturador |

Mentor disponível 1×/semana para dúvidas — **sem** acessar cofres do aluno.

---

## Como confirmar que deu certo (mentor)

- [ ] Aluno passou teste de restauração **antes** de fundos
- [ ] Aluno não compartilhou seed com você
- [ ] Você aprendeu algo ao ensinar (lacuna própria identificada)
- [ ] Critério Cap. 11: "pelo menos 1 pessoa nos Níveis 0–1"

---

## Se der errado

| Situação | Ação |
| --- | --- |
| Aluno com pressa | Pause — seed mal feita custa caro |
| Aluno quer guardar seed no Google Drive | Pare e releia Cap. 4 |
| Livro | Cap. 11 passo 6.6 · Cap. 12 hábitos |

---

## Legado (Nível 7)

Ensinar 1 pessoa/ano (Cap. 12). Traduza labs, reporte bugs, mentore no Matrix/Reddit — a trilha continua.
