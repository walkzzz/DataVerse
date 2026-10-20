///===
/// extcore/math_sparse_matrix

pub(all) struct MathsparsematrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_sparse_matrix_make_point(x : Double, y : Double) -> MathsparsematrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_sparse_matrix_make_point3(x : Double, y : Double, z : Double) -> MathsparsematrixPoint {
  { x, y, z, label: 0 }
}

pub fn MathsparsematrixPoint::x(self : MathsparsematrixPoint) -> Double { self.x }

pub fn MathsparsematrixPoint::y(self : MathsparsematrixPoint) -> Double { self.y }

pub fn MathsparsematrixPoint::z(self : MathsparsematrixPoint) -> Double { self.z }

pub fn MathsparsematrixPoint::label(self : MathsparsematrixPoint) -> Int { self.label }

pub fn MathsparsematrixPoint::dist(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathsparsematrixPoint::add(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathsparsematrixPoint::sub(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathsparsematrixPoint::scale(self : MathsparsematrixPoint, s : Double) -> MathsparsematrixPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathsparsematrixPoint::dot(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathsparsematrixPoint::cross(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathsparsematrixPoint::norm(self : MathsparsematrixPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathsparsematrixPoint::normalize(self : MathsparsematrixPoint) -> MathsparsematrixPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathsparsematrixPoint::negate(self : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathsparsematrixPoint::mid(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathsparsematrixPoint::lerp(self : MathsparsematrixPoint, other : MathsparsematrixPoint, t : Double) -> MathsparsematrixPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathsparsematrixPoint::to_string(self : MathsparsematrixPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathsparsematrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_sparse_matrix_make_series(vals : Array[Double], name : String) -> MathsparsematrixSeries {
  { vals, name, meta: 0 }
}

pub fn MathsparsematrixSeries::len(self : MathsparsematrixSeries) -> Int { self.vals.length() }

pub fn MathsparsematrixSeries::sum(self : MathsparsematrixSeries) -> Double { @_common.sum(self.vals) }

pub fn MathsparsematrixSeries::mean(self : MathsparsematrixSeries) -> Double { @_common.mean(self.vals) }

pub fn MathsparsematrixSeries::min(self : MathsparsematrixSeries) -> Double { @_common.min(self.vals) }

pub fn MathsparsematrixSeries::max(self : MathsparsematrixSeries) -> Double { @_common.max(self.vals) }

pub fn MathsparsematrixSeries::range(self : MathsparsematrixSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathsparsematrixSeries::variance(self : MathsparsematrixSeries) -> Double { @_common.variance(self.vals) }

pub fn MathsparsematrixSeries::std(self : MathsparsematrixSeries) -> Double { @_common.std(self.vals) }

pub fn MathsparsematrixSeries::median(self : MathsparsematrixSeries) -> Double { @_common.median(self.vals) }

pub fn MathsparsematrixSeries::scale(self : MathsparsematrixSeries, f : Double) -> MathsparsematrixSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathsparsematrixSeries::add(self : MathsparsematrixSeries, other : MathsparsematrixSeries) -> MathsparsematrixSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathsparsematrixSeries::sub(self : MathsparsematrixSeries, other : MathsparsematrixSeries) -> MathsparsematrixSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathsparsematrixSeries::normalize(self : MathsparsematrixSeries) -> MathsparsematrixSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathsparsematrixSeries::cumsum(self : MathsparsematrixSeries) -> MathsparsematrixSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathsparsematrixSeries::to_string(self : MathsparsematrixSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathsparsematrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_sparse_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> MathsparsematrixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_sparse_matrix_matrix_identity(n : Int) -> MathsparsematrixMatrix {
  let m = math_sparse_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathsparsematrixMatrix::get(self : MathsparsematrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathsparsematrixMatrix::transpose(self : MathsparsematrixMatrix) -> MathsparsematrixMatrix {
  let result = math_sparse_matrix_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathsparsematrixMatrix::add(self : MathsparsematrixMatrix, other : MathsparsematrixMatrix) -> MathsparsematrixMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_sparse_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathsparsematrixMatrix::scale(self : MathsparsematrixMatrix, s : Double) -> MathsparsematrixMatrix {
  let result = math_sparse_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathsparsematrixMatrix::multiply(self : MathsparsematrixMatrix, other : MathsparsematrixMatrix) -> MathsparsematrixMatrix {
  if self.cols != other.rows { return math_sparse_matrix_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_sparse_matrix_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathsparsematrixMatrix::trace(self : MathsparsematrixMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathsparsematrixMatrix::det(self : MathsparsematrixMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathsparsematrixMatrix::norm(self : MathsparsematrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathsparsematrixMatrix::to_string(self : MathsparsematrixMatrix) -> String {
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

pub(all) struct MathsparsematrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_sparse_matrix_make_vector(comps : Array[Double]) -> MathsparsematrixVector {
  { comps, dim: comps.length() }
}

pub fn math_sparse_matrix_vector_zero(dim : Int) -> MathsparsematrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathsparsematrixVector::add(self : MathsparsematrixVector, other : MathsparsematrixVector) -> MathsparsematrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathsparsematrixVector::sub(self : MathsparsematrixVector, other : MathsparsematrixVector) -> MathsparsematrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathsparsematrixVector::scale(self : MathsparsematrixVector, s : Double) -> MathsparsematrixVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathsparsematrixVector::dot(self : MathsparsematrixVector, other : MathsparsematrixVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathsparsematrixVector::norm(self : MathsparsematrixVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathsparsematrixVector::normalize(self : MathsparsematrixVector) -> MathsparsematrixVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathsparsematrixVector::dist(self : MathsparsematrixVector, other : MathsparsematrixVector) -> Double {
  self.sub(other).norm()
}

pub fn MathsparsematrixVector::to_string(self : MathsparsematrixVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_sparse_matrix_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_sparse_matrix_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_sparse_matrix_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_sparse_matrix_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_sparse_matrix_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_sparse_matrix_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_sparse_matrix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_sparse_matrix_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_sparse_matrix_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_sparse_matrix_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_sparse_matrix_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_sparse_matrix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_sparse_matrix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_sparse_matrix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_sparse_matrix_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_sparse_matrix_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_sparse_matrix_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_sparse_matrix_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_sparse_matrix_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_sparse_matrix_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_sparse_matrix_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_sparse_matrix_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_sparse_matrix_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_sparse_matrix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_sparse_matrix_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_sparse_matrix_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_sparse_matrix_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_sparse_matrix_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_sparse_matrix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathsparsematrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_frame_make(size : Int) -> MathsparsematrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_frame_len(s : MathsparsematrixFrame) -> Int { s.size }

pub fn math_sparse_matrix_frame_get(s : MathsparsematrixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_frame_set(s : MathsparsematrixFrame, i : Int, v : Double) -> MathsparsematrixFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_frame_sum(s : MathsparsematrixFrame) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_frame_mean(s : MathsparsematrixFrame) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_frame_scale(s : MathsparsematrixFrame, f : Double) -> MathsparsematrixFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_frame_add(a : MathsparsematrixFrame, b : MathsparsematrixFrame) -> MathsparsematrixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_frame_copy(s : MathsparsematrixFrame) -> MathsparsematrixFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_frame_fill(s : MathsparsematrixFrame, v : Double) -> MathsparsematrixFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_frame_min(s : MathsparsematrixFrame) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_frame_max(s : MathsparsematrixFrame) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_frame_to_string(s : MathsparsematrixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_table_make(size : Int) -> MathsparsematrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_table_len(s : MathsparsematrixTable) -> Int { s.size }

pub fn math_sparse_matrix_table_get(s : MathsparsematrixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_table_set(s : MathsparsematrixTable, i : Int, v : Double) -> MathsparsematrixTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_table_sum(s : MathsparsematrixTable) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_table_mean(s : MathsparsematrixTable) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_table_scale(s : MathsparsematrixTable, f : Double) -> MathsparsematrixTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_table_add(a : MathsparsematrixTable, b : MathsparsematrixTable) -> MathsparsematrixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_table_copy(s : MathsparsematrixTable) -> MathsparsematrixTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_table_fill(s : MathsparsematrixTable, v : Double) -> MathsparsematrixTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_table_min(s : MathsparsematrixTable) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_table_max(s : MathsparsematrixTable) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_table_to_string(s : MathsparsematrixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_graphn_make(size : Int) -> MathsparsematrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_graphn_len(s : MathsparsematrixGraphN) -> Int { s.size }

pub fn math_sparse_matrix_graphn_get(s : MathsparsematrixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_graphn_set(s : MathsparsematrixGraphN, i : Int, v : Double) -> MathsparsematrixGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_graphn_sum(s : MathsparsematrixGraphN) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_graphn_mean(s : MathsparsematrixGraphN) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_graphn_scale(s : MathsparsematrixGraphN, f : Double) -> MathsparsematrixGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_graphn_add(a : MathsparsematrixGraphN, b : MathsparsematrixGraphN) -> MathsparsematrixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_graphn_copy(s : MathsparsematrixGraphN) -> MathsparsematrixGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_graphn_fill(s : MathsparsematrixGraphN, v : Double) -> MathsparsematrixGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_graphn_min(s : MathsparsematrixGraphN) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_graphn_max(s : MathsparsematrixGraphN) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_graphn_to_string(s : MathsparsematrixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_node_make(size : Int) -> MathsparsematrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_node_len(s : MathsparsematrixNode) -> Int { s.size }

pub fn math_sparse_matrix_node_get(s : MathsparsematrixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_node_set(s : MathsparsematrixNode, i : Int, v : Double) -> MathsparsematrixNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_node_sum(s : MathsparsematrixNode) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_node_mean(s : MathsparsematrixNode) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_node_scale(s : MathsparsematrixNode, f : Double) -> MathsparsematrixNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_node_add(a : MathsparsematrixNode, b : MathsparsematrixNode) -> MathsparsematrixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_node_copy(s : MathsparsematrixNode) -> MathsparsematrixNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_node_fill(s : MathsparsematrixNode, v : Double) -> MathsparsematrixNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_node_min(s : MathsparsematrixNode) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_node_max(s : MathsparsematrixNode) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_node_to_string(s : MathsparsematrixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_edge_make(size : Int) -> MathsparsematrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_edge_len(s : MathsparsematrixEdge) -> Int { s.size }

pub fn math_sparse_matrix_edge_get(s : MathsparsematrixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_edge_set(s : MathsparsematrixEdge, i : Int, v : Double) -> MathsparsematrixEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_edge_sum(s : MathsparsematrixEdge) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_edge_mean(s : MathsparsematrixEdge) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_edge_scale(s : MathsparsematrixEdge, f : Double) -> MathsparsematrixEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_edge_add(a : MathsparsematrixEdge, b : MathsparsematrixEdge) -> MathsparsematrixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_edge_copy(s : MathsparsematrixEdge) -> MathsparsematrixEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_edge_fill(s : MathsparsematrixEdge, v : Double) -> MathsparsematrixEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_edge_min(s : MathsparsematrixEdge) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_edge_max(s : MathsparsematrixEdge) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_edge_to_string(s : MathsparsematrixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_path_make(size : Int) -> MathsparsematrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_path_len(s : MathsparsematrixPath) -> Int { s.size }

pub fn math_sparse_matrix_path_get(s : MathsparsematrixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_path_set(s : MathsparsematrixPath, i : Int, v : Double) -> MathsparsematrixPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_path_sum(s : MathsparsematrixPath) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_path_mean(s : MathsparsematrixPath) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_path_scale(s : MathsparsematrixPath, f : Double) -> MathsparsematrixPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_path_add(a : MathsparsematrixPath, b : MathsparsematrixPath) -> MathsparsematrixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_path_copy(s : MathsparsematrixPath) -> MathsparsematrixPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_path_fill(s : MathsparsematrixPath, v : Double) -> MathsparsematrixPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_path_min(s : MathsparsematrixPath) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_path_max(s : MathsparsematrixPath) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_path_to_string(s : MathsparsematrixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_cluster_make(size : Int) -> MathsparsematrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_cluster_len(s : MathsparsematrixCluster) -> Int { s.size }

pub fn math_sparse_matrix_cluster_get(s : MathsparsematrixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_cluster_set(s : MathsparsematrixCluster, i : Int, v : Double) -> MathsparsematrixCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_cluster_sum(s : MathsparsematrixCluster) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_cluster_mean(s : MathsparsematrixCluster) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_cluster_scale(s : MathsparsematrixCluster, f : Double) -> MathsparsematrixCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_cluster_add(a : MathsparsematrixCluster, b : MathsparsematrixCluster) -> MathsparsematrixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_cluster_copy(s : MathsparsematrixCluster) -> MathsparsematrixCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_cluster_fill(s : MathsparsematrixCluster, v : Double) -> MathsparsematrixCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_cluster_min(s : MathsparsematrixCluster) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_cluster_max(s : MathsparsematrixCluster) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_cluster_to_string(s : MathsparsematrixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_model_make(size : Int) -> MathsparsematrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_model_len(s : MathsparsematrixModel) -> Int { s.size }

pub fn math_sparse_matrix_model_get(s : MathsparsematrixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_model_set(s : MathsparsematrixModel, i : Int, v : Double) -> MathsparsematrixModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_model_sum(s : MathsparsematrixModel) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_model_mean(s : MathsparsematrixModel) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_model_scale(s : MathsparsematrixModel, f : Double) -> MathsparsematrixModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_model_add(a : MathsparsematrixModel, b : MathsparsematrixModel) -> MathsparsematrixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_model_copy(s : MathsparsematrixModel) -> MathsparsematrixModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_model_fill(s : MathsparsematrixModel, v : Double) -> MathsparsematrixModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_model_min(s : MathsparsematrixModel) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_model_max(s : MathsparsematrixModel) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_model_to_string(s : MathsparsematrixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_layer_make(size : Int) -> MathsparsematrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_layer_len(s : MathsparsematrixLayer) -> Int { s.size }

pub fn math_sparse_matrix_layer_get(s : MathsparsematrixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_layer_set(s : MathsparsematrixLayer, i : Int, v : Double) -> MathsparsematrixLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_layer_sum(s : MathsparsematrixLayer) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_layer_mean(s : MathsparsematrixLayer) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_layer_scale(s : MathsparsematrixLayer, f : Double) -> MathsparsematrixLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_layer_add(a : MathsparsematrixLayer, b : MathsparsematrixLayer) -> MathsparsematrixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_layer_copy(s : MathsparsematrixLayer) -> MathsparsematrixLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_layer_fill(s : MathsparsematrixLayer, v : Double) -> MathsparsematrixLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_layer_min(s : MathsparsematrixLayer) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_layer_max(s : MathsparsematrixLayer) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_layer_to_string(s : MathsparsematrixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_buffer_make(size : Int) -> MathsparsematrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_buffer_len(s : MathsparsematrixBuffer) -> Int { s.size }

pub fn math_sparse_matrix_buffer_get(s : MathsparsematrixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_buffer_set(s : MathsparsematrixBuffer, i : Int, v : Double) -> MathsparsematrixBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_buffer_sum(s : MathsparsematrixBuffer) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_buffer_mean(s : MathsparsematrixBuffer) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_buffer_scale(s : MathsparsematrixBuffer, f : Double) -> MathsparsematrixBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_buffer_add(a : MathsparsematrixBuffer, b : MathsparsematrixBuffer) -> MathsparsematrixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_buffer_copy(s : MathsparsematrixBuffer) -> MathsparsematrixBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_buffer_fill(s : MathsparsematrixBuffer, v : Double) -> MathsparsematrixBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_buffer_min(s : MathsparsematrixBuffer) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_buffer_max(s : MathsparsematrixBuffer) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_buffer_to_string(s : MathsparsematrixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_cursor_make(size : Int) -> MathsparsematrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_cursor_len(s : MathsparsematrixCursor) -> Int { s.size }

pub fn math_sparse_matrix_cursor_get(s : MathsparsematrixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_cursor_set(s : MathsparsematrixCursor, i : Int, v : Double) -> MathsparsematrixCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_cursor_sum(s : MathsparsematrixCursor) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_cursor_mean(s : MathsparsematrixCursor) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_cursor_scale(s : MathsparsematrixCursor, f : Double) -> MathsparsematrixCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_cursor_add(a : MathsparsematrixCursor, b : MathsparsematrixCursor) -> MathsparsematrixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_cursor_copy(s : MathsparsematrixCursor) -> MathsparsematrixCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_cursor_fill(s : MathsparsematrixCursor, v : Double) -> MathsparsematrixCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_cursor_min(s : MathsparsematrixCursor) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_cursor_max(s : MathsparsematrixCursor) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_cursor_to_string(s : MathsparsematrixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_view_make(size : Int) -> MathsparsematrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_view_len(s : MathsparsematrixView) -> Int { s.size }

pub fn math_sparse_matrix_view_get(s : MathsparsematrixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_view_set(s : MathsparsematrixView, i : Int, v : Double) -> MathsparsematrixView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_view_sum(s : MathsparsematrixView) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_view_mean(s : MathsparsematrixView) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_view_scale(s : MathsparsematrixView, f : Double) -> MathsparsematrixView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_view_add(a : MathsparsematrixView, b : MathsparsematrixView) -> MathsparsematrixView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_view_copy(s : MathsparsematrixView) -> MathsparsematrixView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_view_fill(s : MathsparsematrixView, v : Double) -> MathsparsematrixView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_view_min(s : MathsparsematrixView) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_view_max(s : MathsparsematrixView) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_view_to_string(s : MathsparsematrixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_range_make(size : Int) -> MathsparsematrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_range_len(s : MathsparsematrixRange) -> Int { s.size }

pub fn math_sparse_matrix_range_get(s : MathsparsematrixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_range_set(s : MathsparsematrixRange, i : Int, v : Double) -> MathsparsematrixRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_range_sum(s : MathsparsematrixRange) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_range_mean(s : MathsparsematrixRange) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_range_scale(s : MathsparsematrixRange, f : Double) -> MathsparsematrixRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_range_add(a : MathsparsematrixRange, b : MathsparsematrixRange) -> MathsparsematrixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_range_copy(s : MathsparsematrixRange) -> MathsparsematrixRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_range_fill(s : MathsparsematrixRange, v : Double) -> MathsparsematrixRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_range_min(s : MathsparsematrixRange) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_range_max(s : MathsparsematrixRange) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_range_to_string(s : MathsparsematrixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_slice_make(size : Int) -> MathsparsematrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_slice_len(s : MathsparsematrixSlice) -> Int { s.size }

pub fn math_sparse_matrix_slice_get(s : MathsparsematrixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_slice_set(s : MathsparsematrixSlice, i : Int, v : Double) -> MathsparsematrixSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_slice_sum(s : MathsparsematrixSlice) -> Double { @_common.sum(s.data) }

pub fn math_sparse_matrix_slice_mean(s : MathsparsematrixSlice) -> Double { @_common.mean(s.data) }

pub fn math_sparse_matrix_slice_scale(s : MathsparsematrixSlice, f : Double) -> MathsparsematrixSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_slice_add(a : MathsparsematrixSlice, b : MathsparsematrixSlice) -> MathsparsematrixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_sparse_matrix_slice_copy(s : MathsparsematrixSlice) -> MathsparsematrixSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_slice_fill(s : MathsparsematrixSlice, v : Double) -> MathsparsematrixSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_sparse_matrix_slice_min(s : MathsparsematrixSlice) -> Double { @_common.min(s.data) }

pub fn math_sparse_matrix_slice_max(s : MathsparsematrixSlice) -> Double { @_common.max(s.data) }

pub fn math_sparse_matrix_slice_to_string(s : MathsparsematrixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

