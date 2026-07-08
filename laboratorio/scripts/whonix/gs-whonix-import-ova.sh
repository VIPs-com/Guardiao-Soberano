#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Guardião Soberano contributors
#
# gs-whonix-import-ova.sh — Guardião Soberano
#
# Lab: laboratorio/nivel-3-observador/01-whonix-virtualbox-completo.md (Passos 2–4)
# Importa a chave de assinatura, VERIFICA o fingerprint contra o valor informado
# (sempre da página oficial https://www.whonix.org/wiki/Verify_the_images),
# verifica a assinatura do .ova e importa no VirtualBox.
#
# NÃO automatiza: Anon Connection Wizard, systemcheck, apt upgrade nas VMs.
#
# Uso:
#   sudo ./gs-whonix-import-ova.sh \
#        -i /caminho/Whonix-LXQt-18.1.4.2.Intel_AMD64.ova \
#        -s /caminho/Whonix-LXQt-18.1.4.2.Intel_AMD64.ova.asc \
#        [-k /caminho/derivative.asc] \
#        -f "FINGERPRINT_DA_PAGINA_OFICIAL" \
#        [-b] [-t lxqt|cli] [-y]
#
# Sem -k: baixa derivative.asc de whonix.org (3 tentativas).
# Log: /var/log/whonix-install.log (ou ./whonix-install.log sem root)
#
# Changelog jul/2026 (port Privacy-OS-Hub v1.0.9.1):
#   - log() em stderr
#   - fetch retry derivative.asc
#   - VALIDSIG+FPR (fail-closed; não depende de "Good signature"/locale)
#   - EXPKEYSIG tratado

set -euo pipefail

OVA_FILE=""
SIG_FILE=""
KEY_FILE=""
VARIANT=""
EXPECTED_FPR=""
BOOT_VMS=0
ASSUME_YES=0
LOG_FILE="/var/log/whonix-install.log"
GNUPGHOME_DIR=""
DERIVATIVE_URL="https://www.whonix.org/keys/derivative.asc"
DOWNLOADED_KEY=0

# stderr: não poluir stdout em capturas $(...)
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE" >&2
}

fetch_url() {
    local url="$1" dest="$2" tries="${3:-3}"
    local n
    for ((n=1; n<=tries; n++)); do
        if curl -fsSL --max-time 120 -o "$dest" "$url" && [[ -s "$dest" ]]; then
            return 0
        fi
        log "AVISO: download falhou (tentativa ${n}/${tries}): $url"
        sleep 5
    done
    return 1
}

fail() {
    log "ERRO: $*"
    cleanup
    exit 1
}

cleanup() {
    if [[ -n "$GNUPGHOME_DIR" && -d "$GNUPGHOME_DIR" ]]; then
        rm -rf "$GNUPGHOME_DIR"
    fi
    if [[ "$DOWNLOADED_KEY" -eq 1 && -n "$KEY_FILE" && -f "$KEY_FILE" ]]; then
        rm -f "$KEY_FILE"
    fi
}
trap cleanup EXIT

usage() {
    grep '^#' "$0" | sed -e 's/^# \?//' -e '/^SPDX\|^Copyright/d' -e '1,/^$/d' | head -n 30
    exit 1
}

confirm() {
    if [[ "$ASSUME_YES" -eq 1 ]]; then
        return 0
    fi
    read -r -p "$1 [s/N] " resp
    [[ "$resp" =~ ^[sSyY]$ ]]
}

require_vboxmanage() {
    command -v VBoxManage >/dev/null 2>&1 \
        || fail "VBoxManage não encontrado. Rode gs-whonix-install-virtualbox.sh ou instale o VirtualBox primeiro."
}

validate_inputs() {
    [[ -n "$OVA_FILE"      ]] || fail "Informe o arquivo .ova com -i."
    [[ -n "$SIG_FILE"      ]] || fail "Informe o arquivo de assinatura (.asc/.sig) com -s."
    [[ -n "$EXPECTED_FPR"  ]] || fail "Informe o fingerprint com -f (de https://www.whonix.org/wiki/Verify_the_images)."

    [[ -f "$OVA_FILE" ]] || fail "Arquivo .ova não encontrado: $OVA_FILE"
    [[ -f "$SIG_FILE" ]] || fail "Arquivo de assinatura não encontrado: $SIG_FILE"

    if [[ -z "$KEY_FILE" ]]; then
        KEY_FILE="$(mktemp)"
        DOWNLOADED_KEY=1
        fetch_url "$DERIVATIVE_URL" "$KEY_FILE" || fail "Falha ao baixar derivative.asc após 3 tentativas"
    fi
    [[ -f "$KEY_FILE" ]] || fail "Arquivo de chave não encontrado: $KEY_FILE"
}

detect_or_validate_variant() {
    local basename_ova detected=""
    basename_ova="$(basename "$OVA_FILE")"

    if echo "$basename_ova" | grep -qi "lxqt"; then
        detected="lxqt"
    elif echo "$basename_ova" | grep -qi "cli"; then
        detected="cli"
    elif echo "$basename_ova" | grep -qi "xfce"; then
        log "AVISO: variante Xfce descontinuada. Use LXQt — confira https://www.whonix.org/wiki/VirtualBox"
    fi

    if [[ -n "$VARIANT" ]]; then
        VARIANT="$(echo "$VARIANT" | tr '[:upper:]' '[:lower:]')"
        if [[ "$VARIANT" != "lxqt" && "$VARIANT" != "cli" ]]; then
            fail "Valor inválido para -t: '$VARIANT' (use lxqt ou cli)."
        fi
        if [[ -n "$detected" && "$detected" != "$VARIANT" ]]; then
            log "AVISO: -t='$VARIANT' mas o nome do arquivo sugere '$detected'."
        else
            log "Variante '$VARIANT' confirmada."
        fi
    elif [[ -n "$detected" ]]; then
        VARIANT="$detected"
        log "Variante detectada: $VARIANT"
    else
        log "AVISO: variante não detectada pelo nome do arquivo."
    fi
}

import_key() {
    log "[Passo 2/5] Importando chave em keyring temporário..."
    GNUPGHOME_DIR="$(mktemp -d)"
    chmod 700 "$GNUPGHOME_DIR"
    export GNUPGHOME="$GNUPGHOME_DIR"

    gpg --quiet --import "$KEY_FILE" 2>&1 | tee -a "$LOG_FILE" >&2
}

verify_fingerprint() {
    log "[Passo 2/5] Verificando fingerprint..."
    local normalized_expected normalized_actual fpr_list matched=0

    normalized_expected="$(echo "$EXPECTED_FPR" | tr -d ' ' | tr '[:lower:]' '[:upper:]')"
    fpr_list="$(gpg --with-colons --fingerprint 2>/dev/null | awk -F: '/^fpr:/ {print $10}')"

    while read -r fpr; do
        normalized_actual="$(echo "$fpr" | tr -d ' ' | tr '[:lower:]' '[:upper:]')"
        if [[ "$normalized_actual" == "$normalized_expected" ]]; then
            matched=1
            break
        fi
    done <<< "$fpr_list"

    if [[ "$matched" -ne 1 ]]; then
        fail "Fingerprint NÃO confere. Confirme em https://www.whonix.org/wiki/Verify_the_images"
    fi

    log "Fingerprint confirmado."
}

# Fail-closed: VALIDSIG + fingerprint (imune a locale PT-BR "Assinatura válida")
verify_signature() {
    log "[Passo 3/5] Verificando assinatura do .ova (OBRIGATÓRIO)..."
    local fpr_norm gpg_log
    fpr_norm="$(echo "$EXPECTED_FPR" | tr -d ' ' | tr '[:lower:]' '[:upper:]')"
    gpg_log="$(mktemp)"
    gpg --status-fd 1 --verify-options show-notations --verify "$SIG_FILE" "$OVA_FILE" \
        >"$gpg_log" 2>&1 || true

    if grep -q "^\[GNUPG:\] VALIDSIG .*${fpr_norm}" "$gpg_log"; then
        log "Assinatura verificada (VALIDSIG + fingerprint esperado)."
        cat "$gpg_log" | tee -a "$LOG_FILE" >&2
        rm -f "$gpg_log"
        return 0
    fi
    if grep -qi "EXPKEYSIG" "$gpg_log"; then
        cat "$gpg_log" | tee -a "$LOG_FILE" >&2
        rm -f "$gpg_log"
        fail "EXPKEYSIG — chave expirada. Reimporte derivative.asc de whonix.org e confira fingerprint em Verify_the_images."
    fi
    cat "$gpg_log" | tee -a "$LOG_FILE" >&2
    rm -f "$gpg_log"
    fail "Assinatura INVÁLIDA. NÃO importe este arquivo. Apague e baixe novamente."
}

import_ova() {
    log "[Passo 4/5] Importando appliance no VirtualBox..."
    VBoxManage import "$OVA_FILE" | tee -a "$LOG_FILE" >&2

    local vms
    vms="$(VBoxManage list vms)"
    echo "$vms" | tee -a "$LOG_FILE" >&2

    echo "$vms" | grep -qi "Whonix-Gateway" || log "AVISO: Whonix-Gateway não encontrada."
    echo "$vms" | grep -qi "Whonix-Workstation" || log "AVISO: Whonix-Workstation não encontrada."
}

boot_vms() {
    log "[Passo 5/5] Iniciando Whonix-Gateway (headless)..."
    VBoxManage startvm "Whonix-Gateway" --type headless \
        || log "AVISO: falha ao iniciar Gateway — use a GUI."

    log "Aguardando 20s..."
    sleep 20

    log "Iniciando Whonix-Workstation (GUI)..."
    VBoxManage startvm "Whonix-Workstation" --type gui \
        || log "AVISO: falha ao iniciar Workstation — use a GUI."
}

print_manual_steps() {
    cat <<'EOF'

===================================================================
PRÓXIMOS PASSOS — MANUAL DENTRO DAS VMs (lab N3/01):

  [Gateway] Anon Connection Wizard → Tor conectado
  [Workstation] systemcheck + gs-verificar-tor.sh (ou curl check.torproject.org)
  [Ambas] passwd (trocar changeme) + sudo apt update && sudo apt full-upgrade
===================================================================
EOF
}

while getopts ":i:s:k:f:t:byh" opt; do
    case "$opt" in
        i) OVA_FILE="$OPTARG" ;;
        s) SIG_FILE="$OPTARG" ;;
        k) KEY_FILE="$OPTARG" ;;
        f) EXPECTED_FPR="$OPTARG" ;;
        t) VARIANT="$OPTARG" ;;
        b) BOOT_VMS=1 ;;
        y) ASSUME_YES=1 ;;
        h) usage ;;
        *) usage ;;
    esac
done

touch "$LOG_FILE" 2>/dev/null || LOG_FILE="./whonix-install.log"
log "===== gs-whonix-import-ova ====="

require_vboxmanage
validate_inputs
detect_or_validate_variant

if ! confirm "Importar '${OVA_FILE}' após verificação?"; then
    log "Cancelado."
    exit 0
fi

import_key
verify_fingerprint
verify_signature
import_ova

if [[ "$BOOT_VMS" -eq 1 ]]; then
    boot_vms
fi

print_manual_steps
log "===== gs-whonix-import-ova concluído (verificação manual pendente) ====="
