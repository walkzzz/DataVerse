///|
/// # opcore/solar 太阳辐射 / Solar Radiation
///
/// Solar Radiation (Area / Point)。
/// 对标 ArcGIS Pro 太阳辐射工具集（3 工具）。
/// S5.2 填充：太阳位置计算 + 辐射通量模拟。
///
/// # Solar radiation
///
/// Area / Point solar radiation. Aligned with ArcGIS Pro Solar Radiation toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

///|
/// 太阳辐射配置 / Solar radiation configuration.
pub struct SolarConfig {
  latitude : Double // 纬度（度）
  longitude : Double // 经度（度）
  day_of_year : Int32 // 年中天数（1-365）
  hour : Double // 小时（0-24）
  diffuse_ratio : Double // 散射比例（0-1）
} derive(Debug, Eq)

///|
pub extend SolarConfig with Eq::{equal, not_equal}

///|
pub extend SolarConfig with Debug::{to_repr}

///|
/// 太阳辐射结果 / Solar radiation result.
pub struct SolarResult {
  global_radiation : Double // 全球辐射
  direct_radiation : Double // 直接辐射
  diffuse_radiation : Double // 散射辐射
  duration : Double // 日照时长（小时）
  altitude : Double // 太阳高度角（度）
  azimuth : Double // 太阳方位角（度）
} derive(Debug, Eq)

///|
pub extend SolarResult with Eq::{equal, not_equal}

///|
pub extend SolarResult with Debug::{to_repr}

///|
/// 太阳辐射区域结果 / Solar radiation area result.
pub struct SolarAreaResult {
  cell_row : Int32
  cell_col : Int32
  result : SolarResult
} derive(Debug, Eq)

///|
pub extend SolarAreaResult with Eq::{equal, not_equal}

///|
pub extend SolarAreaResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

///|
/// 构造太阳辐射配置 / Build solar config.
pub fn make_solar_config(
  latitude : Double,
  longitude : Double,
  day_of_year : Int32,
  hour : Double,
  diffuse_ratio : Double,
) -> SolarConfig {
  let dr = if diffuse_ratio < 0.0 {
    0.0
  } else if diffuse_ratio > 1.0 {
    1.0
  } else {
    diffuse_ratio
  }
  let dy = if day_of_year < 1 {
    1
  } else if day_of_year > 365 {
    365
  } else {
    day_of_year
  }
  let h = if hour < 0.0 { 0.0 } else if hour > 24.0 { 24.0 } else { hour }
  { latitude, longitude, day_of_year: dy, hour: h, diffuse_ratio: dr, }
}

///|
/// 构造太阳辐射结果 / Build solar result.
pub fn make_solar_result(
  global : Double,
  direct : Double,
  diffuse : Double,
  duration : Double,
  altitude : Double,
  azimuth : Double,
) -> SolarResult {
  {
    global_radiation: global,
    direct_radiation: direct,
    diffuse_radiation: diffuse,
    duration,
    altitude,
    azimuth,
  }
}

///|
/// 构造区域结果 / Build area result.
pub fn make_solar_area_result(
  row : Int32,
  col : Int32,
  result : SolarResult,
) -> SolarAreaResult {
  { cell_row: row, cell_col: col, result, }
}

// ============================================================
// 数学辅助 / Math helpers
// ============================================================

///|
fn deg_to_rad(deg : Double) -> Double {
  deg * 3.14159265358979323846 / 180.0
}

///|
fn rad_to_deg(rad : Double) -> Double {
  rad * 180.0 / 3.14159265358979323846
}

///|
fn sin_custom(x : Double) -> Double {
  let pi = 3.141592653589793
  let mut val = x
  while val > pi {
    val = val - 2.0 * pi
  }
  while val < -pi {
    val = val + 2.0 * pi
  }
  let mut result = 0.0
  let mut term = val
  let x_sq = val * val
  for n in 0..<10 {
    let sign = if n % 2 == 0 { 1.0 } else { -1.0 }
    result = result + sign * term
    term = term * x_sq / ((2 * n + 2) * (2 * n + 3)).to_double()
  }
  result
}

///|
fn cos_custom(x : Double) -> Double {
  sin_custom(x + 1.5707963267948966)
}

///|
fn sin_deg(deg : Double) -> Double {
  sin_custom(deg_to_rad(deg))
}

///|
fn cos_deg(deg : Double) -> Double {
  cos_custom(deg_to_rad(deg))
}

///|
fn atan_custom(x : Double) -> Double {
  let pi = 3.14159265358979323846
  let abs_x = if x < 0.0 { -x } else { x }
  let sign = if x < 0.0 { -1.0 } else { 1.0 }
  if abs_x > 1.0 {
    sign * (pi / 2.0 - atan_taylor(1.0 / abs_x))
  } else {
    sign * atan_taylor(abs_x)
  }
}

///|
fn atan_taylor(x : Double) -> Double {
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
fn asin_deg(x : Double) -> Double {
  let x_clamped = if x > 1.0 { 1.0 } else if x < -1.0 { -1.0 } else { x }
  let val = 1.0 - x_clamped * x_clamped
  let sqrt_val = if val > 0.0 { val.sqrt() } else { 0.0 }
  rad_to_deg(atan_custom(x_clamped / (sqrt_val + 0.0000001)))
}

///|
fn acos_deg(x : Double) -> Double {
  let x_clamped = if x > 1.0 { 1.0 } else if x < -1.0 { -1.0 } else { x }
  let val = 1.0 - x_clamped * x_clamped
  let sqrt_val = if val > 0.0 { val.sqrt() } else { 0.0 }
  let pi = 3.14159265358979323846
  if x_clamped >= 0.0 {
    rad_to_deg(atan_custom(sqrt_val / (x_clamped + 0.0000001)))
  } else {
    rad_to_deg(pi - atan_custom(sqrt_val / (-x_clamped + 0.0000001)))
  }
}

// ============================================================
// 太阳位置 / Solar position
// ============================================================

///|
/// 太阳赤纬角 / Solar declination angle (degrees).
///
/// 公式：δ = 23.45° × sin(360° × (284 + n) / 365)
pub fn solar_declination(day_of_year : Int32) -> Double {
  let n = day_of_year.to_double()
  23.45 * sin_deg(360.0 * (284.0 + n) / 365.0)
}

///|
/// 太阳时角 / Solar hour angle (degrees).
///
/// 正午 12 点时角为 0，上午为负，下午为正。
/// 公式：ω = 15° × (hour - 12)
pub fn solar_hour_angle(hour : Double) -> Double {
  15.0 * (hour - 12.0)
}

///|
/// 太阳高度角 / Solar altitude angle (degrees).
///
/// 公式：sin(α) = sin(φ)sin(δ) + cos(φ)cos(δ)cos(ω)
/// 退化安全：α < 0 返回 0（太阳在地平线下）。
pub fn solar_altitude(
  latitude : Double,
  day_of_year : Int32,
  hour : Double,
) -> Double {
  let decl = solar_declination(day_of_year)
  let ha = solar_hour_angle(hour)
  let sin_alt = sin_deg(latitude) * sin_deg(decl) +
    cos_deg(latitude) * cos_deg(decl) * cos_deg(ha)
  let alt = asin_deg(sin_alt)
  if alt < 0.0 {
    0.0
  } else {
    alt
  }
}

///|
/// 太阳方位角 / Solar azimuth angle (degrees).
///
/// 公式：cos(γ) = (sin(δ) - sin(α)sin(φ)) / (cos(α)cos(φ))
/// 退化安全：太阳在地平线下返回 0。
pub fn solar_azimuth(
  latitude : Double,
  day_of_year : Int32,
  hour : Double,
) -> Double {
  let alt = solar_altitude(latitude, day_of_year, hour)
  if alt <= 0.0 {
    0.0
  } else {
    let decl = solar_declination(day_of_year)
    let cos_az = (sin_deg(decl) - sin_deg(alt) * sin_deg(latitude)) /
      (cos_deg(alt) * cos_deg(latitude))
    let az = acos_deg(cos_az)
    if hour < 12.0 {
      -az
    } else {
      az
    }
  }
}

// ============================================================
// 辐射通量 / Radiation flux
// ============================================================

///|
/// 直接辐射 / Direct radiation (W/m²).
///
/// 模拟公式：I_direct = 1000 × sin(α) × (1 - diffuse_ratio)
/// 退化安全：α <= 0 返回 0。
pub fn solar_direct_radiation(
  altitude : Double,
  diffuse_ratio : Double,
) -> Double {
  if altitude <= 0.0 {
    0.0
  } else {
    1000.0 * sin_deg(altitude) * (1.0 - diffuse_ratio)
  }
}

///|
/// 散射辐射 / Diffuse radiation (W/m²).
///
/// 模拟公式：I_diffuse = 1000 × sin(α) × diffuse_ratio
/// 退化安全：α <= 0 返回 0。
pub fn solar_diffuse_radiation(
  altitude : Double,
  diffuse_ratio : Double,
) -> Double {
  if altitude <= 0.0 {
    0.0
  } else {
    1000.0 * sin_deg(altitude) * diffuse_ratio
  }
}

///|
/// 全球辐射 / Global radiation (W/m²).
///
/// 公式：I_global = I_direct + I_diffuse
pub fn solar_global_radiation(
  altitude : Double,
  diffuse_ratio : Double,
) -> Double {
  solar_direct_radiation(altitude, diffuse_ratio) +
  solar_diffuse_radiation(altitude, diffuse_ratio)
}

///|
/// 日照时长 / Sunshine duration (hours).
///
/// 模拟公式：D = 2/15 × acos(-tan(φ)tan(δ))
/// 退化安全：极地夜返回 0。
pub fn solar_duration(latitude : Double, day_of_year : Int32) -> Double {
  let decl = solar_declination(day_of_year)
  let arg = -(sin_deg(latitude) / cos_deg(latitude)) *
    (sin_deg(decl) / cos_deg(decl))
  if arg > 1.0 {
    0.0
  } else if arg < -1.0 {
    24.0
  } else {
    2.0 / 15.0 * acos_deg(arg)
  }
}

// ============================================================
// 太阳辐射计算 / Solar radiation calculation
// ============================================================

///|
/// 点太阳辐射 / Solar radiation at a point.
///
/// 退化安全：太阳在地平线下返回全 0 结果。
pub fn solar_radiation_point(config : SolarConfig) -> SolarResult {
  let alt = solar_altitude(config.latitude, config.day_of_year, config.hour)
  let az = solar_azimuth(config.latitude, config.day_of_year, config.hour)
  let direct = solar_direct_radiation(alt, config.diffuse_ratio)
  let diffuse = solar_diffuse_radiation(alt, config.diffuse_ratio)
  let global = direct + diffuse
  let dur = solar_duration(config.latitude, config.day_of_year)
  make_solar_result(global, direct, diffuse, dur, alt, az)
}

///|
/// 区域太阳辐射 / Solar radiation over an area (using DEM raster).
///
/// 对每个单元格根据高程调整辐射（简化：高程不影响辐射值）。
/// 退化安全：空栅格返回空数组。
pub fn solar_radiation_area(
  dem : @hydrology.RasterGrid,
  config : SolarConfig,
) -> Array[Array[SolarAreaResult]] {
  let rows = @hydrology.raster_rows(dem)
  let cols = @hydrology.raster_cols(dem)
  let result : Array[Array[SolarAreaResult]] = []
  for i in 0..<rows {
    let row : Array[SolarAreaResult] = []
    for j in 0..<cols {
      let r = solar_radiation_point(config)
      row.push(make_solar_area_result(i, j, r))
    }
    result.push(row)
  }
  result
}

///|
/// 太阳辐射统计 / Solar radiation grid statistics.
///
/// 返回 (global_mean, direct_mean, diffuse_mean, total_cells)。
/// 退化安全：空数组返回 (0, 0, 0, 0)。
pub fn solar_radiation_stats(
  results : Array[Array[SolarAreaResult]],
) -> (Double, Double, Double, Int32) {
  let rows = results.length()
  if rows == 0 {
    (0.0, 0.0, 0.0, 0)
  } else {
    let mut sum_global = 0.0
    let mut sum_direct = 0.0
    let mut sum_diffuse = 0.0
    let mut count = 0
    for i in 0..<rows {
      for j in 0..<results[i].length() {
        let r = results[i][j].result
        sum_global = sum_global + r.global_radiation
        sum_direct = sum_direct + r.direct_radiation
        sum_diffuse = sum_diffuse + r.diffuse_radiation
        count += 1
      }
    }
    if count == 0 {
      (0.0, 0.0, 0.0, 0)
    } else {
      let n = count.to_double()
      (sum_global / n, sum_direct / n, sum_diffuse / n, count)
    }
  }
}

///|
/// 太阳辐射结果摘要 / Solar result summary string.
pub fn solar_result_summary(result : SolarResult) -> String {
  let g = result.global_radiation
  let d = result.direct_radiation
  let diff = result.diffuse_radiation
  let dur = result.duration
  let alt = result.altitude
  let az = result.azimuth
  "global=" +
  g.to_string() +
  ", direct=" +
  d.to_string() +
  ", diffuse=" +
  diff.to_string() +
  ", duration=" +
  dur.to_string() +
  ", altitude=" +
  alt.to_string() +
  ", azimuth=" +
  az.to_string()
}
