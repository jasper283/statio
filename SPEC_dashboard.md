# SPEC_dashboard.md — Dashboard

## 1. Page Goal
Allow users to understand yesterday’s app performance within 30 seconds.

## 2. Layout Structure
1. Header
   - App picker (Free: 1 app, Pro: multiple)
   - Date range picker
2. Metric Cards
   - Yesterday Revenue
   - Yesterday Units
   - Delta vs previous day (↑↓)
3. Line Chart
   - Revenue / Units toggle
4. Donut Chart (Pro)
   - Revenue Split (Subscription vs Non-subscription)
5. Country Top List (Pro)
6. Footer
   - Last synced time
   - Manual refresh button

## 3. Date Ranges
- Free:
  - Yesterday
  - Last 7 Days
- Pro:
  - Last 30 Days
  - Custom Range

## 4. Degradation Rules
- No data yet:
  - Show loading / skeleton
- Revenue split unavailable:
  - Hide chart
  - Show localized explanation
