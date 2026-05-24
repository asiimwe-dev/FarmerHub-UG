# 🤝 Contributing to Farmer Hub UG

**Professional Contribution Guidelines for FarmerHub UG Project**

> 📖 Complete guide for contributing code, reporting issues, and participating in the FarmerHub UG community. Learn our development workflow, code standards, and review process.

**Last Updated**: May 2026 | **Status**: ✅ Active | **Audience**: Contributors, Developers

---

## 📋 Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Before You Start](#before-you-start)
4. [Development Workflow](#development-workflow)
5. [Pull Request Process](#pull-request-process)
6. [Code Standards](#code-standards)
7. [Commit Message Guidelines](#commit-message-guidelines)
8. [Testing Requirements](#testing-requirements)
9. [Documentation Standards](#documentation-standards)
10. [Reporting Issues](#reporting-issues)
11. [Code Review Guidelines](#code-review-guidelines)
12. [Common Mistakes](#common-mistakes)
13. [Getting Help](#getting-help)
14. [Recognition](#recognition)

---

## 📜 Code of Conduct

### Our Commitment

We are dedicated to providing a welcoming, inclusive, and professional community for all contributors. We are committed to creating an environment where:

- All contributors feel **safe and respected**
- Diverse perspectives are **valued and heard**
- Technical merit is the basis for all decisions
- Collaboration and learning are encouraged

**See also: [08 Code of Conduct](./08_Code_Of_Conduct.md)**

### Expected Behavior

#### ✅ DO:

- **Be Respectful** — Treat all team members with courtesy and professionalism
- **Be Collaborative** — Share knowledge, help others, celebrate wins together
- **Be Accountable** — Take ownership of your code and its quality
- **Be Professional** — Focus on technical merit and constructive feedback
- **Be Inclusive** — Welcome contributions from people of all backgrounds
- **Be Curious** — Learn from mistakes and improve continuously
- **Ask Questions** — Clarify requirements before implementing

#### ❌ DON'T:

- No Harassment — No bullying, discrimination, or personal attacks
- No Unwelcoming Behavior — No gatekeeping or exclusion based on experience
- No Unprofessionalism — No inappropriate language or behavior in public spaces
- No Plagiarism — Always credit sources and respect intellectual property
- No Conflicts of Interest — Disclose competing interests transparently
- No Shortcuts on Quality — Don't compromise testing or documentation
- No Disrespect to Reviewers — All feedback is meant to improve the code

### Enforcement

Violations of this code of conduct may result in:

1. **Warning** — First offense; private conversation with maintainers
2. **Temporary Removal** — Repeated violations; banned for 1-4 weeks
3. **Permanent Ban** — Severe violations; permanent removal from project

**Report Violations**: Contact project maintainers privately via:
- GitHub: [@asiimwe-dev](https://github.com/asiimwe-dev)
- Email: gilbert.asiimwe.dev@gmail.com
- All reports are **confidential** and investigated promptly

---

## 🚀 Getting Started

### Step 1: Fork and Clone

```bash
# 1. Fork repository on GitHub
# (Click "Fork" button on https://github.com/asiimwe-dev/FarmerHub-UG)

# 2. Clone your fork
git clone https://github.com/YOUR_USERNAME/FarmerHub-UG.git
cd FarmerHub-UG/frontend

# 3. Add upstream remote
git remote add upstream https://github.com/asiimwe-dev/FarmerHub-UG.git
```

### Step 2: Create Feature Branch

```bash
# Always create a new branch from latest main
git fetch upstream
git checkout -b feature/your-feature-name upstream/main

# Branch naming convention:
# feature/description   — New feature
# fix/description       — Bug fix
# docs/description      — Documentation only
# refactor/description  — Code refactoring
```

### Step 3: Set Up Development Environment

#### For Frontend (Mobile)
```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
flutter pub get

# Verify setup
flutter doctor
flutter analyze  # Should show 0 issues
flutter test     # All tests should pass
```

#### For Backend (API)
```bash
# Navigate to backend directory
cd backend

# Set up environment
python -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Verify setup
pytest           # All tests should pass
```

---

## ✅ Before You Start

### Check These First

1. **Browse Existing Issues**
   - Visit [GitHub Issues](https://github.com/asiimwe-dev/FarmerHub-UG/issues)
   - Is your feature already being worked on?
   - Are there related discussions?

2. **Check the Roadmap**
   - Read [ROADMAP.md](./ROADMAP.md)
   - Align your work with project priorities
   - Proposed features should match our vision

3. **Review Architecture**
   - Read [ARCHITECTURE.md](./ARCHITECTURE.md)
   - Understand clean architecture principles
   - Know where your code should live

4. **Discuss Major Changes**
   - For major features, open an issue first
   - Get feedback before implementing
   - Prevents wasted effort on misaligned work

---

## 🔄 Development Workflow

### Step 1: Make Changes

```bash
# Make your changes
# Keep changes focused on one thing
# Follow code standards (see below)

# Example: Adding field validation
# File: lib/core/validators/field_validators.dart
```

### Step 2: Test Locally

```bash
# Run code analysis
flutter analyze

# Run unit tests (in your module)
flutter test test/modules/field_capture/

# Run all tests
flutter test

# Test on emulator
flutter run
```

### Step 3: Commit Changes

```bash
# Add your changes
git add .

# Commit with clear message (see guidelines below)
git commit -m "Add field area validation

- Validates area between 0.01-10000 hectares
- Rejects areas outside valid range
- Added FieldValidators.isValidArea() method
- Added 3 unit tests for edge cases"

# Push to your fork
git push origin feature/your-feature-name
```

### Step 4: Create Pull Request

```bash
# Go to GitHub and create PR from your branch to upstream/main
# Fill out PR template completely
# Link any related issues
# Request reviewers
```

---

## 📬 Pull Request Process

### PR Requirements

Every PR must have:

1. **Clear Title** — Starts with conventional commit prefix
   - `feat: Add field area validation`
   - `fix: Resolve GPS coordinate parsing bug`
   - `docs: Update setup instructions`
   - `refactor: Simplify field form logic`

2. **Detailed Description** — What, Why, How
   ```markdown
   ## What
   Added field area validation to prevent invalid hectare values

   ## Why
   Users were entering invalid areas; validation ensures data quality

   ## How
   - Added FieldValidators.isValidArea() method
   - Integrated into field form submission
   - Added 3 unit tests for edge cases
   
   ## Related Issues
   Fixes #123
   ```

3. **Tests** — Code coverage for changes
   - New features: ≥ 80% coverage
   - Bug fixes: Test case reproducing bug
   - Refactoring: No coverage loss

4. **Documentation** — Updated if applicable
   - User-facing changes: Update README.md
   - Architecture changes: Update ARCHITECTURE.md
   - API changes: Update code comments

5. **No Conflicts** — Synced with main
   ```bash
   git fetch upstream
   git rebase upstream/main
   git push -f origin feature/your-feature-name
   ```

### PR Review Checklist

Reviewers look for:

- ✅ **Correctness** — Does it work? Are edge cases handled?
- ✅ **Design** — Does it follow architecture patterns?
- ✅ **Tests** — Are all cases covered?
- ✅ **Performance** — Any obvious inefficiencies?
- ✅ **Maintainability** — Is it easy to understand?
- ✅ **Documentation** — Is it explained?

### Merging

- ✅ All tests pass
- ✅ All feedback addressed
- ✅ Approved by at least 1 maintainer
- ✅ No merge conflicts
- **Commit Strategy**: Squash commits before merge

---

## 📝 Code Standards

### File Organization

```dart
// 1. Imports (alphabetically organized)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 2. Constants
const int MAX_FIELD_NAME_LENGTH = 100;

// 3. Main class/function
class MyWidget extends ConsumerWidget {
  // Implementation
}

// 4. Helper classes (private)
class _FieldForm {
  // Implementation
}
```

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| **Classes** | PascalCase | `FieldEntity`, `FieldRepository` |
| **Methods** | camelCase | `saveField()`, `validateInput()` |
| **Variables** | camelCase | `fieldName`, `areaHectares` |
| **Constants** | UPPER_SNAKE_CASE | `MAX_AREA`, `DEFAULT_TIMEOUT` |
| **Private** | Start with `_` | `_validateInput()`, `_internalState` |
| **Files** | snake_case | `field_entity.dart`, `app_config.dart` |
| **Packages** | snake_case | `flutter_riverpod`, `connectivity_plus` |

### Code Style

```dart
// ✅ DO: Proper formatting and spacing
class FieldEntity extends Equatable {
  final String id;
  final String cropType;
  final double areaHectares;
  
  FieldEntity({
    required this.id,
    required this.cropType,
    required this.areaHectares,
  });
  
  bool isSufficientSize() => areaHectares >= 0.01;
  
  @override
  List<Object?> get props => [id, cropType, areaHectares];
}

// ✅ DO: Type annotations everywhere
Future<List<FieldEntity>> getAllFields() async {
  // Implementation
}

// ✅ DO: Use const constructors
const snackBar = SnackBar(content: Text('Saved'));

// ❌ DON'T: Avoid dynamic types
dynamic data = json.decode(response);  // Bad

// ❌ DON'T: Avoid bare excepts
try {
  doSomething();
} catch (e) {  // Generic catch - bad
  print(e);
}

// ✅ DO: Specific exception handling
try {
  doSomething();
} on ValidationException catch (e) {
  logger.e('Validation failed: $e');
} on NetworkException catch (e) {
  logger.e('Network error: $e');
}
```

### Comments

```dart
// ✅ DO: Explain WHY, not WHAT
/// Validates field area to ensure it's within acceptable range.
/// Farmers typically work areas from 0.01 ha (small garden) to 10000 ha (large estate).
bool isValidArea(double area) => area >= 0.01 && area <= 10000;

// ❌ DON'T: Comment obvious code
int count = 0;  // Set count to 0
count++;        // Increment count

// ✅ DO: Use doc comments for public API
/// Saves a field record to local storage and queues for sync.
///
/// Throws [ValidationException] if field data is invalid.
/// Throws [OfflineException] if sync fails.
Future<void> saveField(FieldEntity field) async {
  // Implementation
}
```

---

## 💬 Commit Message Guidelines

### Format

```
<type>: <subject>

<body>

<footer>
```

### Type

- `feat:` — New feature
- `fix:` — Bug fix
- `docs:` — Documentation only
- `style:` — Formatting, missing semicolons, etc
- `refactor:` — Code restructuring without functionality change
- `perf:` — Performance improvements
- `test:` — Test additions/changes

### Subject

- Start with lowercase (unless proper noun)
- Max 50 characters
- Imperative mood: "add" not "added" or "adds"
- No period at end

### Body

- Explains **what** and **why**, not **how**
- Max 72 characters per line
- Separate from subject with blank line

### Example

```
feat: Add field area validation

Validates that field areas are between 0.01 and 10000 hectares.
This prevents data quality issues where farmers enter invalid
values like -5 or 1000000 hectares.

Also improves error messages when validation fails.

Fixes #123
```

---

## 🧪 Testing Requirements

### Test Coverage

- **New Features**: ≥ 80% code coverage
- **Bug Fixes**: Reproduction test case required
- **Refactoring**: No coverage loss

### Writing Tests

```dart
// ✅ DO: Clear, descriptive test names
void main() {
  group('FieldEntity', () {
    test('isSufficientSize returns true for areas >= 0.01', () {
      final field = FieldEntity(
        id: '1',
        cropType: 'maize',
        areaHectares: 1.0,
      );
      
      expect(field.isSufficientSize(), true);
    });
    
    test('isSufficientSize returns false for areas < 0.01', () {
      final field = FieldEntity(
        id: '1',
        cropType: 'maize',
        areaHectares: 0.005,
      );
      
      expect(field.isSufficientSize(), false);
    });
  });
}

// ✅ DO: Test edge cases
test('validateArea handles boundary values', () {
  expect(FieldValidators.isValidArea(0.01), true);    // Min
  expect(FieldValidators.isValidArea(10000), true);   // Max
  expect(FieldValidators.isValidArea(0.009), false);  // Below min
  expect(FieldValidators.isValidArea(10001), false);  // Above max
});

// ✅ DO: Use mocks for external dependencies
test('getField calls remote when online', () async {
  final mockRemote = MockRemoteDataSource();
  final mockLocal = MockLocalDataSource();
  
  when(mockRemote.getField('1')).thenAnswer(
    (_) async => FieldDTO(id: '1', cropType: 'maize'),
  );
  
  final repo = FieldRepositoryImpl(mockRemote, mockLocal);
  final result = await repo.getField('1');
  
  expect(result.id, '1');
  verify(mockRemote.getField('1')).called(1);
});
```

### Run Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/modules/field_capture/domain/entities/field_entity_test.dart

# Run tests matching pattern
flutter test --name="isSufficientSize"

# Generate coverage report
flutter test --coverage
```

---

## 📚 Documentation Standards

### In-Code Documentation

```dart
/// Brief description in third person.
///
/// Longer detailed description explaining the purpose,
/// usage, and any important notes.
///
/// Example:
/// ```dart
/// final field = FieldEntity(...);
/// bool valid = field.isSufficientSize();
/// ```
///
/// Throws [ValidationException] if data is invalid.
/// 
/// See also: [FieldValidators] for validation rules.
class FieldEntity {
  // ...
}
```

### Markdown Documentation

- Use **clear headings** with proper hierarchy
- Include **table of contents** at top
- Add **code examples** for complex topics
- Link to **related files** with `[filename](./path)`
- Keep lines under **100 characters**

---

## 🐛 Reporting Issues

### Bug Report Template

```markdown
## Description
Brief description of the bug

## Steps to Reproduce
1. First step
2. Second step
3. Expected result vs actual result

## Environment
- Flutter version: 3.x.x
- OS: macOS/Windows/Linux
- Device: Emulator/Physical

## Logs
Paste relevant error logs or stack trace
```

---

## 👁️ Code Review Guidelines

### For Authors

- ✅ Make small, focused PRs (< 400 LOC)
- ✅ Provide context and explain "why"
- ✅ Respond to all feedback
- ✅ Request re-review after changes

### For Reviewers

- ✅ Review within 24-48 hours
- ✅ Be respectful and constructive
- ✅ Provide specific suggestions
- ✅ Praise good code

---

## 🚀 Release & Versioning Policy

FarmerHub UG follows a strict versioning and release schedule to ensure platform stability for our institutional partners.

### 1. Semantic Versioning (SemVer)
We adhere to `vMAJOR.MINOR.PATCH` formatting:
*   **MAJOR**: Incompatible API changes or fundamental architectural shifts.
*   **MINOR**: New features added in a backwards-compatible manner.
*   **PATCH**: Backwards-compatible bug fixes.

### 2. Branching Strategy
*   **`main`**: Production-ready code. Only merged from `develop` via a Release PR.
*   **`develop`**: Integration branch for features. All PRs target this branch.
*   **`feature/*`**: Individual feature development.
*   **`hotfix/*`**: Emergency fixes targeting `main` directly.

### 3. Release Cadence
*   **Beta/Staging Builds**: Triggered automatically on every merge to `develop`.
*   **Production Releases**: Bi-weekly (every twond Tuesday), provided all QA checks pass.

---

## ⚠️ Common Mistakes

| Mistake | Fix |
|---------|-----|
| Commit directly to `main` | Always create feature branch |
| Mix multiple concerns in one PR | Keep PRs focused on one feature |
| No tests for new code | Add tests before submitting PR |
| Inconsistent formatting | Run `flutter analyze` before committing |
| Large PRs (1000+ LOC) | Break into smaller PRs |
| Generic commit messages | Use conventional commits format |
| Merge conflicts ignored | Rebase on main regularly |

---

## ❓ Getting Help

### Resources

- **Issues**: [GitHub Issues](https://github.com/asiimwe-dev/FarmerHub-UG/issues)
- **Discussions**: [GitHub Discussions](https://github.com/asiimwe-dev/FarmerHub-UG/discussions)
- **Documentation**: [docs/](./../../docs)

### Ask Questions

1. Check existing issues/discussions
2. Search Stack Overflow
3. Open a GitHub Discussion
4. Ask in relevant PR

---

## 🏆 Recognition

We recognize and celebrate all contributions! Contributors are listed in:
- GitHub contributor graph
- Release notes
- Project README

---

**🎉 Thanks for contributing!** Your work helps FarmerHub UG serve farmers across East Africa. 🌾
