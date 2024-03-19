#!/bin/bash

# TODO bu script proof-of-concept olarak yazıldı. Detayl hata denetimi yok.
# Aynı işi düzgün hata denetimiyle yapan bir nodejs scripti yazabiliriz. shell'de http status/response işlemek biraz zor.

echo -e "\n==========> ⏳ Connector'ları oluşturmadan önce Kafka Connect Cluster'ının hazır olmasını bekliyoruz...\n"

while [[ ! $(curl -sH "Accept:application/json" localhost:8083) =~ ^\{\"version\":\"2.[0-9].[0-9]+\" || $(curl -o /dev/null -s -w "%{http_code}\n" localhost:8083) -ne 200 ]]
do
  echo -e $(date): "Cluster Durumu: " $(curl -sH "Accept:application/json" localhost:8083)
  sleep 10
done

echo -e $(date): "Cluster Durumu: " $(curl -sH "Accept:application/json" localhost:8083)

sleep 10

echo -e "\n==========> Connector oluşturuluyor\n"

curl -i -H "Accept:application/json" -H "Content-Type:application/json" -d @./kafka-connect-config-STE.json localhost:8083/connectors

echo -e "\n\n==========> Mevcut connectorlar\n"

curl -s  localhost:8083/connectors | json_pp

echo -e "\n==========> Mevcut simulator connector taskları\n"

curl -s  localhost:8083/connectors/simulator-connector | json_pp

echo -e "\n===============================\n"

echo -e "\n==========> Connector oluşturuluyor\n"

curl -i -H "Accept:application/json" -H "Content-Type:application/json" -d @./kafka-connect-config-EYBS_DEV.json localhost:8083/connectors

echo -e "\n\n==========> Mevcut connectorlar\n"

curl -s  localhost:8083/connectors | json_pp

echo -e "\n==========> Mevcut analysis calculation connector taskları\n"

curl -s  localhost:8083/connectors/analysis-calculation-connector | json_pp

echo -e "\n===============================\n"

exit 0

########### kafka-connect-config.json'da yapılan bazı ayarların açıklamaları (json dosyasına comment yazılamadığı için buraya yazdım) ###################

# https://debezium.io/documentation/reference/1.3/connectors/postgresql.html#postgresql-property-message-key-columns
# "message.key.columns": "public.content_grade:id",

# https://debezium.io/documentation/reference/1.3/connectors/postgresql.html#postgresql-snapshots
# "snapshot.mode": "exported",

# https://stackoverflow.com/q/60710947/1209097
# "heartbeat.interval.ms": "1000",

# https://debezium.io/documentation/reference/1.3/configuration/event-flattening.html
# "transforms": "unwrap,ExtractField",
# "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
# "transforms.ExtractField.type": "org.apache.kafka.connect.transforms.ExtractField$Key",
# "transforms.ExtractField.field": "id",

# "unknown field: id" hatalarını engellemek için predicate'i workaround olarak kullanıyoruz
# https://issues.redhat.com/browse/DBZ-1909
# https://issues.apache.org/jira/browse/KAFKA-9673
# https://stackoverflow.com/questions/64562076/how-to-apply-an-smt-to-a-single-topic-in-kafka-connect
# https://issues.apache.org/jira/browse/KAFKA-7052
# https://gitter.im/debezium/user?at=5e7cce6a9091af6d001ad36c
# "transforms.ExtractField.predicate": "UnknownFieldHatalariIcinPredicate",
# "predicates": "UnknownFieldHatalariIcinPredicate",
# "predicates.UnknownFieldHatalariIcinPredicate.type": "org.apache.kafka.connect.transforms.predicates.TopicNameMatches",
# "predicates.UnknownFieldHatalariIcinPredicate.pattern": ".*content_grade"

################################################################################################################################################################
