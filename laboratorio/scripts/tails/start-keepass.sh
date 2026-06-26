#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Guardião Soberano contributors
#
# Inicia KeePassXC AppImage da partição persistente do Tails.
# Copie para: /home/amnesia/Persistent/start-keepass.sh
#
# Pré-requisito: KeePassXC-*.AppImage em /home/amnesia/Persistent/Apps/

set -euo pipefail

APPS_DIR="/home/amnesia/Persistent/Apps"
shopt -s nullglob
images=("${APPS_DIR}"/KeePassXC-*.AppImage)

if [ ${#images[@]} -eq 0 ]; then
  echo "ERRO: Nenhum KeePassXC-*.AppImage em ${APPS_DIR}" >&2
  echo "Baixe de https://github.com/keepassxreboot/keepassxc/releases" >&2
  exit 1
fi

exec "${images[0]}" "$@"
