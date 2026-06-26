# RetoSwap — swap XMR→BTC + persistência Tails

> **Livro:** Capítulo 10 · Passos 5.4, 5.7, 5.8  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** RetoSwap v1.8.0-reto · Feather · Tails ou Whonix  

---

## Objetivo

Instalar **RetoSwap** (fork Haveno Reto), executar swap **XMR→BTC** com endereço BTC virgem, e aplicar **intervalo de segurança** contra ABCTracer.

> **Direção:** RetoSwap = **XMR→BTC** (e fiat P2P). eigenwallet = BTC→XMR — lab [`01-eigenwallet-whonix-btc-xmr.md`](01-eigenwallet-whonix-btc-xmr.md).

---

## Pré-requisitos

- [ ] XMR na Feather (resultado de swap BTC→XMR anterior)
- [ ] Intervalo **mínimo 24 h** desde o swap de entrada (ideal 3–7 dias) — lab [`04-defesa-abctracer.md`](04-defesa-abctracer.md)
- [ ] Endereço BTC **virgem** do Coldcard/Sparrow anotado no papel
- [ ] Lab Feather: [`02-feather-tails-instalacao.md`](02-feather-tails-instalacao.md)

---

## Trilha A — Tails (persistência)

### A1. Baixar e verificar

```bash
VERSION=v1.8.0-reto
APPS=/home/amnesia/Persistent/Apps
mkdir -p "${APPS}"

# GitHub: github.com/retoaccess1/haveno-reto/releases
# Baixar tarball Linux + .asc via Tor Browser ou torsocks
cd "${APPS}"
# Exemplo após download:
gpg --verify haveno-reto-*.tar.gz.asc haveno-reto-*.tar.gz
```

> ⚠️ Versões anteriores a 20/06/2026 foram descontinuadas (atualização de protocolo).

### A2. Extrair

```bash
mkdir -p /home/amnesia/Persistent/Apps/haveno-reto
tar -xzf haveno-reto-*.tar.gz -C /home/amnesia/Persistent/Apps/haveno-reto --strip-components=1
# Confirmar: bin/Haveno existe
ls /home/amnesia/Persistent/Apps/haveno-reto/bin/Haveno
```

### A3. Script de inicialização

```bash
cp laboratorio/scripts/tails/start-retoswap.sh /home/amnesia/Persistent/start-retoswap.sh
chmod +x /home/amnesia/Persistent/start-retoswap.sh
/home/amnesia/Persistent/start-retoswap.sh
```

Dados em `/home/amnesia/Persistent/haveno-reto-data/`.

### A4. Primeira conta

1. Criar conta (avatar, **sem** e-mail)
2. Exportar backup da conta Haveno → `haveno_backup_amnesia.zip` na persistência
3. Anotar data no KeePassXC

---

## Trilha B — Whonix (persistente)

```bash
mkdir -p ~/Apps && cd ~/Apps
# scurl-download tarball + .asc da release RetoSwap
tar -xzf haveno-reto-*.tar.gz -C ~/Apps/haveno-reto
~/Apps/haveno-reto/bin/Haveno
```

Dados padrão em `~/.local/share/haveno` (persistem no disco da VM).

---

## Passo — Executar swap XMR→BTC

1. **Feather:** subendereço novo para enviar XMR ao escrow (se aplicável) ou conforme UI RetoSwap
2. **RetoSwap:** procurar oferta **XMR→BTC**
3. Verificar reputação da contraparte
4. **BTC destination:** endereço segwit **virgem** do Coldcard (anotado fora do PC)
5. Confirmar valor e fee na UI
6. Aguardar liberação do escrow (horas a dias)

---

## Passo — Após receber BTC

1. Sparrow (watch-only) → confirma recebimento
2. **Não** reutilizar endereço de recebimento
3. Mover para cold storage via PSBT se necessário
4. Registrar TXIDs no KeePassXC

---

## Intervalo de segurança (passo 5.7)

| ❌ Sem defesa | ✅ Com defesa |
| --- | --- |
| BTC→XMR 14:00, XMR→BTC 14:25 | Swaps em **dias** diferentes |
| Mesmo valor exato | Valores variados (0.4 + 0.3 + 0.5) |
| Mesmo par de endereços | Endereços virgens cada vez |

ABCTracer (arXiv:2504.01822): ~91,75% correlação com intervalo curto + valor/fee + destino.

---

## Como confirmar que deu certo

- [ ] RetoSwap inicia via `start-retoswap.sh` após reboot (Tails)
- [ ] Conta e backup exportado na persistência
- [ ] Swap XMR→BTC completou; BTC em endereço virgem
- [ ] Intervalo desde swap de entrada respeitado
- [ ] Nenhum servidor clearnet usado para operação real

---

## Se der errado

| Problema | Solução |
| --- | --- |
| Disputa no escrow | Guardar proofs; chat RetoSwap; Apêndice F |
| Sync Monero lento | Restore height Feather; nó Tor |
| Binário não inicia | JavaFX/GPU no Tails — testar Whonix |
| Versão antiga | Atualizar para v1.8.0-reto mínimo |

---

## Referências

- https://github.com/retoaccess1/haveno-reto/releases
- Livro: `manuscrito/10-nivel-5-trocador.md` (passos 5.4, 5.7, 5.8)
- Diagrama: `imagens/diagrama-swap.png`
