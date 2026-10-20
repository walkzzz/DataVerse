///===
/// extcore/crypto_sign_dsa

pub(all) struct CryptosigndsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_dsa_make_point(x : Double, y : Double) -> CryptosigndsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_dsa_make_point3(x : Double, y : Double, z : Double) -> CryptosigndsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosigndsaPoint::x(self : CryptosigndsaPoint) -> Double { self.x }

pub fn CryptosigndsaPoint::y(self : CryptosigndsaPoint) -> Double { self.y }

pub fn CryptosigndsaPoint::z(self : CryptosigndsaPoint) -> Double { self.z }

pub fn CryptosigndsaPoint::label(self : CryptosigndsaPoint) -> Int { self.label }

pub fn CryptosigndsaPoint::dist(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosigndsaPoint::add(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosigndsaPoint::sub(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosigndsaPoint::scale(self : CryptosigndsaPoint, s : Double) -> CryptosigndsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosigndsaPoint::dot(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosigndsaPoint::cross(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosigndsaPoint::norm(self : CryptosigndsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosigndsaPoint::normalize(self : CryptosigndsaPoint) -> CryptosigndsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigndsaPoint::negate(self : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosigndsaPoint::mid(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosigndsaPoint::lerp(self : CryptosigndsaPoint, other : CryptosigndsaPoint, t : Double) -> CryptosigndsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosigndsaPoint::to_string(self : CryptosigndsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosigndsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_dsa_make_series(vals : Array[Double], name : String) -> CryptosigndsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosigndsaSeries::len(self : CryptosigndsaSeries) -> Int { self.vals.length() }

pub fn CryptosigndsaSeries::sum(self : CryptosigndsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosigndsaSeries::mean(self : CryptosigndsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosigndsaSeries::min(self : CryptosigndsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosigndsaSeries::max(self : CryptosigndsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosigndsaSeries::range(self : CryptosigndsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosigndsaSeries::variance(self : CryptosigndsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosigndsaSeries::std(self : CryptosigndsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosigndsaSeries::median(self : CryptosigndsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosigndsaSeries::scale(self : CryptosigndsaSeries, f : Double) -> CryptosigndsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosigndsaSeries::add(self : CryptosigndsaSeries, other : CryptosigndsaSeries) -> CryptosigndsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosigndsaSeries::sub(self : CryptosigndsaSeries, other : CryptosigndsaSeries) -> CryptosigndsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosigndsaSeries::normalize(self : CryptosigndsaSeries) -> CryptosigndsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosigndsaSeries::cumsum(self : CryptosigndsaSeries) -> CryptosigndsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosigndsaSeries::to_string(self : CryptosigndsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigndsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_dsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosigndsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_dsa_matrix_identity(n : Int) -> CryptosigndsaMatrix {
  let m = crypto_sign_dsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosigndsaMatrix::get(self : CryptosigndsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosigndsaMatrix::transpose(self : CryptosigndsaMatrix) -> CryptosigndsaMatrix {
  let result = crypto_sign_dsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosigndsaMatrix::add(self : CryptosigndsaMatrix, other : CryptosigndsaMatrix) -> CryptosigndsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_dsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosigndsaMatrix::scale(self : CryptosigndsaMatrix, s : Double) -> CryptosigndsaMatrix {
  let result = crypto_sign_dsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosigndsaMatrix::multiply(self : CryptosigndsaMatrix, other : CryptosigndsaMatrix) -> CryptosigndsaMatrix {
  if self.cols != other.rows { return crypto_sign_dsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_dsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosigndsaMatrix::trace(self : CryptosigndsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosigndsaMatrix::det(self : CryptosigndsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosigndsaMatrix::norm(self : CryptosigndsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosigndsaMatrix::to_string(self : CryptosigndsaMatrix) -> String {
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

pub(all) struct CryptosigndsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_dsa_make_vector(comps : Array[Double]) -> CryptosigndsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_dsa_vector_zero(dim : Int) -> CryptosigndsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosigndsaVector::add(self : CryptosigndsaVector, other : CryptosigndsaVector) -> CryptosigndsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigndsaVector::sub(self : CryptosigndsaVector, other : CryptosigndsaVector) -> CryptosigndsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigndsaVector::scale(self : CryptosigndsaVector, s : Double) -> CryptosigndsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosigndsaVector::dot(self : CryptosigndsaVector, other : CryptosigndsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosigndsaVector::norm(self : CryptosigndsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosigndsaVector::normalize(self : CryptosigndsaVector) -> CryptosigndsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigndsaVector::dist(self : CryptosigndsaVector, other : CryptosigndsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosigndsaVector::to_string(self : CryptosigndsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_dsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_dsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_dsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_dsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_dsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_dsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_dsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_dsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_dsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_dsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_dsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_dsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_dsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_dsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_dsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_dsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_dsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_dsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_dsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_dsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_dsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_dsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_dsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_dsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_dsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_dsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_dsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_dsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_dsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosigndsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_frame_make(size : Int) -> CryptosigndsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_frame_len(s : CryptosigndsaFrame) -> Int { s.size }

pub fn crypto_sign_dsa_frame_get(s : CryptosigndsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_frame_set(s : CryptosigndsaFrame, i : Int, v : Double) -> CryptosigndsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_frame_sum(s : CryptosigndsaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_frame_mean(s : CryptosigndsaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_frame_scale(s : CryptosigndsaFrame, f : Double) -> CryptosigndsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_frame_add(a : CryptosigndsaFrame, b : CryptosigndsaFrame) -> CryptosigndsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_frame_copy(s : CryptosigndsaFrame) -> CryptosigndsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_frame_fill(s : CryptosigndsaFrame, v : Double) -> CryptosigndsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_frame_min(s : CryptosigndsaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_frame_max(s : CryptosigndsaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_frame_to_string(s : CryptosigndsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_table_make(size : Int) -> CryptosigndsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_table_len(s : CryptosigndsaTable) -> Int { s.size }

pub fn crypto_sign_dsa_table_get(s : CryptosigndsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_table_set(s : CryptosigndsaTable, i : Int, v : Double) -> CryptosigndsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_table_sum(s : CryptosigndsaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_table_mean(s : CryptosigndsaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_table_scale(s : CryptosigndsaTable, f : Double) -> CryptosigndsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_table_add(a : CryptosigndsaTable, b : CryptosigndsaTable) -> CryptosigndsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_table_copy(s : CryptosigndsaTable) -> CryptosigndsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_table_fill(s : CryptosigndsaTable, v : Double) -> CryptosigndsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_table_min(s : CryptosigndsaTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_table_max(s : CryptosigndsaTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_table_to_string(s : CryptosigndsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_graphn_make(size : Int) -> CryptosigndsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_graphn_len(s : CryptosigndsaGraphN) -> Int { s.size }

pub fn crypto_sign_dsa_graphn_get(s : CryptosigndsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_graphn_set(s : CryptosigndsaGraphN, i : Int, v : Double) -> CryptosigndsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_graphn_sum(s : CryptosigndsaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_graphn_mean(s : CryptosigndsaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_graphn_scale(s : CryptosigndsaGraphN, f : Double) -> CryptosigndsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_graphn_add(a : CryptosigndsaGraphN, b : CryptosigndsaGraphN) -> CryptosigndsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_graphn_copy(s : CryptosigndsaGraphN) -> CryptosigndsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_graphn_fill(s : CryptosigndsaGraphN, v : Double) -> CryptosigndsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_graphn_min(s : CryptosigndsaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_graphn_max(s : CryptosigndsaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_graphn_to_string(s : CryptosigndsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_node_make(size : Int) -> CryptosigndsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_node_len(s : CryptosigndsaNode) -> Int { s.size }

pub fn crypto_sign_dsa_node_get(s : CryptosigndsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_node_set(s : CryptosigndsaNode, i : Int, v : Double) -> CryptosigndsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_node_sum(s : CryptosigndsaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_node_mean(s : CryptosigndsaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_node_scale(s : CryptosigndsaNode, f : Double) -> CryptosigndsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_node_add(a : CryptosigndsaNode, b : CryptosigndsaNode) -> CryptosigndsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_node_copy(s : CryptosigndsaNode) -> CryptosigndsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_node_fill(s : CryptosigndsaNode, v : Double) -> CryptosigndsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_node_min(s : CryptosigndsaNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_node_max(s : CryptosigndsaNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_node_to_string(s : CryptosigndsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_edge_make(size : Int) -> CryptosigndsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_edge_len(s : CryptosigndsaEdge) -> Int { s.size }

pub fn crypto_sign_dsa_edge_get(s : CryptosigndsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_edge_set(s : CryptosigndsaEdge, i : Int, v : Double) -> CryptosigndsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_edge_sum(s : CryptosigndsaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_edge_mean(s : CryptosigndsaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_edge_scale(s : CryptosigndsaEdge, f : Double) -> CryptosigndsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_edge_add(a : CryptosigndsaEdge, b : CryptosigndsaEdge) -> CryptosigndsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_edge_copy(s : CryptosigndsaEdge) -> CryptosigndsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_edge_fill(s : CryptosigndsaEdge, v : Double) -> CryptosigndsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_edge_min(s : CryptosigndsaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_edge_max(s : CryptosigndsaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_edge_to_string(s : CryptosigndsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_path_make(size : Int) -> CryptosigndsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_path_len(s : CryptosigndsaPath) -> Int { s.size }

pub fn crypto_sign_dsa_path_get(s : CryptosigndsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_path_set(s : CryptosigndsaPath, i : Int, v : Double) -> CryptosigndsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_path_sum(s : CryptosigndsaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_path_mean(s : CryptosigndsaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_path_scale(s : CryptosigndsaPath, f : Double) -> CryptosigndsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_path_add(a : CryptosigndsaPath, b : CryptosigndsaPath) -> CryptosigndsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_path_copy(s : CryptosigndsaPath) -> CryptosigndsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_path_fill(s : CryptosigndsaPath, v : Double) -> CryptosigndsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_path_min(s : CryptosigndsaPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_path_max(s : CryptosigndsaPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_path_to_string(s : CryptosigndsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_cluster_make(size : Int) -> CryptosigndsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_cluster_len(s : CryptosigndsaCluster) -> Int { s.size }

pub fn crypto_sign_dsa_cluster_get(s : CryptosigndsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_cluster_set(s : CryptosigndsaCluster, i : Int, v : Double) -> CryptosigndsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_cluster_sum(s : CryptosigndsaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_cluster_mean(s : CryptosigndsaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_cluster_scale(s : CryptosigndsaCluster, f : Double) -> CryptosigndsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_cluster_add(a : CryptosigndsaCluster, b : CryptosigndsaCluster) -> CryptosigndsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_cluster_copy(s : CryptosigndsaCluster) -> CryptosigndsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_cluster_fill(s : CryptosigndsaCluster, v : Double) -> CryptosigndsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_cluster_min(s : CryptosigndsaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_cluster_max(s : CryptosigndsaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_cluster_to_string(s : CryptosigndsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_model_make(size : Int) -> CryptosigndsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_model_len(s : CryptosigndsaModel) -> Int { s.size }

pub fn crypto_sign_dsa_model_get(s : CryptosigndsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_model_set(s : CryptosigndsaModel, i : Int, v : Double) -> CryptosigndsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_model_sum(s : CryptosigndsaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_model_mean(s : CryptosigndsaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_model_scale(s : CryptosigndsaModel, f : Double) -> CryptosigndsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_model_add(a : CryptosigndsaModel, b : CryptosigndsaModel) -> CryptosigndsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_model_copy(s : CryptosigndsaModel) -> CryptosigndsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_model_fill(s : CryptosigndsaModel, v : Double) -> CryptosigndsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_model_min(s : CryptosigndsaModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_model_max(s : CryptosigndsaModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_model_to_string(s : CryptosigndsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_layer_make(size : Int) -> CryptosigndsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_layer_len(s : CryptosigndsaLayer) -> Int { s.size }

pub fn crypto_sign_dsa_layer_get(s : CryptosigndsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_layer_set(s : CryptosigndsaLayer, i : Int, v : Double) -> CryptosigndsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_layer_sum(s : CryptosigndsaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_layer_mean(s : CryptosigndsaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_layer_scale(s : CryptosigndsaLayer, f : Double) -> CryptosigndsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_layer_add(a : CryptosigndsaLayer, b : CryptosigndsaLayer) -> CryptosigndsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_layer_copy(s : CryptosigndsaLayer) -> CryptosigndsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_layer_fill(s : CryptosigndsaLayer, v : Double) -> CryptosigndsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_layer_min(s : CryptosigndsaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_layer_max(s : CryptosigndsaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_layer_to_string(s : CryptosigndsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_buffer_make(size : Int) -> CryptosigndsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_buffer_len(s : CryptosigndsaBuffer) -> Int { s.size }

pub fn crypto_sign_dsa_buffer_get(s : CryptosigndsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_buffer_set(s : CryptosigndsaBuffer, i : Int, v : Double) -> CryptosigndsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_buffer_sum(s : CryptosigndsaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_buffer_mean(s : CryptosigndsaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_buffer_scale(s : CryptosigndsaBuffer, f : Double) -> CryptosigndsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_buffer_add(a : CryptosigndsaBuffer, b : CryptosigndsaBuffer) -> CryptosigndsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_buffer_copy(s : CryptosigndsaBuffer) -> CryptosigndsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_buffer_fill(s : CryptosigndsaBuffer, v : Double) -> CryptosigndsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_buffer_min(s : CryptosigndsaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_buffer_max(s : CryptosigndsaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_buffer_to_string(s : CryptosigndsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_cursor_make(size : Int) -> CryptosigndsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_cursor_len(s : CryptosigndsaCursor) -> Int { s.size }

pub fn crypto_sign_dsa_cursor_get(s : CryptosigndsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_cursor_set(s : CryptosigndsaCursor, i : Int, v : Double) -> CryptosigndsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_cursor_sum(s : CryptosigndsaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_cursor_mean(s : CryptosigndsaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_cursor_scale(s : CryptosigndsaCursor, f : Double) -> CryptosigndsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_cursor_add(a : CryptosigndsaCursor, b : CryptosigndsaCursor) -> CryptosigndsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_cursor_copy(s : CryptosigndsaCursor) -> CryptosigndsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_cursor_fill(s : CryptosigndsaCursor, v : Double) -> CryptosigndsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_cursor_min(s : CryptosigndsaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_cursor_max(s : CryptosigndsaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_cursor_to_string(s : CryptosigndsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_view_make(size : Int) -> CryptosigndsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_view_len(s : CryptosigndsaView) -> Int { s.size }

pub fn crypto_sign_dsa_view_get(s : CryptosigndsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_view_set(s : CryptosigndsaView, i : Int, v : Double) -> CryptosigndsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_view_sum(s : CryptosigndsaView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_view_mean(s : CryptosigndsaView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_view_scale(s : CryptosigndsaView, f : Double) -> CryptosigndsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_view_add(a : CryptosigndsaView, b : CryptosigndsaView) -> CryptosigndsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_view_copy(s : CryptosigndsaView) -> CryptosigndsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_view_fill(s : CryptosigndsaView, v : Double) -> CryptosigndsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_view_min(s : CryptosigndsaView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_view_max(s : CryptosigndsaView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_view_to_string(s : CryptosigndsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_range_make(size : Int) -> CryptosigndsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_range_len(s : CryptosigndsaRange) -> Int { s.size }

pub fn crypto_sign_dsa_range_get(s : CryptosigndsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_range_set(s : CryptosigndsaRange, i : Int, v : Double) -> CryptosigndsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_range_sum(s : CryptosigndsaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_range_mean(s : CryptosigndsaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_range_scale(s : CryptosigndsaRange, f : Double) -> CryptosigndsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_range_add(a : CryptosigndsaRange, b : CryptosigndsaRange) -> CryptosigndsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_range_copy(s : CryptosigndsaRange) -> CryptosigndsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_range_fill(s : CryptosigndsaRange, v : Double) -> CryptosigndsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_range_min(s : CryptosigndsaRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_range_max(s : CryptosigndsaRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_range_to_string(s : CryptosigndsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_slice_make(size : Int) -> CryptosigndsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_slice_len(s : CryptosigndsaSlice) -> Int { s.size }

pub fn crypto_sign_dsa_slice_get(s : CryptosigndsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_slice_set(s : CryptosigndsaSlice, i : Int, v : Double) -> CryptosigndsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_slice_sum(s : CryptosigndsaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_dsa_slice_mean(s : CryptosigndsaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_dsa_slice_scale(s : CryptosigndsaSlice, f : Double) -> CryptosigndsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_slice_add(a : CryptosigndsaSlice, b : CryptosigndsaSlice) -> CryptosigndsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_dsa_slice_copy(s : CryptosigndsaSlice) -> CryptosigndsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_slice_fill(s : CryptosigndsaSlice, v : Double) -> CryptosigndsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_dsa_slice_min(s : CryptosigndsaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_dsa_slice_max(s : CryptosigndsaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_dsa_slice_to_string(s : CryptosigndsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

