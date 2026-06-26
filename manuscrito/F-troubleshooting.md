# Apêndice F — Troubleshooting Comum

## Problemas e Soluções

  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Problema                                      Causa provável                              Solução
  --------------------------------------------- ------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------
  Whonix Workstation não conecta                Gateway não iniciado                        Iniciar Gateway primeiro, aguardar Tor verde

  Sparrow não conecta ao servidor               .onion offline ou URL errada                Verificar URL, testar outro servidor da lista

  Transação não confirma                        Fee muito baixo                             Aguardar ou usar RBF (Replace-By-Fee)

  Coldcard não reconhece MicroSD                Formato incorreto                           Formatar como FAT32

  PSBT rejeitado pelo Coldcard                  Arquivo corrompido                          Reexportar do Sparrow

  Whirlpool parou                               Coordinator offline                         Aguardar ou migrar para JoinMarket

  eigenwallet não encontra makers               Horário de baixa liquidez                   Tentar em outro horário (madrugada UTC tem mais makers)

  Feather Wallet não conecta                    Nó .onion offline                           Trocar para outro nó na lista (configurações → nó)

  Tor lento na Workstation                      Circuito ruim                               Novo circuito: `sudo systemctl restart tor` no Gateway

  Passphrase recusada no Coldcard               Normalização Unicode diferente              Usar apenas ASCII na passphrase (evita NFKD vs NFC)

  Seed não restaura endereços corretos          Derivation path errado                      Confirmar BIP84 (Native SegWit) no Sparrow ao importar

  MicroSD travado no Coldcard                   Arquivo .psbt corrompido                    Recriar transação no Sparrow e exportar novamente

  Whirlpool para de misturar no Tails           Sessão amnésica reiniciada                  Migrar para Whonix para mixing contínuo e remixes automáticos

  eigenwallet não detecta Tor                   Tor não rodando na porta 9050               Verificar que Tails ou Whonix está com Tor ativo; testar `curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org/api/ip`

  SeedSigner não lê QR do Sparrow               QR muito complexo ou brilho alto            Reduzir brilho da tela; usar QR comprimido (PSBT v2)

  Feather Wallet não abre seed                  Seed em formato Polyseed vs BIP39           Feather usa Polyseed 16 palavras, NÃO BIP39 de 24 — são backups separados

  Erro "insufficient funds" no swap             UTXO contaminado pós-coinjoin consolidado   Nunca consolidar UTXOs pós-coinjoin com não-misturados; usar Coin Control

  Credenciais Whonix não funcionam              Ainda nas configurações padrão              Alterar `user/changeme` e `root/changeme` na primeira inicialização

  eigenwallet salvo estado perdido após Tails   Estado em RAM (sem Persistent)              Criar link: `ln -s ~/.local/share/eigenwallet ~/Persistent/eigenwallet-state`
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---

## Procedimento de Emergência: "Não Consigo Acessar Meus Fundos"

Este é o cenário mais temido — e com o procedimento correto, geralmente tem solução. Siga os passos em ordem:

**Passo 1 — Respire. Não apague nada.**

O primeiro instinto quando algo dá errado é apagar e recomeçar. Esse instinto pode destruir seus fundos. Antes de qualquer ação, pare e documente o que está acontecendo: qual software, qual erro exato, o que você fez antes do problema aparecer.

**Passo 2 — Identifique onde estão seus fundos.**

Seus bitcoins estão na blockchain, não no dispositivo. Se você tem a seed (24 palavras) e a passphrase, você pode restaurar em qualquer dispositivo compatível — mesmo que o hardware original tenha queimado, sido roubado ou simplesmente parado de funcionar. O dispositivo é substituível; a seed é o que importa.

**Passo 3 — Se a seed está intacta, restaure em dispositivo limpo.**

1. Adquira um novo dispositivo air-gapped (Coldcard, Jade, SeedSigner, Krux) ou use o Ian Coleman offline (Tails sem rede, arquivo `bip39-standalone.html`).
2. Restaure as 24 palavras + passphrase.
3. Exporte o xpub para o Sparrow em um computador limpo.
4. O Sparrow sincronizará com a blockchain e mostrará seu saldo.
5. Envie os fundos para um endereço de uma **nova seed** gerada com entropia própria.

**Passo 4 — Se a seed pode ter sido comprometida, mova os fundos imediatamente.**

Se você suspeita que alguém teve acesso à sua seed (dispositivo roubado, seed fotografada por engano, backup vazado), aja rápido:

1. Gere uma nova seed com dados de casino em dispositivo air-gapped.
2. Crie uma nova carteira com a nova seed + nova passphrase.
3. Envie todos os fundos da carteira antiga para a nova — em uma única transação, pagando a taxa adequada.
4. Destrua os backups físicos antigos com segurança (corte as placas de aço, desfaça as arruelas).

---

## Diagnóstico Rápido por Sintoma

**"Meu Sparrow mostra saldo zero mas eu sei que tenho BTC"**

- Verifique se o Sparrow está sincronizado com o servidor correto (barra de status na parte inferior)
- Confirme que importou o xpub correto — com passphrase, se usar
- Tente reconectar: File → Disconnect → reconnect
- Verifique no `mempool.space` se os endereços da sua carteira têm saldo

**"O Tor Browser não carrega .onion"**

- Confirme que o Tor está conectado: ícone verde na barra de endereços
- Tente um novo circuito: botão de cebola → New Tor Circuit for this Site
- Se no Whonix: verifique se o Gateway está rodando e mostrando Tor verde
- O .onion pode estar temporariamente fora do ar — tente novamente em alguns minutos

**"Minha passphrase não funciona — endereços gerados são diferentes"**

- Problema mais comum: caractere invisível ou encoding diferente
- Passphrases devem usar apenas ASCII puro — evite acentos, cedilha, caracteres especiais
- Digite a passphrase novamente com atenção, caractere por caractere
- Se você memorizou diferente do que anotou: teste ambas as versões e veja qual abre a carteira com saldo

**"Whirlpool parou de misturar há dias"**

- O Whirlpool precisa de computador ligado e conectado para continuar os remixes
- Se você usa Tails (amnésico), a sessão reiniciou e o processo parou — migre para Whonix para mixing contínuo
- O coordinator pode estar temporariamente fora do ar — veja anúncios no canal oficial do Sparrow
- JoinMarket é a alternativa P2P sem coordinator — veja Capítulo 15

---
