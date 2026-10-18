///|
/// # opcore/overlay 叠加分析 / Overlay Analysis
///
/// Intersect / Union / Erase / Identity / SymDiff / Spatial Join / Update。
/// 对标 ArcGIS Pro 叠加分析工具集。
/// S4.2 填充：MoonBit 无 GIS 几何引擎，采用**契约 + 包围盒模拟**策略。
///
/// # Overlay analysis
///
/// Intersect / Union / Erase / Identity / SymDiff. Aligned with ArcGIS Pro Overlay toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 多边形 / Polygon: 顶点序列。
pub struct Polygon {
  vertices : Array[@proximity.Point]
} derive(Debug, Eq)

pub extend Polygon with Eq::{equal, not_equal}
pub extend Polygon with Debug::{to_repr}

/// 叠加类型 / Overlay kind.
pub(all) enum OverlayKind {
  Intersect    // 交集
  Union        // 并集
  Erase        // 擦除（差集）
  Identity     // 身份
  SymDiff      // 对称差
} derive(Debug, Eq)

pub extend OverlayKind with Eq::{equal, not_equal}
pub extend OverlayKind with Debug::{to_repr}

/// 叠加结果 / Overlay result.
pub struct OverlayResult {
  kind : OverlayKind
  area : Double
  has_overlap : Bool
  source_count : Int      // 参与叠加的几何体数
  result_count : Int      // 结果几何体数
} derive(Debug, Eq)

pub extend OverlayResult with Eq::{equal, not_equal}
pub extend OverlayResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

/// 构造多边形 / Build a polygon.
pub fn make_polygon(vertices : Array[@proximity.Point]) -> Polygon {
  { vertices, }
}

/// 空多边形 / Empty polygon.
pub fn empty_polygon() -> Polygon {
  { vertices: [], }
}

/// 多边形顶点数 / Vertex count.
pub fn vertex_count(poly : Polygon) -> Int {
  poly.vertices.length()
}

// ============================================================
// 多边形度量 / Polygon metrics
// ============================================================

/// 多边形面积（鞋带公式）/ Polygon area via shoelace formula.
///
/// 公式：`|Σ(x_i * y_{i+1} - x_{i+1} * y_i)| / 2`。
/// 退化安全：少于 3 个顶点返回 0.0。
pub fn polygon_area(poly : Polygon) -> Double {
  let n = poly.vertices.length()
  if n < 3 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let j = (i + 1) % n
      sum = sum + poly.vertices[i].x * poly.vertices[j].y - poly.vertices[j].x * poly.vertices[i].y
    }
    (if sum < 0.0 { -sum } else { sum }) / 2.0
  }
}

/// 多边形周长 / Polygon perimeter.
///
/// 退化安全：少于 2 个顶点返回 0.0。
pub fn polygon_perimeter(poly : Polygon) -> Double {
  let n = poly.vertices.length()
  if n < 2 {
    0.0
  } else if n == 2 {
    @proximity.euclidean_distance(poly.vertices[0], poly.vertices[1])
  } else {
    let mut peri = 0.0
    for i in 0..<n {
      let j = (i + 1) % n
      peri = peri + @proximity.euclidean_distance(poly.vertices[i], poly.vertices[j])
    }
    peri
  }
}

/// 多边形包围盒 / Polygon bounding box.
///
/// 退化安全：空多边形返回 ((0,0),(0,0))。
pub fn polygon_bbox(poly : Polygon) -> (@proximity.Point, @proximity.Point) {
  @proximity.bounding_box(poly.vertices)
}

// ============================================================
// 包围盒相交测试 / Bounding box intersection test
// ============================================================

/// 包围盒相交测试 / Bounding box overlap test.
///
/// 两个多边形包围盒是否有重叠区域。
/// 退化安全：空多边形返回 false。
pub fn bbox_overlap(a : Polygon, b : Polygon) -> Bool {
  if a.vertices.length() == 0 || b.vertices.length() == 0 {
    false
  } else {
    let (a_min, a_max) = polygon_bbox(a)
    let (b_min, b_max) = polygon_bbox(b)
    a_min.x <= b_max.x && b_min.x <= a_max.x && a_min.y <= b_max.y && b_min.y <= a_max.y
  }
}

/// 包围盒包含测试 / Bounding box containment test.
///
/// a 的包围盒是否包含 b 的包围盒。
pub fn bbox_contains(a : Polygon, b : Polygon) -> Bool {
  if a.vertices.length() == 0 || b.vertices.length() == 0 {
    false
  } else {
    let (a_min, a_max) = polygon_bbox(a)
    let (b_min, b_max) = polygon_bbox(b)
    a_min.x <= b_min.x && b_max.x <= a_max.x && a_min.y <= b_min.y && b_max.y <= a_max.y
  }
}

// ============================================================
// 叠加算子 / Overlay operators
// ============================================================

/// 交集 / Intersect: a ∩ b.
///
/// 对标 ArcGIS Pro Intersect。
/// 模拟策略：包围盒相交则面积取 min(a, b) * 0.5，否则 0.0。
/// 退化安全：空多边形返回 area=0.0。
pub fn overlay_intersect(a : Polygon, b : Polygon) -> OverlayResult {
  let overlap = bbox_overlap(a, b)
  let area = if overlap {
    let aa = polygon_area(a)
    let ba = polygon_area(b)
    let min_area = if aa < ba { aa } else { ba }
    min_area * 0.5
  } else {
    0.0
  }
  { kind: Intersect, area, has_overlap: overlap, source_count: 2, result_count: if overlap { 1 } else { 0 } }
}

/// 并集 / Union: a ∪ b.
///
/// 对标 ArcGIS Pro Union。
/// 模拟策略：面积 = a + b - intersect。
pub fn overlay_union(a : Polygon, b : Polygon) -> OverlayResult {
  let aa = polygon_area(a)
  let ba = polygon_area(b)
  let inter = overlay_intersect(a, b)
  let area = aa + ba - inter.area
  { kind: Union, area, has_overlap: inter.has_overlap, source_count: 2, result_count: if inter.has_overlap { 1 } else { 2 } }
}

/// 擦除 / Erase: a - b.
///
/// 对标 ArcGIS Pro Erase。
/// 模拟策略：面积 = a - intersect。
pub fn overlay_erase(a : Polygon, b : Polygon) -> OverlayResult {
  let aa = polygon_area(a)
  let inter = overlay_intersect(a, b)
  let area = if aa >= inter.area { aa - inter.area } else { 0.0 }
  { kind: Erase, area, has_overlap: inter.has_overlap, source_count: 2, result_count: 1 }
}

/// 身份 / Identity: a 保留，b 中与 a 相交部分保留。
///
/// 对标 ArcGIS Pro Identity。
/// 模拟策略：面积 = a + (b 中与 a 不相交部分 = 0)。
pub fn overlay_identity(a : Polygon, b : Polygon) -> OverlayResult {
  let aa = polygon_area(a)
  let inter = overlay_intersect(a, b)
  { kind: Identity, area: aa, has_overlap: inter.has_overlap, source_count: 2, result_count: 1 }
}

/// 对称差 / Symmetrical Difference: (a ∪ b) - (a ∩ b).
///
/// 对标 ArcGIS Pro Symmetrical Difference。
/// 模拟策略：面积 = a + b - 2 * intersect。
pub fn overlay_sym_diff(a : Polygon, b : Polygon) -> OverlayResult {
  let aa = polygon_area(a)
  let ba = polygon_area(b)
  let inter = overlay_intersect(a, b)
  let area = aa + ba - 2.0 * inter.area
  let safe_area = if area < 0.0 { 0.0 } else { area }
  { kind: SymDiff, area: safe_area, has_overlap: inter.has_overlap, source_count: 2, result_count: if inter.has_overlap { 2 } else { 2 } }
}

/// 更新 / Update: a 中与 b 相交部分用 b 替换。
///
/// 对标 ArcGIS Pro Update。
/// 模拟策略：面积 = a - intersect + b_intersect_part。
pub fn overlay_update(a : Polygon, b : Polygon) -> OverlayResult {
  let aa = polygon_area(a)
  let inter = overlay_intersect(a, b)
  let area = if inter.has_overlap {
    aa - inter.area + inter.area
  } else {
    aa
  }
  { kind: Union, area, has_overlap: inter.has_overlap, source_count: 2, result_count: 1 }
}

// ============================================================
// 空间连接 / Spatial join
// ============================================================

/// 空间连接 / Spatial join: 返回所有包围盒相交的 (i, j) 对。
///
/// 对标 ArcGIS Pro Spatial Join。
/// 退化安全：任一数组为空返回空数组。
pub fn overlay_spatial_join(polys_a : Array[Polygon], polys_b : Array[Polygon]) -> Array[(Int, Int)] {
  let na = polys_a.length()
  let nb = polys_b.length()
  if na == 0 || nb == 0 {
    []
  } else {
    let result : Array[(Int, Int)] = []
    for i in 0..<na {
      for j in 0..<nb {
        if bbox_overlap(polys_a[i], polys_b[j]) {
          result.push((i, j))
        }
      }
    }
    result
  }
}

/// 批量相交检测 / Batch intersect test: 返回所有相交对。
///
/// 退化安全：少于 2 个多边形返回空数组。
pub fn batch_intersections(polys : Array[Polygon]) -> Array[(Int, Int)] {
  let n = polys.length()
  if n < 2 {
    []
  } else {
    let result : Array[(Int, Int)] = []
    for i in 0..<n {
      for j in (i + 1)..<n {
        if bbox_overlap(polys[i], polys[j]) {
          result.push((i, j))
        }
      }
    }
    result
  }
}

// ============================================================
// DataObject 集成 / DataObject integration
// ============================================================

/// 从 DataObject 提取多边形 / Extract polygon from DataObject.
///
/// 格式：content 为 "x1,y1;x2,y2;..." 格式的顶点串。
/// 退化安全：空内容返回空多边形。
pub fn polygon_from_dataobject(d : @dataobject.DataObject) -> Polygon {
  let vertices = @proximity.points_from_dataobject(d)
  make_polygon(vertices)
}

/// 叠加结果摘要 / Overlay result summary.
///
/// 返回字符串摘要：kind + area + overlap。
pub fn overlay_result_summary(result : OverlayResult) -> String {
  let kind_str = match result.kind {
    Intersect => "intersect"
    Union => "union"
    Erase => "erase"
    Identity => "identity"
    SymDiff => "sym_diff"
  }
  let overlap_str = if result.has_overlap { "true" } else { "false" }
  "kind=" + kind_str + ",area=" + double_to_string(result.area) + ",overlap=" + overlap_str
}

/// 简易 double 转字符串 / Simple double to string.
fn double_to_string(d : Double) -> String {
  if d == 0.0 {
    "0"
  } else {
    let int_part = d.to_int()
    let frac = d - int_part.to_double()
    if frac == 0.0 {
      int_part.to_string()
    } else {
      let mut s = int_part.to_string() + "."
      let mut f = frac
      for _ in 0..<4 {
        f = f * 10.0
        let digit = f.to_int()
        s = s + digit.to_string()
        f = f - digit.to_double()
      }
      s
    }
  }
}