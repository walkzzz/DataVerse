///|
/// # opcore/terrain 地形分析深化算子 / Terrain Analysis Deepening Operators
///
/// 地形分析算子契约 + 简化实现。架构 §4.3 opcore 扩展。
/// S8.3 新建：TPI/SPI/VRM/Roughness/Slope/Aspect/Hillshade/Curvature/Flow +15 fn。
/// 对标 ArcGIS Pro Spatial Analyst → Surface & Hydrology 扩展。
///
/// # Terrain analysis operators

///|
/// DEM（数字高程模型）/ DEM (Digital Elevation Model).
pub struct DEM {
  elevations : Array[Array[Double]]
  cell_size : Double
}

///|
/// 构造 DEM / Create DEM.
pub fn terrain_make_dem(elevations : Array[Array[Double]], cell_size : Double) -> DEM {
  { elevations, cell_size, }
}

///|
/// DEM 行数 / DEM row count.
pub fn terrain_dem_rows(dem : DEM) -> Int32 {
  dem.elevations.length()
}

///|
/// DEM 列数 / DEM column count.
pub fn terrain_dem_cols(dem : DEM) -> Int32 {
  if dem.elevations.length() == 0 {
    0
  } else {
    dem.elevations[0].length()
  }
}

///|
/// 安全获取高程 / Safe elevation access.
fn terrain_get_elev(dem : DEM, row : Int32, col : Int32) -> Double {
  let rows = dem.elevations.length()
  if rows == 0 {
    return 0.0
  }
  let cols = dem.elevations[0].length()
  let r = if row < 0 { 0 } else if row >= rows { rows - 1 } else { row }
  let c = if col < 0 { 0 } else if col >= cols { cols - 1 } else { col }
  dem.elevations[r][c]
}

///|
/// 正弦近似 / Sine approximation (Taylor series).
fn terrain_sin_(x : Double) -> Double {
  let mut x = x
  let two_pi = 6.283185307179586
  let pi = 3.141592653589793
  while x > pi {
    x = x - two_pi
  }
  while x < -pi {
    x = x + two_pi
  }
  let mut result = x
  let mut term = x
  let x2 = x * x
  for i in 1..<10 {
    term = term * x2 / ((2 * i).to_double() * (2 * i + 1).to_double()) * -1.0
    result = result + term
  }
  result
}

///|
/// 余弦近似 / Cosine approximation.
fn terrain_cos_(x : Double) -> Double {
  terrain_sin_(x + 1.5707963267948966)
}

///|
/// 正切近似 / Tangent approximation.
fn terrain_tan_(x : Double) -> Double {
  let c = terrain_cos_(x)
  if c == 0.0 {
    999999.0
  } else {
    terrain_sin_(x) / c
  }
}

///|
/// 反正切近似 / Arctangent approximation.
fn terrain_atan_(x : Double) -> Double {
  let pi = 3.141592653589793
  let abs_x = if x < 0.0 { -x } else { x }
  let sign = if x < 0.0 { -1.0 } else { 1.0 }
  if abs_x > 1.0 {
    sign * (pi / 2.0 - terrain_atan_taylor_(1.0 / abs_x))
  } else {
    sign * terrain_atan_taylor_(abs_x)
  }
}

///|
fn terrain_atan_taylor_(x : Double) -> Double {
  let mut result = 0.0
  let mut x_pow = x
  for n in 0..<50 {
    let term = x_pow / (2 * n + 1).to_double()
    if n % 2 == 0 {
      result = result + term
    } else {
      result = result - term
    }
    x_pow = x_pow * x * x
    if term < 0.0000001 && term > -0.0000001 {
      break
    }
  }
  result
}

///|
/// 反正切2 / atan2.
fn terrain_atan2_(y : Double, x : Double) -> Double {
  let pi = 3.141592653589793
  if x > 0.0 {
    terrain_atan_(y / x)
  } else if x < 0.0 && y >= 0.0 {
    terrain_atan_(y / x) + pi
  } else if x < 0.0 && y < 0.0 {
    terrain_atan_(y / x) - pi
  } else if x == 0.0 && y > 0.0 {
    pi / 2.0
  } else if x == 0.0 && y < 0.0 {
    -pi / 2.0
  } else {
    0.0
  }
}

///===
/// 坡度与坡向

///|
/// 坡度计算 / Slope (Horn's method, degrees).
pub fn terrain_slope(dem : DEM, row : Int32, col : Int32) -> Double {
  let dz_dx = (
      terrain_get_elev(dem, row - 1, col + 1) +
      2.0 * terrain_get_elev(dem, row, col + 1) +
      terrain_get_elev(dem, row + 1, col + 1) -
      terrain_get_elev(dem, row - 1, col - 1) -
      2.0 * terrain_get_elev(dem, row, col - 1) -
      terrain_get_elev(dem, row + 1, col - 1)
    ) /
    (8.0 * dem.cell_size)
  let dz_dy = (
      terrain_get_elev(dem, row + 1, col - 1) +
      2.0 * terrain_get_elev(dem, row + 1, col) +
      terrain_get_elev(dem, row + 1, col + 1) -
      terrain_get_elev(dem, row - 1, col - 1) -
      2.0 * terrain_get_elev(dem, row - 1, col) -
      terrain_get_elev(dem, row - 1, col + 1)
    ) /
    (8.0 * dem.cell_size)
  let slope_rad = terrain_atan_((dz_dx * dz_dx + dz_dy * dz_dy).sqrt())
  slope_rad * 180.0 / 3.141592653589793
}

///|
/// 坡向计算 / Aspect (Horn's method, degrees).
pub fn terrain_aspect(dem : DEM, row : Int32, col : Int32) -> Double {
  let dz_dx = (
      terrain_get_elev(dem, row - 1, col + 1) +
      2.0 * terrain_get_elev(dem, row, col + 1) +
      terrain_get_elev(dem, row + 1, col + 1) -
      terrain_get_elev(dem, row - 1, col - 1) -
      2.0 * terrain_get_elev(dem, row, col - 1) -
      terrain_get_elev(dem, row + 1, col - 1)
    ) /
    (8.0 * dem.cell_size)
  let dz_dy = (
      terrain_get_elev(dem, row + 1, col - 1) +
      2.0 * terrain_get_elev(dem, row + 1, col) +
      terrain_get_elev(dem, row + 1, col + 1) -
      terrain_get_elev(dem, row - 1, col - 1) -
      2.0 * terrain_get_elev(dem, row - 1, col) -
      terrain_get_elev(dem, row - 1, col + 1)
    ) /
    (8.0 * dem.cell_size)
  if dz_dx == 0.0 && dz_dy == 0.0 {
    return 0.0
  }
  let aspect_rad = terrain_atan2_(dz_dx, dz_dy)
  let mut aspect_deg = aspect_rad * 180.0 / 3.141592653589793
  if aspect_deg < 0.0 {
    aspect_deg = 90.0 - aspect_deg
  } else if aspect_deg > 90.0 {
    aspect_deg = 360.0 - aspect_deg + 90.0
  } else {
    aspect_deg = 90.0 - aspect_deg
  }
  if aspect_deg < 0.0 {
    aspect_deg = aspect_deg + 360.0
  }
  aspect_deg
}

///|
/// 山体阴影 / Hillshade.
pub fn terrain_hillshade(
  dem : DEM,
  row : Int32,
  col : Int32,
  azimuth : Double,
  altitude : Double,
) -> Double {
  let slope_rad = terrain_slope(dem, row, col) * 3.141592653589793 / 180.0
  let aspect_rad = terrain_aspect(dem, row, col) * 3.141592653589793 / 180.0
  let zenith_rad = (90.0 - altitude) * 3.141592653589793 / 180.0
  let azimuth_rad = (360.0 - azimuth + 90.0) * 3.141592653589793 / 180.0
  let hs = 255.0 *
    (
      terrain_cos_(zenith_rad) * terrain_cos_(slope_rad) +
      terrain_sin_(azimuth_rad) * terrain_sin_(slope_rad) * terrain_cos_(aspect_rad)
    )
  if hs < 0.0 {
    0.0
  } else {
    hs
  }
}

///===
/// 地形指数

///|
/// TPI（地形位置指数）/ Topographic Position Index.
pub fn terrain_tpi(dem : DEM, row : Int32, col : Int32) -> Double {
  let mut sum = 0.0
  let mut count = 0
  for dr in -1..<=1 {
    for dc in -1..<=1 {
      if dr == 0 && dc == 0 {
        continue
      }
      sum = sum + terrain_get_elev(dem, row + dr, col + dc)
      count = count + 1
    }
  }
  if count == 0 {
    return 0.0
  }
  terrain_get_elev(dem, row, col) - sum / count.to_double()
}

///|
/// 粗糙度 / Roughness (standard deviation of elevation in 3x3 window).
pub fn terrain_roughness(dem : DEM, row : Int32, col : Int32) -> Double {
  let vals : Array[Double] = []
  for dr in -1..<=1 {
    for dc in -1..<=1 {
      vals.push(terrain_get_elev(dem, row + dr, col + dc))
    }
  }
  let n = vals.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + vals[i]
  }
  let mean = sum / n.to_double()
  let mut variance = 0.0
  for i in 0..<n {
    let diff = vals[i] - mean
    variance = variance + diff * diff
  }
  (variance / n.to_double()).sqrt()
}

///|
/// VRM（矢量粗糙度测度）/ Vector Ruggedness Measure (simplified).
pub fn terrain_vrm(dem : DEM, row : Int32, col : Int32) -> Double {
  let s = terrain_slope(dem, row, col) * 3.141592653589793 / 180.0
  let a = terrain_aspect(dem, row, col) * 3.141592653589793 / 180.0
  let x = terrain_sin_(s) * terrain_cos_(a)
  let y = terrain_sin_(s) * terrain_sin_(a)
  let z = terrain_cos_(s)
  let mut sum_x = 0.0
  let mut sum_y = 0.0
  let mut sum_z = 0.0
  let mut count = 0
  for dr in -1..<=1 {
    for dc in -1..<=1 {
      if dr == 0 && dc == 0 {
        continue
      }
      let s_n = terrain_slope(dem, row + dr, col + dc) * 3.141592653589793 / 180.0
      let a_n = terrain_aspect(dem, row + dr, col + dc) * 3.141592653589793 / 180.0
      sum_x = sum_x + terrain_sin_(s_n) * terrain_cos_(a_n)
      sum_y = sum_y + terrain_sin_(s_n) * terrain_sin_(a_n)
      sum_z = sum_z + terrain_cos_(s_n)
      count = count + 1
    }
  }
  if count == 0 {
    return 0.0
  }
  let mean_x = sum_x / count.to_double()
  let mean_y = sum_y / count.to_double()
  let mean_z = sum_z / count.to_double()
  let mag = (mean_x * mean_x + mean_y * mean_y + mean_z * mean_z).sqrt()
  ignore(x)
  ignore(y)
  ignore(z)
  1.0 - mag
}

///|
/// SPI（河流动力指数）/ Stream Power Index (simplified).
pub fn terrain_spi(dem : DEM, row : Int32, col : Int32, flow_acc : Double) -> Double {
  let s = terrain_slope(dem, row, col) * 3.141592653589793 / 180.0
  let tan_s = terrain_tan_(s)
  if tan_s <= 0.0 {
    return 0.0
  }
  flow_acc * tan_s
}

///===
/// 曲率

///|
/// 剖面曲率 / Profile curvature (simplified).
pub fn terrain_profile_curvature(dem : DEM, row : Int32, col : Int32) -> Double {
  let d2z_dx2 = terrain_get_elev(dem, row, col - 1) -
    2.0 * terrain_get_elev(dem, row, col) +
    terrain_get_elev(dem, row, col + 1)
  let d2z_dy2 = terrain_get_elev(dem, row - 1, col) -
    2.0 * terrain_get_elev(dem, row, col) +
    terrain_get_elev(dem, row + 1, col)
  (d2z_dx2 + d2z_dy2) / 2.0
}

///|
/// 平面曲率 / Plan curvature (simplified).
pub fn terrain_plan_curvature(dem : DEM, row : Int32, col : Int32) -> Double {
  let d2z_dxdy = (
      terrain_get_elev(dem, row + 1, col + 1) -
      terrain_get_elev(dem, row + 1, col - 1) -
      terrain_get_elev(dem, row - 1, col + 1) +
      terrain_get_elev(dem, row - 1, col - 1)
    ) /
    4.0
  d2z_dxdy
}

///|
/// 总曲率 / Total curvature.
pub fn terrain_total_curvature(dem : DEM, row : Int32, col : Int32) -> Double {
  let prof = terrain_profile_curvature(dem, row, col)
  let plan = terrain_plan_curvature(dem, row, col)
  prof * prof + plan * plan
}

///===
/// 水文分析

///|
/// 流向 / Flow direction (D8 method, returns direction code 0-7).
pub fn terrain_flow_direction(dem : DEM, row : Int32, col : Int32) -> Int32 {
  let drops = [
    terrain_get_elev(dem, row, col) - terrain_get_elev(dem, row - 1, col),
    terrain_get_elev(dem, row, col) - terrain_get_elev(dem, row - 1, col + 1),
    terrain_get_elev(dem, row, col) - terrain_get_elev(dem, row, col + 1),
    terrain_get_elev(dem, row, col) - terrain_get_elev(dem, row + 1, col + 1),
    terrain_get_elev(dem, row, col) - terrain_get_elev(dem, row + 1, col),
    terrain_get_elev(dem, row, col) - terrain_get_elev(dem, row + 1, col - 1),
    terrain_get_elev(dem, row, col) - terrain_get_elev(dem, row, col - 1),
    terrain_get_elev(dem, row, col) - terrain_get_elev(dem, row - 1, col - 1),
  ]
  let mut max_drop = 0.0
  let mut max_dir = -1
  for i in 0..<8 {
    if drops[i] > max_drop {
      max_drop = drops[i]
      max_dir = i
    }
  }
  max_dir
}

///|
/// 流向累积 / Flow accumulation (simplified, count upstream cells).
pub fn terrain_flow_accumulation(dem : DEM, row : Int32, col : Int32) -> Double {
  let rows = terrain_dem_rows(dem)
  let cols = terrain_dem_cols(dem)
  let mut count = 0.0
  for r in 0..<rows {
    for c in 0..<cols {
      if r == row && c == col {
        continue
      }
      let dir = terrain_flow_direction(dem, r, c)
      let (nr, nc) = match dir {
        0 => (r - 1, c)
        1 => (r - 1, c + 1)
        2 => (r, c + 1)
        3 => (r + 1, c + 1)
        4 => (r + 1, c)
        5 => (r + 1, c - 1)
        6 => (r, c - 1)
        7 => (r - 1, c - 1)
        _ => (r, c)
      }
      if nr == row && nc == col {
        count = count + 1.0
      }
    }
  }
  count + 1.0
}

///===
/// 等值线

///|
/// 等值线生成 / Generate contour (simplified, find cells at elevation).
pub fn terrain_generate_contour(
  dem : DEM,
  elevation : Double,
  tolerance : Double,
) -> Array[(Int32, Int32)] {
  let result : Array[(Int32, Int32)] = []
  let rows = terrain_dem_rows(dem)
  let cols = terrain_dem_cols(dem)
  for r in 0..<rows {
    for c in 0..<cols {
      let diff = dem.elevations[r][c] - elevation
      if diff < 0.0 {
        let neg_diff = -diff
        if neg_diff <= tolerance {
          result.push((r, c))
        }
      } else if diff <= tolerance {
        result.push((r, c))
      }
    }
  }
  result
}

///===
/// 高程统计

///|
/// 高程统计 / Elevation statistics.
pub fn terrain_elevation_stats(dem : DEM) -> (Double, Double, Double, Double) {
  let rows = terrain_dem_rows(dem)
  let cols = terrain_dem_cols(dem)
  if rows == 0 || cols == 0 {
    return (0.0, 0.0, 0.0, 0.0)
  }
  let mut min_e = dem.elevations[0][0]
  let mut max_e = dem.elevations[0][0]
  let mut sum = 0.0
  let mut count = 0
  for r in 0..<rows {
    for c in 0..<cols {
      let e = dem.elevations[r][c]
      if e < min_e {
        min_e = e
      }
      if e > max_e {
        max_e = e
      }
      sum = sum + e
      count = count + 1
    }
  }
  let mean = sum / count.to_double()
  (min_e, max_e, mean, max_e - min_e)
}

///|
///===
/// ID
pub fn terrain_terrain_id() -> String {
  "opcore/terrain"
}
