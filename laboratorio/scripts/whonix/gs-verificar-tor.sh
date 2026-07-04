#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Guardião Soberano contributors
#
# gs-verificar-tor.sh — Guardião Soberano
#
# Rode DENTRO da Whonix-Workstation (após Gateway com Tor verde).
# Lab: laboratorio/nivel-3-observador/01-whonix-virtualbox-completo.md (Passo 5)
#
# Uso: ./gs-verificar-tor.sh [--skip-systemcheck]

set -euo pipefail

SKIP_SYSTEMCHECK=0

for arg in "$@"; do
    case "$arg" in
        --skip-systemcheck) SKIP_SYSTEMCHECK=1 ;;
        -h|--help)
            echo "Uso: $0 [--skip-systemcheck]"
            exit 0
            ;;
        *)
            echo "Opção desconhecida: $arg" >&2
            exit 1
            ;;
    esac
done

echo "=== Guardião Soberano — verificação Tor (Whonix Workstation) ==="

if [[ "$SKIP_SYSTEMCHECK" -eq 0 ]] && command -v systemcheck >/dev/null 2>&1; then
    echo ""
    echo "[1/2] systemcheck (interativo — leia a saída)..."
    systemcheck || {
        echo "AVISO: systemcheck retornou erro. Investigue antes de operar." >&2
        exit 1
    }
else
    echo "[1/2] systemcheck pulado (--skip-systemcheck ou comando ausente)."
fi

echo ""
echo "[2/2] check.torproject.org via SOCKS Tor local..."
if ! curl --silent --fail --socks5-hostname 127.0.0.1:9050 \
    https://check.torproject.org/api/ip 2>/dev/null | grep -qi '"IsTor":true'; then
    echo "Tentando página HTML..."
    if ! curl --silent --fail --socks5-hostname 127.0.0.1:9050 \
        https://check.torproject.org 2>/dev/null | grep -qi congratulations; then
        echo "ERRO: Tor não confirmado em check.torproject.org." >&2
        echo "Confirme: Gateway rodando, Tor verde, Workstation só após Gateway." >&2
        exit 1
    fi
fi

echo ""
echo "OK: Tor operacional na Workstation."
echo "Próximo: trocar senha changeme (passwd) e seguir o lab (KeePassXC, psbt_bridge)."
