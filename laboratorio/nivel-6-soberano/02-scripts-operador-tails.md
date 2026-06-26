# Scripts do operador no Tails (`start-*.sh`)

> **Livro:** Capítulo 11 · passo 6.7 · Cap. 7–10 (labs Tails)  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Tails 7.9 · scripts em `laboratorio/scripts/tails/`  

---

## Objetivo

Instalar e usar os **seis scripts** auditáveis do repositório para abrir ferramentas na persistência Tails com Tor forçado e rotina previsível.

```
Copiar scripts → Persistent/ → executar antes de cada sessão operacional
```

---

## Pré-requisitos

- [ ] Tails com persistência configurada
- [ ] Apps instalados conforme labs N2/N5 (Sparrow, KeePassXC, Electrum, Feather, RetoSwap)
- [ ] Acesso de leitura ao clone do repositório (ou download dos `.sh`)

---

## Inventário de scripts

| Script | Função | Lab relacionado |
| --- | --- | --- |
| `start-sparrow.sh` | Sparrow + Tor | N2/01 |
| `start-keepass.sh` | KeePassXC | N2/03 |
| `start-electrum.sh` | Electrum BTC | N2/04 |
| `start-feather.sh` | Feather XMR | N5/02 |
| `start-retoswap.sh` | RetoSwap GUI | N5/03 |
| `backup-persistencia.sh` | Backup 3-2-1 GPG | N6/01 |

Todos em: [`../scripts/tails/`](../scripts/tails/)

---

## Passo 1 — Instalação única

Para cada script que você usa:

```bash
cp laboratorio/scripts/tails/start-sparrow.sh /home/amnesia/Persistent/
chmod +x /home/amnesia/Persistent/start-sparrow.sh
```

Repita para os demais. Opcional: symlink em `~/Persistent/bin/` e adicione ao PATH.

---

## Passo 2 — Ordem típica de sessão

**Sessão swap (Tails cirúrgico):**

1. `start-keepass.sh` — abra cofre de senhas
2. `start-feather.sh` — monitore XMR
3. `start-retoswap.sh` — swap XMR→BTC
4. Ao encerrar: `backup-persistencia.sh` se houve mudança crítica

**Sessão BTC leve:**

1. `start-sparrow.sh` ou `start-electrum.sh`
2. PSBT → dispositivo air-gapped (N1/N2)

---

## Passo 3 — Auditar antes de confiar

Abra cada `.sh` em editor de texto. Confirme:

- [ ] Sem `curl | bash` de origem desconhecida
- [ ] Caminhos apontam para `/home/amnesia/Persistent/...`
- [ ] Tor/Proxy onde aplicável
- [ ] Licença MIT no cabeçalho

**Regra do livro:** texto claro, linha a linha — nunca binário opaco.

---

## Passo 4 — Registrar no KeePassXC

Entrada sugerida: **Scripts Tails**

| Comando | Quando |
| --- | --- |
| `~/Persistent/start-feather.sh` | Antes de operar XMR |
| `~/Persistent/backup-persistencia.sh /media/backup` | Semanal / pós-swap |

---

## Como confirmar que deu certo

- [ ] Cada script inicia o app esperado sem erro no terminal
- [ ] Conexões passam por Tor (Feather/RetoSwap — ver labs N5)
- [ ] Você sabe qual script usar em cada tipo de operação
- [ ] Backup script gera `.gpg` (lab N6/01)

---

## Se der errado

| Problema | Ação |
| --- | --- |
| `Permission denied` | `chmod +x` no script |
| App não encontrado | Reinstale conforme lab N2/N5 |
| Tor não conecta | Aguarde Tor Browser / reinicie Tails |

Livro: Cap. 11 · Apêndice C · Apêndice F
