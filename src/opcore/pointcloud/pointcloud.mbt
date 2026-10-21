///|
/// # opcore/pointcloud 点云处理算子 / Point Cloud Processing Operators
///
/// 点云处理算子契约 + 简化实现。架构 §4.3 opcore 扩展。
/// S9.5 新建：Filter/Downsample/Segment/Normal/Feature +15 fn。
/// 对标 ArcGIS Pro 3D Analyst → Point Cloud 扩展。
///
/// # Point cloud operators

///|
/// 点云 / Point cloud.
pub struct PointCloud {
  points : Array[(Double, Double, Double)]
}

///|
/// 构造点云 / Create point cloud.
pub fn make_point_cloud(points : Array[(Double, Double, Double)]) -> PointCloud {
  { points, }
}

///|
/// 点云大小 / Point cloud size.
pub fn pointcloud_size(cloud : PointCloud) -> Int32 {
  cloud.points.length()
}

///|
/// 点云质心 / Point cloud centroid.
pub fn pointcloud_centroid(cloud : PointCloud) -> (Double, Double, Double) {
  let n = cloud.points.length()
  if n == 0 {
    return (0.0, 0.0, 0.0)
  }
  let mut sum_x = 0.0
  let mut sum_y = 0.0
  let mut sum_z = 0.0
  for i in 0..<n {
    let (x, y, z) = cloud.points[i]
    sum_x = sum_x + x
    sum_y = sum_y + y
    sum_z = sum_z + z
  }
  (sum_x / n.to_double(), sum_y / n.to_double(), sum_z / n.to_double())
}

///|
/// 点云包围盒 / Point cloud bounding box.
pub fn pointcloud_bbox(
  cloud : PointCloud,
) -> ((Double, Double, Double), (Double, Double, Double)) {
  if cloud.points.length() == 0 {
    return ((0.0, 0.0, 0.0), (0.0, 0.0, 0.0))
  }
  let (x0, y0, z0) = cloud.points[0]
  let mut min_x = x0
  let mut min_y = y0
  let mut min_z = z0
  let mut max_x = x0
  let mut max_y = y0
  let mut max_z = z0
  for i in 1..<cloud.points.length() {
    let (x, y, z) = cloud.points[i]
    if x < min_x {
      min_x = x
    }
    if y < min_y {
      min_y = y
    }
    if z < min_z {
      min_z = z
    }
    if x > max_x {
      max_x = x
    }
    if y > max_y {
      max_y = y
    }
    if z > max_z {
      max_z = z
    }
  }
  ((min_x, min_y, min_z), (max_x, max_y, max_z))
}

///|
/// 高程滤波 / Elevation filter (keep points within z range).
pub fn elevation_filter(
  cloud : PointCloud,
  min_z : Double,
  max_z : Double,
) -> PointCloud {
  let result : Array[(Double, Double, Double)] = []
  for i in 0..<cloud.points.length() {
    let (x, y, z) = cloud.points[i]
    if z >= min_z && z <= max_z {
      result.push((x, y, z))
    }
  }
  { points: result, }
}

///|
/// 体素下采样 / Voxel grid downsample.
pub fn voxel_downsample(cloud : PointCloud, voxel_size : Double) -> PointCloud {
  if voxel_size <= 0.0 {
    return cloud
  }
  let seen : Array[(Int32, Int32, Int32)] = []
  let result : Array[(Double, Double, Double)] = []
  for i in 0..<cloud.points.length() {
    let (x, y, z) = cloud.points[i]
    let vx = (x / voxel_size).to_int()
    let vy = (y / voxel_size).to_int()
    let vz = (z / voxel_size).to_int()
    let mut found = false
    for j in 0..<seen.length() {
      let (sx, sy, sz) = seen[j]
      if sx == vx && sy == vy && sz == vz {
        found = true
        break
      }
    }
    if !found {
      seen.push((vx, vy, vz))
      result.push((x, y, z))
    }
  }
  { points: result, }
}

///|
/// 半径滤波 / Radius outlier removal (simplified, keep points with enough neighbors).
pub fn radius_outlier_removal(
  cloud : PointCloud,
  radius : Double,
  min_neighbors : Int32,
) -> PointCloud {
  let result : Array[(Double, Double, Double)] = []
  for i in 0..<cloud.points.length() {
    let (x1, y1, z1) = cloud.points[i]
    let mut count = 0
    for j in 0..<cloud.points.length() {
      if i == j {
        continue
      }
      let (x2, y2, z2) = cloud.points[j]
      let dx = x2 - x1
      let dy = y2 - y1
      let dz = z2 - z1
      let dist = (dx * dx + dy * dy + dz * dz).sqrt()
      if dist <= radius {
        count = count + 1
      }
    }
    if count >= min_neighbors {
      result.push((x1, y1, z1))
    }
  }
  { points: result, }
}

///|
/// 点云平移 / Translate point cloud.
pub fn pointcloud_translate(
  cloud : PointCloud,
  dx : Double,
  dy : Double,
  dz : Double,
) -> PointCloud {
  let result : Array[(Double, Double, Double)] = []
  for i in 0..<cloud.points.length() {
    let (x, y, z) = cloud.points[i]
    result.push((x + dx, y + dy, z + dz))
  }
  { points: result, }
}

///|
/// 点云缩放 / Scale point cloud.
pub fn pointcloud_scale(
  cloud : PointCloud,
  sx : Double,
  sy : Double,
  sz : Double,
) -> PointCloud {
  let result : Array[(Double, Double, Double)] = []
  for i in 0..<cloud.points.length() {
    let (x, y, z) = cloud.points[i]
    result.push((x * sx, y * sy, z * sz))
  }
  { points: result, }
}

///|
/// 平均点间距 / Average point spacing.
pub fn average_spacing(cloud : PointCloud) -> Double {
  let n = cloud.points.length()
  if n <= 1 {
    return 0.0
  }
  let mut total = 0.0
  let mut count = 0
  for i in 0..<n {
    let (x1, y1, z1) = cloud.points[i]
    let mut min_dist = 999999.0
    for j in 0..<n {
      if i == j {
        continue
      }
      let (x2, y2, z2) = cloud.points[j]
      let dx = x2 - x1
      let dy = y2 - y1
      let dz = z2 - z1
      let dist = (dx * dx + dy * dy + dz * dz).sqrt()
      if dist < min_dist {
        min_dist = dist
      }
    }
    if min_dist < 999999.0 {
      total = total + min_dist
      count = count + 1
    }
  }
  if count == 0 {
    return 0.0
  }
  total / count.to_double()
}

///|
/// 高程统计 / Elevation statistics.
pub fn elevation_stats(cloud : PointCloud) -> (Double, Double, Double) {
  let n = cloud.points.length()
  if n == 0 {
    return (0.0, 0.0, 0.0)
  }
  let mut min_z = cloud.points[0].2
  let mut max_z = cloud.points[0].2
  let mut sum_z = 0.0
  for i in 0..<n {
    let z = cloud.points[i].2
    if z < min_z {
      min_z = z
    }
    if z > max_z {
      max_z = z
    }
    sum_z = sum_z + z
  }
  (min_z, max_z, sum_z / n.to_double())
}

///|
/// 点密度 / Point density (points per cubic unit).
pub fn point_density(cloud : PointCloud) -> Double {
  let n = cloud.points.length()
  if n == 0 {
    return 0.0
  }
  let ((min_x, min_y, min_z), (max_x, max_y, max_z)) = pointcloud_bbox(cloud)
  let volume = (max_x - min_x) * (max_y - min_y) * (max_z - min_z)
  if volume == 0.0 {
    return 0.0
  }
  n.to_double() / volume
}

///|
///===
/// ID
pub fn pointcloud_id() -> String {
  "opcore/pointcloud"
}
