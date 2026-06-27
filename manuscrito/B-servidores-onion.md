# Apêndice B — Servidores .onion de Referência

---

## Aviso Importante

Endereços .onion podem mudar. Projetos podem ser descontinuados. **Sempre verifique os sites oficiais** (via Tor Browser) para confirmar os endereços atuais antes de usar.

Esta lista é um ponto de partida, atualizada em **junho de 2026**.

> **AVISO — Atualização jun/2026:** Endereços no formato `dominio.com.onion` **não são** endereços v3 válidos (v3 tem 56 caracteres base32 antes de `.onion`). Versões anteriores deste apêndice listavam exemplos incorretos — removidos na revisão técnica.

---

## Servidores Electrum (.onion)

Para conectar Sparrow ou Electrum a um servidor via Tor. Prefira **sempre** seu próprio EPS (Electrum Personal Server) ou electrs com hidden service — zero confiança em terceiros.

### Formato válido (v3)

Um endereço .onion v3 tem **56 caracteres** em base32, por exemplo:

    wsw6tua3xl24gsmi264zaep6seppjyrkyucpsmuxnjzyt3f3j6swshad.onion:50002

### Onde encontrar servidores públicos (se necessário)

1.  Lista oficial do Electrum: `github.com/spesmilo/electrum` → arquivo `electrum/servers.json` (filtre entradas com chave `onion` e porta SSL `s`)
2.  Seu próprio node + electrs/EPS com Tor Hidden Service (recomendado — Cap. 8)
3.  **Nunca** use listas não verificadas de fóruns ou Telegram

<!-- -->

    === RECOMENDAÇÃO ===
    1. EPS próprio: [seu-endereco-v3].onion:50002
       SSL: Sim | Verificado: por você

    2. Servidor público: consulte servers.json no momento do uso
       SSL: porta 50002 (:s) | Verificar fingerprint no Sparrow

> **AVISO:**
>
> - Verifique se o SSL está ativo (cadeado verde no Sparrow)
> - Nunca use servidores `.onion` de listas não verificadas
> - Prefira seu EPS próprio — zero confiança em terceiros

### Como testar seu servidor

No terminal da Workstation Whonix:

``` {.sourceCode .bash}
# Substitua pelo seu .onion v3 real
torify nc -zv SEU_ENDERECO_V3.onion 50002

# Deve retornar algo como:
# Connection to SEU_ENDERECO_V3.onion 50002 port [tcp/*] succeeded!
```

---

## RoboSats (.onion)

Exchange P2P para comprar/vender Bitcoin sem KYC via Tor.

    Endereço .onion principal (jun/2026):
    robosatsy56bwqn56qyadmcxkx767hnabg4mihxlmgyt6if5gnuxvzad.onion

    Fonte oficial: github.com/RoboSats/robosats (README)
    Acesso: Tor Browser apenas

> **Nota:** O RoboSats opera em federação — coordenadores podem ter `.onion` próprios. Consulte sempre o README e as discussões oficiais no GitHub antes de operar. **Não use** clearnet para trading (`unsafe.robosats.org` é apenas referência).

---

## Whirlpool Coordinator Comunitário

Após o encerramento do Samourai Wallet em 2024, o Sparrow assumiu a integração Whirlpool conectando ao coordinator comunitário.

    Coordinator: Configurado automaticamente no Sparrow
    Protocolo: ZeroLink (original)
    Desenvolvedor: Craig Raw (Sparrow)

> O coordinator comunitário é acessado automaticamente pelo Sparrow via Tor. Não é necessário configurar o endereço manualmente.

---

## eigenwallet (.onion)

Ferramenta para swap BTC → XMR com endpoint .onion embutido.

    Acesso: Configurado na Workstation Whonix
    Download: github.com/eigenwallet/core/releases (verificar .asc)
    Verificação Tor:
    curl --socks5-hostname 127.0.0.1:9050 \
      https://check.torproject.org/api/ip

---

## Nota sobre Manutenção desta Lista

Os endereços .onion são mais instáveis que URLs normais. Se um endereço não funcionar:

1.  Verifique o site oficial do projeto via Tor Browser
2.  Consulte o canal Matrix ou SimpleX do projeto
3.  Adicione nota de rodapé ao livro: `> AVISO: Endereço inativo em [mês/ano]. Verifique o site oficial.`

Nunca use endereços .onion de fontes não-verificadas — risco de phishing é alto.
