# Qubes OS + Whonix — ambiente avançado (opcional)

> **Livro:** Capítulo 12 · Trilha D — Defesa Máxima  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Qubes OS 4.x · Whonix templates · Sparrow em qube dedicado  

---

## Objetivo

Entender e planejar migração do VirtualBox para **Qubes OS**: VM por função, qube offline para assinatura, isolamento contra host comprometido.

> Lab **opcional** e avançado. Complete Níveis 3–6 no VirtualBox antes de migrar.

---

## Pré-requisitos

- [ ] Hardware compatível: [Qubes HCL](https://www.qubes-os.org/doc/hcl/) — 16 GB+ RAM recomendado
- [ ] Whonix já dominado — [`../nivel-3-observador/01-whonix-virtualbox-completo.md`](../nivel-3-observador/01-whonix-virtualbox-completo.md)
- [ ] Backup 3-2-1 funcional (N6/01)

---

## Por que Qubes? (Trilha D)

| Problema no host único | Qubes |
| --- | --- |
| Malware no Windows host vê VMs | Cada app em qube isolado |
| Uma VM comprometida afeta outras | Políticas `qrexec` restritas |
| Assinatura na mesma VM que navega | Qube **offline** só PSBT |

---

## Arquitetura alvo

```
sys-net (Tor) → sys-whonix → anon-whonix (Sparrow, eigenwallet)
                    ↓
              vault-qube (OFFLINE, só assina PSBT via qrexec/QR)
                    ↓
              vault-bitcoin (node opcional, sem internet direta)
```

Adapte ao seu diagrama do Cap. 11 passo 6.1.

---

## Passo 1 — Instalar Qubes

1. Baixe ISO em [qubes-os.org](https://www.qubes-os.org/downloads/)
2. Verifique assinatura PGP
3. Instale em disco dedicado (dual-boot possível, mas não ideal)
4. Atualize templates após primeiro boot

---

## Passo 2 — Templates Whonix

1. Instale template Whonix via repositório Qubes
2. Crie qubes:
   - `whonix-gw` (gateway)
   - `whonix-ws` (workstation — Sparrow, mixagem)
3. Teste Tor: mesmo checklist do lab N3/01

---

## Passo 3 — Qube offline (split wallet)

1. Qube **sem rede** (`netvm: none`)
2. Instale apenas ferramentas de assinatura ou use QR com signer físico
3. Transfira PSBT via:
   - **QR** (preferido — zero qrexec de arquivo)
   - `qvm-copy` de qube online para offline (política restrita)

Padrão documentado na wiki Whonix/Qubes há anos — alinhado ao Cap. 6 (split wallet).

---

## Passo 4 — Migrar dados

| De VirtualBox | Para Qubes |
| --- | --- |
| Export Sparrow wallet | Import na qube Whonix WS |
| Snapshots VM | Recrie config; não confie em snapshot opaco |
| EPS / node | Qube dedicado com `sys-firewall` |

Não copie persistência Tails inteira — reinstale apps e importe xpub/descriptor.

---

## Passo 5 — Hábitos do Mestre (Cap. 12)

- [ ] Ler changelog Qubes + Whonix a cada update
- [ ] PGP em cada template update
- [ ] Teste restore semestral **incluindo** qubes offline

---

## Como confirmar que deu certo

- [ ] Whonix qubes conectam via Tor
- [ ] Sparrow na WS assina apenas via air-gap (sem seed na WS)
- [ ] Qube offline não pinga rede (`ping 1.1.1.1` falha)
- [ ] Você documentou diagrama atualizado no KeePassXC

---

## Se der errado

| Problema | Ação |
| --- | --- |
| Hardware não suportado | Mantenha VirtualBox — já é suficiente para muitos |
| RAM insuficiente | Feche qubes não usadas; não rode node + WS + GW no mínimo |
| Livro | Cap. 12 Trilha D · Cap. 13 (arquitetura) |

---

## Referências

- [Qubes Whonix docs](https://www.whonix.org/wiki/Qubes)
- [Qubes OS documentation](https://www.qubes-os.org/doc/)
