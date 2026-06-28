# Capítulo 14 — Ferramentas e Alternativas

> "Não dependa de uma única ferramenta. A soberania exige opções"

---

## Objetivo

Apresentar alternativas para cada componente do ecossistema, garantindo que você tenha opções se sua ferramenta principal estiver indisponível — **sem** confundir você com dezenas de caminhos paralelos.

---

## 14.0 — Mapa da trilha: mesma função, nomes diferentes

Maria terminou o Nível 3 e abriu cinco tutoriais na internet. Um dizia Electrum, outro Specter, outro Wasabi, outro “Krux no celular”. Todas pareciam fazer “a mesma coisa”. Ela quase recomeçou do zero — e perderia semanas.

**Este capítulo não existe para você trocar de trilha.** Existe para você saber que, se o Sparrow cair amanhã, o **papel** “coordinator Bitcoin” continua existindo — só muda o nome do software. O que ensinamos nos Caps. 5–12 é **uma trilha coerente**. As alternativas abaixo são **substitutos de emergência** ou **evoluções para depois** que você dominar o básico.

### Três categorias (memorize)

| Categoria | O que significa | O que fazer |
| --- | --- | --- |
| **Trilha do livro** | Stack que você montou nos Níveis 0–7 | **Siga até concluir.** Atualize versões **no mesmo** software. |
| **Mesma função, outro nome** | Faz o **mesmo papel** (assinar, misturar, trocar…) com outra marca | **Não troque no meio da trilha.** Use só se a ferramenta da trilha morrer ou após dominar o fluxo. |
| **Função diferente** | Parece “carteira Bitcoin”, mas serve outro cenário (multisig avançado, app de estudo…) | **Não é concorrente da trilha Sparrow** — é outro capítulo da sua jornada (ex.: Nível 7). |

> **AVISO — regra de ouro:** Uma seed, um coordinator, um fluxo PSBT. Não importe a mesma seed em Sparrow **e** Electrum **e** Specter “só para testar” sem entender o que muda. Confusão de xpub, gap limit e CoinJoin quebrado é comum.

### Mapa por **papel** (não por marca)

Cada linha é um **assento na mesa** do ecossistema. Vários produtos sentam no mesmo assento — você escolhe **um** durante a trilha.

| Papel | Trilha do livro | Outras opções (mesma função) | Concorre com a trilha? | Quando usar alternativa |
| --- | --- | --- | --- | --- |
| **Guardar seed e assinar PSBT** | Coldcard MK5 *(ou SeedSigner/Krux no perfil DIY)* | Jade Plus, Passport, Keystone, Krux (Maix), AirGap Vault | **Substituto de hardware** — escolha **um** no N1 e mantenha | HW queimou; preferência QR vs SD **antes** de enviar fundos |
| **Coordinator BTC** (saldo, UTXO, PSBT, Tor) | **Sparrow** na Whonix WS | Electrum, Specter Desktop | **Sim — mesma função.** Não misture na trilha | Sparrow indisponível; Electrum no Tails para tarefa pontual |
| **CoinJoin BTC** | **Whirlpool** (via Sparrow) | JoinMarket, Wasabi (WabiSabi) | **Sim — mesma função** | Coordinator Whirlpool offline por semanas |
| **Ambiente isolado (longo prazo)** | **Whonix** GW + WS | Tails *(sessões)*, Qubes *(N7)* | **Parcial** — Tails complementa, não substitui WS | Operação amnésica; expert em N7 |
| **Nó Bitcoin próprio** | Bitcoin Core + EPS *(N3+)* | Servidor público Sparrow/Electrum | **Evite** servidores públicos na trilha | Falta de disco — solução temporária apenas |
| **Carteira XMR** | **Feather** | Cake Wallet, Monero GUI | **Sim — mesma função** | Mobile casual; GUI oficial |
| **Swap BTC → XMR** | **eigenwallet** | BasicSwap DEX | **Sim — mesma função** | Trustlessness máximo (expert) |
| **Swap XMR → BTC** | **RetoSwap** | BasicSwap; eigenwallet como maker | **Sim — mesma função** | RetoSwap fora do ar *(raro)* |
| **Multisig avançado** | Sparrow *(N7)* | **Specter Desktop** + Core | **Não na trilha N1–N6** — outro cenário | 2-of-3, herança, várias HW |
| **Aprender fluxo air-gap** | Laboratório / testnet | KruxMobileApp *(Android)* | **Não** — pedagógico, não cofre | Testnet only; ver nota [^krux-mobile] |

**Concorrente direto da trilha Sparrow** = outro **coordinator BTC** (Electrum, Specter como carteira do dia a dia). **Não concorrente** = Specter só para multisig, KruxMobileApp só para estudo, Liana para herança — **função diferente** ou **fase diferente**.

### O que fazer quando sair atualização

1. **Atualize no lugar** — Sparrow 2.5.2 → 2.5.3 no **mesmo** Sparrow; Whonix OVA → importe a nova OVA **no mesmo** desenho GW+WS.
2. **Confira PGP** — Apêndice D; nunca instale binário novo sem verificar assinatura.
3. **Não “aproveite a atualização” para trocar de stack** — trocar Electrum no meio do N4 Whirlpool zera anonset e confunde UTXOs.
4. **Leia o CHANGELOG do projeto** — breaking changes (como RetoSwap pós-17/06/2026) exigem ação; mudança de marca não.

### Stack canônico da trilha (referência rápida)

```
Seed (metal) → HW air-gapped → xpub → Sparrow (Whonix WS) → PSBT → HW assina
                                    → Whirlpool (N4)
                                    → eigenwallet (N5) → Feather → RetoSwap (N5)
Ambiente: Whonix (+ Tails pontual) · Tor · KeePassXC (metadados, não seed)
```

Detalhes por nível: Caps. 5–12. Matriz expandida: Apêndice G.

> **Para o aprendiz:** Se sentir vertigem com nomes novos, volte a esta tabela. Pergunte: *“Qual **papel** este software ocupa?”* Se for o mesmo papel do Sparrow, é **alternativa** — não obrigação. Se for outro papel, não abandone a trilha por causa dele.

---

## 14.0b — Ambientes: air-gap, Tails, Whonix e mobile

A seção **14.0** mapeia **ferramentas** (Sparrow vs Electrum). Esta seção mapeia **lugares** onde você opera — outra fonte comum de confusão.

| Termo que você ouve | O que **não** é | O que **é** na trilha |
| --- | --- | --- |
| **Air-gap / air-gapped** | Um sistema operacional | **Propriedade** do dispositivo que guarda seed: zero rede ao assinar |
| **Tails** | Substituto da Coldcard | **Computador amnésico** para sessões Tor sem rastro |
| **Whonix** | Carteira Bitcoin | **Par de VMs** (GW+WS) onde você *mora* operacionalmente |
| **AirGap Vault** | Sinônimo de “qualquer HW” | **App** de cofre no celular — postura diferente (Cap. 13.5) |
| **Celular CalyxOS** | Cofre principal | **Watch-only / PSBT coordinator** — seed no HW |

### Árvore rápida de decisão

```
Preciso TOCAR na seed?
├─ SIM → só HW air-gapped (ou metal backup offline)
└─ NÃO → preciso de rede?
    ├─ Operação única, sem rastro → Tails
    ├─ Rotina (mix, swap, nó) → Whonix WS
    └─ Só consultar saldo → mobile watch-only OU Sparrow WS
```

**Regra de ouro:** uma seed, um coordinator principal (Sparrow na WS), um fluxo PSBT. Tails **complementa** Whonix; mobile **não substitui** HW.

Mapa completo, matriz operacional, fluxos PSBT e regras da pasta bridge: **Capítulo 13.4–13.8**. Folha de consulta: **Apêndice H**.

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

A equipe do Krux mantém um **app Android experimental** ([KruxMobileApp](https://github.com/selfcustody/KruxMobileApp)) que replica a interface Krux no celular para **aprender** fluxos PSBT air-gapped. Esse projeto **não substitui** o firmware em hardware dedicado descrito acima: o próprio repositório avisa que celulares têm OS, bibliotecas e periféricos fora do seu controle, que o código ainda é pouco testado e que **não se deve** guardar poupança ou mnemônicos importantes no app.[^krux-mobile] Para a trilha do livro (Nível 1), use Maix Amigo ou M5StickV com firmware oficial ([selfcustody.github.io/krux](https://selfcustody.github.io/krux)). Se quiser experimentar o app, faça apenas em **testnet ou regtest**, com seed descartável, em aparelho que nunca volte à internet com dados sensíveis.

[^krux-mobile]: Repositório `selfcustody/KruxMobileApp` (jun/2026): APK em beta (`26.06.beta1`), assinaturas ainda não gerenciadas, atualizações podem exigir reinstalação e apagar configurações ou mnemônicos cifrados. Mantido como ferramenta pedagógica, não como cold wallet.

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
- **Download:** [specter.solutions/downloads](https://specter.solutions/downloads) (GUI, `specterd`, PyPI, Docker)
- **Open source:** Sim ([GitHub](https://github.com/cryptoadvance/specter-desktop))

O **Specter Desktop** é a alternativa correta quando você já tem **Bitcoin Core** (ou EPS) e quer coordenar **multisig** com várias hardware wallets — cenário típico do Nível 7 (Cap. 12). **Não substitui o Sparrow** na trilha principal: o Sparrow continua sendo o coordinator recomendado para PSBT, Tor nativo e **Whirlpool** (Caps. 7–9). Specter não cobre CoinJoin integrado da mesma forma.

Distribuição oficial em [specter.solutions/downloads](https://specter.solutions/downloads): binários para Windows, macOS e Linux, arquivo `SHA256SUMS` assinado com a chave **Specter Signer** (fingerprint no Apêndice D).[^specter-pgp] No Linux, configure as regras `udev` incluídas no arquivo; no macOS, exige Catalina (10.15) ou superior.

> **Nota — nome parecido:** no Capítulo 6, “Specter DIY” refere-se a **hardware** open-source alternativo (como Keystone ou Passport). **Specter Desktop** é **software** de carteira — produtos diferentes.

[^specter-pgp]: Chave de release Specter Signer: `785A 2269 EE3A 9736 AC1A 4F4C 864B 7CF9 A811 FEF7`. Verificação passo a passo: Apêndice D.

### Liana Wallet

- **Função:** Carteira com herança programável
- **Diferencial:** Miniscript + timelocks para sucessão
- **Quando usar:** Planejamento de herança

---

## 14.3 Swaps — Alternativas ao eigenwallet

### RetoSwap

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

## 14.6 Matriz de Decisão Rápida

> **Lembrete:** coluna “Alternativa” = **mesma função**, não convite a trocar de trilha. Ver seção **14.0**.

| Situação | Ferramenta principal *(trilha)* | Alternativa *(mesma função)* |
| --- | --- | --- |
| Melhor segurança BTC | Coldcard MK5 | Jade, Passport, Krux, SeedSigner |
| Coordinator BTC | **Sparrow** | Electrum, Specter *(multisig/Core — N7)* |
| CoinJoin | Whirlpool (Sparrow) | JoinMarket, Wasabi |
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

Ter alternativas não é paranoia — é preparação. Cada ferramenta deste capítulo resolve o **mesmo tipo de problema** por um caminho diferente. Se uma falhar, você continua operando **desde que saiba qual papel ela ocupa**.

A diversidade de ferramentas é uma defesa. **Trocar de trilha a cada tutorial novo** é vulnerabilidade operacional.

**Antes de instalar qualquer nome novo:** consulte a seção **14.0** — *mesma função, nomes diferentes* — e **14.0b** — *ambientes (air-gap, Tails, Whonix, mobile)*.

---

No próximo capítulo, falaremos dos itens que literalmente salvam vidas — conceitos e técnicas que protegem contra as ameaças mais avançadas.
