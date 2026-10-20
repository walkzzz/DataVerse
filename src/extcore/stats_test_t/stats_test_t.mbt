///===
/// extcore/stats_test_t

pub(all) struct StatstesttPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_t_make_point(x : Double, y : Double) -> StatstesttPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_t_make_point3(x : Double, y : Double, z : Double) -> StatstesttPoint {
  { x, y, z, label: 0 }
}

pub fn StatstesttPoint::x(self : StatstesttPoint) -> Double { self.x }

pub fn StatstesttPoint::y(self : StatstesttPoint) -> Double { self.y }

pub fn StatstesttPoint::z(self : StatstesttPoint) -> Double { self.z }

pub fn StatstesttPoint::label(self : StatstesttPoint) -> Int { self.label }

pub fn StatstesttPoint::dist(self : StatstesttPoint, other : StatstesttPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstesttPoint::add(self : StatstesttPoint, other : StatstesttPoint) -> StatstesttPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstesttPoint::sub(self : StatstesttPoint, other : StatstesttPoint) -> StatstesttPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstesttPoint::scale(self : StatstesttPoint, s : Double) -> StatstesttPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstesttPoint::dot(self : StatstesttPoint, other : StatstesttPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstesttPoint::cross(self : StatstesttPoint, other : StatstesttPoint) -> StatstesttPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstesttPoint::norm(self : StatstesttPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstesttPoint::normalize(self : StatstesttPoint) -> StatstesttPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstesttPoint::negate(self : StatstesttPoint) -> StatstesttPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstesttPoint::mid(self : StatstesttPoint, other : StatstesttPoint) -> StatstesttPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstesttPoint::lerp(self : StatstesttPoint, other : StatstesttPoint, t : Double) -> StatstesttPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstesttPoint::to_string(self : StatstesttPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstesttSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_t_make_series(vals : Array[Double], name : String) -> StatstesttSeries {
  { vals, name, meta: 0 }
}

pub fn StatstesttSeries::len(self : StatstesttSeries) -> Int { self.vals.length() }

pub fn StatstesttSeries::sum(self : StatstesttSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstesttSeries::mean(self : StatstesttSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstesttSeries::min(self : StatstesttSeries) -> Double { @_common.min(self.vals) }

pub fn StatstesttSeries::max(self : StatstesttSeries) -> Double { @_common.max(self.vals) }

pub fn StatstesttSeries::range(self : StatstesttSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstesttSeries::variance(self : StatstesttSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstesttSeries::std(self : StatstesttSeries) -> Double { @_common.std(self.vals) }

pub fn StatstesttSeries::median(self : StatstesttSeries) -> Double { @_common.median(self.vals) }

pub fn StatstesttSeries::scale(self : StatstesttSeries, f : Double) -> StatstesttSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstesttSeries::add(self : StatstesttSeries, other : StatstesttSeries) -> StatstesttSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstesttSeries::sub(self : StatstesttSeries, other : StatstesttSeries) -> StatstesttSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstesttSeries::normalize(self : StatstesttSeries) -> StatstesttSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstesttSeries::cumsum(self : StatstesttSeries) -> StatstesttSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstesttSeries::to_string(self : StatstesttSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstesttMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_t_make_matrix(rows : Int, cols : Int, val : Double) -> StatstesttMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_t_matrix_identity(n : Int) -> StatstesttMatrix {
  let m = stats_test_t_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstesttMatrix::get(self : StatstesttMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstesttMatrix::transpose(self : StatstesttMatrix) -> StatstesttMatrix {
  let result = stats_test_t_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstesttMatrix::add(self : StatstesttMatrix, other : StatstesttMatrix) -> StatstesttMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_t_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstesttMatrix::scale(self : StatstesttMatrix, s : Double) -> StatstesttMatrix {
  let result = stats_test_t_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstesttMatrix::multiply(self : StatstesttMatrix, other : StatstesttMatrix) -> StatstesttMatrix {
  if self.cols != other.rows { return stats_test_t_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_t_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatstesttMatrix::trace(self : StatstesttMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstesttMatrix::det(self : StatstesttMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstesttMatrix::norm(self : StatstesttMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstesttMatrix::to_string(self : StatstesttMatrix) -> String {
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

pub(all) struct StatstesttVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_t_make_vector(comps : Array[Double]) -> StatstesttVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_t_vector_zero(dim : Int) -> StatstesttVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstesttVector::add(self : StatstesttVector, other : StatstesttVector) -> StatstesttVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstesttVector::sub(self : StatstesttVector, other : StatstesttVector) -> StatstesttVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstesttVector::scale(self : StatstesttVector, s : Double) -> StatstesttVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstesttVector::dot(self : StatstesttVector, other : StatstesttVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstesttVector::norm(self : StatstesttVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstesttVector::normalize(self : StatstesttVector) -> StatstesttVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstesttVector::dist(self : StatstesttVector, other : StatstesttVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstesttVector::to_string(self : StatstesttVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_t_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_t_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_t_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_t_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_t_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_t_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_t_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_t_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_t_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_t_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_t_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_t_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_t_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_t_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_t_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_t_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_t_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_t_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_t_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_t_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_t_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_t_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_t_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_t_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_t_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_t_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_t_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_t_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_t_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstesttFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_frame_make(size : Int) -> StatstesttFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_frame_len(s : StatstesttFrame) -> Int { s.size }

pub fn stats_test_t_frame_get(s : StatstesttFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_frame_set(s : StatstesttFrame, i : Int, v : Double) -> StatstesttFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_frame_sum(s : StatstesttFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_frame_mean(s : StatstesttFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_frame_scale(s : StatstesttFrame, f : Double) -> StatstesttFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_frame_add(a : StatstesttFrame, b : StatstesttFrame) -> StatstesttFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_frame_copy(s : StatstesttFrame) -> StatstesttFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_frame_fill(s : StatstesttFrame, v : Double) -> StatstesttFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_frame_min(s : StatstesttFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_t_frame_max(s : StatstesttFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_t_frame_to_string(s : StatstesttFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_table_make(size : Int) -> StatstesttTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_table_len(s : StatstesttTable) -> Int { s.size }

pub fn stats_test_t_table_get(s : StatstesttTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_table_set(s : StatstesttTable, i : Int, v : Double) -> StatstesttTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_table_sum(s : StatstesttTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_table_mean(s : StatstesttTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_table_scale(s : StatstesttTable, f : Double) -> StatstesttTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_table_add(a : StatstesttTable, b : StatstesttTable) -> StatstesttTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_table_copy(s : StatstesttTable) -> StatstesttTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_table_fill(s : StatstesttTable, v : Double) -> StatstesttTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_table_min(s : StatstesttTable) -> Double { @_common.min(s.data) }

pub fn stats_test_t_table_max(s : StatstesttTable) -> Double { @_common.max(s.data) }

pub fn stats_test_t_table_to_string(s : StatstesttTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_graphn_make(size : Int) -> StatstesttGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_graphn_len(s : StatstesttGraphN) -> Int { s.size }

pub fn stats_test_t_graphn_get(s : StatstesttGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_graphn_set(s : StatstesttGraphN, i : Int, v : Double) -> StatstesttGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_graphn_sum(s : StatstesttGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_graphn_mean(s : StatstesttGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_graphn_scale(s : StatstesttGraphN, f : Double) -> StatstesttGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_graphn_add(a : StatstesttGraphN, b : StatstesttGraphN) -> StatstesttGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_graphn_copy(s : StatstesttGraphN) -> StatstesttGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_graphn_fill(s : StatstesttGraphN, v : Double) -> StatstesttGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_graphn_min(s : StatstesttGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_t_graphn_max(s : StatstesttGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_t_graphn_to_string(s : StatstesttGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_node_make(size : Int) -> StatstesttNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_node_len(s : StatstesttNode) -> Int { s.size }

pub fn stats_test_t_node_get(s : StatstesttNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_node_set(s : StatstesttNode, i : Int, v : Double) -> StatstesttNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_node_sum(s : StatstesttNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_node_mean(s : StatstesttNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_node_scale(s : StatstesttNode, f : Double) -> StatstesttNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_node_add(a : StatstesttNode, b : StatstesttNode) -> StatstesttNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_node_copy(s : StatstesttNode) -> StatstesttNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_node_fill(s : StatstesttNode, v : Double) -> StatstesttNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_node_min(s : StatstesttNode) -> Double { @_common.min(s.data) }

pub fn stats_test_t_node_max(s : StatstesttNode) -> Double { @_common.max(s.data) }

pub fn stats_test_t_node_to_string(s : StatstesttNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_edge_make(size : Int) -> StatstesttEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_edge_len(s : StatstesttEdge) -> Int { s.size }

pub fn stats_test_t_edge_get(s : StatstesttEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_edge_set(s : StatstesttEdge, i : Int, v : Double) -> StatstesttEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_edge_sum(s : StatstesttEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_edge_mean(s : StatstesttEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_edge_scale(s : StatstesttEdge, f : Double) -> StatstesttEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_edge_add(a : StatstesttEdge, b : StatstesttEdge) -> StatstesttEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_edge_copy(s : StatstesttEdge) -> StatstesttEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_edge_fill(s : StatstesttEdge, v : Double) -> StatstesttEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_edge_min(s : StatstesttEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_t_edge_max(s : StatstesttEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_t_edge_to_string(s : StatstesttEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_path_make(size : Int) -> StatstesttPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_path_len(s : StatstesttPath) -> Int { s.size }

pub fn stats_test_t_path_get(s : StatstesttPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_path_set(s : StatstesttPath, i : Int, v : Double) -> StatstesttPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_path_sum(s : StatstesttPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_path_mean(s : StatstesttPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_path_scale(s : StatstesttPath, f : Double) -> StatstesttPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_path_add(a : StatstesttPath, b : StatstesttPath) -> StatstesttPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_path_copy(s : StatstesttPath) -> StatstesttPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_path_fill(s : StatstesttPath, v : Double) -> StatstesttPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_path_min(s : StatstesttPath) -> Double { @_common.min(s.data) }

pub fn stats_test_t_path_max(s : StatstesttPath) -> Double { @_common.max(s.data) }

pub fn stats_test_t_path_to_string(s : StatstesttPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_cluster_make(size : Int) -> StatstesttCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_cluster_len(s : StatstesttCluster) -> Int { s.size }

pub fn stats_test_t_cluster_get(s : StatstesttCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_cluster_set(s : StatstesttCluster, i : Int, v : Double) -> StatstesttCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_cluster_sum(s : StatstesttCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_cluster_mean(s : StatstesttCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_cluster_scale(s : StatstesttCluster, f : Double) -> StatstesttCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_cluster_add(a : StatstesttCluster, b : StatstesttCluster) -> StatstesttCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_cluster_copy(s : StatstesttCluster) -> StatstesttCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_cluster_fill(s : StatstesttCluster, v : Double) -> StatstesttCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_cluster_min(s : StatstesttCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_t_cluster_max(s : StatstesttCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_t_cluster_to_string(s : StatstesttCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_model_make(size : Int) -> StatstesttModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_model_len(s : StatstesttModel) -> Int { s.size }

pub fn stats_test_t_model_get(s : StatstesttModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_model_set(s : StatstesttModel, i : Int, v : Double) -> StatstesttModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_model_sum(s : StatstesttModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_model_mean(s : StatstesttModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_model_scale(s : StatstesttModel, f : Double) -> StatstesttModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_model_add(a : StatstesttModel, b : StatstesttModel) -> StatstesttModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_model_copy(s : StatstesttModel) -> StatstesttModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_model_fill(s : StatstesttModel, v : Double) -> StatstesttModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_model_min(s : StatstesttModel) -> Double { @_common.min(s.data) }

pub fn stats_test_t_model_max(s : StatstesttModel) -> Double { @_common.max(s.data) }

pub fn stats_test_t_model_to_string(s : StatstesttModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_layer_make(size : Int) -> StatstesttLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_layer_len(s : StatstesttLayer) -> Int { s.size }

pub fn stats_test_t_layer_get(s : StatstesttLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_layer_set(s : StatstesttLayer, i : Int, v : Double) -> StatstesttLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_layer_sum(s : StatstesttLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_layer_mean(s : StatstesttLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_layer_scale(s : StatstesttLayer, f : Double) -> StatstesttLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_layer_add(a : StatstesttLayer, b : StatstesttLayer) -> StatstesttLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_layer_copy(s : StatstesttLayer) -> StatstesttLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_layer_fill(s : StatstesttLayer, v : Double) -> StatstesttLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_layer_min(s : StatstesttLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_t_layer_max(s : StatstesttLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_t_layer_to_string(s : StatstesttLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_buffer_make(size : Int) -> StatstesttBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_buffer_len(s : StatstesttBuffer) -> Int { s.size }

pub fn stats_test_t_buffer_get(s : StatstesttBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_buffer_set(s : StatstesttBuffer, i : Int, v : Double) -> StatstesttBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_buffer_sum(s : StatstesttBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_buffer_mean(s : StatstesttBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_buffer_scale(s : StatstesttBuffer, f : Double) -> StatstesttBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_buffer_add(a : StatstesttBuffer, b : StatstesttBuffer) -> StatstesttBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_buffer_copy(s : StatstesttBuffer) -> StatstesttBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_buffer_fill(s : StatstesttBuffer, v : Double) -> StatstesttBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_buffer_min(s : StatstesttBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_t_buffer_max(s : StatstesttBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_t_buffer_to_string(s : StatstesttBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_cursor_make(size : Int) -> StatstesttCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_cursor_len(s : StatstesttCursor) -> Int { s.size }

pub fn stats_test_t_cursor_get(s : StatstesttCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_cursor_set(s : StatstesttCursor, i : Int, v : Double) -> StatstesttCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_cursor_sum(s : StatstesttCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_cursor_mean(s : StatstesttCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_cursor_scale(s : StatstesttCursor, f : Double) -> StatstesttCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_cursor_add(a : StatstesttCursor, b : StatstesttCursor) -> StatstesttCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_cursor_copy(s : StatstesttCursor) -> StatstesttCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_cursor_fill(s : StatstesttCursor, v : Double) -> StatstesttCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_cursor_min(s : StatstesttCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_t_cursor_max(s : StatstesttCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_t_cursor_to_string(s : StatstesttCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_view_make(size : Int) -> StatstesttView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_view_len(s : StatstesttView) -> Int { s.size }

pub fn stats_test_t_view_get(s : StatstesttView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_view_set(s : StatstesttView, i : Int, v : Double) -> StatstesttView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_view_sum(s : StatstesttView) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_view_mean(s : StatstesttView) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_view_scale(s : StatstesttView, f : Double) -> StatstesttView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_view_add(a : StatstesttView, b : StatstesttView) -> StatstesttView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_view_copy(s : StatstesttView) -> StatstesttView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_view_fill(s : StatstesttView, v : Double) -> StatstesttView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_view_min(s : StatstesttView) -> Double { @_common.min(s.data) }

pub fn stats_test_t_view_max(s : StatstesttView) -> Double { @_common.max(s.data) }

pub fn stats_test_t_view_to_string(s : StatstesttView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_range_make(size : Int) -> StatstesttRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_range_len(s : StatstesttRange) -> Int { s.size }

pub fn stats_test_t_range_get(s : StatstesttRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_range_set(s : StatstesttRange, i : Int, v : Double) -> StatstesttRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_range_sum(s : StatstesttRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_range_mean(s : StatstesttRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_range_scale(s : StatstesttRange, f : Double) -> StatstesttRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_range_add(a : StatstesttRange, b : StatstesttRange) -> StatstesttRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_range_copy(s : StatstesttRange) -> StatstesttRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_range_fill(s : StatstesttRange, v : Double) -> StatstesttRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_range_min(s : StatstesttRange) -> Double { @_common.min(s.data) }

pub fn stats_test_t_range_max(s : StatstesttRange) -> Double { @_common.max(s.data) }

pub fn stats_test_t_range_to_string(s : StatstesttRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_slice_make(size : Int) -> StatstesttSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_slice_len(s : StatstesttSlice) -> Int { s.size }

pub fn stats_test_t_slice_get(s : StatstesttSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_slice_set(s : StatstesttSlice, i : Int, v : Double) -> StatstesttSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_t_slice_sum(s : StatstesttSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_t_slice_mean(s : StatstesttSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_t_slice_scale(s : StatstesttSlice, f : Double) -> StatstesttSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_t_slice_add(a : StatstesttSlice, b : StatstesttSlice) -> StatstesttSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_t_slice_copy(s : StatstesttSlice) -> StatstesttSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_t_slice_fill(s : StatstesttSlice, v : Double) -> StatstesttSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_t_slice_min(s : StatstesttSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_t_slice_max(s : StatstesttSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_t_slice_to_string(s : StatstesttSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

