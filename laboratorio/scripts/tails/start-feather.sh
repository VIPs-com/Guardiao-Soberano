#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Guardião Soberano contributors
#
# Inicia Feather AppImage com datadir na persistência do Tails.
# Copie para: /home/amnesia/Persistent/start-feather.sh
#
# Pré-requisito: feather-*-x86_64.AppImage em /home/amnesia/Persistent/Apps/
# Lab: laboratorio/nivel-5-trocador/02-feather-tails-instalacao.md

set -euo pipefail

APPS_DIR="/home/amnesia/Persistent/Apps"
DATA_DIR="/home/amnesia/Persistent/feather-data"

shopt -s nullglob
images=("${APPS_DIR}"/feather-*-x86_64.AppImage)

if [ ${#images[@]} -eq 0 ]; then
  echo "ERRO: Nenhum feather-*-x86_64.AppImage em ${APPS_DIR}" >&2
  echo "Baixe de https://featherwallet.org/download/" >&2
  exit 1
fi

mkdir -p "${DATA_DIR}"
exec "${images[0]}" --datadir "${DATA_DIR}" --use-tor "$@"
