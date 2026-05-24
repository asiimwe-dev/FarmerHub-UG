# 06 API Documentation

**Technical Reference for the FarmCom Core REST API**

> 🔌 This document provides the high-level API specification for the FarmCom Core backend. It serves as the contract between the Flutter frontend and the FastAPI backend.

---

## 📋 Table of Contents

1. [Introduction](#introduction)
2. [Authentication](#authentication)
3. [Global Headers & Responses](#global-headers--responses)
4. [Endpoint Reference](#endpoint-reference)
    - [Auth & User Management](#auth--user-management)
    - [Field Capture & Plots](#field-capture--plots)
    - [Yields & Forecasting](#yields--forecasting)
    - [Sync & Batching](#sync--batching)
5. [Webhooks](#webhooks)
6. [Rate Limits & Error Codes](#rate-limits--error-codes)

---

## 📌 Introduction

The FarmCom Core API is a RESTful service that communicates using JSON. It is designed to support the **Offline-First** nature of the mobile application by providing efficient batch sync endpoints and idempotent operations.

**Base URL**: `https://api.farmerhub.ug/v1`

---

## 🛡️ Authentication

All requests (except login/registration) require a Bearer Token in the `Authorization` header.

```http
Authorization: Bearer <your_jwt_token>
```

- **Token Type**: JWT (JSON Web Token)
- **Expiration**: 24 hours (Access) / 30 days (Refresh)

---

## 🌐 Global Headers & Responses

### Headers
- `Content-Type: application/json`
- `X-Client-Platform: android | ios | web`
- `X-Client-Version: 1.0.0`

### Standard Response Format
```json
{
  "status": "success | error",
  "data": { ... },
  "message": "Optional message",
  "meta": {
    "timestamp": "2026-05-25T10:00:00Z",
    "request_id": "uuid-v4"
  }
}
```

---

## 🚀 Endpoint Reference

### Auth & User Management

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/auth/register` | Register a new user/organization |
| `POST` | `/auth/login` | Obtain access and refresh tokens |
| `POST` | `/auth/refresh` | Refresh an expired access token |
| `GET`  | `/auth/me` | Get current user profile |

### Field Capture & Plots

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET`  | `/plots` | List all plots for the organization |
| `POST` | `/plots` | Create a new plot boundary |
| `GET`  | `/plots/{id}` | Get detailed plot information |
| `PUT`  | `/plots/{id}` | Update plot attributes or boundary |
| `POST` | `/plots/capture` | Submit a new field record (crop, area, etc.) |

### Yields & Forecasting

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/yields` | Record harvest data for a plot |
| `GET`  | `/yields/history/{plot_id}` | Get historical yield trends |
| `GET`  | `/forecasts/{plot_id}` | Get AI-predicted yield for current season |
| `GET`  | `/forecasts/coop` | Get aggregated forecast for the cooperative |

### Sync & Batching

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/sync/up` | Batch upload offline records |
| `POST` | `/sync/down` | Fetch all changes since last sync timestamp |
| `GET`  | `/traceability/batch/{id}` | Get full provenance for a harvest batch |

---

## 🪝 Webhooks

Organizations can register webhooks to receive real-time notifications for:
- `sync.completed`: When a field team's sync is processed.
- `forecast.updated`: When a new seasonal forecast is generated.
- `compliance.alert`: When a batch fails EUDR validation.

---

## ⚠️ Rate Limits & Error Codes

### Rate Limits
- **Public endpoints**: 60 requests/minute per IP.
- **Authenticated endpoints**: 500 requests/minute per user.

### Common Error Codes

| Code | Meaning | Description |
|------|---------|-------------|
| `400` | Bad Request | Validation failed or missing parameters. |
| `401` | Unauthorized | Missing or invalid Bearer token. |
| `403` | Forbidden | User lacks necessary RBAC permissions. |
| `409` | Conflict | Sync conflict (e.g., edit on deleted record). |
| `429` | Too Many Requests | Rate limit exceeded. |
| `500` | Internal Server Error | Unexpected backend failure. |

---

**Next: [07 Development Workflows](./07_Development_Workflows.md)**
