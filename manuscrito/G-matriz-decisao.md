# Apêndice G — Matriz de Decisão de Ferramentas

---

## Qual dispositivo air-gapped usar?

| Situação | Dispositivo | Custo aprox. |
| --- | --- | --- |
| Melhor segurança, padrão ouro | Coldcard MK5 | ~US$150 |
| Orçamento limitado, open source | Blockstream Jade | ~US$65 |
| Prefere QR a SD card | Foundation Passport Batch 2 | ~US$150 |
| Quer construir o próprio, zero confiança | SeedSigner (DIY) | ~€50 em peças |
| Alternativa DIY moderna | Krux (Maix Amigo ou M5StickV) | ~US$40–60 |
| Certificação máxima (EAL7) | NGRAVE ZERO | ~US$400 |
| Sem portas físicas | ELLIPAL Titan 2.0 | ~US$170 |

---

\newpage

## Qual setup para qual perfil?

| Setup | Perfil | Notas (custo · complexidade · privacidade) |
| --- | --- | --- |
| Tails + Coldcard + Sparrow | Iniciante avançado | Médio · Média · Alta |
| Whonix + Coldcard + eigenwallet | Avançado | Médio · Alta · Muito alta |
| Tails + SeedSigner (DIY) + Sparrow | Técnico, baixo custo | Baixo · Alta · Alta |
| Whonix + SeedSigner + nó próprio | Expert soberano | Alto · Muito alta · Máxima |

---

\newpage

## Qual software de swap usar?

| Situação | Ferramenta | Notas |
| --- | --- | --- |
| BTC → XMR (entrar no Monero) | eigenwallet | Detecta Tor automaticamente |
| XMR → BTC (sair do Monero) | RetoSwap | P2P, sem KYC |
| Fiat → XMR | Haveno (RetoSwap) | Descentralizado |
| Fiat → BTC sem KYC | RoboSats | Via Tor, Lightning |
| Trustless máximo, sem coordinator | BasicSwap DEX | Mais complexo |

---

\newpage

## Qual carteira Monero (XMR) usar?

| Situação | Ferramenta |
| --- | --- |
| Desktop principal, privacidade máxima | Feather Wallet + nó próprio |
| Desktop, facilidade | Feather Wallet + servidor remoto |
| Mobile casual | Cake Wallet |
| Integração com Haveno | Feather Wallet (recomendado) |

---

\newpage

## Qual carteira Bitcoin para watch-only?

| Situação | Ferramenta |
| --- | --- |
| Uso geral, CoinJoin, PSBT | Sparrow Wallet |
| Setup simples, hardware wallet básica | Electrum |
| Node próprio integrado | Sparrow + Bitcoin Core |

---

\newpage

## Qual ambiente usar para cada operação?

| Operação | Ambiente recomendado |
| --- | --- |
| Gerar e guardar seed | Coldcard air-gapped (offline total) |
| Visualizar saldo, criar transação | Sparrow na Whonix Workstation |
| CoinJoin (Whirlpool) | Sparrow na Whonix Workstation |
| Swap BTC→XMR | eigenwallet na Whonix Workstation |
| Swap XMR→BTC | RetoSwap (ou eigenwallet como maker) |
| Comprar sem KYC | Tails + Feather/Cake (XMR); Tails + RoboSats (BTC) |
| Operações de longa duração | Whonix (persistência) |
| Operações pontuais sem rastro | Tails (amnésico) |

---
