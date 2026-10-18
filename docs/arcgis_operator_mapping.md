# ArcGIS Pro 算子映射 / ArcGIS Pro Operator Mapping

> 从 `ArcGIS_Pro_矢量分析工具完整清单.md`（229 工具）+ `ArcGIS_Pro_栅格与影像分析工具完整清单.md`（497 工具）提取。
> 总计 **726 ArcGIS Pro 算子**，映射到 DataVerse 已有/待建算子。

## 一、已覆盖类别 / Covered Categories

| ArcGIS Pro 类别 | 工具数 | DataVerse 对应 | 覆盖度 |
|----------------|--------|---------------|--------|
| 提取分析（Extract） | 5+7 | opcore/filter + opcore/select | 部分 |
| 统计分析（Statistics） | 4 | opcore/eval | 部分 |
| 概化（Generalization） | 3+7 | opcore/transform + opcore/clean | 部分 |
| 聚类分布制图 | 2 | learncore/cluster | 部分 |
| 建模空间关系 | 2 | learncore/classify + learncore/regression | 部分 |
| 深度学习 | 5+5 | learncore/dl_layers | 部分 |
| 条件分析（Conditional） | 3 | opcore/transform | 部分 |
| 数学分析（Math） | 30+ | opcore/transform | 部分 |
| 重分类（Reclass） | 5 | opcore/transform | 部分 |
| 影像分割和分类 | 8 | learncore/classify | 部分 |
| 多模态（image/audio/video） | — | opcore/image + audio + video | 部分 |
| 语义算子 | — | opcore/semantic | 部分 |

## 二、缺失高优先级类别 / Missing High-Priority Categories

| 优先级 | ArcGIS Pro 类别 | 工具数 | 描述 | DataVerse 目标 |
|--------|----------------|--------|------|---------------|
| P0 | 邻近分析（Proximity） | 7 | Buffer/Thiessen/Near/Point Distance | opcore/proximity（新建） |
| P0 | 叠加分析（Overlay） | 10 | Intersect/Union/Erase/Identity/Spatial Join | opcore/overlay（新建） |
| P0 | 水文分析（Hydrology） | 20 | Flow Direction/Flow Accumulation/Watershed/Fill | opcore/hydrology（新建） |
| P0 | 表面分析（Surface） | 15 | Slope/Aspect/Hillshade/Contour/Curvature | opcore/surface（新建） |
| P1 | 密度分析（Density） | 8 | Kernel Density/Point Density/Line Density | opcore/density（新建） |
| P1 | 距离分析（Distance） | 18 | Euclidean Distance/Cost Distance/Path | opcore/distance（新建） |
| P1 | 插值分析（Interpolation） | 7 | IDW/Kriging/Spline/Natural Neighbor | learncore/interpolation（新建） |
| P1 | 区域分析（Zonal） | 6 | Zonal Statistics/Zonal Geometry | opcore/zonal（新建） |
| P2 | 局部分析（Local） | 10 | Local Statistics/Focal Statistics | opcore/local_stats（新建） |
| P2 | 邻域分析（Neighborhood） | 12 | Focal/Block/Line Statistics | opcore/neighborhood（新建） |
| P2 | 太阳辐射（Solar Radiation） | 3 | Solar Radiation/Area/Point | opcore/solar（新建） |
| P2 | 地下水分析（Groundwater） | 4 | Darcy Flow/Particle Track | opcore/groundwater（新建） |

## 三、映射详情 / Mapping Details

### 矢量分析（229 工具）

#### 提取分析 → opcore/filter + opcore/select
- Clip → filter_by_range（部分对标）
- Select → select_by_predicate
- Split → filter_split
- Split By Attributes → 待建

#### 叠加分析 → opcore/overlay
- Erase → overlay_erase
- Identity → overlay_identity
- Intersect → overlay_intersect
- Spatial Join → overlay_spatial_join
- Union → overlay_union
- Update → overlay_update
- Symmetrical Difference → overlay_sym_diff

#### 邻近分析 → opcore/proximity
- Buffer → proximity_buffer
- Create Thiessen Polygons → proximity_thiessen
- Generate Near Table → proximity_near_table
- Multiple Ring Buffer → proximity_multi_ring_buffer
- Near → proximity_near
- Point Distance → proximity_point_distance
- Polygon Neighbors → proximity_polygon_neighbors

#### 统计分析 → opcore/eval
- Frequency → eval_frequency（待建）
- Summary Statistics → eval_summary_stats（部分对标）
- Tabulate Intersection → eval_tabulate_intersection

#### 度量地理分布 → learncore/feature
- Central Feature → feature_central_feature
- Mean Center → feature_mean_center
- Median Center → feature_median_center
- Standard Distance → feature_standard_distance
- Directional Distribution → feature_directional_distribution

#### 聚类分布制图 → learncore/cluster
- Density-based Clustering → cluster_density_based（部分对标）
- Similarity Search → cluster_similarity_search

#### 建模空间关系 → learncore/classify + learncore/regression
- Forest-based Classification and Regression → classify_forest
- Generalized Linear Regression → regression_glm

### 栅格分析（497 工具）

#### 条件分析 → opcore/transform
- Con → transform_conditional
- Pick → transform_pick
- Set Null → transform_set_null

#### 密度分析 → opcore/density
- Kernel Density → density_kernel
- Line Density → density_line
- Point Density → density_point
- Space Time Kernel Density → density_space_time_kernel

#### 距离分析 → opcore/distance
- Distance Accumulation → distance_accumulation
- Cost Distance → distance_cost
- Euclidean Distance → distance_euclidean
- Optimal Path As Line → distance_optimal_path
- Corridor → distance_corridor

#### 水文分析 → opcore/hydrology
- Fill → hydrology_fill
- Flow Direction → hydrology_flow_direction
- Flow Accumulation → hydrology_flow_accumulation
- Watershed → hydrology_watershed
- Stream Order → hydrology_stream_order
- Stream Link → hydrology_stream_link
- Sink → hydrology_sink
- Snap Pour Point → hydrology_snap_pour
- Basin → hydrology_basin
- Flow Length → hydrology_flow_length

#### 插值分析 → learncore/interpolation
- IDW → interpolation_idw
- Kriging → interpolation_kriging
- Spline → interpolation_spline
- Natural Neighbor → interpolation_natural_neighbor
- Topo To Raster → interpolation_topo_to_raster

#### 表面分析 → opcore/surface
- Slope → surface_slope
- Aspect → surface_aspect
- Hillshade → surface_hillshade
- Contour → surface_contour
- Curvature → surface_curvature
- Viewshed → surface_viewshed

#### 区域分析 → opcore/zonal
- Zonal Statistics → zonal_statistics
- Zonal Geometry → zonal_geometry
- Tabulate Area → zonal_tabulate_area

#### 局部分析 → opcore/local_stats
- Local Statistics → local_stats
- Focal Statistics → focal_stats
- Block Statistics → block_stats

#### 重分类 → opcore/transform
- Reclassify → transform_reclassify
- Slice → transform_slice
- Lookup → transform_lookup

## 四、Phase 4 Sprint 规划 / Phase 4 Sprint Planning

| Sprint | 内容 | 新子包数 | 估计 type+fn |
|--------|------|----------|-------------|
| S4.1 | opcore/proximity 邻近分析（Buffer/Thiessen/Near） | 1 | 4+10 |
| S4.2 | opcore/overlay 叠加分析（Intersect/Union/Erase） | 1 | 3+8 |
| S4.3 | opcore/hydrology 水文分析（Fill/Flow/Watershed） | 1 | 5+12 |
| S4.4 | opcore/surface 表面分析（Slope/Aspect/Hillshade/Contour） | 1 | 4+10 |
| S4.5 | opcore/density 密度分析（Kernel/Point/Line Density） | 1 | 3+8 |
| S4.6 | opcore/distance 距离分析（Euclidean/Cost/Path） | 1 | 4+10 |
| S4.7 | learncore/interpolation 插值分析（IDW/Kriging/Spline） | 1 | 4+10 |
| S4.8 | opcore/zonal 区域分析 + opcore/local_stats 局部分析 | 2 | 6+14 |
| S4.9 | R16 门禁 + Phase 4 闭环 | 0 | 0 |

---

> ArcGIS Pro 算子映射 | 2026-10-18 | 726 工具 → DataVerse