///===
/// extcore/stats_dist_wishart

pub(all) struct StatsdistwishartPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_wishart_make_point(x : Double, y : Double) -> StatsdistwishartPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_wishart_make_point3(x : Double, y : Double, z : Double) -> StatsdistwishartPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistwishartPoint::x(self : StatsdistwishartPoint) -> Double { self.x }

pub fn StatsdistwishartPoint::y(self : StatsdistwishartPoint) -> Double { self.y }

pub fn StatsdistwishartPoint::z(self : StatsdistwishartPoint) -> Double { self.z }

pub fn StatsdistwishartPoint::label(self : StatsdistwishartPoint) -> Int { self.label }

pub fn StatsdistwishartPoint::dist(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistwishartPoint::add(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistwishartPoint::sub(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistwishartPoint::scale(self : StatsdistwishartPoint, s : Double) -> StatsdistwishartPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistwishartPoint::dot(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistwishartPoint::cross(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistwishartPoint::norm(self : StatsdistwishartPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistwishartPoint::normalize(self : StatsdistwishartPoint) -> StatsdistwishartPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistwishartPoint::negate(self : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistwishartPoint::mid(self : StatsdistwishartPoint, other : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistwishartPoint::lerp(self : StatsdistwishartPoint, other : StatsdistwishartPoint, t : Double) -> StatsdistwishartPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistwishartPoint::to_string(self : StatsdistwishartPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistwishartSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_wishart_make_series(vals : Array[Double], name : String) -> StatsdistwishartSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistwishartSeries::len(self : StatsdistwishartSeries) -> Int { self.vals.length() }

pub fn StatsdistwishartSeries::sum(self : StatsdistwishartSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistwishartSeries::mean(self : StatsdistwishartSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistwishartSeries::min(self : StatsdistwishartSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistwishartSeries::max(self : StatsdistwishartSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistwishartSeries::range(self : StatsdistwishartSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistwishartSeries::variance(self : StatsdistwishartSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistwishartSeries::std(self : StatsdistwishartSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistwishartSeries::median(self : StatsdistwishartSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistwishartSeries::scale(self : StatsdistwishartSeries, f : Double) -> StatsdistwishartSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistwishartSeries::add(self : StatsdistwishartSeries, other : StatsdistwishartSeries) -> StatsdistwishartSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistwishartSeries::sub(self : StatsdistwishartSeries, other : StatsdistwishartSeries) -> StatsdistwishartSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistwishartSeries::normalize(self : StatsdistwishartSeries) -> StatsdistwishartSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistwishartSeries::cumsum(self : StatsdistwishartSeries) -> StatsdistwishartSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistwishartSeries::to_string(self : StatsdistwishartSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistwishartMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_wishart_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistwishartMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_wishart_matrix_identity(n : Int) -> StatsdistwishartMatrix {
  let m = stats_dist_wishart_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistwishartMatrix::get(self : StatsdistwishartMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistwishartMatrix::transpose(self : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  let result = stats_dist_wishart_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistwishartMatrix::add(self : StatsdistwishartMatrix, other : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_wishart_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistwishartMatrix::scale(self : StatsdistwishartMatrix, s : Double) -> StatsdistwishartMatrix {
  let result = stats_dist_wishart_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistwishartMatrix::multiply(self : StatsdistwishartMatrix, other : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  if self.cols != other.rows { return stats_dist_wishart_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_wishart_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistwishartMatrix::trace(self : StatsdistwishartMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistwishartMatrix::det(self : StatsdistwishartMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistwishartMatrix::norm(self : StatsdistwishartMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistwishartMatrix::to_string(self : StatsdistwishartMatrix) -> String {
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

pub(all) struct StatsdistwishartVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_wishart_make_vector(comps : Array[Double]) -> StatsdistwishartVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_wishart_vector_zero(dim : Int) -> StatsdistwishartVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistwishartVector::add(self : StatsdistwishartVector, other : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistwishartVector::sub(self : StatsdistwishartVector, other : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistwishartVector::scale(self : StatsdistwishartVector, s : Double) -> StatsdistwishartVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistwishartVector::dot(self : StatsdistwishartVector, other : StatsdistwishartVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistwishartVector::norm(self : StatsdistwishartVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistwishartVector::normalize(self : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistwishartVector::dist(self : StatsdistwishartVector, other : StatsdistwishartVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistwishartVector::to_string(self : StatsdistwishartVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_wishart_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_wishart_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_wishart_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_wishart_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_wishart_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_wishart_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_wishart_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_wishart_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_wishart_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_wishart_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_wishart_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_wishart_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_wishart_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_wishart_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_wishart_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_wishart_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_wishart_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_wishart_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_wishart_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_wishart_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_wishart_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_wishart_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_wishart_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_wishart_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_wishart_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_wishart_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_wishart_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_wishart_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_wishart_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistwishartFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_frame_make(size : Int) -> StatsdistwishartFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_frame_len(s : StatsdistwishartFrame) -> Int { s.size }

pub fn stats_dist_wishart_frame_get(s : StatsdistwishartFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_frame_set(s : StatsdistwishartFrame, i : Int, v : Double) -> StatsdistwishartFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_frame_sum(s : StatsdistwishartFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_frame_mean(s : StatsdistwishartFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_frame_scale(s : StatsdistwishartFrame, f : Double) -> StatsdistwishartFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_frame_add(a : StatsdistwishartFrame, b : StatsdistwishartFrame) -> StatsdistwishartFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_frame_copy(s : StatsdistwishartFrame) -> StatsdistwishartFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_frame_fill(s : StatsdistwishartFrame, v : Double) -> StatsdistwishartFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_frame_min(s : StatsdistwishartFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_frame_max(s : StatsdistwishartFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_frame_to_string(s : StatsdistwishartFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_table_make(size : Int) -> StatsdistwishartTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_table_len(s : StatsdistwishartTable) -> Int { s.size }

pub fn stats_dist_wishart_table_get(s : StatsdistwishartTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_table_set(s : StatsdistwishartTable, i : Int, v : Double) -> StatsdistwishartTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_table_sum(s : StatsdistwishartTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_table_mean(s : StatsdistwishartTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_table_scale(s : StatsdistwishartTable, f : Double) -> StatsdistwishartTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_table_add(a : StatsdistwishartTable, b : StatsdistwishartTable) -> StatsdistwishartTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_table_copy(s : StatsdistwishartTable) -> StatsdistwishartTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_table_fill(s : StatsdistwishartTable, v : Double) -> StatsdistwishartTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_table_min(s : StatsdistwishartTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_table_max(s : StatsdistwishartTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_table_to_string(s : StatsdistwishartTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_graphn_make(size : Int) -> StatsdistwishartGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_graphn_len(s : StatsdistwishartGraphN) -> Int { s.size }

pub fn stats_dist_wishart_graphn_get(s : StatsdistwishartGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_graphn_set(s : StatsdistwishartGraphN, i : Int, v : Double) -> StatsdistwishartGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_graphn_sum(s : StatsdistwishartGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_graphn_mean(s : StatsdistwishartGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_graphn_scale(s : StatsdistwishartGraphN, f : Double) -> StatsdistwishartGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_graphn_add(a : StatsdistwishartGraphN, b : StatsdistwishartGraphN) -> StatsdistwishartGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_graphn_copy(s : StatsdistwishartGraphN) -> StatsdistwishartGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_graphn_fill(s : StatsdistwishartGraphN, v : Double) -> StatsdistwishartGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_graphn_min(s : StatsdistwishartGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_graphn_max(s : StatsdistwishartGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_graphn_to_string(s : StatsdistwishartGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_node_make(size : Int) -> StatsdistwishartNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_node_len(s : StatsdistwishartNode) -> Int { s.size }

pub fn stats_dist_wishart_node_get(s : StatsdistwishartNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_node_set(s : StatsdistwishartNode, i : Int, v : Double) -> StatsdistwishartNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_node_sum(s : StatsdistwishartNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_node_mean(s : StatsdistwishartNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_node_scale(s : StatsdistwishartNode, f : Double) -> StatsdistwishartNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_node_add(a : StatsdistwishartNode, b : StatsdistwishartNode) -> StatsdistwishartNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_node_copy(s : StatsdistwishartNode) -> StatsdistwishartNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_node_fill(s : StatsdistwishartNode, v : Double) -> StatsdistwishartNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_node_min(s : StatsdistwishartNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_node_max(s : StatsdistwishartNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_node_to_string(s : StatsdistwishartNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_edge_make(size : Int) -> StatsdistwishartEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_edge_len(s : StatsdistwishartEdge) -> Int { s.size }

pub fn stats_dist_wishart_edge_get(s : StatsdistwishartEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_edge_set(s : StatsdistwishartEdge, i : Int, v : Double) -> StatsdistwishartEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_edge_sum(s : StatsdistwishartEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_edge_mean(s : StatsdistwishartEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_edge_scale(s : StatsdistwishartEdge, f : Double) -> StatsdistwishartEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_edge_add(a : StatsdistwishartEdge, b : StatsdistwishartEdge) -> StatsdistwishartEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_edge_copy(s : StatsdistwishartEdge) -> StatsdistwishartEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_edge_fill(s : StatsdistwishartEdge, v : Double) -> StatsdistwishartEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_edge_min(s : StatsdistwishartEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_edge_max(s : StatsdistwishartEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_edge_to_string(s : StatsdistwishartEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_path_make(size : Int) -> StatsdistwishartPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_path_len(s : StatsdistwishartPath) -> Int { s.size }

pub fn stats_dist_wishart_path_get(s : StatsdistwishartPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_path_set(s : StatsdistwishartPath, i : Int, v : Double) -> StatsdistwishartPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_path_sum(s : StatsdistwishartPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_path_mean(s : StatsdistwishartPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_path_scale(s : StatsdistwishartPath, f : Double) -> StatsdistwishartPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_path_add(a : StatsdistwishartPath, b : StatsdistwishartPath) -> StatsdistwishartPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_path_copy(s : StatsdistwishartPath) -> StatsdistwishartPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_path_fill(s : StatsdistwishartPath, v : Double) -> StatsdistwishartPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_path_min(s : StatsdistwishartPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_path_max(s : StatsdistwishartPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_path_to_string(s : StatsdistwishartPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_cluster_make(size : Int) -> StatsdistwishartCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_cluster_len(s : StatsdistwishartCluster) -> Int { s.size }

pub fn stats_dist_wishart_cluster_get(s : StatsdistwishartCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_cluster_set(s : StatsdistwishartCluster, i : Int, v : Double) -> StatsdistwishartCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cluster_sum(s : StatsdistwishartCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_cluster_mean(s : StatsdistwishartCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_cluster_scale(s : StatsdistwishartCluster, f : Double) -> StatsdistwishartCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cluster_add(a : StatsdistwishartCluster, b : StatsdistwishartCluster) -> StatsdistwishartCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_cluster_copy(s : StatsdistwishartCluster) -> StatsdistwishartCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cluster_fill(s : StatsdistwishartCluster, v : Double) -> StatsdistwishartCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cluster_min(s : StatsdistwishartCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_cluster_max(s : StatsdistwishartCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_cluster_to_string(s : StatsdistwishartCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_model_make(size : Int) -> StatsdistwishartModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_model_len(s : StatsdistwishartModel) -> Int { s.size }

pub fn stats_dist_wishart_model_get(s : StatsdistwishartModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_model_set(s : StatsdistwishartModel, i : Int, v : Double) -> StatsdistwishartModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_model_sum(s : StatsdistwishartModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_model_mean(s : StatsdistwishartModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_model_scale(s : StatsdistwishartModel, f : Double) -> StatsdistwishartModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_model_add(a : StatsdistwishartModel, b : StatsdistwishartModel) -> StatsdistwishartModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_model_copy(s : StatsdistwishartModel) -> StatsdistwishartModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_model_fill(s : StatsdistwishartModel, v : Double) -> StatsdistwishartModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_model_min(s : StatsdistwishartModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_model_max(s : StatsdistwishartModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_model_to_string(s : StatsdistwishartModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_layer_make(size : Int) -> StatsdistwishartLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_layer_len(s : StatsdistwishartLayer) -> Int { s.size }

pub fn stats_dist_wishart_layer_get(s : StatsdistwishartLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_layer_set(s : StatsdistwishartLayer, i : Int, v : Double) -> StatsdistwishartLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_layer_sum(s : StatsdistwishartLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_layer_mean(s : StatsdistwishartLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_layer_scale(s : StatsdistwishartLayer, f : Double) -> StatsdistwishartLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_layer_add(a : StatsdistwishartLayer, b : StatsdistwishartLayer) -> StatsdistwishartLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_layer_copy(s : StatsdistwishartLayer) -> StatsdistwishartLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_layer_fill(s : StatsdistwishartLayer, v : Double) -> StatsdistwishartLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_layer_min(s : StatsdistwishartLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_layer_max(s : StatsdistwishartLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_layer_to_string(s : StatsdistwishartLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_buffer_make(size : Int) -> StatsdistwishartBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_buffer_len(s : StatsdistwishartBuffer) -> Int { s.size }

pub fn stats_dist_wishart_buffer_get(s : StatsdistwishartBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_buffer_set(s : StatsdistwishartBuffer, i : Int, v : Double) -> StatsdistwishartBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_buffer_sum(s : StatsdistwishartBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_buffer_mean(s : StatsdistwishartBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_buffer_scale(s : StatsdistwishartBuffer, f : Double) -> StatsdistwishartBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_buffer_add(a : StatsdistwishartBuffer, b : StatsdistwishartBuffer) -> StatsdistwishartBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_buffer_copy(s : StatsdistwishartBuffer) -> StatsdistwishartBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_buffer_fill(s : StatsdistwishartBuffer, v : Double) -> StatsdistwishartBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_buffer_min(s : StatsdistwishartBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_buffer_max(s : StatsdistwishartBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_buffer_to_string(s : StatsdistwishartBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_cursor_make(size : Int) -> StatsdistwishartCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_cursor_len(s : StatsdistwishartCursor) -> Int { s.size }

pub fn stats_dist_wishart_cursor_get(s : StatsdistwishartCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_cursor_set(s : StatsdistwishartCursor, i : Int, v : Double) -> StatsdistwishartCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cursor_sum(s : StatsdistwishartCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_cursor_mean(s : StatsdistwishartCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_cursor_scale(s : StatsdistwishartCursor, f : Double) -> StatsdistwishartCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cursor_add(a : StatsdistwishartCursor, b : StatsdistwishartCursor) -> StatsdistwishartCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_cursor_copy(s : StatsdistwishartCursor) -> StatsdistwishartCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cursor_fill(s : StatsdistwishartCursor, v : Double) -> StatsdistwishartCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cursor_min(s : StatsdistwishartCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_cursor_max(s : StatsdistwishartCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_cursor_to_string(s : StatsdistwishartCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_view_make(size : Int) -> StatsdistwishartView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_view_len(s : StatsdistwishartView) -> Int { s.size }

pub fn stats_dist_wishart_view_get(s : StatsdistwishartView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_view_set(s : StatsdistwishartView, i : Int, v : Double) -> StatsdistwishartView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_view_sum(s : StatsdistwishartView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_view_mean(s : StatsdistwishartView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_view_scale(s : StatsdistwishartView, f : Double) -> StatsdistwishartView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_view_add(a : StatsdistwishartView, b : StatsdistwishartView) -> StatsdistwishartView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_view_copy(s : StatsdistwishartView) -> StatsdistwishartView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_view_fill(s : StatsdistwishartView, v : Double) -> StatsdistwishartView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_view_min(s : StatsdistwishartView) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_view_max(s : StatsdistwishartView) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_view_to_string(s : StatsdistwishartView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_range_make(size : Int) -> StatsdistwishartRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_range_len(s : StatsdistwishartRange) -> Int { s.size }

pub fn stats_dist_wishart_range_get(s : StatsdistwishartRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_range_set(s : StatsdistwishartRange, i : Int, v : Double) -> StatsdistwishartRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_range_sum(s : StatsdistwishartRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_range_mean(s : StatsdistwishartRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_range_scale(s : StatsdistwishartRange, f : Double) -> StatsdistwishartRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_range_add(a : StatsdistwishartRange, b : StatsdistwishartRange) -> StatsdistwishartRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_range_copy(s : StatsdistwishartRange) -> StatsdistwishartRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_range_fill(s : StatsdistwishartRange, v : Double) -> StatsdistwishartRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_range_min(s : StatsdistwishartRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_range_max(s : StatsdistwishartRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_range_to_string(s : StatsdistwishartRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_slice_make(size : Int) -> StatsdistwishartSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_slice_len(s : StatsdistwishartSlice) -> Int { s.size }

pub fn stats_dist_wishart_slice_get(s : StatsdistwishartSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_slice_set(s : StatsdistwishartSlice, i : Int, v : Double) -> StatsdistwishartSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_slice_sum(s : StatsdistwishartSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_slice_mean(s : StatsdistwishartSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_slice_scale(s : StatsdistwishartSlice, f : Double) -> StatsdistwishartSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_slice_add(a : StatsdistwishartSlice, b : StatsdistwishartSlice) -> StatsdistwishartSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_slice_copy(s : StatsdistwishartSlice) -> StatsdistwishartSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_slice_fill(s : StatsdistwishartSlice, v : Double) -> StatsdistwishartSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_slice_min(s : StatsdistwishartSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_slice_max(s : StatsdistwishartSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_slice_to_string(s : StatsdistwishartSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

