#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Guardião Soberano contributors
#
# Inicia Electrum AppImage com datadir na persistência do Tails.
# Copie para: /home/amnesia/Persistent/start-electrum.sh
#
# Pré-requisito: electrum-*-x86_64.AppImage em /home/amnesia/Persistent/Apps/

set -euo pipefail

APPS_DIR="/home/amnesia/Persistent/Apps"
DATA_DIR="/home/amnesia/Persistent/electrum-data"

shopt -s nullglob
images=("${APPS_DIR}"/electrum-*-x86_64.AppImage)

if [ ${#images[@]} -eq 0 ]; then
  echo "ERRO: Nenhum electrum-*-x86_64.AppImage em ${APPS_DIR}" >&2
  echo "Baixe de https://download.electrum.org/" >&2
  exit 1
fi

mkdir -p "${DATA_DIR}"
exec "${images[0]}" --datadir "${DATA_DIR}" "$@"
