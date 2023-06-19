kafka-avro-console-producer \
  --topic test-ssn  \
  --broker-list ${BOOTSTRAP_SERVERS} \
  --producer.config ../cloud.properties \
  --property schema.registry.url=${SCHEMA_REGISTRY_URL} \
  --property basic.auth.credentials.source=USER_INFO \
  --property basic.auth.user.info=${KEY}:${SECRET} \
  --property value.schema='{"type":"record","name":"myrecord",
     "fields":[
       {"name":"name","type":"string"},
       {"name":"ssn","type":"string","confluent:tags":["PII"]}
     ]}' \
  --property value.rule.set='{ "domainRules": [ { 
     "name": "encryptPII", 
     "type": "ENCRYPT", 
     "tags":["PII"], 
     "params":{"encrypt.kms.key.id": "'${AWS_KMS_KEY_ARN}'"},
     "onFailure": "NONE,NONE"}]}' \
  --property rule.executors=aws \
  --property rule.executors.aws.class=io.confluent.kafka.schemaregistry.encryption.aws.AwsFieldEncryptionExecutor

