# Contributing to Farmer Hub UG

Thanks for contributing to Farmer Hub UG.

## Contribution Priorities (Current)

- Offline-first mobile capture workflows
- Sync reliability and conflict handling
- Geospatial data quality and boundary tooling
- FastAPI service contracts and validation
- Forecasting and analytics pipeline quality

## Basic Setup

```bash
git clone https://github.com/asiimwe-dev/FarmerHub-UG.git
cd FarmerHub-UG/frontend
flutter pub get
flutter analyze
```

## Working Rules

1. Keep features aligned to the FarmCom Core strategy.
2. Prefer clear, testable modules over shortcuts.
3. Update docs in `docs/` when behavior or product direction changes.
4. Avoid committing credentials or environment secrets.

## Pull Request Checklist

- Clear scope and purpose
- No unrelated file churn
- Updated relevant documentation in `docs/`
- Passing local checks for the touched component(s)
