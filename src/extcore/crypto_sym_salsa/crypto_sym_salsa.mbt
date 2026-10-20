///===
/// extcore/crypto_sym_salsa

pub(all) struct CryptosymsalsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_salsa_make_point(x : Double, y : Double) -> CryptosymsalsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_salsa_make_point3(x : Double, y : Double, z : Double) -> CryptosymsalsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymsalsaPoint::x(self : CryptosymsalsaPoint) -> Double { self.x }

pub fn CryptosymsalsaPoint::y(self : CryptosymsalsaPoint) -> Double { self.y }

pub fn CryptosymsalsaPoint::z(self : CryptosymsalsaPoint) -> Double { self.z }

pub fn CryptosymsalsaPoint::label(self : CryptosymsalsaPoint) -> Int { self.label }

pub fn CryptosymsalsaPoint::dist(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymsalsaPoint::add(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymsalsaPoint::sub(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymsalsaPoint::scale(self : CryptosymsalsaPoint, s : Double) -> CryptosymsalsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymsalsaPoint::dot(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymsalsaPoint::cross(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymsalsaPoint::norm(self : CryptosymsalsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymsalsaPoint::normalize(self : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymsalsaPoint::negate(self : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymsalsaPoint::mid(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymsalsaPoint::lerp(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint, t : Double) -> CryptosymsalsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymsalsaPoint::to_string(self : CryptosymsalsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymsalsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_salsa_make_series(vals : Array[Double], name : String) -> CryptosymsalsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymsalsaSeries::len(self : CryptosymsalsaSeries) -> Int { self.vals.length() }

pub fn CryptosymsalsaSeries::sum(self : CryptosymsalsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymsalsaSeries::mean(self : CryptosymsalsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymsalsaSeries::min(self : CryptosymsalsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymsalsaSeries::max(self : CryptosymsalsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymsalsaSeries::range(self : CryptosymsalsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymsalsaSeries::variance(self : CryptosymsalsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymsalsaSeries::std(self : CryptosymsalsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymsalsaSeries::median(self : CryptosymsalsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymsalsaSeries::scale(self : CryptosymsalsaSeries, f : Double) -> CryptosymsalsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymsalsaSeries::add(self : CryptosymsalsaSeries, other : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymsalsaSeries::sub(self : CryptosymsalsaSeries, other : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymsalsaSeries::normalize(self : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymsalsaSeries::cumsum(self : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymsalsaSeries::to_string(self : CryptosymsalsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymsalsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_salsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymsalsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_salsa_matrix_identity(n : Int) -> CryptosymsalsaMatrix {
  let m = crypto_sym_salsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymsalsaMatrix::get(self : CryptosymsalsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymsalsaMatrix::transpose(self : CryptosymsalsaMatrix) -> CryptosymsalsaMatrix {
  let result = crypto_sym_salsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymsalsaMatrix::add(self : CryptosymsalsaMatrix, other : CryptosymsalsaMatrix) -> CryptosymsalsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_salsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymsalsaMatrix::scale(self : CryptosymsalsaMatrix, s : Double) -> CryptosymsalsaMatrix {
  let result = crypto_sym_salsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymsalsaMatrix::multiply(self : CryptosymsalsaMatrix, other : CryptosymsalsaMatrix) -> CryptosymsalsaMatrix {
  if self.cols != other.rows { return crypto_sym_salsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_salsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymsalsaMatrix::trace(self : CryptosymsalsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymsalsaMatrix::det(self : CryptosymsalsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymsalsaMatrix::norm(self : CryptosymsalsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymsalsaMatrix::to_string(self : CryptosymsalsaMatrix) -> String {
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

pub(all) struct CryptosymsalsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_salsa_make_vector(comps : Array[Double]) -> CryptosymsalsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_salsa_vector_zero(dim : Int) -> CryptosymsalsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymsalsaVector::add(self : CryptosymsalsaVector, other : CryptosymsalsaVector) -> CryptosymsalsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymsalsaVector::sub(self : CryptosymsalsaVector, other : CryptosymsalsaVector) -> CryptosymsalsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymsalsaVector::scale(self : CryptosymsalsaVector, s : Double) -> CryptosymsalsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymsalsaVector::dot(self : CryptosymsalsaVector, other : CryptosymsalsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymsalsaVector::norm(self : CryptosymsalsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymsalsaVector::normalize(self : CryptosymsalsaVector) -> CryptosymsalsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymsalsaVector::dist(self : CryptosymsalsaVector, other : CryptosymsalsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymsalsaVector::to_string(self : CryptosymsalsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_salsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_salsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_salsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_salsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_salsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_salsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_salsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_salsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_salsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_salsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_salsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_salsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_salsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_salsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_salsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_salsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_salsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_salsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_salsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_salsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_salsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_salsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_salsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_salsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_salsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_salsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_salsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_salsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_salsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymsalsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_frame_make(size : Int) -> CryptosymsalsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_frame_len(s : CryptosymsalsaFrame) -> Int { s.size }

pub fn crypto_sym_salsa_frame_get(s : CryptosymsalsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_frame_set(s : CryptosymsalsaFrame, i : Int, v : Double) -> CryptosymsalsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_frame_sum(s : CryptosymsalsaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_frame_mean(s : CryptosymsalsaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_frame_scale(s : CryptosymsalsaFrame, f : Double) -> CryptosymsalsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_frame_add(a : CryptosymsalsaFrame, b : CryptosymsalsaFrame) -> CryptosymsalsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_frame_copy(s : CryptosymsalsaFrame) -> CryptosymsalsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_frame_fill(s : CryptosymsalsaFrame, v : Double) -> CryptosymsalsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_frame_min(s : CryptosymsalsaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_frame_max(s : CryptosymsalsaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_frame_to_string(s : CryptosymsalsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_table_make(size : Int) -> CryptosymsalsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_table_len(s : CryptosymsalsaTable) -> Int { s.size }

pub fn crypto_sym_salsa_table_get(s : CryptosymsalsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_table_set(s : CryptosymsalsaTable, i : Int, v : Double) -> CryptosymsalsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_table_sum(s : CryptosymsalsaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_table_mean(s : CryptosymsalsaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_table_scale(s : CryptosymsalsaTable, f : Double) -> CryptosymsalsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_table_add(a : CryptosymsalsaTable, b : CryptosymsalsaTable) -> CryptosymsalsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_table_copy(s : CryptosymsalsaTable) -> CryptosymsalsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_table_fill(s : CryptosymsalsaTable, v : Double) -> CryptosymsalsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_table_min(s : CryptosymsalsaTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_table_max(s : CryptosymsalsaTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_table_to_string(s : CryptosymsalsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_graphn_make(size : Int) -> CryptosymsalsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_graphn_len(s : CryptosymsalsaGraphN) -> Int { s.size }

pub fn crypto_sym_salsa_graphn_get(s : CryptosymsalsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_graphn_set(s : CryptosymsalsaGraphN, i : Int, v : Double) -> CryptosymsalsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_graphn_sum(s : CryptosymsalsaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_graphn_mean(s : CryptosymsalsaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_graphn_scale(s : CryptosymsalsaGraphN, f : Double) -> CryptosymsalsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_graphn_add(a : CryptosymsalsaGraphN, b : CryptosymsalsaGraphN) -> CryptosymsalsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_graphn_copy(s : CryptosymsalsaGraphN) -> CryptosymsalsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_graphn_fill(s : CryptosymsalsaGraphN, v : Double) -> CryptosymsalsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_graphn_min(s : CryptosymsalsaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_graphn_max(s : CryptosymsalsaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_graphn_to_string(s : CryptosymsalsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_node_make(size : Int) -> CryptosymsalsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_node_len(s : CryptosymsalsaNode) -> Int { s.size }

pub fn crypto_sym_salsa_node_get(s : CryptosymsalsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_node_set(s : CryptosymsalsaNode, i : Int, v : Double) -> CryptosymsalsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_node_sum(s : CryptosymsalsaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_node_mean(s : CryptosymsalsaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_node_scale(s : CryptosymsalsaNode, f : Double) -> CryptosymsalsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_node_add(a : CryptosymsalsaNode, b : CryptosymsalsaNode) -> CryptosymsalsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_node_copy(s : CryptosymsalsaNode) -> CryptosymsalsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_node_fill(s : CryptosymsalsaNode, v : Double) -> CryptosymsalsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_node_min(s : CryptosymsalsaNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_node_max(s : CryptosymsalsaNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_node_to_string(s : CryptosymsalsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_edge_make(size : Int) -> CryptosymsalsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_edge_len(s : CryptosymsalsaEdge) -> Int { s.size }

pub fn crypto_sym_salsa_edge_get(s : CryptosymsalsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_edge_set(s : CryptosymsalsaEdge, i : Int, v : Double) -> CryptosymsalsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_edge_sum(s : CryptosymsalsaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_edge_mean(s : CryptosymsalsaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_edge_scale(s : CryptosymsalsaEdge, f : Double) -> CryptosymsalsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_edge_add(a : CryptosymsalsaEdge, b : CryptosymsalsaEdge) -> CryptosymsalsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_edge_copy(s : CryptosymsalsaEdge) -> CryptosymsalsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_edge_fill(s : CryptosymsalsaEdge, v : Double) -> CryptosymsalsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_edge_min(s : CryptosymsalsaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_edge_max(s : CryptosymsalsaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_edge_to_string(s : CryptosymsalsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_path_make(size : Int) -> CryptosymsalsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_path_len(s : CryptosymsalsaPath) -> Int { s.size }

pub fn crypto_sym_salsa_path_get(s : CryptosymsalsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_path_set(s : CryptosymsalsaPath, i : Int, v : Double) -> CryptosymsalsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_path_sum(s : CryptosymsalsaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_path_mean(s : CryptosymsalsaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_path_scale(s : CryptosymsalsaPath, f : Double) -> CryptosymsalsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_path_add(a : CryptosymsalsaPath, b : CryptosymsalsaPath) -> CryptosymsalsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_path_copy(s : CryptosymsalsaPath) -> CryptosymsalsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_path_fill(s : CryptosymsalsaPath, v : Double) -> CryptosymsalsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_path_min(s : CryptosymsalsaPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_path_max(s : CryptosymsalsaPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_path_to_string(s : CryptosymsalsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_cluster_make(size : Int) -> CryptosymsalsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_cluster_len(s : CryptosymsalsaCluster) -> Int { s.size }

pub fn crypto_sym_salsa_cluster_get(s : CryptosymsalsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_cluster_set(s : CryptosymsalsaCluster, i : Int, v : Double) -> CryptosymsalsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_cluster_sum(s : CryptosymsalsaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_cluster_mean(s : CryptosymsalsaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_cluster_scale(s : CryptosymsalsaCluster, f : Double) -> CryptosymsalsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_cluster_add(a : CryptosymsalsaCluster, b : CryptosymsalsaCluster) -> CryptosymsalsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_cluster_copy(s : CryptosymsalsaCluster) -> CryptosymsalsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_cluster_fill(s : CryptosymsalsaCluster, v : Double) -> CryptosymsalsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_cluster_min(s : CryptosymsalsaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_cluster_max(s : CryptosymsalsaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_cluster_to_string(s : CryptosymsalsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_model_make(size : Int) -> CryptosymsalsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_model_len(s : CryptosymsalsaModel) -> Int { s.size }

pub fn crypto_sym_salsa_model_get(s : CryptosymsalsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_model_set(s : CryptosymsalsaModel, i : Int, v : Double) -> CryptosymsalsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_model_sum(s : CryptosymsalsaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_model_mean(s : CryptosymsalsaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_model_scale(s : CryptosymsalsaModel, f : Double) -> CryptosymsalsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_model_add(a : CryptosymsalsaModel, b : CryptosymsalsaModel) -> CryptosymsalsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_model_copy(s : CryptosymsalsaModel) -> CryptosymsalsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_model_fill(s : CryptosymsalsaModel, v : Double) -> CryptosymsalsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_model_min(s : CryptosymsalsaModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_model_max(s : CryptosymsalsaModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_model_to_string(s : CryptosymsalsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_layer_make(size : Int) -> CryptosymsalsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_layer_len(s : CryptosymsalsaLayer) -> Int { s.size }

pub fn crypto_sym_salsa_layer_get(s : CryptosymsalsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_layer_set(s : CryptosymsalsaLayer, i : Int, v : Double) -> CryptosymsalsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_layer_sum(s : CryptosymsalsaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_layer_mean(s : CryptosymsalsaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_layer_scale(s : CryptosymsalsaLayer, f : Double) -> CryptosymsalsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_layer_add(a : CryptosymsalsaLayer, b : CryptosymsalsaLayer) -> CryptosymsalsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_layer_copy(s : CryptosymsalsaLayer) -> CryptosymsalsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_layer_fill(s : CryptosymsalsaLayer, v : Double) -> CryptosymsalsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_layer_min(s : CryptosymsalsaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_layer_max(s : CryptosymsalsaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_layer_to_string(s : CryptosymsalsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_buffer_make(size : Int) -> CryptosymsalsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_buffer_len(s : CryptosymsalsaBuffer) -> Int { s.size }

pub fn crypto_sym_salsa_buffer_get(s : CryptosymsalsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_buffer_set(s : CryptosymsalsaBuffer, i : Int, v : Double) -> CryptosymsalsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_buffer_sum(s : CryptosymsalsaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_buffer_mean(s : CryptosymsalsaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_buffer_scale(s : CryptosymsalsaBuffer, f : Double) -> CryptosymsalsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_buffer_add(a : CryptosymsalsaBuffer, b : CryptosymsalsaBuffer) -> CryptosymsalsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_buffer_copy(s : CryptosymsalsaBuffer) -> CryptosymsalsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_buffer_fill(s : CryptosymsalsaBuffer, v : Double) -> CryptosymsalsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_buffer_min(s : CryptosymsalsaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_buffer_max(s : CryptosymsalsaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_buffer_to_string(s : CryptosymsalsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_cursor_make(size : Int) -> CryptosymsalsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_cursor_len(s : CryptosymsalsaCursor) -> Int { s.size }

pub fn crypto_sym_salsa_cursor_get(s : CryptosymsalsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_cursor_set(s : CryptosymsalsaCursor, i : Int, v : Double) -> CryptosymsalsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_cursor_sum(s : CryptosymsalsaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_cursor_mean(s : CryptosymsalsaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_cursor_scale(s : CryptosymsalsaCursor, f : Double) -> CryptosymsalsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_cursor_add(a : CryptosymsalsaCursor, b : CryptosymsalsaCursor) -> CryptosymsalsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_cursor_copy(s : CryptosymsalsaCursor) -> CryptosymsalsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_cursor_fill(s : CryptosymsalsaCursor, v : Double) -> CryptosymsalsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_cursor_min(s : CryptosymsalsaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_cursor_max(s : CryptosymsalsaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_cursor_to_string(s : CryptosymsalsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_view_make(size : Int) -> CryptosymsalsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_view_len(s : CryptosymsalsaView) -> Int { s.size }

pub fn crypto_sym_salsa_view_get(s : CryptosymsalsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_view_set(s : CryptosymsalsaView, i : Int, v : Double) -> CryptosymsalsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_view_sum(s : CryptosymsalsaView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_view_mean(s : CryptosymsalsaView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_view_scale(s : CryptosymsalsaView, f : Double) -> CryptosymsalsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_view_add(a : CryptosymsalsaView, b : CryptosymsalsaView) -> CryptosymsalsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_view_copy(s : CryptosymsalsaView) -> CryptosymsalsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_view_fill(s : CryptosymsalsaView, v : Double) -> CryptosymsalsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_view_min(s : CryptosymsalsaView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_view_max(s : CryptosymsalsaView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_view_to_string(s : CryptosymsalsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_range_make(size : Int) -> CryptosymsalsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_range_len(s : CryptosymsalsaRange) -> Int { s.size }

pub fn crypto_sym_salsa_range_get(s : CryptosymsalsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_range_set(s : CryptosymsalsaRange, i : Int, v : Double) -> CryptosymsalsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_range_sum(s : CryptosymsalsaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_range_mean(s : CryptosymsalsaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_range_scale(s : CryptosymsalsaRange, f : Double) -> CryptosymsalsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_range_add(a : CryptosymsalsaRange, b : CryptosymsalsaRange) -> CryptosymsalsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_range_copy(s : CryptosymsalsaRange) -> CryptosymsalsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_range_fill(s : CryptosymsalsaRange, v : Double) -> CryptosymsalsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_range_min(s : CryptosymsalsaRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_range_max(s : CryptosymsalsaRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_range_to_string(s : CryptosymsalsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_slice_make(size : Int) -> CryptosymsalsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_slice_len(s : CryptosymsalsaSlice) -> Int { s.size }

pub fn crypto_sym_salsa_slice_get(s : CryptosymsalsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_slice_set(s : CryptosymsalsaSlice, i : Int, v : Double) -> CryptosymsalsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_slice_sum(s : CryptosymsalsaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_salsa_slice_mean(s : CryptosymsalsaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_salsa_slice_scale(s : CryptosymsalsaSlice, f : Double) -> CryptosymsalsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_slice_add(a : CryptosymsalsaSlice, b : CryptosymsalsaSlice) -> CryptosymsalsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_salsa_slice_copy(s : CryptosymsalsaSlice) -> CryptosymsalsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_slice_fill(s : CryptosymsalsaSlice, v : Double) -> CryptosymsalsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_salsa_slice_min(s : CryptosymsalsaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_salsa_slice_max(s : CryptosymsalsaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_salsa_slice_to_string(s : CryptosymsalsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

