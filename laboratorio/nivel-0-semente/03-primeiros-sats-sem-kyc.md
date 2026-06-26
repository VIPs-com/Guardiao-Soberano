# Primeiros satoshis sem KYC — checklist operacional

> **Livro:** Capítulo 5 · Passo 0.7  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Tor Browser · Sparrow (futuro Nível 2)  

---

## Objetivo

Adquirir os **primeiros satoshis** sem vincular documento à carteira soberana, usando um método sem KYC e entendendo o trade-off de privacidade de cada opção.

```
Tor → trade sem documento → BTC on-chain na sua xpub (watching-only depois)
```

---

## Pré-requisitos

- [ ] Endereço de recebimento da sua carteira (xpub no Sparrow **ou** endereço do dispositivo — Nível 1+)
- [ ] Tor Browser instalado e atualizado
- [ ] Valor pequeno para primeiro teste (ex. equivalente a R$ 50–200)

---

## Comparativo rápido

| Método | KYC | Rastro digital do pagamento | Quando usar |
| --- | --- | --- | --- |
| **RoboSats** (Pix → Lightning) | Não na plataforma | Pix no banco | Entrada rápida no Brasil |
| **RetoSwap** (fiat → XMR) | Não | Depende do método | Máximo anonimato fiat |
| **Venda direta** | Não | Dinheiro físico | Conhecido de confiança |
| **Freelance em BTC** | Não | Contrato/work | Renda recorrente |

---

## Trilha A — RoboSats (recomendado para primeiro teste no Brasil)

1. Abra **Tor Browser**
2. Acesse o .onion oficial (Apêndice B):

   `robosatsy56bwqn56qyadmcxkx767hnabg4mihxlmgyt6if5gnuxvzad.onion`

3. Gere **avatar** único para este trade (não reutilize)
4. Filtre: comprar BTC, pagar com **Pix**
5. Escolha oferta com bom histórico do vendedor
6. BTC fica em **escrow Lightning** até confirmação
7. Faça o Pix conforme instruções **dentro do prazo**
8. Após liberação: sweep para endereço **on-chain seu** (novo endereço, não reutilizado)

> Pix deixa registro bancário. Para reduzir correlação: conta sem vínculo óbvio ao seu nome civil, ou prefira Trilha B.

---

## Trilha B — RetoSwap / dinheiro físico → XMR → BTC

1. Conclua Nível 5 para swap XMR→BTC, **ou** use apenas XMR primeiro
2. Métodos sem registro digital forte: dinheiro por correio, encontro presencial
3. XMR em escrow multisig até confirmação do vendedor

Ver labs N5 quando a fortaleza Whonix/Tails estiver pronta.

---

## Trilha C — Venda direta

1. Combine com conhecido que já tem BTC
2. Pagamento em **dinheiro físico**
3. Ele envia para **seu** endereço (você dita ou mostra QR do dispositivo offline)
4. Confirme confirmações on-chain antes de entregar o dinheiro

---

## Regras de ouro (pós-compra)

- [ ] **Rotule** a origem do UTXO no Sparrow (ex.: `RoboSats 2026-06`)
- [ ] Não envie para exchange com seu nome depois
- [ ] Não misture com UTXO KYC antes de CoinJoin (Nível 4)
- [ ] Primeira compra = valor que você aceita perder em caso de erro

---

## Como confirmar que deu certo

- [ ] Tx confirmada on-chain no **seu** endereço
- [ ] Valor bate com o acordado (menos fees)
- [ ] UTXO visível no Sparrow watching-only ou no explorer via Tor
- [ ] Você anotou método e data para coin control futuro

---

## Se der errado

| Problema | Ação |
| --- | --- |
| Trade RoboSats expirou | Abra novo avatar; não reutilize ordem antiga |
| Endereço errado | Impossível reverter — teste com valor mínimo primeiro |
| Só Lightning, precisa on-chain | Use submarine swap ou aguarde canal — planeje antes |

Livro: Cap. 5 · Apêndice B (.onion) · Cap. 11 (entrada sem KYC)

---

## Referências

- [RoboSats GitHub](https://github.com/RoboSats/robosats)
- Livro Apêndice B — RoboSats .onion
