# AGENTS.md — Execution Rules

## Language
- 默认使用简体中文
- 注释可中英混合

## Platform & Stack (HARD CONSTRAINTS)
- iOS >= 17
- SwiftUI + Swift Charts
- WidgetKit
- appstoreconnect-swift-sdk (ASC)
- SQLite + GRDB
- Architecture: MVVM

## Data & Security (HARD CONSTRAINTS)
- ASC API 直连，无后端
- Private Key 仅存 Keychain，不写日志
- 数据存在 T+1/T+2 延迟，禁止展示“实时”
- 所有金额使用 Decimal
- 日期统一按天（yyyy-MM-dd）

## Architecture Rules
- UI 层禁止直接解析 ASC 报表
- 所有 ASC 数据先映射到 Domain Model
- 本地数据库只存“聚合后数据”
- Widget 禁止联网，只读 App Group snapshot

## Failure & Fallback Rules
- 网络/解析失败 → 展示缓存数据
- 无法区分订阅/非订阅 → 隐藏占比图
- 数据缺失 → 显示占位与说明，不 crash

## Defaults When Unclear
- 优先功能可用性 > 完整性
- 优先简化实现
- 优先用户可理解的 UI
