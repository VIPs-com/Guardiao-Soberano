# Regra 3-2-1 — backup digital da fortaleza

> **Livro:** Capítulo 11 · referência 3-2-1 · Cap. 7 (Electrum backup)  
> **Último teste:** 2026-06-25 (conteúdo do manuscrito — revalidar em hardware)  
> **Software:** Tails persistência · GPG · tar · LUKS (HD externo)  

---

## Objetivo

Implementar a **regra 3-2-1** para dados digitais (não seeds): 3 cópias, 2 mídias, 1 off-site — com script auditável e teste de restauração.

```
Persistência Tails (original) → backup local LUKS → cópia off-site mensal
```

Script: [`../scripts/tails/backup-persistencia.sh`](../scripts/tails/backup-persistencia.sh)

---

## Pré-requisitos

- [ ] Tails com persistência e dados reais (Feather, Electrum, Sparrow, KeePassXC…)
- [ ] HD externo ou segundo pendrive com **LUKS**
- [ ] Frase-senha GPG anotada **fora** do pendrive

---

## A regra em uma tabela

| Regra | Na fortaleza |
| --- | --- |
| **3 cópias** | Persistência ativa + backup local + off-site |
| **2 mídias** | Flash (pendrive) + HD magnético/SSD |
| **1 off-site** | Cópia na casa de familiar ou cofre |

Seeds em **metal** são camada separada — este lab é VM, cofres `.kdbx`, dados Feather/Electrum.

---

## Passo 1 — Inventário do que backupar

Pastas típicas na persistência Tails:

| Caminho | Conteúdo |
| --- | --- |
| `feather-data/` | Carteira XMR |
| `electrum-data/` | Carteira BTC hot (Tails) |
| `sparrow-data/` | Sparrow watching-only |
| `haveno-reto-data/` | RetoSwap |
| `fortaleza_cofre.kdbx` | KeePassXC |

Whonix: snapshot de VM no VirtualBox (Cap. 11 passo 6.4) — complementar este lab.

---

## Passo 2 — Instalar o script

```bash
cp /caminho/do/repo/laboratorio/scripts/tails/backup-persistencia.sh \
   /home/amnesia/Persistent/
chmod +x /home/amnesia/Persistent/backup-persistencia.sh
```

Feche Feather, Electrum, RetoSwap e KeePassXC **antes** de rodar.

---

## Passo 3 — Backup semanal (cópia 2 — local)

```bash
sudo mkdir -p /media/backup
sudo mount /dev/sdX1 /media/backup   # volume LUKS
/home/amnesia/Persistent/backup-persistencia.sh /media/backup
```

O script gera: `fortaleza_backup_AAAAMMDD.tar.gz.gpg`

---

## Passo 4 — Off-site (cópia 3)

Mensalmente (ou após swap grande):

1. Copie o `.tar.gz.gpg` para HD externo **diferente**
2. Leve ao local off-site (familiar, cofre)
3. Registre data no KeePassXC

---

## Passo 5 — Teste de restauração

Em Tails **de teste** ou VM limpa:

```bash
gpg -d fortaleza_backup_AAAAMMDD.tar.gz.gpg | tar xzf - -C /tmp/restore-test
ls -la /tmp/restore-test
```

Confirme que arquivos críticos abrem (KeePassXC, configs).

> **Sem teste de restore, você não tem backup — tem esperança.**

---

## Rotina (Cap. 11)

| Frequência | Ação |
| --- | --- |
| Semanal | Script → backup local LUKS |
| Pré-operação crítica | Snapshot VM Whonix (`pre_swap_YYYY-MM-DD`) |
| Mensal | Off-site + verificar placas de aço |
| Semestral | Simulação desastre completa |

---

## Como confirmar que deu certo

- [ ] Arquivo `.gpg` criado e tamanho razoável (> 0)
- [ ] Restore de teste extrai pastas esperadas
- [ ] Frase-senha GPG **não** está no mesmo HD que o backup
- [ ] 3 cópias documentadas no diagrama pessoal (Cap. 11)

---

## Se der errado

| Erro | Ação |
| --- | --- |
| `nenhum dado para backup` | Verifique persistência ativada e paths |
| GPG esqueceu senha | Sem senha = sem restore — anote em local C |
| Livro | Cap. 11 · Apêndice F |
