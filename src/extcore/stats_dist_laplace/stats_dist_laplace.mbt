///===
/// extcore/stats_dist_laplace

pub(all) struct StatsdistlaplacePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_laplace_make_point(x : Double, y : Double) -> StatsdistlaplacePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_laplace_make_point3(x : Double, y : Double, z : Double) -> StatsdistlaplacePoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistlaplacePoint::x(self : StatsdistlaplacePoint) -> Double { self.x }

pub fn StatsdistlaplacePoint::y(self : StatsdistlaplacePoint) -> Double { self.y }

pub fn StatsdistlaplacePoint::z(self : StatsdistlaplacePoint) -> Double { self.z }

pub fn StatsdistlaplacePoint::label(self : StatsdistlaplacePoint) -> Int { self.label }

pub fn StatsdistlaplacePoint::dist(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistlaplacePoint::add(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistlaplacePoint::sub(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistlaplacePoint::scale(self : StatsdistlaplacePoint, s : Double) -> StatsdistlaplacePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistlaplacePoint::dot(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistlaplacePoint::cross(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistlaplacePoint::norm(self : StatsdistlaplacePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistlaplacePoint::normalize(self : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistlaplacePoint::negate(self : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistlaplacePoint::mid(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistlaplacePoint::lerp(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint, t : Double) -> StatsdistlaplacePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistlaplacePoint::to_string(self : StatsdistlaplacePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistlaplaceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_laplace_make_series(vals : Array[Double], name : String) -> StatsdistlaplaceSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistlaplaceSeries::len(self : StatsdistlaplaceSeries) -> Int { self.vals.length() }

pub fn StatsdistlaplaceSeries::sum(self : StatsdistlaplaceSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistlaplaceSeries::mean(self : StatsdistlaplaceSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistlaplaceSeries::min(self : StatsdistlaplaceSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistlaplaceSeries::max(self : StatsdistlaplaceSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistlaplaceSeries::range(self : StatsdistlaplaceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistlaplaceSeries::variance(self : StatsdistlaplaceSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistlaplaceSeries::std(self : StatsdistlaplaceSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistlaplaceSeries::median(self : StatsdistlaplaceSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistlaplaceSeries::scale(self : StatsdistlaplaceSeries, f : Double) -> StatsdistlaplaceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistlaplaceSeries::add(self : StatsdistlaplaceSeries, other : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistlaplaceSeries::sub(self : StatsdistlaplaceSeries, other : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistlaplaceSeries::normalize(self : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistlaplaceSeries::cumsum(self : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistlaplaceSeries::to_string(self : StatsdistlaplaceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistlaplaceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_laplace_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistlaplaceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_laplace_matrix_identity(n : Int) -> StatsdistlaplaceMatrix {
  let m = stats_dist_laplace_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistlaplaceMatrix::get(self : StatsdistlaplaceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistlaplaceMatrix::transpose(self : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  let result = stats_dist_laplace_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistlaplaceMatrix::add(self : StatsdistlaplaceMatrix, other : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_laplace_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistlaplaceMatrix::scale(self : StatsdistlaplaceMatrix, s : Double) -> StatsdistlaplaceMatrix {
  let result = stats_dist_laplace_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistlaplaceMatrix::multiply(self : StatsdistlaplaceMatrix, other : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  if self.cols != other.rows { return stats_dist_laplace_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_laplace_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistlaplaceMatrix::trace(self : StatsdistlaplaceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistlaplaceMatrix::det(self : StatsdistlaplaceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistlaplaceMatrix::norm(self : StatsdistlaplaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistlaplaceMatrix::to_string(self : StatsdistlaplaceMatrix) -> String {
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

pub(all) struct StatsdistlaplaceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_laplace_make_vector(comps : Array[Double]) -> StatsdistlaplaceVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_laplace_vector_zero(dim : Int) -> StatsdistlaplaceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistlaplaceVector::add(self : StatsdistlaplaceVector, other : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistlaplaceVector::sub(self : StatsdistlaplaceVector, other : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistlaplaceVector::scale(self : StatsdistlaplaceVector, s : Double) -> StatsdistlaplaceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistlaplaceVector::dot(self : StatsdistlaplaceVector, other : StatsdistlaplaceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistlaplaceVector::norm(self : StatsdistlaplaceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistlaplaceVector::normalize(self : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistlaplaceVector::dist(self : StatsdistlaplaceVector, other : StatsdistlaplaceVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistlaplaceVector::to_string(self : StatsdistlaplaceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_laplace_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_laplace_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_laplace_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_laplace_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_laplace_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_laplace_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_laplace_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_laplace_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_laplace_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_laplace_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_laplace_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_laplace_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_laplace_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_laplace_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_laplace_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_laplace_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_laplace_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_laplace_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_laplace_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_laplace_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_laplace_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_laplace_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_laplace_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_laplace_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_laplace_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_laplace_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_laplace_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_laplace_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_laplace_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistlaplaceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_frame_make(size : Int) -> StatsdistlaplaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_frame_len(s : StatsdistlaplaceFrame) -> Int { s.size }

pub fn stats_dist_laplace_frame_get(s : StatsdistlaplaceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_frame_set(s : StatsdistlaplaceFrame, i : Int, v : Double) -> StatsdistlaplaceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_frame_sum(s : StatsdistlaplaceFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_frame_mean(s : StatsdistlaplaceFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_frame_scale(s : StatsdistlaplaceFrame, f : Double) -> StatsdistlaplaceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_frame_add(a : StatsdistlaplaceFrame, b : StatsdistlaplaceFrame) -> StatsdistlaplaceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_frame_copy(s : StatsdistlaplaceFrame) -> StatsdistlaplaceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_frame_fill(s : StatsdistlaplaceFrame, v : Double) -> StatsdistlaplaceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_frame_min(s : StatsdistlaplaceFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_frame_max(s : StatsdistlaplaceFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_frame_to_string(s : StatsdistlaplaceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_table_make(size : Int) -> StatsdistlaplaceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_table_len(s : StatsdistlaplaceTable) -> Int { s.size }

pub fn stats_dist_laplace_table_get(s : StatsdistlaplaceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_table_set(s : StatsdistlaplaceTable, i : Int, v : Double) -> StatsdistlaplaceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_table_sum(s : StatsdistlaplaceTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_table_mean(s : StatsdistlaplaceTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_table_scale(s : StatsdistlaplaceTable, f : Double) -> StatsdistlaplaceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_table_add(a : StatsdistlaplaceTable, b : StatsdistlaplaceTable) -> StatsdistlaplaceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_table_copy(s : StatsdistlaplaceTable) -> StatsdistlaplaceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_table_fill(s : StatsdistlaplaceTable, v : Double) -> StatsdistlaplaceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_table_min(s : StatsdistlaplaceTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_table_max(s : StatsdistlaplaceTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_table_to_string(s : StatsdistlaplaceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_graphn_make(size : Int) -> StatsdistlaplaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_graphn_len(s : StatsdistlaplaceGraphN) -> Int { s.size }

pub fn stats_dist_laplace_graphn_get(s : StatsdistlaplaceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_graphn_set(s : StatsdistlaplaceGraphN, i : Int, v : Double) -> StatsdistlaplaceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_graphn_sum(s : StatsdistlaplaceGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_graphn_mean(s : StatsdistlaplaceGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_graphn_scale(s : StatsdistlaplaceGraphN, f : Double) -> StatsdistlaplaceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_graphn_add(a : StatsdistlaplaceGraphN, b : StatsdistlaplaceGraphN) -> StatsdistlaplaceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_graphn_copy(s : StatsdistlaplaceGraphN) -> StatsdistlaplaceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_graphn_fill(s : StatsdistlaplaceGraphN, v : Double) -> StatsdistlaplaceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_graphn_min(s : StatsdistlaplaceGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_graphn_max(s : StatsdistlaplaceGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_graphn_to_string(s : StatsdistlaplaceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_node_make(size : Int) -> StatsdistlaplaceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_node_len(s : StatsdistlaplaceNode) -> Int { s.size }

pub fn stats_dist_laplace_node_get(s : StatsdistlaplaceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_node_set(s : StatsdistlaplaceNode, i : Int, v : Double) -> StatsdistlaplaceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_node_sum(s : StatsdistlaplaceNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_node_mean(s : StatsdistlaplaceNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_node_scale(s : StatsdistlaplaceNode, f : Double) -> StatsdistlaplaceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_node_add(a : StatsdistlaplaceNode, b : StatsdistlaplaceNode) -> StatsdistlaplaceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_node_copy(s : StatsdistlaplaceNode) -> StatsdistlaplaceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_node_fill(s : StatsdistlaplaceNode, v : Double) -> StatsdistlaplaceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_node_min(s : StatsdistlaplaceNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_node_max(s : StatsdistlaplaceNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_node_to_string(s : StatsdistlaplaceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_edge_make(size : Int) -> StatsdistlaplaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_edge_len(s : StatsdistlaplaceEdge) -> Int { s.size }

pub fn stats_dist_laplace_edge_get(s : StatsdistlaplaceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_edge_set(s : StatsdistlaplaceEdge, i : Int, v : Double) -> StatsdistlaplaceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_edge_sum(s : StatsdistlaplaceEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_edge_mean(s : StatsdistlaplaceEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_edge_scale(s : StatsdistlaplaceEdge, f : Double) -> StatsdistlaplaceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_edge_add(a : StatsdistlaplaceEdge, b : StatsdistlaplaceEdge) -> StatsdistlaplaceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_edge_copy(s : StatsdistlaplaceEdge) -> StatsdistlaplaceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_edge_fill(s : StatsdistlaplaceEdge, v : Double) -> StatsdistlaplaceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_edge_min(s : StatsdistlaplaceEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_edge_max(s : StatsdistlaplaceEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_edge_to_string(s : StatsdistlaplaceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplacePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_path_make(size : Int) -> StatsdistlaplacePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_path_len(s : StatsdistlaplacePath) -> Int { s.size }

pub fn stats_dist_laplace_path_get(s : StatsdistlaplacePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_path_set(s : StatsdistlaplacePath, i : Int, v : Double) -> StatsdistlaplacePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_path_sum(s : StatsdistlaplacePath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_path_mean(s : StatsdistlaplacePath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_path_scale(s : StatsdistlaplacePath, f : Double) -> StatsdistlaplacePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_path_add(a : StatsdistlaplacePath, b : StatsdistlaplacePath) -> StatsdistlaplacePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_path_copy(s : StatsdistlaplacePath) -> StatsdistlaplacePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_path_fill(s : StatsdistlaplacePath, v : Double) -> StatsdistlaplacePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_path_min(s : StatsdistlaplacePath) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_path_max(s : StatsdistlaplacePath) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_path_to_string(s : StatsdistlaplacePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_cluster_make(size : Int) -> StatsdistlaplaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_cluster_len(s : StatsdistlaplaceCluster) -> Int { s.size }

pub fn stats_dist_laplace_cluster_get(s : StatsdistlaplaceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_cluster_set(s : StatsdistlaplaceCluster, i : Int, v : Double) -> StatsdistlaplaceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_cluster_sum(s : StatsdistlaplaceCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_cluster_mean(s : StatsdistlaplaceCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_cluster_scale(s : StatsdistlaplaceCluster, f : Double) -> StatsdistlaplaceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_cluster_add(a : StatsdistlaplaceCluster, b : StatsdistlaplaceCluster) -> StatsdistlaplaceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_cluster_copy(s : StatsdistlaplaceCluster) -> StatsdistlaplaceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_cluster_fill(s : StatsdistlaplaceCluster, v : Double) -> StatsdistlaplaceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_cluster_min(s : StatsdistlaplaceCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_cluster_max(s : StatsdistlaplaceCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_cluster_to_string(s : StatsdistlaplaceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_model_make(size : Int) -> StatsdistlaplaceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_model_len(s : StatsdistlaplaceModel) -> Int { s.size }

pub fn stats_dist_laplace_model_get(s : StatsdistlaplaceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_model_set(s : StatsdistlaplaceModel, i : Int, v : Double) -> StatsdistlaplaceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_model_sum(s : StatsdistlaplaceModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_model_mean(s : StatsdistlaplaceModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_model_scale(s : StatsdistlaplaceModel, f : Double) -> StatsdistlaplaceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_model_add(a : StatsdistlaplaceModel, b : StatsdistlaplaceModel) -> StatsdistlaplaceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_model_copy(s : StatsdistlaplaceModel) -> StatsdistlaplaceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_model_fill(s : StatsdistlaplaceModel, v : Double) -> StatsdistlaplaceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_model_min(s : StatsdistlaplaceModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_model_max(s : StatsdistlaplaceModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_model_to_string(s : StatsdistlaplaceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_layer_make(size : Int) -> StatsdistlaplaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_layer_len(s : StatsdistlaplaceLayer) -> Int { s.size }

pub fn stats_dist_laplace_layer_get(s : StatsdistlaplaceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_layer_set(s : StatsdistlaplaceLayer, i : Int, v : Double) -> StatsdistlaplaceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_layer_sum(s : StatsdistlaplaceLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_layer_mean(s : StatsdistlaplaceLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_layer_scale(s : StatsdistlaplaceLayer, f : Double) -> StatsdistlaplaceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_layer_add(a : StatsdistlaplaceLayer, b : StatsdistlaplaceLayer) -> StatsdistlaplaceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_layer_copy(s : StatsdistlaplaceLayer) -> StatsdistlaplaceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_layer_fill(s : StatsdistlaplaceLayer, v : Double) -> StatsdistlaplaceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_layer_min(s : StatsdistlaplaceLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_layer_max(s : StatsdistlaplaceLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_layer_to_string(s : StatsdistlaplaceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_buffer_make(size : Int) -> StatsdistlaplaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_buffer_len(s : StatsdistlaplaceBuffer) -> Int { s.size }

pub fn stats_dist_laplace_buffer_get(s : StatsdistlaplaceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_buffer_set(s : StatsdistlaplaceBuffer, i : Int, v : Double) -> StatsdistlaplaceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_buffer_sum(s : StatsdistlaplaceBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_buffer_mean(s : StatsdistlaplaceBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_buffer_scale(s : StatsdistlaplaceBuffer, f : Double) -> StatsdistlaplaceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_buffer_add(a : StatsdistlaplaceBuffer, b : StatsdistlaplaceBuffer) -> StatsdistlaplaceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_buffer_copy(s : StatsdistlaplaceBuffer) -> StatsdistlaplaceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_buffer_fill(s : StatsdistlaplaceBuffer, v : Double) -> StatsdistlaplaceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_buffer_min(s : StatsdistlaplaceBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_buffer_max(s : StatsdistlaplaceBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_buffer_to_string(s : StatsdistlaplaceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_cursor_make(size : Int) -> StatsdistlaplaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_cursor_len(s : StatsdistlaplaceCursor) -> Int { s.size }

pub fn stats_dist_laplace_cursor_get(s : StatsdistlaplaceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_cursor_set(s : StatsdistlaplaceCursor, i : Int, v : Double) -> StatsdistlaplaceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_cursor_sum(s : StatsdistlaplaceCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_cursor_mean(s : StatsdistlaplaceCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_cursor_scale(s : StatsdistlaplaceCursor, f : Double) -> StatsdistlaplaceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_cursor_add(a : StatsdistlaplaceCursor, b : StatsdistlaplaceCursor) -> StatsdistlaplaceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_cursor_copy(s : StatsdistlaplaceCursor) -> StatsdistlaplaceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_cursor_fill(s : StatsdistlaplaceCursor, v : Double) -> StatsdistlaplaceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_cursor_min(s : StatsdistlaplaceCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_cursor_max(s : StatsdistlaplaceCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_cursor_to_string(s : StatsdistlaplaceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_view_make(size : Int) -> StatsdistlaplaceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_view_len(s : StatsdistlaplaceView) -> Int { s.size }

pub fn stats_dist_laplace_view_get(s : StatsdistlaplaceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_view_set(s : StatsdistlaplaceView, i : Int, v : Double) -> StatsdistlaplaceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_view_sum(s : StatsdistlaplaceView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_view_mean(s : StatsdistlaplaceView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_view_scale(s : StatsdistlaplaceView, f : Double) -> StatsdistlaplaceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_view_add(a : StatsdistlaplaceView, b : StatsdistlaplaceView) -> StatsdistlaplaceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_view_copy(s : StatsdistlaplaceView) -> StatsdistlaplaceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_view_fill(s : StatsdistlaplaceView, v : Double) -> StatsdistlaplaceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_view_min(s : StatsdistlaplaceView) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_view_max(s : StatsdistlaplaceView) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_view_to_string(s : StatsdistlaplaceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_range_make(size : Int) -> StatsdistlaplaceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_range_len(s : StatsdistlaplaceRange) -> Int { s.size }

pub fn stats_dist_laplace_range_get(s : StatsdistlaplaceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_range_set(s : StatsdistlaplaceRange, i : Int, v : Double) -> StatsdistlaplaceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_range_sum(s : StatsdistlaplaceRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_range_mean(s : StatsdistlaplaceRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_range_scale(s : StatsdistlaplaceRange, f : Double) -> StatsdistlaplaceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_range_add(a : StatsdistlaplaceRange, b : StatsdistlaplaceRange) -> StatsdistlaplaceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_range_copy(s : StatsdistlaplaceRange) -> StatsdistlaplaceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_range_fill(s : StatsdistlaplaceRange, v : Double) -> StatsdistlaplaceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_range_min(s : StatsdistlaplaceRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_range_max(s : StatsdistlaplaceRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_range_to_string(s : StatsdistlaplaceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_slice_make(size : Int) -> StatsdistlaplaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_slice_len(s : StatsdistlaplaceSlice) -> Int { s.size }

pub fn stats_dist_laplace_slice_get(s : StatsdistlaplaceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_slice_set(s : StatsdistlaplaceSlice, i : Int, v : Double) -> StatsdistlaplaceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_slice_sum(s : StatsdistlaplaceSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_slice_mean(s : StatsdistlaplaceSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_slice_scale(s : StatsdistlaplaceSlice, f : Double) -> StatsdistlaplaceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_slice_add(a : StatsdistlaplaceSlice, b : StatsdistlaplaceSlice) -> StatsdistlaplaceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_laplace_slice_copy(s : StatsdistlaplaceSlice) -> StatsdistlaplaceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_slice_fill(s : StatsdistlaplaceSlice, v : Double) -> StatsdistlaplaceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_laplace_slice_min(s : StatsdistlaplaceSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_slice_max(s : StatsdistlaplaceSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_slice_to_string(s : StatsdistlaplaceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

