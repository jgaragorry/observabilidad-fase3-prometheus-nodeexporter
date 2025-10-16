#!/bin/bash
echo "🚀 Levantando servicios..."
docker-compose up -d
sleep 10
echo "🔍 Verificando estado..."
docker ps
echo "📊 Accede a Grafana en http://localhost:3000"
