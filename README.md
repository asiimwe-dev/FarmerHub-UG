# Farmer Hub UG - Documentation

Welcome to **Farmer Hub UG**, a professional B2B agri-intelligence platform for cooperatives, exporters, and field teams across East Africa.

## Quick Navigation

| I want to... | Read this |
|---|---|
| **Get started developing** | → [docs/SETUP.md](./docs/SETUP.md) |
| **Understand the codebase** | → [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) |
| **Contribute code** | → [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) |
| **See project vision** | → [docs/PROJECT_OVERVIEW.md](./docs/PROJECT_OVERVIEW.md) |
| **Understand business model** | → [docs/BUSINESS_MODEL.md](./docs/BUSINESS_MODEL.md) |
| **Check development roadmap** | → [docs/ROADMAP.md](./docs/ROADMAP.md) |
| **Quick developer reference** | → [docs/QUICK_REFERENCE.md](./docs/QUICK_REFERENCE.md) |

---

## What is Farmer Hub UG?

**Farmer Hub UG** is an offline-first agri-intelligence platform transforming agricultural supply chains in Uganda and East Africa.

**For Cooperatives** — Aggregate member data, track yields, plan logistics  
**For Processors** — Trace raw material provenance, ensure compliance  
**For Exporters** — Generate export-grade traceability documentation  
**For Lenders** — Assess risk with yield history and land data  
**For Field Teams** — Capture data offline, sync when connected  

### Core Philosophy

- 📱 **Offline-First** — Full functionality without internet
- 🌾 **Domain-Specific** — Built for agricultural stakeholders  
- 🔄 **Sync-Ready** — Automatic background synchronization
- 🛡️ **Enterprise-Grade** — Professional code quality and security
- 📊 **Data-Driven** — Yield forecasting and predictive analytics

**Learn more:** See [docs/PROJECT_OVERVIEW.md](./docs/PROJECT_OVERVIEW.md)

---

## Quick Start

### 5 Minutes to Running

```bash
git clone https://github.com/asiimwe-dev/FarmLink-UG.git
cd FarmLink-UG/frontend
flutter pub get
flutter analyze  # Should show 0 issues
flutter test     # All tests pass
flutter run
```

### Complete Setup Guide

**→ [See docs/SETUP.md](./docs/SETUP.md) for full environment setup instructions**

Includes:
- Prerequisites (Flutter, Git, IDE)
- IDE configuration (VS Code, Android Studio)
- Emulator setup
- Debugging tools
- Common troubleshooting

---

## Project Structure

```
FarmLink-UG/
├── README.md                           ← You are here
├── docs/                               ← ALL DOCUMENTATION
│   ├── SETUP.md                        # Environment setup
│   ├── ARCHITECTURE.md                 # Code structure & patterns
│   ├── CONTRIBUTING.md                 # Contribution guide & CoC
│   ├── QUICK_REFERENCE.md              # Developer shortcuts
│   ├── PROJECT_OVERVIEW.md             # Business vision
│   ├── BUSINESS_MODEL.md               # Revenue model
│   ├── ROADMAP.md                      # Development phases
│   └── archive/                        # Legacy documentation
├── frontend/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── config/                     # Constants & config
│   │   ├── core/                       # Shared infrastructure
│   │   │   ├── exceptions/             # Error hierarchy
│   │   │   ├── validators/             # Input validation  
│   │   │   ├── extensions/             # Utility extensions
│   │   │   └── ...
│   │   ├── app/                        # Shell & routing
│   │   └── modules/                    # Feature modules
│   ├── test/                           # Test suite
│   └── pubspec.yaml                    # Dependencies
└── FARMCOM_CORE_VC_Business_Plan.pdf   # Business plan reference
```

**See:** [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) → Directory Structure

---

## Key Features

### 1. Offline-First Architecture
- Complete functionality without connectivity
- Automatic local storage
- Background sync when reconnected

**Learn more:** [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) → Offline-First Architecture

### 2. Field Data Capture
- GPS-enabled plot entry
- Crop and yield data
- Offline form submission

**Learn more:** [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) → Modules

### 3. Data Synchronization
- Queue-based background sync
- Exponential backoff on failures
- Batch processing

**Learn more:** [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) → Data Synchronization

### 4. Traceability
- Batch provenance tracking
- Export-grade compliance
- Historical versioning

### 5. Yield Forecasting
- Predictive analytics
- Risk assessment
- Recommendations

**See roadmap:** [docs/ROADMAP.md](./docs/ROADMAP.md)

---

## Technology Stack

### Frontend
- **Framework**: Flutter 3.x
- **Language**: Dart  
- **State Management**: Riverpod 2.x
- **Routing**: GoRouter 13.x
- **HTTP**: Dio 5.x
- **Database**: SQLite (local)
- **Connectivity**: Connectivity Plus

**Full details:** [docs/SETUP.md](./docs/SETUP.md) → Technology Stack

---

## Development Guide

### Code Quality

All code must pass:

```bash
flutter analyze              # 0 issues
flutter test                 # All pass
dart format lib/             # Formatted
```

**Details:** [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) → Code Standards

### Common Tasks

| Task | Reference |
|------|-----------|
| Add new feature | [docs/QUICK_REFERENCE.md](./docs/QUICK_REFERENCE.md) → Workflows |
| Write tests | [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) → Testing |
| Add page | [docs/QUICK_REFERENCE.md](./docs/QUICK_REFERENCE.md) → New Page |
| Handle errors | [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) → Error Handling |
| Validate input | [docs/QUICK_REFERENCE.md](./docs/QUICK_REFERENCE.md) → Validation |

**Full guide:** [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md)

### Code Standards

- **Architecture**: Clean Architecture (domain/data/presentation)
- **Naming**: PascalCase (classes), snake_case (files)
- **Errors**: Explicit typed exceptions (no silent failures)
- **Testing**: 90%+ coverage for business logic
- **Docs**: Public APIs documented with `///`

**See:** [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) → Code Standards

---

## Contribution Guidelines

### Code of Conduct

✅ **Be Respectful, Collaborative, Accountable**  
❌ **No Harassment, Plagiarism, or Conflicts of Interest**

**Full conduct:** [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) → Code of Conduct

### How to Contribute

1. **Fork** repository on GitHub
2. **Clone** your fork locally
3. **Create branch** (`git checkout -b feature/xyz`)
4. **Make changes** following code standards
5. **Test thoroughly** (`flutter test`, `flutter analyze`)
6. **Commit** with clear messages
7. **Push** and create Pull Request

**Complete workflow:** [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) → PR Process

### Commit Messages

Format:
```
<type>(<scope>): <subject>

<body>

<footer>
```

Example:
```
feat(field-capture): Add GPS validation

Implement latitude/longitude validation with bounds checking.

Fixes #123
```

**Details:** [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) → Commit Guidelines

---

## Deployment

### Build for Production

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS  
flutter build ios --release
```

**Full guide:** [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) → Deployment

---

## Getting Help

### Documentation Files (in docs/)

| File | Purpose |
|------|---------|
| [docs/SETUP.md](./docs/SETUP.md) | Environment setup & configuration |
| [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) | Code structure & patterns |
| [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) | Contribution & code standards |
| [docs/QUICK_REFERENCE.md](./docs/QUICK_REFERENCE.md) | Quick lookup reference |
| [docs/PROJECT_OVERVIEW.md](./docs/PROJECT_OVERVIEW.md) | Project vision |
| [docs/BUSINESS_MODEL.md](./docs/BUSINESS_MODEL.md) | Business model |
| [docs/ROADMAP.md](./docs/ROADMAP.md) | Development roadmap |

### External Resources

- [Flutter Docs](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Riverpod Docs](https://riverpod.dev)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

### Support

**Questions?** Check docs first, then open [GitHub Discussion](https://github.com/asiimwe-dev/FarmLink-UG/discussions)

**Bug?** Open [GitHub Issue](https://github.com/asiimwe-dev/FarmLink-UG/issues) with details

**Want to contribute?** Read [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) first

---

## Quick Commands

```bash
# Setup
flutter pub get              # Install dependencies

# Development
flutter run                  # Run debug
flutter run --release        # Run release

# Quality
flutter analyze              # Static analysis
flutter test                 # Run tests
flutter test --coverage      # With coverage
dart format lib/             # Format code

# Build
flutter build apk --release  # Android APK
flutter build appbundle      # Play Store
flutter build ios --release  # iOS

# Debugging
flutter logs                 # Device logs
flutter devices              # List devices
flutter doctor               # Check setup
```

**More:** [docs/QUICK_REFERENCE.md](./docs/QUICK_REFERENCE.md)

---

## Project Status

✅ **Phase 1: MVP Frontend**  
- Core architecture complete
- Field capture skeleton ready
- Professional codebase standards

⏳ **Phase 2: Feature Development**  
- Complete field_capture module
- Local SQLite persistence
- Background sync service

📅 **Future Phases**: See [docs/ROADMAP.md](./docs/ROADMAP.md)

---

## Repository

- **GitHub**: [FarmerHub-UG](https://github.com/asiimwe-dev/FarmLink-UG)
- **Issues**: [GitHub Issues](https://github.com/asiimwe-dev/FarmLink-UG/issues)
- **Discussions**: [GitHub Discussions](https://github.com/asiimwe-dev/FarmLink-UG/discussions)

---

## Next Steps

1. ✅ Read this README
2. 📖 Read [docs/SETUP.md](./docs/SETUP.md) for environment setup
3. 🏗️ Read [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) for code structure
4. 💻 Start developing in `frontend/lib/`
5. 📝 Follow [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) when contributing

---

**Last Updated**: May 2026  
**Maintained By**: Farmer Hub UG Development Team

**Questions?** See [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) → Getting Help
