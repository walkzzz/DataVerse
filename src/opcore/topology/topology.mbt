///|
/// # opcore/topology 拓扑分析算子 / Topology Analysis Operators
///
/// 拓扑分析算子契约 + 简化实现。架构 §4.3 opcore 扩展。
/// S8.2 新建：Build/Validate/Edit/Relation +18 fn。
/// 对标 ArcGIS Pro Topology 扩展。
///
/// # Topology analysis operators

/// 点 / Point.
pub struct TopoPoint {
  x : Double
  y : Double
}

/// 多边形（简化为顶点列表）/ Polygon (simplified as vertex list).
pub struct TopoPolygon {
  vertices : Array[TopoPoint]
}

/// 拓扑错误 / Topology error.
pub struct TopologyError {
  error_type : String
  geometry_id1 : Int
  geometry_id2 : Int
  description : String
}

/// 拓扑关系类型 / Topology relation type.
pub(all) enum TopoRelation {
  Equal
  Disjoint
  Touches
  Intersects
  Crosses
  Within
  Contains
  Overlaps
}

/// 构造点 / Create point.
pub fn make_topo_point(x : Double, y : Double) -> TopoPoint {
  { x, y }
}

/// 构造多边形 / Create polygon.
pub fn make_topo_polygon(vertices : Array[TopoPoint]) -> TopoPolygon {
  { vertices: vertices }
}

/// 包围盒 / Bounding box (min_x, min_y, max_x, max_y).
fn bounding_box(poly : TopoPolygon) -> (Double, Double, Double, Double) {
  if poly.vertices.length() == 0 {
    return (0.0, 0.0, 0.0, 0.0)
  }
  let mut min_x = poly.vertices[0].x
  let mut min_y = poly.vertices[0].y
  let mut max_x = poly.vertices[0].x
  let mut max_y = poly.vertices[0].y
  for i in 1..<poly.vertices.length() {
    let p = poly.vertices[i]
    if p.x < min_x {
      min_x = p.x
    }
    if p.y < min_y {
      min_y = p.y
    }
    if p.x > max_x {
      max_x = p.x
    }
    if p.y > max_y {
      max_y = p.y
    }
  }
  (min_x, min_y, max_x, max_y)
}

/// 包围盒相交 / Bounding box intersection check.
fn bbox_intersects(
  b1 : (Double, Double, Double, Double),
  b2 : (Double, Double, Double, Double),
) -> Bool {
  let (min_x1, min_y1, max_x1, max_y1) = b1
  let (min_x2, min_y2, max_x2, max_y2) = b2
  !(max_x1 < min_x2 || max_x2 < min_x1 || max_y1 < min_y2 || max_y2 < min_y1)
}

///===
/// 拓扑关系判定

/// 判断相等 / Check equal (same bounding box).
pub fn check_equal(p1 : TopoPolygon, p2 : TopoPolygon) -> Bool {
  let b1 = bounding_box(p1)
  let b2 = bounding_box(p2)
  let (min_x1, min_y1, max_x1, max_y1) = b1
  let (min_x2, min_y2, max_x2, max_y2) = b2
  min_x1 == min_x2 && min_y1 == min_y2 && max_x1 == max_x2 && max_y1 == max_y2
}

/// 判断不相交 / Check disjoint.
pub fn check_disjoint(p1 : TopoPolygon, p2 : TopoPolygon) -> Bool {
  let b1 = bounding_box(p1)
  let b2 = bounding_box(p2)
  !bbox_intersects(b1, b2)
}

/// 判断相交 / Check intersects.
pub fn check_intersect(p1 : TopoPolygon, p2 : TopoPolygon) -> Bool {
  let b1 = bounding_box(p1)
  let b2 = bounding_box(p2)
  bbox_intersects(b1, b2)
}

/// 判断接触 / Check touches (bbox edges touch but don't overlap interior).
pub fn check_touches(p1 : TopoPolygon, p2 : TopoPolygon) -> Bool {
  let b1 = bounding_box(p1)
  let b2 = bounding_box(p2)
  let (min_x1, min_y1, max_x1, max_y1) = b1
  let (min_x2, min_y2, max_x2, max_y2) = b2
  let edge_touch = (max_x1 == min_x2 || max_x2 == min_x1 || max_y1 == min_y2 || max_y2 == min_y1)
  let overlap = bbox_intersects(b1, b2)
  edge_touch && overlap
}

/// 判断包含 / Check contains (p1 contains p2).
pub fn check_contains(p1 : TopoPolygon, p2 : TopoPolygon) -> Bool {
  let (min_x1, min_y1, max_x1, max_y1) = bounding_box(p1)
  let (min_x2, min_y2, max_x2, max_y2) = bounding_box(p2)
  min_x1 <= min_x2 && min_y1 <= min_y2 && max_x1 >= max_x2 && max_y1 >= max_y2
}

/// 判断在内 / Check within (p1 within p2).
pub fn check_within(p1 : TopoPolygon, p2 : TopoPolygon) -> Bool {
  check_contains(p2, p1)
}

/// 判断交叉 / Check crosses (bbox overlap but neither contains the other).
pub fn check_crosses(p1 : TopoPolygon, p2 : TopoPolygon) -> Bool {
  let b1 = bounding_box(p1)
  let b2 = bounding_box(p2)
  bbox_intersects(b1, b2) && !check_contains(p1, p2) && !check_contains(p2, p1)
}

/// 判断重叠 / Check overlaps.
pub fn check_overlaps(p1 : TopoPolygon, p2 : TopoPolygon) -> Bool {
  check_crosses(p1, p2)
}

/// 获取拓扑关系 / Get topology relation.
pub fn get_relation(p1 : TopoPolygon, p2 : TopoPolygon) -> TopoRelation {
  if check_equal(p1, p2) {
    return Equal
  }
  if check_disjoint(p1, p2) {
    return Disjoint
  }
  if check_contains(p1, p2) {
    return Contains
  }
  if check_within(p1, p2) {
    return Within
  }
  if check_touches(p1, p2) {
    return Touches
  }
  if check_crosses(p1, p2) {
    return Crosses
  }
  if check_overlaps(p1, p2) {
    return Overlaps
  }
  Intersects
}

/// 关系名称 / Relation name.
pub fn relation_name(rel : TopoRelation) -> String {
  match rel {
    Equal => "equal"
    Disjoint => "disjoint"
    Touches => "touches"
    Intersects => "intersects"
    Crosses => "crosses"
    Within => "within"
    Contains => "contains"
    Overlaps => "overlaps"
  }
}

///===
/// 拓扑验证

/// 验证重叠 / Validate overlap (find overlapping polygons).
pub fn validate_overlap(
  polygons : Array[TopoPolygon],
) -> Array[TopologyError] {
  let errors : Array[TopologyError] = []
  let n = polygons.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if check_overlaps(polygons[i], polygons[j]) {
        errors.push({
          error_type: "overlap",
          geometry_id1: i,
          geometry_id2: j,
          description: "Polygons " + i.to_string() + " and " + j.to_string() + " overlap",
        })
      }
    }
  }
  errors
}

/// 验证邻接 / Validate adjacency (find adjacent polygons sharing edges).
pub fn check_adjacency(p1 : TopoPolygon, p2 : TopoPolygon) -> Bool {
  check_touches(p1, p2) || check_overlaps(p1, p2)
}

/// 查找共享边 / Find shared edges (simplified: check shared vertices).
pub fn find_shared_edges(p1 : TopoPolygon, p2 : TopoPolygon) -> Array[TopoPoint] {
  let shared : Array[TopoPoint] = []
  for i in 0..<p1.vertices.length() {
    let v1 = p1.vertices[i]
    for j in 0..<p2.vertices.length() {
      let v2 = p2.vertices[j]
      if v1.x == v2.x && v1.y == v2.y {
        shared.push(v1)
      }
    }
  }
  shared
}

/// 验证缝隙 / Validate gaps (find gaps in polygon coverage).
pub fn validate_gap(
  polygons : Array[TopoPolygon],
  coverage_bbox : (Double, Double, Double, Double),
) -> Array[TopologyError] {
  let errors : Array[TopologyError] = []
  let (cov_min_x, cov_min_y, cov_max_x, cov_max_y) = coverage_bbox
  for i in 0..<polygons.length() {
    let (min_x, min_y, max_x, max_y) = bounding_box(polygons[i])
    if min_x > cov_min_x || min_y > cov_min_y || max_x < cov_max_x || max_y < cov_max_y {
      let mut covered = false
      for j in 0..<polygons.length() {
        if j != i {
          if check_contains(polygons[j], polygons[i]) || check_overlaps(polygons[j], polygons[i]) {
            covered = true
            break
          }
        }
      }
      if !covered {
        errors.push({
          error_type: "gap",
          geometry_id1: i,
          geometry_id2: -1,
          description: "Polygon " + i.to_string() + " may have gap with coverage boundary",
        })
      }
    }
  }
  errors
}

/// 验证悬挂节点 / Validate dangling nodes (vertices that appear only once).
pub fn validate_dangling(
  polygons : Array[TopoPolygon],
) -> Array[TopologyError] {
  let errors : Array[TopologyError] = []
  let vertex_count : Array[(TopoPoint, Int, Int)] = []
  for poly_id in 0..<polygons.length() {
    for v in polygons[poly_id].vertices {
      let mut found = false
      for k in 0..<vertex_count.length() {
        let (p, cnt, pid) = vertex_count[k]
        if p.x == v.x && p.y == v.y {
          ignore(vertex_count.remove(k))
          vertex_count.push((p, cnt + 1, pid))
          found = true
          break
        }
      }
      if !found {
        vertex_count.push((v, 1, poly_id))
      }
    }
  }
  for i in 0..<vertex_count.length() {
    let (p, cnt, pid) = vertex_count[i]
    if cnt == 1 {
      errors.push({
        error_type: "dangling",
        geometry_id1: pid,
        geometry_id2: -1,
        description: "Dangling node at (" + p.x.to_string() + ", " + p.y.to_string() + ")",
      })
    }
  }
  errors
}

/// 查找所有拓扑错误 / Find all topology errors.
pub fn topology_errors(
  polygons : Array[TopoPolygon],
) -> Array[TopologyError] {
  let errors : Array[TopologyError] = []
  let overlap_errors = validate_overlap(polygons)
  for e in overlap_errors {
    errors.push(e)
  }
  let dangling_errors = validate_dangling(polygons)
  for e in dangling_errors {
    errors.push(e)
  }
  errors
}

///===
/// 拓扑编辑

/// 合并多边形 / Merge polygons (union of bounding boxes).
pub fn merge_polygons(p1 : TopoPolygon, p2 : TopoPolygon) -> TopoPolygon {
  let (min_x1, min_y1, max_x1, max_y1) = bounding_box(p1)
  let (min_x2, min_y2, max_x2, max_y2) = bounding_box(p2)
  let min_x = if min_x1 < min_x2 { min_x1 } else { min_x2 }
  let min_y = if min_y1 < min_y2 { min_y1 } else { min_y2 }
  let max_x = if max_x1 > max_x2 { max_x1 } else { max_x2 }
  let max_y = if max_y1 > max_y2 { max_y1 } else { max_y2 }
  {
    vertices: [
      { x: min_x, y: min_y },
      { x: max_x, y: min_y },
      { x: max_x, y: max_y },
      { x: min_x, y: max_y },
    ],
  }
}

/// 修复重叠 / Fix overlap (merge overlapping polygons).
pub fn fix_overlap(
  polygons : Array[TopoPolygon],
) -> Array[TopoPolygon] {
  let result : Array[TopoPolygon] = []
  let merged : Array[Bool] = Array::make(polygons.length(), false)
  for i in 0..<polygons.length() {
    if merged[i] {
      continue
    }
    let mut current = polygons[i]
    for j in (i + 1)..<polygons.length() {
      if !merged[j] && check_overlaps(current, polygons[j]) {
        current = merge_polygons(current, polygons[j])
        merged[j] = true
      }
    }
    result.push(current)
  }
  result
}

/// 简化多边形 / Simplify polygon (remove duplicate vertices).
pub fn simplify_polygon(poly : TopoPolygon) -> TopoPolygon {
  let result : Array[TopoPoint] = []
  for i in 0..<poly.vertices.length() {
    let v = poly.vertices[i]
    let mut dup = false
    for j in 0..<result.length() {
      if result[j].x == v.x && result[j].y == v.y {
        dup = true
        break
      }
    }
    if !dup {
      result.push(v)
    }
  }
  { vertices: result }
}

/// 多边形面积 / Polygon area (shoelace formula).
pub fn polygon_area(poly : TopoPolygon) -> Double {
  let n = poly.vertices.length()
  if n < 3 {
    return 0.0
  }
  let mut area = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    area = area + (poly.vertices[i].x * poly.vertices[j].y - poly.vertices[j].x * poly.vertices[i].y)
  }
  if area < 0.0 {
    -area / 2.0
  } else {
    area / 2.0
  }
}

/// 多边形周长 / Polygon perimeter.
pub fn polygon_perimeter(poly : TopoPolygon) -> Double {
  let n = poly.vertices.length()
  if n < 2 {
    return 0.0
  }
  let mut peri = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    let dx = poly.vertices[j].x - poly.vertices[i].x
    let dy = poly.vertices[j].y - poly.vertices[i].y
    peri = peri + (dx * dx + dy * dy).sqrt()
  }
  peri
}

///===
/// ID

pub fn topology_id() -> String {
  "opcore/topology"
}