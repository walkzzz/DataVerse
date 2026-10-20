///===
/// extcore/crypto_sym_twofish

pub(all) struct CryptosymtwofishPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_twofish_make_point(x : Double, y : Double) -> CryptosymtwofishPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_twofish_make_point3(x : Double, y : Double, z : Double) -> CryptosymtwofishPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymtwofishPoint::x(self : CryptosymtwofishPoint) -> Double { self.x }

pub fn CryptosymtwofishPoint::y(self : CryptosymtwofishPoint) -> Double { self.y }

pub fn CryptosymtwofishPoint::z(self : CryptosymtwofishPoint) -> Double { self.z }

pub fn CryptosymtwofishPoint::label(self : CryptosymtwofishPoint) -> Int { self.label }

pub fn CryptosymtwofishPoint::dist(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymtwofishPoint::add(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymtwofishPoint::sub(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymtwofishPoint::scale(self : CryptosymtwofishPoint, s : Double) -> CryptosymtwofishPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymtwofishPoint::dot(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymtwofishPoint::cross(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymtwofishPoint::norm(self : CryptosymtwofishPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymtwofishPoint::normalize(self : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymtwofishPoint::negate(self : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymtwofishPoint::mid(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymtwofishPoint::lerp(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint, t : Double) -> CryptosymtwofishPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymtwofishPoint::to_string(self : CryptosymtwofishPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymtwofishSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_twofish_make_series(vals : Array[Double], name : String) -> CryptosymtwofishSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymtwofishSeries::len(self : CryptosymtwofishSeries) -> Int { self.vals.length() }

pub fn CryptosymtwofishSeries::sum(self : CryptosymtwofishSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymtwofishSeries::mean(self : CryptosymtwofishSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymtwofishSeries::min(self : CryptosymtwofishSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymtwofishSeries::max(self : CryptosymtwofishSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymtwofishSeries::range(self : CryptosymtwofishSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymtwofishSeries::variance(self : CryptosymtwofishSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymtwofishSeries::std(self : CryptosymtwofishSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymtwofishSeries::median(self : CryptosymtwofishSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymtwofishSeries::scale(self : CryptosymtwofishSeries, f : Double) -> CryptosymtwofishSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymtwofishSeries::add(self : CryptosymtwofishSeries, other : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymtwofishSeries::sub(self : CryptosymtwofishSeries, other : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymtwofishSeries::normalize(self : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymtwofishSeries::cumsum(self : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymtwofishSeries::to_string(self : CryptosymtwofishSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymtwofishMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_twofish_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymtwofishMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_twofish_matrix_identity(n : Int) -> CryptosymtwofishMatrix {
  let m = crypto_sym_twofish_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymtwofishMatrix::get(self : CryptosymtwofishMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymtwofishMatrix::transpose(self : CryptosymtwofishMatrix) -> CryptosymtwofishMatrix {
  let result = crypto_sym_twofish_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymtwofishMatrix::add(self : CryptosymtwofishMatrix, other : CryptosymtwofishMatrix) -> CryptosymtwofishMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_twofish_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymtwofishMatrix::scale(self : CryptosymtwofishMatrix, s : Double) -> CryptosymtwofishMatrix {
  let result = crypto_sym_twofish_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymtwofishMatrix::multiply(self : CryptosymtwofishMatrix, other : CryptosymtwofishMatrix) -> CryptosymtwofishMatrix {
  if self.cols != other.rows { return crypto_sym_twofish_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_twofish_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymtwofishMatrix::trace(self : CryptosymtwofishMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymtwofishMatrix::det(self : CryptosymtwofishMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymtwofishMatrix::norm(self : CryptosymtwofishMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymtwofishMatrix::to_string(self : CryptosymtwofishMatrix) -> String {
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

pub(all) struct CryptosymtwofishVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_twofish_make_vector(comps : Array[Double]) -> CryptosymtwofishVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_twofish_vector_zero(dim : Int) -> CryptosymtwofishVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymtwofishVector::add(self : CryptosymtwofishVector, other : CryptosymtwofishVector) -> CryptosymtwofishVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymtwofishVector::sub(self : CryptosymtwofishVector, other : CryptosymtwofishVector) -> CryptosymtwofishVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymtwofishVector::scale(self : CryptosymtwofishVector, s : Double) -> CryptosymtwofishVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymtwofishVector::dot(self : CryptosymtwofishVector, other : CryptosymtwofishVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymtwofishVector::norm(self : CryptosymtwofishVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymtwofishVector::normalize(self : CryptosymtwofishVector) -> CryptosymtwofishVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymtwofishVector::dist(self : CryptosymtwofishVector, other : CryptosymtwofishVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymtwofishVector::to_string(self : CryptosymtwofishVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_twofish_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_twofish_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_twofish_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_twofish_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_twofish_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_twofish_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_twofish_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_twofish_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_twofish_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_twofish_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_twofish_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_twofish_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_twofish_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_twofish_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_twofish_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_twofish_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_twofish_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_twofish_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_twofish_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_twofish_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_twofish_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_twofish_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_twofish_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_twofish_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_twofish_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_twofish_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_twofish_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_twofish_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_twofish_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymtwofishFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_frame_make(size : Int) -> CryptosymtwofishFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_frame_len(s : CryptosymtwofishFrame) -> Int { s.size }

pub fn crypto_sym_twofish_frame_get(s : CryptosymtwofishFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_frame_set(s : CryptosymtwofishFrame, i : Int, v : Double) -> CryptosymtwofishFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_frame_sum(s : CryptosymtwofishFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_frame_mean(s : CryptosymtwofishFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_frame_scale(s : CryptosymtwofishFrame, f : Double) -> CryptosymtwofishFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_frame_add(a : CryptosymtwofishFrame, b : CryptosymtwofishFrame) -> CryptosymtwofishFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_frame_copy(s : CryptosymtwofishFrame) -> CryptosymtwofishFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_frame_fill(s : CryptosymtwofishFrame, v : Double) -> CryptosymtwofishFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_frame_min(s : CryptosymtwofishFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_frame_max(s : CryptosymtwofishFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_frame_to_string(s : CryptosymtwofishFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_table_make(size : Int) -> CryptosymtwofishTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_table_len(s : CryptosymtwofishTable) -> Int { s.size }

pub fn crypto_sym_twofish_table_get(s : CryptosymtwofishTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_table_set(s : CryptosymtwofishTable, i : Int, v : Double) -> CryptosymtwofishTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_table_sum(s : CryptosymtwofishTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_table_mean(s : CryptosymtwofishTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_table_scale(s : CryptosymtwofishTable, f : Double) -> CryptosymtwofishTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_table_add(a : CryptosymtwofishTable, b : CryptosymtwofishTable) -> CryptosymtwofishTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_table_copy(s : CryptosymtwofishTable) -> CryptosymtwofishTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_table_fill(s : CryptosymtwofishTable, v : Double) -> CryptosymtwofishTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_table_min(s : CryptosymtwofishTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_table_max(s : CryptosymtwofishTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_table_to_string(s : CryptosymtwofishTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_graphn_make(size : Int) -> CryptosymtwofishGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_graphn_len(s : CryptosymtwofishGraphN) -> Int { s.size }

pub fn crypto_sym_twofish_graphn_get(s : CryptosymtwofishGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_graphn_set(s : CryptosymtwofishGraphN, i : Int, v : Double) -> CryptosymtwofishGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_graphn_sum(s : CryptosymtwofishGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_graphn_mean(s : CryptosymtwofishGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_graphn_scale(s : CryptosymtwofishGraphN, f : Double) -> CryptosymtwofishGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_graphn_add(a : CryptosymtwofishGraphN, b : CryptosymtwofishGraphN) -> CryptosymtwofishGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_graphn_copy(s : CryptosymtwofishGraphN) -> CryptosymtwofishGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_graphn_fill(s : CryptosymtwofishGraphN, v : Double) -> CryptosymtwofishGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_graphn_min(s : CryptosymtwofishGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_graphn_max(s : CryptosymtwofishGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_graphn_to_string(s : CryptosymtwofishGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_node_make(size : Int) -> CryptosymtwofishNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_node_len(s : CryptosymtwofishNode) -> Int { s.size }

pub fn crypto_sym_twofish_node_get(s : CryptosymtwofishNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_node_set(s : CryptosymtwofishNode, i : Int, v : Double) -> CryptosymtwofishNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_node_sum(s : CryptosymtwofishNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_node_mean(s : CryptosymtwofishNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_node_scale(s : CryptosymtwofishNode, f : Double) -> CryptosymtwofishNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_node_add(a : CryptosymtwofishNode, b : CryptosymtwofishNode) -> CryptosymtwofishNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_node_copy(s : CryptosymtwofishNode) -> CryptosymtwofishNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_node_fill(s : CryptosymtwofishNode, v : Double) -> CryptosymtwofishNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_node_min(s : CryptosymtwofishNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_node_max(s : CryptosymtwofishNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_node_to_string(s : CryptosymtwofishNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_edge_make(size : Int) -> CryptosymtwofishEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_edge_len(s : CryptosymtwofishEdge) -> Int { s.size }

pub fn crypto_sym_twofish_edge_get(s : CryptosymtwofishEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_edge_set(s : CryptosymtwofishEdge, i : Int, v : Double) -> CryptosymtwofishEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_edge_sum(s : CryptosymtwofishEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_edge_mean(s : CryptosymtwofishEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_edge_scale(s : CryptosymtwofishEdge, f : Double) -> CryptosymtwofishEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_edge_add(a : CryptosymtwofishEdge, b : CryptosymtwofishEdge) -> CryptosymtwofishEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_edge_copy(s : CryptosymtwofishEdge) -> CryptosymtwofishEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_edge_fill(s : CryptosymtwofishEdge, v : Double) -> CryptosymtwofishEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_edge_min(s : CryptosymtwofishEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_edge_max(s : CryptosymtwofishEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_edge_to_string(s : CryptosymtwofishEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_path_make(size : Int) -> CryptosymtwofishPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_path_len(s : CryptosymtwofishPath) -> Int { s.size }

pub fn crypto_sym_twofish_path_get(s : CryptosymtwofishPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_path_set(s : CryptosymtwofishPath, i : Int, v : Double) -> CryptosymtwofishPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_path_sum(s : CryptosymtwofishPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_path_mean(s : CryptosymtwofishPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_path_scale(s : CryptosymtwofishPath, f : Double) -> CryptosymtwofishPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_path_add(a : CryptosymtwofishPath, b : CryptosymtwofishPath) -> CryptosymtwofishPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_path_copy(s : CryptosymtwofishPath) -> CryptosymtwofishPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_path_fill(s : CryptosymtwofishPath, v : Double) -> CryptosymtwofishPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_path_min(s : CryptosymtwofishPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_path_max(s : CryptosymtwofishPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_path_to_string(s : CryptosymtwofishPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_cluster_make(size : Int) -> CryptosymtwofishCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_cluster_len(s : CryptosymtwofishCluster) -> Int { s.size }

pub fn crypto_sym_twofish_cluster_get(s : CryptosymtwofishCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_cluster_set(s : CryptosymtwofishCluster, i : Int, v : Double) -> CryptosymtwofishCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_cluster_sum(s : CryptosymtwofishCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_cluster_mean(s : CryptosymtwofishCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_cluster_scale(s : CryptosymtwofishCluster, f : Double) -> CryptosymtwofishCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_cluster_add(a : CryptosymtwofishCluster, b : CryptosymtwofishCluster) -> CryptosymtwofishCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_cluster_copy(s : CryptosymtwofishCluster) -> CryptosymtwofishCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_cluster_fill(s : CryptosymtwofishCluster, v : Double) -> CryptosymtwofishCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_cluster_min(s : CryptosymtwofishCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_cluster_max(s : CryptosymtwofishCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_cluster_to_string(s : CryptosymtwofishCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_model_make(size : Int) -> CryptosymtwofishModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_model_len(s : CryptosymtwofishModel) -> Int { s.size }

pub fn crypto_sym_twofish_model_get(s : CryptosymtwofishModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_model_set(s : CryptosymtwofishModel, i : Int, v : Double) -> CryptosymtwofishModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_model_sum(s : CryptosymtwofishModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_model_mean(s : CryptosymtwofishModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_model_scale(s : CryptosymtwofishModel, f : Double) -> CryptosymtwofishModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_model_add(a : CryptosymtwofishModel, b : CryptosymtwofishModel) -> CryptosymtwofishModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_model_copy(s : CryptosymtwofishModel) -> CryptosymtwofishModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_model_fill(s : CryptosymtwofishModel, v : Double) -> CryptosymtwofishModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_model_min(s : CryptosymtwofishModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_model_max(s : CryptosymtwofishModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_model_to_string(s : CryptosymtwofishModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_layer_make(size : Int) -> CryptosymtwofishLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_layer_len(s : CryptosymtwofishLayer) -> Int { s.size }

pub fn crypto_sym_twofish_layer_get(s : CryptosymtwofishLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_layer_set(s : CryptosymtwofishLayer, i : Int, v : Double) -> CryptosymtwofishLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_layer_sum(s : CryptosymtwofishLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_layer_mean(s : CryptosymtwofishLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_layer_scale(s : CryptosymtwofishLayer, f : Double) -> CryptosymtwofishLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_layer_add(a : CryptosymtwofishLayer, b : CryptosymtwofishLayer) -> CryptosymtwofishLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_layer_copy(s : CryptosymtwofishLayer) -> CryptosymtwofishLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_layer_fill(s : CryptosymtwofishLayer, v : Double) -> CryptosymtwofishLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_layer_min(s : CryptosymtwofishLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_layer_max(s : CryptosymtwofishLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_layer_to_string(s : CryptosymtwofishLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_buffer_make(size : Int) -> CryptosymtwofishBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_buffer_len(s : CryptosymtwofishBuffer) -> Int { s.size }

pub fn crypto_sym_twofish_buffer_get(s : CryptosymtwofishBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_buffer_set(s : CryptosymtwofishBuffer, i : Int, v : Double) -> CryptosymtwofishBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_buffer_sum(s : CryptosymtwofishBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_buffer_mean(s : CryptosymtwofishBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_buffer_scale(s : CryptosymtwofishBuffer, f : Double) -> CryptosymtwofishBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_buffer_add(a : CryptosymtwofishBuffer, b : CryptosymtwofishBuffer) -> CryptosymtwofishBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_buffer_copy(s : CryptosymtwofishBuffer) -> CryptosymtwofishBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_buffer_fill(s : CryptosymtwofishBuffer, v : Double) -> CryptosymtwofishBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_buffer_min(s : CryptosymtwofishBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_buffer_max(s : CryptosymtwofishBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_buffer_to_string(s : CryptosymtwofishBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_cursor_make(size : Int) -> CryptosymtwofishCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_cursor_len(s : CryptosymtwofishCursor) -> Int { s.size }

pub fn crypto_sym_twofish_cursor_get(s : CryptosymtwofishCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_cursor_set(s : CryptosymtwofishCursor, i : Int, v : Double) -> CryptosymtwofishCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_cursor_sum(s : CryptosymtwofishCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_cursor_mean(s : CryptosymtwofishCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_cursor_scale(s : CryptosymtwofishCursor, f : Double) -> CryptosymtwofishCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_cursor_add(a : CryptosymtwofishCursor, b : CryptosymtwofishCursor) -> CryptosymtwofishCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_cursor_copy(s : CryptosymtwofishCursor) -> CryptosymtwofishCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_cursor_fill(s : CryptosymtwofishCursor, v : Double) -> CryptosymtwofishCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_cursor_min(s : CryptosymtwofishCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_cursor_max(s : CryptosymtwofishCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_cursor_to_string(s : CryptosymtwofishCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_view_make(size : Int) -> CryptosymtwofishView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_view_len(s : CryptosymtwofishView) -> Int { s.size }

pub fn crypto_sym_twofish_view_get(s : CryptosymtwofishView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_view_set(s : CryptosymtwofishView, i : Int, v : Double) -> CryptosymtwofishView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_view_sum(s : CryptosymtwofishView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_view_mean(s : CryptosymtwofishView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_view_scale(s : CryptosymtwofishView, f : Double) -> CryptosymtwofishView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_view_add(a : CryptosymtwofishView, b : CryptosymtwofishView) -> CryptosymtwofishView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_view_copy(s : CryptosymtwofishView) -> CryptosymtwofishView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_view_fill(s : CryptosymtwofishView, v : Double) -> CryptosymtwofishView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_view_min(s : CryptosymtwofishView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_view_max(s : CryptosymtwofishView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_view_to_string(s : CryptosymtwofishView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_range_make(size : Int) -> CryptosymtwofishRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_range_len(s : CryptosymtwofishRange) -> Int { s.size }

pub fn crypto_sym_twofish_range_get(s : CryptosymtwofishRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_range_set(s : CryptosymtwofishRange, i : Int, v : Double) -> CryptosymtwofishRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_range_sum(s : CryptosymtwofishRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_range_mean(s : CryptosymtwofishRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_range_scale(s : CryptosymtwofishRange, f : Double) -> CryptosymtwofishRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_range_add(a : CryptosymtwofishRange, b : CryptosymtwofishRange) -> CryptosymtwofishRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_range_copy(s : CryptosymtwofishRange) -> CryptosymtwofishRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_range_fill(s : CryptosymtwofishRange, v : Double) -> CryptosymtwofishRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_range_min(s : CryptosymtwofishRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_range_max(s : CryptosymtwofishRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_range_to_string(s : CryptosymtwofishRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_slice_make(size : Int) -> CryptosymtwofishSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_slice_len(s : CryptosymtwofishSlice) -> Int { s.size }

pub fn crypto_sym_twofish_slice_get(s : CryptosymtwofishSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_slice_set(s : CryptosymtwofishSlice, i : Int, v : Double) -> CryptosymtwofishSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_slice_sum(s : CryptosymtwofishSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_twofish_slice_mean(s : CryptosymtwofishSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_twofish_slice_scale(s : CryptosymtwofishSlice, f : Double) -> CryptosymtwofishSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_slice_add(a : CryptosymtwofishSlice, b : CryptosymtwofishSlice) -> CryptosymtwofishSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_twofish_slice_copy(s : CryptosymtwofishSlice) -> CryptosymtwofishSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_slice_fill(s : CryptosymtwofishSlice, v : Double) -> CryptosymtwofishSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_twofish_slice_min(s : CryptosymtwofishSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_twofish_slice_max(s : CryptosymtwofishSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_twofish_slice_to_string(s : CryptosymtwofishSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

