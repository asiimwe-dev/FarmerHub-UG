# 05 Backend Specification

**Core Engineering Blueprint for the FarmCom Core Backend Infrastructure**

> 🛠️ This document outlines the technical specification for the FarmCom Core backend. While the project is currently in the frontend-focused MVP phase, this specification defines the target architecture, technology stack, and implementation plan for the centralized intelligence layer.

---

## 📋 Table of Contents

1. [Architectural Overview](#architectural-overview)
2. [Technology Stack](#technology-stack)
3. [Database Schema & Geospatial Layer](#database-schema--geospatial-layer)
4. [Asynchronous Processing & Task Queue](#asynchronous-processing--task-queue)
5. [Predictive Yield Modeling Engine](#predictive-yield-modeling-engine)
6. [Security & Authentication](#security--authentication)
7. [Integration & Sync Gateway](#integration--sync-gateway)
8. [Observability & Reliability](#observability--reliability)
9. [Deployment & Infrastructure](#deployment--infrastructure)

---

## 🏛️ Architectural Overview

The FarmCom Core backend is designed as a high-performance, asynchronous REST API using a **Micro-Service Ready Monolith** approach. It prioritizes data integrity for offline-sync operations and provides the heavy-lifting computational power for yield forecasting.

### Key Architectural Pillars

- **Async-First**: Utilizing Python's `asyncio` for non-blocking I/O operations.
- **Geospatial Intelligence**: Native support for farm boundary polygons and spatial queries.
- **Decoupled Processing**: Offloading intensive ML and notification tasks to background workers.
- **Auditability**: Complete ledger of all field data changes for export compliance.

---

## 💻 Technology Stack

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Framework** | FastAPI | High performance, automatic OpenAPI docs, native async. |
| **Language** | Python 3.12+ | Industry standard for ML and data science. |
| **Database** | PostgreSQL 16 | Robust relational data integrity. |
| **Spatial Ext.** | PostGIS | Essential for mapping and boundary calculations. |
| **ORM** | SQLAlchemy 2.0 | Modern, type-safe mapping with async support. |
| **Task Queue** | Celery | Reliable distributed task processing. |
| **Message Broker** | Redis 7 | High-speed message passing and caching. |
| **Containerization** | Docker | Environment parity across dev and production. |

---

## 🗺️ Database Schema & Geospatial Layer

The database utilizes **PostGIS** to store and query complex farm boundaries (`POLYGON`) and point locations.

### Core Entities

1.  **Users & Identities**: RBAC-enabled user management.
2.  **Organizations (Cooperatives/Exporters)**: Tenant isolation for institutional data.
3.  **Plots (Geospatial)**: Farm boundaries with soil and slope attributes.
4.  **Field Records**: Temporal data of crop cycles, inputs, and labor.
5.  **Batches**: Aggregated harvest lots for traceability.
6.  **Audit Logs**: Immutable record of all data modifications.

### Geospatial Query Examples

-   Find all plots within a specific cooperative boundary.
-   Calculate total acreage of maize within a 50km radius.
-   Verify that a specific harvest batch originated from non-deforested coordinates (EUDR compliance).

---

## ⚙️ Asynchronous Processing & Task Queue

Using **Celery** with **Redis**, the backend handles time-intensive operations without blocking user requests:

-   **Background Sync**: Processing incoming batches of offline data from mobile devices.
-   **Yield Forecasting**: Running the ensemble regression models when new seasonal data arrives.
-   **Report Generation**: Compiling complex PDF export documentation.
-   **Third-party Integrations**: Syncing with weather APIs and market price feeds.

---

## 🧠 Predictive Yield Modeling Engine

The "Intelligent" in Agri-Intelligence is driven by an ensemble regression architecture.

### The Algorithm
The core engine calculates volume forecasts weeks before harvest:

$$Y_{pred} = \sum (A_i \times \eta_i \times \Omega_m)$$

Where:
-   **$Y_{pred}$**: Predicted crop volume.
-   **$A_i$**: Mapped physical acreage of plot $i$.
-   **$\eta_i$**: Plant density index (recorded during field capture).
-   **$\Omega_m$**: Dynamic environmental coefficient (computed from satellite canopy indices and local weather).

### Implementation Pipeline
1.  **Data Ingestion**: Cleanse and normalize incoming field metrics.
2.  **Feature Engineering**: Integrate external weather and satellite data.
3.  **Model Inference**: Run data through localized regression models.
4.  **Validation**: Compare against historical yields to refine coefficients.

---

## 🛡️ Security & Authentication

-   **OAuth2 / JWT**: Stateless authentication for mobile and web clients.
-   **RBAC (Role-Based Access Control)**: Granular permissions (e.g., `FieldAgent` vs `CoopManager`).
-   **Data Encryption**: AES-256 for sensitive field data at rest; TLS 1.3 in transit.
-   **Rate Limiting**: Protection against DDoS and API abuse via Redis.

---

## 🔄 Integration & Sync Gateway

The backend acts as the source of truth for the **Synchronization Gateway**:

1.  **Idempotency**: All sync operations use idempotent keys to prevent duplicate records.
2.  **Conflict Resolution**: Server-side logic to handle multi-device updates on the same plot.
3.  **Delta Sync**: Mobile devices only receive changes since their last successful sync to save data costs.

---

## 📊 Observability & Reliability

To maintain a 99.9% SLA, the backend implements a tiered monitoring and recovery strategy.

### 1. Monitoring & Tracing
*   **Structured Logging**: All logs are emitted in JSON format for ingestion by ELK/Loki.
*   **APM (Application Performance Monitoring)**: **Sentry** is used for real-time error tracking and performance profiling.
*   **Metrics**: **Prometheus** scrapes system-level (CPU/RAM) and application-level (Request Count, P99 Latency) metrics, visualized in **Grafana**.

### 2. Reliability Patterns
*   **Circuit Breakers**: Used when calling external weather or satellite APIs to prevent cascading failures.
*   **Rate Limiting**: Leaky bucket algorithm implemented at the gateway level to prevent API abuse.
*   **Dead Letter Queues (DLQ)**: Failed Celery tasks are moved to a DLQ for manual inspection and replay.

### 3. Data Durability
*   **Point-in-Time Recovery (PITR)**: Enabled for PostgreSQL to allow restoration to any second within the last 30 days.
*   **Redundant Broker**: Redis is configured in a Cluster mode to ensure no task is lost during a node failure.

---

## 🚢 Deployment & Infrastructure

-   **Cloud Provider**: AWS or Azure (Regional clusters in East Africa where available).
-   **Orchestration**: Docker Compose for MVP; Kubernetes for Phase 3 scaling.
-   **CI/CD**: GitHub Actions for automated testing and deployment.
-   **Monitoring**: Prometheus and Grafana for system metrics; Sentry for error tracking.

---

**Next: [06 API Documentation](./06_API_Documentation.md)**
