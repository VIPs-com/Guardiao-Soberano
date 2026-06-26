#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Guardião Soberano contributors
#
# Inicia RetoSwap (haveno-reto) com dados na persistência do Tails.
# Copie para: /home/amnesia/Persistent/start-retoswap.sh
#
# Pré-requisito: tarball extraído em /home/amnesia/Persistent/Apps/haveno-reto/
# Lab: laboratorio/nivel-5-trocador/03-retoswap-xmr-btc.md

set -euo pipefail

APPS_DIR="/home/amnesia/Persistent/Apps/haveno-reto"
DATA_DIR="/home/amnesia/Persistent/haveno-reto-data"

# Binário padrão do tarball Haveno/RetoSwap
BIN="${APPS_DIR}/bin/Haveno"

if [ ! -x "${BIN}" ]; then
  echo "ERRO: ${BIN} não encontrado ou não executável." >&2
  echo "Extraia o release de https://github.com/retoaccess1/haveno-reto/releases" >&2
  echo "  em ${APPS_DIR}/ (deve existir bin/Haveno)" >&2
  exit 1
fi

mkdir -p "${DATA_DIR}"
exec "${BIN}" --data-dir="${DATA_DIR}" "$@"
