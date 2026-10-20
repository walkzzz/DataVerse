///===
/// extcore/stats_dist_student

pub(all) struct StatsdiststudentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_student_make_point(x : Double, y : Double) -> StatsdiststudentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_student_make_point3(x : Double, y : Double, z : Double) -> StatsdiststudentPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdiststudentPoint::x(self : StatsdiststudentPoint) -> Double { self.x }

pub fn StatsdiststudentPoint::y(self : StatsdiststudentPoint) -> Double { self.y }

pub fn StatsdiststudentPoint::z(self : StatsdiststudentPoint) -> Double { self.z }

pub fn StatsdiststudentPoint::label(self : StatsdiststudentPoint) -> Int { self.label }

pub fn StatsdiststudentPoint::dist(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdiststudentPoint::add(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdiststudentPoint::sub(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdiststudentPoint::scale(self : StatsdiststudentPoint, s : Double) -> StatsdiststudentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdiststudentPoint::dot(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdiststudentPoint::cross(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdiststudentPoint::norm(self : StatsdiststudentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdiststudentPoint::normalize(self : StatsdiststudentPoint) -> StatsdiststudentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdiststudentPoint::negate(self : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdiststudentPoint::mid(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdiststudentPoint::lerp(self : StatsdiststudentPoint, other : StatsdiststudentPoint, t : Double) -> StatsdiststudentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdiststudentPoint::to_string(self : StatsdiststudentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdiststudentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_student_make_series(vals : Array[Double], name : String) -> StatsdiststudentSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdiststudentSeries::len(self : StatsdiststudentSeries) -> Int { self.vals.length() }

pub fn StatsdiststudentSeries::sum(self : StatsdiststudentSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdiststudentSeries::mean(self : StatsdiststudentSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdiststudentSeries::min(self : StatsdiststudentSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdiststudentSeries::max(self : StatsdiststudentSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdiststudentSeries::range(self : StatsdiststudentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdiststudentSeries::variance(self : StatsdiststudentSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdiststudentSeries::std(self : StatsdiststudentSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdiststudentSeries::median(self : StatsdiststudentSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdiststudentSeries::scale(self : StatsdiststudentSeries, f : Double) -> StatsdiststudentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdiststudentSeries::add(self : StatsdiststudentSeries, other : StatsdiststudentSeries) -> StatsdiststudentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdiststudentSeries::sub(self : StatsdiststudentSeries, other : StatsdiststudentSeries) -> StatsdiststudentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdiststudentSeries::normalize(self : StatsdiststudentSeries) -> StatsdiststudentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdiststudentSeries::cumsum(self : StatsdiststudentSeries) -> StatsdiststudentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdiststudentSeries::to_string(self : StatsdiststudentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdiststudentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_student_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdiststudentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_student_matrix_identity(n : Int) -> StatsdiststudentMatrix {
  let m = stats_dist_student_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdiststudentMatrix::get(self : StatsdiststudentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdiststudentMatrix::transpose(self : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  let result = stats_dist_student_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdiststudentMatrix::add(self : StatsdiststudentMatrix, other : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_student_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdiststudentMatrix::scale(self : StatsdiststudentMatrix, s : Double) -> StatsdiststudentMatrix {
  let result = stats_dist_student_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdiststudentMatrix::multiply(self : StatsdiststudentMatrix, other : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  if self.cols != other.rows { return stats_dist_student_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_student_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdiststudentMatrix::trace(self : StatsdiststudentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdiststudentMatrix::det(self : StatsdiststudentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdiststudentMatrix::norm(self : StatsdiststudentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdiststudentMatrix::to_string(self : StatsdiststudentMatrix) -> String {
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

pub(all) struct StatsdiststudentVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_student_make_vector(comps : Array[Double]) -> StatsdiststudentVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_student_vector_zero(dim : Int) -> StatsdiststudentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdiststudentVector::add(self : StatsdiststudentVector, other : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdiststudentVector::sub(self : StatsdiststudentVector, other : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdiststudentVector::scale(self : StatsdiststudentVector, s : Double) -> StatsdiststudentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdiststudentVector::dot(self : StatsdiststudentVector, other : StatsdiststudentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdiststudentVector::norm(self : StatsdiststudentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdiststudentVector::normalize(self : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdiststudentVector::dist(self : StatsdiststudentVector, other : StatsdiststudentVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdiststudentVector::to_string(self : StatsdiststudentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_student_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_student_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_student_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_student_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_student_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_student_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_student_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_student_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_student_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_student_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_student_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_student_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_student_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_student_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_student_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_student_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_student_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_student_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_student_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_student_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_student_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_student_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_student_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_student_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_student_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_student_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_student_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_student_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_student_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdiststudentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_frame_make(size : Int) -> StatsdiststudentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_frame_len(s : StatsdiststudentFrame) -> Int { s.size }

pub fn stats_dist_student_frame_get(s : StatsdiststudentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_frame_set(s : StatsdiststudentFrame, i : Int, v : Double) -> StatsdiststudentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_frame_sum(s : StatsdiststudentFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_frame_mean(s : StatsdiststudentFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_frame_scale(s : StatsdiststudentFrame, f : Double) -> StatsdiststudentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_frame_add(a : StatsdiststudentFrame, b : StatsdiststudentFrame) -> StatsdiststudentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_frame_copy(s : StatsdiststudentFrame) -> StatsdiststudentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_frame_fill(s : StatsdiststudentFrame, v : Double) -> StatsdiststudentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_frame_min(s : StatsdiststudentFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_frame_max(s : StatsdiststudentFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_frame_to_string(s : StatsdiststudentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_table_make(size : Int) -> StatsdiststudentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_table_len(s : StatsdiststudentTable) -> Int { s.size }

pub fn stats_dist_student_table_get(s : StatsdiststudentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_table_set(s : StatsdiststudentTable, i : Int, v : Double) -> StatsdiststudentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_table_sum(s : StatsdiststudentTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_table_mean(s : StatsdiststudentTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_table_scale(s : StatsdiststudentTable, f : Double) -> StatsdiststudentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_table_add(a : StatsdiststudentTable, b : StatsdiststudentTable) -> StatsdiststudentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_table_copy(s : StatsdiststudentTable) -> StatsdiststudentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_table_fill(s : StatsdiststudentTable, v : Double) -> StatsdiststudentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_table_min(s : StatsdiststudentTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_table_max(s : StatsdiststudentTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_table_to_string(s : StatsdiststudentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_graphn_make(size : Int) -> StatsdiststudentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_graphn_len(s : StatsdiststudentGraphN) -> Int { s.size }

pub fn stats_dist_student_graphn_get(s : StatsdiststudentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_graphn_set(s : StatsdiststudentGraphN, i : Int, v : Double) -> StatsdiststudentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_graphn_sum(s : StatsdiststudentGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_graphn_mean(s : StatsdiststudentGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_graphn_scale(s : StatsdiststudentGraphN, f : Double) -> StatsdiststudentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_graphn_add(a : StatsdiststudentGraphN, b : StatsdiststudentGraphN) -> StatsdiststudentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_graphn_copy(s : StatsdiststudentGraphN) -> StatsdiststudentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_graphn_fill(s : StatsdiststudentGraphN, v : Double) -> StatsdiststudentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_graphn_min(s : StatsdiststudentGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_graphn_max(s : StatsdiststudentGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_graphn_to_string(s : StatsdiststudentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_node_make(size : Int) -> StatsdiststudentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_node_len(s : StatsdiststudentNode) -> Int { s.size }

pub fn stats_dist_student_node_get(s : StatsdiststudentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_node_set(s : StatsdiststudentNode, i : Int, v : Double) -> StatsdiststudentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_node_sum(s : StatsdiststudentNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_node_mean(s : StatsdiststudentNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_node_scale(s : StatsdiststudentNode, f : Double) -> StatsdiststudentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_node_add(a : StatsdiststudentNode, b : StatsdiststudentNode) -> StatsdiststudentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_node_copy(s : StatsdiststudentNode) -> StatsdiststudentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_node_fill(s : StatsdiststudentNode, v : Double) -> StatsdiststudentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_node_min(s : StatsdiststudentNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_node_max(s : StatsdiststudentNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_node_to_string(s : StatsdiststudentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_edge_make(size : Int) -> StatsdiststudentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_edge_len(s : StatsdiststudentEdge) -> Int { s.size }

pub fn stats_dist_student_edge_get(s : StatsdiststudentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_edge_set(s : StatsdiststudentEdge, i : Int, v : Double) -> StatsdiststudentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_edge_sum(s : StatsdiststudentEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_edge_mean(s : StatsdiststudentEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_edge_scale(s : StatsdiststudentEdge, f : Double) -> StatsdiststudentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_edge_add(a : StatsdiststudentEdge, b : StatsdiststudentEdge) -> StatsdiststudentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_edge_copy(s : StatsdiststudentEdge) -> StatsdiststudentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_edge_fill(s : StatsdiststudentEdge, v : Double) -> StatsdiststudentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_edge_min(s : StatsdiststudentEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_edge_max(s : StatsdiststudentEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_edge_to_string(s : StatsdiststudentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_path_make(size : Int) -> StatsdiststudentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_path_len(s : StatsdiststudentPath) -> Int { s.size }

pub fn stats_dist_student_path_get(s : StatsdiststudentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_path_set(s : StatsdiststudentPath, i : Int, v : Double) -> StatsdiststudentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_path_sum(s : StatsdiststudentPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_path_mean(s : StatsdiststudentPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_path_scale(s : StatsdiststudentPath, f : Double) -> StatsdiststudentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_path_add(a : StatsdiststudentPath, b : StatsdiststudentPath) -> StatsdiststudentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_path_copy(s : StatsdiststudentPath) -> StatsdiststudentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_path_fill(s : StatsdiststudentPath, v : Double) -> StatsdiststudentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_path_min(s : StatsdiststudentPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_path_max(s : StatsdiststudentPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_path_to_string(s : StatsdiststudentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_cluster_make(size : Int) -> StatsdiststudentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_cluster_len(s : StatsdiststudentCluster) -> Int { s.size }

pub fn stats_dist_student_cluster_get(s : StatsdiststudentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_cluster_set(s : StatsdiststudentCluster, i : Int, v : Double) -> StatsdiststudentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_cluster_sum(s : StatsdiststudentCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_cluster_mean(s : StatsdiststudentCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_cluster_scale(s : StatsdiststudentCluster, f : Double) -> StatsdiststudentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_cluster_add(a : StatsdiststudentCluster, b : StatsdiststudentCluster) -> StatsdiststudentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_cluster_copy(s : StatsdiststudentCluster) -> StatsdiststudentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_cluster_fill(s : StatsdiststudentCluster, v : Double) -> StatsdiststudentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_cluster_min(s : StatsdiststudentCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_cluster_max(s : StatsdiststudentCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_cluster_to_string(s : StatsdiststudentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_model_make(size : Int) -> StatsdiststudentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_model_len(s : StatsdiststudentModel) -> Int { s.size }

pub fn stats_dist_student_model_get(s : StatsdiststudentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_model_set(s : StatsdiststudentModel, i : Int, v : Double) -> StatsdiststudentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_model_sum(s : StatsdiststudentModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_model_mean(s : StatsdiststudentModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_model_scale(s : StatsdiststudentModel, f : Double) -> StatsdiststudentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_model_add(a : StatsdiststudentModel, b : StatsdiststudentModel) -> StatsdiststudentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_model_copy(s : StatsdiststudentModel) -> StatsdiststudentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_model_fill(s : StatsdiststudentModel, v : Double) -> StatsdiststudentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_model_min(s : StatsdiststudentModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_model_max(s : StatsdiststudentModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_model_to_string(s : StatsdiststudentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_layer_make(size : Int) -> StatsdiststudentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_layer_len(s : StatsdiststudentLayer) -> Int { s.size }

pub fn stats_dist_student_layer_get(s : StatsdiststudentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_layer_set(s : StatsdiststudentLayer, i : Int, v : Double) -> StatsdiststudentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_layer_sum(s : StatsdiststudentLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_layer_mean(s : StatsdiststudentLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_layer_scale(s : StatsdiststudentLayer, f : Double) -> StatsdiststudentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_layer_add(a : StatsdiststudentLayer, b : StatsdiststudentLayer) -> StatsdiststudentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_layer_copy(s : StatsdiststudentLayer) -> StatsdiststudentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_layer_fill(s : StatsdiststudentLayer, v : Double) -> StatsdiststudentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_layer_min(s : StatsdiststudentLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_layer_max(s : StatsdiststudentLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_layer_to_string(s : StatsdiststudentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_buffer_make(size : Int) -> StatsdiststudentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_buffer_len(s : StatsdiststudentBuffer) -> Int { s.size }

pub fn stats_dist_student_buffer_get(s : StatsdiststudentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_buffer_set(s : StatsdiststudentBuffer, i : Int, v : Double) -> StatsdiststudentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_buffer_sum(s : StatsdiststudentBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_buffer_mean(s : StatsdiststudentBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_buffer_scale(s : StatsdiststudentBuffer, f : Double) -> StatsdiststudentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_buffer_add(a : StatsdiststudentBuffer, b : StatsdiststudentBuffer) -> StatsdiststudentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_buffer_copy(s : StatsdiststudentBuffer) -> StatsdiststudentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_buffer_fill(s : StatsdiststudentBuffer, v : Double) -> StatsdiststudentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_buffer_min(s : StatsdiststudentBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_buffer_max(s : StatsdiststudentBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_buffer_to_string(s : StatsdiststudentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_cursor_make(size : Int) -> StatsdiststudentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_cursor_len(s : StatsdiststudentCursor) -> Int { s.size }

pub fn stats_dist_student_cursor_get(s : StatsdiststudentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_cursor_set(s : StatsdiststudentCursor, i : Int, v : Double) -> StatsdiststudentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_cursor_sum(s : StatsdiststudentCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_cursor_mean(s : StatsdiststudentCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_cursor_scale(s : StatsdiststudentCursor, f : Double) -> StatsdiststudentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_cursor_add(a : StatsdiststudentCursor, b : StatsdiststudentCursor) -> StatsdiststudentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_cursor_copy(s : StatsdiststudentCursor) -> StatsdiststudentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_cursor_fill(s : StatsdiststudentCursor, v : Double) -> StatsdiststudentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_cursor_min(s : StatsdiststudentCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_cursor_max(s : StatsdiststudentCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_cursor_to_string(s : StatsdiststudentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_view_make(size : Int) -> StatsdiststudentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_view_len(s : StatsdiststudentView) -> Int { s.size }

pub fn stats_dist_student_view_get(s : StatsdiststudentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_view_set(s : StatsdiststudentView, i : Int, v : Double) -> StatsdiststudentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_view_sum(s : StatsdiststudentView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_view_mean(s : StatsdiststudentView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_view_scale(s : StatsdiststudentView, f : Double) -> StatsdiststudentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_view_add(a : StatsdiststudentView, b : StatsdiststudentView) -> StatsdiststudentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_view_copy(s : StatsdiststudentView) -> StatsdiststudentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_view_fill(s : StatsdiststudentView, v : Double) -> StatsdiststudentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_view_min(s : StatsdiststudentView) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_view_max(s : StatsdiststudentView) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_view_to_string(s : StatsdiststudentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_range_make(size : Int) -> StatsdiststudentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_range_len(s : StatsdiststudentRange) -> Int { s.size }

pub fn stats_dist_student_range_get(s : StatsdiststudentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_range_set(s : StatsdiststudentRange, i : Int, v : Double) -> StatsdiststudentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_range_sum(s : StatsdiststudentRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_range_mean(s : StatsdiststudentRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_range_scale(s : StatsdiststudentRange, f : Double) -> StatsdiststudentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_range_add(a : StatsdiststudentRange, b : StatsdiststudentRange) -> StatsdiststudentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_range_copy(s : StatsdiststudentRange) -> StatsdiststudentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_range_fill(s : StatsdiststudentRange, v : Double) -> StatsdiststudentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_range_min(s : StatsdiststudentRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_range_max(s : StatsdiststudentRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_range_to_string(s : StatsdiststudentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_slice_make(size : Int) -> StatsdiststudentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_slice_len(s : StatsdiststudentSlice) -> Int { s.size }

pub fn stats_dist_student_slice_get(s : StatsdiststudentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_slice_set(s : StatsdiststudentSlice, i : Int, v : Double) -> StatsdiststudentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_student_slice_sum(s : StatsdiststudentSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_student_slice_mean(s : StatsdiststudentSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_student_slice_scale(s : StatsdiststudentSlice, f : Double) -> StatsdiststudentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_slice_add(a : StatsdiststudentSlice, b : StatsdiststudentSlice) -> StatsdiststudentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_student_slice_copy(s : StatsdiststudentSlice) -> StatsdiststudentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_slice_fill(s : StatsdiststudentSlice, v : Double) -> StatsdiststudentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_student_slice_min(s : StatsdiststudentSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_student_slice_max(s : StatsdiststudentSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_student_slice_to_string(s : StatsdiststudentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

