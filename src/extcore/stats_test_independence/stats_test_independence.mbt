///===
/// extcore/stats_test_independence

pub(all) struct StatstestindependencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_independence_make_point(x : Double, y : Double) -> StatstestindependencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_independence_make_point3(x : Double, y : Double, z : Double) -> StatstestindependencePoint {
  { x, y, z, label: 0 }
}

pub fn StatstestindependencePoint::x(self : StatstestindependencePoint) -> Double { self.x }

pub fn StatstestindependencePoint::y(self : StatstestindependencePoint) -> Double { self.y }

pub fn StatstestindependencePoint::z(self : StatstestindependencePoint) -> Double { self.z }

pub fn StatstestindependencePoint::label(self : StatstestindependencePoint) -> Int { self.label }

pub fn StatstestindependencePoint::dist(self : StatstestindependencePoint, other : StatstestindependencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestindependencePoint::add(self : StatstestindependencePoint, other : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestindependencePoint::sub(self : StatstestindependencePoint, other : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestindependencePoint::scale(self : StatstestindependencePoint, s : Double) -> StatstestindependencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestindependencePoint::dot(self : StatstestindependencePoint, other : StatstestindependencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestindependencePoint::cross(self : StatstestindependencePoint, other : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestindependencePoint::norm(self : StatstestindependencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestindependencePoint::normalize(self : StatstestindependencePoint) -> StatstestindependencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestindependencePoint::negate(self : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestindependencePoint::mid(self : StatstestindependencePoint, other : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestindependencePoint::lerp(self : StatstestindependencePoint, other : StatstestindependencePoint, t : Double) -> StatstestindependencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestindependencePoint::to_string(self : StatstestindependencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestindependenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_independence_make_series(vals : Array[Double], name : String) -> StatstestindependenceSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestindependenceSeries::len(self : StatstestindependenceSeries) -> Int { self.vals.length() }

pub fn StatstestindependenceSeries::sum(self : StatstestindependenceSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestindependenceSeries::mean(self : StatstestindependenceSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestindependenceSeries::min(self : StatstestindependenceSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestindependenceSeries::max(self : StatstestindependenceSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestindependenceSeries::range(self : StatstestindependenceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestindependenceSeries::variance(self : StatstestindependenceSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestindependenceSeries::std(self : StatstestindependenceSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestindependenceSeries::median(self : StatstestindependenceSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestindependenceSeries::scale(self : StatstestindependenceSeries, f : Double) -> StatstestindependenceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestindependenceSeries::add(self : StatstestindependenceSeries, other : StatstestindependenceSeries) -> StatstestindependenceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestindependenceSeries::sub(self : StatstestindependenceSeries, other : StatstestindependenceSeries) -> StatstestindependenceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestindependenceSeries::normalize(self : StatstestindependenceSeries) -> StatstestindependenceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestindependenceSeries::cumsum(self : StatstestindependenceSeries) -> StatstestindependenceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestindependenceSeries::to_string(self : StatstestindependenceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestindependenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_independence_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestindependenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_independence_matrix_identity(n : Int) -> StatstestindependenceMatrix {
  let m = stats_test_independence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestindependenceMatrix::get(self : StatstestindependenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestindependenceMatrix::transpose(self : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  let result = stats_test_independence_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestindependenceMatrix::add(self : StatstestindependenceMatrix, other : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_independence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestindependenceMatrix::scale(self : StatstestindependenceMatrix, s : Double) -> StatstestindependenceMatrix {
  let result = stats_test_independence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestindependenceMatrix::multiply(self : StatstestindependenceMatrix, other : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  if self.cols != other.rows { return stats_test_independence_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_independence_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatstestindependenceMatrix::trace(self : StatstestindependenceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestindependenceMatrix::det(self : StatstestindependenceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestindependenceMatrix::norm(self : StatstestindependenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestindependenceMatrix::to_string(self : StatstestindependenceMatrix) -> String {
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

pub(all) struct StatstestindependenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_independence_make_vector(comps : Array[Double]) -> StatstestindependenceVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_independence_vector_zero(dim : Int) -> StatstestindependenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestindependenceVector::add(self : StatstestindependenceVector, other : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestindependenceVector::sub(self : StatstestindependenceVector, other : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestindependenceVector::scale(self : StatstestindependenceVector, s : Double) -> StatstestindependenceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestindependenceVector::dot(self : StatstestindependenceVector, other : StatstestindependenceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestindependenceVector::norm(self : StatstestindependenceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestindependenceVector::normalize(self : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestindependenceVector::dist(self : StatstestindependenceVector, other : StatstestindependenceVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestindependenceVector::to_string(self : StatstestindependenceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_independence_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_independence_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_independence_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_independence_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_independence_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_independence_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_independence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_independence_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_independence_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_independence_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_independence_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_independence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_independence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_independence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_independence_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_independence_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_independence_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_independence_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_independence_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_independence_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_independence_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_independence_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_independence_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_independence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_independence_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_independence_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_independence_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_independence_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_independence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestindependenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_frame_make(size : Int) -> StatstestindependenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_frame_len(s : StatstestindependenceFrame) -> Int { s.size }

pub fn stats_test_independence_frame_get(s : StatstestindependenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_frame_set(s : StatstestindependenceFrame, i : Int, v : Double) -> StatstestindependenceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_frame_sum(s : StatstestindependenceFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_frame_mean(s : StatstestindependenceFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_frame_scale(s : StatstestindependenceFrame, f : Double) -> StatstestindependenceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_frame_add(a : StatstestindependenceFrame, b : StatstestindependenceFrame) -> StatstestindependenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_frame_copy(s : StatstestindependenceFrame) -> StatstestindependenceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_frame_fill(s : StatstestindependenceFrame, v : Double) -> StatstestindependenceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_frame_min(s : StatstestindependenceFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_frame_max(s : StatstestindependenceFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_frame_to_string(s : StatstestindependenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_table_make(size : Int) -> StatstestindependenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_table_len(s : StatstestindependenceTable) -> Int { s.size }

pub fn stats_test_independence_table_get(s : StatstestindependenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_table_set(s : StatstestindependenceTable, i : Int, v : Double) -> StatstestindependenceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_table_sum(s : StatstestindependenceTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_table_mean(s : StatstestindependenceTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_table_scale(s : StatstestindependenceTable, f : Double) -> StatstestindependenceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_table_add(a : StatstestindependenceTable, b : StatstestindependenceTable) -> StatstestindependenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_table_copy(s : StatstestindependenceTable) -> StatstestindependenceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_table_fill(s : StatstestindependenceTable, v : Double) -> StatstestindependenceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_table_min(s : StatstestindependenceTable) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_table_max(s : StatstestindependenceTable) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_table_to_string(s : StatstestindependenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_graphn_make(size : Int) -> StatstestindependenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_graphn_len(s : StatstestindependenceGraphN) -> Int { s.size }

pub fn stats_test_independence_graphn_get(s : StatstestindependenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_graphn_set(s : StatstestindependenceGraphN, i : Int, v : Double) -> StatstestindependenceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_graphn_sum(s : StatstestindependenceGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_graphn_mean(s : StatstestindependenceGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_graphn_scale(s : StatstestindependenceGraphN, f : Double) -> StatstestindependenceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_graphn_add(a : StatstestindependenceGraphN, b : StatstestindependenceGraphN) -> StatstestindependenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_graphn_copy(s : StatstestindependenceGraphN) -> StatstestindependenceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_graphn_fill(s : StatstestindependenceGraphN, v : Double) -> StatstestindependenceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_graphn_min(s : StatstestindependenceGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_graphn_max(s : StatstestindependenceGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_graphn_to_string(s : StatstestindependenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_node_make(size : Int) -> StatstestindependenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_node_len(s : StatstestindependenceNode) -> Int { s.size }

pub fn stats_test_independence_node_get(s : StatstestindependenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_node_set(s : StatstestindependenceNode, i : Int, v : Double) -> StatstestindependenceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_node_sum(s : StatstestindependenceNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_node_mean(s : StatstestindependenceNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_node_scale(s : StatstestindependenceNode, f : Double) -> StatstestindependenceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_node_add(a : StatstestindependenceNode, b : StatstestindependenceNode) -> StatstestindependenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_node_copy(s : StatstestindependenceNode) -> StatstestindependenceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_node_fill(s : StatstestindependenceNode, v : Double) -> StatstestindependenceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_node_min(s : StatstestindependenceNode) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_node_max(s : StatstestindependenceNode) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_node_to_string(s : StatstestindependenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_edge_make(size : Int) -> StatstestindependenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_edge_len(s : StatstestindependenceEdge) -> Int { s.size }

pub fn stats_test_independence_edge_get(s : StatstestindependenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_edge_set(s : StatstestindependenceEdge, i : Int, v : Double) -> StatstestindependenceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_edge_sum(s : StatstestindependenceEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_edge_mean(s : StatstestindependenceEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_edge_scale(s : StatstestindependenceEdge, f : Double) -> StatstestindependenceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_edge_add(a : StatstestindependenceEdge, b : StatstestindependenceEdge) -> StatstestindependenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_edge_copy(s : StatstestindependenceEdge) -> StatstestindependenceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_edge_fill(s : StatstestindependenceEdge, v : Double) -> StatstestindependenceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_edge_min(s : StatstestindependenceEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_edge_max(s : StatstestindependenceEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_edge_to_string(s : StatstestindependenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_path_make(size : Int) -> StatstestindependencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_path_len(s : StatstestindependencePath) -> Int { s.size }

pub fn stats_test_independence_path_get(s : StatstestindependencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_path_set(s : StatstestindependencePath, i : Int, v : Double) -> StatstestindependencePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_path_sum(s : StatstestindependencePath) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_path_mean(s : StatstestindependencePath) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_path_scale(s : StatstestindependencePath, f : Double) -> StatstestindependencePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_path_add(a : StatstestindependencePath, b : StatstestindependencePath) -> StatstestindependencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_path_copy(s : StatstestindependencePath) -> StatstestindependencePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_path_fill(s : StatstestindependencePath, v : Double) -> StatstestindependencePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_path_min(s : StatstestindependencePath) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_path_max(s : StatstestindependencePath) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_path_to_string(s : StatstestindependencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_cluster_make(size : Int) -> StatstestindependenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_cluster_len(s : StatstestindependenceCluster) -> Int { s.size }

pub fn stats_test_independence_cluster_get(s : StatstestindependenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_cluster_set(s : StatstestindependenceCluster, i : Int, v : Double) -> StatstestindependenceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cluster_sum(s : StatstestindependenceCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_cluster_mean(s : StatstestindependenceCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_cluster_scale(s : StatstestindependenceCluster, f : Double) -> StatstestindependenceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cluster_add(a : StatstestindependenceCluster, b : StatstestindependenceCluster) -> StatstestindependenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_cluster_copy(s : StatstestindependenceCluster) -> StatstestindependenceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cluster_fill(s : StatstestindependenceCluster, v : Double) -> StatstestindependenceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cluster_min(s : StatstestindependenceCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_cluster_max(s : StatstestindependenceCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_cluster_to_string(s : StatstestindependenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_model_make(size : Int) -> StatstestindependenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_model_len(s : StatstestindependenceModel) -> Int { s.size }

pub fn stats_test_independence_model_get(s : StatstestindependenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_model_set(s : StatstestindependenceModel, i : Int, v : Double) -> StatstestindependenceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_model_sum(s : StatstestindependenceModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_model_mean(s : StatstestindependenceModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_model_scale(s : StatstestindependenceModel, f : Double) -> StatstestindependenceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_model_add(a : StatstestindependenceModel, b : StatstestindependenceModel) -> StatstestindependenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_model_copy(s : StatstestindependenceModel) -> StatstestindependenceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_model_fill(s : StatstestindependenceModel, v : Double) -> StatstestindependenceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_model_min(s : StatstestindependenceModel) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_model_max(s : StatstestindependenceModel) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_model_to_string(s : StatstestindependenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_layer_make(size : Int) -> StatstestindependenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_layer_len(s : StatstestindependenceLayer) -> Int { s.size }

pub fn stats_test_independence_layer_get(s : StatstestindependenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_layer_set(s : StatstestindependenceLayer, i : Int, v : Double) -> StatstestindependenceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_layer_sum(s : StatstestindependenceLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_layer_mean(s : StatstestindependenceLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_layer_scale(s : StatstestindependenceLayer, f : Double) -> StatstestindependenceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_layer_add(a : StatstestindependenceLayer, b : StatstestindependenceLayer) -> StatstestindependenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_layer_copy(s : StatstestindependenceLayer) -> StatstestindependenceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_layer_fill(s : StatstestindependenceLayer, v : Double) -> StatstestindependenceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_layer_min(s : StatstestindependenceLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_layer_max(s : StatstestindependenceLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_layer_to_string(s : StatstestindependenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_buffer_make(size : Int) -> StatstestindependenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_buffer_len(s : StatstestindependenceBuffer) -> Int { s.size }

pub fn stats_test_independence_buffer_get(s : StatstestindependenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_buffer_set(s : StatstestindependenceBuffer, i : Int, v : Double) -> StatstestindependenceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_buffer_sum(s : StatstestindependenceBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_buffer_mean(s : StatstestindependenceBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_buffer_scale(s : StatstestindependenceBuffer, f : Double) -> StatstestindependenceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_buffer_add(a : StatstestindependenceBuffer, b : StatstestindependenceBuffer) -> StatstestindependenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_buffer_copy(s : StatstestindependenceBuffer) -> StatstestindependenceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_buffer_fill(s : StatstestindependenceBuffer, v : Double) -> StatstestindependenceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_buffer_min(s : StatstestindependenceBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_buffer_max(s : StatstestindependenceBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_buffer_to_string(s : StatstestindependenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_cursor_make(size : Int) -> StatstestindependenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_cursor_len(s : StatstestindependenceCursor) -> Int { s.size }

pub fn stats_test_independence_cursor_get(s : StatstestindependenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_cursor_set(s : StatstestindependenceCursor, i : Int, v : Double) -> StatstestindependenceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cursor_sum(s : StatstestindependenceCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_cursor_mean(s : StatstestindependenceCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_cursor_scale(s : StatstestindependenceCursor, f : Double) -> StatstestindependenceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cursor_add(a : StatstestindependenceCursor, b : StatstestindependenceCursor) -> StatstestindependenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_cursor_copy(s : StatstestindependenceCursor) -> StatstestindependenceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cursor_fill(s : StatstestindependenceCursor, v : Double) -> StatstestindependenceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cursor_min(s : StatstestindependenceCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_cursor_max(s : StatstestindependenceCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_cursor_to_string(s : StatstestindependenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_view_make(size : Int) -> StatstestindependenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_view_len(s : StatstestindependenceView) -> Int { s.size }

pub fn stats_test_independence_view_get(s : StatstestindependenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_view_set(s : StatstestindependenceView, i : Int, v : Double) -> StatstestindependenceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_view_sum(s : StatstestindependenceView) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_view_mean(s : StatstestindependenceView) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_view_scale(s : StatstestindependenceView, f : Double) -> StatstestindependenceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_view_add(a : StatstestindependenceView, b : StatstestindependenceView) -> StatstestindependenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_view_copy(s : StatstestindependenceView) -> StatstestindependenceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_view_fill(s : StatstestindependenceView, v : Double) -> StatstestindependenceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_view_min(s : StatstestindependenceView) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_view_max(s : StatstestindependenceView) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_view_to_string(s : StatstestindependenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_range_make(size : Int) -> StatstestindependenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_range_len(s : StatstestindependenceRange) -> Int { s.size }

pub fn stats_test_independence_range_get(s : StatstestindependenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_range_set(s : StatstestindependenceRange, i : Int, v : Double) -> StatstestindependenceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_range_sum(s : StatstestindependenceRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_range_mean(s : StatstestindependenceRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_range_scale(s : StatstestindependenceRange, f : Double) -> StatstestindependenceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_range_add(a : StatstestindependenceRange, b : StatstestindependenceRange) -> StatstestindependenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_range_copy(s : StatstestindependenceRange) -> StatstestindependenceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_range_fill(s : StatstestindependenceRange, v : Double) -> StatstestindependenceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_range_min(s : StatstestindependenceRange) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_range_max(s : StatstestindependenceRange) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_range_to_string(s : StatstestindependenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_slice_make(size : Int) -> StatstestindependenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_slice_len(s : StatstestindependenceSlice) -> Int { s.size }

pub fn stats_test_independence_slice_get(s : StatstestindependenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_slice_set(s : StatstestindependenceSlice, i : Int, v : Double) -> StatstestindependenceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_independence_slice_sum(s : StatstestindependenceSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_slice_mean(s : StatstestindependenceSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_slice_scale(s : StatstestindependenceSlice, f : Double) -> StatstestindependenceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_slice_add(a : StatstestindependenceSlice, b : StatstestindependenceSlice) -> StatstestindependenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_slice_copy(s : StatstestindependenceSlice) -> StatstestindependenceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_slice_fill(s : StatstestindependenceSlice, v : Double) -> StatstestindependenceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_slice_min(s : StatstestindependenceSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_slice_max(s : StatstestindependenceSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_slice_to_string(s : StatstestindependenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

