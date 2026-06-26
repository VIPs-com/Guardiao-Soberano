#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Guardião Soberano contributors
#
# Inicia Sparrow com datadir na persistência do Tails.
# Copie para: /home/amnesia/Persistent/start-sparrow.sh
#
# Pré-requisito: sparrow-*/bin/Sparrow em /home/amnesia/Persistent/apps/sparrow/

set -euo pipefail

SPARROW_BIN="/home/amnesia/Persistent/apps/sparrow/bin/Sparrow"
DATA_DIR="/home/amnesia/Persistent/sparrow-data"

if [ ! -x "${SPARROW_BIN}" ]; then
  echo "ERRO: Sparrow não encontrado em ${SPARROW_BIN}" >&2
  echo "Extraia sparrow-*.tar.gz em /home/amnesia/Persistent/apps/sparrow/" >&2
  exit 1
fi

mkdir -p "${DATA_DIR}"
exec "${SPARROW_BIN}" -d "${DATA_DIR}" "$@"
