# Quick Reference - Farmer Hub UG Developer Guide

## 🚀 Start Developing in 5 Minutes

```bash
# Clone
git clone https://github.com/asiimwe-dev/FarmLink-UG.git
cd FarmLink-UG/frontend

# Setup
flutter pub get
flutter analyze  # Should show 0 issues
flutter test     # All tests pass

# Run
flutter run
```

---

## 📁 Where to Put Code

| What | Where | Example |
|------|-------|---------|
| App shell & routing | `lib/app/` | `router.dart` |
| Config & constants | `lib/config/` | `constants.dart` |
| Shared utilities | `lib/core/` | `validators/`, `extensions/` |
| Feature code | `lib/modules/<feature>/` | `field_capture/` |
| Business logic | `domain/` (in module) | `usecases/`, `entities/` |
| Data & API | `data/` (in module) | `repositories/`, `datasources/` |
| UI & widgets | `presentation/` (in module) | `pages/`, `widgets/` |
| Tests | `test/` | `domain/`, `data/`, `presentation/` |

---

## 💡 Common Workflows

### Adding a New Page

```dart
// 1. Create page file
lib/modules/my_feature/presentation/pages/my_page.dart

// 2. Build ConsumerWidget
class MyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('My Page')),
      body: /* Your UI */,
    );
  }
}

// 3. Add route in app/router.dart
GoRoute(
  path: '/my-feature',
  builder: (context, state) => MyPage(),
)

// 4. Done!
```

### Validating Form Input

```dart
// In form field
TextFormField(
  validator: FieldValidators.validateFieldName,
  // Or custom validator
  validator: (value) => value?.isEmpty == true ? 'Required' : null,
)
```

### Handling Errors

```dart
try {
  await repository.fetchData();
} on ValidationException catch (e) {
  showInlineError(e.message);  // ← For form validation
} on NetworkException catch (e) {
  showSnackBar(e.message);     // ← For API failures
} on OfflineException {
  showOfflineBanner();          // ← For no connectivity
}
```

### Using Riverpod State

```dart
// Define provider
final myDataProvider = FutureProvider((ref) async {
  final repo = ref.watch(myRepositoryProvider);
  return repo.fetchData();
});

// Use in widget
final data = ref.watch(myDataProvider);
data.when(
  data: (value) => Text(value.toString()),
  loading: () => LoadingState(),
  error: (err, st) => ErrorState(err.toString()),
);
```

### Writing Tests

```dart
test('validates field area', () {
  expect(
    () => FieldValidators.validateArea('-5'),
    throwsA(isA<ValidationException>()),
  );
});
```

---

## 🔍 Code Quality

**Before committing:**

```bash
dart format .              # Format code
flutter analyze            # Check for issues (must be 0)
flutter test               # Run tests (all pass)
```

**Commit message format:**

```
feat(module-name): Brief description

Optional longer explanation of why and what changed.

Fixes #123
```

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| `README.md` (frontend) | Complete developer guide with TOC |
| `DEVELOPMENT.md` | Step-by-step setup and environment |
| `lib/ARCHITECTURE.md` | Code structure and patterns |
| `docs/CONTRIBUTING.md` | Code of conduct & PR process |
| `docs/PROJECT_OVERVIEW.md` | Business vision & strategy |

---

## ⚡ Keyboard Shortcuts

| Action | Key |
|--------|-----|
| Hot reload (preserve state) | `r` (in flutter run) |
| Full restart (clear state) | `R` (in flutter run) |
| Quit | `q` (in flutter run) |
| Format document | Cmd/Ctrl + Shift + F |
| Run test | Cmd/Ctrl + Shift + T |
| Go to definition | Cmd/Ctrl + Click |
| Find references | Cmd/Ctrl + Shift + R |

---

## 🐛 Debugging

```dart
// Print to console
print('Debug: $value');
debugPrint('Debug: $value');  // Avoids truncation

// Use logger
import 'package:farmer_hub_ug/core/utils/logger.dart';
logger.i('Info');
logger.w('Warning');
logger.e('Error');
```

**Open DevTools:**
```bash
flutter run
# Then press 'v' for DevTools URL
```

---

## 📦 Common Dependencies

- **riverpod** — State management & DI
- **go_router** — Routing and navigation
- **dio** — HTTP client for API calls
- **connectivity_plus** — Detect online/offline
- **logger** — Pretty debug logging
- **equatable** — Value equality
- **intl** — Date/time formatting

---

## 🚦 PR Checklist

Before submitting:

- [ ] Code follows architecture pattern
- [ ] Tests written and passing
- [ ] `flutter analyze` shows 0 issues
- [ ] `dart format` applied
- [ ] Documentation updated
- [ ] Commit messages are clear
- [ ] No hardcoded strings (use constants)
- [ ] Errors handled appropriately

---

## 📞 Getting Help

- 📖 Read docs: `README.md`, `ARCHITECTURE.md`
- 💬 GitHub Issues or Discussions
- 🤝 Ask in PR reviews
- 📧 Email maintainers

---

## 🎯 Development Tips

✅ **Do:**
- Keep functions small and testable
- Use constants instead of magic numbers
- Handle both happy path and error cases
- Write tests alongside code
- Update docs when changing behavior

❌ **Don't:**
- Mix UI code with business logic
- Ignore errors silently
- Commit credentials or secrets
- Use `var` without good reason
- Skip tests for "simple" code

---

**Ready to code? Start with `frontend/README.md` for full guide!**
