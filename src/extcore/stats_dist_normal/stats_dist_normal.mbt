///===
/// extcore/stats_dist_normal

pub(all) struct StatsdistnormalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_normal_make_point(x : Double, y : Double) -> StatsdistnormalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_normal_make_point3(x : Double, y : Double, z : Double) -> StatsdistnormalPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistnormalPoint::x(self : StatsdistnormalPoint) -> Double { self.x }

pub fn StatsdistnormalPoint::y(self : StatsdistnormalPoint) -> Double { self.y }

pub fn StatsdistnormalPoint::z(self : StatsdistnormalPoint) -> Double { self.z }

pub fn StatsdistnormalPoint::label(self : StatsdistnormalPoint) -> Int { self.label }

pub fn StatsdistnormalPoint::dist(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistnormalPoint::add(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistnormalPoint::sub(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistnormalPoint::scale(self : StatsdistnormalPoint, s : Double) -> StatsdistnormalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistnormalPoint::dot(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistnormalPoint::cross(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistnormalPoint::norm(self : StatsdistnormalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistnormalPoint::normalize(self : StatsdistnormalPoint) -> StatsdistnormalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistnormalPoint::negate(self : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistnormalPoint::mid(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistnormalPoint::lerp(self : StatsdistnormalPoint, other : StatsdistnormalPoint, t : Double) -> StatsdistnormalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistnormalPoint::to_string(self : StatsdistnormalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistnormalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_normal_make_series(vals : Array[Double], name : String) -> StatsdistnormalSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistnormalSeries::len(self : StatsdistnormalSeries) -> Int { self.vals.length() }

pub fn StatsdistnormalSeries::sum(self : StatsdistnormalSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistnormalSeries::mean(self : StatsdistnormalSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistnormalSeries::min(self : StatsdistnormalSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistnormalSeries::max(self : StatsdistnormalSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistnormalSeries::range(self : StatsdistnormalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistnormalSeries::variance(self : StatsdistnormalSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistnormalSeries::std(self : StatsdistnormalSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistnormalSeries::median(self : StatsdistnormalSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistnormalSeries::scale(self : StatsdistnormalSeries, f : Double) -> StatsdistnormalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistnormalSeries::add(self : StatsdistnormalSeries, other : StatsdistnormalSeries) -> StatsdistnormalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistnormalSeries::sub(self : StatsdistnormalSeries, other : StatsdistnormalSeries) -> StatsdistnormalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistnormalSeries::normalize(self : StatsdistnormalSeries) -> StatsdistnormalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistnormalSeries::cumsum(self : StatsdistnormalSeries) -> StatsdistnormalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistnormalSeries::to_string(self : StatsdistnormalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistnormalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_normal_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistnormalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_normal_matrix_identity(n : Int) -> StatsdistnormalMatrix {
  let m = stats_dist_normal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistnormalMatrix::get(self : StatsdistnormalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistnormalMatrix::transpose(self : StatsdistnormalMatrix) -> StatsdistnormalMatrix {
  let result = stats_dist_normal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistnormalMatrix::add(self : StatsdistnormalMatrix, other : StatsdistnormalMatrix) -> StatsdistnormalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_normal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistnormalMatrix::scale(self : StatsdistnormalMatrix, s : Double) -> StatsdistnormalMatrix {
  let result = stats_dist_normal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistnormalMatrix::multiply(self : StatsdistnormalMatrix, other : StatsdistnormalMatrix) -> StatsdistnormalMatrix {
  if self.cols != other.rows { return stats_dist_normal_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_normal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistnormalMatrix::trace(self : StatsdistnormalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistnormalMatrix::det(self : StatsdistnormalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistnormalMatrix::norm(self : StatsdistnormalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistnormalMatrix::to_string(self : StatsdistnormalMatrix) -> String {
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

pub(all) struct StatsdistnormalVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_normal_make_vector(comps : Array[Double]) -> StatsdistnormalVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_normal_vector_zero(dim : Int) -> StatsdistnormalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistnormalVector::add(self : StatsdistnormalVector, other : StatsdistnormalVector) -> StatsdistnormalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistnormalVector::sub(self : StatsdistnormalVector, other : StatsdistnormalVector) -> StatsdistnormalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistnormalVector::scale(self : StatsdistnormalVector, s : Double) -> StatsdistnormalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistnormalVector::dot(self : StatsdistnormalVector, other : StatsdistnormalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistnormalVector::norm(self : StatsdistnormalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistnormalVector::normalize(self : StatsdistnormalVector) -> StatsdistnormalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistnormalVector::dist(self : StatsdistnormalVector, other : StatsdistnormalVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistnormalVector::to_string(self : StatsdistnormalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_normal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_normal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_normal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_normal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_normal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_normal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_normal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_normal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_normal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_normal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_normal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_normal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_normal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_normal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_normal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_normal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_normal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_normal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_normal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_normal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_normal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_normal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_normal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_normal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_normal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_normal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_normal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_normal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_normal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistnormalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_frame_make(size : Int) -> StatsdistnormalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_frame_len(s : StatsdistnormalFrame) -> Int { s.size }

pub fn stats_dist_normal_frame_get(s : StatsdistnormalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_frame_set(s : StatsdistnormalFrame, i : Int, v : Double) -> StatsdistnormalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_frame_sum(s : StatsdistnormalFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_frame_mean(s : StatsdistnormalFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_frame_scale(s : StatsdistnormalFrame, f : Double) -> StatsdistnormalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_frame_add(a : StatsdistnormalFrame, b : StatsdistnormalFrame) -> StatsdistnormalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_frame_copy(s : StatsdistnormalFrame) -> StatsdistnormalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_frame_fill(s : StatsdistnormalFrame, v : Double) -> StatsdistnormalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_frame_min(s : StatsdistnormalFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_frame_max(s : StatsdistnormalFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_frame_to_string(s : StatsdistnormalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_table_make(size : Int) -> StatsdistnormalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_table_len(s : StatsdistnormalTable) -> Int { s.size }

pub fn stats_dist_normal_table_get(s : StatsdistnormalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_table_set(s : StatsdistnormalTable, i : Int, v : Double) -> StatsdistnormalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_table_sum(s : StatsdistnormalTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_table_mean(s : StatsdistnormalTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_table_scale(s : StatsdistnormalTable, f : Double) -> StatsdistnormalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_table_add(a : StatsdistnormalTable, b : StatsdistnormalTable) -> StatsdistnormalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_table_copy(s : StatsdistnormalTable) -> StatsdistnormalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_table_fill(s : StatsdistnormalTable, v : Double) -> StatsdistnormalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_table_min(s : StatsdistnormalTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_table_max(s : StatsdistnormalTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_table_to_string(s : StatsdistnormalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_graphn_make(size : Int) -> StatsdistnormalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_graphn_len(s : StatsdistnormalGraphN) -> Int { s.size }

pub fn stats_dist_normal_graphn_get(s : StatsdistnormalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_graphn_set(s : StatsdistnormalGraphN, i : Int, v : Double) -> StatsdistnormalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_graphn_sum(s : StatsdistnormalGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_graphn_mean(s : StatsdistnormalGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_graphn_scale(s : StatsdistnormalGraphN, f : Double) -> StatsdistnormalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_graphn_add(a : StatsdistnormalGraphN, b : StatsdistnormalGraphN) -> StatsdistnormalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_graphn_copy(s : StatsdistnormalGraphN) -> StatsdistnormalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_graphn_fill(s : StatsdistnormalGraphN, v : Double) -> StatsdistnormalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_graphn_min(s : StatsdistnormalGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_graphn_max(s : StatsdistnormalGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_graphn_to_string(s : StatsdistnormalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_node_make(size : Int) -> StatsdistnormalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_node_len(s : StatsdistnormalNode) -> Int { s.size }

pub fn stats_dist_normal_node_get(s : StatsdistnormalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_node_set(s : StatsdistnormalNode, i : Int, v : Double) -> StatsdistnormalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_node_sum(s : StatsdistnormalNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_node_mean(s : StatsdistnormalNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_node_scale(s : StatsdistnormalNode, f : Double) -> StatsdistnormalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_node_add(a : StatsdistnormalNode, b : StatsdistnormalNode) -> StatsdistnormalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_node_copy(s : StatsdistnormalNode) -> StatsdistnormalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_node_fill(s : StatsdistnormalNode, v : Double) -> StatsdistnormalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_node_min(s : StatsdistnormalNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_node_max(s : StatsdistnormalNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_node_to_string(s : StatsdistnormalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_edge_make(size : Int) -> StatsdistnormalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_edge_len(s : StatsdistnormalEdge) -> Int { s.size }

pub fn stats_dist_normal_edge_get(s : StatsdistnormalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_edge_set(s : StatsdistnormalEdge, i : Int, v : Double) -> StatsdistnormalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_edge_sum(s : StatsdistnormalEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_edge_mean(s : StatsdistnormalEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_edge_scale(s : StatsdistnormalEdge, f : Double) -> StatsdistnormalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_edge_add(a : StatsdistnormalEdge, b : StatsdistnormalEdge) -> StatsdistnormalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_edge_copy(s : StatsdistnormalEdge) -> StatsdistnormalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_edge_fill(s : StatsdistnormalEdge, v : Double) -> StatsdistnormalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_edge_min(s : StatsdistnormalEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_edge_max(s : StatsdistnormalEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_edge_to_string(s : StatsdistnormalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_path_make(size : Int) -> StatsdistnormalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_path_len(s : StatsdistnormalPath) -> Int { s.size }

pub fn stats_dist_normal_path_get(s : StatsdistnormalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_path_set(s : StatsdistnormalPath, i : Int, v : Double) -> StatsdistnormalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_path_sum(s : StatsdistnormalPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_path_mean(s : StatsdistnormalPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_path_scale(s : StatsdistnormalPath, f : Double) -> StatsdistnormalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_path_add(a : StatsdistnormalPath, b : StatsdistnormalPath) -> StatsdistnormalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_path_copy(s : StatsdistnormalPath) -> StatsdistnormalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_path_fill(s : StatsdistnormalPath, v : Double) -> StatsdistnormalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_path_min(s : StatsdistnormalPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_path_max(s : StatsdistnormalPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_path_to_string(s : StatsdistnormalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_cluster_make(size : Int) -> StatsdistnormalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_cluster_len(s : StatsdistnormalCluster) -> Int { s.size }

pub fn stats_dist_normal_cluster_get(s : StatsdistnormalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_cluster_set(s : StatsdistnormalCluster, i : Int, v : Double) -> StatsdistnormalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_cluster_sum(s : StatsdistnormalCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_cluster_mean(s : StatsdistnormalCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_cluster_scale(s : StatsdistnormalCluster, f : Double) -> StatsdistnormalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_cluster_add(a : StatsdistnormalCluster, b : StatsdistnormalCluster) -> StatsdistnormalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_cluster_copy(s : StatsdistnormalCluster) -> StatsdistnormalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_cluster_fill(s : StatsdistnormalCluster, v : Double) -> StatsdistnormalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_cluster_min(s : StatsdistnormalCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_cluster_max(s : StatsdistnormalCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_cluster_to_string(s : StatsdistnormalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_model_make(size : Int) -> StatsdistnormalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_model_len(s : StatsdistnormalModel) -> Int { s.size }

pub fn stats_dist_normal_model_get(s : StatsdistnormalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_model_set(s : StatsdistnormalModel, i : Int, v : Double) -> StatsdistnormalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_model_sum(s : StatsdistnormalModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_model_mean(s : StatsdistnormalModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_model_scale(s : StatsdistnormalModel, f : Double) -> StatsdistnormalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_model_add(a : StatsdistnormalModel, b : StatsdistnormalModel) -> StatsdistnormalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_model_copy(s : StatsdistnormalModel) -> StatsdistnormalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_model_fill(s : StatsdistnormalModel, v : Double) -> StatsdistnormalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_model_min(s : StatsdistnormalModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_model_max(s : StatsdistnormalModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_model_to_string(s : StatsdistnormalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_layer_make(size : Int) -> StatsdistnormalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_layer_len(s : StatsdistnormalLayer) -> Int { s.size }

pub fn stats_dist_normal_layer_get(s : StatsdistnormalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_layer_set(s : StatsdistnormalLayer, i : Int, v : Double) -> StatsdistnormalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_layer_sum(s : StatsdistnormalLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_layer_mean(s : StatsdistnormalLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_layer_scale(s : StatsdistnormalLayer, f : Double) -> StatsdistnormalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_layer_add(a : StatsdistnormalLayer, b : StatsdistnormalLayer) -> StatsdistnormalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_layer_copy(s : StatsdistnormalLayer) -> StatsdistnormalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_layer_fill(s : StatsdistnormalLayer, v : Double) -> StatsdistnormalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_layer_min(s : StatsdistnormalLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_layer_max(s : StatsdistnormalLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_layer_to_string(s : StatsdistnormalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_buffer_make(size : Int) -> StatsdistnormalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_buffer_len(s : StatsdistnormalBuffer) -> Int { s.size }

pub fn stats_dist_normal_buffer_get(s : StatsdistnormalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_buffer_set(s : StatsdistnormalBuffer, i : Int, v : Double) -> StatsdistnormalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_buffer_sum(s : StatsdistnormalBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_buffer_mean(s : StatsdistnormalBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_buffer_scale(s : StatsdistnormalBuffer, f : Double) -> StatsdistnormalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_buffer_add(a : StatsdistnormalBuffer, b : StatsdistnormalBuffer) -> StatsdistnormalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_buffer_copy(s : StatsdistnormalBuffer) -> StatsdistnormalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_buffer_fill(s : StatsdistnormalBuffer, v : Double) -> StatsdistnormalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_buffer_min(s : StatsdistnormalBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_buffer_max(s : StatsdistnormalBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_buffer_to_string(s : StatsdistnormalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_cursor_make(size : Int) -> StatsdistnormalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_cursor_len(s : StatsdistnormalCursor) -> Int { s.size }

pub fn stats_dist_normal_cursor_get(s : StatsdistnormalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_cursor_set(s : StatsdistnormalCursor, i : Int, v : Double) -> StatsdistnormalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_cursor_sum(s : StatsdistnormalCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_cursor_mean(s : StatsdistnormalCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_cursor_scale(s : StatsdistnormalCursor, f : Double) -> StatsdistnormalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_cursor_add(a : StatsdistnormalCursor, b : StatsdistnormalCursor) -> StatsdistnormalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_cursor_copy(s : StatsdistnormalCursor) -> StatsdistnormalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_cursor_fill(s : StatsdistnormalCursor, v : Double) -> StatsdistnormalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_cursor_min(s : StatsdistnormalCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_cursor_max(s : StatsdistnormalCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_cursor_to_string(s : StatsdistnormalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_view_make(size : Int) -> StatsdistnormalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_view_len(s : StatsdistnormalView) -> Int { s.size }

pub fn stats_dist_normal_view_get(s : StatsdistnormalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_view_set(s : StatsdistnormalView, i : Int, v : Double) -> StatsdistnormalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_view_sum(s : StatsdistnormalView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_view_mean(s : StatsdistnormalView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_view_scale(s : StatsdistnormalView, f : Double) -> StatsdistnormalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_view_add(a : StatsdistnormalView, b : StatsdistnormalView) -> StatsdistnormalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_view_copy(s : StatsdistnormalView) -> StatsdistnormalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_view_fill(s : StatsdistnormalView, v : Double) -> StatsdistnormalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_view_min(s : StatsdistnormalView) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_view_max(s : StatsdistnormalView) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_view_to_string(s : StatsdistnormalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_range_make(size : Int) -> StatsdistnormalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_range_len(s : StatsdistnormalRange) -> Int { s.size }

pub fn stats_dist_normal_range_get(s : StatsdistnormalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_range_set(s : StatsdistnormalRange, i : Int, v : Double) -> StatsdistnormalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_range_sum(s : StatsdistnormalRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_range_mean(s : StatsdistnormalRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_range_scale(s : StatsdistnormalRange, f : Double) -> StatsdistnormalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_range_add(a : StatsdistnormalRange, b : StatsdistnormalRange) -> StatsdistnormalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_range_copy(s : StatsdistnormalRange) -> StatsdistnormalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_range_fill(s : StatsdistnormalRange, v : Double) -> StatsdistnormalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_range_min(s : StatsdistnormalRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_range_max(s : StatsdistnormalRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_range_to_string(s : StatsdistnormalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_slice_make(size : Int) -> StatsdistnormalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_slice_len(s : StatsdistnormalSlice) -> Int { s.size }

pub fn stats_dist_normal_slice_get(s : StatsdistnormalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_slice_set(s : StatsdistnormalSlice, i : Int, v : Double) -> StatsdistnormalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_slice_sum(s : StatsdistnormalSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_normal_slice_mean(s : StatsdistnormalSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_normal_slice_scale(s : StatsdistnormalSlice, f : Double) -> StatsdistnormalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_slice_add(a : StatsdistnormalSlice, b : StatsdistnormalSlice) -> StatsdistnormalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_normal_slice_copy(s : StatsdistnormalSlice) -> StatsdistnormalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_slice_fill(s : StatsdistnormalSlice, v : Double) -> StatsdistnormalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_normal_slice_min(s : StatsdistnormalSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_normal_slice_max(s : StatsdistnormalSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_normal_slice_to_string(s : StatsdistnormalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

