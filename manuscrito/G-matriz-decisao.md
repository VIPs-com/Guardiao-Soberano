# Apêndice G — Matriz de Decisão de Ferramentas

---

## Não se perca: trilha vs. alternativa

Use esta página quando um vídeo, fórum ou amigo citar outro nome. **Pergunta-chave:** *qual **papel** ocupa?* Se for o mesmo da trilha, é **backup** — não obrigação de migrar.

| Papel | Trilha *(Caps. 5–12)* | Mesma função *(outros nomes)* | Trocar no meio da trilha? |
| --- | --- | --- | --- |
| Assinar / seed offline | Coldcard *(ou SeedSigner/Krux DIY)* | Jade, Passport, Keystone, AirGap | Só se HW morrer **antes** de fundos grandes |
| Coordinator BTC + PSBT | **Sparrow** | Electrum, Specter | **Evite** — concorrente direto |
| CoinJoin | Whirlpool (Sparrow) | JoinMarket, Wasabi | **Evite** — reinicia anonset |
| Ambiente persistente | Whonix | Tails *(pontual)*, Qubes *(N7)* | Tails complementa; não substitui WS |
| XMR desktop | Feather | Cake, Monero GUI | Só se Feather indisponível |
| BTC→XMR | eigenwallet | BasicSwap | Expert only |
| XMR→BTC | RetoSwap | BasicSwap | Só emergência |
| Multisig / Core UI | Sparrow *(N7)* | Specter Desktop | **N7+** — função extra, não N1–N6 |

**Atualizações futuras:** suba versão **no mesmo** software (Sparrow→Sparrow, Feather→Feather). Troca de marca = novo projeto de migração, não “update”.

Mapa narrativo completo: Capítulo **14.0**.

---

## Qual dispositivo air-gapped usar?

| Situação | Dispositivo | Custo aprox. |
| --- | --- | --- |
| Melhor segurança, padrão ouro | Coldcard MK5 | ~US$170 |
| Orçamento limitado, open source | Blockstream Jade Plus | ~US$169 |
| Prefere QR a SD card | Foundation Passport Batch 2 | ~US$150 |
| Quer construir o próprio, zero confiança | SeedSigner (DIY) | ~€50 em peças |
| Alternativa DIY moderna | Krux (Maix Amigo ou M5StickV) | ~US$40–60 |
| Certificação máxima (EAL7) | NGRAVE ZERO | ~US$400 |
| Sem portas físicas | ELLIPAL Titan 2.0 | ~US$170 |

---

## Qual setup para qual perfil?

| Setup | Perfil | Notas (custo · complexidade · privacidade) |
| --- | --- | --- |
| Tails + Coldcard + Sparrow | Iniciante avançado | Médio · Média · Alta |
| Whonix + Coldcard + eigenwallet | Avançado | Médio · Alta · Muito alta |
| Tails + SeedSigner (DIY) + Sparrow | Técnico, baixo custo | Baixo · Alta · Alta |
| Whonix + SeedSigner + nó próprio | Expert soberano | Alto · Muito alta · Máxima |

---

## Qual software de swap usar?

| Situação | Ferramenta | Notas |
| --- | --- | --- |
| BTC → XMR (entrar no Monero) | eigenwallet | Detecta Tor automaticamente |
| XMR → BTC (sair do Monero) | RetoSwap | P2P, sem KYC |
| Fiat → XMR | RetoSwap (ex-Haveno) | Descentralizado |
| Fiat → BTC sem KYC | RoboSats | Via Tor, Lightning |
| Trustless máximo, sem coordinator | BasicSwap DEX | Mais complexo |

---

## Qual carteira Monero (XMR) usar?

| Situação | Ferramenta |
| --- | --- |
| Desktop principal, privacidade máxima | Feather Wallet + nó próprio |
| Desktop, facilidade | Feather Wallet + servidor remoto |
| Mobile casual | Cake Wallet |
| Integração com RetoSwap | Feather Wallet (recomendado) |

---

## Qual carteira Bitcoin para watch-only?

| Situação | Ferramenta |
| --- | --- |
| Uso geral, CoinJoin, PSBT | Sparrow Wallet |
| Setup simples, hardware wallet básica | Electrum |
| Node próprio integrado | Sparrow + Bitcoin Core |

---

## Qual ambiente usar para cada operação?

Referência expandida: **Capítulo 13.5** (matriz completa) e **Apêndice H** (consulta de bolso).

| Operação | Ambiente recomendado |
| --- | --- |
| Gerar e guardar seed | Coldcard air-gapped (offline total) |
| Validar checksum BIP39 | Tails **sem rede** |
| Visualizar saldo, criar transação | Sparrow na Whonix Workstation |
| CoinJoin (Whirlpool) | Sparrow na Whonix Workstation |
| Swap BTC→XMR | eigenwallet na Whonix Workstation |
| Swap XMR→BTC | RetoSwap na Whonix Workstation |
| Comprar sem KYC | Tails + Feather/Cake (XMR); Tails + RoboSats (BTC) |
| Operações de longa duração | Whonix (persistência) |
| Operações pontuais sem rastro | Tails (amnésico) |
| PSBT via SD | Host `/psbt_bridge` + MicroSD + HW *(Cap. 13.6–13.8)* |
| PSBT via QR | Sparrow WS ou mobile watch-only + HW *(Cap. 13.6)* |

### Três posturas do celular

| Postura | Seed no telefone? | Uso |
| --- | --- | --- |
| Watch-only | **Não** | Saldo, alertas |
| Coordinator PSBT | **Não** | Montar tx → HW assina |
| AirGap Vault / similar | **Sim** | Emergência ou valores pequenos — **não** trilha principal |

---

## Modelo de ameaça por camada (resumo)

| Camada | Adversário típico | Defesa principal |
| --- | --- | --- |
| Seed / metal | Ladrão físico, incêndio | 2× placas + passphrase separada |
| HW air-gapped | Supply chain, troca de endereço | Verificar destino no display; comprar direto |
| Host + bridge | Malware no Windows/Linux | Seed nunca no host; apagar PSBT após uso |
| Whonix WS | Correlação Tor, phishing .onion | uwt, bookmarks .onion, PGP |
| Tails | Persistência acidental | Amnésia; pendrive **A** rotina / **B** cirúrgico *(Cap. 15)* |
| Mobile | App maliciosa, celular roubado | Só xpub; Orbot; dispositivo dedicado |
| On-chain | Chain analysis | Whirlpool + intervalo ABCTracer |

Narrativa completa: **Capítulo 13.4–13.8** e **Capítulo 15**.

---
