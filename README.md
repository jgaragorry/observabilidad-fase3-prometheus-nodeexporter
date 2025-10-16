# 📘 Observabilidad Fase 3 – Métricas del sistema con Prometheus + Node Exporter

Este repositorio contiene un laboratorio técnico y didáctico para recolectar, almacenar y visualizar métricas del sistema en tiempo real usando **Prometheus** y **Node Exporter**, con dashboards en **Grafana** y orquestación vía **Docker Compose**.

Aplica buenas prácticas de **DevOps**, **SRE**, **SysOps**, **NetOps**, **DevSecOps**, **Monitoring**, **Telemetría** y **FinOps**, con enfoque reproducible, seguro y orientado a la enseñanza.

---

## 🎯 Objetivo del laboratorio

- Recolectar métricas del sistema (CPU, RAM, disco, red, procesos, etc.)
- Visualizarlas automáticamente en Grafana
- Enseñar PromQL, trazabilidad y monitoreo moderno
- Aplicar buenas prácticas de infraestructura, seguridad y observabilidad

---

## 🧱 Estructura del repositorio

```
observabilidad-fase3-prometheus-nodeexporter/
├── docker-compose.yml
├── .gitignore
├── README.md
├── README-GUIA.md
│
├── prometheus/
│   └── prometheus.yml
│
├── grafana/
│   ├── dashboards/
│   │   └── fase3/
│   │       ├── sistema-basico.json
│   │       └── sistema-avanzado.json
│   └── provisioning/
│       ├── datasources/
│       │   └── datasources.yml
│       └── dashboards/
│           └── dashboards.yml
│
├── scripts/
│   ├── reset.sh
│   └── setup.sh
│
├── docs/
│   ├── arquitectura.md
│   ├── troubleshooting.md
│   └── preguntas-frecuentes.md
│
└── assets/
    └── capturas/
        └── flujo-prometheus-nodeexporter-grafana.png
```

---

## 🚀 ¿Cómo ejecutar el laboratorio?

```bash
git clone https://github.com/jgaragorry/observabilidad-fase3-prometheus-nodeexporter.git
cd observabilidad-fase3-prometheus-nodeexporter
./scripts/reset.sh
./scripts/setup.sh
```

Accede a Grafana:  
`http://localhost:3000`  
Usuario: `admin`  
Contraseña: `admin`

---

## 📊 Dashboards disponibles

### 🧩 Sistema Básico

```promql
rate(node_cpu_seconds_total{mode!="idle"}[1m])
node_memory_MemAvailable_bytes
node_memory_MemTotal_bytes
node_filesystem_avail_bytes
rate(node_network_receive_bytes_total[1m])
rate(node_network_transmit_bytes_total[1m])
```

### 🧠 Sistema Avanzado

```promql
node_memory_SwapTotal_bytes - node_memory_SwapFree_bytes
node_load1
node_procs_running
node_netstat_Tcp_CurrEstab
node_entropy_available_bits
node_time_seconds - node_boot_time_seconds
```

---

