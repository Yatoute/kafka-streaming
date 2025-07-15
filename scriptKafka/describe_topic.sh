#!/bin/bash

# ================================================
# Script pour décrire tous les topics Kafka
# Utilisation : ./describe_topic.sh
# ================================================

# Récupération dynamique du conteneur Kafka
KAFKA_CONTAINER=$(docker ps -qf "ancestor=wurstmeister/kafka:2.12-2.4.1")

# Vérification du conteneur
if [ -z "$KAFKA_CONTAINER" ]; then
  echo "⚠️  Aucun conteneur Kafka trouvé. As-tu lancé 'docker-compose up -d' ?"
  exit 1
fi

# Description de tous les topics
docker exec -it "$KAFKA_CONTAINER" kafka-topics.sh \
  --bootstrap-server localhost:9092 \
  --describe
