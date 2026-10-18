///|
/// # opcore/proximity 邻近分析 / Proximity Analysis
///
/// Buffer / Thiessen / Near / Point Distance。对标 ArcGIS Pro 邻近分析工具集。
/// S4.1 填充：MoonBit 无 GIS 几何引擎，采用**契约 + 模拟实现**策略。
/// 对标 ArcGIS Pro: Buffer / Multiple Ring Buffer / Thiessen Polygons / Near / Point Distance / Polygon Neighbors。
///
/// # Proximity analysis
///
/// Buffer / Thiessen / Near / Point Distance. Aligned with ArcGIS Pro Proximity toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 二维点 / 2D point.
pub struct Point {
  x : Double
  y : Double
} derive(Debug, Eq)

pub extend Point with Eq::{equal, not_equal}
pub extend Point with Debug::{to_repr}

/// 几何类型 / Geometry kind.
pub(all) enum GeometryKind {
  PointGeom   // 点
  LineGeom    // 线
  PolygonGeom // 面
} derive(Debug, Eq)

pub extend GeometryKind with Eq::{equal, not_equal}
pub extend GeometryKind with Debug::{to_repr}

/// 缓冲区结果 / Buffer result.
pub struct BufferResult {
  center : Point
  radius : Double
  area : Double        // π * r²
  perimeter : Double   // 2π * r
} derive(Debug, Eq)

pub extend BufferResult with Eq::{equal, not_equal}
pub extend BufferResult with Debug::{to_repr}

/// 邻近对 / Proximity pair: from-to-distance.
pub struct ProximityPair {
  from_idx : Int
  to_idx : Int
  distance : Double
} derive(Debug, Eq)

pub extend ProximityPair with Eq::{equal, not_equal}
pub extend ProximityPair with Debug::{to_repr}

/// 近邻结果 / Near result: index + distance.
pub struct NearResult {
  nearest_idx : Int
  distance : Double
} derive(Debug, Eq)

pub extend NearResult with Eq::{equal, not_equal}
pub extend NearResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

/// 构造点 / Build a point.
pub fn make_point(x : Double, y : Double) -> Point {
  { x, y }
}

/// 构造缓冲区结果 / Build a buffer result.
pub fn make_buffer_result(center : Point, radius : Double) -> BufferResult {
  { center, radius, area: buffer_area(radius), perimeter: buffer_perimeter(radius) }
}

// ============================================================
// 距离计算 / Distance computation
// ============================================================

/// 欧氏距离 / Euclidean distance.
///
/// 公式：`sqrt((x2-x1)² + (y2-y1)²)`。
/// 退化安全：同点返回 0.0。
pub fn euclidean_distance(a : Point, b : Point) -> Double {
  let dx = b.x - a.x
  let dy = b.y - a.y
  (dx * dx + dy * dy).sqrt()
}

/// 曼哈顿距离 / Manhattan distance.
///
/// 公式：`|x2-x1| + |y2-y1|`。
pub fn manhattan_distance(a : Point, b : Point) -> Double {
  let dx = b.x - a.x
  let dy = b.y - a.y
  (if dx >= 0.0 { dx } else { -dx }) + (if dy >= 0.0 { dy } else { -dy })
}

/// 点到点集距离向量 / Distances from a point to all candidates.
///
/// 退化安全：空候选集返回空数组。
pub fn distances_to_all(target : Point, candidates : Array[Point]) -> Array[Double] {
  candidates.map(fn(p) { euclidean_distance(target, p) })
}

/// 点对距离矩阵 / Pairwise distance matrix.
///
/// 返回 n×n 矩阵，对角线为 0.0。
/// 退化安全：空集返回空数组。
pub fn point_distance_matrix(points : Array[Point]) -> Array[Array[Double]] {
  let n = points.length()
  let result : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      if i == j {
        row.push(0.0)
      } else {
        row.push(euclidean_distance(points[i], points[j]))
      }
    }
    result.push(row)
  }
  result
}

// ============================================================
// 缓冲区分析 / Buffer analysis
// ============================================================

/// 缓冲区面积 / Buffer area: π * r².
///
/// 退化安全：负半径返回 0.0。
pub fn buffer_area(radius : Double) -> Double {
  if radius <= 0.0 {
    0.0
  } else {
    3.141592653589793 * radius * radius
  }
}

/// 缓冲区周长 / Buffer perimeter: 2π * r.
///
/// 退化安全：负半径返回 0.0。
pub fn buffer_perimeter(radius : Double) -> Double {
  if radius <= 0.0 {
    0.0
  } else {
    2.0 * 3.141592653589793 * radius
  }
}

/// 点缓冲区 / Point buffer: 以点为圆心创建圆形缓冲区。
///
/// 对标 ArcGIS Pro Buffer。
/// 退化安全：负半径返回 radius=0 的退化缓冲区。
pub fn buffer_point(center : Point, radius : Double) -> BufferResult {
  let r = if radius < 0.0 { 0.0 } else { radius }
  make_buffer_result(center, r)
}

/// 多环缓冲区 / Multiple ring buffer.
///
/// 对标 ArcGIS Pro Multiple Ring Buffer。
/// 按半径升序排列，每环独立计算。
/// 退化安全：空半径数组返回空结果。
pub fn multi_ring_buffer(center : Point, radii : Array[Double]) -> Array[BufferResult] {
  let sorted = radii.copy()
  sorted.sort_by(fn(a, b) { compare_double(a, b) })
  sorted.map(fn(r) { buffer_point(center, r) })
}

/// 比较双精度 / Compare doubles for sorting.
fn compare_double(a : Double, b : Double) -> Int {
  if a < b {
    -1
  } else if a > b {
    1
  } else {
    0
  }
}

// ============================================================
// 近邻分析 / Near analysis
// ============================================================

/// 最近点 / Nearest point: 返回最近候选点的索引和距离。
///
/// 对标 ArcGIS Pro Near。
/// 退化安全：空候选集返回 None。
pub fn nearest_point(target : Point, candidates : Array[Point]) -> NearResult? {
  let n = candidates.length()
  if n == 0 {
    None
  } else {
    let mut best_idx = 0
    let mut best_dist = euclidean_distance(target, candidates[0])
    for i in 1..<n {
      let d = euclidean_distance(target, candidates[i])
      if d < best_dist {
        best_dist = d
        best_idx = i
      }
    }
    Some({ nearest_idx: best_idx, distance: best_dist })
  }
}

/// K 近邻表 / K-nearest near table.
///
/// 对标 ArcGIS Pro Generate Near Table。
/// 返回距离升序排列的前 k 个邻近对。
/// 退化安全：k<=0 或空候选集返回空数组。
pub fn near_table(target_idx : Int, target : Point, candidates : Array[Point], k : Int) -> Array[ProximityPair] {
  let n = candidates.length()
  if k <= 0 || n == 0 {
    []
  } else {
    let pairs : Array[ProximityPair] = []
    for i in 0..<n {
      pairs.push({ from_idx: target_idx, to_idx: i, distance: euclidean_distance(target, candidates[i]) })
    }
    pairs.sort_by(fn(a, b) { compare_double(a.distance, b.distance) })
    let limit = if k < n { k } else { n }
    let result : Array[ProximityPair] = []
    for i in 0..<limit {
      result.push(pairs[i])
    }
    result
  }
}

/// 全局邻近对 / All proximity pairs: 所有点对的邻近关系。
///
/// 返回所有 (i, j) 对的距离（i < j），按距离升序。
/// 退化安全：少于 2 个点返回空数组。
pub fn all_proximity_pairs(points : Array[Point]) -> Array[ProximityPair] {
  let n = points.length()
  if n < 2 {
    []
  } else {
    let pairs : Array[ProximityPair] = []
    for i in 0..<n {
      for j in (i + 1)..<n {
        pairs.push({ from_idx: i, to_idx: j, distance: euclidean_distance(points[i], points[j]) })
      }
    }
    pairs.sort_by(fn(a, b) { compare_double(a.distance, b.distance) })
    pairs
  }
}

// ============================================================
// 泰森多边形 / Thiessen (Voronoi) polygons
// ============================================================

/// 泰森多边形面积估计 / Thiessen polygon area estimate.
///
/// 基于点集包围盒均分估计每个 Voronoi 单元的面积。
/// 公式：`total_area / n`（均匀估计）。
/// 退化安全：空集返回空数组。
pub fn thiessen_polygons(points : Array[Point]) -> Array[(Point, Double)] {
  let n = points.length()
  if n == 0 {
    []
  } else if n == 1 {
    [(points[0], 0.0)]
  } else {
    let bbox = bounding_box(points)
    let total_area = (bbox.1.x - bbox.0.x) * (bbox.1.y - bbox.0.y)
    let cell_area = total_area / n.to_double()
    points.map(fn(p) { (p, cell_area) })
  }
}

/// 包围盒 / Bounding box: 返回 (min_point, max_point)。
///
/// 退化安全：空集返回 ((0,0),(0,0))。
pub fn bounding_box(points : Array[Point]) -> (Point, Point) {
  let n = points.length()
  if n == 0 {
    (make_point(0.0, 0.0), make_point(0.0, 0.0))
  } else {
    let mut min_x = points[0].x
    let mut max_x = points[0].x
    let mut min_y = points[0].y
    let mut max_y = points[0].y
    for i in 1..<n {
      if points[i].x < min_x {
        min_x = points[i].x
      }
      if points[i].x > max_x {
        max_x = points[i].x
      }
      if points[i].y < min_y {
        min_y = points[i].y
      }
      if points[i].y > max_y {
        max_y = points[i].y
      }
    }
    (make_point(min_x, min_y), make_point(max_x, max_y))
  }
}

// ============================================================
// 多边形邻接 / Polygon neighbors
// ============================================================

/// 多边形邻接对 / Polygon neighbor pairs.
///
/// 基于包围盒距离阈值判断邻接。两个多边形包围盒距离 <= threshold 则视为邻接。
/// 返回所有邻接对 (i, j)，i < j。
/// 退化安全：少于 2 个多边形返回空数组。
pub fn polygon_neighbors(polygons : Array[Array[Point]], threshold : Double) -> Array[(Int, Int)] {
  let n = polygons.length()
  if n < 2 {
    []
  } else {
    let bboxes = polygons.map(fn(poly) { bounding_box(poly) })
    let neighbors : Array[(Int, Int)] = []
    for i in 0..<n {
      for j in (i + 1)..<n {
        let dist = bbox_distance(bboxes[i], bboxes[j])
        if dist <= threshold {
          neighbors.push((i, j))
        }
      }
    }
    neighbors
  }
}

/// 包围盒间距离 / Distance between two bounding boxes.
fn bbox_distance(a : (Point, Point), b : (Point, Point)) -> Double {
  let a_min = a.0
  let a_max = a.1
  let b_min = b.0
  let b_max = b.1
  let dx = if a_max.x < b_min.x {
    b_min.x - a_max.x
  } else if b_max.x < a_min.x {
    a_min.x - b_max.x
  } else {
    0.0
  }
  let dy = if a_max.y < b_min.y {
    b_min.y - a_max.y
  } else if b_max.y < a_min.y {
    a_min.y - b_max.y
  } else {
    0.0
  }
  (dx * dx + dy * dy).sqrt()
}

// ============================================================
// DataObject 集成 / DataObject integration
// ============================================================

/// 从 DataObject 提取点集 / Extract points from DataObject.
///
/// 格式：content 为 "x1,y1;x2,y2;..." 格式的点串。
/// 退化安全：空内容或解析失败返回空数组。
pub fn points_from_dataobject(d : @dataobject.DataObject) -> Array[Point] {
  let content = d.content
  if content.length() == 0 {
    []
  } else {
    let result : Array[Point] = []
    let parts = content.split(";").to_array()
    for part in parts {
      let part_str = part.to_owned()
      let coords = part_str.split(",").to_array()
      if coords.length() >= 2 {
        let x = parse_double(coords[0].to_owned())
        let y = parse_double(coords[1].to_owned())
        result.push(make_point(x, y))
      }
    }
    result
  }
}

/// 简易 double 解析 / Simple double parser.
///
/// 支持 "3.14" / "-2.5" / "0" 格式。解析失败返回 0.0。
fn parse_double(s : String) -> Double {
  let trimmed = s.trim().to_owned()
  if trimmed.length() == 0 {
    0.0
  } else {
    let chars = trimmed.to_array()
    let n = chars.length()
    let mut i = 0
    let mut negative = false
    if n > 0 && chars[0] == '-' {
      negative = true
      i = 1
    } else if n > 0 && chars[0] == '+' {
      i = 1
    }
    let mut int_part = 0.0
    while i < n && chars[i] != '.' {
      if chars[i] >= '0' && chars[i] <= '9' {
        int_part = int_part * 10.0 + (chars[i].to_int() - 48).to_double()
      } else {
        break
      }
      i += 1
    }
    let mut frac_part = 0.0
    let mut frac_scale = 0.1
    if i < n && chars[i] == '.' {
      i += 1
      while i < n {
        if chars[i] >= '0' && chars[i] <= '9' {
          frac_part = frac_part + (chars[i].to_int() - 48).to_double() * frac_scale
          frac_scale = frac_scale * 0.1
        } else {
          break
        }
        i += 1
      }
    }
    let result = int_part + frac_part
    if negative { -result } else { result }
  }
}

/// 点集缓冲区统计 / Buffer statistics for a point set.
///
/// 对每个点创建缓冲区，返回总面积和总周长。
/// 退化安全：空点集返回 (0.0, 0.0)。
pub fn buffer_stats(points : Array[Point], radius : Double) -> (Double, Double) {
  let n = points.length()
  if n == 0 || radius <= 0.0 {
    (0.0, 0.0)
  } else {
    let area = buffer_area(radius) * n.to_double()
    let perimeter = buffer_perimeter(radius) * n.to_double()
    (area, perimeter)
  }
}