# 09 Quick Reference

**CLI Shortcuts, Common Tasks, and Troubleshooting for FarmerHub UG**

> ⚡ Quick reference guide for developers to find common commands, shortcuts, and troubleshooting steps for the FarmerHub UG project.

---

## 📋 Table of Contents

1. [Flutter CLI Shortcuts](#flutter-cli-shortcuts)
2. [Backend CLI Shortcuts](#backend-cli-shortcuts)
3. [Common Development Tasks](#common-development-tasks)
4. [Project Directory Shortcuts](#project-directory-shortcuts)
5. [Troubleshooting](#troubleshooting)
6. [Useful Resources](#useful-resources)

---

## 📱 Flutter CLI Shortcuts

| Command | Description |
|---------|-------------|
| `flutter run` | Run the application |
| `flutter pub get` | Install dependencies |
| `flutter analyze` | Run static analysis |
| `flutter test` | Run unit and widget tests |
| `flutter clean` | Clear build caches |
| `flutter doctor` | Check environment status |
| `flutter devices` | List connected devices |

---

## 🛠️ Backend CLI Shortcuts

| Command | Description |
|---------|-------------|
| `pytest` | Run backend tests |
| `uvicorn app.main:app --reload` | Run FastAPI dev server |
| `pip install -r requirements.txt` | Install dependencies |
| `docker-compose up` | Start local infra (PostgreSQL, Redis) |

---

## 🏗️ Common Development Tasks

### Creating a New Module
1. Create directory in `lib/modules/`
2. Follow Clean Architecture layers (domain, data, presentation)
3. Register providers in `lib/core/di/providers.dart`
4. Update router in `lib/app/router.dart`

### Running Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

### Building for Release (Android)
```bash
flutter build apk --release
```

---

## 📂 Project Directory Shortcuts

| Path | Description |
|------|-------------|
| `frontend/lib/app/` | Routing and bootstrap logic |
| `frontend/lib/core/` | Shared components and utilities |
| `frontend/lib/modules/` | Feature-specific business logic and UI |
| `backend/app/api/` | REST API endpoints |
| `backend/app/services/` | Business logic and ML engine |
| `docs/` | Project documentation |

---

## 🔍 Troubleshooting

### Sync Issues
- Check network connectivity.
- Verify JWT token hasn't expired.
- Check backend logs for idempotency conflicts.

### GPS Accuracy
- Ensure location permissions are granted.
- Check GPS precision in field capture page.
- Verify coordinate system (WGS84).

---

## 📚 Useful Resources
- [Flutter Documentation](https://docs.flutter.dev)
- [Riverpod Guide](https://riverpod.dev)
- [FastAPI Documentation](https://fastapi.tiangolo.com)
- [PostGIS Reference](https://postgis.net/documentation)

---

**Next: [10 Product Roadmap](./10_Product_Roadmap.md)**
