
-- BU AYARLAR kafka-connect-dev-01 ve kafka-connect-01 CONTAINERLARI TARAFINDAN KULLANILIYOR
-- bkz. https://debezium.io/documentation/reference/1.3/connectors/postgresql.html#postgresql-server-configuration
alter system set wal_level = 'logical';
alter system set max_wal_senders = 1;
alter system set max_replication_slots = 1;
-- SELECT name, setting FROM pg_settings WHERE name = 'wal_level';
-- SELECT name, setting FROM pg_settings WHERE name = 'max_wal_senders';
-- SELECT name, setting FROM pg_settings WHERE name = 'max_replication_slots';
