# ⚡ Quick Reference Guide

**Fast Lookup for Common Development Tasks in FarmCom Core**

> 🚀 Quick answers to development questions. For detailed information, see linked documentation.

**Last Updated**: May 2026 | **Status**: ✅ Always Updated | **Audience**: Developers

---

## 📋 Table of Contents

1. [Common Commands](#common-commands)
2. [Where to Put Code](#where-to-put-code)
3. [Adding a New Feature](#adding-a-new-feature)
4. [Directory Tree](#directory-tree)
5. [Project Shortcuts](#project-shortcuts)
6. [Git Commands](#git-commands)
7. [Troubleshooting Quick Fixes](#troubleshooting-quick-fixes)
8. [Code Snippets](#code-snippets)
9. [File Templates](#file-templates)
10. [Keyboard Shortcuts](#keyboard-shortcuts)
11. [Testing Checklists](#testing-checklists)
12. [PR Checklist](#pr-checklist)

---

## 🔧 Common Commands

| Task | Command |
|------|---------|
| **Install dependencies** | `flutter pub get` |
| **Run app** | `flutter run` |
| **Analyze code** | `flutter analyze` |
| **Run tests** | `flutter test` |
| **Format code** | `dart format .` |
| **Hot reload** | Press `r` in terminal |
| **Hot restart** | Press `R` in terminal |
| **Build APK** | `flutter build apk --release` |
| **Build iOS** | `flutter build ios --release` |
| **Clear cache** | `flutter clean` |
| **Get specific package** | `flutter pub get package_name` |

---

## 📁 Where to Put Code

### Location by Type

| Code Type | Location | Example |
|-----------|----------|---------|
| **Entity** (business logic) | `modules/*/domain/entities/` | `field_entity.dart` |
| **Repository Interface** | `modules/*/domain/repositories/` | `field_repository.dart` |
| **Use Case/Provider** | `modules/*/application/` | `field_providers.dart` |
| **DTO/Model** | `modules/*/data/models/` | `field_dto.dart` |
| **Data Source** | `modules/*/data/datasources/` | `field_remote_data_source.dart` |
| **Repository Impl** | `modules/*/data/repositories/` | `field_repository_impl.dart` |
| **Page/Screen** | `modules/*/presentation/pages/` | `field_capture_page.dart` |
| **Widget** | `modules/*/presentation/widgets/` | `field_form.dart` |
| **Provider** | `modules/*/` or `core/di/` | `field_providers.dart` |
| **Configuration** | `config/` | `constants.dart`, `app_config.dart` |
| **Exception** | `core/exceptions/` | `app_exception.dart` |
| **Validator** | `core/validators/` | `field_validators.dart` |
| **Extension** | `core/extensions/` | `num_extensions.dart` |
| **Shared Widget** | `core/widgets/` | `loading_state.dart` |

---

## 🎯 Adding a New Feature

### Module Structure

```bash
mkdir -p lib/modules/your_feature/{domain,data,presentation}
```

### Files to Create (In Order)

1. **Entity** → `domain/entities/your_entity.dart`
2. **Repository Interface** → `domain/repositories/your_repository.dart`
3. **DTO** → `data/models/your_dto.dart`
4. **Implementation** → `data/repositories/your_repository_impl.dart`
5. **Provider** → `presentation/your_providers.dart`
6. **Page** → `presentation/pages/your_page.dart`

### Add Route

Edit `lib/app/router.dart` and add your route.

---

## 📂 Directory Tree

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── bootstrap.dart
│   └── router.dart
├── config/
│   ├── app_config.dart
│   └── constants.dart
├── core/
│   ├── exceptions/
│   ├── validators/
│   ├── extensions/
│   ├── network/
│   ├── di/
│   ├── theme/
│   └── widgets/
└── modules/
    ├── auth/
    ├── field_capture/
    ├── traceability/
    └── forecasts/
```

---

## 🎹 Project Shortcuts

### VS Code

| Shortcut | Action |
|----------|--------|
| `Cmd+Shift+P` or `Ctrl+Shift+P` | Command Palette |
| `Cmd+Shift+F` or `Ctrl+Shift+F` | Find in files |
| `Cmd+G` or `Ctrl+G` | Go to line |
| `Cmd+B` or `Ctrl+B` | Toggle sidebar |
| `Cmd+J` or `Ctrl+J` | Toggle terminal |

### Flutter

| Key | Action |
|-----|--------|
| `r` | Hot reload |
| `R` | Hot restart |
| `q` | Quit |
| `h` | Help menu |
| `w` | Widget tree |

---

## 📝 Git Commands

| Task | Command |
|------|---------|
| **Create branch** | `git checkout -b feature/name` |
| **Switch branch** | `git checkout main` |
| **Add changes** | `git add .` |
| **Commit** | `git commit -m "message"` |
| **Push** | `git push origin feature/name` |
| **Fetch updates** | `git fetch upstream` |
| **Rebase** | `git rebase upstream/main` |
| **View commits** | `git log --oneline` |

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| `flutter not found` | Add Flutter to PATH (see SETUP.md) |
| `No connected devices` | Start emulator or connect device |
| `Gradle failed` | `flutter clean && flutter pub get` |
| `Xcode failed` | `flutter clean` then retry |
| `Tests failing` | Run `flutter test` for details |
| `Analysis errors` | Run `flutter analyze` |
| `Hot reload not working` | Try `R` for hot restart |

---

## 💡 Code Snippets

### Basic Provider
```dart
final nameProvider = StateProvider((ref) => '');
```

### Async Provider
```dart
final dataProvider = FutureProvider((ref) async {
  return await repository.getData();
});
```

### Error Handling
```dart
try {
  await operation();
} on ValidationException catch (e) {
  logger.e('Validation error: $e');
} on NetworkException catch (e) {
  logger.e('Network error: $e');
}
```

---

## ✅ PR Checklist

Before submitting PR:

- ✅ All tests pass: `flutter test`
- ✅ No analysis errors: `flutter analyze`
- ✅ Code formatted: `dart format`
- ✅ Commits follow conventional format
- ✅ PR description explains "what" and "why"
- ✅ Related issues linked
- ✅ Documentation updated if needed

---

**Need more details?** Check [ARCHITECTURE.md](./ARCHITECTURE.md) or [SETUP.md](./SETUP.md)
