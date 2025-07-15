#!/bin/bash

# ================================================
# Script pour lancer un producteur Kafka console
# Utilisation : ./producer.sh <nom_du_topic>
# ================================================

# Vérification de l'argument
if [ -z "$1" ]; then
  echo "❌ Usage : ./producer.sh <nom_du_topic>"
  exit 1
fi

TOPIC_NAME=$1

# Récupération dynamique de l'ID du conteneur Kafka
KAFKA_CONTAINER=$(docker ps -qf "ancestor=wurstmeister/kafka:2.12-2.4.1")

# Vérification du conteneur Kafka
if [ -z "$KAFKA_CONTAINER" ]; then
  echo "⚠️  Aucun conteneur Kafka trouvé. As-tu lancé 'docker-compose up -d' ?"
  exit 1
fi

# Lancement du producteur console
docker exec -it "$KAFKA_CONTAINER" kafka-console-producer.sh \
  --broker-list localhost:9092 \
  --topic "$TOPIC_NAME"
