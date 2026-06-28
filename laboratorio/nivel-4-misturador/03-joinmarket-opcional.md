# JoinMarket — alternativa P2P ao Whirlpool (opcional)

> **Livro:** Capítulo 9 · Passo 4.7 · Cap. 15.2  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Whonix WS · joinmarket-clientserver (última release estável) · Bitcoin Core ou Electrum conectado via Tor  

---

## Objetivo

Instalar o **JoinMarket** na Whonix Workstation, gerar carteira, executar **um CoinJoin de teste** como taker e saber quando migrar do Whirlpool se o coordinator cair.

```
Whirlpool (principal)  →  coordinator offline?  →  JoinMarket (backup P2P)
```

| | Whirlpool | JoinMarket |
| --- | --- | --- |
| Arquitetura | Coordinator central (.onion) | P2P — makers e takers |
| Valores | Pools fixos (0.01, 0.05, 0.5 BTC) | Qualquer valor (dentro da liquidez) |
| Uso típico | Mixagem principal no Sparrow | Backup + valores customizados |
| Maker | Remix automático no Sparrow | `yield-generator.py` (Nível 7) |

---

## Pré-requisitos

- [ ] Whonix operacional — [`../nivel-3-observador/01-whonix-virtualbox-completo.md`](../nivel-3-observador/01-whonix-virtualbox-completo.md)
- [ ] Lab Whirlpool concluído ou em andamento — [`01-whirlpool-primeiro-mix.md`](01-whirlpool-primeiro-mix.md)
- [ ] **≥ 0.001 BTC** para teste taker + fees (valor pequeno; ajuste conforme liquidez)
- [ ] Endereço de recebimento anotado (Postmix ou carteira separada)

> **Não substitua** o Whirlpool por padrão. Este lab é **resiliência**: você já sabe mixar se o coordinator comunitário ficar offline.

---

## Passo 1 — Clonar e instalar dependências

Na **Whonix Workstation** (terminal):

```bash
cd ~
git clone https://github.com/JoinMarket-Org/joinmarket-clientserver.git
cd joinmarket-clientserver
pip3 install --user -r requirements.txt
```

Verifique a release no [GitHub oficial](https://github.com/JoinMarket-Org/joinmarket-clientserver/releases) e, se preferir pinagem, faça checkout de uma tag estável antes do `pip install`.

---

## Passo 2 — Configurar Tor

Edite `joinmarket.cfg` na pasta clonada:

```bash
nano joinmarket.cfg
```

Confirme (ou ajuste) a seção de messaging para SOCKS5 via Tor na Gateway:

```ini
[MESSAGING:server]
host = 127.0.0.1
port = 9050
type = socks5
```

Na Whonix, o proxy Tor já está disponível na Workstation via Gateway — **não** use clearnet.

Salve e feche o editor.

---

## Passo 3 — Gerar carteira JoinMarket

```bash
cd ~/joinmarket-clientserver/scripts
python3 wallet-tool.py generate
```

- Escolha um nome (ex.: `jm_wallet`)
- Anote a **seed BIP39** em **metal/papel** — é carteira **hot** na VM, mas o backup ainda importa
- **Não** reutilize a seed do seu Coldcard/SeedSigner

Fundos de teste: envie BTC para um endereço gerado por esta carteira (valor mínimo para 1 coinjoin).

---

## Passo 4 — CoinJoin de teste (taker)

Com saldo confirmado na carteira JM:

```bash
cd ~/joinmarket-clientserver/scripts
python3 sendpayment.py jm_wallet.json 0.001 SEU_ENDERECO_POSTMIX
```

Substitua `0.001` pelo valor de teste e `SEU_ENDERECO_POSTMIX` por endereço **novo** (ideal: carteira Postmix do Sparrow).

O script negocia com makers na rede JoinMarket. Pode levar **minutos a horas** conforme liquidez e fee oferecida.

---

## Passo 5 — Registrar comandos no KeePassXC

Anote no cofre (sem colar seeds):

| Comando | Função |
| --- | --- |
| `wallet-tool.py generate` | Nova carteira JM |
| `sendpayment.py WALLET VALOR ENDEREÇO` | Taker — iniciar coinjoin |
| `yield-generator.py WALLET` | Maker — fornecer liquidez (Nível 7) |

Caminho do clone: `~/joinmarket-clientserver/`

---

## Como confirmar que deu certo

- [ ] `pip3 install` terminou sem erro crítico
- [ ] Carteira JM criada e fundada com tx confirmada on-chain
- [ ] `sendpayment.py` completou — tx visível no explorer via Tor
- [ ] Output chegou no endereço Postmix (ou destino de teste)
- [ ] Você sabe **quando** abrir o JM em vez do Whirlpool (coordinator offline, pool indisponível)

Verificação on-chain (opcional):

```bash
# No Sparrow ou via explorer .onion — confira que o output não consolida com UTXO sujo
```

---

## Quando usar JoinMarket vs Whirlpool

| Situação | Ação |
| --- | --- |
| Mixagem rotineira, pools 0.01+ | Whirlpool no Sparrow |
| Coordinator Whirlpool offline dias | JoinMarket taker |
| Valor fora dos pools fixos | JoinMarket |
| Quiser ganhar fees (avançado) | `yield-generator.py` — ver Nível 7 |

---

## Se der errado

| Problema | Caminho |
| --- | --- |
| Sem makers / tx não fecha | Aumente fee relativa ou tente em horário de maior liquidez |
| Erro de conexão | Confirme Tor (`curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org`) |
| Whirlpool voltou | Continue no Whirlpool; JM fica como backup testado |
| Livro | Apêndice F — Troubleshooting · Cap. 15.2 |

---

## Referências oficiais

- [JoinMarket-Org/joinmarket-clientserver](https://github.com/JoinMarket-Org/joinmarket-clientserver)
- [JoinMarket docs](https://joinmarket-org.github.io/joinmarket-clientserver/)
- Livro: Cap. 9 passo 4.7 · Cap. 15.2 · Glossário (JoinMarket)
