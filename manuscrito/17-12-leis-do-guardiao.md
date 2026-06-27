# Capítulo 17 — As 12 Leis do Guardião

> "A tecnologia protege contra atacantes externos. Ela não protege contra você mesmo"

---

## Objetivo

Estabelecer os princípios comportamentais que sustentam toda a arquitetura técnica. Se estas leis forem quebradas, nenhuma tecnologia salvará sua privacidade.

---

## As Leis da Seed e das Chaves

### Lei 1: A seed será gerada SEMPRE offline, em hardware dedicado

Nunca gere sua seed em um computador, celular ou máquina virtual conectada à internet. Use um dispositivo air-gapped (Coldcard, SeedSigner, Krux, Jade) ou, no mínimo, um computador permanentemente offline.

**Por que:** Software pode ser comprometido. RNG de computador pode ser previsível. O momento da geração é o momento mais vulnerável da sua vida financeira.

### Lei 2: O backup será em metal, em dois locais físicos diferentes

Nunca use papel como backup permanente. Nunca armazene a seed em apenas um local.

**Por que:** Papel queima, molha e rasga. Um único local está sujeito a incêndio, inundação, roubo. Dois locais geograficamente separados garantem que nenhum desastre destrua ambos.

### Lei 3: A recuperação será testada ANTES de enviar fundos

Após gravar a seed em metal, apague o dispositivo e restaure a carteira. Verifique se os endereços são idênticos.

**Por que:** Um erro de gravação (palavra errada, ordem trocada) só é descoberto quando você tenta restaurar. Descubra com R$ 0 em jogo, não com suas economias.

### Lei 4: A seed jamais será fotografada, digitalizada ou armazenada em nuvem

Nunca tire foto da seed. Nunca digite a seed em um computador conectado. Nunca salve em email, WhatsApp, Google Drive, iCloud, Evernote, ou qualquer serviço digital.

**Por que:** Tudo que é digital é copiável, hackeável e — em muitos países — passível de ser entregue mediante ordem judicial. O aço não responde a intimações.

---

## As Leis da Rede e da Identidade

### Lei 5: Toda operação cripto usará Tor — nunca clearnet

Use Tails ou Whonix para todas as operações. Nunca acesse sua carteira, faça swaps ou consulte a blockchain sem passar pela rede Tor.

**Por que:** Seu endereço IP revela sua localização geográfica, seu provedor de internet e potencialmente sua identidade. Tor protege a camada de rede.

### Lei 6: Nenhuma conta pessoal será acessada durante uma sessão cripto

Não faça login em Gmail, redes sociais, serviços bancários ou qualquer plataforma que vincule sua identidade ao IP da sessão.

**Por que:** Se você acessa sua carteira anônima e depois loga no seu email pessoal na mesma sessão Tor, o provedor do email sabe que aquele circuito Tor era seu. A identidade da carteira e a identidade civil colapsam em uma só.

### Lei 7: Nenhum endereço Bitcoin será reutilizado

Gere um novo endereço para cada transação que receber. O Sparrow faz isso automaticamente.

**Por que:** Reutilizar endereços permite que qualquer pessoa que lhe pagou veja seu saldo total e histórico completo de transações. É como dar seu extrato bancário a cada pessoa que lhe transfere dinheiro.

### Lei 8: Nenhum subendereço Monero será reutilizado entre swaps

Gere um novo subendereço XMR para cada swap. Anote no KeePassXC.

**Por que:** Embora o Monero proteja o valor e o remetente, a reutilização de subendereços entre swaps diferentes cria um ponto de correlação desnecessário.

---

## As Leis dos Swaps e da Privacidade

### Lei 9: Jamais se fará swap de volta imediatamente

Após um swap BTC→XMR, aguarde no MÍNIMO 24 horas antes de qualquer movimento do XMR. Ideal: 3 a 7 dias.

**Por que:** O ABCTracer demonstrou que a correlação temporal é o principal vetor de desanonimização cross-chain. O tempo dilui a correlação.

### Lei 10: Toda ferramenta será verificada via PGP antes da execução

Nunca execute um AppImage, instalador ou script sem verificar a assinatura PGP do desenvolvedor.

**Por que:** Um software falso pode roubar suas chaves, seus fundos ou seus metadados em segundos. A verificação PGP leva 30 segundos e previne perda total.

### Lei 11: Usar-se-á nó .onion próprio ou servidor confiável

Conecte seu Sparrow/Electrum ao seu EPS próprio (.onion) ou a um servidor .onion de confiança. Nunca use servidores Electrum públicos em clearnet.

**Por que:** Servidores públicos podem correlacionar todos os seus endereços, saldo e histórico de transações. Seu EPS próprio elimina esse risco.

### Lei 12: Começar-se-á SEMPRE com valor de teste mínimo

Antes de qualquer operação com valor significativo, faça um teste com o valor mínimo possível (0.00005 BTC para PSBT, 0.003 BTC para swap).

**Por que:** Um erro no fluxo — endereço errado, ferramenta com bug, passo pulado — custa centavos no teste. Com valores reais, pode custar tudo.

---

## A Lei Mestra

> **A tecnologia protege contra atacantes externos. Ela não protege contra você mesmo.**
>
> Um descuido momentâneo — fotografar a seed, reutilizar um endereço, fazer swap imediato, logar em conta pessoal na sessão errada — desfaz meses de configuração em segundos.
>
> A privacidade é um hábito, não uma configuração.
>
> O Guardião não é quem monta o sistema. É quem o opera com disciplina todos os dias.

---

## Resumo das 12 Leis

  \#   Categoria   Lei
  ---- ----------- -------------------------------------------
  1    Seed        Gerar offline em hardware dedicado
  2    Seed        Backup em metal, 2 locais
  3    Seed        Testar recuperação antes de enviar fundos
  4    Seed        Nunca digitalizar
  5    Rede        Sempre Tor
  6    Rede        Nunca logar conta pessoal na sessão
  7    Rede        Nunca reutilizar endereço BTC
  8    Rede        Nunca reutilizar subendereço XMR
  9    Swap        Nunca swap de volta imediato
  10   Swap        Verificar PGP de tudo
  11   Swap        Usar nó .onion próprio
  12   Swap        Começar com valor de teste

---

Com estas leis, encerramos a Parte III. Os apêndices a seguir fornecem referência rápida para consulta: glossário, servidores .onion, comandos essenciais e mais.
