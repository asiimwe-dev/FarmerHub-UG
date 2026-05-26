# 03 Architecture Blueprint

**Full-Stack Agri-RegTech Architecture for Global Compliance**

> 📖 Technical reference for the FarmerHub UG ecosystem, detailing the offline-first mobile architecture, the geospatial intelligence layer, and the National DWH integration framework.

**Last Updated**: May 2026 | **Status**: ✅ Production Ready | **Audience**: Architects, Lead Engineers, Security Officers

---

## 📋 Table of Contents

1. [Architectural Overview](#architectural-overview)
2. [FarmerHub Core: The Intelligence Engine](#farmerhub-core-the-intelligence-engine)
3. [The Mixed-Pixel Solution: Canopy-Decoupling Algorithm](#the-mixed-pixel-solution-canopy-decoupling-algorithm)
4. [Offline-First Resilience](#offline-first-resilience)
5. [Geospatial & Spatial Database Design](#geospatial--spatial-database-design)
6. [National DWH (TAP) Integration](#national-dwh-tap-integration)
7. [Security, Privacy & Data Sovereignty](#security-privacy--data-sovereignty)

---

## 🎯 Architecture Overview

FarmerHub UG uses a **Micro-Service Ready Monolith** approach on the backend and **Clean Architecture** on the frontend. The system is designed to handle the "Mixed Pixel Challenge" of intercropped tropical systems while maintaining 100% functionality in zero-connectivity rural zones.

```
┌─────────────────────────────────┐       ┌───────────────────────────────┐
│     FarmerHub UG (Mobile)       │       │    FarmerHub UG (Backend)     │
│  (Flutter + SQLite + Reactive)  │ <───> │ (FastAPI + PostGIS + Celery)  │
└───────────────┬─────────────────┘       └───────────────┬───────────────┘
                │                                         │
                ▼                                         ▼
      [Mediated Data Capture]                  [National Coffee DWH]
      Farmer & Plot Mapping                    (NITA-U Hosted TAP API)
```

---

## 🧠 FarmerHub Core: The Intelligence Engine

The core engine models crop volumes using a proprietary mathematical formulation that filters out overstory vegetation noise (e.g., banana leaves) in intercropped systems.

### The Decoupling Yield Formula
$$Y_{pred} = \sum_{i=1}^{N} \left( A_{i} \cdot n_{i} \cdot \left[ \Omega_{m} \cdot \Psi(k, \sigma) \right] \right)$$

*   **$\Omega_m$**: Dynamic environmental coefficient (Satellite/Weather).
*   **$\Psi(k, \sigma)$**: **Canopy-Decoupling correction function**.
    *   $k$: Ratio of overstory canopy density to understory crop density.
    *   $\sigma$: Species-specific crop growth habit index (e.g., crown-to-stem diameter ratio).

---

## 📱 Offline-First Resilience

Field teams operate in deep rural corridors with zero 3G/4G coverage.

*   **Local Persistence**: SQLite with an encryption layer (SQLCipher).
*   **Sync Gateway**: Asynchronous background workers using an **Idempotent Sync Protocol**.
*   **Reactive UI**: UI updates instantly, with sync status reflected via a causal ordering ledger.

---

## 🗺️ Geospatial & Spatial Database Design

We leverage **PostgreSQL 16 + PostGIS** to store complex farm boundary polygons.

*   **EUDR Geometry**: Automated validation of polygon intersections with deforestation maps (reference date: Dec 31, 2020).
*   **Coordinate System**: Standardized to **WGS84 (EPSG:4326)** for global interoperability.
*   **Spatial Indexing**: GiST indexing for rapid proximity queries (e.g., "Find all plots within 50km of a protected forest").

---

## 🔌 National DWH (TAP) Integration

FarmerHub UG acts as an authorized **Traceability Access Platform (TAP)**.

1.  **Handshake**: Secure OAuth2 handshake with the UCDA/NITA-U hosted National Coffee Data Warehouse.
2.  **Encrypted Payload**: Farmer identifiers are encrypted (AES-256) before transit to comply with the **Uganda Data Protection Act**.
3.  **Unique ID Retrieval**: The backend retrieves a government-approved unique ID for every plot, which is then appended to the export DDS.

---

## 🛡️ Security, Privacy & Data Sovereignty

### 1. Zero Trust Identity
All users must use multi-factor authentication (MFA). Device binding ensures only authorized hardware can access the TAP integration layer.

### 2. Sovereign Data Governance
The architecture strictly enforces **Data Portability**.
*   **No Lock-in**: Cooperatives can export their full supply chain ledger in audit-ready formats (CSV, XML, JSON).
*   **Consent Management**: Explicit digital consent logs are stored on the immutable ledger for every farmer registration.

---

**Next: [04 Development Setup](./04_Development_Setup.md)**
