# Electrum no Tails — carteira BTC persistente via Tor

> **Livro:** Capítulo 7 · seção *Electrum com Stream Isolation*  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em Tails real)  
> **Software:** Tails 7.9 · Electrum 4.5.5 (AppImage) · ThomasV GPG `6694D8DE…7F9470E6`  

---

## Objetivo

Instalar o **Electrum** na persistência do Tails com `--datadir` dedicado, proxy **SOCKS5** em `127.0.0.1:9050`, e carteiras salvas em `~/Persistent/electrum-data/` — integrado ao KeePassXC e ao backup 3-2-1.

---

## Quando usar Electrum vs Sparrow?

| Ferramenta | Papel no Nível 2 |
| --- | --- |
| **Sparrow** | Coordinator watching-only + PSBT com HW air-gapped (recomendado para cold storage) |
| **Electrum** | Carteira BTC leve, alternativa rápida, testes, ou perfil sem Sparrow |

Não misture identidades na mesma sessão Tails (carteira pessoal vs anônima).

---

## Pré-requisitos

- [ ] Labs [`05-tails-setup-btc-xmr-completo.md`](05-tails-setup-btc-xmr-completo.md) (Tails + persistência + Tor)
- [ ] Lab [`03-keepassxc-tails.md`](03-keepassxc-tails.md) (cofre `.kdbx` — rotular seeds BTC vs XMR)
- [ ] Persistência com **Personal Data** e **Bitcoin Client** ativos (recomendado)
- [ ] Pasta: `mkdir -p /home/amnesia/Persistent/Apps`

---

## Caminho A — Electrum pré-instalado no Tails

Com **Bitcoin Client** na persistência, o Tails pode manter config em `~/.electrum`. Para dados **explicitamente** em `Persistent/`, prefira o Caminho B com `--datadir`.

---

## Caminho B — AppImage persistente (recomendado)

### 1. Baixar e verificar

Confira a versão atual em [https://electrum.org/#download](https://electrum.org/#download) antes de rodar.

```bash
VERSION=4.5.5
APPS=/home/amnesia/Persistent/Apps

torsocks wget -P "$APPS" \
  "https://download.electrum.org/${VERSION}/electrum-${VERSION}-x86_64.AppImage" \
  "https://download.electrum.org/${VERSION}/electrum-${VERSION}-x86_64.AppImage.asc"
```

Importar chave **ThomasV** (verifique fingerprint no site oficial):

```bash
gpg --keyserver keys.openpgp.org --recv-keys 6694D8DE7BE8EE5631BED9502BD5824B7F9470E6

gpg --verify "$APPS/electrum-${VERSION}-x86_64.AppImage.asc" \
  "$APPS/electrum-${VERSION}-x86_64.AppImage"
```

Esperado: `Good signature from "Thomas Voegtlin"` e fingerprint `6694 D8DE 7BE8 EE56 31BE D950 2BD5 824B 7F94 70E6`.

```bash
chmod +x "$APPS/electrum-${VERSION}-x86_64.AppImage"
```

### 2. Script de inicialização

Copie `laboratorio/scripts/tails/start-electrum.sh` para `~/Persistent/` ou crie:

```bash
cat > /home/amnesia/Persistent/start-electrum.sh << 'EOF'
#!/bin/bash
set -euo pipefail
APPS="/home/amnesia/Persistent/Apps"
shopt -s nullglob
imgs=("${APPS}"/electrum-*-x86_64.AppImage)
[ ${#imgs[@]} -eq 0 ] && { echo "Electrum AppImage não encontrado em ${APPS}" >&2; exit 1; }
mkdir -p /home/amnesia/Persistent/electrum-data
exec "${imgs[0]}" --datadir /home/amnesia/Persistent/electrum-data "$@"
EOF
chmod +x /home/amnesia/Persistent/start-electrum.sh
```

> **`--datadir`** é crítico: sem ele, dados vão para `~/.electrum` (tmpfs) e somem ao desligar.

---

## Configurar rede (Tor / stream isolation)

1. Execute:

```bash
/home/amnesia/Persistent/start-electrum.sh
```

2. **Ferramentas → Rede** (Tools → Network):
   - **Proxy:** Usar proxy → SOCKS5 → `127.0.0.1` → porta `9050`
   - (Tor Browser isolado usa `9150`; no Tails o proxy do sistema é `9050`)

3. **Servidores:** para mais privacidade, adicione servidores ElectrumX `.onion` e desabilite clearnet. Exemplo de formato:

```
exemplo.onion 50002 s
```

Consulte listas confiáveis em [electrum.org](https://electrum.org) — nunca use servidor aleatório.

4. **Ferramentas → Preferências → Transações:**
   - Usar múltiplas mudanças (change)
   - Ajustar taxas manualmente se necessário

---

## Criar ou restaurar carteira

| Ação | Passos |
| --- | --- |
| **Nova** | Standard wallet → anote **12 palavras** em metal + tipo (native segwit, etc.) |
| **Restaurar** | Cole seed → senha forte do arquivo wallet → aguarde sync |

Arquivos em:

```
/home/amnesia/Persistent/electrum-data/wallets/
```

Registre no KeePassXC: nome da carteira, tipo, data — **não** substitua backup em aço.

---

## Estrutura na persistência

```
/home/amnesia/Persistent/electrum-data/
├── config
├── wallets/
│   └── fortaleza_btc/
├── logs/
└── …
```

---

## Convivência com Feather e RetoSwap

Os três podem rodar juntos se a RAM permitir (8 GB mínimo, 16 GB ideal). RetoSwap usa Feather para XMR; Electrum é independente para BTC. Tor é compartilhado pelo sistema.

---

## Backup 3-2-1 (incluir electrum-data)

Ajuste o `tar` do ritual de backup (exemplo):

```bash
tar czf - \
  /home/amnesia/.config/feather \
  /home/amnesia/Persistent/electrum-data \
  /home/amnesia/Persistent/fortaleza_cofre.kdbx \
| gpg --symmetric --cipher-algo AES256 \
  --output /media/backup/fortaleza_backup_$(date +%Y%m%d).tar.gz.gpg
```

A **seed de 12 palavras** continua sendo o último recurso — em aço, separada do arquivo GPG.

---

## Como confirmar que deu certo

- [ ] `gpg --verify` passou antes de executar o AppImage
- [ ] Proxy SOCKS5 `127.0.0.1:9050` ativo em Ferramentas → Rede
- [ ] Ícone de rede no Electrum indica conexão (sem erro de servidor)
- [ ] Após **reboot**, `start-electrum.sh` abre a mesma carteira e saldo/histórico
- [ ] Pasta `~/Persistent/electrum-data/wallets/` contém arquivos da carteira
- [ ] Seed BTC (12 palavras) rotulada no KeePassXC **se** guardar cópia — distinta de Monero (25 palavras)

### Teste de sobrevivência (opcional)

1. Receba fração mínima de BTC (faucet / amigo)
2. Feche Electrum, reinicie Tails
3. Abra via script — saldo e transação devem reaparecer

---

## Se der errado

| Problema | Ação |
| --- | --- |
| Carteira sumiu após reboot | Faltou `--datadir` — recrie script e restaure da seed |
| Não conecta ao servidor | Verifique Tor (`check.torproject.org`); tente servidor `.onion` |
| Confundiu seed BTC/XMR | Electrum = 12 palavras; Feather = 25 — rotule no KeePassXC |
| RAM baixa | Feche Feather/eigenwallet ao usar Electrum |

Livro: **Apêndice F** — Troubleshooting

---

## Regras de ouro

- Baixar **somente** de `download.electrum.org`
- Verificar GPG **a cada** nova versão
- Nunca exportar seed com rede ativa desnecessariamente
- Feche o Electrum antes de backup manual ou desligar o Tails

---

## Próximos labs

- [`01-sparrow-watching-only.md`](01-sparrow-watching-only.md) — coordinator + xpub  
- [`02-primeiro-psbt.md`](02-primeiro-psbt.md) — ciclo PSBT completo  

---

## Referências oficiais

- [Electrum — Download](https://electrum.org/#download)
- [Verificação GPG](https://electrum.readthedocs.io/en/latest/gpg-check.html)
- [Tails — Persistent Storage](https://tails.net/doc/persistent_storage/)

---

*Extraído de `manuscrito/07-nivel-2-carteira-fria.md`. Fingerprint GPG corrigido em relação ao placeholder do rascunho original.*
