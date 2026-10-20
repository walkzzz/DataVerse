///===
/// extcore/geo_dist_ellipsoidal

pub(all) struct GeodistellipsoidalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_ellipsoidal_make_point(x : Double, y : Double) -> GeodistellipsoidalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_ellipsoidal_make_point3(x : Double, y : Double, z : Double) -> GeodistellipsoidalPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistellipsoidalPoint::x(self : GeodistellipsoidalPoint) -> Double { self.x }

pub fn GeodistellipsoidalPoint::y(self : GeodistellipsoidalPoint) -> Double { self.y }

pub fn GeodistellipsoidalPoint::z(self : GeodistellipsoidalPoint) -> Double { self.z }

pub fn GeodistellipsoidalPoint::label(self : GeodistellipsoidalPoint) -> Int { self.label }

pub fn GeodistellipsoidalPoint::dist(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistellipsoidalPoint::add(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistellipsoidalPoint::sub(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistellipsoidalPoint::scale(self : GeodistellipsoidalPoint, s : Double) -> GeodistellipsoidalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistellipsoidalPoint::dot(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistellipsoidalPoint::cross(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistellipsoidalPoint::norm(self : GeodistellipsoidalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistellipsoidalPoint::normalize(self : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistellipsoidalPoint::negate(self : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistellipsoidalPoint::mid(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistellipsoidalPoint::lerp(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint, t : Double) -> GeodistellipsoidalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistellipsoidalPoint::to_string(self : GeodistellipsoidalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistellipsoidalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_ellipsoidal_make_series(vals : Array[Double], name : String) -> GeodistellipsoidalSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistellipsoidalSeries::len(self : GeodistellipsoidalSeries) -> Int { self.vals.length() }

pub fn GeodistellipsoidalSeries::sum(self : GeodistellipsoidalSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistellipsoidalSeries::mean(self : GeodistellipsoidalSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistellipsoidalSeries::min(self : GeodistellipsoidalSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistellipsoidalSeries::max(self : GeodistellipsoidalSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistellipsoidalSeries::range(self : GeodistellipsoidalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistellipsoidalSeries::variance(self : GeodistellipsoidalSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistellipsoidalSeries::std(self : GeodistellipsoidalSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistellipsoidalSeries::median(self : GeodistellipsoidalSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistellipsoidalSeries::scale(self : GeodistellipsoidalSeries, f : Double) -> GeodistellipsoidalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistellipsoidalSeries::add(self : GeodistellipsoidalSeries, other : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistellipsoidalSeries::sub(self : GeodistellipsoidalSeries, other : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistellipsoidalSeries::normalize(self : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistellipsoidalSeries::cumsum(self : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistellipsoidalSeries::to_string(self : GeodistellipsoidalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistellipsoidalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_ellipsoidal_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistellipsoidalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_ellipsoidal_matrix_identity(n : Int) -> GeodistellipsoidalMatrix {
  let m = geo_dist_ellipsoidal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistellipsoidalMatrix::get(self : GeodistellipsoidalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistellipsoidalMatrix::transpose(self : GeodistellipsoidalMatrix) -> GeodistellipsoidalMatrix {
  let result = geo_dist_ellipsoidal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistellipsoidalMatrix::add(self : GeodistellipsoidalMatrix, other : GeodistellipsoidalMatrix) -> GeodistellipsoidalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_ellipsoidal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistellipsoidalMatrix::scale(self : GeodistellipsoidalMatrix, s : Double) -> GeodistellipsoidalMatrix {
  let result = geo_dist_ellipsoidal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistellipsoidalMatrix::multiply(self : GeodistellipsoidalMatrix, other : GeodistellipsoidalMatrix) -> GeodistellipsoidalMatrix {
  if self.cols != other.rows { return geo_dist_ellipsoidal_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_ellipsoidal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistellipsoidalMatrix::trace(self : GeodistellipsoidalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistellipsoidalMatrix::det(self : GeodistellipsoidalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistellipsoidalMatrix::norm(self : GeodistellipsoidalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistellipsoidalMatrix::to_string(self : GeodistellipsoidalMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeodistellipsoidalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_ellipsoidal_make_vector(comps : Array[Double]) -> GeodistellipsoidalVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_ellipsoidal_vector_zero(dim : Int) -> GeodistellipsoidalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistellipsoidalVector::add(self : GeodistellipsoidalVector, other : GeodistellipsoidalVector) -> GeodistellipsoidalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistellipsoidalVector::sub(self : GeodistellipsoidalVector, other : GeodistellipsoidalVector) -> GeodistellipsoidalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistellipsoidalVector::scale(self : GeodistellipsoidalVector, s : Double) -> GeodistellipsoidalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistellipsoidalVector::dot(self : GeodistellipsoidalVector, other : GeodistellipsoidalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistellipsoidalVector::norm(self : GeodistellipsoidalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistellipsoidalVector::normalize(self : GeodistellipsoidalVector) -> GeodistellipsoidalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistellipsoidalVector::dist(self : GeodistellipsoidalVector, other : GeodistellipsoidalVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistellipsoidalVector::to_string(self : GeodistellipsoidalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_ellipsoidal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_ellipsoidal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_ellipsoidal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_ellipsoidal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_ellipsoidal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_ellipsoidal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_ellipsoidal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_ellipsoidal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_ellipsoidal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_ellipsoidal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_ellipsoidal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_ellipsoidal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_ellipsoidal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_ellipsoidal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_ellipsoidal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_ellipsoidal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_ellipsoidal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_ellipsoidal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_ellipsoidal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_ellipsoidal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_ellipsoidal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_ellipsoidal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_ellipsoidal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_ellipsoidal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_ellipsoidal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_ellipsoidal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_ellipsoidal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_ellipsoidal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_ellipsoidal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistellipsoidalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_frame_make(size : Int) -> GeodistellipsoidalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_frame_len(s : GeodistellipsoidalFrame) -> Int { s.size }

pub fn geo_dist_ellipsoidal_frame_get(s : GeodistellipsoidalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_frame_set(s : GeodistellipsoidalFrame, i : Int, v : Double) -> GeodistellipsoidalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_frame_sum(s : GeodistellipsoidalFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_frame_mean(s : GeodistellipsoidalFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_frame_scale(s : GeodistellipsoidalFrame, f : Double) -> GeodistellipsoidalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_frame_add(a : GeodistellipsoidalFrame, b : GeodistellipsoidalFrame) -> GeodistellipsoidalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_frame_copy(s : GeodistellipsoidalFrame) -> GeodistellipsoidalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_frame_fill(s : GeodistellipsoidalFrame, v : Double) -> GeodistellipsoidalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_frame_min(s : GeodistellipsoidalFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_frame_max(s : GeodistellipsoidalFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_frame_to_string(s : GeodistellipsoidalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_table_make(size : Int) -> GeodistellipsoidalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_table_len(s : GeodistellipsoidalTable) -> Int { s.size }

pub fn geo_dist_ellipsoidal_table_get(s : GeodistellipsoidalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_table_set(s : GeodistellipsoidalTable, i : Int, v : Double) -> GeodistellipsoidalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_table_sum(s : GeodistellipsoidalTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_table_mean(s : GeodistellipsoidalTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_table_scale(s : GeodistellipsoidalTable, f : Double) -> GeodistellipsoidalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_table_add(a : GeodistellipsoidalTable, b : GeodistellipsoidalTable) -> GeodistellipsoidalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_table_copy(s : GeodistellipsoidalTable) -> GeodistellipsoidalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_table_fill(s : GeodistellipsoidalTable, v : Double) -> GeodistellipsoidalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_table_min(s : GeodistellipsoidalTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_table_max(s : GeodistellipsoidalTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_table_to_string(s : GeodistellipsoidalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_graphn_make(size : Int) -> GeodistellipsoidalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_graphn_len(s : GeodistellipsoidalGraphN) -> Int { s.size }

pub fn geo_dist_ellipsoidal_graphn_get(s : GeodistellipsoidalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_graphn_set(s : GeodistellipsoidalGraphN, i : Int, v : Double) -> GeodistellipsoidalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_graphn_sum(s : GeodistellipsoidalGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_graphn_mean(s : GeodistellipsoidalGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_graphn_scale(s : GeodistellipsoidalGraphN, f : Double) -> GeodistellipsoidalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_graphn_add(a : GeodistellipsoidalGraphN, b : GeodistellipsoidalGraphN) -> GeodistellipsoidalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_graphn_copy(s : GeodistellipsoidalGraphN) -> GeodistellipsoidalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_graphn_fill(s : GeodistellipsoidalGraphN, v : Double) -> GeodistellipsoidalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_graphn_min(s : GeodistellipsoidalGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_graphn_max(s : GeodistellipsoidalGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_graphn_to_string(s : GeodistellipsoidalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_node_make(size : Int) -> GeodistellipsoidalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_node_len(s : GeodistellipsoidalNode) -> Int { s.size }

pub fn geo_dist_ellipsoidal_node_get(s : GeodistellipsoidalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_node_set(s : GeodistellipsoidalNode, i : Int, v : Double) -> GeodistellipsoidalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_node_sum(s : GeodistellipsoidalNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_node_mean(s : GeodistellipsoidalNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_node_scale(s : GeodistellipsoidalNode, f : Double) -> GeodistellipsoidalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_node_add(a : GeodistellipsoidalNode, b : GeodistellipsoidalNode) -> GeodistellipsoidalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_node_copy(s : GeodistellipsoidalNode) -> GeodistellipsoidalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_node_fill(s : GeodistellipsoidalNode, v : Double) -> GeodistellipsoidalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_node_min(s : GeodistellipsoidalNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_node_max(s : GeodistellipsoidalNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_node_to_string(s : GeodistellipsoidalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_edge_make(size : Int) -> GeodistellipsoidalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_edge_len(s : GeodistellipsoidalEdge) -> Int { s.size }

pub fn geo_dist_ellipsoidal_edge_get(s : GeodistellipsoidalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_edge_set(s : GeodistellipsoidalEdge, i : Int, v : Double) -> GeodistellipsoidalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_edge_sum(s : GeodistellipsoidalEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_edge_mean(s : GeodistellipsoidalEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_edge_scale(s : GeodistellipsoidalEdge, f : Double) -> GeodistellipsoidalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_edge_add(a : GeodistellipsoidalEdge, b : GeodistellipsoidalEdge) -> GeodistellipsoidalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_edge_copy(s : GeodistellipsoidalEdge) -> GeodistellipsoidalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_edge_fill(s : GeodistellipsoidalEdge, v : Double) -> GeodistellipsoidalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_edge_min(s : GeodistellipsoidalEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_edge_max(s : GeodistellipsoidalEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_edge_to_string(s : GeodistellipsoidalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_path_make(size : Int) -> GeodistellipsoidalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_path_len(s : GeodistellipsoidalPath) -> Int { s.size }

pub fn geo_dist_ellipsoidal_path_get(s : GeodistellipsoidalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_path_set(s : GeodistellipsoidalPath, i : Int, v : Double) -> GeodistellipsoidalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_path_sum(s : GeodistellipsoidalPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_path_mean(s : GeodistellipsoidalPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_path_scale(s : GeodistellipsoidalPath, f : Double) -> GeodistellipsoidalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_path_add(a : GeodistellipsoidalPath, b : GeodistellipsoidalPath) -> GeodistellipsoidalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_path_copy(s : GeodistellipsoidalPath) -> GeodistellipsoidalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_path_fill(s : GeodistellipsoidalPath, v : Double) -> GeodistellipsoidalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_path_min(s : GeodistellipsoidalPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_path_max(s : GeodistellipsoidalPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_path_to_string(s : GeodistellipsoidalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_cluster_make(size : Int) -> GeodistellipsoidalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_cluster_len(s : GeodistellipsoidalCluster) -> Int { s.size }

pub fn geo_dist_ellipsoidal_cluster_get(s : GeodistellipsoidalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_cluster_set(s : GeodistellipsoidalCluster, i : Int, v : Double) -> GeodistellipsoidalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cluster_sum(s : GeodistellipsoidalCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_cluster_mean(s : GeodistellipsoidalCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_cluster_scale(s : GeodistellipsoidalCluster, f : Double) -> GeodistellipsoidalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cluster_add(a : GeodistellipsoidalCluster, b : GeodistellipsoidalCluster) -> GeodistellipsoidalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_cluster_copy(s : GeodistellipsoidalCluster) -> GeodistellipsoidalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cluster_fill(s : GeodistellipsoidalCluster, v : Double) -> GeodistellipsoidalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cluster_min(s : GeodistellipsoidalCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_cluster_max(s : GeodistellipsoidalCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_cluster_to_string(s : GeodistellipsoidalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_model_make(size : Int) -> GeodistellipsoidalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_model_len(s : GeodistellipsoidalModel) -> Int { s.size }

pub fn geo_dist_ellipsoidal_model_get(s : GeodistellipsoidalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_model_set(s : GeodistellipsoidalModel, i : Int, v : Double) -> GeodistellipsoidalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_model_sum(s : GeodistellipsoidalModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_model_mean(s : GeodistellipsoidalModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_model_scale(s : GeodistellipsoidalModel, f : Double) -> GeodistellipsoidalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_model_add(a : GeodistellipsoidalModel, b : GeodistellipsoidalModel) -> GeodistellipsoidalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_model_copy(s : GeodistellipsoidalModel) -> GeodistellipsoidalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_model_fill(s : GeodistellipsoidalModel, v : Double) -> GeodistellipsoidalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_model_min(s : GeodistellipsoidalModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_model_max(s : GeodistellipsoidalModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_model_to_string(s : GeodistellipsoidalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_layer_make(size : Int) -> GeodistellipsoidalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_layer_len(s : GeodistellipsoidalLayer) -> Int { s.size }

pub fn geo_dist_ellipsoidal_layer_get(s : GeodistellipsoidalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_layer_set(s : GeodistellipsoidalLayer, i : Int, v : Double) -> GeodistellipsoidalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_layer_sum(s : GeodistellipsoidalLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_layer_mean(s : GeodistellipsoidalLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_layer_scale(s : GeodistellipsoidalLayer, f : Double) -> GeodistellipsoidalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_layer_add(a : GeodistellipsoidalLayer, b : GeodistellipsoidalLayer) -> GeodistellipsoidalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_layer_copy(s : GeodistellipsoidalLayer) -> GeodistellipsoidalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_layer_fill(s : GeodistellipsoidalLayer, v : Double) -> GeodistellipsoidalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_layer_min(s : GeodistellipsoidalLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_layer_max(s : GeodistellipsoidalLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_layer_to_string(s : GeodistellipsoidalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_buffer_make(size : Int) -> GeodistellipsoidalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_buffer_len(s : GeodistellipsoidalBuffer) -> Int { s.size }

pub fn geo_dist_ellipsoidal_buffer_get(s : GeodistellipsoidalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_buffer_set(s : GeodistellipsoidalBuffer, i : Int, v : Double) -> GeodistellipsoidalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_buffer_sum(s : GeodistellipsoidalBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_buffer_mean(s : GeodistellipsoidalBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_buffer_scale(s : GeodistellipsoidalBuffer, f : Double) -> GeodistellipsoidalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_buffer_add(a : GeodistellipsoidalBuffer, b : GeodistellipsoidalBuffer) -> GeodistellipsoidalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_buffer_copy(s : GeodistellipsoidalBuffer) -> GeodistellipsoidalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_buffer_fill(s : GeodistellipsoidalBuffer, v : Double) -> GeodistellipsoidalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_buffer_min(s : GeodistellipsoidalBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_buffer_max(s : GeodistellipsoidalBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_buffer_to_string(s : GeodistellipsoidalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_cursor_make(size : Int) -> GeodistellipsoidalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_cursor_len(s : GeodistellipsoidalCursor) -> Int { s.size }

pub fn geo_dist_ellipsoidal_cursor_get(s : GeodistellipsoidalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_cursor_set(s : GeodistellipsoidalCursor, i : Int, v : Double) -> GeodistellipsoidalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cursor_sum(s : GeodistellipsoidalCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_cursor_mean(s : GeodistellipsoidalCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_cursor_scale(s : GeodistellipsoidalCursor, f : Double) -> GeodistellipsoidalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cursor_add(a : GeodistellipsoidalCursor, b : GeodistellipsoidalCursor) -> GeodistellipsoidalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_cursor_copy(s : GeodistellipsoidalCursor) -> GeodistellipsoidalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cursor_fill(s : GeodistellipsoidalCursor, v : Double) -> GeodistellipsoidalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cursor_min(s : GeodistellipsoidalCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_cursor_max(s : GeodistellipsoidalCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_cursor_to_string(s : GeodistellipsoidalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_view_make(size : Int) -> GeodistellipsoidalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_view_len(s : GeodistellipsoidalView) -> Int { s.size }

pub fn geo_dist_ellipsoidal_view_get(s : GeodistellipsoidalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_view_set(s : GeodistellipsoidalView, i : Int, v : Double) -> GeodistellipsoidalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_view_sum(s : GeodistellipsoidalView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_view_mean(s : GeodistellipsoidalView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_view_scale(s : GeodistellipsoidalView, f : Double) -> GeodistellipsoidalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_view_add(a : GeodistellipsoidalView, b : GeodistellipsoidalView) -> GeodistellipsoidalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_view_copy(s : GeodistellipsoidalView) -> GeodistellipsoidalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_view_fill(s : GeodistellipsoidalView, v : Double) -> GeodistellipsoidalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_view_min(s : GeodistellipsoidalView) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_view_max(s : GeodistellipsoidalView) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_view_to_string(s : GeodistellipsoidalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_range_make(size : Int) -> GeodistellipsoidalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_range_len(s : GeodistellipsoidalRange) -> Int { s.size }

pub fn geo_dist_ellipsoidal_range_get(s : GeodistellipsoidalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_range_set(s : GeodistellipsoidalRange, i : Int, v : Double) -> GeodistellipsoidalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_range_sum(s : GeodistellipsoidalRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_range_mean(s : GeodistellipsoidalRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_range_scale(s : GeodistellipsoidalRange, f : Double) -> GeodistellipsoidalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_range_add(a : GeodistellipsoidalRange, b : GeodistellipsoidalRange) -> GeodistellipsoidalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_range_copy(s : GeodistellipsoidalRange) -> GeodistellipsoidalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_range_fill(s : GeodistellipsoidalRange, v : Double) -> GeodistellipsoidalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_range_min(s : GeodistellipsoidalRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_range_max(s : GeodistellipsoidalRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_range_to_string(s : GeodistellipsoidalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_slice_make(size : Int) -> GeodistellipsoidalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_slice_len(s : GeodistellipsoidalSlice) -> Int { s.size }

pub fn geo_dist_ellipsoidal_slice_get(s : GeodistellipsoidalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_slice_set(s : GeodistellipsoidalSlice, i : Int, v : Double) -> GeodistellipsoidalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_slice_sum(s : GeodistellipsoidalSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_slice_mean(s : GeodistellipsoidalSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_slice_scale(s : GeodistellipsoidalSlice, f : Double) -> GeodistellipsoidalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_slice_add(a : GeodistellipsoidalSlice, b : GeodistellipsoidalSlice) -> GeodistellipsoidalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_slice_copy(s : GeodistellipsoidalSlice) -> GeodistellipsoidalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_slice_fill(s : GeodistellipsoidalSlice, v : Double) -> GeodistellipsoidalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_slice_min(s : GeodistellipsoidalSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_slice_max(s : GeodistellipsoidalSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_slice_to_string(s : GeodistellipsoidalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

