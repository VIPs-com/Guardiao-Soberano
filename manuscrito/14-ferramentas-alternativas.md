# Capítulo 14 — Ferramentas e Alternativas

> "Não dependa de uma única ferramenta. A soberania exige opções"

---

## Objetivo

Apresentar alternativas para cada componente do ecossistema, garantindo que você tenha opções se sua ferramenta principal estiver indisponível.

---

## 14.1 Hardware Wallets — Alternativas ao Coldcard

O Coldcard MK5 é nossa recomendação principal, mas existem outras opções excelentes:

### Blockstream Jade Plus

- **Preço:** US$ 169 (jun/2026) — substituiu o Jade original
- **Diferencial:** Câmera integrada para QR code, display colorido, Bluetooth opcional
- **Quando usar:** Alternativa ao Coldcard com preço similar; prefere QR a SD card
- **Open source:** Sim

### Foundation Passport Batch 2

- **Preço:** ~US$ 150-200
- **Diferencial:** QR nativo, UX mais amigável, design modular
- **Quando usar:** Prefere QR a SD card
- **Open source:** Sim

### Keystone 3 Pro

- **Preço:** ~US$ 130
- **Diferencial:** Tela touchscreen grande, multi-coin, compatível com MetaMask
- **Quando usar:** Precisa de multi-coin
- **Open source:** Sim (firmware Bitcoin-only disponível)

### SeedSigner (DIY)

- **Preço:** ~US$ 50 em peças
- **Diferencial:** Stateless (apaga tudo ao desligar), você monta
- **Quando usar:** Quer construir o próprio dispositivo
- **Open source:** 100%

### Krux (DIY Firmware)

- **Preço:** ~US$ 40-60 (hardware Maix Amigo ou M5StickV)
- **Diferencial:** Stateless, suporte a Taproot, Miniscript, builds reproduzíveis
- **Quando usar:** Alternativa moderna ao SeedSigner
- **Open source:** Sim, com builds verificáveis

### AirGap Vault (Mobile)

- **Preço:** Gratuito (usa celular velho)
- **Diferencial:** Dois dispositivos (um offline, um online), comunicação via QR
- **Quando usar:** Já tem celular velho dedicado
- **Open source:** Sim

---

## 14.2 Software — Alternativas ao Sparrow

### Electrum

- **Função:** Carteira Bitcoin
- **Diferencial:** Pré-instalado no Tails, leve, Lightning Network
- **Quando usar:** Operações simples, já vem pronto no Tails

### Specter Desktop

- **Função:** Interface para Bitcoin Core
- **Diferencial:** Multisig avançado, integração com hardware wallets
- **Quando usar:** Configurar multisig com múltiplos dispositivos

### Liana Wallet

- **Função:** Carteira com herança programável
- **Diferencial:** Miniscript + timelocks para sucessão
- **Quando usar:** Planejamento de herança

---

## 14.3 Swaps — Alternativas ao eigenwallet

### RetoSwap (Haveno)

- **Versão atual:** v1.8.0-reto (20/06/2026)
- **Download:** `github.com/retoaccess1/haveno-reto/releases`
- **Direção:** XMR ↔︎ Fiat, XMR ↔︎ BTC
- **Diferencial:** P2P descentralizado, escrow multisig
- **Quando usar:** Swap reverso (XMR→BTC) ou entrada fiat sem KYC
- **Atenção:** Pesquisa (arXiv:2505.02392, 2025) identificou padrões detectáveis on-chain em certas transações Haveno. Use para XMR→BTC onde não há alternativa trustless equivalente.
- **AVISO — Versões antigas:** A partir de 17/06/2026, versões anteriores foram descontinuadas por atualização de protocolo. Use sempre a versão mais recente do GitHub.

### BasicSwap DEX

- **Direção:** BTC ↔︎ XMR (e mais pares futuros)
- **Diferencial:** Atomic swap trustless total, sem taxas de maker/taker
- **Quando usar:** Trustlessness máxima (requer Docker + ~400 GB)
- **Complexidade:** Alta

### RoboSats

- **Direção:** Fiat → BTC (Lightning)
- **Diferencial:** P2P sobre Tor, avatares descartáveis, sem KYC
- **Quando usar:** Comprar BTC com Pix sem criar conta
- **Pré-requisito:** Requer carteira Lightning (Zeus, Phoenix ou Breez). Sem uma carteira Lightning configurada, você não consegue receber os fundos.

---

## 14.4 Mixagem — Alternativas ao Whirlpool

### JoinMarket

- **Tipo:** CoinJoin P2P descentralizado
- **Diferencial:** Sem coordenador central, makers ganham fees
- **Quando usar:** Backup se o coordenador Whirlpool cair

### WabiSabi (Wasabi Wallet)

- **Tipo:** CoinJoin com coordenador
- **Diferencial:** Pool de valores iguais, anonset alto
- **Quando usar:** Alternativa ao Whirlpool/Sparrow

---

## 14.5 Carteiras Monero — Alternativas ao Feather

### Cake Wallet

- **Plataforma:** iOS e Android
- **Diferencial:** Multi-coin (BTC, XMR, ETH, LTC, SOL), swap integrado
- **Quando usar:** Uso mobile casual (não para grandes valores)

### Monero GUI

- **Plataforma:** Desktop (Windows, Mac, Linux)
- **Diferencial:** Carteira oficial, nó completo ou simples
- **Quando usar:** Máxima compatibilidade com a rede Monero

---

\newpage

## 14.6 Matriz de Decisão Rápida

| Situação | Ferramenta principal | Alternativa |
| --- | --- | --- |
| Melhor segurança BTC | Coldcard MK5 | Jade, Passport, Krux |
| Coordinator BTC | Sparrow | Electrum, Specter |
| CoinJoin | Whirlpool (Sparrow) | JoinMarket |
| Swap BTC→XMR | eigenwallet | BasicSwap |
| Swap XMR→BTC | RetoSwap | BasicSwap |
| Entrada fiat sem KYC | RoboSats | RetoSwap, venda direta |
| Carteira XMR | Feather | Cake (mobile), Monero GUI |
| Ambiente principal | Whonix | Tails (ocasional) |
| Ambiente cirúrgico | Tails | Whonix |

---

## 14.7 O que NÃO usar

Algumas ferramentas foram descontinuadas ou apresentaram vulnerabilidades:

| Ferramenta | Motivo |
| --- | --- |
| Samourai Wallet | Apreendida em 2024, sem atualizações |
| Whirlpool CLI original | Coordinador desligado |
| MyMonero | Encerrado em janeiro de 2026 |
| Subgraph OS | Descontinuado em 2026, sem manutenção |
| Linux Kodachi | Auditorias negativas — não recomendado para cripto |
| Ferramentas sem PGP | Risco de malware |
| Forks não auditados | Risco de backdoor |

---

\newpage

## 14.8 Celular: GrapheneOS vs. CalyxOS

O componente mobile do ecossistema — usado para watching-only e como interface discreta no dia a dia — precisa de um sistema operacional que não envie seus dados para o Google ou Apple.

### GrapheneOS

**Dispositivos suportados:** Apenas Google Pixel (4a, 5, 6, 7, 8 e variantes)

**Filosofia:** Segurança em primeiro lugar. Adiciona sandbox reforçado para aplicativos, controles de permissão granulares, proteção de memória adicional e atualizações rápidas de segurança. Pode rodar aplicativos Android via "sandboxed Google Play" (sem acesso privilegiado ao sistema).

**Quando escolher:** Você quer máxima segurança técnica, está disposto a usar um Pixel, e entende que a usabilidade é ligeiramente mais restrita.

**Para uso com Bitcoin/Monero:** Instale Sparrow (watching-only), Feather Wallet, KeePassDX. Todas as conexões passam pelo perfil de Tor da carteira ou por aplicativo Tor separado.

### CalyxOS

**Dispositivos suportados:** Google Pixel, alguns Motorola, FairPhone

**Filosofia:** Privacidade acessível. Inclui MicroG (substituto open-source do Google Play Services), o que facilita compatibilidade com mais aplicativos sem exigir conta Google.

**Quando escolher:** Você quer um celular com privacidade que funcione como um Android comum para pessoas não técnicas, com compatibilidade mais ampla de aplicativos.

**Para uso com Bitcoin/Monero:** Mesmas carteiras que o GrapheneOS. O Orbot (Tor para Android) permite rotear aplicativos específicos pelo Tor.

### Regras comuns para qualquer celular soberano

1. **Não faça login com sua conta Google/Apple pessoal.** Um celular de privacidade vinculado à sua conta real é um celular de nada.
2. **Use o F-Droid** para instalar aplicativos open-source sem precisar da Play Store.
3. **Ative o bootloader lock** após a instalação — impede que alguém reinstale o sistema sem sua senha.
4. **Não armazene seeds nem passphrases no celular.** O celular é watching-only, não um cofre.
5. **Use apenas para valores pequenos** — o celular é a camada de conveniência, não a camada de segurança.

---

## 14.9 Como manter-se atualizado sobre as ferramentas

O ecossistema de privacidade em Bitcoin evolui rapidamente. Ferramentas são atualizadas, vulnerabilidades são descobertas, projetos são descontinuados. Algumas formas de se manter informado sem comprometer sua privacidade:

**Para atualizações de software:** Assine o canal oficial de cada projeto via RSS ou visita regular ao GitHub (via Tor). Não dependa de notificações de terceiros.

**Para notícias sobre vulnerabilidades:** O site `bitcoin.org` e o GitHub do Bitcoin Core publicam avisos de segurança. O blog do Sparrow Wallet e os canais oficiais do Whonix fazem o mesmo.

**Para discussão técnica:** O subreddit r/Bitcoin (leitura) e o fórum Bitcointalk têm discussões técnicas. Acesse via Tor e sem login para não expor seus interesses.

**Regra geral:** Se uma ferramenta principal for comprometida, você saberá — a comunidade Bitcoin e Monero é vigilante. O que você precisa é ter o hábito de verificar, em vez de assumir que tudo está bem.

---

## Resumo do Capítulo

Ter alternativas não é paranoia — é preparação. Cada ferramenta deste capítulo resolve o mesmo problema por um caminho diferente. Se uma falhar, você continua operando.

A diversidade de ferramentas é uma defesa. A dependência de uma única ferramenta é uma vulnerabilidade.

---

No próximo capítulo, falaremos dos itens que literalmente salvam vidas — conceitos e técnicas que protegem contra as ameaças mais avançadas.
