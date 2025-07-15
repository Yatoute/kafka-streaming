#!/bin/bash

# ================================================
# Script pour démarrer un consommateur Kafka
# Utilisation : ./consumer.sh <nom_du_topic>
# ================================================

# Vérification de l'argument
if [ -z "$1" ]; then
  echo "❌ Usage : ./consumer.sh <nom_du_topic>"
  exit 1
fi

TOPIC_NAME=$1

# Récupération dynamique de l'ID du conteneur Kafka
KAFKA_CONTAINER=$(docker ps -qf "ancestor=wurstmeister/kafka:2.12-2.4.1")

# Vérification que le conteneur est bien lancé
if [ -z "$KAFKA_CONTAINER" ]; then
  echo "⚠️  Aucun conteneur Kafka trouvé. As-tu lancé 'docker-compose up -d' ?"
  exit 1
fi

# Lancement du consommateur Kafka avec affichage clé + valeur
docker exec -it "$KAFKA_CONTAINER" kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic "$TOPIC_NAME" \
  --from-beginning \
  --formatter kafka.tools.DefaultMessageFormatter \
  --property print.key=true \
  --property print.value=true \
  --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
  --property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer
