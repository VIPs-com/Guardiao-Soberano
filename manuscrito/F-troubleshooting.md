# Apêndice F — Troubleshooting Comum

## Problemas e Soluções

| Problema | Causa provável | Solução |
| --- | --- | --- |
| Whonix WS offline | Gateway parado | Iniciar Gateway; aguardar Tor verde |
| Sparrow sem servidor | `.onion` ou URL errada | Conferir URL; testar da lista |
| Transação não confirma | Fee muito baixo | Aguardar ou usar RBF |
| Coldcard não lê MicroSD | Formato incorreto | Formatar como FAT32 |
| PSBT rejeitado | Arquivo corrompido | Reexportar do Sparrow |
| Whirlpool parou | Coordinator offline | Aguardar ou JoinMarket |
| eigenwallet sem makers | Baixa liquidez | Tentar madrugada UTC |
| Feather sem conexão | Nó `.onion` offline | Trocar nó nas configs |
| Tor lento na WS | Circuito ruim | `restart tor` no Gateway |
| Passphrase recusada | Unicode diferente | Usar só ASCII |
| Seed não restaura | Path errado | Confirmar BIP84 no Sparrow |
| MicroSD travado | `.psbt` corrompido | Recriar transação |
| Whirlpool parou (Tails) | Sessão reiniciada | Migrar para Whonix |
| eigenwallet sem Tor | Porta 9050 inativa | Testar curl via socks5 |
| SeedSigner não lê QR | QR grande / brilho | Menos brilho; PSBT v2 |
| Feather não abre seed | Polyseed vs BIP39 | Polyseed 16 palavras — backup à parte |
| Funds insuficientes | UTXO consolidado | Coin Control; não juntar UTXOs |
| Senha Whonix padrão | Não alterada | Trocar user/root `changeme` |
| Estado eigen perdido | Tails sem Persistent | Symlink em `~/Persistent/` |
| Perdi seed/settings após update do Krux no celular | KruxMobileApp (beta) — não é cofre | Restaure só em hardware dedicado; veja Cap. 14 (Krux DIY) |

---

## Procedimento de Emergência: "Não Consigo Acessar Meus Fundos"

Este é o cenário mais temido — e com o procedimento correto, geralmente tem solução. Siga os passos em ordem:

**Passo 1 — Respire. Não apague nada.**

O primeiro instinto quando algo dá errado é apagar e recomeçar. Esse instinto pode destruir seus fundos. Antes de qualquer ação, pare e documente o que está acontecendo: qual software, qual erro exato, o que você fez antes do problema aparecer.

**Passo 2 — Identifique onde estão seus fundos.**

Seus bitcoins estão na blockchain, não no dispositivo. Se você tem a seed (24 palavras) e a passphrase, você pode restaurar em qualquer dispositivo compatível — mesmo que o hardware original tenha queimado, sido roubado ou simplesmente parado de funcionar. O dispositivo é substituível; a seed é o que importa.

**Passo 3 — Se a seed está intacta, restaure em dispositivo limpo.**

1. Adquira um novo dispositivo air-gapped (Coldcard, Jade Plus, SeedSigner, Krux) ou use o Ian Coleman offline (Tails sem rede, arquivo `bip39-standalone.html`).
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
- Tente reconectar: Arquivo → Desconectar → reconectar
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

**"Usei Krux no Android e perdi acesso ou os fundos sumiram"**

- O **KruxMobileApp** não é o Krux do Capítulo 6 — é app experimental para aprendizado, não cold wallet (nota de rodapé em Cap. 14)
- Atualizações do APK podem apagar configurações e mnemônicos cifrados; assinaturas do app ainda não são gerenciadas oficialmente
- Se a **seed em metal** está intacta: restaure em Maix/M5StickV com firmware Krux ou outro dispositivo air-gapped (Passo 3 acima)
- Se guardou fundos reais no app Android: trate a seed como **potencialmente comprometida** e migre para nova seed em hardware dedicado (Passo 4)
- Detalhes e posicionamento: Capítulo 14, seção Krux (DIY Firmware)

---
