#!/bin/bash
echo "🧹 Reiniciando entorno..."
docker-compose down -v
docker network prune -f
echo "✅ Entorno limpio."
