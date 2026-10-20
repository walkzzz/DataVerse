///===
/// extcore/crypto_asym_elgamal

pub(all) struct CryptoasymelgamalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_elgamal_make_point(x : Double, y : Double) -> CryptoasymelgamalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_elgamal_make_point3(x : Double, y : Double, z : Double) -> CryptoasymelgamalPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymelgamalPoint::x(self : CryptoasymelgamalPoint) -> Double { self.x }

pub fn CryptoasymelgamalPoint::y(self : CryptoasymelgamalPoint) -> Double { self.y }

pub fn CryptoasymelgamalPoint::z(self : CryptoasymelgamalPoint) -> Double { self.z }

pub fn CryptoasymelgamalPoint::label(self : CryptoasymelgamalPoint) -> Int { self.label }

pub fn CryptoasymelgamalPoint::dist(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymelgamalPoint::add(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymelgamalPoint::sub(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymelgamalPoint::scale(self : CryptoasymelgamalPoint, s : Double) -> CryptoasymelgamalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymelgamalPoint::dot(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymelgamalPoint::cross(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymelgamalPoint::norm(self : CryptoasymelgamalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymelgamalPoint::normalize(self : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymelgamalPoint::negate(self : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymelgamalPoint::mid(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymelgamalPoint::lerp(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint, t : Double) -> CryptoasymelgamalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymelgamalPoint::to_string(self : CryptoasymelgamalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymelgamalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_elgamal_make_series(vals : Array[Double], name : String) -> CryptoasymelgamalSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymelgamalSeries::len(self : CryptoasymelgamalSeries) -> Int { self.vals.length() }

pub fn CryptoasymelgamalSeries::sum(self : CryptoasymelgamalSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymelgamalSeries::mean(self : CryptoasymelgamalSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymelgamalSeries::min(self : CryptoasymelgamalSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymelgamalSeries::max(self : CryptoasymelgamalSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymelgamalSeries::range(self : CryptoasymelgamalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymelgamalSeries::variance(self : CryptoasymelgamalSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymelgamalSeries::std(self : CryptoasymelgamalSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymelgamalSeries::median(self : CryptoasymelgamalSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymelgamalSeries::scale(self : CryptoasymelgamalSeries, f : Double) -> CryptoasymelgamalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymelgamalSeries::add(self : CryptoasymelgamalSeries, other : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymelgamalSeries::sub(self : CryptoasymelgamalSeries, other : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymelgamalSeries::normalize(self : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymelgamalSeries::cumsum(self : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymelgamalSeries::to_string(self : CryptoasymelgamalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymelgamalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_elgamal_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymelgamalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_elgamal_matrix_identity(n : Int) -> CryptoasymelgamalMatrix {
  let m = crypto_asym_elgamal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymelgamalMatrix::get(self : CryptoasymelgamalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymelgamalMatrix::transpose(self : CryptoasymelgamalMatrix) -> CryptoasymelgamalMatrix {
  let result = crypto_asym_elgamal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymelgamalMatrix::add(self : CryptoasymelgamalMatrix, other : CryptoasymelgamalMatrix) -> CryptoasymelgamalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_elgamal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymelgamalMatrix::scale(self : CryptoasymelgamalMatrix, s : Double) -> CryptoasymelgamalMatrix {
  let result = crypto_asym_elgamal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymelgamalMatrix::multiply(self : CryptoasymelgamalMatrix, other : CryptoasymelgamalMatrix) -> CryptoasymelgamalMatrix {
  if self.cols != other.rows { return crypto_asym_elgamal_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_elgamal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptoasymelgamalMatrix::trace(self : CryptoasymelgamalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymelgamalMatrix::det(self : CryptoasymelgamalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymelgamalMatrix::norm(self : CryptoasymelgamalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymelgamalMatrix::to_string(self : CryptoasymelgamalMatrix) -> String {
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

pub(all) struct CryptoasymelgamalVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_elgamal_make_vector(comps : Array[Double]) -> CryptoasymelgamalVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_elgamal_vector_zero(dim : Int) -> CryptoasymelgamalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymelgamalVector::add(self : CryptoasymelgamalVector, other : CryptoasymelgamalVector) -> CryptoasymelgamalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymelgamalVector::sub(self : CryptoasymelgamalVector, other : CryptoasymelgamalVector) -> CryptoasymelgamalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymelgamalVector::scale(self : CryptoasymelgamalVector, s : Double) -> CryptoasymelgamalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymelgamalVector::dot(self : CryptoasymelgamalVector, other : CryptoasymelgamalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymelgamalVector::norm(self : CryptoasymelgamalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymelgamalVector::normalize(self : CryptoasymelgamalVector) -> CryptoasymelgamalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymelgamalVector::dist(self : CryptoasymelgamalVector, other : CryptoasymelgamalVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymelgamalVector::to_string(self : CryptoasymelgamalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_elgamal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_elgamal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_elgamal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_elgamal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_elgamal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_elgamal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_elgamal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_elgamal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_elgamal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_elgamal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_elgamal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_elgamal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_elgamal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_elgamal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_elgamal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_elgamal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_elgamal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_elgamal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_elgamal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_elgamal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_elgamal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_elgamal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_elgamal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_elgamal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_elgamal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_elgamal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_elgamal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_elgamal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_elgamal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymelgamalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_frame_make(size : Int) -> CryptoasymelgamalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_frame_len(s : CryptoasymelgamalFrame) -> Int { s.size }

pub fn crypto_asym_elgamal_frame_get(s : CryptoasymelgamalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_frame_set(s : CryptoasymelgamalFrame, i : Int, v : Double) -> CryptoasymelgamalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_frame_sum(s : CryptoasymelgamalFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_frame_mean(s : CryptoasymelgamalFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_frame_scale(s : CryptoasymelgamalFrame, f : Double) -> CryptoasymelgamalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_frame_add(a : CryptoasymelgamalFrame, b : CryptoasymelgamalFrame) -> CryptoasymelgamalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_frame_copy(s : CryptoasymelgamalFrame) -> CryptoasymelgamalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_frame_fill(s : CryptoasymelgamalFrame, v : Double) -> CryptoasymelgamalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_frame_min(s : CryptoasymelgamalFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_frame_max(s : CryptoasymelgamalFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_frame_to_string(s : CryptoasymelgamalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_table_make(size : Int) -> CryptoasymelgamalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_table_len(s : CryptoasymelgamalTable) -> Int { s.size }

pub fn crypto_asym_elgamal_table_get(s : CryptoasymelgamalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_table_set(s : CryptoasymelgamalTable, i : Int, v : Double) -> CryptoasymelgamalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_table_sum(s : CryptoasymelgamalTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_table_mean(s : CryptoasymelgamalTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_table_scale(s : CryptoasymelgamalTable, f : Double) -> CryptoasymelgamalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_table_add(a : CryptoasymelgamalTable, b : CryptoasymelgamalTable) -> CryptoasymelgamalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_table_copy(s : CryptoasymelgamalTable) -> CryptoasymelgamalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_table_fill(s : CryptoasymelgamalTable, v : Double) -> CryptoasymelgamalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_table_min(s : CryptoasymelgamalTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_table_max(s : CryptoasymelgamalTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_table_to_string(s : CryptoasymelgamalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_graphn_make(size : Int) -> CryptoasymelgamalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_graphn_len(s : CryptoasymelgamalGraphN) -> Int { s.size }

pub fn crypto_asym_elgamal_graphn_get(s : CryptoasymelgamalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_graphn_set(s : CryptoasymelgamalGraphN, i : Int, v : Double) -> CryptoasymelgamalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_graphn_sum(s : CryptoasymelgamalGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_graphn_mean(s : CryptoasymelgamalGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_graphn_scale(s : CryptoasymelgamalGraphN, f : Double) -> CryptoasymelgamalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_graphn_add(a : CryptoasymelgamalGraphN, b : CryptoasymelgamalGraphN) -> CryptoasymelgamalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_graphn_copy(s : CryptoasymelgamalGraphN) -> CryptoasymelgamalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_graphn_fill(s : CryptoasymelgamalGraphN, v : Double) -> CryptoasymelgamalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_graphn_min(s : CryptoasymelgamalGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_graphn_max(s : CryptoasymelgamalGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_graphn_to_string(s : CryptoasymelgamalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_node_make(size : Int) -> CryptoasymelgamalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_node_len(s : CryptoasymelgamalNode) -> Int { s.size }

pub fn crypto_asym_elgamal_node_get(s : CryptoasymelgamalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_node_set(s : CryptoasymelgamalNode, i : Int, v : Double) -> CryptoasymelgamalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_node_sum(s : CryptoasymelgamalNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_node_mean(s : CryptoasymelgamalNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_node_scale(s : CryptoasymelgamalNode, f : Double) -> CryptoasymelgamalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_node_add(a : CryptoasymelgamalNode, b : CryptoasymelgamalNode) -> CryptoasymelgamalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_node_copy(s : CryptoasymelgamalNode) -> CryptoasymelgamalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_node_fill(s : CryptoasymelgamalNode, v : Double) -> CryptoasymelgamalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_node_min(s : CryptoasymelgamalNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_node_max(s : CryptoasymelgamalNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_node_to_string(s : CryptoasymelgamalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_edge_make(size : Int) -> CryptoasymelgamalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_edge_len(s : CryptoasymelgamalEdge) -> Int { s.size }

pub fn crypto_asym_elgamal_edge_get(s : CryptoasymelgamalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_edge_set(s : CryptoasymelgamalEdge, i : Int, v : Double) -> CryptoasymelgamalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_edge_sum(s : CryptoasymelgamalEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_edge_mean(s : CryptoasymelgamalEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_edge_scale(s : CryptoasymelgamalEdge, f : Double) -> CryptoasymelgamalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_edge_add(a : CryptoasymelgamalEdge, b : CryptoasymelgamalEdge) -> CryptoasymelgamalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_edge_copy(s : CryptoasymelgamalEdge) -> CryptoasymelgamalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_edge_fill(s : CryptoasymelgamalEdge, v : Double) -> CryptoasymelgamalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_edge_min(s : CryptoasymelgamalEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_edge_max(s : CryptoasymelgamalEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_edge_to_string(s : CryptoasymelgamalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_path_make(size : Int) -> CryptoasymelgamalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_path_len(s : CryptoasymelgamalPath) -> Int { s.size }

pub fn crypto_asym_elgamal_path_get(s : CryptoasymelgamalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_path_set(s : CryptoasymelgamalPath, i : Int, v : Double) -> CryptoasymelgamalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_path_sum(s : CryptoasymelgamalPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_path_mean(s : CryptoasymelgamalPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_path_scale(s : CryptoasymelgamalPath, f : Double) -> CryptoasymelgamalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_path_add(a : CryptoasymelgamalPath, b : CryptoasymelgamalPath) -> CryptoasymelgamalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_path_copy(s : CryptoasymelgamalPath) -> CryptoasymelgamalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_path_fill(s : CryptoasymelgamalPath, v : Double) -> CryptoasymelgamalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_path_min(s : CryptoasymelgamalPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_path_max(s : CryptoasymelgamalPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_path_to_string(s : CryptoasymelgamalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_cluster_make(size : Int) -> CryptoasymelgamalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_cluster_len(s : CryptoasymelgamalCluster) -> Int { s.size }

pub fn crypto_asym_elgamal_cluster_get(s : CryptoasymelgamalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_cluster_set(s : CryptoasymelgamalCluster, i : Int, v : Double) -> CryptoasymelgamalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_cluster_sum(s : CryptoasymelgamalCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_cluster_mean(s : CryptoasymelgamalCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_cluster_scale(s : CryptoasymelgamalCluster, f : Double) -> CryptoasymelgamalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_cluster_add(a : CryptoasymelgamalCluster, b : CryptoasymelgamalCluster) -> CryptoasymelgamalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_cluster_copy(s : CryptoasymelgamalCluster) -> CryptoasymelgamalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_cluster_fill(s : CryptoasymelgamalCluster, v : Double) -> CryptoasymelgamalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_cluster_min(s : CryptoasymelgamalCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_cluster_max(s : CryptoasymelgamalCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_cluster_to_string(s : CryptoasymelgamalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_model_make(size : Int) -> CryptoasymelgamalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_model_len(s : CryptoasymelgamalModel) -> Int { s.size }

pub fn crypto_asym_elgamal_model_get(s : CryptoasymelgamalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_model_set(s : CryptoasymelgamalModel, i : Int, v : Double) -> CryptoasymelgamalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_model_sum(s : CryptoasymelgamalModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_model_mean(s : CryptoasymelgamalModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_model_scale(s : CryptoasymelgamalModel, f : Double) -> CryptoasymelgamalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_model_add(a : CryptoasymelgamalModel, b : CryptoasymelgamalModel) -> CryptoasymelgamalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_model_copy(s : CryptoasymelgamalModel) -> CryptoasymelgamalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_model_fill(s : CryptoasymelgamalModel, v : Double) -> CryptoasymelgamalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_model_min(s : CryptoasymelgamalModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_model_max(s : CryptoasymelgamalModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_model_to_string(s : CryptoasymelgamalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_layer_make(size : Int) -> CryptoasymelgamalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_layer_len(s : CryptoasymelgamalLayer) -> Int { s.size }

pub fn crypto_asym_elgamal_layer_get(s : CryptoasymelgamalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_layer_set(s : CryptoasymelgamalLayer, i : Int, v : Double) -> CryptoasymelgamalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_layer_sum(s : CryptoasymelgamalLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_layer_mean(s : CryptoasymelgamalLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_layer_scale(s : CryptoasymelgamalLayer, f : Double) -> CryptoasymelgamalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_layer_add(a : CryptoasymelgamalLayer, b : CryptoasymelgamalLayer) -> CryptoasymelgamalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_layer_copy(s : CryptoasymelgamalLayer) -> CryptoasymelgamalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_layer_fill(s : CryptoasymelgamalLayer, v : Double) -> CryptoasymelgamalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_layer_min(s : CryptoasymelgamalLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_layer_max(s : CryptoasymelgamalLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_layer_to_string(s : CryptoasymelgamalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_buffer_make(size : Int) -> CryptoasymelgamalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_buffer_len(s : CryptoasymelgamalBuffer) -> Int { s.size }

pub fn crypto_asym_elgamal_buffer_get(s : CryptoasymelgamalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_buffer_set(s : CryptoasymelgamalBuffer, i : Int, v : Double) -> CryptoasymelgamalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_buffer_sum(s : CryptoasymelgamalBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_buffer_mean(s : CryptoasymelgamalBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_buffer_scale(s : CryptoasymelgamalBuffer, f : Double) -> CryptoasymelgamalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_buffer_add(a : CryptoasymelgamalBuffer, b : CryptoasymelgamalBuffer) -> CryptoasymelgamalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_buffer_copy(s : CryptoasymelgamalBuffer) -> CryptoasymelgamalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_buffer_fill(s : CryptoasymelgamalBuffer, v : Double) -> CryptoasymelgamalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_buffer_min(s : CryptoasymelgamalBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_buffer_max(s : CryptoasymelgamalBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_buffer_to_string(s : CryptoasymelgamalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_cursor_make(size : Int) -> CryptoasymelgamalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_cursor_len(s : CryptoasymelgamalCursor) -> Int { s.size }

pub fn crypto_asym_elgamal_cursor_get(s : CryptoasymelgamalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_cursor_set(s : CryptoasymelgamalCursor, i : Int, v : Double) -> CryptoasymelgamalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_cursor_sum(s : CryptoasymelgamalCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_cursor_mean(s : CryptoasymelgamalCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_cursor_scale(s : CryptoasymelgamalCursor, f : Double) -> CryptoasymelgamalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_cursor_add(a : CryptoasymelgamalCursor, b : CryptoasymelgamalCursor) -> CryptoasymelgamalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_cursor_copy(s : CryptoasymelgamalCursor) -> CryptoasymelgamalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_cursor_fill(s : CryptoasymelgamalCursor, v : Double) -> CryptoasymelgamalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_cursor_min(s : CryptoasymelgamalCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_cursor_max(s : CryptoasymelgamalCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_cursor_to_string(s : CryptoasymelgamalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_view_make(size : Int) -> CryptoasymelgamalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_view_len(s : CryptoasymelgamalView) -> Int { s.size }

pub fn crypto_asym_elgamal_view_get(s : CryptoasymelgamalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_view_set(s : CryptoasymelgamalView, i : Int, v : Double) -> CryptoasymelgamalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_view_sum(s : CryptoasymelgamalView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_view_mean(s : CryptoasymelgamalView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_view_scale(s : CryptoasymelgamalView, f : Double) -> CryptoasymelgamalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_view_add(a : CryptoasymelgamalView, b : CryptoasymelgamalView) -> CryptoasymelgamalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_view_copy(s : CryptoasymelgamalView) -> CryptoasymelgamalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_view_fill(s : CryptoasymelgamalView, v : Double) -> CryptoasymelgamalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_view_min(s : CryptoasymelgamalView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_view_max(s : CryptoasymelgamalView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_view_to_string(s : CryptoasymelgamalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_range_make(size : Int) -> CryptoasymelgamalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_range_len(s : CryptoasymelgamalRange) -> Int { s.size }

pub fn crypto_asym_elgamal_range_get(s : CryptoasymelgamalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_range_set(s : CryptoasymelgamalRange, i : Int, v : Double) -> CryptoasymelgamalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_range_sum(s : CryptoasymelgamalRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_range_mean(s : CryptoasymelgamalRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_range_scale(s : CryptoasymelgamalRange, f : Double) -> CryptoasymelgamalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_range_add(a : CryptoasymelgamalRange, b : CryptoasymelgamalRange) -> CryptoasymelgamalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_range_copy(s : CryptoasymelgamalRange) -> CryptoasymelgamalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_range_fill(s : CryptoasymelgamalRange, v : Double) -> CryptoasymelgamalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_range_min(s : CryptoasymelgamalRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_range_max(s : CryptoasymelgamalRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_range_to_string(s : CryptoasymelgamalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_slice_make(size : Int) -> CryptoasymelgamalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_slice_len(s : CryptoasymelgamalSlice) -> Int { s.size }

pub fn crypto_asym_elgamal_slice_get(s : CryptoasymelgamalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_slice_set(s : CryptoasymelgamalSlice, i : Int, v : Double) -> CryptoasymelgamalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_slice_sum(s : CryptoasymelgamalSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_elgamal_slice_mean(s : CryptoasymelgamalSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_elgamal_slice_scale(s : CryptoasymelgamalSlice, f : Double) -> CryptoasymelgamalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_slice_add(a : CryptoasymelgamalSlice, b : CryptoasymelgamalSlice) -> CryptoasymelgamalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_elgamal_slice_copy(s : CryptoasymelgamalSlice) -> CryptoasymelgamalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_slice_fill(s : CryptoasymelgamalSlice, v : Double) -> CryptoasymelgamalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_elgamal_slice_min(s : CryptoasymelgamalSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_elgamal_slice_max(s : CryptoasymelgamalSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_elgamal_slice_to_string(s : CryptoasymelgamalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

