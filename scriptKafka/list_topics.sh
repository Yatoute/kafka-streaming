#!/bin/bash

# ================================================
# Script pour lister tous les topics Kafka
# Utilisation : ./list_topics.sh
# ================================================

# Récupération dynamique du conteneur Kafka
KAFKA_CONTAINER=$(docker ps -qf "ancestor=wurstmeister/kafka:2.12-2.4.1")

# Vérification que le conteneur Kafka est bien lancé
if [ -z "$KAFKA_CONTAINER" ]; then
  echo "⚠️  Aucun conteneur Kafka trouvé. Le service est-il lancé ?"
  exit 1
fi

# Exécution de la commande pour lister les topics
docker exec -it "$KAFKA_CONTAINER" \
  kafka-topics.sh --list --bootstrap-server localhost:9092
