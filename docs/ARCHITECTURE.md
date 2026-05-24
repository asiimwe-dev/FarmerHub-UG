# Farmer Hub UG - Professional Codebase Architecture

## Overview
This is a **professional-grade, production-ready Flutter codebase** for FarmCom Core, an offline-first agri-intelligence platform for cooperatives, exporters, and field teams.

## Core Design Principles
- **Clean Architecture** - Strict separation between domain (business logic), data (API/local storage), and presentation (UI)
- **Offline-First** - All data is stored locally; sync service manages cloud synchronization
- **Lean & Focused** - Only capabilities needed for agri-intelligence; no cruft from previous features
- **Enterprise Patterns** - Proper error handling, validation, dependency injection, logging

---

## Directory Structure

### 📁 `config/` - Application Configuration
Global app settings that vary by environment (dev/staging/prod).

```
config/
├── app_config.dart       # Environment-specific URLs, debug flags
└── constants.dart        # Timeouts, validation rules, field constraints, sync settings
```

**Usage**: Import when you need API endpoints, app strings, validation rules.
```dart
import 'package:farmer_hub_ug/config/constants.dart';
// Use: AppConstants.maxFieldAreaHectares, AppConstants.networkTimeout
```

---

### 📁 `core/` - Shared Infrastructure
Cross-cutting concerns used by all modules.

#### `core/exceptions/`
Centralized error handling hierarchy. Every error in the app is a subclass of `AppException`.

```
exceptions/
└── app_exception.dart    # AppException (base), NetworkException, ValidationException, OfflineException, SyncException
```

**Usage**:
```dart
try {
  await repository.fetchData();
} on NetworkException catch (e) {
  // Handle network errors
} on OfflineException catch (e) {
  // Handle offline errors
}
```

#### `core/extensions/`
Utility extensions on built-in Dart types. Domain-specific operations like unit conversions.

```
extensions/
├── string_extensions.dart       # capitalize(), isValidEmail(), truncate()
├── date_time_extensions.dart    # formatDate(), timeAgo(), isToday()
└── num_extensions.dart          # kg2lbs(), ha2ac(), roundTo() — agricultural conversions
```

**Usage**:
```dart
final kg = 50;
final pounds = kg.kg2lbs();  // 110.231
final area = 2.5.ha2ac();    // 6.177525
```

#### `core/validators/`
Domain-specific validation rules for forms and data entry.

```
validators/
├── field_validators.dart        # validateFieldName(), validateArea(), validateCoordinates()
├── crop_validators.dart         # validateCropType(), validatePlantingDate()
└── measurement_validators.dart  # validateYield(), validateYieldUnit()
```

**Usage** (in form widgets):
```dart
TextFormField(
  validator: FieldValidators.validateFieldName,
  // ...
)
```

#### `core/network/`
HTTP client setup and response handling. Centralized for all API communication.

```
network/
├── dio_client.dart           # Dio setup with timeouts, interceptors, logging
├── api_response.dart         # Generic response wrapper: ApiResponse<T>
├── request_interceptor.dart  # Add auth tokens, headers (TBD)
└── response_interceptor.dart # Handle errors, offline detection (TBD)
```

**Usage** (injected via Riverpod):
```dart
final apiProvider = Provider((ref) => ref.watch(dioProvider));
```

#### `core/di/`
Dependency injection using Riverpod. All singletons and factories defined here.

```
di/
└── providers.dart  # dioProvider, baseUrlProvider, loggerProvider
```

**Usage**:
```dart
final httpClient = ref.watch(dioProvider);
```

#### `core/mappers/`
Converters between DTOs (data layer) and Entities (domain layer).

```
mappers/
└── dto_entity_mapper.dart  # Base Mapper<DTO, Entity> interface
```

**Usage** (implement per feature):
```dart
class FieldRecordMapper extends Mapper<FieldRecordDTO, FieldRecordEntity> {
  @override
  FieldRecordEntity toDomain(FieldRecordDTO dto) => FieldRecordEntity(...);
  
  @override
  FieldRecordDTO toDTO(FieldRecordEntity entity) => FieldRecordDTO(...);
}
```

#### `core/theme/`
Theming system (colors, typography, Material 3 design).

```
theme/
├── app_colors.dart      # Color palette, dark mode variants
├── app_theme.dart       # ThemeData builder, elevation, shadows
└── app_typography.dart  # Text styles, font scales
```

#### `core/utils/`
Utility helpers: logging, date formatting, etc.

```
utils/
└── logger.dart  # Production-filtered logger with pretty printing
```

#### `core/widgets/`
Shared UI components used across screens.

```
widgets/
├── app_scaffold.dart     # Main scaffold with bottom nav
├── error_state.dart      # Error display widget
├── loading_state.dart    # Loading spinner widget
└── (form_widgets.dart)   # TBD: Input fields, buttons, cards
```

---

### 📁 `app/` - Application Shell
The app entry point, routing, and bootstrap.

```
app/
├── bootstrap.dart  # Initialize Riverpod, connectivity, logging
├── app.dart        # MaterialApp setup, theme provider
└── router.dart     # GoRouter configuration with ShellRoute for navigation bar
```

---

### 📁 `modules/` - Feature Modules
Each module follows **Clean Architecture** with three layers:

```
modules/
├── auth/                    # User authentication
├── field_capture/          # Core feature: offline field plot entry
├── forecasts/              # Yield predictions display
├── sync/                   # Background sync orchestration
└── traceability/           # Batch provenance tracking
```

Each module has:
- **`data/`** - Remote/local data sources, DTOs, repositories
- **`domain/`** - Business entities, abstract repositories, use cases
- **`presentation/`** - Pages, widgets, Riverpod state providers
- **`infrastructure/`** (optional) - Special infrastructure just for this module

#### Example: `field_capture/` Module Structure

```
field_capture/
├── data/
│   ├── models/                              # DTOs (JSON serialization)
│   │   └── field_record_dto.dart
│   ├── datasources/
│   │   ├── local_field_capture_datasource.dart  # SQLite access
│   │   └── remote_field_capture_datasource.dart # API access (TBD)
│   └── repositories/
│       └── field_capture_repository_impl.dart   # Data layer implementation
├── domain/
│   ├── entities/
│   │   └── field_record_entity.dart         # Pure business object
│   ├── repositories/
│   │   └── field_capture_repository.dart    # Abstract contract
│   └── usecases/
│       └── save_field_record_usecase.dart   # Business logic
├── presentation/
│   ├── pages/
│   │   └── field_capture_page.dart          # Main screen
│   ├── widgets/
│   │   └── field_record_form.dart           # Form component
│   └── providers/
│       └── field_capture_providers.dart     # Riverpod state management
└── field_capture.dart                       # Barrel export
```

**Data Flow**:
```
UI (presentation) 
  → Use Case (domain) 
  → Repository (data)
  → Local/Remote DataSource
  → SQLite / HTTP
```

---

## Dependency Injection (Riverpod)

All dependencies defined in `core/di/providers.dart`:

```dart
final dioProvider = Provider<Dio>(...);           // HTTP client
final baseUrlProvider = Provider<String>(...);    // API base URL
final loggerProvider = Provider(...);             // Logger instance
```

**Per-module providers** go in `modules/<feature>/<feature>_providers.dart`:

```dart
// In field_capture_providers.dart
final fieldCaptureRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return FieldCaptureRepositoryImpl(dio: dio);
});

final saveFieldRecordProvider = FutureProvider((ref) async {
  final repo = ref.watch(fieldCaptureRepositoryProvider);
  return repo.saveFieldRecord(...);
});
```

**In widgets**:
```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(myDataProvider);
    // ...
  }
}
```

---

## Error Handling

All errors inherit from `AppException`. Catch specific exception types:

```dart
try {
  await repository.sync();
} on OfflineException {
  // Show offline banner
} on NetworkException catch (e) {
  // Show error snackbar with message
} on ValidationException catch (e) {
  // Show validation error inline
} on SyncException catch (e) {
  // Retry with backoff
}
```

---

## Validation

Use validators from `core/validators/` before saving data:

```dart
// In form
final error = FieldValidators.validateFieldName(nameController.text);
if (error != null) {
  // Show error
}

// Before API call
CropValidators.validateCropType(cropType); // Throws ValidationException if invalid
```

---

## Testing

Each layer can be tested independently:

```
test/
├── domain/                      # Unit tests for usecases, entities
├── data/                        # Unit tests for repositories, mappers
└── presentation/                # Widget/integration tests
```

**Example: Test a usecase**
```dart
test('SaveFieldRecordUsecase should persist to repository', () async {
  final mockRepo = MockFieldCaptureRepository();
  final usecase = SaveFieldRecordUsecase(mockRepo);
  
  await usecase(fieldRecord);
  
  verify(mockRepo.save(fieldRecord)).called(1);
});
```

---

## Adding a New Feature

1. **Create module folder**: `modules/my_feature/`
2. **Define domain layer**: entities, abstract repositories, usecases
3. **Implement data layer**: DTOs, datasources, repository implementation
4. **Add presentation**: pages, widgets, Riverpod providers
5. **Inject into router**: Add route in `app/router.dart`
6. **Wire up DI**: Add providers to `my_feature_providers.dart`

---

## Best Practices

✅ **DO:**
- Use exceptions for errors (don't return null)
- Validate input in usecases before calling repository
- Keep business logic in domain layer (testable, reusable)
- Use barrel exports (`feature.dart`) to hide internal structure
- Run `flutter analyze` before committing

❌ **DON'T:**
- Direct API calls from UI (go through repository)
- Business logic in widgets (move to usecases)
- Hardcoded strings (use `constants.dart`)
- Mixed concerns (e.g., sync + field capture in one class)

---

## Quick Links

- **Config**: `config/` — App constants, environment settings
- **Errors**: `core/exceptions/` — Exception hierarchy
- **Validators**: `core/validators/` — Input validation rules
- **Network**: `core/network/` — HTTP client setup
- **DI**: `core/di/providers.dart` — Dependency injection
- **Routing**: `app/router.dart` — Navigation configuration
- **Modules**: `modules/` — Feature implementations

