///===
/// extcore/stats_desc_robust

pub(all) struct StatsdescrobustPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_robust_make_point(x : Double, y : Double) -> StatsdescrobustPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_robust_make_point3(x : Double, y : Double, z : Double) -> StatsdescrobustPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdescrobustPoint::x(self : StatsdescrobustPoint) -> Double { self.x }

pub fn StatsdescrobustPoint::y(self : StatsdescrobustPoint) -> Double { self.y }

pub fn StatsdescrobustPoint::z(self : StatsdescrobustPoint) -> Double { self.z }

pub fn StatsdescrobustPoint::label(self : StatsdescrobustPoint) -> Int { self.label }

pub fn StatsdescrobustPoint::dist(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdescrobustPoint::add(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdescrobustPoint::sub(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdescrobustPoint::scale(self : StatsdescrobustPoint, s : Double) -> StatsdescrobustPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdescrobustPoint::dot(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdescrobustPoint::cross(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdescrobustPoint::norm(self : StatsdescrobustPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdescrobustPoint::normalize(self : StatsdescrobustPoint) -> StatsdescrobustPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescrobustPoint::negate(self : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdescrobustPoint::mid(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdescrobustPoint::lerp(self : StatsdescrobustPoint, other : StatsdescrobustPoint, t : Double) -> StatsdescrobustPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdescrobustPoint::to_string(self : StatsdescrobustPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdescrobustSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_robust_make_series(vals : Array[Double], name : String) -> StatsdescrobustSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdescrobustSeries::len(self : StatsdescrobustSeries) -> Int { self.vals.length() }

pub fn StatsdescrobustSeries::sum(self : StatsdescrobustSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdescrobustSeries::mean(self : StatsdescrobustSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdescrobustSeries::min(self : StatsdescrobustSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdescrobustSeries::max(self : StatsdescrobustSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdescrobustSeries::range(self : StatsdescrobustSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdescrobustSeries::variance(self : StatsdescrobustSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdescrobustSeries::std(self : StatsdescrobustSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdescrobustSeries::median(self : StatsdescrobustSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdescrobustSeries::scale(self : StatsdescrobustSeries, f : Double) -> StatsdescrobustSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdescrobustSeries::add(self : StatsdescrobustSeries, other : StatsdescrobustSeries) -> StatsdescrobustSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdescrobustSeries::sub(self : StatsdescrobustSeries, other : StatsdescrobustSeries) -> StatsdescrobustSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdescrobustSeries::normalize(self : StatsdescrobustSeries) -> StatsdescrobustSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdescrobustSeries::cumsum(self : StatsdescrobustSeries) -> StatsdescrobustSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdescrobustSeries::to_string(self : StatsdescrobustSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescrobustMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_robust_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescrobustMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_robust_matrix_identity(n : Int) -> StatsdescrobustMatrix {
  let m = stats_desc_robust_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdescrobustMatrix::get(self : StatsdescrobustMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdescrobustMatrix::transpose(self : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  let result = stats_desc_robust_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdescrobustMatrix::add(self : StatsdescrobustMatrix, other : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_desc_robust_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdescrobustMatrix::scale(self : StatsdescrobustMatrix, s : Double) -> StatsdescrobustMatrix {
  let result = stats_desc_robust_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdescrobustMatrix::multiply(self : StatsdescrobustMatrix, other : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  if self.cols != other.rows { return stats_desc_robust_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_desc_robust_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdescrobustMatrix::trace(self : StatsdescrobustMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdescrobustMatrix::det(self : StatsdescrobustMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdescrobustMatrix::norm(self : StatsdescrobustMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdescrobustMatrix::to_string(self : StatsdescrobustMatrix) -> String {
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

pub(all) struct StatsdescrobustVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_robust_make_vector(comps : Array[Double]) -> StatsdescrobustVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_robust_vector_zero(dim : Int) -> StatsdescrobustVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdescrobustVector::add(self : StatsdescrobustVector, other : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescrobustVector::sub(self : StatsdescrobustVector, other : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescrobustVector::scale(self : StatsdescrobustVector, s : Double) -> StatsdescrobustVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdescrobustVector::dot(self : StatsdescrobustVector, other : StatsdescrobustVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdescrobustVector::norm(self : StatsdescrobustVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdescrobustVector::normalize(self : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescrobustVector::dist(self : StatsdescrobustVector, other : StatsdescrobustVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdescrobustVector::to_string(self : StatsdescrobustVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_robust_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_desc_robust_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_desc_robust_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_desc_robust_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_desc_robust_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_desc_robust_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_desc_robust_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_desc_robust_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_desc_robust_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_desc_robust_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_desc_robust_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_desc_robust_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_desc_robust_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_desc_robust_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_desc_robust_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_desc_robust_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_desc_robust_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_desc_robust_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_desc_robust_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_desc_robust_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_desc_robust_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_desc_robust_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_desc_robust_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_desc_robust_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_desc_robust_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_desc_robust_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_desc_robust_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_desc_robust_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_desc_robust_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdescrobustFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_frame_make(size : Int) -> StatsdescrobustFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_frame_len(s : StatsdescrobustFrame) -> Int { s.size }

pub fn stats_desc_robust_frame_get(s : StatsdescrobustFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_frame_set(s : StatsdescrobustFrame, i : Int, v : Double) -> StatsdescrobustFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_frame_sum(s : StatsdescrobustFrame) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_frame_mean(s : StatsdescrobustFrame) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_frame_scale(s : StatsdescrobustFrame, f : Double) -> StatsdescrobustFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_frame_add(a : StatsdescrobustFrame, b : StatsdescrobustFrame) -> StatsdescrobustFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_frame_copy(s : StatsdescrobustFrame) -> StatsdescrobustFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_frame_fill(s : StatsdescrobustFrame, v : Double) -> StatsdescrobustFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_frame_min(s : StatsdescrobustFrame) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_frame_max(s : StatsdescrobustFrame) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_frame_to_string(s : StatsdescrobustFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_table_make(size : Int) -> StatsdescrobustTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_table_len(s : StatsdescrobustTable) -> Int { s.size }

pub fn stats_desc_robust_table_get(s : StatsdescrobustTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_table_set(s : StatsdescrobustTable, i : Int, v : Double) -> StatsdescrobustTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_table_sum(s : StatsdescrobustTable) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_table_mean(s : StatsdescrobustTable) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_table_scale(s : StatsdescrobustTable, f : Double) -> StatsdescrobustTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_table_add(a : StatsdescrobustTable, b : StatsdescrobustTable) -> StatsdescrobustTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_table_copy(s : StatsdescrobustTable) -> StatsdescrobustTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_table_fill(s : StatsdescrobustTable, v : Double) -> StatsdescrobustTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_table_min(s : StatsdescrobustTable) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_table_max(s : StatsdescrobustTable) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_table_to_string(s : StatsdescrobustTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_graphn_make(size : Int) -> StatsdescrobustGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_graphn_len(s : StatsdescrobustGraphN) -> Int { s.size }

pub fn stats_desc_robust_graphn_get(s : StatsdescrobustGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_graphn_set(s : StatsdescrobustGraphN, i : Int, v : Double) -> StatsdescrobustGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_graphn_sum(s : StatsdescrobustGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_graphn_mean(s : StatsdescrobustGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_graphn_scale(s : StatsdescrobustGraphN, f : Double) -> StatsdescrobustGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_graphn_add(a : StatsdescrobustGraphN, b : StatsdescrobustGraphN) -> StatsdescrobustGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_graphn_copy(s : StatsdescrobustGraphN) -> StatsdescrobustGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_graphn_fill(s : StatsdescrobustGraphN, v : Double) -> StatsdescrobustGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_graphn_min(s : StatsdescrobustGraphN) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_graphn_max(s : StatsdescrobustGraphN) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_graphn_to_string(s : StatsdescrobustGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_node_make(size : Int) -> StatsdescrobustNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_node_len(s : StatsdescrobustNode) -> Int { s.size }

pub fn stats_desc_robust_node_get(s : StatsdescrobustNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_node_set(s : StatsdescrobustNode, i : Int, v : Double) -> StatsdescrobustNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_node_sum(s : StatsdescrobustNode) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_node_mean(s : StatsdescrobustNode) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_node_scale(s : StatsdescrobustNode, f : Double) -> StatsdescrobustNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_node_add(a : StatsdescrobustNode, b : StatsdescrobustNode) -> StatsdescrobustNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_node_copy(s : StatsdescrobustNode) -> StatsdescrobustNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_node_fill(s : StatsdescrobustNode, v : Double) -> StatsdescrobustNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_node_min(s : StatsdescrobustNode) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_node_max(s : StatsdescrobustNode) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_node_to_string(s : StatsdescrobustNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_edge_make(size : Int) -> StatsdescrobustEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_edge_len(s : StatsdescrobustEdge) -> Int { s.size }

pub fn stats_desc_robust_edge_get(s : StatsdescrobustEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_edge_set(s : StatsdescrobustEdge, i : Int, v : Double) -> StatsdescrobustEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_edge_sum(s : StatsdescrobustEdge) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_edge_mean(s : StatsdescrobustEdge) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_edge_scale(s : StatsdescrobustEdge, f : Double) -> StatsdescrobustEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_edge_add(a : StatsdescrobustEdge, b : StatsdescrobustEdge) -> StatsdescrobustEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_edge_copy(s : StatsdescrobustEdge) -> StatsdescrobustEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_edge_fill(s : StatsdescrobustEdge, v : Double) -> StatsdescrobustEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_edge_min(s : StatsdescrobustEdge) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_edge_max(s : StatsdescrobustEdge) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_edge_to_string(s : StatsdescrobustEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_path_make(size : Int) -> StatsdescrobustPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_path_len(s : StatsdescrobustPath) -> Int { s.size }

pub fn stats_desc_robust_path_get(s : StatsdescrobustPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_path_set(s : StatsdescrobustPath, i : Int, v : Double) -> StatsdescrobustPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_path_sum(s : StatsdescrobustPath) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_path_mean(s : StatsdescrobustPath) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_path_scale(s : StatsdescrobustPath, f : Double) -> StatsdescrobustPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_path_add(a : StatsdescrobustPath, b : StatsdescrobustPath) -> StatsdescrobustPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_path_copy(s : StatsdescrobustPath) -> StatsdescrobustPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_path_fill(s : StatsdescrobustPath, v : Double) -> StatsdescrobustPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_path_min(s : StatsdescrobustPath) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_path_max(s : StatsdescrobustPath) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_path_to_string(s : StatsdescrobustPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_cluster_make(size : Int) -> StatsdescrobustCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_cluster_len(s : StatsdescrobustCluster) -> Int { s.size }

pub fn stats_desc_robust_cluster_get(s : StatsdescrobustCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_cluster_set(s : StatsdescrobustCluster, i : Int, v : Double) -> StatsdescrobustCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_cluster_sum(s : StatsdescrobustCluster) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_cluster_mean(s : StatsdescrobustCluster) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_cluster_scale(s : StatsdescrobustCluster, f : Double) -> StatsdescrobustCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_cluster_add(a : StatsdescrobustCluster, b : StatsdescrobustCluster) -> StatsdescrobustCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_cluster_copy(s : StatsdescrobustCluster) -> StatsdescrobustCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_cluster_fill(s : StatsdescrobustCluster, v : Double) -> StatsdescrobustCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_cluster_min(s : StatsdescrobustCluster) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_cluster_max(s : StatsdescrobustCluster) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_cluster_to_string(s : StatsdescrobustCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_model_make(size : Int) -> StatsdescrobustModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_model_len(s : StatsdescrobustModel) -> Int { s.size }

pub fn stats_desc_robust_model_get(s : StatsdescrobustModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_model_set(s : StatsdescrobustModel, i : Int, v : Double) -> StatsdescrobustModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_model_sum(s : StatsdescrobustModel) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_model_mean(s : StatsdescrobustModel) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_model_scale(s : StatsdescrobustModel, f : Double) -> StatsdescrobustModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_model_add(a : StatsdescrobustModel, b : StatsdescrobustModel) -> StatsdescrobustModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_model_copy(s : StatsdescrobustModel) -> StatsdescrobustModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_model_fill(s : StatsdescrobustModel, v : Double) -> StatsdescrobustModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_model_min(s : StatsdescrobustModel) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_model_max(s : StatsdescrobustModel) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_model_to_string(s : StatsdescrobustModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_layer_make(size : Int) -> StatsdescrobustLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_layer_len(s : StatsdescrobustLayer) -> Int { s.size }

pub fn stats_desc_robust_layer_get(s : StatsdescrobustLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_layer_set(s : StatsdescrobustLayer, i : Int, v : Double) -> StatsdescrobustLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_layer_sum(s : StatsdescrobustLayer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_layer_mean(s : StatsdescrobustLayer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_layer_scale(s : StatsdescrobustLayer, f : Double) -> StatsdescrobustLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_layer_add(a : StatsdescrobustLayer, b : StatsdescrobustLayer) -> StatsdescrobustLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_layer_copy(s : StatsdescrobustLayer) -> StatsdescrobustLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_layer_fill(s : StatsdescrobustLayer, v : Double) -> StatsdescrobustLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_layer_min(s : StatsdescrobustLayer) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_layer_max(s : StatsdescrobustLayer) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_layer_to_string(s : StatsdescrobustLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_buffer_make(size : Int) -> StatsdescrobustBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_buffer_len(s : StatsdescrobustBuffer) -> Int { s.size }

pub fn stats_desc_robust_buffer_get(s : StatsdescrobustBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_buffer_set(s : StatsdescrobustBuffer, i : Int, v : Double) -> StatsdescrobustBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_buffer_sum(s : StatsdescrobustBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_buffer_mean(s : StatsdescrobustBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_buffer_scale(s : StatsdescrobustBuffer, f : Double) -> StatsdescrobustBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_buffer_add(a : StatsdescrobustBuffer, b : StatsdescrobustBuffer) -> StatsdescrobustBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_buffer_copy(s : StatsdescrobustBuffer) -> StatsdescrobustBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_buffer_fill(s : StatsdescrobustBuffer, v : Double) -> StatsdescrobustBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_buffer_min(s : StatsdescrobustBuffer) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_buffer_max(s : StatsdescrobustBuffer) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_buffer_to_string(s : StatsdescrobustBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_cursor_make(size : Int) -> StatsdescrobustCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_cursor_len(s : StatsdescrobustCursor) -> Int { s.size }

pub fn stats_desc_robust_cursor_get(s : StatsdescrobustCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_cursor_set(s : StatsdescrobustCursor, i : Int, v : Double) -> StatsdescrobustCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_cursor_sum(s : StatsdescrobustCursor) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_cursor_mean(s : StatsdescrobustCursor) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_cursor_scale(s : StatsdescrobustCursor, f : Double) -> StatsdescrobustCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_cursor_add(a : StatsdescrobustCursor, b : StatsdescrobustCursor) -> StatsdescrobustCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_cursor_copy(s : StatsdescrobustCursor) -> StatsdescrobustCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_cursor_fill(s : StatsdescrobustCursor, v : Double) -> StatsdescrobustCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_cursor_min(s : StatsdescrobustCursor) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_cursor_max(s : StatsdescrobustCursor) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_cursor_to_string(s : StatsdescrobustCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_view_make(size : Int) -> StatsdescrobustView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_view_len(s : StatsdescrobustView) -> Int { s.size }

pub fn stats_desc_robust_view_get(s : StatsdescrobustView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_view_set(s : StatsdescrobustView, i : Int, v : Double) -> StatsdescrobustView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_view_sum(s : StatsdescrobustView) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_view_mean(s : StatsdescrobustView) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_view_scale(s : StatsdescrobustView, f : Double) -> StatsdescrobustView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_view_add(a : StatsdescrobustView, b : StatsdescrobustView) -> StatsdescrobustView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_view_copy(s : StatsdescrobustView) -> StatsdescrobustView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_view_fill(s : StatsdescrobustView, v : Double) -> StatsdescrobustView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_view_min(s : StatsdescrobustView) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_view_max(s : StatsdescrobustView) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_view_to_string(s : StatsdescrobustView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_range_make(size : Int) -> StatsdescrobustRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_range_len(s : StatsdescrobustRange) -> Int { s.size }

pub fn stats_desc_robust_range_get(s : StatsdescrobustRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_range_set(s : StatsdescrobustRange, i : Int, v : Double) -> StatsdescrobustRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_range_sum(s : StatsdescrobustRange) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_range_mean(s : StatsdescrobustRange) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_range_scale(s : StatsdescrobustRange, f : Double) -> StatsdescrobustRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_range_add(a : StatsdescrobustRange, b : StatsdescrobustRange) -> StatsdescrobustRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_range_copy(s : StatsdescrobustRange) -> StatsdescrobustRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_range_fill(s : StatsdescrobustRange, v : Double) -> StatsdescrobustRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_range_min(s : StatsdescrobustRange) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_range_max(s : StatsdescrobustRange) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_range_to_string(s : StatsdescrobustRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_slice_make(size : Int) -> StatsdescrobustSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_slice_len(s : StatsdescrobustSlice) -> Int { s.size }

pub fn stats_desc_robust_slice_get(s : StatsdescrobustSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_slice_set(s : StatsdescrobustSlice, i : Int, v : Double) -> StatsdescrobustSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_slice_sum(s : StatsdescrobustSlice) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_slice_mean(s : StatsdescrobustSlice) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_slice_scale(s : StatsdescrobustSlice, f : Double) -> StatsdescrobustSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_slice_add(a : StatsdescrobustSlice, b : StatsdescrobustSlice) -> StatsdescrobustSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_robust_slice_copy(s : StatsdescrobustSlice) -> StatsdescrobustSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_slice_fill(s : StatsdescrobustSlice, v : Double) -> StatsdescrobustSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_robust_slice_min(s : StatsdescrobustSlice) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_slice_max(s : StatsdescrobustSlice) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_slice_to_string(s : StatsdescrobustSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

