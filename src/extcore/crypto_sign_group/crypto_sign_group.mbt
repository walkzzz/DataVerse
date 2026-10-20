///===
/// extcore/crypto_sign_group

pub(all) struct CryptosigngroupPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_group_make_point(x : Double, y : Double) -> CryptosigngroupPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_group_make_point3(x : Double, y : Double, z : Double) -> CryptosigngroupPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosigngroupPoint::x(self : CryptosigngroupPoint) -> Double { self.x }

pub fn CryptosigngroupPoint::y(self : CryptosigngroupPoint) -> Double { self.y }

pub fn CryptosigngroupPoint::z(self : CryptosigngroupPoint) -> Double { self.z }

pub fn CryptosigngroupPoint::label(self : CryptosigngroupPoint) -> Int { self.label }

pub fn CryptosigngroupPoint::dist(self : CryptosigngroupPoint, other : CryptosigngroupPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosigngroupPoint::add(self : CryptosigngroupPoint, other : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosigngroupPoint::sub(self : CryptosigngroupPoint, other : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosigngroupPoint::scale(self : CryptosigngroupPoint, s : Double) -> CryptosigngroupPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosigngroupPoint::dot(self : CryptosigngroupPoint, other : CryptosigngroupPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosigngroupPoint::cross(self : CryptosigngroupPoint, other : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosigngroupPoint::norm(self : CryptosigngroupPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosigngroupPoint::normalize(self : CryptosigngroupPoint) -> CryptosigngroupPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigngroupPoint::negate(self : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosigngroupPoint::mid(self : CryptosigngroupPoint, other : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosigngroupPoint::lerp(self : CryptosigngroupPoint, other : CryptosigngroupPoint, t : Double) -> CryptosigngroupPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosigngroupPoint::to_string(self : CryptosigngroupPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosigngroupSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_group_make_series(vals : Array[Double], name : String) -> CryptosigngroupSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosigngroupSeries::len(self : CryptosigngroupSeries) -> Int { self.vals.length() }

pub fn CryptosigngroupSeries::sum(self : CryptosigngroupSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosigngroupSeries::mean(self : CryptosigngroupSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosigngroupSeries::min(self : CryptosigngroupSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosigngroupSeries::max(self : CryptosigngroupSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosigngroupSeries::range(self : CryptosigngroupSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosigngroupSeries::variance(self : CryptosigngroupSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosigngroupSeries::std(self : CryptosigngroupSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosigngroupSeries::median(self : CryptosigngroupSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosigngroupSeries::scale(self : CryptosigngroupSeries, f : Double) -> CryptosigngroupSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosigngroupSeries::add(self : CryptosigngroupSeries, other : CryptosigngroupSeries) -> CryptosigngroupSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosigngroupSeries::sub(self : CryptosigngroupSeries, other : CryptosigngroupSeries) -> CryptosigngroupSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosigngroupSeries::normalize(self : CryptosigngroupSeries) -> CryptosigngroupSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosigngroupSeries::cumsum(self : CryptosigngroupSeries) -> CryptosigngroupSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosigngroupSeries::to_string(self : CryptosigngroupSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigngroupMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_group_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosigngroupMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_group_matrix_identity(n : Int) -> CryptosigngroupMatrix {
  let m = crypto_sign_group_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosigngroupMatrix::get(self : CryptosigngroupMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosigngroupMatrix::transpose(self : CryptosigngroupMatrix) -> CryptosigngroupMatrix {
  let result = crypto_sign_group_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosigngroupMatrix::add(self : CryptosigngroupMatrix, other : CryptosigngroupMatrix) -> CryptosigngroupMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_group_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosigngroupMatrix::scale(self : CryptosigngroupMatrix, s : Double) -> CryptosigngroupMatrix {
  let result = crypto_sign_group_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosigngroupMatrix::multiply(self : CryptosigngroupMatrix, other : CryptosigngroupMatrix) -> CryptosigngroupMatrix {
  if self.cols != other.rows { return crypto_sign_group_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_group_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosigngroupMatrix::trace(self : CryptosigngroupMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosigngroupMatrix::det(self : CryptosigngroupMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosigngroupMatrix::norm(self : CryptosigngroupMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosigngroupMatrix::to_string(self : CryptosigngroupMatrix) -> String {
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

pub(all) struct CryptosigngroupVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_group_make_vector(comps : Array[Double]) -> CryptosigngroupVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_group_vector_zero(dim : Int) -> CryptosigngroupVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosigngroupVector::add(self : CryptosigngroupVector, other : CryptosigngroupVector) -> CryptosigngroupVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigngroupVector::sub(self : CryptosigngroupVector, other : CryptosigngroupVector) -> CryptosigngroupVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigngroupVector::scale(self : CryptosigngroupVector, s : Double) -> CryptosigngroupVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosigngroupVector::dot(self : CryptosigngroupVector, other : CryptosigngroupVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosigngroupVector::norm(self : CryptosigngroupVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosigngroupVector::normalize(self : CryptosigngroupVector) -> CryptosigngroupVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigngroupVector::dist(self : CryptosigngroupVector, other : CryptosigngroupVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosigngroupVector::to_string(self : CryptosigngroupVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_group_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_group_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_group_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_group_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_group_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_group_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_group_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_group_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_group_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_group_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_group_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_group_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_group_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_group_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_group_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_group_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_group_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_group_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_group_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_group_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_group_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_group_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_group_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_group_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_group_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_group_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_group_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_group_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_group_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosigngroupFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_frame_make(size : Int) -> CryptosigngroupFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_frame_len(s : CryptosigngroupFrame) -> Int { s.size }

pub fn crypto_sign_group_frame_get(s : CryptosigngroupFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_frame_set(s : CryptosigngroupFrame, i : Int, v : Double) -> CryptosigngroupFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_frame_sum(s : CryptosigngroupFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_frame_mean(s : CryptosigngroupFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_frame_scale(s : CryptosigngroupFrame, f : Double) -> CryptosigngroupFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_frame_add(a : CryptosigngroupFrame, b : CryptosigngroupFrame) -> CryptosigngroupFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_frame_copy(s : CryptosigngroupFrame) -> CryptosigngroupFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_frame_fill(s : CryptosigngroupFrame, v : Double) -> CryptosigngroupFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_frame_min(s : CryptosigngroupFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_frame_max(s : CryptosigngroupFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_frame_to_string(s : CryptosigngroupFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_table_make(size : Int) -> CryptosigngroupTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_table_len(s : CryptosigngroupTable) -> Int { s.size }

pub fn crypto_sign_group_table_get(s : CryptosigngroupTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_table_set(s : CryptosigngroupTable, i : Int, v : Double) -> CryptosigngroupTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_table_sum(s : CryptosigngroupTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_table_mean(s : CryptosigngroupTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_table_scale(s : CryptosigngroupTable, f : Double) -> CryptosigngroupTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_table_add(a : CryptosigngroupTable, b : CryptosigngroupTable) -> CryptosigngroupTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_table_copy(s : CryptosigngroupTable) -> CryptosigngroupTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_table_fill(s : CryptosigngroupTable, v : Double) -> CryptosigngroupTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_table_min(s : CryptosigngroupTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_table_max(s : CryptosigngroupTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_table_to_string(s : CryptosigngroupTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_graphn_make(size : Int) -> CryptosigngroupGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_graphn_len(s : CryptosigngroupGraphN) -> Int { s.size }

pub fn crypto_sign_group_graphn_get(s : CryptosigngroupGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_graphn_set(s : CryptosigngroupGraphN, i : Int, v : Double) -> CryptosigngroupGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_graphn_sum(s : CryptosigngroupGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_graphn_mean(s : CryptosigngroupGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_graphn_scale(s : CryptosigngroupGraphN, f : Double) -> CryptosigngroupGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_graphn_add(a : CryptosigngroupGraphN, b : CryptosigngroupGraphN) -> CryptosigngroupGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_graphn_copy(s : CryptosigngroupGraphN) -> CryptosigngroupGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_graphn_fill(s : CryptosigngroupGraphN, v : Double) -> CryptosigngroupGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_graphn_min(s : CryptosigngroupGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_graphn_max(s : CryptosigngroupGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_graphn_to_string(s : CryptosigngroupGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_node_make(size : Int) -> CryptosigngroupNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_node_len(s : CryptosigngroupNode) -> Int { s.size }

pub fn crypto_sign_group_node_get(s : CryptosigngroupNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_node_set(s : CryptosigngroupNode, i : Int, v : Double) -> CryptosigngroupNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_node_sum(s : CryptosigngroupNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_node_mean(s : CryptosigngroupNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_node_scale(s : CryptosigngroupNode, f : Double) -> CryptosigngroupNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_node_add(a : CryptosigngroupNode, b : CryptosigngroupNode) -> CryptosigngroupNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_node_copy(s : CryptosigngroupNode) -> CryptosigngroupNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_node_fill(s : CryptosigngroupNode, v : Double) -> CryptosigngroupNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_node_min(s : CryptosigngroupNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_node_max(s : CryptosigngroupNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_node_to_string(s : CryptosigngroupNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_edge_make(size : Int) -> CryptosigngroupEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_edge_len(s : CryptosigngroupEdge) -> Int { s.size }

pub fn crypto_sign_group_edge_get(s : CryptosigngroupEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_edge_set(s : CryptosigngroupEdge, i : Int, v : Double) -> CryptosigngroupEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_edge_sum(s : CryptosigngroupEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_edge_mean(s : CryptosigngroupEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_edge_scale(s : CryptosigngroupEdge, f : Double) -> CryptosigngroupEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_edge_add(a : CryptosigngroupEdge, b : CryptosigngroupEdge) -> CryptosigngroupEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_edge_copy(s : CryptosigngroupEdge) -> CryptosigngroupEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_edge_fill(s : CryptosigngroupEdge, v : Double) -> CryptosigngroupEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_edge_min(s : CryptosigngroupEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_edge_max(s : CryptosigngroupEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_edge_to_string(s : CryptosigngroupEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_path_make(size : Int) -> CryptosigngroupPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_path_len(s : CryptosigngroupPath) -> Int { s.size }

pub fn crypto_sign_group_path_get(s : CryptosigngroupPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_path_set(s : CryptosigngroupPath, i : Int, v : Double) -> CryptosigngroupPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_path_sum(s : CryptosigngroupPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_path_mean(s : CryptosigngroupPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_path_scale(s : CryptosigngroupPath, f : Double) -> CryptosigngroupPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_path_add(a : CryptosigngroupPath, b : CryptosigngroupPath) -> CryptosigngroupPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_path_copy(s : CryptosigngroupPath) -> CryptosigngroupPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_path_fill(s : CryptosigngroupPath, v : Double) -> CryptosigngroupPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_path_min(s : CryptosigngroupPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_path_max(s : CryptosigngroupPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_path_to_string(s : CryptosigngroupPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_cluster_make(size : Int) -> CryptosigngroupCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_cluster_len(s : CryptosigngroupCluster) -> Int { s.size }

pub fn crypto_sign_group_cluster_get(s : CryptosigngroupCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_cluster_set(s : CryptosigngroupCluster, i : Int, v : Double) -> CryptosigngroupCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cluster_sum(s : CryptosigngroupCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_cluster_mean(s : CryptosigngroupCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_cluster_scale(s : CryptosigngroupCluster, f : Double) -> CryptosigngroupCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cluster_add(a : CryptosigngroupCluster, b : CryptosigngroupCluster) -> CryptosigngroupCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_cluster_copy(s : CryptosigngroupCluster) -> CryptosigngroupCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cluster_fill(s : CryptosigngroupCluster, v : Double) -> CryptosigngroupCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cluster_min(s : CryptosigngroupCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_cluster_max(s : CryptosigngroupCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_cluster_to_string(s : CryptosigngroupCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_model_make(size : Int) -> CryptosigngroupModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_model_len(s : CryptosigngroupModel) -> Int { s.size }

pub fn crypto_sign_group_model_get(s : CryptosigngroupModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_model_set(s : CryptosigngroupModel, i : Int, v : Double) -> CryptosigngroupModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_model_sum(s : CryptosigngroupModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_model_mean(s : CryptosigngroupModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_model_scale(s : CryptosigngroupModel, f : Double) -> CryptosigngroupModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_model_add(a : CryptosigngroupModel, b : CryptosigngroupModel) -> CryptosigngroupModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_model_copy(s : CryptosigngroupModel) -> CryptosigngroupModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_model_fill(s : CryptosigngroupModel, v : Double) -> CryptosigngroupModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_model_min(s : CryptosigngroupModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_model_max(s : CryptosigngroupModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_model_to_string(s : CryptosigngroupModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_layer_make(size : Int) -> CryptosigngroupLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_layer_len(s : CryptosigngroupLayer) -> Int { s.size }

pub fn crypto_sign_group_layer_get(s : CryptosigngroupLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_layer_set(s : CryptosigngroupLayer, i : Int, v : Double) -> CryptosigngroupLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_layer_sum(s : CryptosigngroupLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_layer_mean(s : CryptosigngroupLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_layer_scale(s : CryptosigngroupLayer, f : Double) -> CryptosigngroupLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_layer_add(a : CryptosigngroupLayer, b : CryptosigngroupLayer) -> CryptosigngroupLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_layer_copy(s : CryptosigngroupLayer) -> CryptosigngroupLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_layer_fill(s : CryptosigngroupLayer, v : Double) -> CryptosigngroupLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_layer_min(s : CryptosigngroupLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_layer_max(s : CryptosigngroupLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_layer_to_string(s : CryptosigngroupLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_buffer_make(size : Int) -> CryptosigngroupBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_buffer_len(s : CryptosigngroupBuffer) -> Int { s.size }

pub fn crypto_sign_group_buffer_get(s : CryptosigngroupBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_buffer_set(s : CryptosigngroupBuffer, i : Int, v : Double) -> CryptosigngroupBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_buffer_sum(s : CryptosigngroupBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_buffer_mean(s : CryptosigngroupBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_buffer_scale(s : CryptosigngroupBuffer, f : Double) -> CryptosigngroupBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_buffer_add(a : CryptosigngroupBuffer, b : CryptosigngroupBuffer) -> CryptosigngroupBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_buffer_copy(s : CryptosigngroupBuffer) -> CryptosigngroupBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_buffer_fill(s : CryptosigngroupBuffer, v : Double) -> CryptosigngroupBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_buffer_min(s : CryptosigngroupBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_buffer_max(s : CryptosigngroupBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_buffer_to_string(s : CryptosigngroupBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_cursor_make(size : Int) -> CryptosigngroupCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_cursor_len(s : CryptosigngroupCursor) -> Int { s.size }

pub fn crypto_sign_group_cursor_get(s : CryptosigngroupCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_cursor_set(s : CryptosigngroupCursor, i : Int, v : Double) -> CryptosigngroupCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cursor_sum(s : CryptosigngroupCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_cursor_mean(s : CryptosigngroupCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_cursor_scale(s : CryptosigngroupCursor, f : Double) -> CryptosigngroupCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cursor_add(a : CryptosigngroupCursor, b : CryptosigngroupCursor) -> CryptosigngroupCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_cursor_copy(s : CryptosigngroupCursor) -> CryptosigngroupCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cursor_fill(s : CryptosigngroupCursor, v : Double) -> CryptosigngroupCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cursor_min(s : CryptosigngroupCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_cursor_max(s : CryptosigngroupCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_cursor_to_string(s : CryptosigngroupCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_view_make(size : Int) -> CryptosigngroupView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_view_len(s : CryptosigngroupView) -> Int { s.size }

pub fn crypto_sign_group_view_get(s : CryptosigngroupView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_view_set(s : CryptosigngroupView, i : Int, v : Double) -> CryptosigngroupView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_view_sum(s : CryptosigngroupView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_view_mean(s : CryptosigngroupView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_view_scale(s : CryptosigngroupView, f : Double) -> CryptosigngroupView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_view_add(a : CryptosigngroupView, b : CryptosigngroupView) -> CryptosigngroupView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_view_copy(s : CryptosigngroupView) -> CryptosigngroupView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_view_fill(s : CryptosigngroupView, v : Double) -> CryptosigngroupView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_view_min(s : CryptosigngroupView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_view_max(s : CryptosigngroupView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_view_to_string(s : CryptosigngroupView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_range_make(size : Int) -> CryptosigngroupRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_range_len(s : CryptosigngroupRange) -> Int { s.size }

pub fn crypto_sign_group_range_get(s : CryptosigngroupRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_range_set(s : CryptosigngroupRange, i : Int, v : Double) -> CryptosigngroupRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_range_sum(s : CryptosigngroupRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_range_mean(s : CryptosigngroupRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_range_scale(s : CryptosigngroupRange, f : Double) -> CryptosigngroupRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_range_add(a : CryptosigngroupRange, b : CryptosigngroupRange) -> CryptosigngroupRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_range_copy(s : CryptosigngroupRange) -> CryptosigngroupRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_range_fill(s : CryptosigngroupRange, v : Double) -> CryptosigngroupRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_range_min(s : CryptosigngroupRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_range_max(s : CryptosigngroupRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_range_to_string(s : CryptosigngroupRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_slice_make(size : Int) -> CryptosigngroupSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_slice_len(s : CryptosigngroupSlice) -> Int { s.size }

pub fn crypto_sign_group_slice_get(s : CryptosigngroupSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_slice_set(s : CryptosigngroupSlice, i : Int, v : Double) -> CryptosigngroupSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_slice_sum(s : CryptosigngroupSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_slice_mean(s : CryptosigngroupSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_slice_scale(s : CryptosigngroupSlice, f : Double) -> CryptosigngroupSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_slice_add(a : CryptosigngroupSlice, b : CryptosigngroupSlice) -> CryptosigngroupSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_slice_copy(s : CryptosigngroupSlice) -> CryptosigngroupSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_slice_fill(s : CryptosigngroupSlice, v : Double) -> CryptosigngroupSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_slice_min(s : CryptosigngroupSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_slice_max(s : CryptosigngroupSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_slice_to_string(s : CryptosigngroupSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

