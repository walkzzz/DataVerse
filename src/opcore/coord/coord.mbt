///|
/// # opcore/coord 坐标变换算子 / Coordinate Transformation Operators
///
/// 坐标变换算子契约 + 简化实现。架构 §4.3 opcore 扩展。
/// S8.6 新建：Projection/Transform/Datum/GreatCircle/Bearing +20 fn。
/// 对标 ArcGIS Pro Projections and Transformations 扩展。
///
/// # Coordinate transformation operators

///|
/// 大地坐标 / Geodetic coordinate (lon, lat in degrees).
pub struct GeodeticCoord {
  lon : Double
  lat : Double
}

///|
/// 投影坐标 / Projected coordinate (x, y in meters).
pub struct ProjectedCoord {
  x : Double
  y : Double
}

///|
/// 仿射变换参数 / Affine transformation parameters.
pub struct AffineTransform {
  a : Double
  b : Double
  c : Double
  d : Double
  e : Double
  f : Double
}

///|
/// 构造大地坐标 / Create geodetic coordinate.
pub fn make_geodetic(lon : Double, lat : Double) -> GeodeticCoord {
  { lon, lat, }
}

///|
/// 构造投影坐标 / Create projected coordinate.
pub fn make_projected(x : Double, y : Double) -> ProjectedCoord {
  { x, y, }
}

///|
/// 构造仿射变换 / Create affine transform.
pub fn make_affine(
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double,
) -> AffineTransform {
  { a, b, c, d, e, f, }
}

///|
/// 正弦近似 / Sine approximation.
fn sin_(x : Double) -> Double {
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
fn cos_(x : Double) -> Double {
  sin_(x + 1.5707963267948966)
}

///|
/// 反正切近似 / Arctangent approximation.
fn atan_(x : Double) -> Double {
  let pi = 3.141592653589793
  let abs_x = if x < 0.0 { -x } else { x }
  let sign = if x < 0.0 { -1.0 } else { 1.0 }
  if abs_x > 1.0 {
    sign * (pi / 2.0 - atan_taylor_(1.0 / abs_x))
  } else {
    sign * atan_taylor_(abs_x)
  }
}

///|
fn atan_taylor_(x : Double) -> Double {
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

///===
/// Web Mercator 投影

///|
/// WGS84 → Web Mercator / WGS84 to Web Mercator.
pub fn wgs84_to_web_mercator(coord : GeodeticCoord) -> ProjectedCoord {
  let r = 6378137.0
  let x = r * coord.lon * 3.141592653589793 / 180.0
  let lat_rad = coord.lat * 3.141592653589793 / 180.0
  let y = r * ln_((1.0 + sin_(lat_rad)) / (1.0 - sin_(lat_rad))) / 2.0
  { x, y, }
}

///|
/// Web Mercator → WGS84 / Web Mercator to WGS84.
pub fn web_mercator_to_wgs84(coord : ProjectedCoord) -> GeodeticCoord {
  let r = 6378137.0
  let lon = coord.x / r * 180.0 / 3.141592653589793
  let lat_rad = 2.0 * atan_(exp_(coord.y / r)) - 3.141592653589793 / 2.0
  let lat = lat_rad * 180.0 / 3.141592653589793
  { lon, lat, }
}

///|
/// 自然对数 / Natural log.
fn ln_(x : Double) -> Double {
  if x <= 0.0 {
    return -999999.0
  }
  let mut result = 0.0
  let t = (x - 1.0) / (x + 1.0)
  let t2 = t * t
  let mut term = t
  for k in 0..<50 {
    result = result + term / (2 * k + 1).to_double()
    term = term * t2
  }
  2.0 * result
}

///|
/// 指数 / Exponential.
fn exp_(x : Double) -> Double {
  if x > 20.0 {
    return 485165195.4
  }
  if x < -20.0 {
    return 0.0
  }
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<50 {
    term = term * x / i.to_double()
    result = result + term
  }
  result
}

///===
/// UTM 投影（简化）

///|
/// WGS84 → UTM / WGS84 to UTM (simplified).
pub fn wgs84_to_utm(coord : GeodeticCoord, zone : Int32) -> ProjectedCoord {
  let lon_ref = (zone * 6 - 183).to_double()
  let r = 6378137.0
  let x = r * (coord.lon - lon_ref) * 3.141592653589793 / 180.0
  let y = r * coord.lat * 3.141592653589793 / 180.0
  { x, y, }
}

///|
/// UTM → WGS84 / UTM to WGS84 (simplified).
pub fn utm_to_wgs84(coord : ProjectedCoord, zone : Int32) -> GeodeticCoord {
  let lon_ref = (zone * 6 - 183).to_double()
  let r = 6378137.0
  let lon = lon_ref + coord.x / r * 180.0 / 3.141592653589793
  let lat = coord.y / r * 180.0 / 3.141592653589793
  { lon, lat, }
}

///|
/// UTM 区域号 / UTM zone number.
pub fn utm_zone(coord : GeodeticCoord) -> Int32 {
  ((coord.lon + 180.0) / 6.0).to_int() + 1
}

///===
/// 仿射变换

///|
/// 应用仿射变换 / Apply affine transform.
pub fn apply_affine(
  transform : AffineTransform,
  coord : ProjectedCoord,
) -> ProjectedCoord {
  {
    x: transform.a * coord.x + transform.b * coord.y + transform.c,
    y: transform.d * coord.x + transform.e * coord.y + transform.f,
  }
}

///|
/// 单位变换 / Identity transform.
pub fn identity_affine() -> AffineTransform {
  { a: 1.0, b: 0.0, c: 0.0, d: 0.0, e: 1.0, f: 0.0, }
}

///|
/// 平移变换 / Translation transform.
pub fn translation_affine(dx : Double, dy : Double) -> AffineTransform {
  { a: 1.0, b: 0.0, c: dx, d: 0.0, e: 1.0, f: dy, }
}

///|
/// 缩放变换 / Scale transform.
pub fn scale_affine(sx : Double, sy : Double) -> AffineTransform {
  { a: sx, b: 0.0, c: 0.0, d: 0.0, e: sy, f: 0.0, }
}

///===
/// 大圆距离

///|
/// 大圆距离 / Great circle distance (Haversine, meters).
pub fn great_circle_distance(c1 : GeodeticCoord, c2 : GeodeticCoord) -> Double {
  let r = 6371000.0
  let lat1 = c1.lat * 3.141592653589793 / 180.0
  let lat2 = c2.lat * 3.141592653589793 / 180.0
  let dlat = (c2.lat - c1.lat) * 3.141592653589793 / 180.0
  let dlon = (c2.lon - c1.lon) * 3.141592653589793 / 180.0
  let a = sin_(dlat / 2.0) * sin_(dlat / 2.0) +
    cos_(lat1) * cos_(lat2) * sin_(dlon / 2.0) * sin_(dlon / 2.0)
  let c = 2.0 * atan_(a.sqrt() / (1.0 - a).sqrt())
  r * c
}

///|
/// 方位角 / Bearing (degrees).
pub fn bearing(c1 : GeodeticCoord, c2 : GeodeticCoord) -> Double {
  let lat1 = c1.lat * 3.141592653589793 / 180.0
  let lat2 = c2.lat * 3.141592653589793 / 180.0
  let dlon = (c2.lon - c1.lon) * 3.141592653589793 / 180.0
  let y = sin_(dlon) * cos_(lat2)
  let x = cos_(lat1) * sin_(lat2) - sin_(lat1) * cos_(lat2) * cos_(dlon)
  let mut brng = atan2_(y, x) * 180.0 / 3.141592653589793
  brng = (brng + 360.0) % 360.0
  brng
}

///|
/// 反正切2 / atan2.
fn atan2_(y : Double, x : Double) -> Double {
  let pi = 3.141592653589793
  if x > 0.0 {
    atan_(y / x)
  } else if x < 0.0 && y >= 0.0 {
    atan_(y / x) + pi
  } else if x < 0.0 && y < 0.0 {
    atan_(y / x) - pi
  } else if x == 0.0 && y > 0.0 {
    pi / 2.0
  } else if x == 0.0 && y < 0.0 {
    -pi / 2.0
  } else {
    0.0
  }
}

///===
/// 目的地推算

///|
/// 目的地推算 / Destination point given distance and bearing.
pub fn destination_point(
  start : GeodeticCoord,
  distance : Double,
  bearing_deg : Double,
) -> GeodeticCoord {
  let r = 6371000.0
  let lat1 = start.lat * 3.141592653589793 / 180.0
  let lon1 = start.lon * 3.141592653589793 / 180.0
  let brng = bearing_deg * 3.141592653589793 / 180.0
  let d = distance / r
  let lat2 = asin_approx(
    sin_(lat1) * cos_(d) + cos_(lat1) * sin_(d) * cos_(brng),
  )
  let lon2 = lon1 +
    atan2_(sin_(brng) * sin_(d) * cos_(lat1), cos_(d) - sin_(lat1) * sin_(lat2))
  {
    lon: lon2 * 180.0 / 3.141592653589793,
    lat: lat2 * 180.0 / 3.141592653589793,
  }
}

///|
/// 反正弦近似 / Arcsine approximation.
fn asin_approx(x : Double) -> Double {
  if x >= 1.0 {
    return 1.5707963267948966
  }
  if x <= -1.0 {
    return -1.5707963267948966
  }
  atan_(x / (1.0 - x * x).sqrt())
}

///===
/// 度分秒转换

///|
/// 十进制度 → 度分秒 / Decimal degrees to DMS.
pub fn decimal_to_dms(decimal : Double) -> (Int32, Int32, Double) {
  let abs_d = if decimal < 0.0 { -decimal } else { decimal }
  let deg = abs_d.to_int()
  let min_full = (abs_d - deg.to_double()) * 60.0
  let min = min_full.to_int()
  let sec = (min_full - min.to_double()) * 60.0
  (deg, min, sec)
}

///|
/// 度分秒 → 十进制度 / DMS to decimal degrees.
pub fn dms_to_decimal(deg : Int32, min : Int32, sec : Double) -> Double {
  let abs_deg = if deg < 0 { -deg } else { deg }
  let abs_d = abs_deg.to_double() + min.to_double() / 60.0 + sec / 3600.0
  if deg < 0 {
    -abs_d
  } else {
    abs_d
  }
}

///|
///===
/// ID
pub fn coord_id() -> String {
  "opcore/coord"
}
