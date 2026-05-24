# Contributing to Farmer Hub UG

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Before You Start](#before-you-start)
4. [Development Workflow](#development-workflow)
5. [Pull Request Process](#pull-request-process)
6. [Code Standards](#code-standards)
7. [Commit Message Guidelines](#commit-message-guidelines)
8. [Testing Requirements](#testing-requirements)
9. [Documentation](#documentation)
10. [Common Pitfalls](#common-pitfalls)
11. [Getting Help](#getting-help)

---

## Code of Conduct

### Our Values

We are committed to fostering a welcoming, inclusive, and professional community. All contributors must:

#### ✅ DO:
- **Be Respectful** — Treat all team members with courtesy and professionalism
- **Be Collaborative** — Share knowledge, help others, and celebrate wins together
- **Be Accountable** — Take ownership of your code and its quality
- **Be Professional** — Focus on technical merit and constructive feedback
- **Be Inclusive** — Welcome contributions from people of all backgrounds
- **Be Curious** — Learn from mistakes and improve continuously

#### ❌ DON'T:
- **No Harassment** — No bullying, discrimination, or personal attacks
- **No Unwelcoming Behavior** — No gatekeeping or exclusion based on experience level
- **No Unprofessionalism** — No inappropriate language or behavior in public spaces
- **No Plagiarism** — Always credit sources and respect intellectual property
- **No Conflicts of Interest** — Disclose competing interests transparently

### Enforcement

Violations of this code of conduct may result in:
- Warning (first offense)
- Temporary removal from project (repeated offenses)
- Permanent ban from the project (severe violations)

**Report violations** to the project maintainers via private message or email. All reports are confidential and will be investigated promptly.

---

## Getting Started

### Prerequisites

Before contributing, ensure you have:

- **Flutter 3.x** installed
  ```bash
  flutter --version
  ```
- **Git** configured with your GitHub account
  ```bash
  git config user.name "Your Name"
  git config user.email "your.email@example.com"
  ```
- **IDE** (VS Code or Android Studio)
- Familiarity with **Clean Architecture** (see `lib/ARCHITECTURE.md`)
- Read the **main README.md** for project overview

### Repository Setup

1. **Fork the repository** on GitHub
   - Click "Fork" button on [FarmerHub-UG](https://github.com/asiimwe-dev/FarmLink-UG)

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/FarmLink-UG.git
   cd FarmLink-UG/frontend
   ```

3. **Add upstream remote** (to stay synced)
   ```bash
   git remote add upstream https://github.com/asiimwe-dev/FarmLink-UG.git
   ```

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Verify setup** (should show 0 issues)
   ```bash
   flutter analyze
   flutter test
   ```

---

## Before You Start

### 1. Pick an Issue

- Check [GitHub Issues](https://github.com/asiimwe-dev/FarmLink-UG/issues)
- Look for labels: `good first issue`, `help wanted`, `type: feature`
- Comment "I'll work on this" to claim it
- Discuss approach with maintainers if it's substantial

### 2. Discuss Major Changes

For **new modules, architecture changes, or breaking changes**:
- Open a GitHub Discussion or issue first
- Get feedback before writing code
- Saves time and prevents rework

### 3. Understand the Architecture

Read `frontend/lib/ARCHITECTURE.md` thoroughly:
- Know where to put code (which layer/directory)
- Understand the data flow (presentation → domain → data)
- Learn the dependency injection pattern (Riverpod)

### 4. Contribution Priorities

Current focus areas for FarmCom Core:
- Offline-first mobile capture workflows
- Sync reliability and conflict handling
- Geospatial data quality and boundary tooling
- Authentication and session management
- Forecasting and analytics pipeline quality

---

## Development Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/user-authentication
```

**Naming Convention**:
- `feature/` — New features
- `bugfix/` — Bug fixes
- `refactor/` — Code refactoring
- `docs/` — Documentation updates
- `test/` — Tests
- `chore/` — Maintenance (deps, config)

### 2. Make Your Changes

**Single Responsibility**: Each commit should be logically independent.

### 3. Keep Your Branch Updated

Before submitting PR:
```bash
git fetch upstream
git rebase upstream/main
```

### 4. Test Your Changes

Run **all checks** before pushing:

```bash
# Format code
dart format .

# Static analysis (MUST pass)
flutter analyze

# Run tests
flutter test

# Build (catches compile errors)
flutter build apk --debug  # Android
```

**All of these must pass!**

### 5. Push to Your Fork

```bash
git push origin feature/your-feature
```

---

## Pull Request Process

### PR Template

```markdown
## Description
Brief summary of what this PR does.

## Motivation
Why is this change needed? What problem does it solve?

## Implementation Details
How does it work? Any key decisions or tradeoffs?

## Changes Made
- Change 1
- Change 2

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] No breaking changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] No console warnings or errors
- [ ] `flutter analyze` passes
- [ ] `flutter test` passes
```

### Code Review

**Reviewers will check**:
- ✅ Architecture compliance
- ✅ Error handling
- ✅ Testability
- ✅ Performance
- ✅ Readability
- ✅ Documentation

Be open to feedback. We review for quality, not ego.

---

## Code Standards

### Follow Dart Style Guide

- Use `final` by default (immutability)
- Private fields with `_` prefix
- PascalCase for classes, snake_case for files
- Type annotations for public APIs
- Document with `///` comments

### Formatting

```bash
dart format lib/
```

### Architecture Compliance

- Domain layer: Pure Dart, no framework code
- Data layer: DTOs, mappers, repositories
- Presentation: UI, widgets, Riverpod providers
- Validation: Input checked in usecases before DB/API calls

---

## Commit Message Guidelines

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type
- `feat` — New feature
- `bugfix` — Bug fix
- `refactor` — Code refactoring
- `docs` — Documentation
- `test` — Test updates
- `chore` — Maintenance

### Example

```
feat(field-capture): Add GPS coordinate validation

Implement latitude/longitude validation with:
- Bounds checking (-90 to 90 for lat, -180 to 180 for lon)
- Precision to 6 decimal places

Fixes #123
```

---

## Testing Requirements

### Minimum Coverage

- **Core layers**: 100%
- **Domain usecases**: 90%+
- **Data repositories**: 80%+
- **Presentation**: 60%+ (focus on logic)

### Run Tests

```bash
flutter test                    # All tests
flutter test --coverage         # With coverage report
```

---

## Documentation

### Update if Adding:

- ✅ New major feature
- ✅ Architecture changes
- ✅ New dependencies
- ✅ Changed setup steps

### Location

- `README.md` — User guide and overview
- `frontend/lib/ARCHITECTURE.md` — Architecture details
- `docs/` — Other project documentation
- Code comments — Implementation details

---

## Common Pitfalls

### ❌ Avoid These

1. **Mixing concerns** — UI code in domain, database in presentation
2. **Ignoring errors** — Silent failure with empty catch blocks
3. **Breaking changes** — Without discussion or deprecation
4. **No tests** — All new code needs tests
5. **Hardcoded values** — Use constants instead
6. **Committing secrets** — Never commit credentials

---

## Getting Help

### Questions?

- 📖 **Read docs first**: Check README.md, ARCHITECTURE.md
- 💬 **Ask in discussions**: GitHub Discussions tab
- 🤝 **Ask reviewers**: Comment on PRs
- 📧 **Email maintainers**: For sensitive issues

### Found a Bug?

Open GitHub issue with:
- Description and reproduction steps
- Expected vs actual behavior
- Device, OS, Flutter version

---

## Working Rules

1. **Align to FarmCom Core strategy** — Offline-first, agri-intelligence
2. **Prefer testable modules** — Over shortcuts and hacks
3. **Update docs when needed** — Keep `docs/` in sync with changes
4. **Never commit secrets** — Use `.env` or secure storage
5. **Ask before major changes** — Discuss architecture changes first

---

## Thank You! 🙏

Your contributions help Farmer Hub UG reach farmers across East Africa. We appreciate your time and care for code quality.

**Together, we're building technology that matters.**

---

**Last Updated**: May 2026  
**Maintained By**: Farmer Hub UG Development Team
