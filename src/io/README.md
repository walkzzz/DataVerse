# io 存储适配

> 对应架构 §3 + §2 非目标 4 | Sprint：Phase 1+

## 职责

对接对象存储、数据湖、向量库。**不做数据存储引擎**，只提供 IO 适配层。

## 规划

- 对象存储（OBS/S3）
- 数据湖格式（Iceberg / Delta / Parquet / WebDataset / TFRecord）
- 向量库（Faiss / Milvus）
- 流式源

## 当前状态

S0.1 骨架占位。`io_id` 为占位标识，供根包重导出验证。

---

> io | DataVerse | 2026-10-17