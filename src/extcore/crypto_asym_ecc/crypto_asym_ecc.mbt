///===
/// extcore/crypto_asym_ecc

pub(all) struct CryptoasymeccPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_ecc_make_point(x : Double, y : Double) -> CryptoasymeccPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_ecc_make_point3(x : Double, y : Double, z : Double) -> CryptoasymeccPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymeccPoint::x(self : CryptoasymeccPoint) -> Double { self.x }

pub fn CryptoasymeccPoint::y(self : CryptoasymeccPoint) -> Double { self.y }

pub fn CryptoasymeccPoint::z(self : CryptoasymeccPoint) -> Double { self.z }

pub fn CryptoasymeccPoint::label(self : CryptoasymeccPoint) -> Int { self.label }

pub fn CryptoasymeccPoint::dist(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymeccPoint::add(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymeccPoint::sub(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymeccPoint::scale(self : CryptoasymeccPoint, s : Double) -> CryptoasymeccPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymeccPoint::dot(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymeccPoint::cross(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymeccPoint::norm(self : CryptoasymeccPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymeccPoint::normalize(self : CryptoasymeccPoint) -> CryptoasymeccPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeccPoint::negate(self : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymeccPoint::mid(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymeccPoint::lerp(self : CryptoasymeccPoint, other : CryptoasymeccPoint, t : Double) -> CryptoasymeccPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymeccPoint::to_string(self : CryptoasymeccPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymeccSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_ecc_make_series(vals : Array[Double], name : String) -> CryptoasymeccSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymeccSeries::len(self : CryptoasymeccSeries) -> Int { self.vals.length() }

pub fn CryptoasymeccSeries::sum(self : CryptoasymeccSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymeccSeries::mean(self : CryptoasymeccSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymeccSeries::min(self : CryptoasymeccSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymeccSeries::max(self : CryptoasymeccSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymeccSeries::range(self : CryptoasymeccSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymeccSeries::variance(self : CryptoasymeccSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymeccSeries::std(self : CryptoasymeccSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymeccSeries::median(self : CryptoasymeccSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymeccSeries::scale(self : CryptoasymeccSeries, f : Double) -> CryptoasymeccSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymeccSeries::add(self : CryptoasymeccSeries, other : CryptoasymeccSeries) -> CryptoasymeccSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymeccSeries::sub(self : CryptoasymeccSeries, other : CryptoasymeccSeries) -> CryptoasymeccSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymeccSeries::normalize(self : CryptoasymeccSeries) -> CryptoasymeccSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymeccSeries::cumsum(self : CryptoasymeccSeries) -> CryptoasymeccSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymeccSeries::to_string(self : CryptoasymeccSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeccMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_ecc_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymeccMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_ecc_matrix_identity(n : Int) -> CryptoasymeccMatrix {
  let m = crypto_asym_ecc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymeccMatrix::get(self : CryptoasymeccMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymeccMatrix::transpose(self : CryptoasymeccMatrix) -> CryptoasymeccMatrix {
  let result = crypto_asym_ecc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymeccMatrix::add(self : CryptoasymeccMatrix, other : CryptoasymeccMatrix) -> CryptoasymeccMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_ecc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymeccMatrix::scale(self : CryptoasymeccMatrix, s : Double) -> CryptoasymeccMatrix {
  let result = crypto_asym_ecc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymeccMatrix::multiply(self : CryptoasymeccMatrix, other : CryptoasymeccMatrix) -> CryptoasymeccMatrix {
  if self.cols != other.rows { return crypto_asym_ecc_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_ecc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptoasymeccMatrix::trace(self : CryptoasymeccMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymeccMatrix::det(self : CryptoasymeccMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymeccMatrix::norm(self : CryptoasymeccMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymeccMatrix::to_string(self : CryptoasymeccMatrix) -> String {
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

pub(all) struct CryptoasymeccVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_ecc_make_vector(comps : Array[Double]) -> CryptoasymeccVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_ecc_vector_zero(dim : Int) -> CryptoasymeccVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymeccVector::add(self : CryptoasymeccVector, other : CryptoasymeccVector) -> CryptoasymeccVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeccVector::sub(self : CryptoasymeccVector, other : CryptoasymeccVector) -> CryptoasymeccVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeccVector::scale(self : CryptoasymeccVector, s : Double) -> CryptoasymeccVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymeccVector::dot(self : CryptoasymeccVector, other : CryptoasymeccVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymeccVector::norm(self : CryptoasymeccVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymeccVector::normalize(self : CryptoasymeccVector) -> CryptoasymeccVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeccVector::dist(self : CryptoasymeccVector, other : CryptoasymeccVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymeccVector::to_string(self : CryptoasymeccVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_ecc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_ecc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_ecc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_ecc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_ecc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_ecc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_ecc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_ecc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_ecc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_ecc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_ecc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_ecc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_ecc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_ecc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_ecc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_ecc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_ecc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_ecc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_ecc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_ecc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_ecc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_ecc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_ecc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_ecc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_ecc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_ecc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_ecc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_ecc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_ecc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymeccFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_frame_make(size : Int) -> CryptoasymeccFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_frame_len(s : CryptoasymeccFrame) -> Int { s.size }

pub fn crypto_asym_ecc_frame_get(s : CryptoasymeccFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_frame_set(s : CryptoasymeccFrame, i : Int, v : Double) -> CryptoasymeccFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_frame_sum(s : CryptoasymeccFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_frame_mean(s : CryptoasymeccFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_frame_scale(s : CryptoasymeccFrame, f : Double) -> CryptoasymeccFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_frame_add(a : CryptoasymeccFrame, b : CryptoasymeccFrame) -> CryptoasymeccFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_frame_copy(s : CryptoasymeccFrame) -> CryptoasymeccFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_frame_fill(s : CryptoasymeccFrame, v : Double) -> CryptoasymeccFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_frame_min(s : CryptoasymeccFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_frame_max(s : CryptoasymeccFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_frame_to_string(s : CryptoasymeccFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_table_make(size : Int) -> CryptoasymeccTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_table_len(s : CryptoasymeccTable) -> Int { s.size }

pub fn crypto_asym_ecc_table_get(s : CryptoasymeccTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_table_set(s : CryptoasymeccTable, i : Int, v : Double) -> CryptoasymeccTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_table_sum(s : CryptoasymeccTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_table_mean(s : CryptoasymeccTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_table_scale(s : CryptoasymeccTable, f : Double) -> CryptoasymeccTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_table_add(a : CryptoasymeccTable, b : CryptoasymeccTable) -> CryptoasymeccTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_table_copy(s : CryptoasymeccTable) -> CryptoasymeccTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_table_fill(s : CryptoasymeccTable, v : Double) -> CryptoasymeccTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_table_min(s : CryptoasymeccTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_table_max(s : CryptoasymeccTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_table_to_string(s : CryptoasymeccTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_graphn_make(size : Int) -> CryptoasymeccGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_graphn_len(s : CryptoasymeccGraphN) -> Int { s.size }

pub fn crypto_asym_ecc_graphn_get(s : CryptoasymeccGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_graphn_set(s : CryptoasymeccGraphN, i : Int, v : Double) -> CryptoasymeccGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_graphn_sum(s : CryptoasymeccGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_graphn_mean(s : CryptoasymeccGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_graphn_scale(s : CryptoasymeccGraphN, f : Double) -> CryptoasymeccGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_graphn_add(a : CryptoasymeccGraphN, b : CryptoasymeccGraphN) -> CryptoasymeccGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_graphn_copy(s : CryptoasymeccGraphN) -> CryptoasymeccGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_graphn_fill(s : CryptoasymeccGraphN, v : Double) -> CryptoasymeccGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_graphn_min(s : CryptoasymeccGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_graphn_max(s : CryptoasymeccGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_graphn_to_string(s : CryptoasymeccGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_node_make(size : Int) -> CryptoasymeccNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_node_len(s : CryptoasymeccNode) -> Int { s.size }

pub fn crypto_asym_ecc_node_get(s : CryptoasymeccNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_node_set(s : CryptoasymeccNode, i : Int, v : Double) -> CryptoasymeccNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_node_sum(s : CryptoasymeccNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_node_mean(s : CryptoasymeccNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_node_scale(s : CryptoasymeccNode, f : Double) -> CryptoasymeccNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_node_add(a : CryptoasymeccNode, b : CryptoasymeccNode) -> CryptoasymeccNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_node_copy(s : CryptoasymeccNode) -> CryptoasymeccNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_node_fill(s : CryptoasymeccNode, v : Double) -> CryptoasymeccNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_node_min(s : CryptoasymeccNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_node_max(s : CryptoasymeccNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_node_to_string(s : CryptoasymeccNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_edge_make(size : Int) -> CryptoasymeccEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_edge_len(s : CryptoasymeccEdge) -> Int { s.size }

pub fn crypto_asym_ecc_edge_get(s : CryptoasymeccEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_edge_set(s : CryptoasymeccEdge, i : Int, v : Double) -> CryptoasymeccEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_edge_sum(s : CryptoasymeccEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_edge_mean(s : CryptoasymeccEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_edge_scale(s : CryptoasymeccEdge, f : Double) -> CryptoasymeccEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_edge_add(a : CryptoasymeccEdge, b : CryptoasymeccEdge) -> CryptoasymeccEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_edge_copy(s : CryptoasymeccEdge) -> CryptoasymeccEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_edge_fill(s : CryptoasymeccEdge, v : Double) -> CryptoasymeccEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_edge_min(s : CryptoasymeccEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_edge_max(s : CryptoasymeccEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_edge_to_string(s : CryptoasymeccEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_path_make(size : Int) -> CryptoasymeccPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_path_len(s : CryptoasymeccPath) -> Int { s.size }

pub fn crypto_asym_ecc_path_get(s : CryptoasymeccPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_path_set(s : CryptoasymeccPath, i : Int, v : Double) -> CryptoasymeccPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_path_sum(s : CryptoasymeccPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_path_mean(s : CryptoasymeccPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_path_scale(s : CryptoasymeccPath, f : Double) -> CryptoasymeccPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_path_add(a : CryptoasymeccPath, b : CryptoasymeccPath) -> CryptoasymeccPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_path_copy(s : CryptoasymeccPath) -> CryptoasymeccPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_path_fill(s : CryptoasymeccPath, v : Double) -> CryptoasymeccPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_path_min(s : CryptoasymeccPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_path_max(s : CryptoasymeccPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_path_to_string(s : CryptoasymeccPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_cluster_make(size : Int) -> CryptoasymeccCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_cluster_len(s : CryptoasymeccCluster) -> Int { s.size }

pub fn crypto_asym_ecc_cluster_get(s : CryptoasymeccCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_cluster_set(s : CryptoasymeccCluster, i : Int, v : Double) -> CryptoasymeccCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_cluster_sum(s : CryptoasymeccCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_cluster_mean(s : CryptoasymeccCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_cluster_scale(s : CryptoasymeccCluster, f : Double) -> CryptoasymeccCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_cluster_add(a : CryptoasymeccCluster, b : CryptoasymeccCluster) -> CryptoasymeccCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_cluster_copy(s : CryptoasymeccCluster) -> CryptoasymeccCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_cluster_fill(s : CryptoasymeccCluster, v : Double) -> CryptoasymeccCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_cluster_min(s : CryptoasymeccCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_cluster_max(s : CryptoasymeccCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_cluster_to_string(s : CryptoasymeccCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_model_make(size : Int) -> CryptoasymeccModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_model_len(s : CryptoasymeccModel) -> Int { s.size }

pub fn crypto_asym_ecc_model_get(s : CryptoasymeccModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_model_set(s : CryptoasymeccModel, i : Int, v : Double) -> CryptoasymeccModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_model_sum(s : CryptoasymeccModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_model_mean(s : CryptoasymeccModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_model_scale(s : CryptoasymeccModel, f : Double) -> CryptoasymeccModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_model_add(a : CryptoasymeccModel, b : CryptoasymeccModel) -> CryptoasymeccModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_model_copy(s : CryptoasymeccModel) -> CryptoasymeccModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_model_fill(s : CryptoasymeccModel, v : Double) -> CryptoasymeccModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_model_min(s : CryptoasymeccModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_model_max(s : CryptoasymeccModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_model_to_string(s : CryptoasymeccModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_layer_make(size : Int) -> CryptoasymeccLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_layer_len(s : CryptoasymeccLayer) -> Int { s.size }

pub fn crypto_asym_ecc_layer_get(s : CryptoasymeccLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_layer_set(s : CryptoasymeccLayer, i : Int, v : Double) -> CryptoasymeccLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_layer_sum(s : CryptoasymeccLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_layer_mean(s : CryptoasymeccLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_layer_scale(s : CryptoasymeccLayer, f : Double) -> CryptoasymeccLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_layer_add(a : CryptoasymeccLayer, b : CryptoasymeccLayer) -> CryptoasymeccLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_layer_copy(s : CryptoasymeccLayer) -> CryptoasymeccLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_layer_fill(s : CryptoasymeccLayer, v : Double) -> CryptoasymeccLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_layer_min(s : CryptoasymeccLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_layer_max(s : CryptoasymeccLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_layer_to_string(s : CryptoasymeccLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_buffer_make(size : Int) -> CryptoasymeccBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_buffer_len(s : CryptoasymeccBuffer) -> Int { s.size }

pub fn crypto_asym_ecc_buffer_get(s : CryptoasymeccBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_buffer_set(s : CryptoasymeccBuffer, i : Int, v : Double) -> CryptoasymeccBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_buffer_sum(s : CryptoasymeccBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_buffer_mean(s : CryptoasymeccBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_buffer_scale(s : CryptoasymeccBuffer, f : Double) -> CryptoasymeccBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_buffer_add(a : CryptoasymeccBuffer, b : CryptoasymeccBuffer) -> CryptoasymeccBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_buffer_copy(s : CryptoasymeccBuffer) -> CryptoasymeccBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_buffer_fill(s : CryptoasymeccBuffer, v : Double) -> CryptoasymeccBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_buffer_min(s : CryptoasymeccBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_buffer_max(s : CryptoasymeccBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_buffer_to_string(s : CryptoasymeccBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_cursor_make(size : Int) -> CryptoasymeccCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_cursor_len(s : CryptoasymeccCursor) -> Int { s.size }

pub fn crypto_asym_ecc_cursor_get(s : CryptoasymeccCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_cursor_set(s : CryptoasymeccCursor, i : Int, v : Double) -> CryptoasymeccCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_cursor_sum(s : CryptoasymeccCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_cursor_mean(s : CryptoasymeccCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_cursor_scale(s : CryptoasymeccCursor, f : Double) -> CryptoasymeccCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_cursor_add(a : CryptoasymeccCursor, b : CryptoasymeccCursor) -> CryptoasymeccCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_cursor_copy(s : CryptoasymeccCursor) -> CryptoasymeccCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_cursor_fill(s : CryptoasymeccCursor, v : Double) -> CryptoasymeccCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_cursor_min(s : CryptoasymeccCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_cursor_max(s : CryptoasymeccCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_cursor_to_string(s : CryptoasymeccCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_view_make(size : Int) -> CryptoasymeccView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_view_len(s : CryptoasymeccView) -> Int { s.size }

pub fn crypto_asym_ecc_view_get(s : CryptoasymeccView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_view_set(s : CryptoasymeccView, i : Int, v : Double) -> CryptoasymeccView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_view_sum(s : CryptoasymeccView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_view_mean(s : CryptoasymeccView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_view_scale(s : CryptoasymeccView, f : Double) -> CryptoasymeccView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_view_add(a : CryptoasymeccView, b : CryptoasymeccView) -> CryptoasymeccView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_view_copy(s : CryptoasymeccView) -> CryptoasymeccView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_view_fill(s : CryptoasymeccView, v : Double) -> CryptoasymeccView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_view_min(s : CryptoasymeccView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_view_max(s : CryptoasymeccView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_view_to_string(s : CryptoasymeccView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_range_make(size : Int) -> CryptoasymeccRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_range_len(s : CryptoasymeccRange) -> Int { s.size }

pub fn crypto_asym_ecc_range_get(s : CryptoasymeccRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_range_set(s : CryptoasymeccRange, i : Int, v : Double) -> CryptoasymeccRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_range_sum(s : CryptoasymeccRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_range_mean(s : CryptoasymeccRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_range_scale(s : CryptoasymeccRange, f : Double) -> CryptoasymeccRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_range_add(a : CryptoasymeccRange, b : CryptoasymeccRange) -> CryptoasymeccRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_range_copy(s : CryptoasymeccRange) -> CryptoasymeccRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_range_fill(s : CryptoasymeccRange, v : Double) -> CryptoasymeccRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_range_min(s : CryptoasymeccRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_range_max(s : CryptoasymeccRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_range_to_string(s : CryptoasymeccRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_slice_make(size : Int) -> CryptoasymeccSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_slice_len(s : CryptoasymeccSlice) -> Int { s.size }

pub fn crypto_asym_ecc_slice_get(s : CryptoasymeccSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_slice_set(s : CryptoasymeccSlice, i : Int, v : Double) -> CryptoasymeccSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_slice_sum(s : CryptoasymeccSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_slice_mean(s : CryptoasymeccSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_slice_scale(s : CryptoasymeccSlice, f : Double) -> CryptoasymeccSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_slice_add(a : CryptoasymeccSlice, b : CryptoasymeccSlice) -> CryptoasymeccSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecc_slice_copy(s : CryptoasymeccSlice) -> CryptoasymeccSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_slice_fill(s : CryptoasymeccSlice, v : Double) -> CryptoasymeccSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecc_slice_min(s : CryptoasymeccSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_slice_max(s : CryptoasymeccSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_slice_to_string(s : CryptoasymeccSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

