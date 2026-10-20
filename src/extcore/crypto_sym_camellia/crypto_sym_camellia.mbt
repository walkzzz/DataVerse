///===
/// extcore/crypto_sym_camellia

pub(all) struct CryptosymcamelliaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_camellia_make_point(x : Double, y : Double) -> CryptosymcamelliaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_camellia_make_point3(x : Double, y : Double, z : Double) -> CryptosymcamelliaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymcamelliaPoint::x(self : CryptosymcamelliaPoint) -> Double { self.x }

pub fn CryptosymcamelliaPoint::y(self : CryptosymcamelliaPoint) -> Double { self.y }

pub fn CryptosymcamelliaPoint::z(self : CryptosymcamelliaPoint) -> Double { self.z }

pub fn CryptosymcamelliaPoint::label(self : CryptosymcamelliaPoint) -> Int { self.label }

pub fn CryptosymcamelliaPoint::dist(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymcamelliaPoint::add(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymcamelliaPoint::sub(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymcamelliaPoint::scale(self : CryptosymcamelliaPoint, s : Double) -> CryptosymcamelliaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymcamelliaPoint::dot(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymcamelliaPoint::cross(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymcamelliaPoint::norm(self : CryptosymcamelliaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymcamelliaPoint::normalize(self : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymcamelliaPoint::negate(self : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymcamelliaPoint::mid(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymcamelliaPoint::lerp(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint, t : Double) -> CryptosymcamelliaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymcamelliaPoint::to_string(self : CryptosymcamelliaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymcamelliaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_camellia_make_series(vals : Array[Double], name : String) -> CryptosymcamelliaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymcamelliaSeries::len(self : CryptosymcamelliaSeries) -> Int { self.vals.length() }

pub fn CryptosymcamelliaSeries::sum(self : CryptosymcamelliaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymcamelliaSeries::mean(self : CryptosymcamelliaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymcamelliaSeries::min(self : CryptosymcamelliaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymcamelliaSeries::max(self : CryptosymcamelliaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymcamelliaSeries::range(self : CryptosymcamelliaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymcamelliaSeries::variance(self : CryptosymcamelliaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymcamelliaSeries::std(self : CryptosymcamelliaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymcamelliaSeries::median(self : CryptosymcamelliaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymcamelliaSeries::scale(self : CryptosymcamelliaSeries, f : Double) -> CryptosymcamelliaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymcamelliaSeries::add(self : CryptosymcamelliaSeries, other : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymcamelliaSeries::sub(self : CryptosymcamelliaSeries, other : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymcamelliaSeries::normalize(self : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymcamelliaSeries::cumsum(self : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymcamelliaSeries::to_string(self : CryptosymcamelliaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymcamelliaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_camellia_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymcamelliaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_camellia_matrix_identity(n : Int) -> CryptosymcamelliaMatrix {
  let m = crypto_sym_camellia_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymcamelliaMatrix::get(self : CryptosymcamelliaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymcamelliaMatrix::transpose(self : CryptosymcamelliaMatrix) -> CryptosymcamelliaMatrix {
  let result = crypto_sym_camellia_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymcamelliaMatrix::add(self : CryptosymcamelliaMatrix, other : CryptosymcamelliaMatrix) -> CryptosymcamelliaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_camellia_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymcamelliaMatrix::scale(self : CryptosymcamelliaMatrix, s : Double) -> CryptosymcamelliaMatrix {
  let result = crypto_sym_camellia_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymcamelliaMatrix::multiply(self : CryptosymcamelliaMatrix, other : CryptosymcamelliaMatrix) -> CryptosymcamelliaMatrix {
  if self.cols != other.rows { return crypto_sym_camellia_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_camellia_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymcamelliaMatrix::trace(self : CryptosymcamelliaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymcamelliaMatrix::det(self : CryptosymcamelliaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymcamelliaMatrix::norm(self : CryptosymcamelliaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymcamelliaMatrix::to_string(self : CryptosymcamelliaMatrix) -> String {
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

pub(all) struct CryptosymcamelliaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_camellia_make_vector(comps : Array[Double]) -> CryptosymcamelliaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_camellia_vector_zero(dim : Int) -> CryptosymcamelliaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymcamelliaVector::add(self : CryptosymcamelliaVector, other : CryptosymcamelliaVector) -> CryptosymcamelliaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymcamelliaVector::sub(self : CryptosymcamelliaVector, other : CryptosymcamelliaVector) -> CryptosymcamelliaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymcamelliaVector::scale(self : CryptosymcamelliaVector, s : Double) -> CryptosymcamelliaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymcamelliaVector::dot(self : CryptosymcamelliaVector, other : CryptosymcamelliaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymcamelliaVector::norm(self : CryptosymcamelliaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymcamelliaVector::normalize(self : CryptosymcamelliaVector) -> CryptosymcamelliaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymcamelliaVector::dist(self : CryptosymcamelliaVector, other : CryptosymcamelliaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymcamelliaVector::to_string(self : CryptosymcamelliaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_camellia_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_camellia_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_camellia_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_camellia_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_camellia_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_camellia_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_camellia_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_camellia_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_camellia_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_camellia_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_camellia_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_camellia_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_camellia_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_camellia_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_camellia_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_camellia_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_camellia_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_camellia_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_camellia_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_camellia_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_camellia_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_camellia_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_camellia_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_camellia_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_camellia_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_camellia_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_camellia_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_camellia_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_camellia_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymcamelliaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_frame_make(size : Int) -> CryptosymcamelliaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_frame_len(s : CryptosymcamelliaFrame) -> Int { s.size }

pub fn crypto_sym_camellia_frame_get(s : CryptosymcamelliaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_frame_set(s : CryptosymcamelliaFrame, i : Int, v : Double) -> CryptosymcamelliaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_frame_sum(s : CryptosymcamelliaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_frame_mean(s : CryptosymcamelliaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_frame_scale(s : CryptosymcamelliaFrame, f : Double) -> CryptosymcamelliaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_frame_add(a : CryptosymcamelliaFrame, b : CryptosymcamelliaFrame) -> CryptosymcamelliaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_frame_copy(s : CryptosymcamelliaFrame) -> CryptosymcamelliaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_frame_fill(s : CryptosymcamelliaFrame, v : Double) -> CryptosymcamelliaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_frame_min(s : CryptosymcamelliaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_frame_max(s : CryptosymcamelliaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_frame_to_string(s : CryptosymcamelliaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_table_make(size : Int) -> CryptosymcamelliaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_table_len(s : CryptosymcamelliaTable) -> Int { s.size }

pub fn crypto_sym_camellia_table_get(s : CryptosymcamelliaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_table_set(s : CryptosymcamelliaTable, i : Int, v : Double) -> CryptosymcamelliaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_table_sum(s : CryptosymcamelliaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_table_mean(s : CryptosymcamelliaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_table_scale(s : CryptosymcamelliaTable, f : Double) -> CryptosymcamelliaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_table_add(a : CryptosymcamelliaTable, b : CryptosymcamelliaTable) -> CryptosymcamelliaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_table_copy(s : CryptosymcamelliaTable) -> CryptosymcamelliaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_table_fill(s : CryptosymcamelliaTable, v : Double) -> CryptosymcamelliaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_table_min(s : CryptosymcamelliaTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_table_max(s : CryptosymcamelliaTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_table_to_string(s : CryptosymcamelliaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_graphn_make(size : Int) -> CryptosymcamelliaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_graphn_len(s : CryptosymcamelliaGraphN) -> Int { s.size }

pub fn crypto_sym_camellia_graphn_get(s : CryptosymcamelliaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_graphn_set(s : CryptosymcamelliaGraphN, i : Int, v : Double) -> CryptosymcamelliaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_graphn_sum(s : CryptosymcamelliaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_graphn_mean(s : CryptosymcamelliaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_graphn_scale(s : CryptosymcamelliaGraphN, f : Double) -> CryptosymcamelliaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_graphn_add(a : CryptosymcamelliaGraphN, b : CryptosymcamelliaGraphN) -> CryptosymcamelliaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_graphn_copy(s : CryptosymcamelliaGraphN) -> CryptosymcamelliaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_graphn_fill(s : CryptosymcamelliaGraphN, v : Double) -> CryptosymcamelliaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_graphn_min(s : CryptosymcamelliaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_graphn_max(s : CryptosymcamelliaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_graphn_to_string(s : CryptosymcamelliaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_node_make(size : Int) -> CryptosymcamelliaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_node_len(s : CryptosymcamelliaNode) -> Int { s.size }

pub fn crypto_sym_camellia_node_get(s : CryptosymcamelliaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_node_set(s : CryptosymcamelliaNode, i : Int, v : Double) -> CryptosymcamelliaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_node_sum(s : CryptosymcamelliaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_node_mean(s : CryptosymcamelliaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_node_scale(s : CryptosymcamelliaNode, f : Double) -> CryptosymcamelliaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_node_add(a : CryptosymcamelliaNode, b : CryptosymcamelliaNode) -> CryptosymcamelliaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_node_copy(s : CryptosymcamelliaNode) -> CryptosymcamelliaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_node_fill(s : CryptosymcamelliaNode, v : Double) -> CryptosymcamelliaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_node_min(s : CryptosymcamelliaNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_node_max(s : CryptosymcamelliaNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_node_to_string(s : CryptosymcamelliaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_edge_make(size : Int) -> CryptosymcamelliaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_edge_len(s : CryptosymcamelliaEdge) -> Int { s.size }

pub fn crypto_sym_camellia_edge_get(s : CryptosymcamelliaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_edge_set(s : CryptosymcamelliaEdge, i : Int, v : Double) -> CryptosymcamelliaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_edge_sum(s : CryptosymcamelliaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_edge_mean(s : CryptosymcamelliaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_edge_scale(s : CryptosymcamelliaEdge, f : Double) -> CryptosymcamelliaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_edge_add(a : CryptosymcamelliaEdge, b : CryptosymcamelliaEdge) -> CryptosymcamelliaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_edge_copy(s : CryptosymcamelliaEdge) -> CryptosymcamelliaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_edge_fill(s : CryptosymcamelliaEdge, v : Double) -> CryptosymcamelliaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_edge_min(s : CryptosymcamelliaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_edge_max(s : CryptosymcamelliaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_edge_to_string(s : CryptosymcamelliaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_path_make(size : Int) -> CryptosymcamelliaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_path_len(s : CryptosymcamelliaPath) -> Int { s.size }

pub fn crypto_sym_camellia_path_get(s : CryptosymcamelliaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_path_set(s : CryptosymcamelliaPath, i : Int, v : Double) -> CryptosymcamelliaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_path_sum(s : CryptosymcamelliaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_path_mean(s : CryptosymcamelliaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_path_scale(s : CryptosymcamelliaPath, f : Double) -> CryptosymcamelliaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_path_add(a : CryptosymcamelliaPath, b : CryptosymcamelliaPath) -> CryptosymcamelliaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_path_copy(s : CryptosymcamelliaPath) -> CryptosymcamelliaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_path_fill(s : CryptosymcamelliaPath, v : Double) -> CryptosymcamelliaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_path_min(s : CryptosymcamelliaPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_path_max(s : CryptosymcamelliaPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_path_to_string(s : CryptosymcamelliaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_cluster_make(size : Int) -> CryptosymcamelliaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_cluster_len(s : CryptosymcamelliaCluster) -> Int { s.size }

pub fn crypto_sym_camellia_cluster_get(s : CryptosymcamelliaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_cluster_set(s : CryptosymcamelliaCluster, i : Int, v : Double) -> CryptosymcamelliaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_cluster_sum(s : CryptosymcamelliaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_cluster_mean(s : CryptosymcamelliaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_cluster_scale(s : CryptosymcamelliaCluster, f : Double) -> CryptosymcamelliaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_cluster_add(a : CryptosymcamelliaCluster, b : CryptosymcamelliaCluster) -> CryptosymcamelliaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_cluster_copy(s : CryptosymcamelliaCluster) -> CryptosymcamelliaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_cluster_fill(s : CryptosymcamelliaCluster, v : Double) -> CryptosymcamelliaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_cluster_min(s : CryptosymcamelliaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_cluster_max(s : CryptosymcamelliaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_cluster_to_string(s : CryptosymcamelliaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_model_make(size : Int) -> CryptosymcamelliaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_model_len(s : CryptosymcamelliaModel) -> Int { s.size }

pub fn crypto_sym_camellia_model_get(s : CryptosymcamelliaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_model_set(s : CryptosymcamelliaModel, i : Int, v : Double) -> CryptosymcamelliaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_model_sum(s : CryptosymcamelliaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_model_mean(s : CryptosymcamelliaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_model_scale(s : CryptosymcamelliaModel, f : Double) -> CryptosymcamelliaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_model_add(a : CryptosymcamelliaModel, b : CryptosymcamelliaModel) -> CryptosymcamelliaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_model_copy(s : CryptosymcamelliaModel) -> CryptosymcamelliaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_model_fill(s : CryptosymcamelliaModel, v : Double) -> CryptosymcamelliaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_model_min(s : CryptosymcamelliaModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_model_max(s : CryptosymcamelliaModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_model_to_string(s : CryptosymcamelliaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_layer_make(size : Int) -> CryptosymcamelliaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_layer_len(s : CryptosymcamelliaLayer) -> Int { s.size }

pub fn crypto_sym_camellia_layer_get(s : CryptosymcamelliaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_layer_set(s : CryptosymcamelliaLayer, i : Int, v : Double) -> CryptosymcamelliaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_layer_sum(s : CryptosymcamelliaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_layer_mean(s : CryptosymcamelliaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_layer_scale(s : CryptosymcamelliaLayer, f : Double) -> CryptosymcamelliaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_layer_add(a : CryptosymcamelliaLayer, b : CryptosymcamelliaLayer) -> CryptosymcamelliaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_layer_copy(s : CryptosymcamelliaLayer) -> CryptosymcamelliaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_layer_fill(s : CryptosymcamelliaLayer, v : Double) -> CryptosymcamelliaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_layer_min(s : CryptosymcamelliaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_layer_max(s : CryptosymcamelliaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_layer_to_string(s : CryptosymcamelliaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_buffer_make(size : Int) -> CryptosymcamelliaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_buffer_len(s : CryptosymcamelliaBuffer) -> Int { s.size }

pub fn crypto_sym_camellia_buffer_get(s : CryptosymcamelliaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_buffer_set(s : CryptosymcamelliaBuffer, i : Int, v : Double) -> CryptosymcamelliaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_buffer_sum(s : CryptosymcamelliaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_buffer_mean(s : CryptosymcamelliaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_buffer_scale(s : CryptosymcamelliaBuffer, f : Double) -> CryptosymcamelliaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_buffer_add(a : CryptosymcamelliaBuffer, b : CryptosymcamelliaBuffer) -> CryptosymcamelliaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_buffer_copy(s : CryptosymcamelliaBuffer) -> CryptosymcamelliaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_buffer_fill(s : CryptosymcamelliaBuffer, v : Double) -> CryptosymcamelliaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_buffer_min(s : CryptosymcamelliaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_buffer_max(s : CryptosymcamelliaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_buffer_to_string(s : CryptosymcamelliaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_cursor_make(size : Int) -> CryptosymcamelliaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_cursor_len(s : CryptosymcamelliaCursor) -> Int { s.size }

pub fn crypto_sym_camellia_cursor_get(s : CryptosymcamelliaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_cursor_set(s : CryptosymcamelliaCursor, i : Int, v : Double) -> CryptosymcamelliaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_cursor_sum(s : CryptosymcamelliaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_cursor_mean(s : CryptosymcamelliaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_cursor_scale(s : CryptosymcamelliaCursor, f : Double) -> CryptosymcamelliaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_cursor_add(a : CryptosymcamelliaCursor, b : CryptosymcamelliaCursor) -> CryptosymcamelliaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_cursor_copy(s : CryptosymcamelliaCursor) -> CryptosymcamelliaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_cursor_fill(s : CryptosymcamelliaCursor, v : Double) -> CryptosymcamelliaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_cursor_min(s : CryptosymcamelliaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_cursor_max(s : CryptosymcamelliaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_cursor_to_string(s : CryptosymcamelliaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_view_make(size : Int) -> CryptosymcamelliaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_view_len(s : CryptosymcamelliaView) -> Int { s.size }

pub fn crypto_sym_camellia_view_get(s : CryptosymcamelliaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_view_set(s : CryptosymcamelliaView, i : Int, v : Double) -> CryptosymcamelliaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_view_sum(s : CryptosymcamelliaView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_view_mean(s : CryptosymcamelliaView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_view_scale(s : CryptosymcamelliaView, f : Double) -> CryptosymcamelliaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_view_add(a : CryptosymcamelliaView, b : CryptosymcamelliaView) -> CryptosymcamelliaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_view_copy(s : CryptosymcamelliaView) -> CryptosymcamelliaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_view_fill(s : CryptosymcamelliaView, v : Double) -> CryptosymcamelliaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_view_min(s : CryptosymcamelliaView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_view_max(s : CryptosymcamelliaView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_view_to_string(s : CryptosymcamelliaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_range_make(size : Int) -> CryptosymcamelliaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_range_len(s : CryptosymcamelliaRange) -> Int { s.size }

pub fn crypto_sym_camellia_range_get(s : CryptosymcamelliaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_range_set(s : CryptosymcamelliaRange, i : Int, v : Double) -> CryptosymcamelliaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_range_sum(s : CryptosymcamelliaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_range_mean(s : CryptosymcamelliaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_range_scale(s : CryptosymcamelliaRange, f : Double) -> CryptosymcamelliaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_range_add(a : CryptosymcamelliaRange, b : CryptosymcamelliaRange) -> CryptosymcamelliaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_range_copy(s : CryptosymcamelliaRange) -> CryptosymcamelliaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_range_fill(s : CryptosymcamelliaRange, v : Double) -> CryptosymcamelliaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_range_min(s : CryptosymcamelliaRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_range_max(s : CryptosymcamelliaRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_range_to_string(s : CryptosymcamelliaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_slice_make(size : Int) -> CryptosymcamelliaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_slice_len(s : CryptosymcamelliaSlice) -> Int { s.size }

pub fn crypto_sym_camellia_slice_get(s : CryptosymcamelliaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_slice_set(s : CryptosymcamelliaSlice, i : Int, v : Double) -> CryptosymcamelliaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_slice_sum(s : CryptosymcamelliaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_camellia_slice_mean(s : CryptosymcamelliaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_camellia_slice_scale(s : CryptosymcamelliaSlice, f : Double) -> CryptosymcamelliaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_slice_add(a : CryptosymcamelliaSlice, b : CryptosymcamelliaSlice) -> CryptosymcamelliaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_camellia_slice_copy(s : CryptosymcamelliaSlice) -> CryptosymcamelliaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_slice_fill(s : CryptosymcamelliaSlice, v : Double) -> CryptosymcamelliaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_camellia_slice_min(s : CryptosymcamelliaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_camellia_slice_max(s : CryptosymcamelliaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_camellia_slice_to_string(s : CryptosymcamelliaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

