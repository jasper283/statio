# SPEC_global.md — Global Specification

## 1. Language & Internationalization (HARD)

### 1.1 Language Strategy
- Default app language: English (en)
- The app must support in-app language switching (not relying on system language)
- v1.0 must support:
  - English (en)
  - Simplified Chinese (zh-Hans)

### 1.2 i18n Implementation Rules
- ❌ No hard-coded strings in code
- ✅ All user-visible text must come from localization resources:
  - Localizable.strings
  - or `String(localized:)`
- Localization key naming convention examples:
  - `dashboard.title`
  - `dashboard.metric.revenue`
  - `dashboard.metric.units`
  - `dashboard.lastSynced`
  - `setup.title`
  - `setup.verify.success`
  - `error.network`
  - `paywall.pro.title`

- Views must only use localized strings, e.g.:
  - `Text(String(localized: "dashboard.title"))`

### 1.3 In-App Language Switching
- A language picker must be provided in Settings.
- Supported languages (v1.0): English, Simplified Chinese.
- UI must refresh immediately after language change.
- No app restart required.
- Language preference must be persisted in UserDefaults.
- The language setting must override system language for in-app text.

---

## 2. Light / Dark Mode Support (HARD)

### 2.1 Appearance Modes
- Must support:
  - Light
  - Dark
  - Follow System (default)

### 2.2 Color Rules
- ❌ Do NOT use `.black` / `.white` for UI colors.
- ✅ Prefer semantic colors:
  - `Color.primary`
  - `Color.secondary`

- All custom UI colors must be defined in `Assets.xcassets` and include Light & Dark variants.
- Views should use app semantic wrappers instead of raw asset names, e.g.:
  - `Color.appBackground`
  - `Color.cardBackground`
  - `Color.appSeparator`

### 2.3 Charts (Swift Charts)
- Charts must adapt to dark mode.
- ❌ No hard-coded hex colors inside chart code.
- ✅ Use semantic colors or assets with light/dark variants.
- Grid/axis labels must remain readable in both modes.

---

## 3. Global UX Requirements (HARD)

### 3.1 Error / Loading / Empty States
- Must provide localized:
  - Loading state (skeleton or progress)
  - Error state (network/auth/parse)
  - Empty state (no data available yet)
- Errors must not expose secrets (no private key contents, no raw credential logging).

### 3.2 Number / Currency Formatting
- All money amounts must use `Decimal` internally (no Double).
- Display formatting must be locale-aware:
  - Thousands separators
  - Currency symbol if available
- If multiple currencies appear, the UI must label the currency context clearly (v1.0 may default to “as reported by ASC” without conversion).

### 3.3 Date Formatting
- Dates are day-precision (yyyy-MM-dd in storage).
- Display dates in user-friendly format per selected language/locale.
- The app must clearly communicate ASC delay:
  - Default preset “Yesterday” is the primary entry point (not “Today” real-time).
