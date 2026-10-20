///===
/// extcore/crypto_asym_dsa

pub(all) struct CryptoasymdsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_dsa_make_point(x : Double, y : Double) -> CryptoasymdsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_dsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymdsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymdsaPoint::x(self : CryptoasymdsaPoint) -> Double { self.x }

pub fn CryptoasymdsaPoint::y(self : CryptoasymdsaPoint) -> Double { self.y }

pub fn CryptoasymdsaPoint::z(self : CryptoasymdsaPoint) -> Double { self.z }

pub fn CryptoasymdsaPoint::label(self : CryptoasymdsaPoint) -> Int { self.label }

pub fn CryptoasymdsaPoint::dist(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymdsaPoint::add(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymdsaPoint::sub(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymdsaPoint::scale(self : CryptoasymdsaPoint, s : Double) -> CryptoasymdsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymdsaPoint::dot(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymdsaPoint::cross(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymdsaPoint::norm(self : CryptoasymdsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymdsaPoint::normalize(self : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymdsaPoint::negate(self : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymdsaPoint::mid(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymdsaPoint::lerp(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint, t : Double) -> CryptoasymdsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymdsaPoint::to_string(self : CryptoasymdsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymdsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_dsa_make_series(vals : Array[Double], name : String) -> CryptoasymdsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymdsaSeries::len(self : CryptoasymdsaSeries) -> Int { self.vals.length() }

pub fn CryptoasymdsaSeries::sum(self : CryptoasymdsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymdsaSeries::mean(self : CryptoasymdsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymdsaSeries::min(self : CryptoasymdsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymdsaSeries::max(self : CryptoasymdsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymdsaSeries::range(self : CryptoasymdsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymdsaSeries::variance(self : CryptoasymdsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymdsaSeries::std(self : CryptoasymdsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymdsaSeries::median(self : CryptoasymdsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymdsaSeries::scale(self : CryptoasymdsaSeries, f : Double) -> CryptoasymdsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymdsaSeries::add(self : CryptoasymdsaSeries, other : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymdsaSeries::sub(self : CryptoasymdsaSeries, other : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymdsaSeries::normalize(self : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymdsaSeries::cumsum(self : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymdsaSeries::to_string(self : CryptoasymdsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymdsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_dsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymdsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_dsa_matrix_identity(n : Int) -> CryptoasymdsaMatrix {
  let m = crypto_asym_dsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymdsaMatrix::get(self : CryptoasymdsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymdsaMatrix::transpose(self : CryptoasymdsaMatrix) -> CryptoasymdsaMatrix {
  let result = crypto_asym_dsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymdsaMatrix::add(self : CryptoasymdsaMatrix, other : CryptoasymdsaMatrix) -> CryptoasymdsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_dsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymdsaMatrix::scale(self : CryptoasymdsaMatrix, s : Double) -> CryptoasymdsaMatrix {
  let result = crypto_asym_dsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymdsaMatrix::multiply(self : CryptoasymdsaMatrix, other : CryptoasymdsaMatrix) -> CryptoasymdsaMatrix {
  if self.cols != other.rows { return crypto_asym_dsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_dsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptoasymdsaMatrix::trace(self : CryptoasymdsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymdsaMatrix::det(self : CryptoasymdsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymdsaMatrix::norm(self : CryptoasymdsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymdsaMatrix::to_string(self : CryptoasymdsaMatrix) -> String {
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

pub(all) struct CryptoasymdsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_dsa_make_vector(comps : Array[Double]) -> CryptoasymdsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_dsa_vector_zero(dim : Int) -> CryptoasymdsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymdsaVector::add(self : CryptoasymdsaVector, other : CryptoasymdsaVector) -> CryptoasymdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymdsaVector::sub(self : CryptoasymdsaVector, other : CryptoasymdsaVector) -> CryptoasymdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymdsaVector::scale(self : CryptoasymdsaVector, s : Double) -> CryptoasymdsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymdsaVector::dot(self : CryptoasymdsaVector, other : CryptoasymdsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymdsaVector::norm(self : CryptoasymdsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymdsaVector::normalize(self : CryptoasymdsaVector) -> CryptoasymdsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymdsaVector::dist(self : CryptoasymdsaVector, other : CryptoasymdsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymdsaVector::to_string(self : CryptoasymdsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_dsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_dsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_dsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_dsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_dsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_dsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_dsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_dsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_dsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_dsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_dsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_dsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_dsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_dsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_dsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_dsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_dsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_dsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_dsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_dsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_dsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_dsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_dsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_dsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_dsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_dsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_dsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_dsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_dsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymdsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_frame_make(size : Int) -> CryptoasymdsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_frame_len(s : CryptoasymdsaFrame) -> Int { s.size }

pub fn crypto_asym_dsa_frame_get(s : CryptoasymdsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_frame_set(s : CryptoasymdsaFrame, i : Int, v : Double) -> CryptoasymdsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_frame_sum(s : CryptoasymdsaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_frame_mean(s : CryptoasymdsaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_frame_scale(s : CryptoasymdsaFrame, f : Double) -> CryptoasymdsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_frame_add(a : CryptoasymdsaFrame, b : CryptoasymdsaFrame) -> CryptoasymdsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_frame_copy(s : CryptoasymdsaFrame) -> CryptoasymdsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_frame_fill(s : CryptoasymdsaFrame, v : Double) -> CryptoasymdsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_frame_min(s : CryptoasymdsaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_frame_max(s : CryptoasymdsaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_frame_to_string(s : CryptoasymdsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_table_make(size : Int) -> CryptoasymdsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_table_len(s : CryptoasymdsaTable) -> Int { s.size }

pub fn crypto_asym_dsa_table_get(s : CryptoasymdsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_table_set(s : CryptoasymdsaTable, i : Int, v : Double) -> CryptoasymdsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_table_sum(s : CryptoasymdsaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_table_mean(s : CryptoasymdsaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_table_scale(s : CryptoasymdsaTable, f : Double) -> CryptoasymdsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_table_add(a : CryptoasymdsaTable, b : CryptoasymdsaTable) -> CryptoasymdsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_table_copy(s : CryptoasymdsaTable) -> CryptoasymdsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_table_fill(s : CryptoasymdsaTable, v : Double) -> CryptoasymdsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_table_min(s : CryptoasymdsaTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_table_max(s : CryptoasymdsaTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_table_to_string(s : CryptoasymdsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_graphn_make(size : Int) -> CryptoasymdsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_graphn_len(s : CryptoasymdsaGraphN) -> Int { s.size }

pub fn crypto_asym_dsa_graphn_get(s : CryptoasymdsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_graphn_set(s : CryptoasymdsaGraphN, i : Int, v : Double) -> CryptoasymdsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_graphn_sum(s : CryptoasymdsaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_graphn_mean(s : CryptoasymdsaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_graphn_scale(s : CryptoasymdsaGraphN, f : Double) -> CryptoasymdsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_graphn_add(a : CryptoasymdsaGraphN, b : CryptoasymdsaGraphN) -> CryptoasymdsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_graphn_copy(s : CryptoasymdsaGraphN) -> CryptoasymdsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_graphn_fill(s : CryptoasymdsaGraphN, v : Double) -> CryptoasymdsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_graphn_min(s : CryptoasymdsaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_graphn_max(s : CryptoasymdsaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_graphn_to_string(s : CryptoasymdsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_node_make(size : Int) -> CryptoasymdsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_node_len(s : CryptoasymdsaNode) -> Int { s.size }

pub fn crypto_asym_dsa_node_get(s : CryptoasymdsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_node_set(s : CryptoasymdsaNode, i : Int, v : Double) -> CryptoasymdsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_node_sum(s : CryptoasymdsaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_node_mean(s : CryptoasymdsaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_node_scale(s : CryptoasymdsaNode, f : Double) -> CryptoasymdsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_node_add(a : CryptoasymdsaNode, b : CryptoasymdsaNode) -> CryptoasymdsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_node_copy(s : CryptoasymdsaNode) -> CryptoasymdsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_node_fill(s : CryptoasymdsaNode, v : Double) -> CryptoasymdsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_node_min(s : CryptoasymdsaNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_node_max(s : CryptoasymdsaNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_node_to_string(s : CryptoasymdsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_edge_make(size : Int) -> CryptoasymdsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_edge_len(s : CryptoasymdsaEdge) -> Int { s.size }

pub fn crypto_asym_dsa_edge_get(s : CryptoasymdsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_edge_set(s : CryptoasymdsaEdge, i : Int, v : Double) -> CryptoasymdsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_edge_sum(s : CryptoasymdsaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_edge_mean(s : CryptoasymdsaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_edge_scale(s : CryptoasymdsaEdge, f : Double) -> CryptoasymdsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_edge_add(a : CryptoasymdsaEdge, b : CryptoasymdsaEdge) -> CryptoasymdsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_edge_copy(s : CryptoasymdsaEdge) -> CryptoasymdsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_edge_fill(s : CryptoasymdsaEdge, v : Double) -> CryptoasymdsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_edge_min(s : CryptoasymdsaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_edge_max(s : CryptoasymdsaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_edge_to_string(s : CryptoasymdsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_path_make(size : Int) -> CryptoasymdsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_path_len(s : CryptoasymdsaPath) -> Int { s.size }

pub fn crypto_asym_dsa_path_get(s : CryptoasymdsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_path_set(s : CryptoasymdsaPath, i : Int, v : Double) -> CryptoasymdsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_path_sum(s : CryptoasymdsaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_path_mean(s : CryptoasymdsaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_path_scale(s : CryptoasymdsaPath, f : Double) -> CryptoasymdsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_path_add(a : CryptoasymdsaPath, b : CryptoasymdsaPath) -> CryptoasymdsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_path_copy(s : CryptoasymdsaPath) -> CryptoasymdsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_path_fill(s : CryptoasymdsaPath, v : Double) -> CryptoasymdsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_path_min(s : CryptoasymdsaPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_path_max(s : CryptoasymdsaPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_path_to_string(s : CryptoasymdsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_cluster_make(size : Int) -> CryptoasymdsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_cluster_len(s : CryptoasymdsaCluster) -> Int { s.size }

pub fn crypto_asym_dsa_cluster_get(s : CryptoasymdsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_cluster_set(s : CryptoasymdsaCluster, i : Int, v : Double) -> CryptoasymdsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_cluster_sum(s : CryptoasymdsaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_cluster_mean(s : CryptoasymdsaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_cluster_scale(s : CryptoasymdsaCluster, f : Double) -> CryptoasymdsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_cluster_add(a : CryptoasymdsaCluster, b : CryptoasymdsaCluster) -> CryptoasymdsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_cluster_copy(s : CryptoasymdsaCluster) -> CryptoasymdsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_cluster_fill(s : CryptoasymdsaCluster, v : Double) -> CryptoasymdsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_cluster_min(s : CryptoasymdsaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_cluster_max(s : CryptoasymdsaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_cluster_to_string(s : CryptoasymdsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_model_make(size : Int) -> CryptoasymdsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_model_len(s : CryptoasymdsaModel) -> Int { s.size }

pub fn crypto_asym_dsa_model_get(s : CryptoasymdsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_model_set(s : CryptoasymdsaModel, i : Int, v : Double) -> CryptoasymdsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_model_sum(s : CryptoasymdsaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_model_mean(s : CryptoasymdsaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_model_scale(s : CryptoasymdsaModel, f : Double) -> CryptoasymdsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_model_add(a : CryptoasymdsaModel, b : CryptoasymdsaModel) -> CryptoasymdsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_model_copy(s : CryptoasymdsaModel) -> CryptoasymdsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_model_fill(s : CryptoasymdsaModel, v : Double) -> CryptoasymdsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_model_min(s : CryptoasymdsaModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_model_max(s : CryptoasymdsaModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_model_to_string(s : CryptoasymdsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_layer_make(size : Int) -> CryptoasymdsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_layer_len(s : CryptoasymdsaLayer) -> Int { s.size }

pub fn crypto_asym_dsa_layer_get(s : CryptoasymdsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_layer_set(s : CryptoasymdsaLayer, i : Int, v : Double) -> CryptoasymdsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_layer_sum(s : CryptoasymdsaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_layer_mean(s : CryptoasymdsaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_layer_scale(s : CryptoasymdsaLayer, f : Double) -> CryptoasymdsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_layer_add(a : CryptoasymdsaLayer, b : CryptoasymdsaLayer) -> CryptoasymdsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_layer_copy(s : CryptoasymdsaLayer) -> CryptoasymdsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_layer_fill(s : CryptoasymdsaLayer, v : Double) -> CryptoasymdsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_layer_min(s : CryptoasymdsaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_layer_max(s : CryptoasymdsaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_layer_to_string(s : CryptoasymdsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_buffer_make(size : Int) -> CryptoasymdsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_buffer_len(s : CryptoasymdsaBuffer) -> Int { s.size }

pub fn crypto_asym_dsa_buffer_get(s : CryptoasymdsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_buffer_set(s : CryptoasymdsaBuffer, i : Int, v : Double) -> CryptoasymdsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_buffer_sum(s : CryptoasymdsaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_buffer_mean(s : CryptoasymdsaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_buffer_scale(s : CryptoasymdsaBuffer, f : Double) -> CryptoasymdsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_buffer_add(a : CryptoasymdsaBuffer, b : CryptoasymdsaBuffer) -> CryptoasymdsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_buffer_copy(s : CryptoasymdsaBuffer) -> CryptoasymdsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_buffer_fill(s : CryptoasymdsaBuffer, v : Double) -> CryptoasymdsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_buffer_min(s : CryptoasymdsaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_buffer_max(s : CryptoasymdsaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_buffer_to_string(s : CryptoasymdsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_cursor_make(size : Int) -> CryptoasymdsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_cursor_len(s : CryptoasymdsaCursor) -> Int { s.size }

pub fn crypto_asym_dsa_cursor_get(s : CryptoasymdsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_cursor_set(s : CryptoasymdsaCursor, i : Int, v : Double) -> CryptoasymdsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_cursor_sum(s : CryptoasymdsaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_cursor_mean(s : CryptoasymdsaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_cursor_scale(s : CryptoasymdsaCursor, f : Double) -> CryptoasymdsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_cursor_add(a : CryptoasymdsaCursor, b : CryptoasymdsaCursor) -> CryptoasymdsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_cursor_copy(s : CryptoasymdsaCursor) -> CryptoasymdsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_cursor_fill(s : CryptoasymdsaCursor, v : Double) -> CryptoasymdsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_cursor_min(s : CryptoasymdsaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_cursor_max(s : CryptoasymdsaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_cursor_to_string(s : CryptoasymdsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_view_make(size : Int) -> CryptoasymdsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_view_len(s : CryptoasymdsaView) -> Int { s.size }

pub fn crypto_asym_dsa_view_get(s : CryptoasymdsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_view_set(s : CryptoasymdsaView, i : Int, v : Double) -> CryptoasymdsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_view_sum(s : CryptoasymdsaView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_view_mean(s : CryptoasymdsaView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_view_scale(s : CryptoasymdsaView, f : Double) -> CryptoasymdsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_view_add(a : CryptoasymdsaView, b : CryptoasymdsaView) -> CryptoasymdsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_view_copy(s : CryptoasymdsaView) -> CryptoasymdsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_view_fill(s : CryptoasymdsaView, v : Double) -> CryptoasymdsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_view_min(s : CryptoasymdsaView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_view_max(s : CryptoasymdsaView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_view_to_string(s : CryptoasymdsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_range_make(size : Int) -> CryptoasymdsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_range_len(s : CryptoasymdsaRange) -> Int { s.size }

pub fn crypto_asym_dsa_range_get(s : CryptoasymdsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_range_set(s : CryptoasymdsaRange, i : Int, v : Double) -> CryptoasymdsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_range_sum(s : CryptoasymdsaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_range_mean(s : CryptoasymdsaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_range_scale(s : CryptoasymdsaRange, f : Double) -> CryptoasymdsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_range_add(a : CryptoasymdsaRange, b : CryptoasymdsaRange) -> CryptoasymdsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_range_copy(s : CryptoasymdsaRange) -> CryptoasymdsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_range_fill(s : CryptoasymdsaRange, v : Double) -> CryptoasymdsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_range_min(s : CryptoasymdsaRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_range_max(s : CryptoasymdsaRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_range_to_string(s : CryptoasymdsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_slice_make(size : Int) -> CryptoasymdsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_slice_len(s : CryptoasymdsaSlice) -> Int { s.size }

pub fn crypto_asym_dsa_slice_get(s : CryptoasymdsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_slice_set(s : CryptoasymdsaSlice, i : Int, v : Double) -> CryptoasymdsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_slice_sum(s : CryptoasymdsaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dsa_slice_mean(s : CryptoasymdsaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dsa_slice_scale(s : CryptoasymdsaSlice, f : Double) -> CryptoasymdsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_slice_add(a : CryptoasymdsaSlice, b : CryptoasymdsaSlice) -> CryptoasymdsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dsa_slice_copy(s : CryptoasymdsaSlice) -> CryptoasymdsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_slice_fill(s : CryptoasymdsaSlice, v : Double) -> CryptoasymdsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dsa_slice_min(s : CryptoasymdsaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dsa_slice_max(s : CryptoasymdsaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dsa_slice_to_string(s : CryptoasymdsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

