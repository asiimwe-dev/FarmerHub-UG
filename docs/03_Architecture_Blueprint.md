# 🏗️ Farmer Hub UG - Codebase Architecture Guide

**Professional Clean Architecture for FarmerHub Core Flutter Application**

> 📖 Complete reference for the codebase structure, design patterns, layer separation, and development guidelines. Understand how FarmerHub Core is organized for scalability, testability, and maintainability.

**Last Updated**: May 2026 | **Status**: ✅ Production Ready | **Audience**: Developers, Architects

---

## 📋 Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Core Design Principles](#core-design-principles)
3. [Clean Architecture Layers](#clean-architecture-layers)
4. [Directory Structure](#directory-structure)
5. [Core Infrastructure](#core-infrastructure)
6. [Feature Modules](#feature-modules)
7. [Dependency Injection](#dependency-injection)
8. [Error Handling](#error-handling)
9. [State Management](#state-management)
10. [Testing Strategy](#testing-strategy)
11. [Offline-First Architecture](#offline-first-architecture)
12. [Best Practices](#best-practices)
13. [Common Patterns](#common-patterns)
14. [Troubleshooting](#troubleshooting)

---

## 🎯 Architecture Overview

FarmerHub Core uses **Clean Architecture** with strict layer separation to enable:

- ✅ **Testability** — Each layer independently testable with mocks
- ✅ **Scalability** — Features isolated in modules, easy to extend
- ✅ **Maintainability** — Clear responsibilities, predictable code location
- ✅ **Reusability** — Shared infrastructure available to all features
- ✅ **Enterprise-Grade** — Professional patterns used in production apps

### Architecture Layers

```
┌────────────────────────────────┐
│     Presentation Layer         │  ← UI, Pages, Widgets
│   (app/, modules/*/presentation) │
├────────────────────────────────┤
│     Application Layer          │  ← Use Cases, State Management
│   (modules/*/application)      │
├────────────────────────────────┤
│     Domain Layer               │  ← Business Logic, Entities
│   (modules/*/domain)           │
├────────────────────────────────┤
│     Infrastructure Layer       │  ← API Clients, Databases
│   (core/, modules/*/infrastructure) │
└────────────────────────────────┘
```

---

## 📐 Core Design Principles

### 1. **Dependency Inversion**
- Dependencies point **inward** (toward domain layer)
- Domain layer has **no external dependencies**
- Infrastructure implements domain interfaces

```dart
// ❌ Wrong: Domain depends on external library
class FieldEntity {
  final http.Client client; // BAD: Infrastructure leak
}

// ✅ Correct: Domain defines interface
class FieldEntity {
  final FieldRepository repository; // Domain interface
}
```

### 2. **Single Responsibility**
- Each class has **one reason to change**
- UI widgets don't fetch data
- Repositories don't format UI strings

### 3. **Open/Closed Principle**
- Open for **extension**, closed for **modification**
- Add features without changing existing code
- Use interfaces for flexibility

### 4. **Interface Segregation**
- Small, focused interfaces
- Clients don't depend on methods they don't use

### 5. **Offline-First**
- All data stored **locally first**
- Background sync manages cloud synchronization
- App remains functional without internet

---

## 🏛️ Clean Architecture Layers

### Presentation Layer (UI)

**Responsibility**: Display data, collect user input, handle navigation

**Location**: `lib/app/`, `lib/modules/*/presentation/`

**Contains**:
- **Pages** — Full-screen UI components
- **Widgets** — Reusable UI components
- **State Management** — Riverpod providers
- **Themes** — Colors, typography, styles

```dart
// Example: Page with Riverpod state management
class FieldCapturePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldState = ref.watch(fieldProvider);
    return fieldState.when(
      data: (field) => FieldCaptureForm(field: field),
      loading: () => LoadingWidget(),
      error: (err, st) => ErrorWidget(error: err),
    );
  }
}
```

### Application Layer (Use Cases)

**Responsibility**: Orchestrate business logic, manage state transitions

**Location**: `lib/modules/*/application/`

**Contains**:
- **Use Case Providers** — Riverpod providers exposing application logic
- **State Notifiers** — Complex state management logic
- **Mappers** — Convert between DTOs and entities
- **Validators** — Business rule validation

```dart
// Example: Use case provider
final saveFieldProvider = FutureProvider<void>((ref) async {
  final fieldRepository = ref.watch(fieldRepositoryProvider);
  final field = ref.watch(fieldFormProvider);
  
  // Validate
  if (!fieldValidator.isValid(field)) {
    throw ValidationException('Invalid field');
  }
  
  // Execute
  await fieldRepository.saveField(field);
});
```

### Domain Layer (Business Logic)

**Responsibility**: Define business rules, entities, and repository interfaces

**Location**: `lib/modules/*/domain/`

**Contains**:
- **Entities** — Core business objects
- **Repositories** — Interfaces for data access
- **Value Objects** — Strongly-typed values
- **Exceptions** — Domain-specific errors

```dart
// Example: Entity (immutable, business logic)
class FieldEntity extends Equatable {
  final String id;
  final String cropType;
  final double areaHectares;
  
  // Business logic
  bool isSufficientSize() => areaHectares >= 0.01;
  
  @override
  List<Object?> get props => [id, cropType, areaHectares];
}

// Example: Repository interface
abstract class FieldRepository {
  Future<FieldEntity> getField(String id);
  Future<void> saveField(FieldEntity field);
  Future<List<FieldEntity>> listFields();
}
```

### Infrastructure Layer (External Systems)

**Responsibility**: Implement external integrations (API, database, location)

**Location**: `lib/core/`, `lib/modules/*/infrastructure/`

**Contains**:
- **API Clients** — HTTP requests to backend
- **Local Data Sources** — SQLite, SharedPreferences
- **Repositories** — Implementation of domain interfaces
- **DTOs** — Network/database models

```dart
// Example: Repository implementation
class FieldRepositoryImpl implements FieldRepository {
  final FieldRemoteDataSource remote;
  final FieldLocalDataSource local;
  
  @override
  Future<FieldEntity> getField(String id) async {
    try {
      // Try remote first
      final dto = await remote.getField(id);
      final entity = FieldDTOMapper.toEntity(dto);
      // Cache locally
      await local.cacheField(entity);
      return entity;
    } on NetworkException {
      // Fallback to local
      final entity = await local.getField(id);
      return entity;
    }
  }
}
```

---

## 📁 Directory Structure

The project is organized into two primary service layers: **Frontend (Mobile)** and **Backend (API)**.

### 📱 Frontend (lib/)

```
frontend/lib/
├── main.dart                      # App entry point
├── app/
│   ├── app.dart                   # Root MaterialApp
│   ├── bootstrap.dart             # App initialization
│   ├── router.dart                # GoRouter configuration
│   └── app_lifecycle.dart         # Lifecycle management
├── config/
│   ├── app_config.dart            # Environment config (API URLs, etc.)
│   └── constants.dart             # App-wide constants
├── core/                          # Shared infrastructure
│   ├── exceptions/
│   │   └── app_exception.dart    # Exception hierarchy
│   ├── validators/
│   │   ├── field_validators.dart  # Field validation rules
│   │   └── ...
│   ├── network/
│   │   ├── dio_client.dart       # HTTP client configuration
│   │   └── api_response.dart     # Response wrapper
│   ├── di/
│   │   └── providers.dart        # Riverpod providers
│   └── ...
└── modules/                       # Feature modules
    ├── auth/                      # Authentication logic
    ├── field_capture/             # GPS & plot capture
    ├── traceability/              # Batch tracking
    └── sync/                      # Offline sync gateway
```

### 🛠️ Backend (app/)

```
backend/app/
├── api/                           # API Route handlers
│   ├── v1/                        # API versioning
│   │   ├── endpoints/             # Specific feature routes
│   │   └── api.py                 # Router aggregation
├── core/                          # Global configuration
│   ├── config.py                  # Environment variables
│   └── security.py                # JWT & Auth logic
├── crud/                          # CRUD operations (SQLAlchemy)
├── db/                            # Database sessions & PostGIS
├── models/                        # SQLAlchemy entities
├── schemas/                       # Pydantic DTOs
├── services/                      # Business logic & ML engine
└── tasks/                         # Celery background workers
```

│   │   │   │   └── login_form.dart
│   │   │   └── auth_providers.dart
│   │   └── auth_module.dart      # Module configuration
│   │
│   ├── field_capture/            # Similar structure
│   ├── traceability/             # Similar structure
│   ├── forecasts/                # Similar structure
│   └── sync/                     # Background sync module
├── test/
│   └── smoke_test.dart
└── pubspec.yaml
```

---

## 🔧 Core Infrastructure

### Exception Handling

**Location**: `lib/core/exceptions/app_exception.dart`

```dart
// Exception hierarchy
abstract class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

class ValidationException extends AppException {
  ValidationException(String message) : super(message);
}

class OfflineException extends AppException {
  OfflineException(String message) : super(message);
}
```

**Usage**:
```dart
try {
  await repository.fetchData();
} on NetworkException catch (e) {
  showErrorDialog('Network error: ${e.message}');
} on ValidationException catch (e) {
  showErrorDialog('Invalid input: ${e.message}');
} on AppException catch (e) {
  showErrorDialog('Error: ${e.message}');
}
```

### Validators

**Field Validation** (`lib/core/validators/field_validators.dart`):
```dart
class FieldValidators {
  // Field name: 2-100 characters
  static bool isValidFieldName(String name) {
    return name.length >= 2 && name.length <= 100;
  }
  
  // Area: 0.01 - 10000 hectares
  static bool isValidArea(double area) {
    return area >= 0.01 && area <= 10000;
  }
}
```

### Unit Converters

**Agri-Specific Unit Conversions** (`lib/core/extensions/num_extensions.dart`):
```dart
extension UnitConverter on num {
  // Hectares ↔ Acres
  double get ha2ac => this * 2.47105;
  double get ac2ha => this / 2.47105;
  
  // Kilograms ↔ Pounds
  double get kg2lbs => this * 2.20462;
  double get lbs2kg => this / 2.20462;
}
```

### Dependency Injection

**Riverpod Setup** (`lib/core/di/providers.dart`):
```dart
// Base providers
final dioProvider = Provider((ref) => DioClient().client);
final baseUrlProvider = Provider((ref) => AppConfig.apiBaseUrl);
final loggerProvider = Provider((ref) => Logger());

// Repository providers
final fieldRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return FieldRepositoryImpl(
    remote: FieldRemoteDataSourceImpl(dio),
    local: FieldLocalDataSourceImpl(),
  );
});
```

---

## 🎯 Feature Modules

Each feature follows the same structure:

```
modules/field_capture/
├── domain/               # Business logic
│   ├── entities/
│   │   └── field_record.dart
│   ├── repositories/
│   │   └── field_capture_repository.dart
│   └── exceptions/
│       └── field_exceptions.dart
├── data/                 # External systems
│   ├── datasources/
│   │   ├── field_capture_remote_data_source.dart
│   │   └── field_capture_local_data_source.dart
│   ├── repositories/
│   │   └── field_capture_repository_impl.dart
│   └── models/
│       └── field_record_dto.dart
├── presentation/         # UI
│   ├── pages/
│   │   └── field_capture_page.dart
│   ├── widgets/
│   │   ├── field_form.dart
│   │   └── gps_input.dart
│   └── field_capture_providers.dart
└── field_capture_module.dart
```

---

## 💉 Dependency Injection

### How to Register Dependencies

```dart
// In lib/core/di/providers.dart

final fieldRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return FieldRepositoryImpl(
    remote: FieldRemoteDataSourceImpl(dio),
    local: FieldLocalDataSourceImpl(),
  );
});
```

### How to Use Dependencies

```dart
class FieldCapturePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access dependency
    final repository = ref.watch(fieldRepositoryProvider);
    
    // Use in provider
    final fieldState = ref.watch(FutureProvider((ref) {
      return repository.getField('123');
    }));
    
    return Scaffold(
      body: fieldState.when(
        data: (field) => FieldForm(field: field),
        loading: () => LoadingWidget(),
        error: (err, st) => ErrorWidget(error: err),
      ),
    );
  }
}
```

---

## ⚠️ Error Handling

### Multi-Layer Error Handling

```dart
// Domain: Define exception
class FieldValidationException extends AppException {
  FieldValidationException(String message) : super(message);
}

// Infrastructure: Catch and convert
try {
  final dto = json.decode(response);
} on FormatException catch (_) {
  throw FieldValidationException('Invalid field data');
}

// Application: Wrap in state
final saveFieldProvider = FutureProvider((ref) async {
  try {
    await ref.watch(fieldRepositoryProvider).saveField(field);
  } on AppException catch (e) {
    throw e; // Let UI layer handle
  }
});

// Presentation: Display to user
final state = ref.watch(saveFieldProvider);
state.whenData((_) => showSuccess())
     .whenError((err, st) => showError(err));
```

---

## 🔄 State Management

### Using Riverpod

**Simple Provider**:
```dart
final nameProvider = StateProvider((ref) => '');
```

**Async Provider**:
```dart
final fieldProvider = FutureProvider.autoDispose((ref) {
  final repo = ref.watch(fieldRepositoryProvider);
  return repo.getField('123');
});
```

**State Notifier** (for complex logic):
```dart
class FieldFormNotifier extends StateNotifier<FieldForm> {
  FieldFormNotifier() : super(FieldForm.initial());
  
  void updateField(String value) {
    state = state.copyWith(fieldName: value);
  }
}

final fieldFormProvider = StateNotifierProvider((_) {
  return FieldFormNotifier();
});
```

---

## 🧪 Testing Strategy

### Testing Pyramid

```
         ⬢ E2E Tests (2%)
       ⬢⬢⬢ Integration Tests (8%)
     ⬢⬢⬢⬢⬢ Unit Tests (90%)
```

### Unit Testing

```dart
test('FieldEntity.isSufficientSize returns true for valid area', () {
  final field = FieldEntity(
    id: '1',
    cropType: 'maize',
    areaHectares: 1.5,
  );
  
  expect(field.isSufficientSize(), true);
});
```

### Mocking

```dart
// Create mock
final mockRepository = MockFieldRepository();

// Set up return value
when(mockRepository.getField('1')).thenAnswer(
  (_) async => FieldEntity(id: '1', cropType: 'maize', areaHectares: 1.0),
);

// Use in test
expect(await mockRepository.getField('1'), isNotNull);
```

---

## 📱 Offline-First Architecture

### Data Flow

```
┌─────────────────────────────────────────────┐
│          User Action (Save Field)           │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
         ┌──────────────────────┐
         │   Validate Input     │
         │  (Field Validators)  │
         └──────────┬───────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │  Save to Local DB    │
         │    (SQLite)          │
         └──────────┬───────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │ Queue for Sync       │
         │ (Sync Queue Service) │
         └──────────┬───────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │ Network Available?   │
         └────────┬─────────────┘
                  │
          ┌───────┴────────┐
          ▼                ▼
    YES: Sync         NO: Wait
      to Cloud      (Retry later)
```

### Implementation

```dart
// Save field (offline-first)
Future<void> saveField(FieldEntity field) async {
  // 1. Validate
  if (!FieldValidators.isValidField(field)) {
    throw ValidationException('Invalid field');
  }
  
  // 2. Save locally
  await localDataSource.saveField(field);
  
  // 3. Queue for sync
  await syncQueueService.queueFieldSave(field);
  
  // 4. Sync if online
  if (await connectivity.isConnected()) {
    await syncCoordinator.syncPending();
  }
}
```

---

## ✅ Best Practices

### DO ✅

- ✅ Keep business logic in **domain layer**
- ✅ Use **interfaces for abstraction**
- ✅ Inject **dependencies** via constructors
- ✅ Write **unit tests** for business logic
- ✅ Use **enums** for fixed value sets
- ✅ **Validate input** before processing
- ✅ Log **errors** appropriately
- ✅ Use **immutable** data structures

### DON'T ❌

- ❌ UI logic in widgets (move to Riverpod providers)
- ❌ Direct API calls from UI
- ❌ Global mutable state
- ❌ Tight coupling between layers
- ❌ Silent error catching
- ❌ Hardcoded values
- ❌ Overly complex widget trees

---

## �� Common Patterns

### Pattern: Loading State

```dart
final dataProvider = FutureProvider((ref) async {
  return await repository.fetchData();
});

// In widget:
final state = ref.watch(dataProvider);
state.when(
  loading: () => LoadingWidget(),
  data: (data) => DataWidget(data: data),
  error: (err, st) => ErrorWidget(error: err),
);
```

### Pattern: Form State

```dart
class FormNotifier extends StateNotifier<FormState> {
  FormNotifier() : super(FormState.initial());
  
  void updateField(String name, dynamic value) {
    state = state.copyWith(fields: {...state.fields, name: value});
  }
  
  Future<void> submit() async {
    state = state.copyWith(isLoading: true);
    try {
      await repository.saveForm(state);
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
```

### Pattern: Auto-Retry

```dart
Future<T> retryAsync<T>(
  Future<T> Function() fn, {
  int maxAttempts = 3,
  Duration delay = const Duration(seconds: 1),
}) async {
  for (int attempt = 1; attempt <= maxAttempts; attempt++) {
    try {
      return await fn();
    } catch (e) {
      if (attempt == maxAttempts) rethrow;
      await Future.delayed(delay * attempt);
    }
  }
}
```

---

## 🛡️ Security & Privacy Posture

FarmerHub Core handles sensitive agricultural and geospatial data. Our security model is built on **Zero Trust** principles.

### 1. Data Encryption
*   **At Rest (On-Device)**: SQLite databases are encrypted using **SQLCipher** (256-bit AES) to prevent unauthorized access if a device is stolen.
*   **At Rest (Cloud)**: PostgreSQL data volumes use AWS/Azure native disk encryption.
*   **In Transit**: All API communication is enforced via **TLS 1.3**. Self-signed certificates are strictly rejected in production.

### 2. Identity & Access Management (IAM)
*   **Authentication**: OAuth 2.0 with JWT. Tokens have a short TTL (1 hour) with secure Refresh Token rotation.
*   **RBAC**: Granular permissions ensure a Field Agent cannot view financial data intended for a Cooperative Manager.
*   **Device Binding**: Authorized devices must be registered with the organization's tenant to prevent rogue API access.

### 3. Privacy & Compliance
*   **Data Minimization**: We only capture coordinates necessary for plot boundary verification.
*   **Right to be Forgotten**: Standardized procedures for farmers to request deletion of their plot data, compliant with the **Uganda Data Protection and Privacy Act**.
*   **Geo-Fencing**: API requests are validated against known regional IP ranges to detect and block suspicious cross-border access attempts.

---

## 🔍 Troubleshooting

### Issue: Circular dependency between layers

**Solution**: Ensure dependencies only point inward. Domain → Never depends on anything. Data → Only depends on domain. Presentation → Depends on app, config, core.

### Issue: Provider not updating

**Solution**: Ensure you're using `.watch()` not `.read()` in build methods. `.read()` only accesses current value, doesn't listen for changes.

### Issue: Too many rebuilds

**Solution**: Use `.select()` to watch only the fields you need:
```dart
final name = ref.watch(formProvider.select((f) => f.name));
```

---

**✅ Architecture Complete!** This structure scales from MVP to production. 🚀

---

**Next: [04 Development Setup](./04_Development_Setup.md)**

