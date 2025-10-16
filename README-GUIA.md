# 📘 README-GUIA.md – Guía didáctica para el Workshop Fase 3

---

## 🎯 Objetivo de esta guía

Esta guía explica paso a paso cómo ejecutar el workshop **Fase 3: Prometheus + Node Exporter + Grafana**, qué hace cada archivo, en qué orden se usan, y cómo se conectan entre sí. Está pensada para que cualquier persona pueda reproducir el laboratorio, entender su arquitectura y aprender PromQL.

---

## 🧱 Estructura del repositorio explicada

| Carpeta | Propósito |
|--------|-----------|
| `prometheus/` | Configuración de Prometheus para recolectar métricas |
| `grafana/` | Dashboards y configuración para que Grafana los cargue automáticamente |
| `scripts/` | Scripts para iniciar y reiniciar el entorno |
| `docs/` | Documentación técnica y didáctica |
| `assets/` | Recursos visuales como diagramas |
| Raíz | Archivos principales como `README.md`, `.gitignore`, `docker-compose.yml` |

---

## 🚀 Cómo ejecutar el workshop paso a paso

1. Clona el repositorio:
   ```bash
   git clone https://github.com/jgaragorry/observabilidad-fase3-prometheus-nodeexporter.git
   cd observabilidad-fase3-prometheus-nodeexporter
   ```

2. Limpia el entorno:
   ```bash
   ./scripts/reset.sh
   ```

3. Levanta los servicios:
   ```bash
   ./scripts/setup.sh
   ```

4. Accede a Grafana:
   - URL: `http://localhost:3000`
   - Usuario: `admin`
   - Contraseña: `admin`

5. Accede a Prometheus:
   - URL: `http://localhost:9090`

6. Explora los dashboards cargados automáticamente

7. Revisa esta guía para entender cada componente

---

## 🔧 Archivos explicados

### `docker-compose.yml`
> Orquesta los servicios Prometheus, Node Exporter y Grafana. Define red, puertos y volúmenes.

### `prometheus/prometheus.yml`
> Configura Prometheus para recolectar métricas del sistema desde Node Exporter.

### `grafana/provisioning/datasources/datasources.yml`
> Conecta Grafana con Prometheus como fuente de datos.

### `grafana/provisioning/dashboards/dashboards.yml`
> Indica a Grafana dónde buscar los dashboards `.json` para cargarlos automáticamente.

### `grafana/dashboards/fase3/sistema-basico.json`
> Dashboard con paneles para CPU, RAM, disco y red.

### `grafana/dashboards/fase3/sistema-avanzado.json`
> Dashboard con paneles para swap, procesos, TCP, entropía y uptime.

### `scripts/reset.sh`
> Elimina contenedores, volúmenes y redes para reiniciar el entorno.

### `scripts/setup.sh`
> Levanta los servicios y verifica que estén corriendo.

### `.gitignore`
> Excluye archivos temporales y persistentes, pero permite versionar dashboards y configuración.

---

## 📘 Guía didáctica – Aprendiendo PromQL paso a paso

PromQL (Prometheus Query Language) permite consultar, filtrar y transformar métricas recolectadas por Prometheus.

### 🧩 1. Entender la estructura de una métrica
```promql
node_memory_MemAvailable_bytes
```

### 🔍 2. Filtrar por etiquetas
```promql
node_cpu_seconds_total{mode="user"}
```

### ⏱️ 3. Aplicar funciones de tiempo
```promql
rate(node_cpu_seconds_total{mode!="idle"}[1m])
```

### 📊 4. Agrupar por etiquetas
```promql
sum(rate(node_cpu_seconds_total{mode!="idle"}[1m])) by (instance)
```

### 🧠 5. Crear expresiones compuestas
```promql
(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100
```

### 🧪 6. Validar en Prometheus
- Accede a `http://localhost:9090`
- Escribe la expresión PromQL
- Verifica resultados en tabla o gráfico

### 📊 7. Usar en Grafana
- Crea un panel → tipo `Graph`, `Gauge` o `Stat`
- Pega la expresión PromQL
- Ajusta leyenda, unidad y colores

---

## 🎓 Ejercicios sugeridos para alumnos

1. Mostrar el uso de CPU por núcleo
2. Calcular el porcentaje de RAM usada
3. Ver el número de procesos activos
4. Mostrar el uptime del sistema
5. Graficar el tráfico de red por segundo

---

## 🧪 Troubleshooting

- Prometheus sin métricas → revisar `prometheus.yml`
- Dashboards vacíos → revisar `datasources.yml` y `dashboards.yml`
- YAML mal indentado → validar con `yamllint`
- JSON mal formateado → validar con `jq`
- Contenedores caídos → usar `docker ps` y revisar logs

---

## ❓ Preguntas frecuentes

- ¿Qué métricas se recolectan?
- ¿Cómo se filtra por host?
- ¿Cómo se calcula el uso de RAM?
- ¿Cómo se exporta un dashboard?
- ¿Cómo se reinicia el entorno?

---

## 🧭 Arquitectura del flujo

```plaintext
[Node Exporter] → métricas del sistema
        ↓
[Prometheus] → recolección y almacenamiento
        ↓
[Grafana] → visualización en dashboards
```

![Flujo Prometheus → Grafana](assets/capturas/flujo-prometheus-nodeexporter-grafana.png)

---

## ✅ Validación final

- Todos los archivos están explicados
- El orden de ejecución está claro
- La arquitectura está documentada
- PromQL está enseñado paso a paso
- El workshop es reproducible y didáctico

---

