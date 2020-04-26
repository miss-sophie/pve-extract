#!/bin/bash

if [ "${EXTRACT_FILE: -4}" == ".lzo" ]; then
	echo Extracting "$EXTRACT_FILE"
	lzop -d /backup/"$EXTRACT_FILE" -o "${EXTRACT_FILE::-4}"
	EXTRACT_FILE="${EXTRACT_FILE::-4}"
fi

vma extract /backup/"$EXTRACT_FILE" -v /backup/vmaextract_"$EXTRACT_FILE"

for filename in /backup/vmaextract_"$EXTRACT_FILE"/*.raw; do
	echo extracting "$filename"
	qemu-img convert -f raw -O qcow2 "$filename" "${filename::-4}".qcow2
done
