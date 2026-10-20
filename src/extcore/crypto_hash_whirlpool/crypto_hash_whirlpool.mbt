///===
/// extcore/crypto_hash_whirlpool

pub(all) struct CryptohashwhirlpoolPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_whirlpool_make_point(x : Double, y : Double) -> CryptohashwhirlpoolPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_whirlpool_make_point3(x : Double, y : Double, z : Double) -> CryptohashwhirlpoolPoint {
  { x, y, z, label: 0 }
}

pub fn CryptohashwhirlpoolPoint::x(self : CryptohashwhirlpoolPoint) -> Double { self.x }

pub fn CryptohashwhirlpoolPoint::y(self : CryptohashwhirlpoolPoint) -> Double { self.y }

pub fn CryptohashwhirlpoolPoint::z(self : CryptohashwhirlpoolPoint) -> Double { self.z }

pub fn CryptohashwhirlpoolPoint::label(self : CryptohashwhirlpoolPoint) -> Int { self.label }

pub fn CryptohashwhirlpoolPoint::dist(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptohashwhirlpoolPoint::add(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::sub(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::scale(self : CryptohashwhirlpoolPoint, s : Double) -> CryptohashwhirlpoolPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::dot(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptohashwhirlpoolPoint::cross(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptohashwhirlpoolPoint::norm(self : CryptohashwhirlpoolPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptohashwhirlpoolPoint::normalize(self : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashwhirlpoolPoint::negate(self : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::mid(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::lerp(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint, t : Double) -> CryptohashwhirlpoolPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::to_string(self : CryptohashwhirlpoolPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_whirlpool_make_series(vals : Array[Double], name : String) -> CryptohashwhirlpoolSeries {
  { vals, name, meta: 0 }
}

pub fn CryptohashwhirlpoolSeries::len(self : CryptohashwhirlpoolSeries) -> Int { self.vals.length() }

pub fn CryptohashwhirlpoolSeries::sum(self : CryptohashwhirlpoolSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptohashwhirlpoolSeries::mean(self : CryptohashwhirlpoolSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptohashwhirlpoolSeries::min(self : CryptohashwhirlpoolSeries) -> Double { @_common.min(self.vals) }

pub fn CryptohashwhirlpoolSeries::max(self : CryptohashwhirlpoolSeries) -> Double { @_common.max(self.vals) }

pub fn CryptohashwhirlpoolSeries::range(self : CryptohashwhirlpoolSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptohashwhirlpoolSeries::variance(self : CryptohashwhirlpoolSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptohashwhirlpoolSeries::std(self : CryptohashwhirlpoolSeries) -> Double { @_common.std(self.vals) }

pub fn CryptohashwhirlpoolSeries::median(self : CryptohashwhirlpoolSeries) -> Double { @_common.median(self.vals) }

pub fn CryptohashwhirlpoolSeries::scale(self : CryptohashwhirlpoolSeries, f : Double) -> CryptohashwhirlpoolSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptohashwhirlpoolSeries::add(self : CryptohashwhirlpoolSeries, other : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptohashwhirlpoolSeries::sub(self : CryptohashwhirlpoolSeries, other : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptohashwhirlpoolSeries::normalize(self : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptohashwhirlpoolSeries::cumsum(self : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptohashwhirlpoolSeries::to_string(self : CryptohashwhirlpoolSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashwhirlpoolMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_whirlpool_make_matrix(rows : Int, cols : Int, val : Double) -> CryptohashwhirlpoolMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_whirlpool_matrix_identity(n : Int) -> CryptohashwhirlpoolMatrix {
  let m = crypto_hash_whirlpool_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptohashwhirlpoolMatrix::get(self : CryptohashwhirlpoolMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptohashwhirlpoolMatrix::transpose(self : CryptohashwhirlpoolMatrix) -> CryptohashwhirlpoolMatrix {
  let result = crypto_hash_whirlpool_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptohashwhirlpoolMatrix::add(self : CryptohashwhirlpoolMatrix, other : CryptohashwhirlpoolMatrix) -> CryptohashwhirlpoolMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_whirlpool_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptohashwhirlpoolMatrix::scale(self : CryptohashwhirlpoolMatrix, s : Double) -> CryptohashwhirlpoolMatrix {
  let result = crypto_hash_whirlpool_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptohashwhirlpoolMatrix::multiply(self : CryptohashwhirlpoolMatrix, other : CryptohashwhirlpoolMatrix) -> CryptohashwhirlpoolMatrix {
  if self.cols != other.rows { return crypto_hash_whirlpool_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_whirlpool_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptohashwhirlpoolMatrix::trace(self : CryptohashwhirlpoolMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptohashwhirlpoolMatrix::det(self : CryptohashwhirlpoolMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptohashwhirlpoolMatrix::norm(self : CryptohashwhirlpoolMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptohashwhirlpoolMatrix::to_string(self : CryptohashwhirlpoolMatrix) -> String {
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

pub(all) struct CryptohashwhirlpoolVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_whirlpool_make_vector(comps : Array[Double]) -> CryptohashwhirlpoolVector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_whirlpool_vector_zero(dim : Int) -> CryptohashwhirlpoolVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptohashwhirlpoolVector::add(self : CryptohashwhirlpoolVector, other : CryptohashwhirlpoolVector) -> CryptohashwhirlpoolVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashwhirlpoolVector::sub(self : CryptohashwhirlpoolVector, other : CryptohashwhirlpoolVector) -> CryptohashwhirlpoolVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashwhirlpoolVector::scale(self : CryptohashwhirlpoolVector, s : Double) -> CryptohashwhirlpoolVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptohashwhirlpoolVector::dot(self : CryptohashwhirlpoolVector, other : CryptohashwhirlpoolVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptohashwhirlpoolVector::norm(self : CryptohashwhirlpoolVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptohashwhirlpoolVector::normalize(self : CryptohashwhirlpoolVector) -> CryptohashwhirlpoolVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashwhirlpoolVector::dist(self : CryptohashwhirlpoolVector, other : CryptohashwhirlpoolVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptohashwhirlpoolVector::to_string(self : CryptohashwhirlpoolVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_whirlpool_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_whirlpool_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_whirlpool_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_whirlpool_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_whirlpool_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_whirlpool_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_whirlpool_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_whirlpool_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_whirlpool_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_whirlpool_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_whirlpool_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_whirlpool_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_whirlpool_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_whirlpool_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_whirlpool_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_whirlpool_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_whirlpool_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_whirlpool_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_whirlpool_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_whirlpool_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_whirlpool_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_whirlpool_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_whirlpool_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_whirlpool_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_whirlpool_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_whirlpool_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_whirlpool_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_whirlpool_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_whirlpool_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptohashwhirlpoolFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_frame_make(size : Int) -> CryptohashwhirlpoolFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_frame_len(s : CryptohashwhirlpoolFrame) -> Int { s.size }

pub fn crypto_hash_whirlpool_frame_get(s : CryptohashwhirlpoolFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_frame_set(s : CryptohashwhirlpoolFrame, i : Int, v : Double) -> CryptohashwhirlpoolFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_frame_sum(s : CryptohashwhirlpoolFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_frame_mean(s : CryptohashwhirlpoolFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_frame_scale(s : CryptohashwhirlpoolFrame, f : Double) -> CryptohashwhirlpoolFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_frame_add(a : CryptohashwhirlpoolFrame, b : CryptohashwhirlpoolFrame) -> CryptohashwhirlpoolFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_frame_copy(s : CryptohashwhirlpoolFrame) -> CryptohashwhirlpoolFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_frame_fill(s : CryptohashwhirlpoolFrame, v : Double) -> CryptohashwhirlpoolFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_frame_min(s : CryptohashwhirlpoolFrame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_frame_max(s : CryptohashwhirlpoolFrame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_frame_to_string(s : CryptohashwhirlpoolFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_table_make(size : Int) -> CryptohashwhirlpoolTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_table_len(s : CryptohashwhirlpoolTable) -> Int { s.size }

pub fn crypto_hash_whirlpool_table_get(s : CryptohashwhirlpoolTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_table_set(s : CryptohashwhirlpoolTable, i : Int, v : Double) -> CryptohashwhirlpoolTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_table_sum(s : CryptohashwhirlpoolTable) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_table_mean(s : CryptohashwhirlpoolTable) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_table_scale(s : CryptohashwhirlpoolTable, f : Double) -> CryptohashwhirlpoolTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_table_add(a : CryptohashwhirlpoolTable, b : CryptohashwhirlpoolTable) -> CryptohashwhirlpoolTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_table_copy(s : CryptohashwhirlpoolTable) -> CryptohashwhirlpoolTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_table_fill(s : CryptohashwhirlpoolTable, v : Double) -> CryptohashwhirlpoolTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_table_min(s : CryptohashwhirlpoolTable) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_table_max(s : CryptohashwhirlpoolTable) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_table_to_string(s : CryptohashwhirlpoolTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_graphn_make(size : Int) -> CryptohashwhirlpoolGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_graphn_len(s : CryptohashwhirlpoolGraphN) -> Int { s.size }

pub fn crypto_hash_whirlpool_graphn_get(s : CryptohashwhirlpoolGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_graphn_set(s : CryptohashwhirlpoolGraphN, i : Int, v : Double) -> CryptohashwhirlpoolGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_graphn_sum(s : CryptohashwhirlpoolGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_graphn_mean(s : CryptohashwhirlpoolGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_graphn_scale(s : CryptohashwhirlpoolGraphN, f : Double) -> CryptohashwhirlpoolGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_graphn_add(a : CryptohashwhirlpoolGraphN, b : CryptohashwhirlpoolGraphN) -> CryptohashwhirlpoolGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_graphn_copy(s : CryptohashwhirlpoolGraphN) -> CryptohashwhirlpoolGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_graphn_fill(s : CryptohashwhirlpoolGraphN, v : Double) -> CryptohashwhirlpoolGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_graphn_min(s : CryptohashwhirlpoolGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_graphn_max(s : CryptohashwhirlpoolGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_graphn_to_string(s : CryptohashwhirlpoolGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_node_make(size : Int) -> CryptohashwhirlpoolNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_node_len(s : CryptohashwhirlpoolNode) -> Int { s.size }

pub fn crypto_hash_whirlpool_node_get(s : CryptohashwhirlpoolNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_node_set(s : CryptohashwhirlpoolNode, i : Int, v : Double) -> CryptohashwhirlpoolNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_node_sum(s : CryptohashwhirlpoolNode) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_node_mean(s : CryptohashwhirlpoolNode) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_node_scale(s : CryptohashwhirlpoolNode, f : Double) -> CryptohashwhirlpoolNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_node_add(a : CryptohashwhirlpoolNode, b : CryptohashwhirlpoolNode) -> CryptohashwhirlpoolNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_node_copy(s : CryptohashwhirlpoolNode) -> CryptohashwhirlpoolNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_node_fill(s : CryptohashwhirlpoolNode, v : Double) -> CryptohashwhirlpoolNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_node_min(s : CryptohashwhirlpoolNode) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_node_max(s : CryptohashwhirlpoolNode) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_node_to_string(s : CryptohashwhirlpoolNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_edge_make(size : Int) -> CryptohashwhirlpoolEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_edge_len(s : CryptohashwhirlpoolEdge) -> Int { s.size }

pub fn crypto_hash_whirlpool_edge_get(s : CryptohashwhirlpoolEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_edge_set(s : CryptohashwhirlpoolEdge, i : Int, v : Double) -> CryptohashwhirlpoolEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_edge_sum(s : CryptohashwhirlpoolEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_edge_mean(s : CryptohashwhirlpoolEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_edge_scale(s : CryptohashwhirlpoolEdge, f : Double) -> CryptohashwhirlpoolEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_edge_add(a : CryptohashwhirlpoolEdge, b : CryptohashwhirlpoolEdge) -> CryptohashwhirlpoolEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_edge_copy(s : CryptohashwhirlpoolEdge) -> CryptohashwhirlpoolEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_edge_fill(s : CryptohashwhirlpoolEdge, v : Double) -> CryptohashwhirlpoolEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_edge_min(s : CryptohashwhirlpoolEdge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_edge_max(s : CryptohashwhirlpoolEdge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_edge_to_string(s : CryptohashwhirlpoolEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_path_make(size : Int) -> CryptohashwhirlpoolPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_path_len(s : CryptohashwhirlpoolPath) -> Int { s.size }

pub fn crypto_hash_whirlpool_path_get(s : CryptohashwhirlpoolPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_path_set(s : CryptohashwhirlpoolPath, i : Int, v : Double) -> CryptohashwhirlpoolPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_path_sum(s : CryptohashwhirlpoolPath) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_path_mean(s : CryptohashwhirlpoolPath) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_path_scale(s : CryptohashwhirlpoolPath, f : Double) -> CryptohashwhirlpoolPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_path_add(a : CryptohashwhirlpoolPath, b : CryptohashwhirlpoolPath) -> CryptohashwhirlpoolPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_path_copy(s : CryptohashwhirlpoolPath) -> CryptohashwhirlpoolPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_path_fill(s : CryptohashwhirlpoolPath, v : Double) -> CryptohashwhirlpoolPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_path_min(s : CryptohashwhirlpoolPath) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_path_max(s : CryptohashwhirlpoolPath) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_path_to_string(s : CryptohashwhirlpoolPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_cluster_make(size : Int) -> CryptohashwhirlpoolCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_cluster_len(s : CryptohashwhirlpoolCluster) -> Int { s.size }

pub fn crypto_hash_whirlpool_cluster_get(s : CryptohashwhirlpoolCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_cluster_set(s : CryptohashwhirlpoolCluster, i : Int, v : Double) -> CryptohashwhirlpoolCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_cluster_sum(s : CryptohashwhirlpoolCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_cluster_mean(s : CryptohashwhirlpoolCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_cluster_scale(s : CryptohashwhirlpoolCluster, f : Double) -> CryptohashwhirlpoolCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_cluster_add(a : CryptohashwhirlpoolCluster, b : CryptohashwhirlpoolCluster) -> CryptohashwhirlpoolCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_cluster_copy(s : CryptohashwhirlpoolCluster) -> CryptohashwhirlpoolCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_cluster_fill(s : CryptohashwhirlpoolCluster, v : Double) -> CryptohashwhirlpoolCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_cluster_min(s : CryptohashwhirlpoolCluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_cluster_max(s : CryptohashwhirlpoolCluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_cluster_to_string(s : CryptohashwhirlpoolCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_model_make(size : Int) -> CryptohashwhirlpoolModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_model_len(s : CryptohashwhirlpoolModel) -> Int { s.size }

pub fn crypto_hash_whirlpool_model_get(s : CryptohashwhirlpoolModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_model_set(s : CryptohashwhirlpoolModel, i : Int, v : Double) -> CryptohashwhirlpoolModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_model_sum(s : CryptohashwhirlpoolModel) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_model_mean(s : CryptohashwhirlpoolModel) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_model_scale(s : CryptohashwhirlpoolModel, f : Double) -> CryptohashwhirlpoolModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_model_add(a : CryptohashwhirlpoolModel, b : CryptohashwhirlpoolModel) -> CryptohashwhirlpoolModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_model_copy(s : CryptohashwhirlpoolModel) -> CryptohashwhirlpoolModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_model_fill(s : CryptohashwhirlpoolModel, v : Double) -> CryptohashwhirlpoolModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_model_min(s : CryptohashwhirlpoolModel) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_model_max(s : CryptohashwhirlpoolModel) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_model_to_string(s : CryptohashwhirlpoolModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_layer_make(size : Int) -> CryptohashwhirlpoolLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_layer_len(s : CryptohashwhirlpoolLayer) -> Int { s.size }

pub fn crypto_hash_whirlpool_layer_get(s : CryptohashwhirlpoolLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_layer_set(s : CryptohashwhirlpoolLayer, i : Int, v : Double) -> CryptohashwhirlpoolLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_layer_sum(s : CryptohashwhirlpoolLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_layer_mean(s : CryptohashwhirlpoolLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_layer_scale(s : CryptohashwhirlpoolLayer, f : Double) -> CryptohashwhirlpoolLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_layer_add(a : CryptohashwhirlpoolLayer, b : CryptohashwhirlpoolLayer) -> CryptohashwhirlpoolLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_layer_copy(s : CryptohashwhirlpoolLayer) -> CryptohashwhirlpoolLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_layer_fill(s : CryptohashwhirlpoolLayer, v : Double) -> CryptohashwhirlpoolLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_layer_min(s : CryptohashwhirlpoolLayer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_layer_max(s : CryptohashwhirlpoolLayer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_layer_to_string(s : CryptohashwhirlpoolLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_buffer_make(size : Int) -> CryptohashwhirlpoolBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_buffer_len(s : CryptohashwhirlpoolBuffer) -> Int { s.size }

pub fn crypto_hash_whirlpool_buffer_get(s : CryptohashwhirlpoolBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_buffer_set(s : CryptohashwhirlpoolBuffer, i : Int, v : Double) -> CryptohashwhirlpoolBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_buffer_sum(s : CryptohashwhirlpoolBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_buffer_mean(s : CryptohashwhirlpoolBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_buffer_scale(s : CryptohashwhirlpoolBuffer, f : Double) -> CryptohashwhirlpoolBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_buffer_add(a : CryptohashwhirlpoolBuffer, b : CryptohashwhirlpoolBuffer) -> CryptohashwhirlpoolBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_buffer_copy(s : CryptohashwhirlpoolBuffer) -> CryptohashwhirlpoolBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_buffer_fill(s : CryptohashwhirlpoolBuffer, v : Double) -> CryptohashwhirlpoolBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_buffer_min(s : CryptohashwhirlpoolBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_buffer_max(s : CryptohashwhirlpoolBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_buffer_to_string(s : CryptohashwhirlpoolBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_cursor_make(size : Int) -> CryptohashwhirlpoolCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_cursor_len(s : CryptohashwhirlpoolCursor) -> Int { s.size }

pub fn crypto_hash_whirlpool_cursor_get(s : CryptohashwhirlpoolCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_cursor_set(s : CryptohashwhirlpoolCursor, i : Int, v : Double) -> CryptohashwhirlpoolCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_cursor_sum(s : CryptohashwhirlpoolCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_cursor_mean(s : CryptohashwhirlpoolCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_cursor_scale(s : CryptohashwhirlpoolCursor, f : Double) -> CryptohashwhirlpoolCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_cursor_add(a : CryptohashwhirlpoolCursor, b : CryptohashwhirlpoolCursor) -> CryptohashwhirlpoolCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_cursor_copy(s : CryptohashwhirlpoolCursor) -> CryptohashwhirlpoolCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_cursor_fill(s : CryptohashwhirlpoolCursor, v : Double) -> CryptohashwhirlpoolCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_cursor_min(s : CryptohashwhirlpoolCursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_cursor_max(s : CryptohashwhirlpoolCursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_cursor_to_string(s : CryptohashwhirlpoolCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_view_make(size : Int) -> CryptohashwhirlpoolView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_view_len(s : CryptohashwhirlpoolView) -> Int { s.size }

pub fn crypto_hash_whirlpool_view_get(s : CryptohashwhirlpoolView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_view_set(s : CryptohashwhirlpoolView, i : Int, v : Double) -> CryptohashwhirlpoolView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_view_sum(s : CryptohashwhirlpoolView) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_view_mean(s : CryptohashwhirlpoolView) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_view_scale(s : CryptohashwhirlpoolView, f : Double) -> CryptohashwhirlpoolView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_view_add(a : CryptohashwhirlpoolView, b : CryptohashwhirlpoolView) -> CryptohashwhirlpoolView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_view_copy(s : CryptohashwhirlpoolView) -> CryptohashwhirlpoolView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_view_fill(s : CryptohashwhirlpoolView, v : Double) -> CryptohashwhirlpoolView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_view_min(s : CryptohashwhirlpoolView) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_view_max(s : CryptohashwhirlpoolView) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_view_to_string(s : CryptohashwhirlpoolView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_range_make(size : Int) -> CryptohashwhirlpoolRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_range_len(s : CryptohashwhirlpoolRange) -> Int { s.size }

pub fn crypto_hash_whirlpool_range_get(s : CryptohashwhirlpoolRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_range_set(s : CryptohashwhirlpoolRange, i : Int, v : Double) -> CryptohashwhirlpoolRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_range_sum(s : CryptohashwhirlpoolRange) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_range_mean(s : CryptohashwhirlpoolRange) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_range_scale(s : CryptohashwhirlpoolRange, f : Double) -> CryptohashwhirlpoolRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_range_add(a : CryptohashwhirlpoolRange, b : CryptohashwhirlpoolRange) -> CryptohashwhirlpoolRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_range_copy(s : CryptohashwhirlpoolRange) -> CryptohashwhirlpoolRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_range_fill(s : CryptohashwhirlpoolRange, v : Double) -> CryptohashwhirlpoolRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_range_min(s : CryptohashwhirlpoolRange) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_range_max(s : CryptohashwhirlpoolRange) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_range_to_string(s : CryptohashwhirlpoolRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_slice_make(size : Int) -> CryptohashwhirlpoolSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_slice_len(s : CryptohashwhirlpoolSlice) -> Int { s.size }

pub fn crypto_hash_whirlpool_slice_get(s : CryptohashwhirlpoolSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_slice_set(s : CryptohashwhirlpoolSlice, i : Int, v : Double) -> CryptohashwhirlpoolSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_slice_sum(s : CryptohashwhirlpoolSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_slice_mean(s : CryptohashwhirlpoolSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_slice_scale(s : CryptohashwhirlpoolSlice, f : Double) -> CryptohashwhirlpoolSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_slice_add(a : CryptohashwhirlpoolSlice, b : CryptohashwhirlpoolSlice) -> CryptohashwhirlpoolSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_whirlpool_slice_copy(s : CryptohashwhirlpoolSlice) -> CryptohashwhirlpoolSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_slice_fill(s : CryptohashwhirlpoolSlice, v : Double) -> CryptohashwhirlpoolSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_whirlpool_slice_min(s : CryptohashwhirlpoolSlice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_slice_max(s : CryptohashwhirlpoolSlice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_slice_to_string(s : CryptohashwhirlpoolSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

