///===
/// extcore/crypto_sign_eddsa

pub(all) struct CryptosigneddsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_eddsa_make_point(x : Double, y : Double) -> CryptosigneddsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_eddsa_make_point3(x : Double, y : Double, z : Double) -> CryptosigneddsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosigneddsaPoint::x(self : CryptosigneddsaPoint) -> Double { self.x }

pub fn CryptosigneddsaPoint::y(self : CryptosigneddsaPoint) -> Double { self.y }

pub fn CryptosigneddsaPoint::z(self : CryptosigneddsaPoint) -> Double { self.z }

pub fn CryptosigneddsaPoint::label(self : CryptosigneddsaPoint) -> Int { self.label }

pub fn CryptosigneddsaPoint::dist(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosigneddsaPoint::add(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosigneddsaPoint::sub(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosigneddsaPoint::scale(self : CryptosigneddsaPoint, s : Double) -> CryptosigneddsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosigneddsaPoint::dot(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosigneddsaPoint::cross(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosigneddsaPoint::norm(self : CryptosigneddsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosigneddsaPoint::normalize(self : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigneddsaPoint::negate(self : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosigneddsaPoint::mid(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosigneddsaPoint::lerp(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint, t : Double) -> CryptosigneddsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosigneddsaPoint::to_string(self : CryptosigneddsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosigneddsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_eddsa_make_series(vals : Array[Double], name : String) -> CryptosigneddsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosigneddsaSeries::len(self : CryptosigneddsaSeries) -> Int { self.vals.length() }

pub fn CryptosigneddsaSeries::sum(self : CryptosigneddsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosigneddsaSeries::mean(self : CryptosigneddsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosigneddsaSeries::min(self : CryptosigneddsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosigneddsaSeries::max(self : CryptosigneddsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosigneddsaSeries::range(self : CryptosigneddsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosigneddsaSeries::variance(self : CryptosigneddsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosigneddsaSeries::std(self : CryptosigneddsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosigneddsaSeries::median(self : CryptosigneddsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosigneddsaSeries::scale(self : CryptosigneddsaSeries, f : Double) -> CryptosigneddsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosigneddsaSeries::add(self : CryptosigneddsaSeries, other : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosigneddsaSeries::sub(self : CryptosigneddsaSeries, other : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosigneddsaSeries::normalize(self : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosigneddsaSeries::cumsum(self : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosigneddsaSeries::to_string(self : CryptosigneddsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigneddsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_eddsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosigneddsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_eddsa_matrix_identity(n : Int) -> CryptosigneddsaMatrix {
  let m = crypto_sign_eddsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosigneddsaMatrix::get(self : CryptosigneddsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosigneddsaMatrix::transpose(self : CryptosigneddsaMatrix) -> CryptosigneddsaMatrix {
  let result = crypto_sign_eddsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosigneddsaMatrix::add(self : CryptosigneddsaMatrix, other : CryptosigneddsaMatrix) -> CryptosigneddsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_eddsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosigneddsaMatrix::scale(self : CryptosigneddsaMatrix, s : Double) -> CryptosigneddsaMatrix {
  let result = crypto_sign_eddsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosigneddsaMatrix::multiply(self : CryptosigneddsaMatrix, other : CryptosigneddsaMatrix) -> CryptosigneddsaMatrix {
  if self.cols != other.rows { return crypto_sign_eddsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_eddsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosigneddsaMatrix::trace(self : CryptosigneddsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosigneddsaMatrix::det(self : CryptosigneddsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosigneddsaMatrix::norm(self : CryptosigneddsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosigneddsaMatrix::to_string(self : CryptosigneddsaMatrix) -> String {
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

pub(all) struct CryptosigneddsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_eddsa_make_vector(comps : Array[Double]) -> CryptosigneddsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_eddsa_vector_zero(dim : Int) -> CryptosigneddsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosigneddsaVector::add(self : CryptosigneddsaVector, other : CryptosigneddsaVector) -> CryptosigneddsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigneddsaVector::sub(self : CryptosigneddsaVector, other : CryptosigneddsaVector) -> CryptosigneddsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigneddsaVector::scale(self : CryptosigneddsaVector, s : Double) -> CryptosigneddsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosigneddsaVector::dot(self : CryptosigneddsaVector, other : CryptosigneddsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosigneddsaVector::norm(self : CryptosigneddsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosigneddsaVector::normalize(self : CryptosigneddsaVector) -> CryptosigneddsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigneddsaVector::dist(self : CryptosigneddsaVector, other : CryptosigneddsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosigneddsaVector::to_string(self : CryptosigneddsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_eddsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_eddsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_eddsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_eddsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_eddsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_eddsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_eddsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_eddsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_eddsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_eddsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_eddsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_eddsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_eddsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_eddsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_eddsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_eddsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_eddsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_eddsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_eddsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_eddsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_eddsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_eddsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_eddsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_eddsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_eddsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_eddsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_eddsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_eddsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_eddsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosigneddsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_frame_make(size : Int) -> CryptosigneddsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_frame_len(s : CryptosigneddsaFrame) -> Int { s.size }

pub fn crypto_sign_eddsa_frame_get(s : CryptosigneddsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_frame_set(s : CryptosigneddsaFrame, i : Int, v : Double) -> CryptosigneddsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_frame_sum(s : CryptosigneddsaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_frame_mean(s : CryptosigneddsaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_frame_scale(s : CryptosigneddsaFrame, f : Double) -> CryptosigneddsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_frame_add(a : CryptosigneddsaFrame, b : CryptosigneddsaFrame) -> CryptosigneddsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_frame_copy(s : CryptosigneddsaFrame) -> CryptosigneddsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_frame_fill(s : CryptosigneddsaFrame, v : Double) -> CryptosigneddsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_frame_min(s : CryptosigneddsaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_frame_max(s : CryptosigneddsaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_frame_to_string(s : CryptosigneddsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_table_make(size : Int) -> CryptosigneddsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_table_len(s : CryptosigneddsaTable) -> Int { s.size }

pub fn crypto_sign_eddsa_table_get(s : CryptosigneddsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_table_set(s : CryptosigneddsaTable, i : Int, v : Double) -> CryptosigneddsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_table_sum(s : CryptosigneddsaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_table_mean(s : CryptosigneddsaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_table_scale(s : CryptosigneddsaTable, f : Double) -> CryptosigneddsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_table_add(a : CryptosigneddsaTable, b : CryptosigneddsaTable) -> CryptosigneddsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_table_copy(s : CryptosigneddsaTable) -> CryptosigneddsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_table_fill(s : CryptosigneddsaTable, v : Double) -> CryptosigneddsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_table_min(s : CryptosigneddsaTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_table_max(s : CryptosigneddsaTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_table_to_string(s : CryptosigneddsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_graphn_make(size : Int) -> CryptosigneddsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_graphn_len(s : CryptosigneddsaGraphN) -> Int { s.size }

pub fn crypto_sign_eddsa_graphn_get(s : CryptosigneddsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_graphn_set(s : CryptosigneddsaGraphN, i : Int, v : Double) -> CryptosigneddsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_graphn_sum(s : CryptosigneddsaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_graphn_mean(s : CryptosigneddsaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_graphn_scale(s : CryptosigneddsaGraphN, f : Double) -> CryptosigneddsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_graphn_add(a : CryptosigneddsaGraphN, b : CryptosigneddsaGraphN) -> CryptosigneddsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_graphn_copy(s : CryptosigneddsaGraphN) -> CryptosigneddsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_graphn_fill(s : CryptosigneddsaGraphN, v : Double) -> CryptosigneddsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_graphn_min(s : CryptosigneddsaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_graphn_max(s : CryptosigneddsaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_graphn_to_string(s : CryptosigneddsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_node_make(size : Int) -> CryptosigneddsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_node_len(s : CryptosigneddsaNode) -> Int { s.size }

pub fn crypto_sign_eddsa_node_get(s : CryptosigneddsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_node_set(s : CryptosigneddsaNode, i : Int, v : Double) -> CryptosigneddsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_node_sum(s : CryptosigneddsaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_node_mean(s : CryptosigneddsaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_node_scale(s : CryptosigneddsaNode, f : Double) -> CryptosigneddsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_node_add(a : CryptosigneddsaNode, b : CryptosigneddsaNode) -> CryptosigneddsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_node_copy(s : CryptosigneddsaNode) -> CryptosigneddsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_node_fill(s : CryptosigneddsaNode, v : Double) -> CryptosigneddsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_node_min(s : CryptosigneddsaNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_node_max(s : CryptosigneddsaNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_node_to_string(s : CryptosigneddsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_edge_make(size : Int) -> CryptosigneddsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_edge_len(s : CryptosigneddsaEdge) -> Int { s.size }

pub fn crypto_sign_eddsa_edge_get(s : CryptosigneddsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_edge_set(s : CryptosigneddsaEdge, i : Int, v : Double) -> CryptosigneddsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_edge_sum(s : CryptosigneddsaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_edge_mean(s : CryptosigneddsaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_edge_scale(s : CryptosigneddsaEdge, f : Double) -> CryptosigneddsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_edge_add(a : CryptosigneddsaEdge, b : CryptosigneddsaEdge) -> CryptosigneddsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_edge_copy(s : CryptosigneddsaEdge) -> CryptosigneddsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_edge_fill(s : CryptosigneddsaEdge, v : Double) -> CryptosigneddsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_edge_min(s : CryptosigneddsaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_edge_max(s : CryptosigneddsaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_edge_to_string(s : CryptosigneddsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_path_make(size : Int) -> CryptosigneddsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_path_len(s : CryptosigneddsaPath) -> Int { s.size }

pub fn crypto_sign_eddsa_path_get(s : CryptosigneddsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_path_set(s : CryptosigneddsaPath, i : Int, v : Double) -> CryptosigneddsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_path_sum(s : CryptosigneddsaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_path_mean(s : CryptosigneddsaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_path_scale(s : CryptosigneddsaPath, f : Double) -> CryptosigneddsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_path_add(a : CryptosigneddsaPath, b : CryptosigneddsaPath) -> CryptosigneddsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_path_copy(s : CryptosigneddsaPath) -> CryptosigneddsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_path_fill(s : CryptosigneddsaPath, v : Double) -> CryptosigneddsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_path_min(s : CryptosigneddsaPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_path_max(s : CryptosigneddsaPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_path_to_string(s : CryptosigneddsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_cluster_make(size : Int) -> CryptosigneddsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_cluster_len(s : CryptosigneddsaCluster) -> Int { s.size }

pub fn crypto_sign_eddsa_cluster_get(s : CryptosigneddsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_cluster_set(s : CryptosigneddsaCluster, i : Int, v : Double) -> CryptosigneddsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_cluster_sum(s : CryptosigneddsaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_cluster_mean(s : CryptosigneddsaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_cluster_scale(s : CryptosigneddsaCluster, f : Double) -> CryptosigneddsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_cluster_add(a : CryptosigneddsaCluster, b : CryptosigneddsaCluster) -> CryptosigneddsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_cluster_copy(s : CryptosigneddsaCluster) -> CryptosigneddsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_cluster_fill(s : CryptosigneddsaCluster, v : Double) -> CryptosigneddsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_cluster_min(s : CryptosigneddsaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_cluster_max(s : CryptosigneddsaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_cluster_to_string(s : CryptosigneddsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_model_make(size : Int) -> CryptosigneddsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_model_len(s : CryptosigneddsaModel) -> Int { s.size }

pub fn crypto_sign_eddsa_model_get(s : CryptosigneddsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_model_set(s : CryptosigneddsaModel, i : Int, v : Double) -> CryptosigneddsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_model_sum(s : CryptosigneddsaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_model_mean(s : CryptosigneddsaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_model_scale(s : CryptosigneddsaModel, f : Double) -> CryptosigneddsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_model_add(a : CryptosigneddsaModel, b : CryptosigneddsaModel) -> CryptosigneddsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_model_copy(s : CryptosigneddsaModel) -> CryptosigneddsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_model_fill(s : CryptosigneddsaModel, v : Double) -> CryptosigneddsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_model_min(s : CryptosigneddsaModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_model_max(s : CryptosigneddsaModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_model_to_string(s : CryptosigneddsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_layer_make(size : Int) -> CryptosigneddsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_layer_len(s : CryptosigneddsaLayer) -> Int { s.size }

pub fn crypto_sign_eddsa_layer_get(s : CryptosigneddsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_layer_set(s : CryptosigneddsaLayer, i : Int, v : Double) -> CryptosigneddsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_layer_sum(s : CryptosigneddsaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_layer_mean(s : CryptosigneddsaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_layer_scale(s : CryptosigneddsaLayer, f : Double) -> CryptosigneddsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_layer_add(a : CryptosigneddsaLayer, b : CryptosigneddsaLayer) -> CryptosigneddsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_layer_copy(s : CryptosigneddsaLayer) -> CryptosigneddsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_layer_fill(s : CryptosigneddsaLayer, v : Double) -> CryptosigneddsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_layer_min(s : CryptosigneddsaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_layer_max(s : CryptosigneddsaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_layer_to_string(s : CryptosigneddsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_buffer_make(size : Int) -> CryptosigneddsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_buffer_len(s : CryptosigneddsaBuffer) -> Int { s.size }

pub fn crypto_sign_eddsa_buffer_get(s : CryptosigneddsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_buffer_set(s : CryptosigneddsaBuffer, i : Int, v : Double) -> CryptosigneddsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_buffer_sum(s : CryptosigneddsaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_buffer_mean(s : CryptosigneddsaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_buffer_scale(s : CryptosigneddsaBuffer, f : Double) -> CryptosigneddsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_buffer_add(a : CryptosigneddsaBuffer, b : CryptosigneddsaBuffer) -> CryptosigneddsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_buffer_copy(s : CryptosigneddsaBuffer) -> CryptosigneddsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_buffer_fill(s : CryptosigneddsaBuffer, v : Double) -> CryptosigneddsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_buffer_min(s : CryptosigneddsaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_buffer_max(s : CryptosigneddsaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_buffer_to_string(s : CryptosigneddsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_cursor_make(size : Int) -> CryptosigneddsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_cursor_len(s : CryptosigneddsaCursor) -> Int { s.size }

pub fn crypto_sign_eddsa_cursor_get(s : CryptosigneddsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_cursor_set(s : CryptosigneddsaCursor, i : Int, v : Double) -> CryptosigneddsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_cursor_sum(s : CryptosigneddsaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_cursor_mean(s : CryptosigneddsaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_cursor_scale(s : CryptosigneddsaCursor, f : Double) -> CryptosigneddsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_cursor_add(a : CryptosigneddsaCursor, b : CryptosigneddsaCursor) -> CryptosigneddsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_cursor_copy(s : CryptosigneddsaCursor) -> CryptosigneddsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_cursor_fill(s : CryptosigneddsaCursor, v : Double) -> CryptosigneddsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_cursor_min(s : CryptosigneddsaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_cursor_max(s : CryptosigneddsaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_cursor_to_string(s : CryptosigneddsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_view_make(size : Int) -> CryptosigneddsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_view_len(s : CryptosigneddsaView) -> Int { s.size }

pub fn crypto_sign_eddsa_view_get(s : CryptosigneddsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_view_set(s : CryptosigneddsaView, i : Int, v : Double) -> CryptosigneddsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_view_sum(s : CryptosigneddsaView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_view_mean(s : CryptosigneddsaView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_view_scale(s : CryptosigneddsaView, f : Double) -> CryptosigneddsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_view_add(a : CryptosigneddsaView, b : CryptosigneddsaView) -> CryptosigneddsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_view_copy(s : CryptosigneddsaView) -> CryptosigneddsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_view_fill(s : CryptosigneddsaView, v : Double) -> CryptosigneddsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_view_min(s : CryptosigneddsaView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_view_max(s : CryptosigneddsaView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_view_to_string(s : CryptosigneddsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_range_make(size : Int) -> CryptosigneddsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_range_len(s : CryptosigneddsaRange) -> Int { s.size }

pub fn crypto_sign_eddsa_range_get(s : CryptosigneddsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_range_set(s : CryptosigneddsaRange, i : Int, v : Double) -> CryptosigneddsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_range_sum(s : CryptosigneddsaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_range_mean(s : CryptosigneddsaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_range_scale(s : CryptosigneddsaRange, f : Double) -> CryptosigneddsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_range_add(a : CryptosigneddsaRange, b : CryptosigneddsaRange) -> CryptosigneddsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_range_copy(s : CryptosigneddsaRange) -> CryptosigneddsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_range_fill(s : CryptosigneddsaRange, v : Double) -> CryptosigneddsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_range_min(s : CryptosigneddsaRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_range_max(s : CryptosigneddsaRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_range_to_string(s : CryptosigneddsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_slice_make(size : Int) -> CryptosigneddsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_slice_len(s : CryptosigneddsaSlice) -> Int { s.size }

pub fn crypto_sign_eddsa_slice_get(s : CryptosigneddsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_slice_set(s : CryptosigneddsaSlice, i : Int, v : Double) -> CryptosigneddsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_slice_sum(s : CryptosigneddsaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_eddsa_slice_mean(s : CryptosigneddsaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_eddsa_slice_scale(s : CryptosigneddsaSlice, f : Double) -> CryptosigneddsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_slice_add(a : CryptosigneddsaSlice, b : CryptosigneddsaSlice) -> CryptosigneddsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_eddsa_slice_copy(s : CryptosigneddsaSlice) -> CryptosigneddsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_slice_fill(s : CryptosigneddsaSlice, v : Double) -> CryptosigneddsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_eddsa_slice_min(s : CryptosigneddsaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_eddsa_slice_max(s : CryptosigneddsaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_eddsa_slice_to_string(s : CryptosigneddsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

