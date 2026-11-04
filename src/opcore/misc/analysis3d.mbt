///|
/// # opcore/analysis3d 三维分析算子 / 3D Analysis Operators
///
/// 三维分析算子契约 + 简化实现。架构 §4.3 opcore 扩展。
/// S8.4 新建：Viewshed3D/Buffer3D/Distance3D/LineOfSight/Skyline/Volume3D +18 fn。
/// 对标 ArcGIS Pro 3D Analyst 扩展。
///
/// # 3D analysis operators

///|
/// 三维点 / 3D point.
pub struct Point3D {
  x : Double
  y : Double
  z : Double
}

///|
/// 三维包围盒 / 3D bounding box.
pub struct BBox3D {
  min_x : Double
  min_y : Double
  min_z : Double
  max_x : Double
  max_y : Double
  max_z : Double
}

///|
/// 构造三维点 / Create 3D point.
pub fn analysis3d_make_point3d(x : Double, y : Double, z : Double) -> Point3D {
  { x, y, z, }
}

///|
/// 构造三维包围盒 / Create 3D bounding box.
pub fn analysis3d_make_bbox3d(
  min_x : Double,
  min_y : Double,
  min_z : Double,
  max_x : Double,
  max_y : Double,
  max_z : Double,
) -> BBox3D {
  { min_x, min_y, min_z, max_x, max_y, max_z, }
}

///===
/// 三维距离

///|
/// 三维欧氏距离 / 3D Euclidean distance.
pub fn analysis3d_distance3d(p1 : Point3D, p2 : Point3D) -> Double {
  let dx = p2.x - p1.x
  let dy = p2.y - p1.y
  let dz = p2.z - p1.z
  (dx * dx + dy * dy + dz * dz).sqrt()
}

///|
/// 三维曼哈顿距离 / 3D Manhattan distance.
pub fn analysis3d_manhattan3d(p1 : Point3D, p2 : Point3D) -> Double {
  let dx = p2.x - p1.x
  let dy = p2.y - p1.y
  let dz = p2.z - p1.z
  let abs_dx = if dx < 0.0 { -dx } else { dx }
  let abs_dy = if dy < 0.0 { -dy } else { dy }
  let abs_dz = if dz < 0.0 { -dz } else { dz }
  abs_dx + abs_dy + abs_dz
}

///|
/// 三维切比雪夫距离 / 3D Chebyshev distance.
pub fn analysis3d_chebyshev3d(p1 : Point3D, p2 : Point3D) -> Double {
  let dx = p2.x - p1.x
  let dy = p2.y - p1.y
  let dz = p2.z - p1.z
  let abs_dx = if dx < 0.0 { -dx } else { dx }
  let abs_dy = if dy < 0.0 { -dy } else { dy }
  let abs_dz = if dz < 0.0 { -dz } else { dz }
  let mut max_d = abs_dx
  if abs_dy > max_d {
    max_d = abs_dy
  }
  if abs_dz > max_d {
    max_d = abs_dz
  }
  max_d
}

///===
/// 三维包围盒

///|
/// 三维包围盒 / Compute 3D bounding box.
pub fn analysis3d_bbox3d(points : Array[Point3D]) -> BBox3D {
  if points.length() == 0 {
    return {
      min_x: 0.0,
      min_y: 0.0,
      min_z: 0.0,
      max_x: 0.0,
      max_y: 0.0,
      max_z: 0.0,
    }
  }
  let mut min_x = points[0].x
  let mut min_y = points[0].y
  let mut min_z = points[0].z
  let mut max_x = points[0].x
  let mut max_y = points[0].y
  let mut max_z = points[0].z
  for i in 1..<points.length() {
    let p = points[i]
    if p.x < min_x {
      min_x = p.x
    }
    if p.y < min_y {
      min_y = p.y
    }
    if p.z < min_z {
      min_z = p.z
    }
    if p.x > max_x {
      max_x = p.x
    }
    if p.y > max_y {
      max_y = p.y
    }
    if p.z > max_z {
      max_z = p.z
    }
  }
  { min_x, min_y, min_z, max_x, max_y, max_z, }
}

///|
/// 包围盒体积 / Bounding box volume.
pub fn analysis3d_bbox3d_volume(bbox : BBox3D) -> Double {
  (bbox.max_x - bbox.min_x) *
  (bbox.max_y - bbox.min_y) *
  (bbox.max_z - bbox.min_z)
}

///|
/// 包围盒中心 / Bounding box center.
pub fn analysis3d_bbox3d_center(bbox : BBox3D) -> Point3D {
  {
    x: (bbox.min_x + bbox.max_x) / 2.0,
    y: (bbox.min_y + bbox.max_y) / 2.0,
    z: (bbox.min_z + bbox.max_z) / 2.0,
  }
}

///===
/// 三维缓冲

///|
/// 三维缓冲 / 3D buffer (simplified, returns bounding box expanded by radius).
pub fn analysis3d_buffer3d(point : Point3D, radius : Double) -> BBox3D {
  {
    min_x: point.x - radius,
    min_y: point.y - radius,
    min_z: point.z - radius,
    max_x: point.x + radius,
    max_y: point.y + radius,
    max_z: point.z + radius,
  }
}

///===
/// 视线分析

///|
/// 视线分析 / Line of sight (simplified, check if target is visible from observer).
pub fn analysis3d_line_of_sight(
  observer : Point3D,
  target : Point3D,
  obstacles : Array[Point3D],
) -> Bool {
  for i in 0..<obstacles.length() {
    let obs = obstacles[i]
    let d_total = analysis3d_distance3d(observer, target)
    if d_total == 0.0 {
      continue
    }
    let d_obs = analysis3d_distance3d(observer, obs)
    if d_obs >= d_total {
      continue
    }
    let t = d_obs / d_total
    let expected_z = observer.z + t * (target.z - observer.z)
    if obs.z > expected_z {
      return false
    }
  }
  true
}

///|
/// 可视域分析 / Viewshed 3D (simplified, count visible points).
pub fn analysis3d_viewshed3d(
  observer : Point3D,
  targets : Array[Point3D],
  obstacles : Array[Point3D],
) -> Int32 {
  let mut count = 0
  for i in 0..<targets.length() {
    if analysis3d_line_of_sight(observer, targets[i], obstacles) {
      count = count + 1
    }
  }
  count
}

///===
/// 天际线

///|
/// 天际线分析 / Skyline (simplified, find max z for each direction).
pub fn analysis3d_skyline(
  observer : Point3D,
  points : Array[Point3D],
  n_directions : Int32,
) -> Array[Double] {
  let result : Array[Double] = Array::make(n_directions, 0.0)
  for i in 0..<points.length() {
    let p = points[i]
    let dx = p.x - observer.x
    let dy = p.y - observer.y
    let mut angle = 0.0
    if dx == 0.0 && dy == 0.0 {
      continue
    }
    if dx == 0.0 {
      angle = if dy > 0.0 { 1.5707963267948966 } else { -1.5707963267948966 }
    } else {
      angle = dy / dx
      if dx < 0.0 {
        angle = angle + 3.141592653589793
      }
    }
    let dir_idx = (
        (angle / 6.283185307179586 * n_directions.to_double()).to_int() %
        n_directions +
        n_directions
      ) %
      n_directions
    if p.z > result[dir_idx] {
      result[dir_idx] = p.z
    }
  }
  result
}

///===
/// 体积与表面积

///|
/// 三维体积 / 3D volume (simplified, using bounding box).
pub fn analysis3d_volume3d(points : Array[Point3D]) -> Double {
  if points.length() < 4 {
    return 0.0
  }
  let bbox = analysis3d_bbox3d(points)
  analysis3d_bbox3d_volume(bbox)
}

///|
/// 表面积 / Surface area (simplified, using bounding box faces).
pub fn analysis3d_surface_area3d(points : Array[Point3D]) -> Double {
  if points.length() < 4 {
    return 0.0
  }
  let bbox = analysis3d_bbox3d(points)
  let w = bbox.max_x - bbox.min_x
  let h = bbox.max_y - bbox.min_y
  let d = bbox.max_z - bbox.min_z
  2.0 * (w * h + w * d + h * d)
}

///===
/// 三维变换

///|
/// 平移 / Translate 3D point.
pub fn analysis3d_translate3d(
  point : Point3D,
  dx : Double,
  dy : Double,
  dz : Double,
) -> Point3D {
  { x: point.x + dx, y: point.y + dy, z: point.z + dz, }
}

///|
/// 缩放 / Scale 3D point.
pub fn analysis3d_scale3d(
  point : Point3D,
  sx : Double,
  sy : Double,
  sz : Double,
) -> Point3D {
  { x: point.x * sx, y: point.y * sy, z: point.z * sz, }
}

///|
/// 质心 / Centroid 3D.
pub fn analysis3d_centroid3d(points : Array[Point3D]) -> Point3D {
  let n = points.length()
  if n == 0 {
    return { x: 0.0, y: 0.0, z: 0.0, }
  }
  let mut sum_x = 0.0
  let mut sum_y = 0.0
  let mut sum_z = 0.0
  for i in 0..<n {
    sum_x = sum_x + points[i].x
    sum_y = sum_y + points[i].y
    sum_z = sum_z + points[i].z
  }
  {
    x: sum_x / n.to_double(),
    y: sum_y / n.to_double(),
    z: sum_z / n.to_double(),
  }
}

///===
/// 三维相交

///|
/// 包围盒相交 / Bounding box intersection.
pub fn analysis3d_bbox3d_intersects(b1 : BBox3D, b2 : BBox3D) -> Bool {
  !(b1.max_x < b2.min_x ||
  b2.max_x < b1.min_x ||
  b1.max_y < b2.min_y ||
  b2.max_y < b1.min_y ||
  b1.max_z < b2.min_z ||
  b2.max_z < b1.min_z)
}

///|
/// 包围盒包含 / Bounding box contains point.
pub fn analysis3d_bbox3d_contains(bbox : BBox3D, point : Point3D) -> Bool {
  point.x >= bbox.min_x &&
  point.x <= bbox.max_x &&
  point.y >= bbox.min_y &&
  point.y <= bbox.max_y &&
  point.z >= bbox.min_z &&
  point.z <= bbox.max_z
}

///|
///===
/// ID
pub fn analysis3d_analysis3d_id() -> String {
  "opcore/analysis3d"
}
