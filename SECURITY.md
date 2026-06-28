# Política de segurança

O Guardião Soberano ensina auto-custódia e privacidade. Scripts em
`laboratorio/scripts/` podem manipular carteiras e dados sensíveis — trate
qualquer problema como potencialmente grave.

---

## O que reportar

- Script que exfiltra dados ou conecta a endpoints não documentados
- Comando em lab que expõe chaves privadas ou seeds em log/clipe
- Link malicioso ou substituição de URL de download oficial
- Instrução que contradiz práticas seguras do livro sem justificativa técnica

## O que **não** é escopo deste repositório

- Vulnerabilidades em Tails, Whonix, Sparrow, Feather, Bitcoin Core, etc.  
  → Reporte aos mantenedores oficiais desses projetos.
- Perda de fundos por erro do usuário seguindo o guia  
  → Use issues de documentação (`erro-de-comando`), não security advisory.

---

## Como reportar

1. **Não** abra issue pública com detalhes exploráveis.
2. Use o canal **[Security Advisories](../../security/advisories/new)** do GitHub (privado).
3. Inclua: arquivo/lab afetado, passo, impacto, reprodução mínima.

---

## Boas práticas ao usar os labs

- Teste sempre com quantias pequenas primeiro.
- Verifique GPG e hashes antes de executar qualquer AppImage ou `.tar.gz`.
- Nunca cole seeds ou chaves em issues, PRs ou chats.

---

*Guardião Soberano v1.1 — junho 2026*
