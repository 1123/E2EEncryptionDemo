kafka-avro-console-consumer \
  --topic test-ssn \
  --consumer.config ../cloud.properties \
  --bootstrap-server ${BOOTSTRAP_SERVERS}\
  --property schema.registry.url=${SCHEMA_REGISTRY_URL} \
  --property basic.auth.credentials.source=USER_INFO \
  --property basic.auth.user.info=${KEY}:${SECRET} \
  --property rule.executors=encryptPII \
  --property rule.executors.encryptPII.class=io.confluent.kafka.schemaregistry.encryption.aws.AwsFieldEncryptionExecutor 

