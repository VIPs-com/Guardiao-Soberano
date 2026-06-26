# Migração Tails → Whonix (estratégia híbrida)

> **Livro:** Capítulo 8 · Referência *Tails vs Whonix*  
> **Último teste:** 2026-06-25 (conteúdo extraído — revalidar em hardware)  
> **Cenário:** Você dominou Tails (Nível 2) e vai subir para Whonix (Nível 3+)  

---

## Objetivo

Planejar e executar a **transição** de operações pontuais no Tails para a fortaleza persistente no Whonix — sem perder o pendrive amnésico como ferramenta cirúrgica.

---

## Quando migrar

| Fique no Tails se… | Migre para Whonix se… |
| --- | --- |
| CoinJoin 1×/mês, sem pressa | CoinJoin semanal + remix 24/7 |
| Swaps pontuais de alto risco | eigenwallet/RetoSwap recorrentes |
| Portabilidade (pendrive no bolso) | Desktop 16 GB+ RAM disponível |
| País com risco de apreensão de VM no disco | Node próprio + EPS desejado |

Matriz completa: livro **Cap. 8** (seção *Referência: Tails vs Whonix*).

---

## O que NÃO muda na migração

| Item | Onde continua |
| --- | --- |
| Seed Bitcoin | Placa de aço + air-gap (Nível 1) |
| Seed Monero | KeePassXC + metal (separada da BTC) |
| PSBT / assinatura | Dispositivo air-gapped |
| Regra ABCTracer | Intervalos entre swaps (Nível 5) |

**A seed não migra para o Whonix.** Só xpub, metadados e apps.

---

## Passo 1 — Inventário do Tails (antes de desligar)

Anote o que existe na persistência:

```bash
ls -la /home/amnesia/Persistent/
ls /home/amnesia/Persistent/feather-data 2>/dev/null
ls /home/amnesia/Persistent/electrum-data 2>/dev/null
ls /home/amnesia/Persistent/sparrow-data 2>/dev/null
```

| Dado Tails | Ação na migração |
| --- | --- |
| `fortaleza_cofre.kdbx` | Copiar para Whonix (KeePassXC) |
| Feather `feather-data` | **Opção A:** manter XMR no Tails para swaps · **Opção B:** restaurar seed Feather no Whonix |
| Electrum `electrum-data` | Restaurar com seed 12 palavras no Whonix se necessário |
| Sparrow xpub | Reimportar mesma xpub no Sparrow Whonix |
| Scripts `start-*.sh` | Recriar em Whonix ou manter no Tails |

---

## Passo 2 — Subir Whonix (lab N3)

Siga [`01-whonix-virtualbox-completo.md`](01-whonix-virtualbox-completo.md):

1. Gateway → Workstation
2. Tor verificado
3. KeePassXC com cópia do `.kdbx`
4. Sparrow com **mesma xpub**
5. Pasta `/mnt/psbt_bridge` para PSBT

Opcional imediato: [`02-bitcoin-node-eps-onion.md`](02-bitcoin-node-eps-onion.md)

---

## Passo 3 — Estratégia híbrida (recomendada)

Não abandone o Tails — **segregue funções**:

| Ambiente | Função |
| --- | --- |
| **Whonix** | Whirlpool 24/7 · Sparrow + EPS · monitoramento diário |
| **Tails** | Swaps cirúrgicos · RoboSats · sessões de alto risco |

**Fluxo tipo:**

```
1. Whonix: mixar BTC → Postmix
2. Transferir só o necessário → endereço Sparrow no Tails (ou manter swap no Whonix)
3. Tails: eigenwallet / RetoSwap (sessão descartável)
4. BTC limpo → cold storage (air-gap)
```

Whonix **não precisa** tocar Monero se você preferir XMR só no Tails.

---

## Passo 4 — Whirlpool: por que sair do Tails

| Tails | Whonix |
| --- | --- |
| Estado Whirlpool frágil na persistência USB | Estado no `.vdi` — snapshot + backup de arquivo |
| Sessões longas arriscadas (energia/USB) | VM 24/7 com remix automático |
| Boot a cada operação | Sempre pronto |

Lab: [`../nivel-4-misturador/01-whirlpool-primeiro-mix.md`](../nivel-4-misturador/01-whirlpool-primeiro-mix.md)

---

## Passo 5 — Backup na transição

Antes de formatar ou trocar pendrive Tails:

```bash
/home/amnesia/Persistent/backup-persistencia.sh /media/backup
```

Script: `laboratorio/scripts/tails/backup-persistencia.sh`

Guarde cópia offsite (HD LUKS fora de casa). **Frase-senha do GPG separada** do pendrive.

---

## Passo 6 — Checklist pós-migração

- [ ] Sparrow Whonix mostra mesmo saldo/histórico (mesma xpub)
- [ ] KeePassXC abre no Whonix com todos os metadados
- [ ] PSBT funciona via `psbt_bridge` ou SD
- [ ] Tails ainda boota e scripts `start-*.sh` funcionam (reserva)
- [ ] Você sabe qual ambiente usa para **cada** operação
- [ ] Backup 3-2-1 atualizado após migração

---

## Erros comuns

| Erro | Consequência |
| --- | --- |
| Copiar seed para Whonix “por conveniência” | Superfície de ataque maior |
| Apagar Tails antes de backup | Perda de metadados Haveno/electrum |
| Rodar Whirlpool só no Tails com uptime longo | Corrupção USB / perda de estado |
| Usar mesmo subendereço XMR após migração | Pior higiene de privacidade |

---

## Como confirmar que deu certo

- [ ] Operações diárias (receive, watch) no Whonix
- [ ] Tails reservado para swaps pontuais — você sabe quando bootar
- [ ] Nenhuma seed digitada no Whonix
- [ ] Diagrama pessoal desenhado (host + 2 VMs + Tails USB)

---

## Referências

- Livro: `manuscrito/08-nivel-3-observador.md` (Referência Tails vs Whonix)
- Backup: `manuscrito/11-nivel-6-soberano.md` (regra 3-2-1)
