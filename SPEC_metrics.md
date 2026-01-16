# SPEC_metrics.md — Metrics & Data Definition

## 1. Metric Definitions
- Revenue = Developer Proceeds
- Units = Downloads
- Date precision = day (yyyy-MM-dd)

## 2. Trend Data
- Aggregated by day
- Missing dates filled with zero (for chart continuity)

## 3. Revenue Split
- Subscription
- Non-subscription
- If not reliably available:
  - Mark as unknown
  - UI must hide donut chart

## 4. Country Dimension
- countryCode = ISO Alpha-2
- Global represented as "WW"
