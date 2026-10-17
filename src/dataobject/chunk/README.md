# dataobject/chunk

分块单元 / Chunk unit.

## 定位

切片文本/图像区域/表格块，带稳定 ID。架构 §4.2。

## 当前状态（S0.3）

- `ChunkType` 枚举（TextSlice/ImageRegion/TableBlock/CodeBlock）
- `Chunk` 结构（id + content + chunk_type）+ 构造函数 `make` / `empty_chunk` / `length`

## 后续填充

- S0.4：分块算子（opcore transform）
- Phase 1：跨模态分块、嵌套分块