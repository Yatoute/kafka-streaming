#!/bin/bash

# ================================================
# Script pour créer un topic Kafka
# Utilisation : ./create_topic.sh <nom_du_topic>
# ================================================

# Vérification de l'argument
if [ -z "$1" ]; then
  echo "❌ Usage : ./create_topic.sh <nom_du_topic>"
  exit 1
fi

TOPIC_NAME=$1

# Récupération dynamique du conteneur Kafka
KAFKA_CONTAINER=$(docker ps -qf "ancestor=wurstmeister/kafka:2.12-2.4.1")

# Vérification du conteneur
if [ -z "$KAFKA_CONTAINER" ]; then
  echo "⚠️  Aucun conteneur Kafka trouvé. Lance 'docker-compose up -d' d'abord."
  exit 1
fi

# Création du topic
docker exec -it "$KAFKA_CONTAINER" kafka-topics.sh --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 3 \
  --topic "$TOPIC_NAME"
