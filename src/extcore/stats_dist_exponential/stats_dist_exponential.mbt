///===
/// extcore/stats_dist_exponential

pub(all) struct StatsdistexponentialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_exponential_make_point(x : Double, y : Double) -> StatsdistexponentialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_exponential_make_point3(x : Double, y : Double, z : Double) -> StatsdistexponentialPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistexponentialPoint::x(self : StatsdistexponentialPoint) -> Double { self.x }

pub fn StatsdistexponentialPoint::y(self : StatsdistexponentialPoint) -> Double { self.y }

pub fn StatsdistexponentialPoint::z(self : StatsdistexponentialPoint) -> Double { self.z }

pub fn StatsdistexponentialPoint::label(self : StatsdistexponentialPoint) -> Int { self.label }

pub fn StatsdistexponentialPoint::dist(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistexponentialPoint::add(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistexponentialPoint::sub(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistexponentialPoint::scale(self : StatsdistexponentialPoint, s : Double) -> StatsdistexponentialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistexponentialPoint::dot(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistexponentialPoint::cross(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistexponentialPoint::norm(self : StatsdistexponentialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistexponentialPoint::normalize(self : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistexponentialPoint::negate(self : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistexponentialPoint::mid(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistexponentialPoint::lerp(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint, t : Double) -> StatsdistexponentialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistexponentialPoint::to_string(self : StatsdistexponentialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistexponentialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_exponential_make_series(vals : Array[Double], name : String) -> StatsdistexponentialSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistexponentialSeries::len(self : StatsdistexponentialSeries) -> Int { self.vals.length() }

pub fn StatsdistexponentialSeries::sum(self : StatsdistexponentialSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistexponentialSeries::mean(self : StatsdistexponentialSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistexponentialSeries::min(self : StatsdistexponentialSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistexponentialSeries::max(self : StatsdistexponentialSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistexponentialSeries::range(self : StatsdistexponentialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistexponentialSeries::variance(self : StatsdistexponentialSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistexponentialSeries::std(self : StatsdistexponentialSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistexponentialSeries::median(self : StatsdistexponentialSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistexponentialSeries::scale(self : StatsdistexponentialSeries, f : Double) -> StatsdistexponentialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistexponentialSeries::add(self : StatsdistexponentialSeries, other : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistexponentialSeries::sub(self : StatsdistexponentialSeries, other : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistexponentialSeries::normalize(self : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistexponentialSeries::cumsum(self : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistexponentialSeries::to_string(self : StatsdistexponentialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistexponentialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_exponential_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistexponentialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_exponential_matrix_identity(n : Int) -> StatsdistexponentialMatrix {
  let m = stats_dist_exponential_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistexponentialMatrix::get(self : StatsdistexponentialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistexponentialMatrix::transpose(self : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  let result = stats_dist_exponential_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistexponentialMatrix::add(self : StatsdistexponentialMatrix, other : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_exponential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistexponentialMatrix::scale(self : StatsdistexponentialMatrix, s : Double) -> StatsdistexponentialMatrix {
  let result = stats_dist_exponential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistexponentialMatrix::multiply(self : StatsdistexponentialMatrix, other : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  if self.cols != other.rows { return stats_dist_exponential_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_exponential_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistexponentialMatrix::trace(self : StatsdistexponentialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistexponentialMatrix::det(self : StatsdistexponentialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistexponentialMatrix::norm(self : StatsdistexponentialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistexponentialMatrix::to_string(self : StatsdistexponentialMatrix) -> String {
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

pub(all) struct StatsdistexponentialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_exponential_make_vector(comps : Array[Double]) -> StatsdistexponentialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_exponential_vector_zero(dim : Int) -> StatsdistexponentialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistexponentialVector::add(self : StatsdistexponentialVector, other : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistexponentialVector::sub(self : StatsdistexponentialVector, other : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistexponentialVector::scale(self : StatsdistexponentialVector, s : Double) -> StatsdistexponentialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistexponentialVector::dot(self : StatsdistexponentialVector, other : StatsdistexponentialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistexponentialVector::norm(self : StatsdistexponentialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistexponentialVector::normalize(self : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistexponentialVector::dist(self : StatsdistexponentialVector, other : StatsdistexponentialVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistexponentialVector::to_string(self : StatsdistexponentialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_exponential_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_exponential_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_exponential_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_exponential_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_exponential_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_exponential_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_exponential_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_exponential_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_exponential_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_exponential_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_exponential_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_exponential_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_exponential_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_exponential_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_exponential_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_exponential_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_exponential_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_exponential_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_exponential_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_exponential_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_exponential_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_exponential_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_exponential_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_exponential_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_exponential_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_exponential_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_exponential_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_exponential_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_exponential_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistexponentialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_frame_make(size : Int) -> StatsdistexponentialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_frame_len(s : StatsdistexponentialFrame) -> Int { s.size }

pub fn stats_dist_exponential_frame_get(s : StatsdistexponentialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_frame_set(s : StatsdistexponentialFrame, i : Int, v : Double) -> StatsdistexponentialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_frame_sum(s : StatsdistexponentialFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_frame_mean(s : StatsdistexponentialFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_frame_scale(s : StatsdistexponentialFrame, f : Double) -> StatsdistexponentialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_frame_add(a : StatsdistexponentialFrame, b : StatsdistexponentialFrame) -> StatsdistexponentialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_frame_copy(s : StatsdistexponentialFrame) -> StatsdistexponentialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_frame_fill(s : StatsdistexponentialFrame, v : Double) -> StatsdistexponentialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_frame_min(s : StatsdistexponentialFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_frame_max(s : StatsdistexponentialFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_frame_to_string(s : StatsdistexponentialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_table_make(size : Int) -> StatsdistexponentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_table_len(s : StatsdistexponentialTable) -> Int { s.size }

pub fn stats_dist_exponential_table_get(s : StatsdistexponentialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_table_set(s : StatsdistexponentialTable, i : Int, v : Double) -> StatsdistexponentialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_table_sum(s : StatsdistexponentialTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_table_mean(s : StatsdistexponentialTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_table_scale(s : StatsdistexponentialTable, f : Double) -> StatsdistexponentialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_table_add(a : StatsdistexponentialTable, b : StatsdistexponentialTable) -> StatsdistexponentialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_table_copy(s : StatsdistexponentialTable) -> StatsdistexponentialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_table_fill(s : StatsdistexponentialTable, v : Double) -> StatsdistexponentialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_table_min(s : StatsdistexponentialTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_table_max(s : StatsdistexponentialTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_table_to_string(s : StatsdistexponentialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_graphn_make(size : Int) -> StatsdistexponentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_graphn_len(s : StatsdistexponentialGraphN) -> Int { s.size }

pub fn stats_dist_exponential_graphn_get(s : StatsdistexponentialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_graphn_set(s : StatsdistexponentialGraphN, i : Int, v : Double) -> StatsdistexponentialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_graphn_sum(s : StatsdistexponentialGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_graphn_mean(s : StatsdistexponentialGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_graphn_scale(s : StatsdistexponentialGraphN, f : Double) -> StatsdistexponentialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_graphn_add(a : StatsdistexponentialGraphN, b : StatsdistexponentialGraphN) -> StatsdistexponentialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_graphn_copy(s : StatsdistexponentialGraphN) -> StatsdistexponentialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_graphn_fill(s : StatsdistexponentialGraphN, v : Double) -> StatsdistexponentialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_graphn_min(s : StatsdistexponentialGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_graphn_max(s : StatsdistexponentialGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_graphn_to_string(s : StatsdistexponentialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_node_make(size : Int) -> StatsdistexponentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_node_len(s : StatsdistexponentialNode) -> Int { s.size }

pub fn stats_dist_exponential_node_get(s : StatsdistexponentialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_node_set(s : StatsdistexponentialNode, i : Int, v : Double) -> StatsdistexponentialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_node_sum(s : StatsdistexponentialNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_node_mean(s : StatsdistexponentialNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_node_scale(s : StatsdistexponentialNode, f : Double) -> StatsdistexponentialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_node_add(a : StatsdistexponentialNode, b : StatsdistexponentialNode) -> StatsdistexponentialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_node_copy(s : StatsdistexponentialNode) -> StatsdistexponentialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_node_fill(s : StatsdistexponentialNode, v : Double) -> StatsdistexponentialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_node_min(s : StatsdistexponentialNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_node_max(s : StatsdistexponentialNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_node_to_string(s : StatsdistexponentialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_edge_make(size : Int) -> StatsdistexponentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_edge_len(s : StatsdistexponentialEdge) -> Int { s.size }

pub fn stats_dist_exponential_edge_get(s : StatsdistexponentialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_edge_set(s : StatsdistexponentialEdge, i : Int, v : Double) -> StatsdistexponentialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_edge_sum(s : StatsdistexponentialEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_edge_mean(s : StatsdistexponentialEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_edge_scale(s : StatsdistexponentialEdge, f : Double) -> StatsdistexponentialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_edge_add(a : StatsdistexponentialEdge, b : StatsdistexponentialEdge) -> StatsdistexponentialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_edge_copy(s : StatsdistexponentialEdge) -> StatsdistexponentialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_edge_fill(s : StatsdistexponentialEdge, v : Double) -> StatsdistexponentialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_edge_min(s : StatsdistexponentialEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_edge_max(s : StatsdistexponentialEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_edge_to_string(s : StatsdistexponentialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_path_make(size : Int) -> StatsdistexponentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_path_len(s : StatsdistexponentialPath) -> Int { s.size }

pub fn stats_dist_exponential_path_get(s : StatsdistexponentialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_path_set(s : StatsdistexponentialPath, i : Int, v : Double) -> StatsdistexponentialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_path_sum(s : StatsdistexponentialPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_path_mean(s : StatsdistexponentialPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_path_scale(s : StatsdistexponentialPath, f : Double) -> StatsdistexponentialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_path_add(a : StatsdistexponentialPath, b : StatsdistexponentialPath) -> StatsdistexponentialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_path_copy(s : StatsdistexponentialPath) -> StatsdistexponentialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_path_fill(s : StatsdistexponentialPath, v : Double) -> StatsdistexponentialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_path_min(s : StatsdistexponentialPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_path_max(s : StatsdistexponentialPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_path_to_string(s : StatsdistexponentialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_cluster_make(size : Int) -> StatsdistexponentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_cluster_len(s : StatsdistexponentialCluster) -> Int { s.size }

pub fn stats_dist_exponential_cluster_get(s : StatsdistexponentialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_cluster_set(s : StatsdistexponentialCluster, i : Int, v : Double) -> StatsdistexponentialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_cluster_sum(s : StatsdistexponentialCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_cluster_mean(s : StatsdistexponentialCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_cluster_scale(s : StatsdistexponentialCluster, f : Double) -> StatsdistexponentialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_cluster_add(a : StatsdistexponentialCluster, b : StatsdistexponentialCluster) -> StatsdistexponentialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_cluster_copy(s : StatsdistexponentialCluster) -> StatsdistexponentialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_cluster_fill(s : StatsdistexponentialCluster, v : Double) -> StatsdistexponentialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_cluster_min(s : StatsdistexponentialCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_cluster_max(s : StatsdistexponentialCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_cluster_to_string(s : StatsdistexponentialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_model_make(size : Int) -> StatsdistexponentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_model_len(s : StatsdistexponentialModel) -> Int { s.size }

pub fn stats_dist_exponential_model_get(s : StatsdistexponentialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_model_set(s : StatsdistexponentialModel, i : Int, v : Double) -> StatsdistexponentialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_model_sum(s : StatsdistexponentialModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_model_mean(s : StatsdistexponentialModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_model_scale(s : StatsdistexponentialModel, f : Double) -> StatsdistexponentialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_model_add(a : StatsdistexponentialModel, b : StatsdistexponentialModel) -> StatsdistexponentialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_model_copy(s : StatsdistexponentialModel) -> StatsdistexponentialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_model_fill(s : StatsdistexponentialModel, v : Double) -> StatsdistexponentialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_model_min(s : StatsdistexponentialModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_model_max(s : StatsdistexponentialModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_model_to_string(s : StatsdistexponentialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_layer_make(size : Int) -> StatsdistexponentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_layer_len(s : StatsdistexponentialLayer) -> Int { s.size }

pub fn stats_dist_exponential_layer_get(s : StatsdistexponentialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_layer_set(s : StatsdistexponentialLayer, i : Int, v : Double) -> StatsdistexponentialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_layer_sum(s : StatsdistexponentialLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_layer_mean(s : StatsdistexponentialLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_layer_scale(s : StatsdistexponentialLayer, f : Double) -> StatsdistexponentialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_layer_add(a : StatsdistexponentialLayer, b : StatsdistexponentialLayer) -> StatsdistexponentialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_layer_copy(s : StatsdistexponentialLayer) -> StatsdistexponentialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_layer_fill(s : StatsdistexponentialLayer, v : Double) -> StatsdistexponentialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_layer_min(s : StatsdistexponentialLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_layer_max(s : StatsdistexponentialLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_layer_to_string(s : StatsdistexponentialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_buffer_make(size : Int) -> StatsdistexponentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_buffer_len(s : StatsdistexponentialBuffer) -> Int { s.size }

pub fn stats_dist_exponential_buffer_get(s : StatsdistexponentialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_buffer_set(s : StatsdistexponentialBuffer, i : Int, v : Double) -> StatsdistexponentialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_buffer_sum(s : StatsdistexponentialBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_buffer_mean(s : StatsdistexponentialBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_buffer_scale(s : StatsdistexponentialBuffer, f : Double) -> StatsdistexponentialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_buffer_add(a : StatsdistexponentialBuffer, b : StatsdistexponentialBuffer) -> StatsdistexponentialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_buffer_copy(s : StatsdistexponentialBuffer) -> StatsdistexponentialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_buffer_fill(s : StatsdistexponentialBuffer, v : Double) -> StatsdistexponentialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_buffer_min(s : StatsdistexponentialBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_buffer_max(s : StatsdistexponentialBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_buffer_to_string(s : StatsdistexponentialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_cursor_make(size : Int) -> StatsdistexponentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_cursor_len(s : StatsdistexponentialCursor) -> Int { s.size }

pub fn stats_dist_exponential_cursor_get(s : StatsdistexponentialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_cursor_set(s : StatsdistexponentialCursor, i : Int, v : Double) -> StatsdistexponentialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_cursor_sum(s : StatsdistexponentialCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_cursor_mean(s : StatsdistexponentialCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_cursor_scale(s : StatsdistexponentialCursor, f : Double) -> StatsdistexponentialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_cursor_add(a : StatsdistexponentialCursor, b : StatsdistexponentialCursor) -> StatsdistexponentialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_cursor_copy(s : StatsdistexponentialCursor) -> StatsdistexponentialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_cursor_fill(s : StatsdistexponentialCursor, v : Double) -> StatsdistexponentialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_cursor_min(s : StatsdistexponentialCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_cursor_max(s : StatsdistexponentialCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_cursor_to_string(s : StatsdistexponentialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_view_make(size : Int) -> StatsdistexponentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_view_len(s : StatsdistexponentialView) -> Int { s.size }

pub fn stats_dist_exponential_view_get(s : StatsdistexponentialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_view_set(s : StatsdistexponentialView, i : Int, v : Double) -> StatsdistexponentialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_view_sum(s : StatsdistexponentialView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_view_mean(s : StatsdistexponentialView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_view_scale(s : StatsdistexponentialView, f : Double) -> StatsdistexponentialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_view_add(a : StatsdistexponentialView, b : StatsdistexponentialView) -> StatsdistexponentialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_view_copy(s : StatsdistexponentialView) -> StatsdistexponentialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_view_fill(s : StatsdistexponentialView, v : Double) -> StatsdistexponentialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_view_min(s : StatsdistexponentialView) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_view_max(s : StatsdistexponentialView) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_view_to_string(s : StatsdistexponentialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_range_make(size : Int) -> StatsdistexponentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_range_len(s : StatsdistexponentialRange) -> Int { s.size }

pub fn stats_dist_exponential_range_get(s : StatsdistexponentialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_range_set(s : StatsdistexponentialRange, i : Int, v : Double) -> StatsdistexponentialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_range_sum(s : StatsdistexponentialRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_range_mean(s : StatsdistexponentialRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_range_scale(s : StatsdistexponentialRange, f : Double) -> StatsdistexponentialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_range_add(a : StatsdistexponentialRange, b : StatsdistexponentialRange) -> StatsdistexponentialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_range_copy(s : StatsdistexponentialRange) -> StatsdistexponentialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_range_fill(s : StatsdistexponentialRange, v : Double) -> StatsdistexponentialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_range_min(s : StatsdistexponentialRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_range_max(s : StatsdistexponentialRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_range_to_string(s : StatsdistexponentialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_slice_make(size : Int) -> StatsdistexponentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_slice_len(s : StatsdistexponentialSlice) -> Int { s.size }

pub fn stats_dist_exponential_slice_get(s : StatsdistexponentialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_slice_set(s : StatsdistexponentialSlice, i : Int, v : Double) -> StatsdistexponentialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_slice_sum(s : StatsdistexponentialSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_exponential_slice_mean(s : StatsdistexponentialSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_exponential_slice_scale(s : StatsdistexponentialSlice, f : Double) -> StatsdistexponentialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_slice_add(a : StatsdistexponentialSlice, b : StatsdistexponentialSlice) -> StatsdistexponentialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_exponential_slice_copy(s : StatsdistexponentialSlice) -> StatsdistexponentialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_slice_fill(s : StatsdistexponentialSlice, v : Double) -> StatsdistexponentialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_exponential_slice_min(s : StatsdistexponentialSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_exponential_slice_max(s : StatsdistexponentialSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_exponential_slice_to_string(s : StatsdistexponentialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

