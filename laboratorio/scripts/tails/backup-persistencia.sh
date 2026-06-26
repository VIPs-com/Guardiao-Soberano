#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Guardião Soberano contributors
#
# Backup criptografado da persistência Tails (regra 3-2-1).
# Copie para: /home/amnesia/Persistent/backup-persistencia.sh
#
# Uso:
#   sudo mkdir -p /media/backup && sudo mount /dev/sdX1 /media/backup
#   ./backup-persistencia.sh /media/backup
#
# Pré-requisito: feche Feather, Electrum, RetoSwap e KeePassXC antes de rodar.

set -euo pipefail

DEST_DIR="${1:-/media/backup}"
STAMP="$(date +%Y%m%d)"
OUT="${DEST_DIR}/fortaleza_backup_${STAMP}.tar.gz.gpg"
PERSIST="/home/amnesia/Persistent"

if [ ! -d "${DEST_DIR}" ] || [ ! -w "${DEST_DIR}" ]; then
  echo "ERRO: destino inexistente ou sem permissão de escrita: ${DEST_DIR}" >&2
  echo "Monte um volume LUKS e passe o caminho: $0 /media/backup" >&2
  exit 1
fi

# Pastas/arquivos a incluir (somente se existirem)
INCLUDE=()
for path in \
  "${PERSIST}/feather-data" \
  "${PERSIST}/electrum-data" \
  "${PERSIST}/sparrow-data" \
  "${PERSIST}/haveno-reto-data" \
  "${PERSIST}/fortaleza_cofre.kdbx" \
  "${PERSIST}/haveno_backup_amnesia.zip" \
  "${PERSIST}/haveno-reto-data/account_backup.zip"
do
  if [ -e "${path}" ]; then
    INCLUDE+=("${path}")
  fi
done

if [ ${#INCLUDE[@]} -eq 0 ]; then
  echo "AVISO: nenhum dado em ${PERSIST} para backup." >&2
  exit 1
fi

echo "Itens incluídos:"
printf '  - %s\n' "${INCLUDE[@]}"
echo ""
echo "Será pedida uma frase-senha GPG (anote fora do pendrive)."
echo "Destino: ${OUT}"
echo ""

tar czf - "${INCLUDE[@]}" \
  | gpg --symmetric --cipher-algo AES256 --output "${OUT}"

echo "Backup concluído: ${OUT}"
echo "Teste restauração em ambiente de teste antes de confiar neste arquivo."
