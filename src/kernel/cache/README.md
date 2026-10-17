# kernel/cache

缓存增量模式 / Cache incremental mode.

## 定位

大目录重复处理、增量更新的执行模式基座。
一致性保证：**命中缓存即等价**（cache-hit-equiv）。

## 当前状态（S0.2）

- 缓存键抽象 `CacheKey` / `make_key` / `is_hit`
- 模式标识 `cache_id` / `mode_tag` / `consistency_guarantee`

## 后续填充

- S0.4：真实内容指纹（SHA-256 截断）
- Phase 1：缓存存储后端、增量更新算子