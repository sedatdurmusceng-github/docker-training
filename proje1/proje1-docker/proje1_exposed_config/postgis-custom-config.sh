#!/bin/bash
set -e

echo "====> Adding custom configuration... "

#psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
#	alter system set wal_level = 'logical';
#	alter system set max_wal_senders = 1;
#	alter system set max_replication_slots = 1;
#	SELECT * FROM pg_settings WHERE name = 'wal_level';
#	SELECT * FROM pg_settings WHERE name = 'max_wal_senders';
#	SELECT * FROM pg_settings WHERE name = 'max_replication_slots';
#EOSQL

# cat /var/lib/postgresql/data/pg_hba.conf

echo "Veritabanı container'ı çalıştırıldığında container üzerinde ayar yapmak gerekirse buraya yazılabilir"

echo "====> Adding custom configuration... "
