## 📘 README-GUIA.md

Explica cada archivo, flujo de lectura, `.gitignore`, PromQL, y ejercicios didácticos. Incluye:

- Flujo de lectura: `docker-compose.yml → prometheus.yml → datasources.yml → dashboards.yml → dashboards.json`
- Guía PromQL paso a paso
- Ejercicios para alumnos
- Troubleshooting y preguntas frecuentes

---

## 🔧 Archivos de configuración

### `docker-compose.yml`

```yaml
version: '3.8'
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"
    networks:
      - observabilidad

  node-exporter:
    image: prom/node-exporter:latest
    container_name: node-exporter
    ports:
      - "9100:9100"
    networks:
      - observabilidad

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "3000:3000"
    volumes:
      - ./grafana/provisioning:/etc/grafana/provisioning
      - ./grafana/dashboards:/var/lib/grafana/dashboards
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=admin
    networks:
      - observabilidad

networks:
  observabilidad:
    driver: bridge
```

---

### `prometheus/prometheus.yml`

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'node'
    static_configs:
      - targets: ['node-exporter:9100']
```

---

### `grafana/provisioning/datasources/datasources.yml`

```yaml
apiVersion: 1
datasources:
  - name: Prometheus
    uid: prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
```

---

### `grafana/provisioning/dashboards/dashboards.yml`

```yaml
apiVersion: 1
providers:
  - name: 'fase3'
    orgId: 1
    folder: 'Fase 3'
    type: file
    disableDeletion: false
    editable: true
    options:
      path: /var/lib/grafana/dashboards/fase3
```

---

## 📊 Dashboards `.json`

- `grafana/dashboards/fase3/sistema-basico.json`  
  Paneles: CPU, RAM, Disco, Red

- `grafana/dashboards/fase3/sistema-avanzado.json`  
  Paneles: Swap, Load, TCP, Procesos, Entropía, Uptime

✅ Exportar desde Grafana GUI → Settings → JSON Model → Guardar

---

## 🧪 Scripts

### `scripts/reset.sh`

```bash
#!/bin/bash
echo "🧹 Reiniciando entorno..."
docker-compose down -v
docker network prune -f
echo "✅ Entorno limpio."
```

### `scripts/setup.sh`

```bash
#!/bin/bash
echo "🚀 Levantando servicios..."
docker-compose up -d
sleep 10
echo "🔍 Verificando estado..."
docker ps
echo "📊 Accede a Grafana en http://localhost:3000"
```

---

## 📁 `.gitignore`

```gitignore
# Logs y temporales
*.log
/tmp/
grafana/data/
prometheus/data/

# Dashboards y provisioning (excepciones explícitas)
!grafana/dashboards/**/*.json
!grafana/provisioning/**/*.yml

# IDEs y sistema
.vscode/
.idea/
.DS_Store
Thumbs.db
```

---

## 📘 Documentación adicional

### `docs/arquitectura.md`

```markdown
# 🧭 Arquitectura – Observabilidad Fase 3

Este documento explica el flujo técnico del laboratorio de observabilidad con Prometheus + Node Exporter + Grafana.

## 🔄 Flujo de componentes

[Node Exporter] → métricas del sistema  
        ↓  
[Prometheus] → recolección y almacenamiento  
        ↓  
[Grafana] → visualización en dashboards

## 📦 Diagrama visual

![Flujo Prometheus → Grafana](assets/capturas/flujo-prometheus-nodeexporter-grafana.png)
```

---

### `docs/troubleshooting.md`

Errores comunes:
- Prometheus sin métricas → revisar `prometheus.yml`
- Dashboards vacíos → revisar `datasources.yml` y `dashboards.yml`
- YAML mal indentado → validar con `yamllint`

---

### `docs/preguntas-frecuentes.md`

- ¿Qué métricas se recolectan?
- ¿Cómo se filtra por host?
- ¿Cómo se calcula el uso de RAM?
- ¿Cómo se exporta un dashboard?

---

✅ Este bloque contiene **todo lo necesario para construir, ejecutar y enseñar** el workshop Fase 3.  
¿Quieres que te prepare una versión en inglés, una plantilla para futuros workshops, o una infografía visual para redes sociales? También puedo ayudarte a crear una checklist imprimible para tus alumnos.
