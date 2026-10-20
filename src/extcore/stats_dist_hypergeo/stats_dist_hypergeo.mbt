///===
/// extcore/stats_dist_hypergeo

pub(all) struct StatsdisthypergeoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_hypergeo_make_point(x : Double, y : Double) -> StatsdisthypergeoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_hypergeo_make_point3(x : Double, y : Double, z : Double) -> StatsdisthypergeoPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdisthypergeoPoint::x(self : StatsdisthypergeoPoint) -> Double { self.x }

pub fn StatsdisthypergeoPoint::y(self : StatsdisthypergeoPoint) -> Double { self.y }

pub fn StatsdisthypergeoPoint::z(self : StatsdisthypergeoPoint) -> Double { self.z }

pub fn StatsdisthypergeoPoint::label(self : StatsdisthypergeoPoint) -> Int { self.label }

pub fn StatsdisthypergeoPoint::dist(self : StatsdisthypergeoPoint, other : StatsdisthypergeoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdisthypergeoPoint::add(self : StatsdisthypergeoPoint, other : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdisthypergeoPoint::sub(self : StatsdisthypergeoPoint, other : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdisthypergeoPoint::scale(self : StatsdisthypergeoPoint, s : Double) -> StatsdisthypergeoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdisthypergeoPoint::dot(self : StatsdisthypergeoPoint, other : StatsdisthypergeoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdisthypergeoPoint::cross(self : StatsdisthypergeoPoint, other : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdisthypergeoPoint::norm(self : StatsdisthypergeoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdisthypergeoPoint::normalize(self : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdisthypergeoPoint::negate(self : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdisthypergeoPoint::mid(self : StatsdisthypergeoPoint, other : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdisthypergeoPoint::lerp(self : StatsdisthypergeoPoint, other : StatsdisthypergeoPoint, t : Double) -> StatsdisthypergeoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdisthypergeoPoint::to_string(self : StatsdisthypergeoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdisthypergeoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_hypergeo_make_series(vals : Array[Double], name : String) -> StatsdisthypergeoSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdisthypergeoSeries::len(self : StatsdisthypergeoSeries) -> Int { self.vals.length() }

pub fn StatsdisthypergeoSeries::sum(self : StatsdisthypergeoSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdisthypergeoSeries::mean(self : StatsdisthypergeoSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdisthypergeoSeries::min(self : StatsdisthypergeoSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdisthypergeoSeries::max(self : StatsdisthypergeoSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdisthypergeoSeries::range(self : StatsdisthypergeoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdisthypergeoSeries::variance(self : StatsdisthypergeoSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdisthypergeoSeries::std(self : StatsdisthypergeoSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdisthypergeoSeries::median(self : StatsdisthypergeoSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdisthypergeoSeries::scale(self : StatsdisthypergeoSeries, f : Double) -> StatsdisthypergeoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdisthypergeoSeries::add(self : StatsdisthypergeoSeries, other : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdisthypergeoSeries::sub(self : StatsdisthypergeoSeries, other : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdisthypergeoSeries::normalize(self : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdisthypergeoSeries::cumsum(self : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdisthypergeoSeries::to_string(self : StatsdisthypergeoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdisthypergeoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_hypergeo_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdisthypergeoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_hypergeo_matrix_identity(n : Int) -> StatsdisthypergeoMatrix {
  let m = stats_dist_hypergeo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdisthypergeoMatrix::get(self : StatsdisthypergeoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdisthypergeoMatrix::transpose(self : StatsdisthypergeoMatrix) -> StatsdisthypergeoMatrix {
  let result = stats_dist_hypergeo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdisthypergeoMatrix::add(self : StatsdisthypergeoMatrix, other : StatsdisthypergeoMatrix) -> StatsdisthypergeoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_hypergeo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdisthypergeoMatrix::scale(self : StatsdisthypergeoMatrix, s : Double) -> StatsdisthypergeoMatrix {
  let result = stats_dist_hypergeo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdisthypergeoMatrix::multiply(self : StatsdisthypergeoMatrix, other : StatsdisthypergeoMatrix) -> StatsdisthypergeoMatrix {
  if self.cols != other.rows { return stats_dist_hypergeo_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_hypergeo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdisthypergeoMatrix::trace(self : StatsdisthypergeoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdisthypergeoMatrix::det(self : StatsdisthypergeoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdisthypergeoMatrix::norm(self : StatsdisthypergeoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdisthypergeoMatrix::to_string(self : StatsdisthypergeoMatrix) -> String {
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

pub(all) struct StatsdisthypergeoVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_hypergeo_make_vector(comps : Array[Double]) -> StatsdisthypergeoVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_hypergeo_vector_zero(dim : Int) -> StatsdisthypergeoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdisthypergeoVector::add(self : StatsdisthypergeoVector, other : StatsdisthypergeoVector) -> StatsdisthypergeoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdisthypergeoVector::sub(self : StatsdisthypergeoVector, other : StatsdisthypergeoVector) -> StatsdisthypergeoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdisthypergeoVector::scale(self : StatsdisthypergeoVector, s : Double) -> StatsdisthypergeoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdisthypergeoVector::dot(self : StatsdisthypergeoVector, other : StatsdisthypergeoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdisthypergeoVector::norm(self : StatsdisthypergeoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdisthypergeoVector::normalize(self : StatsdisthypergeoVector) -> StatsdisthypergeoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdisthypergeoVector::dist(self : StatsdisthypergeoVector, other : StatsdisthypergeoVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdisthypergeoVector::to_string(self : StatsdisthypergeoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_hypergeo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_hypergeo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_hypergeo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_hypergeo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_hypergeo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_hypergeo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_hypergeo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_hypergeo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_hypergeo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_hypergeo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_hypergeo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_hypergeo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_hypergeo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_hypergeo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_hypergeo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_hypergeo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_hypergeo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_hypergeo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_hypergeo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_hypergeo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_hypergeo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_hypergeo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_hypergeo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_hypergeo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_hypergeo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_hypergeo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_hypergeo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_hypergeo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_hypergeo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdisthypergeoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_frame_make(size : Int) -> StatsdisthypergeoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_frame_len(s : StatsdisthypergeoFrame) -> Int { s.size }

pub fn stats_dist_hypergeo_frame_get(s : StatsdisthypergeoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_frame_set(s : StatsdisthypergeoFrame, i : Int, v : Double) -> StatsdisthypergeoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_frame_sum(s : StatsdisthypergeoFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_frame_mean(s : StatsdisthypergeoFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_frame_scale(s : StatsdisthypergeoFrame, f : Double) -> StatsdisthypergeoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_frame_add(a : StatsdisthypergeoFrame, b : StatsdisthypergeoFrame) -> StatsdisthypergeoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_frame_copy(s : StatsdisthypergeoFrame) -> StatsdisthypergeoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_frame_fill(s : StatsdisthypergeoFrame, v : Double) -> StatsdisthypergeoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_frame_min(s : StatsdisthypergeoFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_frame_max(s : StatsdisthypergeoFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_frame_to_string(s : StatsdisthypergeoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_table_make(size : Int) -> StatsdisthypergeoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_table_len(s : StatsdisthypergeoTable) -> Int { s.size }

pub fn stats_dist_hypergeo_table_get(s : StatsdisthypergeoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_table_set(s : StatsdisthypergeoTable, i : Int, v : Double) -> StatsdisthypergeoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_table_sum(s : StatsdisthypergeoTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_table_mean(s : StatsdisthypergeoTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_table_scale(s : StatsdisthypergeoTable, f : Double) -> StatsdisthypergeoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_table_add(a : StatsdisthypergeoTable, b : StatsdisthypergeoTable) -> StatsdisthypergeoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_table_copy(s : StatsdisthypergeoTable) -> StatsdisthypergeoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_table_fill(s : StatsdisthypergeoTable, v : Double) -> StatsdisthypergeoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_table_min(s : StatsdisthypergeoTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_table_max(s : StatsdisthypergeoTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_table_to_string(s : StatsdisthypergeoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_graphn_make(size : Int) -> StatsdisthypergeoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_graphn_len(s : StatsdisthypergeoGraphN) -> Int { s.size }

pub fn stats_dist_hypergeo_graphn_get(s : StatsdisthypergeoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_graphn_set(s : StatsdisthypergeoGraphN, i : Int, v : Double) -> StatsdisthypergeoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_graphn_sum(s : StatsdisthypergeoGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_graphn_mean(s : StatsdisthypergeoGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_graphn_scale(s : StatsdisthypergeoGraphN, f : Double) -> StatsdisthypergeoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_graphn_add(a : StatsdisthypergeoGraphN, b : StatsdisthypergeoGraphN) -> StatsdisthypergeoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_graphn_copy(s : StatsdisthypergeoGraphN) -> StatsdisthypergeoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_graphn_fill(s : StatsdisthypergeoGraphN, v : Double) -> StatsdisthypergeoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_graphn_min(s : StatsdisthypergeoGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_graphn_max(s : StatsdisthypergeoGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_graphn_to_string(s : StatsdisthypergeoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_node_make(size : Int) -> StatsdisthypergeoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_node_len(s : StatsdisthypergeoNode) -> Int { s.size }

pub fn stats_dist_hypergeo_node_get(s : StatsdisthypergeoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_node_set(s : StatsdisthypergeoNode, i : Int, v : Double) -> StatsdisthypergeoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_node_sum(s : StatsdisthypergeoNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_node_mean(s : StatsdisthypergeoNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_node_scale(s : StatsdisthypergeoNode, f : Double) -> StatsdisthypergeoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_node_add(a : StatsdisthypergeoNode, b : StatsdisthypergeoNode) -> StatsdisthypergeoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_node_copy(s : StatsdisthypergeoNode) -> StatsdisthypergeoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_node_fill(s : StatsdisthypergeoNode, v : Double) -> StatsdisthypergeoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_node_min(s : StatsdisthypergeoNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_node_max(s : StatsdisthypergeoNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_node_to_string(s : StatsdisthypergeoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_edge_make(size : Int) -> StatsdisthypergeoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_edge_len(s : StatsdisthypergeoEdge) -> Int { s.size }

pub fn stats_dist_hypergeo_edge_get(s : StatsdisthypergeoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_edge_set(s : StatsdisthypergeoEdge, i : Int, v : Double) -> StatsdisthypergeoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_edge_sum(s : StatsdisthypergeoEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_edge_mean(s : StatsdisthypergeoEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_edge_scale(s : StatsdisthypergeoEdge, f : Double) -> StatsdisthypergeoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_edge_add(a : StatsdisthypergeoEdge, b : StatsdisthypergeoEdge) -> StatsdisthypergeoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_edge_copy(s : StatsdisthypergeoEdge) -> StatsdisthypergeoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_edge_fill(s : StatsdisthypergeoEdge, v : Double) -> StatsdisthypergeoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_edge_min(s : StatsdisthypergeoEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_edge_max(s : StatsdisthypergeoEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_edge_to_string(s : StatsdisthypergeoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_path_make(size : Int) -> StatsdisthypergeoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_path_len(s : StatsdisthypergeoPath) -> Int { s.size }

pub fn stats_dist_hypergeo_path_get(s : StatsdisthypergeoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_path_set(s : StatsdisthypergeoPath, i : Int, v : Double) -> StatsdisthypergeoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_path_sum(s : StatsdisthypergeoPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_path_mean(s : StatsdisthypergeoPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_path_scale(s : StatsdisthypergeoPath, f : Double) -> StatsdisthypergeoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_path_add(a : StatsdisthypergeoPath, b : StatsdisthypergeoPath) -> StatsdisthypergeoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_path_copy(s : StatsdisthypergeoPath) -> StatsdisthypergeoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_path_fill(s : StatsdisthypergeoPath, v : Double) -> StatsdisthypergeoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_path_min(s : StatsdisthypergeoPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_path_max(s : StatsdisthypergeoPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_path_to_string(s : StatsdisthypergeoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_cluster_make(size : Int) -> StatsdisthypergeoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_cluster_len(s : StatsdisthypergeoCluster) -> Int { s.size }

pub fn stats_dist_hypergeo_cluster_get(s : StatsdisthypergeoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_cluster_set(s : StatsdisthypergeoCluster, i : Int, v : Double) -> StatsdisthypergeoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cluster_sum(s : StatsdisthypergeoCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_cluster_mean(s : StatsdisthypergeoCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_cluster_scale(s : StatsdisthypergeoCluster, f : Double) -> StatsdisthypergeoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cluster_add(a : StatsdisthypergeoCluster, b : StatsdisthypergeoCluster) -> StatsdisthypergeoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_cluster_copy(s : StatsdisthypergeoCluster) -> StatsdisthypergeoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cluster_fill(s : StatsdisthypergeoCluster, v : Double) -> StatsdisthypergeoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cluster_min(s : StatsdisthypergeoCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_cluster_max(s : StatsdisthypergeoCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_cluster_to_string(s : StatsdisthypergeoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_model_make(size : Int) -> StatsdisthypergeoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_model_len(s : StatsdisthypergeoModel) -> Int { s.size }

pub fn stats_dist_hypergeo_model_get(s : StatsdisthypergeoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_model_set(s : StatsdisthypergeoModel, i : Int, v : Double) -> StatsdisthypergeoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_model_sum(s : StatsdisthypergeoModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_model_mean(s : StatsdisthypergeoModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_model_scale(s : StatsdisthypergeoModel, f : Double) -> StatsdisthypergeoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_model_add(a : StatsdisthypergeoModel, b : StatsdisthypergeoModel) -> StatsdisthypergeoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_model_copy(s : StatsdisthypergeoModel) -> StatsdisthypergeoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_model_fill(s : StatsdisthypergeoModel, v : Double) -> StatsdisthypergeoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_model_min(s : StatsdisthypergeoModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_model_max(s : StatsdisthypergeoModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_model_to_string(s : StatsdisthypergeoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_layer_make(size : Int) -> StatsdisthypergeoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_layer_len(s : StatsdisthypergeoLayer) -> Int { s.size }

pub fn stats_dist_hypergeo_layer_get(s : StatsdisthypergeoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_layer_set(s : StatsdisthypergeoLayer, i : Int, v : Double) -> StatsdisthypergeoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_layer_sum(s : StatsdisthypergeoLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_layer_mean(s : StatsdisthypergeoLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_layer_scale(s : StatsdisthypergeoLayer, f : Double) -> StatsdisthypergeoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_layer_add(a : StatsdisthypergeoLayer, b : StatsdisthypergeoLayer) -> StatsdisthypergeoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_layer_copy(s : StatsdisthypergeoLayer) -> StatsdisthypergeoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_layer_fill(s : StatsdisthypergeoLayer, v : Double) -> StatsdisthypergeoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_layer_min(s : StatsdisthypergeoLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_layer_max(s : StatsdisthypergeoLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_layer_to_string(s : StatsdisthypergeoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_buffer_make(size : Int) -> StatsdisthypergeoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_buffer_len(s : StatsdisthypergeoBuffer) -> Int { s.size }

pub fn stats_dist_hypergeo_buffer_get(s : StatsdisthypergeoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_buffer_set(s : StatsdisthypergeoBuffer, i : Int, v : Double) -> StatsdisthypergeoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_buffer_sum(s : StatsdisthypergeoBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_buffer_mean(s : StatsdisthypergeoBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_buffer_scale(s : StatsdisthypergeoBuffer, f : Double) -> StatsdisthypergeoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_buffer_add(a : StatsdisthypergeoBuffer, b : StatsdisthypergeoBuffer) -> StatsdisthypergeoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_buffer_copy(s : StatsdisthypergeoBuffer) -> StatsdisthypergeoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_buffer_fill(s : StatsdisthypergeoBuffer, v : Double) -> StatsdisthypergeoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_buffer_min(s : StatsdisthypergeoBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_buffer_max(s : StatsdisthypergeoBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_buffer_to_string(s : StatsdisthypergeoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_cursor_make(size : Int) -> StatsdisthypergeoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_cursor_len(s : StatsdisthypergeoCursor) -> Int { s.size }

pub fn stats_dist_hypergeo_cursor_get(s : StatsdisthypergeoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_cursor_set(s : StatsdisthypergeoCursor, i : Int, v : Double) -> StatsdisthypergeoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cursor_sum(s : StatsdisthypergeoCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_cursor_mean(s : StatsdisthypergeoCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_cursor_scale(s : StatsdisthypergeoCursor, f : Double) -> StatsdisthypergeoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cursor_add(a : StatsdisthypergeoCursor, b : StatsdisthypergeoCursor) -> StatsdisthypergeoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_cursor_copy(s : StatsdisthypergeoCursor) -> StatsdisthypergeoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cursor_fill(s : StatsdisthypergeoCursor, v : Double) -> StatsdisthypergeoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cursor_min(s : StatsdisthypergeoCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_cursor_max(s : StatsdisthypergeoCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_cursor_to_string(s : StatsdisthypergeoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_view_make(size : Int) -> StatsdisthypergeoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_view_len(s : StatsdisthypergeoView) -> Int { s.size }

pub fn stats_dist_hypergeo_view_get(s : StatsdisthypergeoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_view_set(s : StatsdisthypergeoView, i : Int, v : Double) -> StatsdisthypergeoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_view_sum(s : StatsdisthypergeoView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_view_mean(s : StatsdisthypergeoView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_view_scale(s : StatsdisthypergeoView, f : Double) -> StatsdisthypergeoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_view_add(a : StatsdisthypergeoView, b : StatsdisthypergeoView) -> StatsdisthypergeoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_view_copy(s : StatsdisthypergeoView) -> StatsdisthypergeoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_view_fill(s : StatsdisthypergeoView, v : Double) -> StatsdisthypergeoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_view_min(s : StatsdisthypergeoView) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_view_max(s : StatsdisthypergeoView) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_view_to_string(s : StatsdisthypergeoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_range_make(size : Int) -> StatsdisthypergeoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_range_len(s : StatsdisthypergeoRange) -> Int { s.size }

pub fn stats_dist_hypergeo_range_get(s : StatsdisthypergeoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_range_set(s : StatsdisthypergeoRange, i : Int, v : Double) -> StatsdisthypergeoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_range_sum(s : StatsdisthypergeoRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_range_mean(s : StatsdisthypergeoRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_range_scale(s : StatsdisthypergeoRange, f : Double) -> StatsdisthypergeoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_range_add(a : StatsdisthypergeoRange, b : StatsdisthypergeoRange) -> StatsdisthypergeoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_range_copy(s : StatsdisthypergeoRange) -> StatsdisthypergeoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_range_fill(s : StatsdisthypergeoRange, v : Double) -> StatsdisthypergeoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_range_min(s : StatsdisthypergeoRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_range_max(s : StatsdisthypergeoRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_range_to_string(s : StatsdisthypergeoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_slice_make(size : Int) -> StatsdisthypergeoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_slice_len(s : StatsdisthypergeoSlice) -> Int { s.size }

pub fn stats_dist_hypergeo_slice_get(s : StatsdisthypergeoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_slice_set(s : StatsdisthypergeoSlice, i : Int, v : Double) -> StatsdisthypergeoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_slice_sum(s : StatsdisthypergeoSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_slice_mean(s : StatsdisthypergeoSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_slice_scale(s : StatsdisthypergeoSlice, f : Double) -> StatsdisthypergeoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_slice_add(a : StatsdisthypergeoSlice, b : StatsdisthypergeoSlice) -> StatsdisthypergeoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_slice_copy(s : StatsdisthypergeoSlice) -> StatsdisthypergeoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_slice_fill(s : StatsdisthypergeoSlice, v : Double) -> StatsdisthypergeoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_slice_min(s : StatsdisthypergeoSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_slice_max(s : StatsdisthypergeoSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_slice_to_string(s : StatsdisthypergeoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

