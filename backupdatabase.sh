#kode untuk terminal bash
#!/bin/bash

#konfigurasi database
DB_USER="usernameDB"
DB_PASS="passwordDB"
DB_NAME="namaDB"

#konfigurasi backup
BACKUP_DIR="direktori letak backup"
MAX_BACKUP="banyaknya backup yang diinginkan"
BACKUPNAME="$DB_NAME-$(date '+%Y-%m-%d_%H-%M-%S')".gz

#membuat backup
mkdir -p $BACKUP_DIR && cd $BACKUP_DIR
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME | gzip > $BACKUP_NAME

#Hapus backup jika sudah lebih dari yang ditentukan
TOTAL_BACKUP=$(ls -1 | grep "$DB_NAME-" | wc -l)
if [ $TOTAL_BACKUP -gt $MAX_BACKUP ]; then
    DELETE_NUM=$(expr $TOTAL_BACKUP - $MAX_BACKUP)
    ls -1t | grep "$DB_NAME-" | tail -$DELETE_NUM | xargs -I {} rm {}
fi