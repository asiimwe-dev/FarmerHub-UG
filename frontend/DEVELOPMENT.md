# Development Setup Guide

Complete step-by-step guide for setting up your development environment.

## Quick Start (5 minutes)

```bash
# 1. Clone
git clone https://github.com/asiimwe-dev/FarmLink-UG.git
cd FarmLink-UG/frontend

# 2. Install
flutter pub get

# 3. Verify
flutter analyze
flutter test

# 4. Run
flutter run
```

## Detailed Setup

### 1. Install Flutter

**macOS**:
```bash
# Using Homebrew
brew install flutter

# Verify
flutter --version
```

**Windows** (CMD):
```powershell
# Download from https://flutter.dev/docs/get-started/install/windows
# Extract and add to PATH
flutter --version
```

**Linux**:
```bash
# Download from https://flutter.dev/docs/get-started/install/linux
# Extract and update PATH
flutter --version
```

### 2. Verify Prerequisites

```bash
flutter doctor

# Should show:
# ✓ Flutter (version X.X.X)
# ✓ Android toolchain
# ✓ Xcode (if on macOS)
# ✓ VS Code / Android Studio with Flutter extension
```

### 3. Clone Repository

```bash
git clone https://github.com/asiimwe-dev/FarmLink-UG.git
cd FarmLink-UG/frontend
```

### 4. Install Dependencies

```bash
flutter pub get
```

### 5. Code Generation (if needed)

```bash
# For DTOs with JSON serialization
flutter pub run build_runner build --delete-conflicting-outputs
```

### 6. Verify Setup

```bash
flutter analyze              # 0 issues expected
flutter test                 # All tests pass
flutter build apk --debug    # Compiles successfully
```

---

## IDE Setup

### VS Code

1. **Install extensions**:
   - Flutter
   - Dart
   - Riverpod (optional, for snippets)

2. **Configure**:
   - `.vscode/settings.json`:
     ```json
     {
       "dart.flutterSdkPath": "/path/to/flutter",
       "[dart]": {
         "editor.formatOnSave": true,
         "editor.defaultFormatter": "Dart-Code.dart-code"
       }
     }
     ```

3. **Keyboard shortcuts** (optional):
   - Cmd+Shift+P → "Format Document" for manual format

### Android Studio / IntelliJ

1. **Install plugins**:
   - Preferences → Plugins
   - Search "Flutter", "Dart"
   - Install and restart

2. **Configure**:
   - Settings → Languages & Frameworks → Dart
   - Enable "Format code on save"

---

## Running the App

### Debug Mode

```bash
flutter run
```

Then interact via console:
- `r` — Hot reload (fast, preserves state)
- `R` — Full restart (slower, clears state)
- `q` — Quit

### Release Mode

```bash
flutter run --release
```

Faster but no hot reload. For performance testing.

### Run on Specific Device

```bash
flutter devices                    # List available
flutter run -d emulator-5554       # Run on specific device
flutter run -d chrome              # Web (debug only)
```

### Build Variant

```bash
flutter run --debug       # Debug
flutter run --release     # Release (optimized)
flutter run --profile     # Profile (performance data)
```

---

## Emulator Setup

### Android Emulator

```bash
# List available AVDs
flutter emulators

# Create new (via Android Studio)
# Settings → Virtual Device Manager → Create Device

# Launch emulator
flutter emulators --launch Pixel_5_API_30
```

### iOS Simulator (macOS only)

```bash
# Open Simulator
open -a Simulator

# List available
xcrun simctl list devices

# Launch simulator
xcrun simctl boot 'iPhone 14'
```

---

## Debugging

### Print Debug Info

```dart
print('Debug: $variable');  // Console output
debugPrint('Debug: $variable');  // Avoids console truncation
```

### Use Logger

```dart
import 'package:farmer_hub_ug/core/utils/logger.dart';

logger.i('Info message');
logger.w('Warning message');
logger.e('Error message');
```

### Flutter DevTools

```bash
flutter pub global activate devtools
devtools

# Or integrated in IDE:
flutter run
# Press 'v' for DevTools URL
```

In DevTools:
- **Console** — Print statements, logs
- **Performance** — Frame rendering
- **Memory** — Heap and memory leaks
- **Network** — HTTP requests
- **Inspector** — Widget tree, element state

---

## Testing Workflow

### Run All Tests

```bash
flutter test
```

### Run Specific File

```bash
flutter test test/domain/entities/field_record_test.dart
```

### Run with Coverage

```bash
flutter test --coverage
lcov --list coverage/lcov.info  # View coverage report
```

### Watch Mode (on file change)

```bash
flutter test --watch
```

---

## Code Quality Checks

### Format Code

```bash
dart format lib/
dart format test/
```

### Static Analysis

```bash
flutter analyze
```

Should show 0 issues. If not:
- Check the error message
- Review `analysis_options.yaml` for rules
- Use `// ignore: rule_name` for deliberate violations

### Linting

```bash
dart analyze --fatal-infos  # Treat warnings as errors
```

---

## Database & Local Storage

### SQLite Setup (TODO)

Once SQLite is integrated:

```bash
# Generate migration files
sqlite3 frontend/data/farmerhub.db

# View schema
.schema
.tables
```

### Manual Database Reset

```dart
// In development code
await deleteDatabase(dbPath);  // Clears all local data
```

---

## Environment Configuration

### Create .env File

```bash
# frontend/.env
FLAVOR=dev
API_BASE_URL=http://localhost:8000/api
DEBUG=true
LOG_LEVEL=debug
```

### Load from Code

Update `lib/config/app_config.dart`:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiBaseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000/api';
  }
}
```

Then load in `main.dart`:

```dart
await dotenv.load(fileName: '.env');
```

---

## Common Issues & Solutions

### Issue: "CocoaPods dependency conflict"

**Solution**:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

### Issue: "Gradle build failed"

**Solution**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Issue: "Unable to find devices"

**Solution**:
```bash
flutter doctor                    # Check adb/xcode
flutter emulators --launch <name>  # Launch emulator
adb devices                        # Verify connection
```

### Issue: "Hot reload not working"

**Solution**:
```bash
# Full restart instead
press R in console

# Or restart entirely
flutter run
```

### Issue: "Riverpod provider not updating"

**Solution**:
```dart
// Make sure you're WATCHING, not READING
final data = ref.watch(myProvider);  // ✅ Correct
// final data = ref.read(myProvider);  // ❌ Won't update
```

---

## Performance Profiling

### Check Frame Rate

```bash
flutter run
# Press 'p' to show performance overlay
```

### Memory Profiling

```bash
flutter run
# In DevTools → Memory tab
# Take snapshots and analyze heap
```

### CPU Profiling

```bash
flutter run --profile
# In DevTools → Performance tab
# Record and analyze CPU usage
```

---

## Useful Commands Reference

```bash
# Project management
flutter pub get              # Install dependencies
flutter pub upgrade          # Upgrade dependencies
flutter pub outdated         # Check outdated packages
flutter pub cache clean      # Clear pub cache

# Build & run
flutter run                  # Run debug
flutter run --release        # Run release
flutter build apk            # Build APK
flutter build ipa            # Build iOS

# Testing & quality
flutter test                 # Run tests
flutter analyze              # Static analysis
dart format lib/             # Format code

# Debugging
flutter logs                 # Stream device logs
flutter devices              # List connected devices
flutter clean                # Clean build artifacts

# Documentation
flutter doctor               # Diagnose environment
dart doc                     # Generate API docs
```

---

## Next Steps

1. ✅ Setup complete
2. 📖 Read `README.md` for project overview
3. 🏗️ Read `lib/ARCHITECTURE.md` for code structure
4. 🧪 Run `flutter test` to verify
5. 💻 Start coding!

---

**Need help?** Check [Flutter Docs](https://flutter.dev/docs) or open an issue on GitHub.
