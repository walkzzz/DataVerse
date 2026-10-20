///===
/// extcore/crypto_sign_schnorr

pub(all) struct CryptosignschnorrPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_schnorr_make_point(x : Double, y : Double) -> CryptosignschnorrPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_schnorr_make_point3(x : Double, y : Double, z : Double) -> CryptosignschnorrPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosignschnorrPoint::x(self : CryptosignschnorrPoint) -> Double { self.x }

pub fn CryptosignschnorrPoint::y(self : CryptosignschnorrPoint) -> Double { self.y }

pub fn CryptosignschnorrPoint::z(self : CryptosignschnorrPoint) -> Double { self.z }

pub fn CryptosignschnorrPoint::label(self : CryptosignschnorrPoint) -> Int { self.label }

pub fn CryptosignschnorrPoint::dist(self : CryptosignschnorrPoint, other : CryptosignschnorrPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosignschnorrPoint::add(self : CryptosignschnorrPoint, other : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosignschnorrPoint::sub(self : CryptosignschnorrPoint, other : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosignschnorrPoint::scale(self : CryptosignschnorrPoint, s : Double) -> CryptosignschnorrPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosignschnorrPoint::dot(self : CryptosignschnorrPoint, other : CryptosignschnorrPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosignschnorrPoint::cross(self : CryptosignschnorrPoint, other : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosignschnorrPoint::norm(self : CryptosignschnorrPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosignschnorrPoint::normalize(self : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignschnorrPoint::negate(self : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosignschnorrPoint::mid(self : CryptosignschnorrPoint, other : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosignschnorrPoint::lerp(self : CryptosignschnorrPoint, other : CryptosignschnorrPoint, t : Double) -> CryptosignschnorrPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosignschnorrPoint::to_string(self : CryptosignschnorrPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosignschnorrSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_schnorr_make_series(vals : Array[Double], name : String) -> CryptosignschnorrSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosignschnorrSeries::len(self : CryptosignschnorrSeries) -> Int { self.vals.length() }

pub fn CryptosignschnorrSeries::sum(self : CryptosignschnorrSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosignschnorrSeries::mean(self : CryptosignschnorrSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosignschnorrSeries::min(self : CryptosignschnorrSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosignschnorrSeries::max(self : CryptosignschnorrSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosignschnorrSeries::range(self : CryptosignschnorrSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosignschnorrSeries::variance(self : CryptosignschnorrSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosignschnorrSeries::std(self : CryptosignschnorrSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosignschnorrSeries::median(self : CryptosignschnorrSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosignschnorrSeries::scale(self : CryptosignschnorrSeries, f : Double) -> CryptosignschnorrSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosignschnorrSeries::add(self : CryptosignschnorrSeries, other : CryptosignschnorrSeries) -> CryptosignschnorrSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosignschnorrSeries::sub(self : CryptosignschnorrSeries, other : CryptosignschnorrSeries) -> CryptosignschnorrSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosignschnorrSeries::normalize(self : CryptosignschnorrSeries) -> CryptosignschnorrSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosignschnorrSeries::cumsum(self : CryptosignschnorrSeries) -> CryptosignschnorrSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosignschnorrSeries::to_string(self : CryptosignschnorrSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignschnorrMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_schnorr_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignschnorrMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_schnorr_matrix_identity(n : Int) -> CryptosignschnorrMatrix {
  let m = crypto_sign_schnorr_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosignschnorrMatrix::get(self : CryptosignschnorrMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosignschnorrMatrix::transpose(self : CryptosignschnorrMatrix) -> CryptosignschnorrMatrix {
  let result = crypto_sign_schnorr_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosignschnorrMatrix::add(self : CryptosignschnorrMatrix, other : CryptosignschnorrMatrix) -> CryptosignschnorrMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_schnorr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosignschnorrMatrix::scale(self : CryptosignschnorrMatrix, s : Double) -> CryptosignschnorrMatrix {
  let result = crypto_sign_schnorr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosignschnorrMatrix::multiply(self : CryptosignschnorrMatrix, other : CryptosignschnorrMatrix) -> CryptosignschnorrMatrix {
  if self.cols != other.rows { return crypto_sign_schnorr_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_schnorr_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosignschnorrMatrix::trace(self : CryptosignschnorrMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosignschnorrMatrix::det(self : CryptosignschnorrMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosignschnorrMatrix::norm(self : CryptosignschnorrMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosignschnorrMatrix::to_string(self : CryptosignschnorrMatrix) -> String {
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

pub(all) struct CryptosignschnorrVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_schnorr_make_vector(comps : Array[Double]) -> CryptosignschnorrVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_schnorr_vector_zero(dim : Int) -> CryptosignschnorrVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosignschnorrVector::add(self : CryptosignschnorrVector, other : CryptosignschnorrVector) -> CryptosignschnorrVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignschnorrVector::sub(self : CryptosignschnorrVector, other : CryptosignschnorrVector) -> CryptosignschnorrVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignschnorrVector::scale(self : CryptosignschnorrVector, s : Double) -> CryptosignschnorrVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosignschnorrVector::dot(self : CryptosignschnorrVector, other : CryptosignschnorrVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosignschnorrVector::norm(self : CryptosignschnorrVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosignschnorrVector::normalize(self : CryptosignschnorrVector) -> CryptosignschnorrVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignschnorrVector::dist(self : CryptosignschnorrVector, other : CryptosignschnorrVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosignschnorrVector::to_string(self : CryptosignschnorrVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_schnorr_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_schnorr_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_schnorr_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_schnorr_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_schnorr_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_schnorr_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_schnorr_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_schnorr_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_schnorr_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_schnorr_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_schnorr_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_schnorr_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_schnorr_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_schnorr_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_schnorr_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_schnorr_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_schnorr_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_schnorr_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_schnorr_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_schnorr_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_schnorr_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_schnorr_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_schnorr_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_schnorr_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_schnorr_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_schnorr_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_schnorr_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_schnorr_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_schnorr_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignschnorrFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_frame_make(size : Int) -> CryptosignschnorrFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_frame_len(s : CryptosignschnorrFrame) -> Int { s.size }

pub fn crypto_sign_schnorr_frame_get(s : CryptosignschnorrFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_frame_set(s : CryptosignschnorrFrame, i : Int, v : Double) -> CryptosignschnorrFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_frame_sum(s : CryptosignschnorrFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_frame_mean(s : CryptosignschnorrFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_frame_scale(s : CryptosignschnorrFrame, f : Double) -> CryptosignschnorrFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_frame_add(a : CryptosignschnorrFrame, b : CryptosignschnorrFrame) -> CryptosignschnorrFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_frame_copy(s : CryptosignschnorrFrame) -> CryptosignschnorrFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_frame_fill(s : CryptosignschnorrFrame, v : Double) -> CryptosignschnorrFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_frame_min(s : CryptosignschnorrFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_frame_max(s : CryptosignschnorrFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_frame_to_string(s : CryptosignschnorrFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_table_make(size : Int) -> CryptosignschnorrTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_table_len(s : CryptosignschnorrTable) -> Int { s.size }

pub fn crypto_sign_schnorr_table_get(s : CryptosignschnorrTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_table_set(s : CryptosignschnorrTable, i : Int, v : Double) -> CryptosignschnorrTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_table_sum(s : CryptosignschnorrTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_table_mean(s : CryptosignschnorrTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_table_scale(s : CryptosignschnorrTable, f : Double) -> CryptosignschnorrTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_table_add(a : CryptosignschnorrTable, b : CryptosignschnorrTable) -> CryptosignschnorrTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_table_copy(s : CryptosignschnorrTable) -> CryptosignschnorrTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_table_fill(s : CryptosignschnorrTable, v : Double) -> CryptosignschnorrTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_table_min(s : CryptosignschnorrTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_table_max(s : CryptosignschnorrTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_table_to_string(s : CryptosignschnorrTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_graphn_make(size : Int) -> CryptosignschnorrGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_graphn_len(s : CryptosignschnorrGraphN) -> Int { s.size }

pub fn crypto_sign_schnorr_graphn_get(s : CryptosignschnorrGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_graphn_set(s : CryptosignschnorrGraphN, i : Int, v : Double) -> CryptosignschnorrGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_graphn_sum(s : CryptosignschnorrGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_graphn_mean(s : CryptosignschnorrGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_graphn_scale(s : CryptosignschnorrGraphN, f : Double) -> CryptosignschnorrGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_graphn_add(a : CryptosignschnorrGraphN, b : CryptosignschnorrGraphN) -> CryptosignschnorrGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_graphn_copy(s : CryptosignschnorrGraphN) -> CryptosignschnorrGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_graphn_fill(s : CryptosignschnorrGraphN, v : Double) -> CryptosignschnorrGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_graphn_min(s : CryptosignschnorrGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_graphn_max(s : CryptosignschnorrGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_graphn_to_string(s : CryptosignschnorrGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_node_make(size : Int) -> CryptosignschnorrNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_node_len(s : CryptosignschnorrNode) -> Int { s.size }

pub fn crypto_sign_schnorr_node_get(s : CryptosignschnorrNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_node_set(s : CryptosignschnorrNode, i : Int, v : Double) -> CryptosignschnorrNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_node_sum(s : CryptosignschnorrNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_node_mean(s : CryptosignschnorrNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_node_scale(s : CryptosignschnorrNode, f : Double) -> CryptosignschnorrNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_node_add(a : CryptosignschnorrNode, b : CryptosignschnorrNode) -> CryptosignschnorrNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_node_copy(s : CryptosignschnorrNode) -> CryptosignschnorrNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_node_fill(s : CryptosignschnorrNode, v : Double) -> CryptosignschnorrNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_node_min(s : CryptosignschnorrNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_node_max(s : CryptosignschnorrNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_node_to_string(s : CryptosignschnorrNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_edge_make(size : Int) -> CryptosignschnorrEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_edge_len(s : CryptosignschnorrEdge) -> Int { s.size }

pub fn crypto_sign_schnorr_edge_get(s : CryptosignschnorrEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_edge_set(s : CryptosignschnorrEdge, i : Int, v : Double) -> CryptosignschnorrEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_edge_sum(s : CryptosignschnorrEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_edge_mean(s : CryptosignschnorrEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_edge_scale(s : CryptosignschnorrEdge, f : Double) -> CryptosignschnorrEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_edge_add(a : CryptosignschnorrEdge, b : CryptosignschnorrEdge) -> CryptosignschnorrEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_edge_copy(s : CryptosignschnorrEdge) -> CryptosignschnorrEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_edge_fill(s : CryptosignschnorrEdge, v : Double) -> CryptosignschnorrEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_edge_min(s : CryptosignschnorrEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_edge_max(s : CryptosignschnorrEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_edge_to_string(s : CryptosignschnorrEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_path_make(size : Int) -> CryptosignschnorrPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_path_len(s : CryptosignschnorrPath) -> Int { s.size }

pub fn crypto_sign_schnorr_path_get(s : CryptosignschnorrPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_path_set(s : CryptosignschnorrPath, i : Int, v : Double) -> CryptosignschnorrPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_path_sum(s : CryptosignschnorrPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_path_mean(s : CryptosignschnorrPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_path_scale(s : CryptosignschnorrPath, f : Double) -> CryptosignschnorrPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_path_add(a : CryptosignschnorrPath, b : CryptosignschnorrPath) -> CryptosignschnorrPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_path_copy(s : CryptosignschnorrPath) -> CryptosignschnorrPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_path_fill(s : CryptosignschnorrPath, v : Double) -> CryptosignschnorrPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_path_min(s : CryptosignschnorrPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_path_max(s : CryptosignschnorrPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_path_to_string(s : CryptosignschnorrPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_cluster_make(size : Int) -> CryptosignschnorrCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_cluster_len(s : CryptosignschnorrCluster) -> Int { s.size }

pub fn crypto_sign_schnorr_cluster_get(s : CryptosignschnorrCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_cluster_set(s : CryptosignschnorrCluster, i : Int, v : Double) -> CryptosignschnorrCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cluster_sum(s : CryptosignschnorrCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_cluster_mean(s : CryptosignschnorrCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_cluster_scale(s : CryptosignschnorrCluster, f : Double) -> CryptosignschnorrCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cluster_add(a : CryptosignschnorrCluster, b : CryptosignschnorrCluster) -> CryptosignschnorrCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_cluster_copy(s : CryptosignschnorrCluster) -> CryptosignschnorrCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cluster_fill(s : CryptosignschnorrCluster, v : Double) -> CryptosignschnorrCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cluster_min(s : CryptosignschnorrCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_cluster_max(s : CryptosignschnorrCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_cluster_to_string(s : CryptosignschnorrCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_model_make(size : Int) -> CryptosignschnorrModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_model_len(s : CryptosignschnorrModel) -> Int { s.size }

pub fn crypto_sign_schnorr_model_get(s : CryptosignschnorrModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_model_set(s : CryptosignschnorrModel, i : Int, v : Double) -> CryptosignschnorrModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_model_sum(s : CryptosignschnorrModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_model_mean(s : CryptosignschnorrModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_model_scale(s : CryptosignschnorrModel, f : Double) -> CryptosignschnorrModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_model_add(a : CryptosignschnorrModel, b : CryptosignschnorrModel) -> CryptosignschnorrModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_model_copy(s : CryptosignschnorrModel) -> CryptosignschnorrModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_model_fill(s : CryptosignschnorrModel, v : Double) -> CryptosignschnorrModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_model_min(s : CryptosignschnorrModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_model_max(s : CryptosignschnorrModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_model_to_string(s : CryptosignschnorrModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_layer_make(size : Int) -> CryptosignschnorrLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_layer_len(s : CryptosignschnorrLayer) -> Int { s.size }

pub fn crypto_sign_schnorr_layer_get(s : CryptosignschnorrLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_layer_set(s : CryptosignschnorrLayer, i : Int, v : Double) -> CryptosignschnorrLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_layer_sum(s : CryptosignschnorrLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_layer_mean(s : CryptosignschnorrLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_layer_scale(s : CryptosignschnorrLayer, f : Double) -> CryptosignschnorrLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_layer_add(a : CryptosignschnorrLayer, b : CryptosignschnorrLayer) -> CryptosignschnorrLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_layer_copy(s : CryptosignschnorrLayer) -> CryptosignschnorrLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_layer_fill(s : CryptosignschnorrLayer, v : Double) -> CryptosignschnorrLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_layer_min(s : CryptosignschnorrLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_layer_max(s : CryptosignschnorrLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_layer_to_string(s : CryptosignschnorrLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_buffer_make(size : Int) -> CryptosignschnorrBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_buffer_len(s : CryptosignschnorrBuffer) -> Int { s.size }

pub fn crypto_sign_schnorr_buffer_get(s : CryptosignschnorrBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_buffer_set(s : CryptosignschnorrBuffer, i : Int, v : Double) -> CryptosignschnorrBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_buffer_sum(s : CryptosignschnorrBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_buffer_mean(s : CryptosignschnorrBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_buffer_scale(s : CryptosignschnorrBuffer, f : Double) -> CryptosignschnorrBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_buffer_add(a : CryptosignschnorrBuffer, b : CryptosignschnorrBuffer) -> CryptosignschnorrBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_buffer_copy(s : CryptosignschnorrBuffer) -> CryptosignschnorrBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_buffer_fill(s : CryptosignschnorrBuffer, v : Double) -> CryptosignschnorrBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_buffer_min(s : CryptosignschnorrBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_buffer_max(s : CryptosignschnorrBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_buffer_to_string(s : CryptosignschnorrBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_cursor_make(size : Int) -> CryptosignschnorrCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_cursor_len(s : CryptosignschnorrCursor) -> Int { s.size }

pub fn crypto_sign_schnorr_cursor_get(s : CryptosignschnorrCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_cursor_set(s : CryptosignschnorrCursor, i : Int, v : Double) -> CryptosignschnorrCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cursor_sum(s : CryptosignschnorrCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_cursor_mean(s : CryptosignschnorrCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_cursor_scale(s : CryptosignschnorrCursor, f : Double) -> CryptosignschnorrCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cursor_add(a : CryptosignschnorrCursor, b : CryptosignschnorrCursor) -> CryptosignschnorrCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_cursor_copy(s : CryptosignschnorrCursor) -> CryptosignschnorrCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cursor_fill(s : CryptosignschnorrCursor, v : Double) -> CryptosignschnorrCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cursor_min(s : CryptosignschnorrCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_cursor_max(s : CryptosignschnorrCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_cursor_to_string(s : CryptosignschnorrCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_view_make(size : Int) -> CryptosignschnorrView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_view_len(s : CryptosignschnorrView) -> Int { s.size }

pub fn crypto_sign_schnorr_view_get(s : CryptosignschnorrView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_view_set(s : CryptosignschnorrView, i : Int, v : Double) -> CryptosignschnorrView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_view_sum(s : CryptosignschnorrView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_view_mean(s : CryptosignschnorrView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_view_scale(s : CryptosignschnorrView, f : Double) -> CryptosignschnorrView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_view_add(a : CryptosignschnorrView, b : CryptosignschnorrView) -> CryptosignschnorrView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_view_copy(s : CryptosignschnorrView) -> CryptosignschnorrView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_view_fill(s : CryptosignschnorrView, v : Double) -> CryptosignschnorrView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_view_min(s : CryptosignschnorrView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_view_max(s : CryptosignschnorrView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_view_to_string(s : CryptosignschnorrView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_range_make(size : Int) -> CryptosignschnorrRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_range_len(s : CryptosignschnorrRange) -> Int { s.size }

pub fn crypto_sign_schnorr_range_get(s : CryptosignschnorrRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_range_set(s : CryptosignschnorrRange, i : Int, v : Double) -> CryptosignschnorrRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_range_sum(s : CryptosignschnorrRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_range_mean(s : CryptosignschnorrRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_range_scale(s : CryptosignschnorrRange, f : Double) -> CryptosignschnorrRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_range_add(a : CryptosignschnorrRange, b : CryptosignschnorrRange) -> CryptosignschnorrRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_range_copy(s : CryptosignschnorrRange) -> CryptosignschnorrRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_range_fill(s : CryptosignschnorrRange, v : Double) -> CryptosignschnorrRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_range_min(s : CryptosignschnorrRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_range_max(s : CryptosignschnorrRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_range_to_string(s : CryptosignschnorrRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_slice_make(size : Int) -> CryptosignschnorrSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_slice_len(s : CryptosignschnorrSlice) -> Int { s.size }

pub fn crypto_sign_schnorr_slice_get(s : CryptosignschnorrSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_slice_set(s : CryptosignschnorrSlice, i : Int, v : Double) -> CryptosignschnorrSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_slice_sum(s : CryptosignschnorrSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_slice_mean(s : CryptosignschnorrSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_slice_scale(s : CryptosignschnorrSlice, f : Double) -> CryptosignschnorrSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_slice_add(a : CryptosignschnorrSlice, b : CryptosignschnorrSlice) -> CryptosignschnorrSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_slice_copy(s : CryptosignschnorrSlice) -> CryptosignschnorrSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_slice_fill(s : CryptosignschnorrSlice, v : Double) -> CryptosignschnorrSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_slice_min(s : CryptosignschnorrSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_slice_max(s : CryptosignschnorrSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_slice_to_string(s : CryptosignschnorrSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

