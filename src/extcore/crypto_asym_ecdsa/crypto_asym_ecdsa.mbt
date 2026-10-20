///===
/// extcore/crypto_asym_ecdsa

pub(all) struct CryptoasymecdsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_ecdsa_make_point(x : Double, y : Double) -> CryptoasymecdsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_ecdsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymecdsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymecdsaPoint::x(self : CryptoasymecdsaPoint) -> Double { self.x }

pub fn CryptoasymecdsaPoint::y(self : CryptoasymecdsaPoint) -> Double { self.y }

pub fn CryptoasymecdsaPoint::z(self : CryptoasymecdsaPoint) -> Double { self.z }

pub fn CryptoasymecdsaPoint::label(self : CryptoasymecdsaPoint) -> Int { self.label }

pub fn CryptoasymecdsaPoint::dist(self : CryptoasymecdsaPoint, other : CryptoasymecdsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymecdsaPoint::add(self : CryptoasymecdsaPoint, other : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymecdsaPoint::sub(self : CryptoasymecdsaPoint, other : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymecdsaPoint::scale(self : CryptoasymecdsaPoint, s : Double) -> CryptoasymecdsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymecdsaPoint::dot(self : CryptoasymecdsaPoint, other : CryptoasymecdsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymecdsaPoint::cross(self : CryptoasymecdsaPoint, other : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymecdsaPoint::norm(self : CryptoasymecdsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymecdsaPoint::normalize(self : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymecdsaPoint::negate(self : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymecdsaPoint::mid(self : CryptoasymecdsaPoint, other : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymecdsaPoint::lerp(self : CryptoasymecdsaPoint, other : CryptoasymecdsaPoint, t : Double) -> CryptoasymecdsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymecdsaPoint::to_string(self : CryptoasymecdsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymecdsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_ecdsa_make_series(vals : Array[Double], name : String) -> CryptoasymecdsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymecdsaSeries::len(self : CryptoasymecdsaSeries) -> Int { self.vals.length() }

pub fn CryptoasymecdsaSeries::sum(self : CryptoasymecdsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymecdsaSeries::mean(self : CryptoasymecdsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymecdsaSeries::min(self : CryptoasymecdsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymecdsaSeries::max(self : CryptoasymecdsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymecdsaSeries::range(self : CryptoasymecdsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymecdsaSeries::variance(self : CryptoasymecdsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymecdsaSeries::std(self : CryptoasymecdsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymecdsaSeries::median(self : CryptoasymecdsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymecdsaSeries::scale(self : CryptoasymecdsaSeries, f : Double) -> CryptoasymecdsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymecdsaSeries::add(self : CryptoasymecdsaSeries, other : CryptoasymecdsaSeries) -> CryptoasymecdsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymecdsaSeries::sub(self : CryptoasymecdsaSeries, other : CryptoasymecdsaSeries) -> CryptoasymecdsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymecdsaSeries::normalize(self : CryptoasymecdsaSeries) -> CryptoasymecdsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymecdsaSeries::cumsum(self : CryptoasymecdsaSeries) -> CryptoasymecdsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymecdsaSeries::to_string(self : CryptoasymecdsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymecdsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_ecdsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymecdsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_ecdsa_matrix_identity(n : Int) -> CryptoasymecdsaMatrix {
  let m = crypto_asym_ecdsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymecdsaMatrix::get(self : CryptoasymecdsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymecdsaMatrix::transpose(self : CryptoasymecdsaMatrix) -> CryptoasymecdsaMatrix {
  let result = crypto_asym_ecdsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymecdsaMatrix::add(self : CryptoasymecdsaMatrix, other : CryptoasymecdsaMatrix) -> CryptoasymecdsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_ecdsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymecdsaMatrix::scale(self : CryptoasymecdsaMatrix, s : Double) -> CryptoasymecdsaMatrix {
  let result = crypto_asym_ecdsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymecdsaMatrix::multiply(self : CryptoasymecdsaMatrix, other : CryptoasymecdsaMatrix) -> CryptoasymecdsaMatrix {
  if self.cols != other.rows { return crypto_asym_ecdsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_ecdsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptoasymecdsaMatrix::trace(self : CryptoasymecdsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymecdsaMatrix::det(self : CryptoasymecdsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymecdsaMatrix::norm(self : CryptoasymecdsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymecdsaMatrix::to_string(self : CryptoasymecdsaMatrix) -> String {
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

pub(all) struct CryptoasymecdsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_ecdsa_make_vector(comps : Array[Double]) -> CryptoasymecdsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_ecdsa_vector_zero(dim : Int) -> CryptoasymecdsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymecdsaVector::add(self : CryptoasymecdsaVector, other : CryptoasymecdsaVector) -> CryptoasymecdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymecdsaVector::sub(self : CryptoasymecdsaVector, other : CryptoasymecdsaVector) -> CryptoasymecdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymecdsaVector::scale(self : CryptoasymecdsaVector, s : Double) -> CryptoasymecdsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymecdsaVector::dot(self : CryptoasymecdsaVector, other : CryptoasymecdsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymecdsaVector::norm(self : CryptoasymecdsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymecdsaVector::normalize(self : CryptoasymecdsaVector) -> CryptoasymecdsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymecdsaVector::dist(self : CryptoasymecdsaVector, other : CryptoasymecdsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymecdsaVector::to_string(self : CryptoasymecdsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_ecdsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_ecdsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_ecdsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_ecdsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_ecdsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_ecdsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_ecdsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_ecdsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_ecdsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_ecdsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_ecdsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_ecdsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_ecdsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_ecdsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_ecdsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_ecdsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_ecdsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_ecdsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_ecdsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_ecdsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_ecdsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_ecdsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_ecdsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_ecdsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_ecdsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_ecdsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_ecdsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_ecdsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_ecdsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymecdsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_frame_make(size : Int) -> CryptoasymecdsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_frame_len(s : CryptoasymecdsaFrame) -> Int { s.size }

pub fn crypto_asym_ecdsa_frame_get(s : CryptoasymecdsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_frame_set(s : CryptoasymecdsaFrame, i : Int, v : Double) -> CryptoasymecdsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_frame_sum(s : CryptoasymecdsaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_frame_mean(s : CryptoasymecdsaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_frame_scale(s : CryptoasymecdsaFrame, f : Double) -> CryptoasymecdsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_frame_add(a : CryptoasymecdsaFrame, b : CryptoasymecdsaFrame) -> CryptoasymecdsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_frame_copy(s : CryptoasymecdsaFrame) -> CryptoasymecdsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_frame_fill(s : CryptoasymecdsaFrame, v : Double) -> CryptoasymecdsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_frame_min(s : CryptoasymecdsaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_frame_max(s : CryptoasymecdsaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_frame_to_string(s : CryptoasymecdsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_table_make(size : Int) -> CryptoasymecdsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_table_len(s : CryptoasymecdsaTable) -> Int { s.size }

pub fn crypto_asym_ecdsa_table_get(s : CryptoasymecdsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_table_set(s : CryptoasymecdsaTable, i : Int, v : Double) -> CryptoasymecdsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_table_sum(s : CryptoasymecdsaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_table_mean(s : CryptoasymecdsaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_table_scale(s : CryptoasymecdsaTable, f : Double) -> CryptoasymecdsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_table_add(a : CryptoasymecdsaTable, b : CryptoasymecdsaTable) -> CryptoasymecdsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_table_copy(s : CryptoasymecdsaTable) -> CryptoasymecdsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_table_fill(s : CryptoasymecdsaTable, v : Double) -> CryptoasymecdsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_table_min(s : CryptoasymecdsaTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_table_max(s : CryptoasymecdsaTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_table_to_string(s : CryptoasymecdsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_graphn_make(size : Int) -> CryptoasymecdsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_graphn_len(s : CryptoasymecdsaGraphN) -> Int { s.size }

pub fn crypto_asym_ecdsa_graphn_get(s : CryptoasymecdsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_graphn_set(s : CryptoasymecdsaGraphN, i : Int, v : Double) -> CryptoasymecdsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_graphn_sum(s : CryptoasymecdsaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_graphn_mean(s : CryptoasymecdsaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_graphn_scale(s : CryptoasymecdsaGraphN, f : Double) -> CryptoasymecdsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_graphn_add(a : CryptoasymecdsaGraphN, b : CryptoasymecdsaGraphN) -> CryptoasymecdsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_graphn_copy(s : CryptoasymecdsaGraphN) -> CryptoasymecdsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_graphn_fill(s : CryptoasymecdsaGraphN, v : Double) -> CryptoasymecdsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_graphn_min(s : CryptoasymecdsaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_graphn_max(s : CryptoasymecdsaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_graphn_to_string(s : CryptoasymecdsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_node_make(size : Int) -> CryptoasymecdsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_node_len(s : CryptoasymecdsaNode) -> Int { s.size }

pub fn crypto_asym_ecdsa_node_get(s : CryptoasymecdsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_node_set(s : CryptoasymecdsaNode, i : Int, v : Double) -> CryptoasymecdsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_node_sum(s : CryptoasymecdsaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_node_mean(s : CryptoasymecdsaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_node_scale(s : CryptoasymecdsaNode, f : Double) -> CryptoasymecdsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_node_add(a : CryptoasymecdsaNode, b : CryptoasymecdsaNode) -> CryptoasymecdsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_node_copy(s : CryptoasymecdsaNode) -> CryptoasymecdsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_node_fill(s : CryptoasymecdsaNode, v : Double) -> CryptoasymecdsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_node_min(s : CryptoasymecdsaNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_node_max(s : CryptoasymecdsaNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_node_to_string(s : CryptoasymecdsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_edge_make(size : Int) -> CryptoasymecdsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_edge_len(s : CryptoasymecdsaEdge) -> Int { s.size }

pub fn crypto_asym_ecdsa_edge_get(s : CryptoasymecdsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_edge_set(s : CryptoasymecdsaEdge, i : Int, v : Double) -> CryptoasymecdsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_edge_sum(s : CryptoasymecdsaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_edge_mean(s : CryptoasymecdsaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_edge_scale(s : CryptoasymecdsaEdge, f : Double) -> CryptoasymecdsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_edge_add(a : CryptoasymecdsaEdge, b : CryptoasymecdsaEdge) -> CryptoasymecdsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_edge_copy(s : CryptoasymecdsaEdge) -> CryptoasymecdsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_edge_fill(s : CryptoasymecdsaEdge, v : Double) -> CryptoasymecdsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_edge_min(s : CryptoasymecdsaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_edge_max(s : CryptoasymecdsaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_edge_to_string(s : CryptoasymecdsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_path_make(size : Int) -> CryptoasymecdsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_path_len(s : CryptoasymecdsaPath) -> Int { s.size }

pub fn crypto_asym_ecdsa_path_get(s : CryptoasymecdsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_path_set(s : CryptoasymecdsaPath, i : Int, v : Double) -> CryptoasymecdsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_path_sum(s : CryptoasymecdsaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_path_mean(s : CryptoasymecdsaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_path_scale(s : CryptoasymecdsaPath, f : Double) -> CryptoasymecdsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_path_add(a : CryptoasymecdsaPath, b : CryptoasymecdsaPath) -> CryptoasymecdsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_path_copy(s : CryptoasymecdsaPath) -> CryptoasymecdsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_path_fill(s : CryptoasymecdsaPath, v : Double) -> CryptoasymecdsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_path_min(s : CryptoasymecdsaPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_path_max(s : CryptoasymecdsaPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_path_to_string(s : CryptoasymecdsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_cluster_make(size : Int) -> CryptoasymecdsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_cluster_len(s : CryptoasymecdsaCluster) -> Int { s.size }

pub fn crypto_asym_ecdsa_cluster_get(s : CryptoasymecdsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_cluster_set(s : CryptoasymecdsaCluster, i : Int, v : Double) -> CryptoasymecdsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_cluster_sum(s : CryptoasymecdsaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_cluster_mean(s : CryptoasymecdsaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_cluster_scale(s : CryptoasymecdsaCluster, f : Double) -> CryptoasymecdsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_cluster_add(a : CryptoasymecdsaCluster, b : CryptoasymecdsaCluster) -> CryptoasymecdsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_cluster_copy(s : CryptoasymecdsaCluster) -> CryptoasymecdsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_cluster_fill(s : CryptoasymecdsaCluster, v : Double) -> CryptoasymecdsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_cluster_min(s : CryptoasymecdsaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_cluster_max(s : CryptoasymecdsaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_cluster_to_string(s : CryptoasymecdsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_model_make(size : Int) -> CryptoasymecdsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_model_len(s : CryptoasymecdsaModel) -> Int { s.size }

pub fn crypto_asym_ecdsa_model_get(s : CryptoasymecdsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_model_set(s : CryptoasymecdsaModel, i : Int, v : Double) -> CryptoasymecdsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_model_sum(s : CryptoasymecdsaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_model_mean(s : CryptoasymecdsaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_model_scale(s : CryptoasymecdsaModel, f : Double) -> CryptoasymecdsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_model_add(a : CryptoasymecdsaModel, b : CryptoasymecdsaModel) -> CryptoasymecdsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_model_copy(s : CryptoasymecdsaModel) -> CryptoasymecdsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_model_fill(s : CryptoasymecdsaModel, v : Double) -> CryptoasymecdsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_model_min(s : CryptoasymecdsaModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_model_max(s : CryptoasymecdsaModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_model_to_string(s : CryptoasymecdsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_layer_make(size : Int) -> CryptoasymecdsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_layer_len(s : CryptoasymecdsaLayer) -> Int { s.size }

pub fn crypto_asym_ecdsa_layer_get(s : CryptoasymecdsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_layer_set(s : CryptoasymecdsaLayer, i : Int, v : Double) -> CryptoasymecdsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_layer_sum(s : CryptoasymecdsaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_layer_mean(s : CryptoasymecdsaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_layer_scale(s : CryptoasymecdsaLayer, f : Double) -> CryptoasymecdsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_layer_add(a : CryptoasymecdsaLayer, b : CryptoasymecdsaLayer) -> CryptoasymecdsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_layer_copy(s : CryptoasymecdsaLayer) -> CryptoasymecdsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_layer_fill(s : CryptoasymecdsaLayer, v : Double) -> CryptoasymecdsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_layer_min(s : CryptoasymecdsaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_layer_max(s : CryptoasymecdsaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_layer_to_string(s : CryptoasymecdsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_buffer_make(size : Int) -> CryptoasymecdsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_buffer_len(s : CryptoasymecdsaBuffer) -> Int { s.size }

pub fn crypto_asym_ecdsa_buffer_get(s : CryptoasymecdsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_buffer_set(s : CryptoasymecdsaBuffer, i : Int, v : Double) -> CryptoasymecdsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_buffer_sum(s : CryptoasymecdsaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_buffer_mean(s : CryptoasymecdsaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_buffer_scale(s : CryptoasymecdsaBuffer, f : Double) -> CryptoasymecdsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_buffer_add(a : CryptoasymecdsaBuffer, b : CryptoasymecdsaBuffer) -> CryptoasymecdsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_buffer_copy(s : CryptoasymecdsaBuffer) -> CryptoasymecdsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_buffer_fill(s : CryptoasymecdsaBuffer, v : Double) -> CryptoasymecdsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_buffer_min(s : CryptoasymecdsaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_buffer_max(s : CryptoasymecdsaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_buffer_to_string(s : CryptoasymecdsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_cursor_make(size : Int) -> CryptoasymecdsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_cursor_len(s : CryptoasymecdsaCursor) -> Int { s.size }

pub fn crypto_asym_ecdsa_cursor_get(s : CryptoasymecdsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_cursor_set(s : CryptoasymecdsaCursor, i : Int, v : Double) -> CryptoasymecdsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_cursor_sum(s : CryptoasymecdsaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_cursor_mean(s : CryptoasymecdsaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_cursor_scale(s : CryptoasymecdsaCursor, f : Double) -> CryptoasymecdsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_cursor_add(a : CryptoasymecdsaCursor, b : CryptoasymecdsaCursor) -> CryptoasymecdsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_cursor_copy(s : CryptoasymecdsaCursor) -> CryptoasymecdsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_cursor_fill(s : CryptoasymecdsaCursor, v : Double) -> CryptoasymecdsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_cursor_min(s : CryptoasymecdsaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_cursor_max(s : CryptoasymecdsaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_cursor_to_string(s : CryptoasymecdsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_view_make(size : Int) -> CryptoasymecdsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_view_len(s : CryptoasymecdsaView) -> Int { s.size }

pub fn crypto_asym_ecdsa_view_get(s : CryptoasymecdsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_view_set(s : CryptoasymecdsaView, i : Int, v : Double) -> CryptoasymecdsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_view_sum(s : CryptoasymecdsaView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_view_mean(s : CryptoasymecdsaView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_view_scale(s : CryptoasymecdsaView, f : Double) -> CryptoasymecdsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_view_add(a : CryptoasymecdsaView, b : CryptoasymecdsaView) -> CryptoasymecdsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_view_copy(s : CryptoasymecdsaView) -> CryptoasymecdsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_view_fill(s : CryptoasymecdsaView, v : Double) -> CryptoasymecdsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_view_min(s : CryptoasymecdsaView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_view_max(s : CryptoasymecdsaView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_view_to_string(s : CryptoasymecdsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_range_make(size : Int) -> CryptoasymecdsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_range_len(s : CryptoasymecdsaRange) -> Int { s.size }

pub fn crypto_asym_ecdsa_range_get(s : CryptoasymecdsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_range_set(s : CryptoasymecdsaRange, i : Int, v : Double) -> CryptoasymecdsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_range_sum(s : CryptoasymecdsaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_range_mean(s : CryptoasymecdsaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_range_scale(s : CryptoasymecdsaRange, f : Double) -> CryptoasymecdsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_range_add(a : CryptoasymecdsaRange, b : CryptoasymecdsaRange) -> CryptoasymecdsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_range_copy(s : CryptoasymecdsaRange) -> CryptoasymecdsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_range_fill(s : CryptoasymecdsaRange, v : Double) -> CryptoasymecdsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_range_min(s : CryptoasymecdsaRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_range_max(s : CryptoasymecdsaRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_range_to_string(s : CryptoasymecdsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_slice_make(size : Int) -> CryptoasymecdsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_slice_len(s : CryptoasymecdsaSlice) -> Int { s.size }

pub fn crypto_asym_ecdsa_slice_get(s : CryptoasymecdsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_slice_set(s : CryptoasymecdsaSlice, i : Int, v : Double) -> CryptoasymecdsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_slice_sum(s : CryptoasymecdsaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecdsa_slice_mean(s : CryptoasymecdsaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecdsa_slice_scale(s : CryptoasymecdsaSlice, f : Double) -> CryptoasymecdsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_slice_add(a : CryptoasymecdsaSlice, b : CryptoasymecdsaSlice) -> CryptoasymecdsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecdsa_slice_copy(s : CryptoasymecdsaSlice) -> CryptoasymecdsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_slice_fill(s : CryptoasymecdsaSlice, v : Double) -> CryptoasymecdsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecdsa_slice_min(s : CryptoasymecdsaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecdsa_slice_max(s : CryptoasymecdsaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecdsa_slice_to_string(s : CryptoasymecdsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

