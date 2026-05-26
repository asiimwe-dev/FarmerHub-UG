# 06 API Documentation

**Restricted REST API Specification: FarmerHub UG / National DWH Interface**

> 🔌 High-level API specification for the FarmerHub Core backend. Includes endpoints for supply chain aggregation, yield forecasting, and regulatory TAP integration.

---

## 📋 Table of Contents

1. [Authentication & IAM](#authentication--iam)
2. [Field & Plot Management](#field--plot-management)
3. [Yield Modeling Endpoints](#yield-modeling-endpoints)
4. [Regulatory Integration (TAP/DWH)](#regulatory-integration-tapdwh)
5. [Compliance & DDS Generation](#compliance--dds-generation)

---

## 🛡️ Authentication & IAM

All requests require a **JWT Bearer Token** issued via the OAuth2 Flow.
`Authorization: Bearer <token>`

---

## 🚀 Endpoint Reference

### Field & Plot Management

| Method | Endpoint | Description |
|:---|:---|:---|
| `POST` | `/plots/map` | Create plot boundary polygon + land tenure data. |
| `GET` | `/plots/{id}/compliance` | Check EUDR compliance status (Dec 31, 2020 intersection). |
| `PUT` | `/plots/{id}/layout` | Set crop layout type (Monocrop vs CBI) for ML engine. |

### Yield Modeling Endpoints

| Method | Endpoint | Description |
|:---|:---|:---|
| `GET` | `/forecasts/coop/{id}` | Get aggregated yield forecast with canopy-decoupling applied. |
| `POST` | `/forecasts/audit` | Flag plots with yield-to-acreage anomalies for field review. |

### Regulatory Integration (TAP/DWH)

| Method | Endpoint | Description |
|:---|:---|:---|
| `POST` | `/integration/tap/push` | Push encrypted farmer/plot data to National Coffee DWH. |
| `GET` | `/integration/tap/status/{id}` | Check government authorization status of a specific batch. |

### Compliance & DDS Generation

| Method | Endpoint | Description |
|:---|:---|:---|
| `POST` | `/compliance/dds/generate` | Compile Batch-level Due Diligence Statement (XML/JSON). |
| `GET` | `/compliance/certificates/{batch_id}` | Download verified Batch Provenance Certificate (PDF). |

---

## ⚠️ Error Codes

| Code | Meaning | Context |
|:---|:---|:---|
| `409` | Conflict | Sync conflict (Multi-agent edit on same plot). |
| `422` | Validation Error | Mapped polygon violates minimum accuracy thresholds. |
| `451` | Legal Reason | Data access restricted per Uganda Data Privacy Act. |

---

**Next: [07 Development Workflows](./07_Development_Workflows.md)**
