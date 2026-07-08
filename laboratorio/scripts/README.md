# Scripts do laboratório

Scripts em **texto claro** (`.sh`) — auditáveis, sem binários de terceiros.

## Regras

1. Comentário em cada bloco explicando o que faz  
2. Caminhos explícitos para Tails (`/home/amnesia/Persistent/`) ou Whonix  
3. Testar após cada release de Tails/Whonix  
4. Prefixo **`gs-`** nos scripts Whonix deste repositório (autocontidos — não dependem de outros cursos VIPs-com)

## Scripts Whonix (host + Workstation)

| Arquivo | Ambiente | Status |
| --- | --- | --- |
| `whonix/gs-whonix-install-virtualbox.sh` | Host Debian amd64 | ✅ Suíte v3.5.4 (lab N3/01 Passo 1 · MOK/Secure Boot) |
| `whonix/gs-whonix-sign-virtualbox-modules.sh` | Host Debian amd64 | ✅ Assina + carrega vboxdrv (repetir a cada kernel novo) |
| `whonix/gs-whonix-verify-virtualbox-host.sh` | Host Debian amd64 | ✅ 9 checks read-only + QA log |
| `whonix/gs-whonix-import-ova.sh` | Host com VBoxManage | 🟡 Extraído (lab N3/01 Passos 2–4 · verify PGP embutido) |
| `whonix/gs-verificar-tor.sh` | Whonix Workstation | 🟡 Extraído (lab N3/01 Passo 5) |

## Scripts Tails

| Arquivo | Ambiente | Status |
| --- | --- | --- |
| `tails/start-keepass.sh` | Tails | 🟡 Extraído (lab 03) |
| `tails/start-sparrow.sh` | Tails | 🟡 Extraído (lab 01) |
| `tails/start-electrum.sh` | Tails | 🟡 Extraído (lab 04) |
| `tails/start-feather.sh` | Tails | 🟡 Extraído (lab N5) |
| `tails/start-retoswap.sh` | Tails | 🟡 Extraído (lab N5/03) |
| `tails/backup-persistencia.sh` | Tails | 🟡 Extraído |

Testar após cada release de Tails/Whonix — marcar 🟢 só com hardware real.
