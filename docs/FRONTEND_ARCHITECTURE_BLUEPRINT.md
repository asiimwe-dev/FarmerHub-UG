# Farmer Hub UG Frontend Architecture Blueprint (Reset Plan)

## Purpose

Define the approved target architecture before deleting legacy frontend code and dependencies.

This blueprint supports the new Farmer Hub UG direction: **offline-first agri-intelligence, traceability, and enterprise readiness**.

## Reset Principles

1. Keep only what supports the new product direction.
2. Start from a minimal, production-credible structure.
3. Remove feature clutter from the prior community-chat-centric build.
4. Maintain clean boundaries: app shell, core, domain modules, infrastructure.

## Frontend Target (Minimal Professional Layout)

```text
frontend/
  lib/
    app/
      app.dart
      bootstrap.dart
      router.dart
    core/
      config/
        env.dart
      theme/
        app_theme.dart
        app_colors.dart
      widgets/
        app_scaffold.dart
        loading_state.dart
        error_state.dart
      utils/
        logger.dart
    modules/
      auth/
        presentation/
          login_page.dart
      field_capture/
        domain/
          entities/
          repositories/
        application/
          usecases/
        infrastructure/
          datasources/
          repositories/
        presentation/
          pages/
          widgets/
      sync/
        application/
        infrastructure/
      traceability/
        domain/
        application/
        infrastructure/
        presentation/
      forecasts/
        domain/
        application/
        infrastructure/
        presentation/
    main.dart
  test/
    smoke_test.dart
  pubspec.yaml
```

## Module Responsibilities

- **field_capture:** offline-first farm plot and agronomic entry.
- **sync:** queued sync orchestration and retry lifecycle.
- **traceability:** provenance and batch evidence workflows.
- **forecasts:** yield projection inputs and result display.
- **auth:** identity and session boundaries for field and enterprise users.

## Dependency Reset (Proposed Baseline)

### Keep

- `flutter`
- `flutter_riverpod`
- `go_router`
- `dio`
- `connectivity_plus`
- `intl`
- `logger`
- `equatable`

### Remove from initial rebuild baseline

- `supabase_flutter`
- `flutterwave_standard`
- `audioplayers`
- `image_picker`
- `image`
- `cached_network_image`
- `flutter_svg`
- `shimmer`
- `pull_to_refresh`
- `dartz`
- `riverpod_annotation` and generators (until needed)
- all current dependency overrides unless re-justified

## Cleanup Scope for Rewrite Step

When implementation begins, the reset will:

1. Remove `frontend/build/` and generated artifacts.
2. Replace current `frontend/lib/` with the target layout above.
3. Minimize `pubspec.yaml` to only baseline dependencies.
4. Add a clean app shell with placeholders for new modules.
5. Keep tests minimal but present (`smoke_test.dart`).

## Implementation Sequence

1. Backup current frontend tree to `frontend_legacy_backup/` (inside repo) before deletion.
2. Reset dependency graph and run fresh package resolution.
3. Scaffold new folder structure and app shell.
4. Add module stubs for field capture, sync, traceability, forecasts.
5. Add initial routing and state wiring.
6. Validate app boots cleanly.

## Definition of Done (Rewrite Phase)

- Frontend contains only the new minimal architecture.
- Legacy feature files are removed.
- Dependency list is reduced to approved baseline.
- App compiles and opens with new shell and module placeholders.
- Documentation remains centralized in `docs/`.
