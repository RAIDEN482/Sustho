# Shustho

**Shustho** (স্বাস্থ্য — "Health" in Bangla) is a free, offline-first menstruation
and reproductive health tracker built for Bangladesh. It supports both Bangla
(বাংলা) and English, and keeps all data on the device — no accounts, no tracking.

## Features

- **Period & cycle tracking** — log period days with flow intensity (light /
  medium / heavy), pain level, moods, symptoms and notes.
- **Smart predictions** — estimates next period start, ovulation and the fertile
  window based on your own cycle history, with sensible fallbacks.
- **Calendar view** — color-coded month calendar (period, predicted period,
  fertile window, ovulation).
- **Insights** — average cycle length, average period length, next-period
  countdown and a cycle-length trend chart.
- **Red-flag health alerts** — in-app guidance for symptoms that warrant medical
  attention.
- **Guardian** — optional trusted-contact profile (local only; nothing is sent).
- **Bilingual** — Bangla and English, with Bangla numerals (০১২৩৪৫৬৭৮৯).
- **Dark & light themes** — flat design system with GitHub-inspired palette.

## Design system

Implemented in `lib/core/theme/`:

| Token            | Hex      | Usage                          |
| ---------------- | -------- | ------------------------------ |
| Primary          | `#E94560` | Period indicators, CTAs        |
| Secondary        | `#58A6FF` | Ovulation, links               |
| Success          | `#238636` | Healthy states, guardian       |
| Warning          | `#D29922` | Medium alerts, pending         |
| Danger           | `#DA3633` | Red flags, severe pain         |
| Background (dark) | `#0D1117` | Dark mode page                 |

- Font: **Inter** (bundled) with **Noto Sans Bengali** fallback for Bangla text.
- Weights: 400 and 500 only.
- Radii: 6 / 8 / 10 / 12 / 16 / 9999.
- Flat design — elevation via 1px borders, no shadows.
- Outlined icons (Material Icons Outlined), 20/24/48px.
- Motion: 100/200/300ms with `cubic-bezier(0.16,1,0.3,1)` (entrance) and
  `cubic-bezier(0.4,0,0.2,1)` (standard).

## Architecture

```
lib/
  core/theme/       Design tokens, themes
  core/utils/       Date helpers, Bangla digits, cycle engine
  data/             Hive-backed offline repository & settings
  l10n/             Bangla + English strings
  models/           CycleEntry, enums
  screens/          onboarding, home, calendar, insights, profile, log
  state/            AppState, CycleController (ChangeNotifier)
  widgets/          Buttons, cards, chips, stat tiles
```

Storage uses [Hive](https://pub.dev/packages/hive) (local boxes), so the app
works fully offline on every platform including web (IndexedDB backend).

## Getting started

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Testing

- `test/cycle_engine_test.dart` — pure logic tests for period grouping, cycle
  averaging and predictions.
- `test/theme_test.dart` — design-token and localization smoke tests.

## License

Free for everyone. Shustho is not a medical device and predictions are
estimates only — consult a healthcare provider for medical advice.
