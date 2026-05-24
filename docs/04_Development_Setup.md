# 🚀 Farmer Hub UG - Development Setup Guide

**Professional Development Environment Configuration for FarmCom Core**

> 📖 Complete guide to setting up your development environment, installing dependencies, and running the FarmCom Core mobile application for the first time.

**Last Updated**: May 2026 | **Status**: ✅ Production Ready | **Audience**: Developers, Contributors

---

## 📋 Table of Contents

1. [Quick Start (5 Minutes)](#quick-start-5-minutes)
2. [Prerequisites & System Requirements](#prerequisites--system-requirements)
3. [Operating System Setup](#operating-system-setup)
4. [Flutter Installation](#flutter-installation)
5. [IDE & Editor Configuration](#ide--editor-configuration)
6. [Project Repository Setup](#project-repository-setup)
7. [Emulator & Simulator Setup](#emulator--simulator-setup)
8. [Running Your First Build](#running-your-first-build)
9. [Development & Debugging](#development--debugging)
10. [Troubleshooting Common Issues](#troubleshooting-common-issues)
11. [Performance Tips](#performance-tips)
12. [Next Steps After Setup](#next-steps-after-setup)
13. [Getting Help](#getting-help)

---

## ⚡ Quick Start (5 Minutes)

For experienced developers with Flutter already installed:

```bash
# Clone repository
git clone https://github.com/asiimwe-dev/FarmerHub-UG.git
cd FarmerHub-UG/frontend

# Install dependencies
flutter pub get

# Run application
flutter run

# Hot reload shortcuts
# Press 'r' for hot reload (fast)
# Press 'R' for hot restart (full rebuild)
```

**⏱️ Expected Time**: 5-10 minutes

---

## ✅ Prerequisites & System Requirements

### Minimum Requirements

| Requirement | Version | Notes |
|-------------|---------|-------|
| **Flutter SDK** | 3.13.0 or higher | [Download](https://flutter.dev/docs/get-started/install) |
| **Dart SDK** | 3.1.0 or higher | Included with Flutter |
| **Git** | 2.30+ | For version control |
| **RAM** | 8 GB minimum | 16 GB recommended for emulator |
| **Disk Space** | 5 GB available | For SDK, dependencies, and caches |
| **Operating System** | macOS 10.15+, Windows 10+, Ubuntu 18.04+ | Any modern OS |

### Device/Emulator

- **Physical Device**: Android 5.0+ or iOS 12+
- **Android Emulator**: API 21+ recommended
- **iOS Simulator**: Xcode 13+

### Verify Installation

```bash
# Check Flutter version
flutter --version

# Check Dart version
dart --version

# Run diagnostics
flutter doctor

# Expected output: 
# ✓ Flutter (Channel stable, version 3.x.x)
# ✓ Dart (version 3.x.x)
# ✓ Android toolchain
# ✓ Xcode (if on macOS)
```

---

## 🖥️ Operating System Setup

### macOS Setup

**Install Homebrew** (if not installed):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Install Git and Dependencies**:
```bash
brew install git
brew install --cask android-studio
brew install --cask xcode  # For iOS development
```

**Accept Xcode Licenses**:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xdm-accept-license
```

### Windows Setup

1. **Install Git**
   - Download: [Git for Windows](https://git-scm.com/download/win)
   - Use default settings

2. **Install Android Studio**
   - Download: [Android Studio](https://developer.android.com/studio)
   - During installation, select Android SDK, Android SDK Platform, and Android Virtual Device

3. **Install Visual Studio Code** (Optional but recommended)
   - Download: [VS Code](https://code.visualstudio.com)

### Linux Setup (Ubuntu/Debian)

```bash
# Update packages
sudo apt update && sudo apt upgrade

# Install dependencies
sudo apt install -y git curl unzip xz-utils zip libglu1-mesa

# Install Android Studio
# Download from https://developer.android.com/studio
# Or use snap: sudo snap install android-studio --classic

# Set Android SDK permissions
sudo chown -R $USER:$USER ~/Android/
```

---

## 📦 Flutter Installation

### Step 1: Download Flutter SDK

```bash
# macOS/Linux
git clone https://github.com/flutter/flutter.git -b stable ~/flutter

# Windows (using Git Bash)
git clone https://github.com/flutter/flutter.git -b stable %USERPROFILE%\flutter
```

### Step 2: Add Flutter to PATH

**macOS/Linux**:
```bash
# Edit ~/.zshrc or ~/.bashrc (depending on your shell)
export PATH="$PATH:$HOME/flutter/bin"

# Reload shell
source ~/.zshrc  # or ~/.bashrc
```

**Windows**:
1. Press `Win + X` → System (or Settings → System)
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Under "User variables", click "New"
5. Variable name: `PATH`
6. Variable value: `C:\Users\[YourUsername]\flutter\bin`
7. Click OK and restart your computer

### Step 3: Verify Installation

```bash
flutter doctor

# Should show:
# ✓ Flutter (version x.x.x)
# ✓ Dart SDK
# ✓ Chrome (for web development)
```

---

## 🎯 IDE & Editor Configuration

### Visual Studio Code (Recommended for Flutter)

**Install VS Code**:
- Download: [https://code.visualstudio.com](https://code.visualstudio.com)

**Install Extensions**:
1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X / Cmd+Shift+X)
3. Search and install:
   - **Flutter** (Dart Code) - Official Flutter support
   - **Dart** (Dart Code) - Dart language support
   - **Pubspec Assist** - Package management helper
   - **GitLens** - Git integration

**VS Code Settings** (`settings.json`):
```json
{
  "dart.enableSdkFormatter": true,
  "dart.lineLength": 100,
  "editor.formatOnSave": true,
  "[dart]": {
    "editor.defaultFormatter": "Dart-Code.dart-code",
    "editor.formatOnSave": true
  },
  "dart.flutterSdkPath": "/path/to/flutter"
}
```

### Android Studio

**Install Extensions**:
1. Open Android Studio
2. Go to Preferences/Settings
3. Search "Plugins"
4. Install:
   - **Flutter** plugin
   - **Dart** plugin

**Configure SDK**:
1. Preferences → Languages & Frameworks → Dart
2. Set Dart SDK to `[flutter-path]/bin/cache/dart-sdk`

---

## 🏗️ Project Repository Setup

### Clone Repository

```bash
# Clone from GitHub
git clone https://github.com/asiimwe-dev/FarmerHub-UG.git
cd FarmerHub-UG
```

### Install Dependencies

#### 📱 Frontend (Flutter)
```bash
cd frontend
flutter pub get

# Verify static analysis
flutter analyze
```

#### 🛠️ Backend (FastAPI)
```bash
cd ../backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### Analyze Project

```bash
# Run static analysis
flutter analyze

# Should output: 0 issues found
```

---

## 📱 Emulator & Simulator Setup

### Android Emulator

**Create Virtual Device**:
```bash
# List available system images
flutter emulators

# Create new emulator
flutter emulators create --name farmhub_dev

# Start emulator
flutter emulators --launch farmhub_dev

# Or from Android Studio:
# 1. Open AVD Manager (Tools → AVD Manager)
# 2. Click "Create Virtual Device"
# 3. Select Pixel 5 or similar
# 4. Select API 30+ image
# 5. Complete setup
```

**Recommended Settings**:
- Device: Pixel 5 or Pixel 6
- API Level: 30 or higher
- RAM: 2 GB minimum (4 GB recommended)
- Storage: 2 GB

### iOS Simulator

```bash
# Start iOS Simulator
open -a Simulator

# List available simulators
xcrun simctl list devices

# Start specific simulator
xcrun simctl boot "iPhone 14 Pro"

# Note: iOS development requires macOS
```

---

## 🚀 Running Your First Build

### Run on Emulator/Simulator

```bash
# Start emulator first, then run:
flutter run

# For verbose output:
flutter run -v

# Hot reload during development:
# Press 'r' in terminal

# Hot restart:
# Press 'R' in terminal

# Stop app:
# Press 'q' in terminal
```

### Run on Physical Device

**Android**:
```bash
# Enable Developer Mode on device
# 1. Settings → About Phone
# 2. Tap "Build Number" 7 times
# 3. Settings → Developer Options
# 4. Enable "USB Debugging"
# 5. Connect via USB cable

# List connected devices
flutter devices

# Run on device
flutter run
```

**iOS**:
```bash
# Connect iPhone via USB
# Trust the computer when prompted

# List connected devices
flutter devices

# Run on device
flutter run

# Note: May require Apple Developer account
```

### Build for Release

```bash
# Android (creates APK)
flutter build apk --release

# Android (creates App Bundle for Play Store)
flutter build appbundle --release

# iOS (creates .ipa)
flutter build ios --release

# Output location:
# Android: build/app/outputs/flutter-apk/
# iOS: build/ios/ipa/
```

---

## 🔧 Development & Debugging

### Hot Reload & Hot Restart

| Command | Keyboard | Effect |
|---------|----------|--------|
| **Hot Reload** | `r` | Reload code without full rebuild (fast) |
| **Hot Restart** | `R` | Full restart with app state reset |
| **Quit** | `q` | Stop the app |
| **List Options** | `h` | Show help menu |

### Debugging Tools

**Flutter DevTools**:
```bash
# Start DevTools
flutter pub global activate devtools
devtools

# Or from VS Code:
# Command Palette → Flutter: Open DevTools
```

**Logging**:
```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.i('Info message');      // Info
logger.w('Warning message');   // Warning
logger.e('Error message');     // Error
logger.d('Debug message');     // Debug
```

**Breakpoint Debugging**:
1. Set breakpoint in VS Code (click line number)
2. Run app in debug mode: `flutter run`
3. App pauses at breakpoint
4. Use Debug Console to inspect variables

---

## 🐛 Troubleshooting Common Issues

### Issue: "Flutter not found"

**Solution**:
```bash
# Verify PATH is set
echo $PATH

# Add to PATH manually
export PATH="$PATH:$HOME/flutter/bin"

# Verify flutter is accessible
which flutter
```

### Issue: "Gradle build failed"

**Solution**:
```bash
# Clean build cache
flutter clean

# Get dependencies again
flutter pub get

# Try build again
flutter run

# If still fails, check gradle version
```

### Issue: "Android SDK not found"

**Solution**:
```bash
# Run diagnostics
flutter doctor -v

# Set Android SDK path manually
export ANDROID_SDK_ROOT=~/Android/Sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools"
```

### Issue: "No connected devices"

**Solution**:
```bash
# List available devices
flutter devices

# If empty, either:
# 1. Start emulator: flutter emulators --launch [name]
# 2. Connect physical device with USB debugging enabled

# Check USB connection
adb devices
```

### Issue: "Xcode build failed" (macOS)

**Solution**:
```bash
# Clean Xcode cache
flutter clean
rm -rf ios/Pods ios/Podfile.lock

# Reinstall dependencies
flutter pub get

# Accept Xcode licenses
sudo xcode-select --reset
sudo xdm-accept-license

# Try again
flutter run
```

---

## ⚡ Performance Tips

### Optimize Build Times

```bash
# Use split debug build for faster iteration
flutter run --split-per-abi

# Disable animations during development
flutter run --enable-software-rendering

# Use verbose output to identify slow steps
flutter build apk -v
```

### Emulator Performance

- Use **hardware acceleration** when available
- Allocate sufficient **RAM** (4+ GB recommended)
- Use **faster storage** (SSD recommended)
- Disable unnecessary sensors/features

### Development Best Practices

- Use **hot reload** frequently during UI development
- Keep **emulator running** between sessions
- Use **Android Studio's Profiler** to identify bottlenecks
- Enable **null safety** for compile-time error checking

---

## 📚 Next Steps After Setup

1. **Read ARCHITECTURE.md** — Understand code structure
2. **Read QUICK_REFERENCE.md** — Learn common workflows
3. **Explore the codebase**:
   ```bash
   cd lib
   ls -la
   # Check: app/, config/, core/, modules/
   ```
4. **Run your first test**:
   ```bash
   flutter test
   ```
5. **Make a small code change** and use hot reload:
   - Edit a string in `lib/app/app.dart`
   - Press `r` to see changes instantly

---

## ❓ Getting Help

### Resources

- **Official Documentation**: [Flutter.dev](https://flutter.dev/docs)
- **Dart Documentation**: [Dart.dev](https://dart.dev)
- **Stack Overflow**: Tag `flutter`
- **GitHub Issues**: [FarmerHub-UG Issues](https://github.com/asiimwe-dev/FarmerHub-UG/issues)

### Common Documentation Links

- [Flutter Installation](https://flutter.dev/docs/get-started/install)
- [Flutter for Android Developers](https://flutter.dev/docs/get-started/flutter-for/android-devs)
- [Flutter for iOS Developers](https://flutter.dev/docs/get-started/flutter-for/ios-devs)
- [Flutter Widget Catalog](https://flutter.dev/docs/development/ui/widgets)

### Ask for Help

1. Check existing [GitHub Issues](https://github.com/asiimwe-dev/FarmerHub-UG/issues)
2. Search Stack Overflow and Flutter docs
3. Post in GitHub Discussions
4. Contact project maintainers

---

**✅ Setup Complete!** You're now ready to start developing FarmCom Core. 🎉

---

**Next: [05 Backend Specification](./05_Backend_Specification.md)**
