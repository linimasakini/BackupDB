#!/bin/bash

#sumber konfigurasi
. config.sh



#buat dan masuk ke direktori backup
mkdir -p "$BACKUP_DIR"
cd "$BACKUP_DIR"

#dump database
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" | gzip > "$DB_NAME-$(date '+%Y-%m-%d_%H-%M-%S').gz"

#Hapus backup jika lebih dari yang diinginkan
TOTAL_BACKUP=$(ls -1 | grep "$DB_NAME-" | wc -l)
if [ $TOTAL_BACKUP -gt $MAX_BACKUP ]; then
 DELETE_NUM=$(expr $TOTAL_BACKUP - $MAX_BACKUP)
 ls -1t | grep "$DB_NAME-" | tail -$DELETE_NUM | xargs -I {} rm {}
fi

