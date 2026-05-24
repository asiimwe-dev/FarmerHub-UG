# Farmer Hub UG - Frontend Documentation

## Table of Contents

1. [Overview](#overview)
2. [Project Vision](#project-vision)
3. [Technology Stack](#technology-stack)
4. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Installation](#installation)
   - [Environment Setup](#environment-setup)
   - [Running the App](#running-the-app)
5. [Architecture](#architecture)
   - [Design Patterns](#design-patterns)
   - [Clean Architecture](#clean-architecture)
   - [Directory Structure](#directory-structure)
6. [Core Concepts](#core-concepts)
   - [Offline-First Architecture](#offline-first-architecture)
   - [Data Synchronization](#data-synchronization)
   - [Error Handling](#error-handling)
7. [Development Workflow](#development-workflow)
   - [Creating New Features](#creating-new-features)
   - [Code Organization](#code-organization)
   - [State Management](#state-management)
   - [Testing](#testing)
8. [API Integration](#api-integration)
9. [Database & Local Storage](#database--local-storage)
10. [Authentication](#authentication)
11. [Validation & Error Handling](#validation--error-handling)
12. [Deployment](#deployment)
13. [Best Practices](#best-practices)
14. [Troubleshooting](#troubleshooting)
15. [Resources](#resources)

---

## Overview

**Farmer Hub UG** is a modern B2B agri-intelligence platform built with Flutter. It provides cooperative aggregation, predictive yield planning, and export-grade traceability for agricultural stakeholders in Uganda and across East Africa.

### Key Features
- 📱 **Offline-First** — Full functionality without internet connectivity
- 🌾 **Field Capture** — Easy plot data entry with GPS validation
- 📊 **Yield Forecasting** — AI-powered predictive analytics
- 🔗 **Traceability** — Complete batch provenance tracking
- 🔄 **Background Sync** — Automatic cloud synchronization
- 🛡️ **Enterprise Security** — Role-based access, encrypted storage

### Repository
- **GitHub**: [FarmerHub-UG](https://github.com/asiimwe-dev/FarmLink-UG)
- **Frontend**: Flutter (this repository)
- **Backend**: FastAPI + PostgreSQL (separate repository)

---

## Project Vision

Farmer Hub UG transforms agricultural supply chains through offline-first intelligence:

1. **For Cooperatives** — Aggregate member data, track yields, plan logistics
2. **For Processors** — Trace raw material provenance, ensure compliance
3. **For Exporters** — Generate export-grade traceability documentation
4. **For Lenders** — Assess risk with yield history and land data
5. **For Field Teams** — Capture data offline, sync when connected

**Current Phase**: MVP with core modules (auth, field capture, basic sync)

---

## Technology Stack

### Core Framework
- **Flutter 3.x** — Cross-platform mobile development (iOS, Android)
- **Dart** — Modern, strongly-typed language

### State Management & DI
- **Riverpod 2.x** — Reactive dependency injection and state management
- **Flutter Riverpod** — Bindings for Flutter

### Networking & HTTP
- **Dio 5.x** — HTTP client with interceptors and error handling
- **GoRouter 13.x** — Type-safe routing and navigation

### Local Storage & Sync
- **SQLite** (via `sqflite`) — Primary local database (TODO)
- **Isar** (later) — High-performance alternative when AGP 8.x stable

### Connectivity
- **Connectivity Plus** — Detect online/offline state
- **Background Sync** — Queue sync tasks when reconnected

### Utilities
- **Equatable** — Value equality for entities and models
- **Intl** — Internationalization and date formatting
- **Logger** — Pretty-printing debug logs

### Development
- **Analysis** — Dart linter with strict rules
- **Testing** — Flutter test framework

---

## Getting Started

### Prerequisites

- **Flutter SDK** 3.x or later
  ```bash
  flutter --version
  ```
- **Dart SDK** (included with Flutter)
- **Git** for version control
- **Android Studio** or **Xcode** (for emulators)
- **VS Code** or **Android Studio** (IDE)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/asiimwe-dev/FarmLink-UG.git
   cd FarmLink-UG/frontend
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation** (if needed)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Environment Setup

Create a `.env` file in `frontend/` directory:

```env
# Development
FLAVOR=dev
API_BASE_URL=http://localhost:8000/api
DEBUG=true

# Staging
# FLAVOR=staging
# API_BASE_URL=https://staging.farmerhub.example.com/api
# DEBUG=false
```

Update `lib/config/app_config.dart` to load from `.env` if needed.

### Running the App

**Development (debug mode)**
```bash
flutter run --debug
```

**Release build**
```bash
flutter run --release
```

**On specific device**
```bash
flutter devices  # List connected devices
flutter run -d <device_id>
```

**Web (for testing)**
```bash
flutter run -d chrome
```

---

## Architecture

### Design Patterns

1. **Clean Architecture** — Separation of concerns (domain/data/presentation)
2. **Repository Pattern** — Abstract data access layer
3. **Dependency Injection** — Riverpod providers for testability
4. **State Management** — Riverpod for reactive state
5. **Mapper Pattern** — DTO↔Entity transformations

### Clean Architecture

```
Presentation Layer (UI)
    ↓ (depends on)
Application Layer (Use Cases)
    ↓ (depends on)
Domain Layer (Entities, Abstract Repos)
    ↓ (depends on)
Data Layer (DTOs, Concrete Repos, DataSources)
```

**Benefits**:
- ✅ Testable (mock each layer independently)
- ✅ Reusable (business logic not coupled to UI)
- ✅ Maintainable (clear responsibilities)
- ✅ Scalable (easy to add new features)

### Directory Structure

```
frontend/lib/
├── config/                          # Environment & constants
│   ├── app_config.dart
│   └── constants.dart
├── core/                            # Shared infrastructure
│   ├── di/                          # Dependency injection
│   ├── exceptions/                  # Error hierarchy
│   ├── extensions/                  # Utility extensions
│   ├── network/                     # HTTP client
│   ├── validators/                  # Input validation
│   ├── mappers/                     # DTO↔Entity conversion
│   ├── theme/                       # UI theming
│   ├── utils/                       # Helpers
│   └── widgets/                     # Reusable components
├── app/                             # Application shell
│   ├── bootstrap.dart
│   ├── app.dart
│   └── router.dart
└── modules/                         # Feature modules
    ├── auth/                        # Authentication
    ├── field_capture/               # Field data entry
    ├── sync/                        # Synchronization
    ├── traceability/                # Batch tracking
    └── forecasts/                   # Yield predictions
```

See `frontend/lib/ARCHITECTURE.md` for detailed structure explanation.

---

## Core Concepts

### Offline-First Architecture

The app works **completely offline**. Data is stored locally; sync happens when connected.

**Flow**:
1. User enters field data → Saved to **local SQLite**
2. App detects connectivity → Queues data for sync
3. Background sync service → Pushes to backend API
4. Backend confirms → Marks as synced locally
5. User can still view/edit data even if sync fails

**Implementation**:
- `modules/sync/` — Manages sync queue and orchestration
- `connectivity_plus` — Detects online/offline state
- Local caching — Reduces API calls

### Data Synchronization

**Sync Service** (`modules/sync/`):
- Monitors connectivity state
- Queues outgoing changes
- Batches requests to reduce API load
- Implements exponential backoff on failures
- Resolves conflicts (local vs remote)

**Conflict Resolution Strategy**:
- **Last-Write-Wins** — For most data
- **Manual Review** — For critical data (high-value transactions)

### Error Handling

All errors inherit from `AppException`. Specific types:

```dart
AppException
├── NetworkException      // API, connection failures
├── ValidationException   // Invalid input data
├── OfflineException     // No connectivity
├── SyncException        // Sync queue failures
└── UnknownException     // Unhandled errors
```

**Usage**:
```dart
try {
  await fieldRepo.saveField(field);
} on ValidationException catch (e) {
  showInlineError(e.message);
} on NetworkException catch (e) {
  showOfflineBanner(e.message);
} on SyncException catch (e) {
  retryWithBackoff();
}
```

---

## Development Workflow

### Creating New Features

**1. Define Domain Layer** (business logic)
```
modules/my_feature/
├── domain/
│   ├── entities/
│   │   └── my_entity.dart       # Pure Dart class (no framework code)
│   ├── repositories/
│   │   └── my_repository.dart   # Abstract contract
│   └── usecases/
│       └── my_usecase.dart      # Business logic, input validation
```

**2. Implement Data Layer** (storage & API)
```
modules/my_feature/
├── data/
│   ├── models/
│   │   └── my_dto.dart          # JSON serializable
│   ├── datasources/
│   │   ├── local_datasource.dart     # SQLite access
│   │   └── remote_datasource.dart    # API client
│   └── repositories/
│       └── my_repository_impl.dart   # Concrete implementation
```

**3. Add Presentation Layer** (UI & state)
```
modules/my_feature/
├── presentation/
│   ├── pages/
│   │   └── my_page.dart         # Full screen
│   ├── widgets/
│   │   └── my_widget.dart       # Reusable component
│   └── providers/
│       └── my_providers.dart    # Riverpod state
```

**4. Wire Up DI**
```dart
// In my_feature_providers.dart
final myRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MyRepositoryImpl(dio);
});

final myDataProvider = FutureProvider((ref) async {
  final repo = ref.watch(myRepositoryProvider);
  return repo.fetchData();
});
```

**5. Add Route**
```dart
// In app/router.dart
GoRoute(
  path: '/my-feature',
  builder: (context, state) => MyPage(),
)
```

### Code Organization

**Barrel Exports** (hide internal structure):
```dart
// In modules/my_feature/my_feature.dart
export 'domain/entities/my_entity.dart';
export 'domain/repositories/my_repository.dart';
export 'presentation/pages/my_page.dart';

// Usage:
import 'package:farmer_hub_ug/modules/my_feature/my_feature.dart';
final entity = MyEntity(...);
```

**Naming Conventions**:
- Files: `snake_case` (e.g., `field_record.dart`)
- Classes: `PascalCase` (e.g., `FieldRecord`)
- Constants: `camelCase` (e.g., `maxFieldArea`)
- Privates: `_leadingUnderscore` (e.g., `_internalMethod`)

### State Management

Using **Riverpod** for reactive state:

```dart
// Simple provider (read-only)
final counterProvider = StateProvider<int>((ref) => 0);

// Async provider (for API calls)
final fieldProvider = FutureProvider.family<FieldRecord, String>((ref, id) async {
  final repo = ref.watch(fieldRepositoryProvider);
  return repo.fetchField(id);
});

// State notifier (for complex state)
final fieldListProvider = StateNotifierProvider<FieldListNotifier, List<FieldRecord>>(
  (ref) => FieldListNotifier(ref.watch(fieldRepositoryProvider)),
);
```

**In Widgets**:
```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch provider to rebuild on changes
    final fields = ref.watch(fieldListProvider);
    
    return fields.when(
      data: (data) => ListView(children: [...]),
      loading: () => LoadingState(),
      error: (err, st) => ErrorState(err.toString()),
    );
  }
}
```

### Testing

**Unit Tests** (domain logic):
```dart
test('SaveFieldUsecase validates area', () {
  final usecase = SaveFieldUsecase(mockRepo);
  expect(
    () => usecase(invalidArea: -5),
    throwsA(isA<ValidationException>()),
  );
});
```

**Widget Tests** (UI components):
```dart
testWidgets('FieldForm shows validation errors', (tester) async {
  await tester.pumpWidget(TestApp(child: FieldForm()));
  await tester.enterText(find.byType(TextField), '');
  await tester.pumpWidget(SizedBox.shrink()); // Trigger rebuild
  expect(find.text('Field name required'), findsOneWidget);
});
```

**Run Tests**:
```bash
flutter test                           # All tests
flutter test test/domain/              # Specific directory
flutter test --coverage                # With coverage report
```

---

## API Integration

### HTTP Client Setup

Located in `core/network/dio_client.dart`. Configured with:
- Base URL from `AppConfig`
- Request/response interceptors
- Timeout handling
- Error logging (debug mode)

### Making API Calls

```dart
// In datasource
class RemoteFieldDataSource {
  final Dio dio;
  
  Future<FieldRecordDTO> fetchField(String id) async {
    try {
      final response = await dio.get('/fields/$id');
      return FieldRecordDTO.fromJson(response.data);
    } on DioException catch (e) {
      throw NetworkException(
        message: 'Failed to fetch field',
        originalException: e,
      );
    }
  }
}
```

### Authentication

**Token Management** (TODO: Complete implementation):
- Store token in secure storage (Flutter Secure Storage)
- Add token to request headers
- Refresh token on 401 Unauthorized
- Clear token on logout

```dart
// In request interceptor (TBD)
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = ref.watch(authTokenProvider);
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
  ),
);
```

---

## Database & Local Storage

### SQLite (Planned)

**Setup** (TODO):
```dart
// In core/persistence/database_provider.dart
final databaseProvider = FutureProvider((ref) async {
  final dbPath = await getDatabasesPath();
  return openDatabase('$dbPath/farmerhub.db');
});
```

**Tables** (planned):
- `field_records` — Farm plot data
- `crop_records` — Crop planting info
- `yield_measurements` — Harvest data
- `sync_queue` — Pending remote changes
- `users` — Local user info

### Local Datasource

```dart
class LocalFieldDataSource {
  final Database db;
  
  Future<void> saveField(FieldRecordDTO dto) async {
    await db.insert(
      'field_records',
      dto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  Future<List<FieldRecordDTO>> getLocalFields() async {
    final rows = await db.query('field_records');
    return rows.map(FieldRecordDTO.fromMap).toList();
  }
}
```

---

## Authentication

### User Login Flow

1. User enters email + password
2. Call `/auth/login` endpoint
3. Backend returns JWT token + refresh token
4. Store tokens securely
5. Add token to subsequent requests
6. On 401, refresh token
7. On refresh failure, logout user

**State** (via Riverpod):
```dart
final authTokenProvider = StateProvider<String?>((ref) => null);
final currentUserProvider = StateProvider<User?>((ref) => null);

final loginProvider = FutureProvider.family<void, (String, String)>((ref, creds) async {
  final (email, password) = creds;
  final response = await ref.watch(dioProvider).post(
    '/auth/login',
    data: {'email': email, 'password': password},
  );
  ref.read(authTokenProvider.notifier).state = response.data['token'];
});
```

---

## Validation & Error Handling

### Input Validation

Located in `core/validators/`. Covers:
- **Field Validators** — Field names, areas, GPS coordinates
- **Crop Validators** — Crop types, planting dates
- **Measurement Validators** — Yields, units

```dart
// Usage in forms
TextFormField(
  validator: FieldValidators.validateFieldName,
  onChanged: (value) {
    setState(() => fieldNameError = FieldValidators.validateFieldName(value));
  },
)
```

### Error Display

**Network Errors**:
```dart
if (asyncValue.hasError) {
  return ErrorState(
    title: 'Connection Failed',
    message: 'Check your internet and try again',
    onRetry: () => ref.refresh(dataProvider),
  );
}
```

**Validation Errors**:
```dart
if (error is ValidationException) {
  return Padding(
    padding: EdgeInsets.only(top: 8),
    child: Text(error.message, style: TextStyle(color: Colors.red)),
  );
}
```

---

## Deployment

### Build APK (Android)

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-app.apk
```

### Build AAB (Google Play)

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app.aab
```

### Build IPA (iOS)

```bash
flutter build ios --release
# Then upload via Xcode or TestFlight
```

### Store Configuration

- **Google Play**: Upload AAB to Play Console
- **App Store**: Archive via Xcode, upload via App Store Connect
- **Version Management**: Update `pubspec.yaml` version before build

---

## Best Practices

### Code Style

- ✅ Use `final` by default (immutability)
- ✅ Private fields with `_` prefix
- ✅ PascalCase for classes, snake_case for files
- ✅ Use type annotations (no `var` for public APIs)
- ✅ Document public APIs with `///` comments

### Architecture

- ✅ Keep business logic in domain layer
- ✅ Avoid UI imports in data/domain layers
- ✅ Use exceptions for errors (not nullable returns)
- ✅ Validate input in usecases before database/API calls
- ✅ Use barrel exports to hide internal structure

### State Management

- ✅ Use Riverpod providers (never pass state via constructors)
- ✅ Keep state close to where it's used
- ✅ Use `.family` for parameterized providers
- ✅ Prefer `FutureProvider` for async operations
- ✅ Use `.select` to watch only needed properties

### Testing

- ✅ Test behavior, not implementation
- ✅ Mock external dependencies
- ✅ Write tests before code (TDD)
- ✅ Aim for >80% code coverage on critical paths
- ✅ Test error cases, not just happy path

### Performance

- ✅ Use `const` constructors where possible
- ✅ Avoid rebuilds with `RepaintBoundary`
- ✅ Cache network responses
- ✅ Lazy-load large lists
- ✅ Profile with DevTools before optimizing

---

## Troubleshooting

### Common Issues

**Issue: "CocoaPods dependency conflict"**
```bash
cd ios
rm -rf Pods Podfile.lock
cd ..
flutter clean
flutter pub get
```

**Issue: "Gradle build failed on Android"**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

**Issue: "Dio request timeouts"**
Check network/firewall. Increase timeout in `AppConstants.networkTimeout`.

**Issue: "State not updating in Riverpod"**
Ensure you're watching the provider: `ref.watch(myProvider)` not `ref.read(myProvider)`.

**Issue: "Sync queue stuck"**
Check logs in `core/utils/logger.dart`. Manually trigger retry or clear queue.

---

## Resources

### Flutter & Dart
- [Flutter Docs](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

### State Management
- [Riverpod Docs](https://riverpod.dev)
- [Flutter Riverpod](https://riverpod.dev/docs/ecosystem/flutter_riverpod)

### Architecture
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Repository Pattern](https://www.notion.so/Repository-Pattern-in-Flutter-0b05c5e2c8f4)

### Testing
- [Flutter Testing Guide](https://flutter.dev/docs/testing)
- [Mockito](https://pub.dev/packages/mockito)

### Design
- [Material Design 3](https://m3.material.io)
- [Flutter UI Documentation](https://flutter.dev/docs/development/ui)

---

## License

This project is private and confidential. All rights reserved.

## Contact

For questions or issues:
- Create a GitHub issue in the repository
- Contact the development team

---

**Last Updated**: May 2026  
**Maintained By**: Farmer Hub UG Development Team
