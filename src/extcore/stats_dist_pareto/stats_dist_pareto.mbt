///===
/// extcore/stats_dist_pareto

pub(all) struct StatsdistparetoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_pareto_make_point(x : Double, y : Double) -> StatsdistparetoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_pareto_make_point3(x : Double, y : Double, z : Double) -> StatsdistparetoPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistparetoPoint::x(self : StatsdistparetoPoint) -> Double { self.x }

pub fn StatsdistparetoPoint::y(self : StatsdistparetoPoint) -> Double { self.y }

pub fn StatsdistparetoPoint::z(self : StatsdistparetoPoint) -> Double { self.z }

pub fn StatsdistparetoPoint::label(self : StatsdistparetoPoint) -> Int { self.label }

pub fn StatsdistparetoPoint::dist(self : StatsdistparetoPoint, other : StatsdistparetoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistparetoPoint::add(self : StatsdistparetoPoint, other : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistparetoPoint::sub(self : StatsdistparetoPoint, other : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistparetoPoint::scale(self : StatsdistparetoPoint, s : Double) -> StatsdistparetoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistparetoPoint::dot(self : StatsdistparetoPoint, other : StatsdistparetoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistparetoPoint::cross(self : StatsdistparetoPoint, other : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistparetoPoint::norm(self : StatsdistparetoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistparetoPoint::normalize(self : StatsdistparetoPoint) -> StatsdistparetoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistparetoPoint::negate(self : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistparetoPoint::mid(self : StatsdistparetoPoint, other : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistparetoPoint::lerp(self : StatsdistparetoPoint, other : StatsdistparetoPoint, t : Double) -> StatsdistparetoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistparetoPoint::to_string(self : StatsdistparetoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistparetoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_pareto_make_series(vals : Array[Double], name : String) -> StatsdistparetoSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistparetoSeries::len(self : StatsdistparetoSeries) -> Int { self.vals.length() }

pub fn StatsdistparetoSeries::sum(self : StatsdistparetoSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistparetoSeries::mean(self : StatsdistparetoSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistparetoSeries::min(self : StatsdistparetoSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistparetoSeries::max(self : StatsdistparetoSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistparetoSeries::range(self : StatsdistparetoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistparetoSeries::variance(self : StatsdistparetoSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistparetoSeries::std(self : StatsdistparetoSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistparetoSeries::median(self : StatsdistparetoSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistparetoSeries::scale(self : StatsdistparetoSeries, f : Double) -> StatsdistparetoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistparetoSeries::add(self : StatsdistparetoSeries, other : StatsdistparetoSeries) -> StatsdistparetoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistparetoSeries::sub(self : StatsdistparetoSeries, other : StatsdistparetoSeries) -> StatsdistparetoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistparetoSeries::normalize(self : StatsdistparetoSeries) -> StatsdistparetoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistparetoSeries::cumsum(self : StatsdistparetoSeries) -> StatsdistparetoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistparetoSeries::to_string(self : StatsdistparetoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistparetoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_pareto_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistparetoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_pareto_matrix_identity(n : Int) -> StatsdistparetoMatrix {
  let m = stats_dist_pareto_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistparetoMatrix::get(self : StatsdistparetoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistparetoMatrix::transpose(self : StatsdistparetoMatrix) -> StatsdistparetoMatrix {
  let result = stats_dist_pareto_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistparetoMatrix::add(self : StatsdistparetoMatrix, other : StatsdistparetoMatrix) -> StatsdistparetoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_pareto_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistparetoMatrix::scale(self : StatsdistparetoMatrix, s : Double) -> StatsdistparetoMatrix {
  let result = stats_dist_pareto_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistparetoMatrix::multiply(self : StatsdistparetoMatrix, other : StatsdistparetoMatrix) -> StatsdistparetoMatrix {
  if self.cols != other.rows { return stats_dist_pareto_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_pareto_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistparetoMatrix::trace(self : StatsdistparetoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistparetoMatrix::det(self : StatsdistparetoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistparetoMatrix::norm(self : StatsdistparetoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistparetoMatrix::to_string(self : StatsdistparetoMatrix) -> String {
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

pub(all) struct StatsdistparetoVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_pareto_make_vector(comps : Array[Double]) -> StatsdistparetoVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_pareto_vector_zero(dim : Int) -> StatsdistparetoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistparetoVector::add(self : StatsdistparetoVector, other : StatsdistparetoVector) -> StatsdistparetoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistparetoVector::sub(self : StatsdistparetoVector, other : StatsdistparetoVector) -> StatsdistparetoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistparetoVector::scale(self : StatsdistparetoVector, s : Double) -> StatsdistparetoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistparetoVector::dot(self : StatsdistparetoVector, other : StatsdistparetoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistparetoVector::norm(self : StatsdistparetoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistparetoVector::normalize(self : StatsdistparetoVector) -> StatsdistparetoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistparetoVector::dist(self : StatsdistparetoVector, other : StatsdistparetoVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistparetoVector::to_string(self : StatsdistparetoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_pareto_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_pareto_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_pareto_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_pareto_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_pareto_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_pareto_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_pareto_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_pareto_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_pareto_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_pareto_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_pareto_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_pareto_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_pareto_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_pareto_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_pareto_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_pareto_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_pareto_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_pareto_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_pareto_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_pareto_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_pareto_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_pareto_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_pareto_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_pareto_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_pareto_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_pareto_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_pareto_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_pareto_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_pareto_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistparetoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_frame_make(size : Int) -> StatsdistparetoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_frame_len(s : StatsdistparetoFrame) -> Int { s.size }

pub fn stats_dist_pareto_frame_get(s : StatsdistparetoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_frame_set(s : StatsdistparetoFrame, i : Int, v : Double) -> StatsdistparetoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_frame_sum(s : StatsdistparetoFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_frame_mean(s : StatsdistparetoFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_frame_scale(s : StatsdistparetoFrame, f : Double) -> StatsdistparetoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_frame_add(a : StatsdistparetoFrame, b : StatsdistparetoFrame) -> StatsdistparetoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_frame_copy(s : StatsdistparetoFrame) -> StatsdistparetoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_frame_fill(s : StatsdistparetoFrame, v : Double) -> StatsdistparetoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_frame_min(s : StatsdistparetoFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_frame_max(s : StatsdistparetoFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_frame_to_string(s : StatsdistparetoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_table_make(size : Int) -> StatsdistparetoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_table_len(s : StatsdistparetoTable) -> Int { s.size }

pub fn stats_dist_pareto_table_get(s : StatsdistparetoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_table_set(s : StatsdistparetoTable, i : Int, v : Double) -> StatsdistparetoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_table_sum(s : StatsdistparetoTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_table_mean(s : StatsdistparetoTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_table_scale(s : StatsdistparetoTable, f : Double) -> StatsdistparetoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_table_add(a : StatsdistparetoTable, b : StatsdistparetoTable) -> StatsdistparetoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_table_copy(s : StatsdistparetoTable) -> StatsdistparetoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_table_fill(s : StatsdistparetoTable, v : Double) -> StatsdistparetoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_table_min(s : StatsdistparetoTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_table_max(s : StatsdistparetoTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_table_to_string(s : StatsdistparetoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_graphn_make(size : Int) -> StatsdistparetoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_graphn_len(s : StatsdistparetoGraphN) -> Int { s.size }

pub fn stats_dist_pareto_graphn_get(s : StatsdistparetoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_graphn_set(s : StatsdistparetoGraphN, i : Int, v : Double) -> StatsdistparetoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_graphn_sum(s : StatsdistparetoGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_graphn_mean(s : StatsdistparetoGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_graphn_scale(s : StatsdistparetoGraphN, f : Double) -> StatsdistparetoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_graphn_add(a : StatsdistparetoGraphN, b : StatsdistparetoGraphN) -> StatsdistparetoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_graphn_copy(s : StatsdistparetoGraphN) -> StatsdistparetoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_graphn_fill(s : StatsdistparetoGraphN, v : Double) -> StatsdistparetoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_graphn_min(s : StatsdistparetoGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_graphn_max(s : StatsdistparetoGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_graphn_to_string(s : StatsdistparetoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_node_make(size : Int) -> StatsdistparetoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_node_len(s : StatsdistparetoNode) -> Int { s.size }

pub fn stats_dist_pareto_node_get(s : StatsdistparetoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_node_set(s : StatsdistparetoNode, i : Int, v : Double) -> StatsdistparetoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_node_sum(s : StatsdistparetoNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_node_mean(s : StatsdistparetoNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_node_scale(s : StatsdistparetoNode, f : Double) -> StatsdistparetoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_node_add(a : StatsdistparetoNode, b : StatsdistparetoNode) -> StatsdistparetoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_node_copy(s : StatsdistparetoNode) -> StatsdistparetoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_node_fill(s : StatsdistparetoNode, v : Double) -> StatsdistparetoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_node_min(s : StatsdistparetoNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_node_max(s : StatsdistparetoNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_node_to_string(s : StatsdistparetoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_edge_make(size : Int) -> StatsdistparetoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_edge_len(s : StatsdistparetoEdge) -> Int { s.size }

pub fn stats_dist_pareto_edge_get(s : StatsdistparetoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_edge_set(s : StatsdistparetoEdge, i : Int, v : Double) -> StatsdistparetoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_edge_sum(s : StatsdistparetoEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_edge_mean(s : StatsdistparetoEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_edge_scale(s : StatsdistparetoEdge, f : Double) -> StatsdistparetoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_edge_add(a : StatsdistparetoEdge, b : StatsdistparetoEdge) -> StatsdistparetoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_edge_copy(s : StatsdistparetoEdge) -> StatsdistparetoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_edge_fill(s : StatsdistparetoEdge, v : Double) -> StatsdistparetoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_edge_min(s : StatsdistparetoEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_edge_max(s : StatsdistparetoEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_edge_to_string(s : StatsdistparetoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_path_make(size : Int) -> StatsdistparetoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_path_len(s : StatsdistparetoPath) -> Int { s.size }

pub fn stats_dist_pareto_path_get(s : StatsdistparetoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_path_set(s : StatsdistparetoPath, i : Int, v : Double) -> StatsdistparetoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_path_sum(s : StatsdistparetoPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_path_mean(s : StatsdistparetoPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_path_scale(s : StatsdistparetoPath, f : Double) -> StatsdistparetoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_path_add(a : StatsdistparetoPath, b : StatsdistparetoPath) -> StatsdistparetoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_path_copy(s : StatsdistparetoPath) -> StatsdistparetoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_path_fill(s : StatsdistparetoPath, v : Double) -> StatsdistparetoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_path_min(s : StatsdistparetoPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_path_max(s : StatsdistparetoPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_path_to_string(s : StatsdistparetoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_cluster_make(size : Int) -> StatsdistparetoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_cluster_len(s : StatsdistparetoCluster) -> Int { s.size }

pub fn stats_dist_pareto_cluster_get(s : StatsdistparetoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_cluster_set(s : StatsdistparetoCluster, i : Int, v : Double) -> StatsdistparetoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cluster_sum(s : StatsdistparetoCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_cluster_mean(s : StatsdistparetoCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_cluster_scale(s : StatsdistparetoCluster, f : Double) -> StatsdistparetoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cluster_add(a : StatsdistparetoCluster, b : StatsdistparetoCluster) -> StatsdistparetoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_cluster_copy(s : StatsdistparetoCluster) -> StatsdistparetoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cluster_fill(s : StatsdistparetoCluster, v : Double) -> StatsdistparetoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cluster_min(s : StatsdistparetoCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_cluster_max(s : StatsdistparetoCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_cluster_to_string(s : StatsdistparetoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_model_make(size : Int) -> StatsdistparetoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_model_len(s : StatsdistparetoModel) -> Int { s.size }

pub fn stats_dist_pareto_model_get(s : StatsdistparetoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_model_set(s : StatsdistparetoModel, i : Int, v : Double) -> StatsdistparetoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_model_sum(s : StatsdistparetoModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_model_mean(s : StatsdistparetoModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_model_scale(s : StatsdistparetoModel, f : Double) -> StatsdistparetoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_model_add(a : StatsdistparetoModel, b : StatsdistparetoModel) -> StatsdistparetoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_model_copy(s : StatsdistparetoModel) -> StatsdistparetoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_model_fill(s : StatsdistparetoModel, v : Double) -> StatsdistparetoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_model_min(s : StatsdistparetoModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_model_max(s : StatsdistparetoModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_model_to_string(s : StatsdistparetoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_layer_make(size : Int) -> StatsdistparetoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_layer_len(s : StatsdistparetoLayer) -> Int { s.size }

pub fn stats_dist_pareto_layer_get(s : StatsdistparetoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_layer_set(s : StatsdistparetoLayer, i : Int, v : Double) -> StatsdistparetoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_layer_sum(s : StatsdistparetoLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_layer_mean(s : StatsdistparetoLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_layer_scale(s : StatsdistparetoLayer, f : Double) -> StatsdistparetoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_layer_add(a : StatsdistparetoLayer, b : StatsdistparetoLayer) -> StatsdistparetoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_layer_copy(s : StatsdistparetoLayer) -> StatsdistparetoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_layer_fill(s : StatsdistparetoLayer, v : Double) -> StatsdistparetoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_layer_min(s : StatsdistparetoLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_layer_max(s : StatsdistparetoLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_layer_to_string(s : StatsdistparetoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_buffer_make(size : Int) -> StatsdistparetoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_buffer_len(s : StatsdistparetoBuffer) -> Int { s.size }

pub fn stats_dist_pareto_buffer_get(s : StatsdistparetoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_buffer_set(s : StatsdistparetoBuffer, i : Int, v : Double) -> StatsdistparetoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_buffer_sum(s : StatsdistparetoBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_buffer_mean(s : StatsdistparetoBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_buffer_scale(s : StatsdistparetoBuffer, f : Double) -> StatsdistparetoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_buffer_add(a : StatsdistparetoBuffer, b : StatsdistparetoBuffer) -> StatsdistparetoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_buffer_copy(s : StatsdistparetoBuffer) -> StatsdistparetoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_buffer_fill(s : StatsdistparetoBuffer, v : Double) -> StatsdistparetoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_buffer_min(s : StatsdistparetoBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_buffer_max(s : StatsdistparetoBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_buffer_to_string(s : StatsdistparetoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_cursor_make(size : Int) -> StatsdistparetoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_cursor_len(s : StatsdistparetoCursor) -> Int { s.size }

pub fn stats_dist_pareto_cursor_get(s : StatsdistparetoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_cursor_set(s : StatsdistparetoCursor, i : Int, v : Double) -> StatsdistparetoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cursor_sum(s : StatsdistparetoCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_cursor_mean(s : StatsdistparetoCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_cursor_scale(s : StatsdistparetoCursor, f : Double) -> StatsdistparetoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cursor_add(a : StatsdistparetoCursor, b : StatsdistparetoCursor) -> StatsdistparetoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_cursor_copy(s : StatsdistparetoCursor) -> StatsdistparetoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cursor_fill(s : StatsdistparetoCursor, v : Double) -> StatsdistparetoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cursor_min(s : StatsdistparetoCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_cursor_max(s : StatsdistparetoCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_cursor_to_string(s : StatsdistparetoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_view_make(size : Int) -> StatsdistparetoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_view_len(s : StatsdistparetoView) -> Int { s.size }

pub fn stats_dist_pareto_view_get(s : StatsdistparetoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_view_set(s : StatsdistparetoView, i : Int, v : Double) -> StatsdistparetoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_view_sum(s : StatsdistparetoView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_view_mean(s : StatsdistparetoView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_view_scale(s : StatsdistparetoView, f : Double) -> StatsdistparetoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_view_add(a : StatsdistparetoView, b : StatsdistparetoView) -> StatsdistparetoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_view_copy(s : StatsdistparetoView) -> StatsdistparetoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_view_fill(s : StatsdistparetoView, v : Double) -> StatsdistparetoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_view_min(s : StatsdistparetoView) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_view_max(s : StatsdistparetoView) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_view_to_string(s : StatsdistparetoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_range_make(size : Int) -> StatsdistparetoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_range_len(s : StatsdistparetoRange) -> Int { s.size }

pub fn stats_dist_pareto_range_get(s : StatsdistparetoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_range_set(s : StatsdistparetoRange, i : Int, v : Double) -> StatsdistparetoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_range_sum(s : StatsdistparetoRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_range_mean(s : StatsdistparetoRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_range_scale(s : StatsdistparetoRange, f : Double) -> StatsdistparetoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_range_add(a : StatsdistparetoRange, b : StatsdistparetoRange) -> StatsdistparetoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_range_copy(s : StatsdistparetoRange) -> StatsdistparetoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_range_fill(s : StatsdistparetoRange, v : Double) -> StatsdistparetoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_range_min(s : StatsdistparetoRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_range_max(s : StatsdistparetoRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_range_to_string(s : StatsdistparetoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_slice_make(size : Int) -> StatsdistparetoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_slice_len(s : StatsdistparetoSlice) -> Int { s.size }

pub fn stats_dist_pareto_slice_get(s : StatsdistparetoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_slice_set(s : StatsdistparetoSlice, i : Int, v : Double) -> StatsdistparetoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_slice_sum(s : StatsdistparetoSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_slice_mean(s : StatsdistparetoSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_slice_scale(s : StatsdistparetoSlice, f : Double) -> StatsdistparetoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_slice_add(a : StatsdistparetoSlice, b : StatsdistparetoSlice) -> StatsdistparetoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_slice_copy(s : StatsdistparetoSlice) -> StatsdistparetoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_slice_fill(s : StatsdistparetoSlice, v : Double) -> StatsdistparetoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_slice_min(s : StatsdistparetoSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_slice_max(s : StatsdistparetoSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_slice_to_string(s : StatsdistparetoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

