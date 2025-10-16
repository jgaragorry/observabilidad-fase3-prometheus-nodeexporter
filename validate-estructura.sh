#!/bin/bash

echo "🔍 Validando estructura y configuración del workshop Fase 3..."

# Lista de rutas requeridas
required_paths=(
  "docker-compose.yml"
  ".gitignore"
  "README.md"
  "README-GUIA.md"
  "prometheus/prometheus.yml"
  "grafana/provisioning/datasources/datasources.yml"
  "grafana/provisioning/dashboards/dashboards.yml"
  "grafana/dashboards/fase3/sistema-basico.json"
  "grafana/dashboards/fase3/sistema-avanzado.json"
  "scripts/reset.sh"
  "scripts/setup.sh"
  "docs/arquitectura.md"
  "docs/troubleshooting.md"
  "docs/preguntas-frecuentes.md"
  "assets/capturas/flujo-prometheus-nodeexporter-grafana.png"
)

missing=0
empty=0
invalid_yaml=0
invalid_json=0
non_executable=0

for path in "${required_paths[@]}"; do
  if [ ! -e "$path" ]; then
    echo "❌ Falta: $path"
    ((missing++))
  else
    if [ ! -s "$path" ]; then
      echo "⚠️ Vacío: $path"
      ((empty++))
    else
      echo "✅ OK: $path"
    fi

    # Validar YAML
    if [[ "$path" == *.yml ]]; then
      yamllint -d relaxed "$path" > /dev/null 2>&1
      if [ $? -ne 0 ]; then
        echo "❌ YAML inválido: $path"
        ((invalid_yaml++))
      fi
    fi

    # Validar JSON
    if [[ "$path" == *.json ]]; then
      jq empty "$path" > /dev/null 2>&1
      if [ $? -ne 0 ]; then
        echo "❌ JSON inválido: $path"
        ((invalid_json++))
      fi
    fi

    # Validar permisos de ejecución en scripts
    if [[ "$path" == *.sh ]]; then
      if [ ! -x "$path" ]; then
        echo "⚠️ Script sin permisos de ejecución: $path"
        ((non_executable++))
      fi
    fi
  fi
done

echo "--------------------------------------"
echo "📦 Resultado final:"
echo "Archivos faltantes: $missing"
echo "Archivos vacíos: $empty"
echo "YAML inválidos: $invalid_yaml"
echo "JSON inválidos: $invalid_json"
echo "Scripts sin permisos: $non_executable"

if [ $missing -eq 0 ] && [ $empty -eq 0 ] && [ $invalid_yaml -eq 0 ] && [ $invalid_json -eq 0 ]; then
  echo "🎉 Todo está listo para reproducir el workshop."
else
  echo "🛠️ Revisa los puntos anteriores antes de ejecutar."
fi

