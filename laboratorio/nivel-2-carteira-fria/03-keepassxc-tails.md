# KeePassXC no Tails — cofre na persistência

> **Livro:** Capítulo 7 · seção *KeePassXC no Ambiente Persistente*  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em Tails real)  
> **Software:** Tails 7.9 · KeePassXC 2.7.9 (AppImage) ou pré-instalado no Tails  

---

## Objetivo

Criar um banco **`.kdbx`** cifrado na partição persistente do Tails — segunda camada além do LUKS — para guardar PINs, passphrases, xpubs, metadados de swaps, tokens RoboSats e (se aplicável ao seu perfil) seeds Monero **somente dentro do cofre cifrado**.

---

## Por que não texto puro na persistência?

A persistência LUKS protege o USB, mas se alguém obtiver a senha da persistência (coação, senha fraca, vulnerabilidade futura), arquivos em texto claro ficam expostos. O `.kdbx` exige **outra** senha forte para abrir.

```
[USB Tails] → LUKS (senha 1) → ~/Persistent/ → fortaleza_cofre.kdbx (senha 2)
```

---

## Pré-requisitos

- [ ] Lab [`05-tails-setup-btc-xmr-completo.md`](05-tails-setup-btc-xmr-completo.md) — passos 1–3 (Tails instalado, persistência, Tor OK)
- [ ] Frase-senha do cofre **memorizada** (diferente da senha da persistência e do GPG de backup)
- [ ] Perfil claro: se usa **hardware wallet** para BTC, não armazene seed BIP39 de assinatura aqui — use o cofre para metadados, xpub, PINs e notas operacionais

---

## Caminho A — KeePassXC pré-instalado (rápido)

O Tails já inclui KeePassXC:

1. **Applications → Accessories → KeePassXC**
2. Pule para [Criar o banco de dados](#criar-o-banco-de-dados-o-cofre)

> O binário some ao reiniciar se não usar Additional Software; para instalação **persistente**, prefira o Caminho B.

---

## Caminho B — AppImage na persistência (recomendado)

### 1. Baixar o AppImage

```bash
mkdir -p /home/amnesia/Persistent/Apps

torsocks wget -P /home/amnesia/Persistent/Apps/ \
  https://github.com/keepassxreboot/keepassxc/releases/download/2.7.9/KeePassXC-2.7.9-x86_64.AppImage
```

Verifique assinatura GPG quando possível (`.sig` no [GitHub KeePassXC](https://github.com/keepassxreboot/keepassxc/releases)).

### 2. Tornar executável

```bash
chmod +x /home/amnesia/Persistent/Apps/KeePassXC-*.AppImage
```

### 3. Script de inicialização

Copie o conteúdo de `laboratorio/scripts/tails/start-keepass.sh` (do repositório clonado ou USB) para `/home/amnesia/Persistent/start-keepass.sh`, ou crie manualmente:

```bash
cat > /home/amnesia/Persistent/start-keepass.sh << 'EOF'
#!/bin/bash
exec /home/amnesia/Persistent/Apps/KeePassXC-*.AppImage "$@"
EOF
chmod +x /home/amnesia/Persistent/start-keepass.sh
```

Após cada boot:

```bash
/home/amnesia/Persistent/start-keepass.sh &
```

---

## Criar o banco de dados (o cofre)

1. Abra o KeePassXC (atalho ou script).
2. **Create new database**
3. Nome sugerido: `fortaleza_cofre`
4. Senha mestra: frase longa (7+ palavras diceware) — **diferente** da senha da persistência
5. (Opcional avançado) Key file em mídia separada
6. Salvar em:

```
/home/amnesia/Persistent/fortaleza_cofre.kdbx
```

---

## Configurações de segurança

**Tools → Settings:**

| Seção | Ajuste |
| --- | --- |
| Security → Clear clipboard after | 20–30 s |
| Security → Lock after inactivity | 2 min |
| Security → Lock when minimized | Ligado |

---

## Estrutura de grupos sugerida

| Grupo | Conteúdo |
| --- | --- |
| **Bitcoin** | xpub, fingerprints, endereços reservados, hashes de verificação de downloads |
| **Monero** | Seeds Polyseed (se perfil Tails-only), restore height, subendereços usados |
| **RetoSwap / swaps** | IDs de oferta, intervalos planejados, notas ABCTracer |
| **RoboSats** | Token do Robot (um por trade) |
| **Senhas Web** | Bridges Tor, logins `.onion` |
| **Backup** | Local do off-site, frase do GPG de backup |

### Exemplo — entrada Monero

1. Nova entrada: `Carteira XMR — Fortaleza`
2. Campo **Password:** seed (25 palavras) — só se aceitar risco operacional documentado no livro
3. **Advanced → Additional Attributes:**
   - `RestoreHeight`: (altura de restauração)
   - `DataCriacao`: AAAA-MM-DD
   - `Tipo`: Monero standard
4. **Notes:** onde está backup em aço, passphrase extra, etc.

> Seeds no `.kdbx` são aceitáveis **porque** o arquivo usa AES-256/ChaCha20 **dentro** do LUKS. Duas camadas — não substituem backup em metal.

---

## Uso no dia a dia

1. Boot Tails → desbloqueie persistência
2. Execute `start-keepass.sh`
3. Desbloqueie o cofre
4. Copie o segredo necessário → cole no app → clipboard limpa em segundos
5. **Trave o cofre** (`Ctrl+L`) ao terminar — não deixe aberto

---

## Como confirmar que deu certo

- [ ] Após **reboot**, o arquivo existe: `ls -la ~/Persistent/fortaleza_cofre.kdbx`
- [ ] KeePassXC abre o `.kdbx` com a senha mestra
- [ ] Entradas de teste (ex.: “teste-recuperacao”) aparecem após reiniciar
- [ ] Cofre **trava** após inatividade configurada
- [ ] Clipboard limpa após copiar senha (teste com bloco de notas)

### Teste de recuperação (recomendado)

1. Crie entrada `TESTE-RECUPERACAO` com senha aleatória
2. Reinicie o Tails
3. Abra o cofre e confirme a entrada
4. (Ambiente de teste) Restaure `.kdbx` do backup GPG do ritual 3-2-1 — deve abrir igual

---

## Se der errado

| Problema | Ação |
| --- | --- |
| Esqueci senha do cofre | Sem recuperação — previna com memória + backup físico separado |
| AppImage não abre | `chmod +x` novamente; baixar versão compatível com Tails |
| `.kdbx` corrompido | Restaurar do backup 3-2-1 (ver livro cap. 7 / lab futuro `01-backup-3-2-1`) |
| Synaptic instalou e sumiu | Use AppImage no `Persistent/Apps/` |

Livro: **Apêndice F** — Troubleshooting

---

## Regras de ouro

- **Nunca** guarde a senha mestra do KeePassXC dentro do próprio KeePassXC
- **Não** use extensão KeePassXC-Browser no Tor Browser — digite manualmente
- **Backup** do `.kdbx` no ritual 3-2-1 (arquivo pequeno, incluir no `tar` cifrado)
- Considere cópia do `.kdbx` em **USB separado** cifrado (VeraCrypt/LUKS)

---

## Próximo lab

- [`04-electrum-tails.md`](04-electrum-tails.md) — Electrum persistente com Tor  
- [`05-tails-setup-btc-xmr-completo.md`](05-tails-setup-btc-xmr-completo.md) — visão geral do ambiente  

---

## Referências oficiais

- [KeePassXC — Documentação](https://keepassxc.org/docs/)
- [KeePassXC — Releases](https://github.com/keepassxreboot/keepassxc/releases)
- [Tails — Persistent Storage](https://tails.net/doc/persistent_storage/)

---

*Extraído de `manuscrito/07-nivel-2-carteira-fria.md` e pesquisa Manual da Fortaleza (backup `old/manuscrito-backups/`).*
