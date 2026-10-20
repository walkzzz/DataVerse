///===
/// extcore/crypto_sign_ecdsa

pub(all) struct CryptosignecdsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_ecdsa_make_point(x : Double, y : Double) -> CryptosignecdsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_ecdsa_make_point3(x : Double, y : Double, z : Double) -> CryptosignecdsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosignecdsaPoint::x(self : CryptosignecdsaPoint) -> Double { self.x }

pub fn CryptosignecdsaPoint::y(self : CryptosignecdsaPoint) -> Double { self.y }

pub fn CryptosignecdsaPoint::z(self : CryptosignecdsaPoint) -> Double { self.z }

pub fn CryptosignecdsaPoint::label(self : CryptosignecdsaPoint) -> Int { self.label }

pub fn CryptosignecdsaPoint::dist(self : CryptosignecdsaPoint, other : CryptosignecdsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosignecdsaPoint::add(self : CryptosignecdsaPoint, other : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosignecdsaPoint::sub(self : CryptosignecdsaPoint, other : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosignecdsaPoint::scale(self : CryptosignecdsaPoint, s : Double) -> CryptosignecdsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosignecdsaPoint::dot(self : CryptosignecdsaPoint, other : CryptosignecdsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosignecdsaPoint::cross(self : CryptosignecdsaPoint, other : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosignecdsaPoint::norm(self : CryptosignecdsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosignecdsaPoint::normalize(self : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignecdsaPoint::negate(self : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosignecdsaPoint::mid(self : CryptosignecdsaPoint, other : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosignecdsaPoint::lerp(self : CryptosignecdsaPoint, other : CryptosignecdsaPoint, t : Double) -> CryptosignecdsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosignecdsaPoint::to_string(self : CryptosignecdsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosignecdsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_ecdsa_make_series(vals : Array[Double], name : String) -> CryptosignecdsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosignecdsaSeries::len(self : CryptosignecdsaSeries) -> Int { self.vals.length() }

pub fn CryptosignecdsaSeries::sum(self : CryptosignecdsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosignecdsaSeries::mean(self : CryptosignecdsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosignecdsaSeries::min(self : CryptosignecdsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosignecdsaSeries::max(self : CryptosignecdsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosignecdsaSeries::range(self : CryptosignecdsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosignecdsaSeries::variance(self : CryptosignecdsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosignecdsaSeries::std(self : CryptosignecdsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosignecdsaSeries::median(self : CryptosignecdsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosignecdsaSeries::scale(self : CryptosignecdsaSeries, f : Double) -> CryptosignecdsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosignecdsaSeries::add(self : CryptosignecdsaSeries, other : CryptosignecdsaSeries) -> CryptosignecdsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosignecdsaSeries::sub(self : CryptosignecdsaSeries, other : CryptosignecdsaSeries) -> CryptosignecdsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosignecdsaSeries::normalize(self : CryptosignecdsaSeries) -> CryptosignecdsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosignecdsaSeries::cumsum(self : CryptosignecdsaSeries) -> CryptosignecdsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosignecdsaSeries::to_string(self : CryptosignecdsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignecdsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_ecdsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignecdsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_ecdsa_matrix_identity(n : Int) -> CryptosignecdsaMatrix {
  let m = crypto_sign_ecdsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosignecdsaMatrix::get(self : CryptosignecdsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosignecdsaMatrix::transpose(self : CryptosignecdsaMatrix) -> CryptosignecdsaMatrix {
  let result = crypto_sign_ecdsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosignecdsaMatrix::add(self : CryptosignecdsaMatrix, other : CryptosignecdsaMatrix) -> CryptosignecdsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_ecdsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosignecdsaMatrix::scale(self : CryptosignecdsaMatrix, s : Double) -> CryptosignecdsaMatrix {
  let result = crypto_sign_ecdsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosignecdsaMatrix::multiply(self : CryptosignecdsaMatrix, other : CryptosignecdsaMatrix) -> CryptosignecdsaMatrix {
  if self.cols != other.rows { return crypto_sign_ecdsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_ecdsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosignecdsaMatrix::trace(self : CryptosignecdsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosignecdsaMatrix::det(self : CryptosignecdsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosignecdsaMatrix::norm(self : CryptosignecdsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosignecdsaMatrix::to_string(self : CryptosignecdsaMatrix) -> String {
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

pub(all) struct CryptosignecdsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_ecdsa_make_vector(comps : Array[Double]) -> CryptosignecdsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_ecdsa_vector_zero(dim : Int) -> CryptosignecdsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosignecdsaVector::add(self : CryptosignecdsaVector, other : CryptosignecdsaVector) -> CryptosignecdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignecdsaVector::sub(self : CryptosignecdsaVector, other : CryptosignecdsaVector) -> CryptosignecdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignecdsaVector::scale(self : CryptosignecdsaVector, s : Double) -> CryptosignecdsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosignecdsaVector::dot(self : CryptosignecdsaVector, other : CryptosignecdsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosignecdsaVector::norm(self : CryptosignecdsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosignecdsaVector::normalize(self : CryptosignecdsaVector) -> CryptosignecdsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignecdsaVector::dist(self : CryptosignecdsaVector, other : CryptosignecdsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosignecdsaVector::to_string(self : CryptosignecdsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_ecdsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_ecdsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_ecdsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_ecdsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_ecdsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_ecdsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_ecdsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_ecdsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_ecdsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_ecdsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_ecdsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_ecdsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_ecdsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_ecdsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_ecdsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_ecdsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_ecdsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_ecdsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_ecdsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_ecdsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_ecdsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_ecdsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_ecdsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_ecdsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_ecdsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_ecdsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_ecdsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_ecdsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_ecdsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignecdsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_frame_make(size : Int) -> CryptosignecdsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_frame_len(s : CryptosignecdsaFrame) -> Int { s.size }

pub fn crypto_sign_ecdsa_frame_get(s : CryptosignecdsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_frame_set(s : CryptosignecdsaFrame, i : Int, v : Double) -> CryptosignecdsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_frame_sum(s : CryptosignecdsaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_frame_mean(s : CryptosignecdsaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_frame_scale(s : CryptosignecdsaFrame, f : Double) -> CryptosignecdsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_frame_add(a : CryptosignecdsaFrame, b : CryptosignecdsaFrame) -> CryptosignecdsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_frame_copy(s : CryptosignecdsaFrame) -> CryptosignecdsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_frame_fill(s : CryptosignecdsaFrame, v : Double) -> CryptosignecdsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_frame_min(s : CryptosignecdsaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_frame_max(s : CryptosignecdsaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_frame_to_string(s : CryptosignecdsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_table_make(size : Int) -> CryptosignecdsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_table_len(s : CryptosignecdsaTable) -> Int { s.size }

pub fn crypto_sign_ecdsa_table_get(s : CryptosignecdsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_table_set(s : CryptosignecdsaTable, i : Int, v : Double) -> CryptosignecdsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_table_sum(s : CryptosignecdsaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_table_mean(s : CryptosignecdsaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_table_scale(s : CryptosignecdsaTable, f : Double) -> CryptosignecdsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_table_add(a : CryptosignecdsaTable, b : CryptosignecdsaTable) -> CryptosignecdsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_table_copy(s : CryptosignecdsaTable) -> CryptosignecdsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_table_fill(s : CryptosignecdsaTable, v : Double) -> CryptosignecdsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_table_min(s : CryptosignecdsaTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_table_max(s : CryptosignecdsaTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_table_to_string(s : CryptosignecdsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_graphn_make(size : Int) -> CryptosignecdsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_graphn_len(s : CryptosignecdsaGraphN) -> Int { s.size }

pub fn crypto_sign_ecdsa_graphn_get(s : CryptosignecdsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_graphn_set(s : CryptosignecdsaGraphN, i : Int, v : Double) -> CryptosignecdsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_graphn_sum(s : CryptosignecdsaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_graphn_mean(s : CryptosignecdsaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_graphn_scale(s : CryptosignecdsaGraphN, f : Double) -> CryptosignecdsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_graphn_add(a : CryptosignecdsaGraphN, b : CryptosignecdsaGraphN) -> CryptosignecdsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_graphn_copy(s : CryptosignecdsaGraphN) -> CryptosignecdsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_graphn_fill(s : CryptosignecdsaGraphN, v : Double) -> CryptosignecdsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_graphn_min(s : CryptosignecdsaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_graphn_max(s : CryptosignecdsaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_graphn_to_string(s : CryptosignecdsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_node_make(size : Int) -> CryptosignecdsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_node_len(s : CryptosignecdsaNode) -> Int { s.size }

pub fn crypto_sign_ecdsa_node_get(s : CryptosignecdsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_node_set(s : CryptosignecdsaNode, i : Int, v : Double) -> CryptosignecdsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_node_sum(s : CryptosignecdsaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_node_mean(s : CryptosignecdsaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_node_scale(s : CryptosignecdsaNode, f : Double) -> CryptosignecdsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_node_add(a : CryptosignecdsaNode, b : CryptosignecdsaNode) -> CryptosignecdsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_node_copy(s : CryptosignecdsaNode) -> CryptosignecdsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_node_fill(s : CryptosignecdsaNode, v : Double) -> CryptosignecdsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_node_min(s : CryptosignecdsaNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_node_max(s : CryptosignecdsaNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_node_to_string(s : CryptosignecdsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_edge_make(size : Int) -> CryptosignecdsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_edge_len(s : CryptosignecdsaEdge) -> Int { s.size }

pub fn crypto_sign_ecdsa_edge_get(s : CryptosignecdsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_edge_set(s : CryptosignecdsaEdge, i : Int, v : Double) -> CryptosignecdsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_edge_sum(s : CryptosignecdsaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_edge_mean(s : CryptosignecdsaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_edge_scale(s : CryptosignecdsaEdge, f : Double) -> CryptosignecdsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_edge_add(a : CryptosignecdsaEdge, b : CryptosignecdsaEdge) -> CryptosignecdsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_edge_copy(s : CryptosignecdsaEdge) -> CryptosignecdsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_edge_fill(s : CryptosignecdsaEdge, v : Double) -> CryptosignecdsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_edge_min(s : CryptosignecdsaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_edge_max(s : CryptosignecdsaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_edge_to_string(s : CryptosignecdsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_path_make(size : Int) -> CryptosignecdsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_path_len(s : CryptosignecdsaPath) -> Int { s.size }

pub fn crypto_sign_ecdsa_path_get(s : CryptosignecdsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_path_set(s : CryptosignecdsaPath, i : Int, v : Double) -> CryptosignecdsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_path_sum(s : CryptosignecdsaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_path_mean(s : CryptosignecdsaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_path_scale(s : CryptosignecdsaPath, f : Double) -> CryptosignecdsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_path_add(a : CryptosignecdsaPath, b : CryptosignecdsaPath) -> CryptosignecdsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_path_copy(s : CryptosignecdsaPath) -> CryptosignecdsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_path_fill(s : CryptosignecdsaPath, v : Double) -> CryptosignecdsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_path_min(s : CryptosignecdsaPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_path_max(s : CryptosignecdsaPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_path_to_string(s : CryptosignecdsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_cluster_make(size : Int) -> CryptosignecdsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_cluster_len(s : CryptosignecdsaCluster) -> Int { s.size }

pub fn crypto_sign_ecdsa_cluster_get(s : CryptosignecdsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_cluster_set(s : CryptosignecdsaCluster, i : Int, v : Double) -> CryptosignecdsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_cluster_sum(s : CryptosignecdsaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_cluster_mean(s : CryptosignecdsaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_cluster_scale(s : CryptosignecdsaCluster, f : Double) -> CryptosignecdsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_cluster_add(a : CryptosignecdsaCluster, b : CryptosignecdsaCluster) -> CryptosignecdsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_cluster_copy(s : CryptosignecdsaCluster) -> CryptosignecdsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_cluster_fill(s : CryptosignecdsaCluster, v : Double) -> CryptosignecdsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_cluster_min(s : CryptosignecdsaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_cluster_max(s : CryptosignecdsaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_cluster_to_string(s : CryptosignecdsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_model_make(size : Int) -> CryptosignecdsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_model_len(s : CryptosignecdsaModel) -> Int { s.size }

pub fn crypto_sign_ecdsa_model_get(s : CryptosignecdsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_model_set(s : CryptosignecdsaModel, i : Int, v : Double) -> CryptosignecdsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_model_sum(s : CryptosignecdsaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_model_mean(s : CryptosignecdsaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_model_scale(s : CryptosignecdsaModel, f : Double) -> CryptosignecdsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_model_add(a : CryptosignecdsaModel, b : CryptosignecdsaModel) -> CryptosignecdsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_model_copy(s : CryptosignecdsaModel) -> CryptosignecdsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_model_fill(s : CryptosignecdsaModel, v : Double) -> CryptosignecdsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_model_min(s : CryptosignecdsaModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_model_max(s : CryptosignecdsaModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_model_to_string(s : CryptosignecdsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_layer_make(size : Int) -> CryptosignecdsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_layer_len(s : CryptosignecdsaLayer) -> Int { s.size }

pub fn crypto_sign_ecdsa_layer_get(s : CryptosignecdsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_layer_set(s : CryptosignecdsaLayer, i : Int, v : Double) -> CryptosignecdsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_layer_sum(s : CryptosignecdsaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_layer_mean(s : CryptosignecdsaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_layer_scale(s : CryptosignecdsaLayer, f : Double) -> CryptosignecdsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_layer_add(a : CryptosignecdsaLayer, b : CryptosignecdsaLayer) -> CryptosignecdsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_layer_copy(s : CryptosignecdsaLayer) -> CryptosignecdsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_layer_fill(s : CryptosignecdsaLayer, v : Double) -> CryptosignecdsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_layer_min(s : CryptosignecdsaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_layer_max(s : CryptosignecdsaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_layer_to_string(s : CryptosignecdsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_buffer_make(size : Int) -> CryptosignecdsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_buffer_len(s : CryptosignecdsaBuffer) -> Int { s.size }

pub fn crypto_sign_ecdsa_buffer_get(s : CryptosignecdsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_buffer_set(s : CryptosignecdsaBuffer, i : Int, v : Double) -> CryptosignecdsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_buffer_sum(s : CryptosignecdsaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_buffer_mean(s : CryptosignecdsaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_buffer_scale(s : CryptosignecdsaBuffer, f : Double) -> CryptosignecdsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_buffer_add(a : CryptosignecdsaBuffer, b : CryptosignecdsaBuffer) -> CryptosignecdsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_buffer_copy(s : CryptosignecdsaBuffer) -> CryptosignecdsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_buffer_fill(s : CryptosignecdsaBuffer, v : Double) -> CryptosignecdsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_buffer_min(s : CryptosignecdsaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_buffer_max(s : CryptosignecdsaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_buffer_to_string(s : CryptosignecdsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_cursor_make(size : Int) -> CryptosignecdsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_cursor_len(s : CryptosignecdsaCursor) -> Int { s.size }

pub fn crypto_sign_ecdsa_cursor_get(s : CryptosignecdsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_cursor_set(s : CryptosignecdsaCursor, i : Int, v : Double) -> CryptosignecdsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_cursor_sum(s : CryptosignecdsaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_cursor_mean(s : CryptosignecdsaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_cursor_scale(s : CryptosignecdsaCursor, f : Double) -> CryptosignecdsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_cursor_add(a : CryptosignecdsaCursor, b : CryptosignecdsaCursor) -> CryptosignecdsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_cursor_copy(s : CryptosignecdsaCursor) -> CryptosignecdsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_cursor_fill(s : CryptosignecdsaCursor, v : Double) -> CryptosignecdsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_cursor_min(s : CryptosignecdsaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_cursor_max(s : CryptosignecdsaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_cursor_to_string(s : CryptosignecdsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_view_make(size : Int) -> CryptosignecdsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_view_len(s : CryptosignecdsaView) -> Int { s.size }

pub fn crypto_sign_ecdsa_view_get(s : CryptosignecdsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_view_set(s : CryptosignecdsaView, i : Int, v : Double) -> CryptosignecdsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_view_sum(s : CryptosignecdsaView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_view_mean(s : CryptosignecdsaView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_view_scale(s : CryptosignecdsaView, f : Double) -> CryptosignecdsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_view_add(a : CryptosignecdsaView, b : CryptosignecdsaView) -> CryptosignecdsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_view_copy(s : CryptosignecdsaView) -> CryptosignecdsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_view_fill(s : CryptosignecdsaView, v : Double) -> CryptosignecdsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_view_min(s : CryptosignecdsaView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_view_max(s : CryptosignecdsaView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_view_to_string(s : CryptosignecdsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_range_make(size : Int) -> CryptosignecdsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_range_len(s : CryptosignecdsaRange) -> Int { s.size }

pub fn crypto_sign_ecdsa_range_get(s : CryptosignecdsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_range_set(s : CryptosignecdsaRange, i : Int, v : Double) -> CryptosignecdsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_range_sum(s : CryptosignecdsaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_range_mean(s : CryptosignecdsaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_range_scale(s : CryptosignecdsaRange, f : Double) -> CryptosignecdsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_range_add(a : CryptosignecdsaRange, b : CryptosignecdsaRange) -> CryptosignecdsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_range_copy(s : CryptosignecdsaRange) -> CryptosignecdsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_range_fill(s : CryptosignecdsaRange, v : Double) -> CryptosignecdsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_range_min(s : CryptosignecdsaRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_range_max(s : CryptosignecdsaRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_range_to_string(s : CryptosignecdsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_slice_make(size : Int) -> CryptosignecdsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_slice_len(s : CryptosignecdsaSlice) -> Int { s.size }

pub fn crypto_sign_ecdsa_slice_get(s : CryptosignecdsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_slice_set(s : CryptosignecdsaSlice, i : Int, v : Double) -> CryptosignecdsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_slice_sum(s : CryptosignecdsaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ecdsa_slice_mean(s : CryptosignecdsaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ecdsa_slice_scale(s : CryptosignecdsaSlice, f : Double) -> CryptosignecdsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_slice_add(a : CryptosignecdsaSlice, b : CryptosignecdsaSlice) -> CryptosignecdsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ecdsa_slice_copy(s : CryptosignecdsaSlice) -> CryptosignecdsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_slice_fill(s : CryptosignecdsaSlice, v : Double) -> CryptosignecdsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ecdsa_slice_min(s : CryptosignecdsaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ecdsa_slice_max(s : CryptosignecdsaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ecdsa_slice_to_string(s : CryptosignecdsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

