# Capítulo 8 — Nível 3: O Observador

> "Construindo a fortaleza digital"

---

## Objetivo

Migrar para ambiente Whonix com **node próprio** (Bitcoin Core) e **EPS** (Electrum Personal Server), eliminando dependência de servidores públicos. Construir independência total de rede.

**Tempo estimado:** 1–2 semanas | **Dificuldade:** 4/5

**Pré-requisitos:** Nível 2 concluído + computador com **8 GB RAM mínimo** (16 GB recomendado para full node + três VMs).

---

### Passo 3.1 — Instalar VirtualBox no host

> **OVA** = arquivo de appliance que importa uma VM pronta no VirtualBox. **Snapshot** = «foto» do estado da VM para voltar atrás se algo der errado.

- [ ] Baixar VirtualBox de virtualbox.org
- [ ] Instalar no seu sistema operacional principal
- [ ] Conceitos para entender:
  - Máquina Virtual (VM): computador dentro do computador
  - Rede NAT: VM acessa internet via host
  - Rede Interna: VMs conversam entre si, sem internet direta
  - Snapshots: "foto" do estado da VM para voltar atrás
- [ ] Se seu host é Linux, considere KVM:
  - Mais performance que VirtualBox
  - Hypervisor nativo do Linux
  - VirtualBox é mais simples para começar
  - KVM é para quando você estiver confortável

---

### Passo 3.2 — Instalar Whonix

- [ ] Baixar Whonix de whonix.org (via Tor Browser)
- [ ] Baixar assinatura .asc e verificar (chave 2EEACCDA)
- [ ] VirtualBox → Arquivo → Importar appliance (Import Appliance) → selecionar arquivo .ova
- [ ] Duas VMs são criadas:
  - Whonix-Gateway (força Tor)
  - Whonix-Workstation (onde você trabalha)
- [ ] INICIAR GATEWAY PRIMEIRO
  - Aguardar ícone Tor ficar verde
  - Só depois iniciar a Workstation
- [ ] Na Workstation, verificar Tor:

```bash
curl --socks5-hostname 127.0.0.1:9050 \
  https://check.torproject.org
```

  - Deve mostrar: "Congratulations. You are using Tor."
- [ ] Trocar senha padrão (changeme → sua senha forte):

```bash
passwd
```

---

### Passo 3.3 — Instalar ferramentas na Workstation

- [ ] Sparrow Wallet (mesmo processo do Tails):
  - Baixar AppImage + verificar PGP
  - Tornar executável e rodar
- [ ] KeePassXC:

```bash
sudo apt install keepassxc -y
```

  - Criar banco "whonix_crypto.kdbx"
  - Guardar: senhas, .onions, metadados
  - NUNCA guardar seed
- [ ] Electrum (opcional, já que Sparrow é o foco):
  - Pode instalar para ter alternativa

---

### Passo 3.4 — Entender isolamento de stream (Stream Isolation)

- [ ] Conceito: cada app usa circuito Tor SEPARADO (isolamento de stream)
- [ ] Impede que um app revele identidade de outro
- [ ] Sparrow: Tor integrado nativo (automático)
- [ ] Electrum: `--oneserver --server .onion` (isolado)
- [ ] Whonix: uwt (Usability Wrapper for Tor) gerencia isso
- [ ] Verificar: cada conexão de app deve ter circuito diferente

---

### Passo 3.5 — Criar VM para Bitcoin Core + EPS

> **EPS** = Electrum Personal Server — software que conecta sua xpub (watching-only) ao seu node Bitcoin, sem expor endereços a terceiros.

- [ ] VirtualBox → Nova VM (New) → "Bitcoin-Node"
- [ ] SO: Debian minimal
- [ ] RAM: 4–8 GB (full node: 8 GB, pruned: 4 GB)
- [ ] Disco: 400 GB (pruned) ou 800 GB (full)
- [ ] Rede: Rede interna (Internal Network) "Whonix"
- [ ] Instalar Debian, atualizar sistema
- [ ] Instalar Bitcoin Core:
  - Baixar de bitcoincore.org
  - Verificar PGP (chaves dos desenvolvedores)
  - Configurar bitcoin.conf para Tor (`onlynet=onion`)
- [ ] Instalar EPS (Electrum Personal Server):
  - clonar repositório oficial (`git clone`)
  - Configurar com sua xpub
  - Configurar serviço oculto Tor (Tor hidden service)
  - Anotar endereço .onion gerado
- [ ] Sincronização inicial: 2–7 dias via Tor
  - Manter `onlynet=onion` ativo durante toda a IBD (Lei 5)

> **AVISO:** NÃO sincronizar via clearnet — expõe IP e metadados.

  - Enquanto sincroniza, pode usar servidor Electrum público via Tor temporariamente; depois conecte ao seu EPS (Passo 3.6)

---

### Passo 3.6 — Conectar Sparrow ao seu EPS

- [ ] Sparrow → Preferências (Preferences) → Servidor (Server) → Electrum privado (Private Electrum)
- [ ] URL: `seu_onion.onion:50002`
- [ ] Testar conexão (Test Connection) → VERDE
- [ ] Console Sparrow → `getinfo` → confirmar servidor
- [ ] AGORA VOCÊ É INDEPENDENTE
  - Nenhum servidor público sabe seus endereços
  - Nenhum terceiro correlaciona suas transações
  - Seu node, seu EPS, sua privacidade

---

### Passo 3.7 — Configurar pasta compartilhada para PSBT

- [ ] Criar pasta no host: `/psbt_bridge`
- [ ] VirtualBox → Configurações (Settings) → Pastas compartilhadas (Shared Folders) → adicionar
- [ ] Workstation acessa em: `/mnt/psbt_bridge`
- [ ] Testar: criar arquivo no host, ver na Workstation
- [ ] Fluxo PSBT: Sparrow → `/mnt/psbt_bridge` → MicroSD → Dispositivo

---

### Passo 3.8 — Entender o risco do Host OS

> **AVISO:** Whonix protege DENTRO das VMs. Mas se o HOST (seu Windows/Linux/macOS) estiver comprometido, keylogger pode capturar tudo que você digita na VM, malware pode ver sua tela, e senhas, endereços e metadados podem vazar.

- [ ] Whonix protege DENTRO das VMs
- [ ] Mas se o HOST (seu Windows/Linux/macOS) estiver comprometido:
  - Keylogger pode capturar tudo que você digita na VM
  - Malware pode ver sua tela
  - Senhas, endereços, metadados podem vazar
- [ ] Mitigações:
  - Manter host LIMPO e ATUALIZADO
  - Não instalar software pirata ou suspeito
  - Ideal: host Linux dedicado só para isso
  - Máximo: Qubes OS (Nível 7) resolve esse problema
  - As CHAVES PRIVADAS nunca estão no computador (Coldcard assina offline — isso salva mesmo com host comprometido)

---

### Verificação do Nível 3

**Obrigatório antes de operar com valor real:**

- [ ] Whonix Gateway + Workstation funcionando
- [ ] Sparrow conectado ao SEU EPS (.onion), não a servidor público
- [ ] Fluxo PSBT testado via pasta compartilhada
- [ ] Stream Isolation (isolamento de stream) compreendido

**Ambiente configurado:**

- [ ] Node Bitcoin sincronizado (ou em progresso — OK usar EPS depois)
- [ ] EPS rodando com .onion próprio
- [ ] Sei fazer snapshot da VM antes de operações críticas
- [ ] Entendo o risco do host OS e como mitigar

---

## Conquista: "O Observador"

> Não dependo de servidores alheios. Meu node valida minhas transações. Meu EPS responde só a mim. A fortaleza digital está de pé — e sei onde estão suas muralhas e suas brechas.

---

## Leitura opcional — após Nível 3

As seções abaixo aprofundam instalação Whonix, cifragem de VMs, rotina diária e comparação Tails vs Whonix. **Não são obrigatórias** para concluir o Nível 3.

> **Prévia do N5:** menções a Feather, eigenwallet e RetoSwap são contexto para o Capítulo 10 — **não instale nem opere swaps** até lá.

---

## Aprofundamento: Configuração Completa do Whonix

**Diferença fundamental do Whonix:** persistência por design. Ao contrário do Tails, configurações, wallets, estado de swaps e histórico sobrevivem ao reboot — em discos virtuais cifrados pelo VirtualBox.

### Como o Whonix se divide

| Camada | Função | RAM |
| --- | --- | --- |
| **Host** (Linux/Windows/macOS) | VirtualBox/KVM roda aqui | — |
| **Whonix-Gateway** | Tor, firewall, kill switch | 512 MB |
| **Whonix-Workstation** | Sparrow, KeePassXC, ferramentas (sem IP real) | 2–4 GB |
| **Dispositivo air-gapped** | Coldcard/SeedSigner — SD/QR, nunca rede | — |

A Workstation só fala com a Gateway (rede interna). A Gateway força todo tráfego via Tor.

### Requisitos mínimos de hardware

| Recurso | Mínimo | Recomendado |
| --- | --- | --- |
| RAM total | 8 GB | 16 GB |
| Disco livre | 50 GB | +300 GB (com nó BTC) |
| CPU | x86-64, VT-x/AMD-V | 4 núcleos por VM |
| VirtualBox | 7+ + Extension Pack | SSD (HDD é lento) |

> **AVISO — risco vs Tails:** o sistema **host** é superfície de ataque. Host comprometido pode monitorar VMs. Ideal: Linux dedicado só para Whonix.

O projeto Whonix oferece um instalador automático para Linux que baixa e configura VirtualBox + ambas as VMs com um único comando. Para Windows/macOS o fluxo é manual via OVA.

### Opção A — Linux: instalador automático (recomendado)

O instalador verifica virtualização aninhada, secure boot e instala VirtualBox + ambas as VMs.

```bash
# Host Linux (Debian/Ubuntu/Fedora)
# Baixar via Tor Browser: whonix.org/wiki/Linux
sha512sum dist-installer-cli
bash dist-installer-cli --install --ci
# Instala VirtualBox + Gateway + Workstation OVA
```

### Opção B — Windows/macOS: importar OVA manualmente

```bash
# 1. Instalar VirtualBox + Extension Pack (virtualbox.org)
# 2. Baixar Whonix .ova + .ova.asc (whonix.org)
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
gpg --verify Whonix-*.ova.asc Whonix-*.ova
# 3. VirtualBox → Arquivo → Importar appliance → .ova
```

> GPG obrigatório antes de importar. Saída esperada: assinatura de Patrick Schleizer.

### Primeira inicialização — Gateway SEMPRE primeiro

```bash
# 1. VirtualBox → Whonix-Gateway → Iniciar (~30–60 s)
#    Wizard: aceitar termos → Connect (ou Bridges se censura)
# 2. VirtualBox → Whonix-Workstation → Iniciar
# 3. Tor Browser → check.torproject.org
# Credenciais padrão (mudar imediatamente): user/changeme, root/changeme
```

### Primeira configuração: senhas + atualizações

Em **cada** VM (Gateway e Workstation):

```bash
passwd
sudo passwd root
sudo apt update && sudo apt full-upgrade -y
sudo reboot
```

Senhas únicas por VM. Updates vão via Tor automaticamente.

O Whonix tem persistência por design — os discos virtuais (.vdi) ficam no host. Para proteger esses dados em repouso (se alguém pegar o computador), é necessário cifrar os discos das VMs.

A criptografia do VirtualBox (AES-XTS256) protege os dados quando as VMs estão **desligadas**. Com as VMs rodando, os dados estão descriptografados em memória — proteger o host também é fundamental.

### Cifragem de discos das VMs

Extension Pack obrigatório para cifragem AES-XTS256:

```bash
# Baixar Extension Pack (mesma versão do VirtualBox)
sudo VBoxManage extpack install --replace \
  Oracle_VirtualBox_Extension_Pack-7.x.x.vbox-extpack
VBoxManage list extpacks
```

Com VMs **desligadas**: Configurações → Disco → Cifragem → AES-XTS256-PLAIN64. Senha **diferente** por VM. Anote no KeePassXC (metadados).

Via CLI (alternativa):

```bash
VBoxManage encryptmedium "/path/to/Whonix-Workstation.vdi" \
  --newpassword - --cipher AES-XTS256-PLAIN64 --newpasswordalign 1
```

### Cifragem do host (LUKS / BitLocker / FileVault)

Cifrar o host protege os `.vdi` em repouso se alguém copiar o disco.

```bash
# Linux: LUKS na instalação do SO (ou cryptsetup — destrutivo)
# Windows: BitLocker (Pro/Enterprise)
# macOS: FileVault
```

### Backup cifrado das VMs

```bash
# Linux: ~/VirtualBox VMs/Whonix-Gateway/ e Whonix-Workstation/
# Copiar para volume VeraCrypt em HD externo (mensal ou após mudanças)
```

### Ferramentas persistentes na Workstation

#### Electrum (pré-instalado)

```bash
electrum --version
# Versão mais recente: whonix.org/wiki/Electrum
EL_VER=4.x.x
EL_BASE="https://download.electrum.org/${EL_VER}"
scurl-download \
  "${EL_BASE}/electrum-${EL_VER}-x86_64.AppImage"
gpg --verify electrum-*.AppImage.asc electrum-*.AppImage
electrum --oneserver \
  --server seu-servidor.onion:50002:s \
  --proxy socks5:127.0.0.1:9111
```

#### Sparrow Wallet

```bash
SP_REPO="https://github.com/sparrowwallet/sparrow"
SP_BASE="${SP_REPO}/releases/latest/download"
scurl-download "${SP_BASE}/sparrow-*.tar.gz"
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys D4D0D3202FC06849A257B38DE94618334C674B40
gpg --verify sparrow-*.tar.gz.asc sparrow-*.tar.gz
tar -xf sparrow-*.tar.gz -C ~/apps/
chmod +x ~/apps/Sparrow/bin/Sparrow
# Preferências → Servidor → Electrum privado (.onion)
```

#### Feather Wallet (Cap. 10+)

```bash
scurl-download \
  "https://featherwallet.org/files/releases/linux/feather-*.AppImage"
gpg --keyserver hkps://keys.openpgp.org \
  --recv-keys 8185E158A33330C7FD61BC0D1F76E155CEFBA71C
gpg --verify feather-*.AppImage.asc feather-*.AppImage
chmod +x feather-*.AppImage
mv feather-*.AppImage ~/apps/feather.AppImage
```

#### eigenwallet (Cap. 10+)

```bash
EW_VER=4.11.3
EW_ORG="eigenwallet/core/releases/download"
EW_BASE="https://github.com/${EW_ORG}/${EW_VER}"
EW_FILE="eigenwallet_${EW_VER}_amd64"
scurl-download "${EW_BASE}/${EW_FILE}.AppImage"
gpg --import binarybaron.asc
gpg --verify ${EW_FILE}.AppImage.asc ${EW_FILE}.AppImage
chmod +x ${EW_FILE}.AppImage
# Estado: ~/.local/share/eigenwallet/
```

#### KeePassXC (pré-instalado)

Abra em Acessórios → KeePassXC. Crie `~/keepass/cripto.kdbx`. Guarde **metadados** (PINs, xpub, .onions) — **nunca** seed BIP39 (Lei 4).

### Rotina diária no Whonix

1. Gateway → Workstation (sempre nesta ordem)
2. Tor Browser → check.torproject.org
3. KeePassXC → Sparrow (Feather/eigenwallet só no N5+)

**Isolamento de stream** — portas dedicadas:

```bash
# 9050 geral | 9100 Tor Browser | 9111 Electrum | 9114 eigenwallet | 9115 Feather
electrum --proxy socks5:127.0.0.1:9111 \
  --server meu-electrumx.onion:50002:s --oneserver
```

**Encerramento seguro** (Workstation primeiro):

```bash
sudo shutdown now   # Workstation
sudo shutdown now   # Gateway
# Nunca forçar Power Off no VirtualBox
```

**Atualizações mensais:**

```bash
sudo apt update && sudo apt full-upgrade -y   # em cada VM
# AppImages: scurl-download + gpg --verify + testar antes de usar
```


> **Tails vs Whonix:** comparação resumida acima; tabela completa, matriz de decisão e estratégia híbrida na seção *Referência: Tails vs Whonix* (final deste capítulo).

## Referência: Arquitetura de Segurança do Whonix

| Componente | Papel |
| --- | --- |
| **Gateway** | Tor, firewall, isolamento por app, IP real nunca exposto |
| **Workstation** | Sparrow/Electrum, sem internet direta — só via Gateway |
| **Nó + EPS** (opcional) | Bitcoin Core + Electrum Personal Server via `.onion` |
| **HW air-gapped** | Assina PSBT via QR/SD — chaves nunca entram na VM |

| Ferramenta | Destaque |
| --- | --- |
| **Electrum** | Pré-instalado; use servidor `.onion` ou EPS próprio |
| **Sparrow** | Tor nativo, controle de UTXOs, multisig, PSBT |
| **Specter** | Interface multisig avançada para Bitcoin Core |
| **ElectrumX + Core** | Máxima privacidade (~100–300 GB disco) |

### Passos rápidos (resumo)

1. **Baixar e importar** OVA de whonix.org (Tor Browser) + `gpg --verify`
2. **Gateway primeiro**, depois Workstation
3. **Instalar carteira** na Workstation (`scurl-download` + PGP)
4. **Isolamento de stream** — circuito Tor dedicado por app
5. **Seed na HW wallet** — só xpub na VM (carteira somente leitura)
6. **Assinar PSBT** offline (QR/SD) e transmitir via Tor

> **Vantagem:** mesmo com malware na Workstation, o IP real do host não vaza.

> **AVISO:** Electrum com servidores públicos expõe endereços. Use EPS próprio ou `.onion` confiável.

> **AVISO:** Nunca gere seed BIP39 dentro da VM. Use dispositivo air-gapped.

> **AVISO:** Whonix protege rede/IP, não o grafo on-chain. CoinJoin (Cap. 9) ou Monero (Cap. 10).

> **AVISO:** Erros humanos (reuso de endereço, seed em texto claro) desfazem a proteção.

> **AVISO:** Host comprometido pode monitorar VMs. Qubes OS (Cap. 12) mitiga isso.

---

## Referência: Tails vs Whonix

Escolher entre Tails e Whonix define como você opera daqui em diante — coinjoins, swaps, monitoramento de carteira. Este capítulo ensina Whonix; a tabela abaixo ajuda a decidir **quando** usar cada ambiente.

### Tabela comparativa direta

| Critério | Tails | Whonix |
| --- | --- | --- |
| Persistência Whirlpool | Frágil (LUKS no USB) | Robusta (disco da VM) |
| Restauração após falha | Lenta (10–40 min) | Rápida (snapshot / `.vdi`) |
| Backup | Clonar USB manualmente | Copiar arquivo da VM |
| Rede / Tor | Tor forçado (fail-closed) | Gateway VM isolado |
| Isolamento de processos | AppArmor (moderado) | VM separada (alto) |
| Malware persistente | Alta (amnésico) | Média (mitigar com snapshots) |
| Uso diário | Boot lento; USB físico | VM pode ficar ligada semanas |
| Setup inicial | Média | Alta (duas VMs + rede) |
| RAM mínima | 2–4 GB | 8 GB (16 recomendado) |
| Coldcard via PSBT | Nativa (SD no host) | Passthrough ou pasta compartilhada |
| EPS / node próprio | Limitada | Integração ideal |
| Mixagem longa (24/7) | Uptime limitado | Possível com snapshots |
| Perda de fundos | Não (só perda de estado) | Não (estado backupeável) |
| Perfil ideal | Coinjoin esporádico | Operador frequente |

> Detalhes e nuance de cada linha estão nas seções **Tails** e **Whonix** abaixo.

---

### Análise qualitativa

### Tails: o cofre portátil que você abre só quando precisa

**Vantagens reais:**

* Não deixa rastro no hardware. Se você mora em país hostil a cripto, o Tails não deixa vestígio no disco do computador.
* O sistema inteiro é imutável. Um malware que infecte o Sparrow morre no reboot (a não ser que grave no Persistent Storage, o que é difícil).
* Portabilidade extrema: cabe num pendrive no bolso. Você pode mixar em qualquer laptop emprestado.
* Custo zero em infraestrutura: não precisa de hypervisor, nem de VM, nem de node dedicado.

**Desvantagens reais:**

* A persistência é uma gambiarra elegante, mas gambiarra. O Tails não foi projetado para manter estado de aplicações complexas como o Whirlpool.
* Cada sessão de mixagem longa é uma oração silenciosa para a energia não cair e o USB não pifar.
* Restaurar o estado do Whirlpool após perda do Persistent Storage é chato e demorado, embora seguro.
* Se você mixa com frequência (vários UTXOs, vários pools), o ciclo de boot → carregar carteira → iniciar Whirlpool → esperar rounds → desligar fica desgastante.

**Conclusão para Tails:**
Use Tails se você faz **coinjoins táticos** — uma vez por mês, prepara UTXOs para swaps futuros, não tem pressa. É o cofre que você vai buscar no banco quando precisa, não o cofre que fica aberto no quarto.

---

### Whonix: a fortaleza que fica de prontidão

**Vantagens reais:**

* A arquitetura de duas VMs é uma obra-prima: a Workstation **não tem IP real**, não conhece sua localização geográfica, não sabe seu endereço MAC. Mesmo que o Sparrow seja 0-day explorado, o atacante está preso numa VM sem rota para a internet — ele só vê o Gateway, que só fala Tor.
* Snapshots são um superpoder. Antes de cada round de Whirlpool, tire snapshot. Se algo corromper, volta em 30 segundos.
* Pode mixar 24/7. Deixa a VM rodando enquanto trabalha, dorme, viaja. O Whirlpool adora tempo de uptime — mais rounds, mais pares, anonset sobe mais rápido.
* Integração com node próprio (EPS) é natural e elegante. Você pode ter uma terceira VM só com Bitcoin Core + EPS, toda comunicação interna criptografada e via Tor.
* Backup é copiar arquivo. Sem ritual de clonagem de USB, sem `dd` nervoso.

**Desvantagens reais:**

* Complexidade de setup não é trivial. Instalar Whonix, configurar rede interna, pastas compartilhadas, USB passthrough — leva uma tarde inteira na primeira vez.
* Exige hardware parrudo. Com host Linux + Gateway VM + Workstation VM + (opcional) Node VM, 16 GB de RAM é o mínimo confortável.
* O host não é anônimo. Seu sistema operacional base (Windows, Linux, macOS) sabe que você está rodando Whonix. Em país opressor, isso pode ser um problema. O Tails não deixa rastro; o Whonix deixa a VM no seu disco.
* Malware que escape da VM para o host é cenário de ataque avançado (Ex.: escape do hipervisor), mas não impossível. No Tails, não há host para escapar — é o hardware direto.

**Conclusão para Whonix:**
Use Whonix se você é **operador frequente** — mantém node próprio, faz coinjoins semanais, swaps regulares, e quer a conveniência de um sistema sempre pronto, com backup fácil e resiliência contra falhas. É a fortaleza que fica de prontidão no terreno, não o cofre que você vai buscar.

---

### Matriz de decisão rápida

| Seu perfil | Escolha |
| --- | --- |
| Faço coinjoin 1x por mês, não tenho pressa, não quero hardware extra | **Tails** |
| Faço coinjoins toda semana, tenho node próprio, quero automação | **Whonix** |
| Risco de apreensão de equipamento | **Tails** (pendrive) |
| Tenho desktop com 16+ GB RAM e SSD sobrando | **Whonix** |
| Uso laptop emprestado ou de trabalho | **Tails** |
| Quero mixar 24/7 para anonset alto rápido | **Whonix** |
| Não quero aprender VirtualBox/KVM agora | **Tails** |
| Já sei VirtualBox e quero o melhor setup possível | **Whonix** |
| Preciso de portabilidade total (viajar, levar no bolso) | **Tails** |
| Quero integrar com EPS, node, eigenwallet tudo junto | **Whonix** |

---

### Estratégia híbrida recomendada

Com base no protocolo completo da trilha (Tails para swaps pontuais, Whonix para operações persistentes), você pode ter **os dois**, em funções separadas:

| Ambiente | Função |
| --- | --- |
| **Whonix persistente** | Whirlpool 24/7 + Sparrow + EPS |
| **Tails (sessões)** | Swaps eigenwallet/RetoSwap + Feather |

**Fluxo:**

1. No Whonix, você mixa BTC continuamente até ter outputs pós-coinjoin prontos.
2. Move os outputs limpos para uma carteira Postmix no Whonix.
3. Quando vai fazer um swap, **transfere só o necessário** do Whonix para um endereço da carteira no Tails.
4. No Tails, executa o swap (eigenwallet), recebe XMR no Feather.
5. O Whonix nunca toca em Monero; o Tails nunca guarda estado de longo prazo. Segregação de funções = segurança em camadas.

Isso resolve o dilema: Whonix para o trabalho pesado e persistente (coinjoin), Tails para a operação cirúrgica e descartável (swap).

---

No próximo capítulo, desapareceremos na multidão com CoinJoin e Whirlpool.
