///===
/// extcore/stats_dist_lognormal

pub(all) struct StatsdistlognormalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_lognormal_make_point(x : Double, y : Double) -> StatsdistlognormalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_lognormal_make_point3(x : Double, y : Double, z : Double) -> StatsdistlognormalPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistlognormalPoint::x(self : StatsdistlognormalPoint) -> Double { self.x }

pub fn StatsdistlognormalPoint::y(self : StatsdistlognormalPoint) -> Double { self.y }

pub fn StatsdistlognormalPoint::z(self : StatsdistlognormalPoint) -> Double { self.z }

pub fn StatsdistlognormalPoint::label(self : StatsdistlognormalPoint) -> Int { self.label }

pub fn StatsdistlognormalPoint::dist(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistlognormalPoint::add(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistlognormalPoint::sub(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistlognormalPoint::scale(self : StatsdistlognormalPoint, s : Double) -> StatsdistlognormalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistlognormalPoint::dot(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistlognormalPoint::cross(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistlognormalPoint::norm(self : StatsdistlognormalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistlognormalPoint::normalize(self : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistlognormalPoint::negate(self : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistlognormalPoint::mid(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistlognormalPoint::lerp(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint, t : Double) -> StatsdistlognormalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistlognormalPoint::to_string(self : StatsdistlognormalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistlognormalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_lognormal_make_series(vals : Array[Double], name : String) -> StatsdistlognormalSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistlognormalSeries::len(self : StatsdistlognormalSeries) -> Int { self.vals.length() }

pub fn StatsdistlognormalSeries::sum(self : StatsdistlognormalSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistlognormalSeries::mean(self : StatsdistlognormalSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistlognormalSeries::min(self : StatsdistlognormalSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistlognormalSeries::max(self : StatsdistlognormalSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistlognormalSeries::range(self : StatsdistlognormalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistlognormalSeries::variance(self : StatsdistlognormalSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistlognormalSeries::std(self : StatsdistlognormalSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistlognormalSeries::median(self : StatsdistlognormalSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistlognormalSeries::scale(self : StatsdistlognormalSeries, f : Double) -> StatsdistlognormalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistlognormalSeries::add(self : StatsdistlognormalSeries, other : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistlognormalSeries::sub(self : StatsdistlognormalSeries, other : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistlognormalSeries::normalize(self : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistlognormalSeries::cumsum(self : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistlognormalSeries::to_string(self : StatsdistlognormalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistlognormalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_lognormal_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistlognormalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_lognormal_matrix_identity(n : Int) -> StatsdistlognormalMatrix {
  let m = stats_dist_lognormal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistlognormalMatrix::get(self : StatsdistlognormalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistlognormalMatrix::transpose(self : StatsdistlognormalMatrix) -> StatsdistlognormalMatrix {
  let result = stats_dist_lognormal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistlognormalMatrix::add(self : StatsdistlognormalMatrix, other : StatsdistlognormalMatrix) -> StatsdistlognormalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_lognormal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistlognormalMatrix::scale(self : StatsdistlognormalMatrix, s : Double) -> StatsdistlognormalMatrix {
  let result = stats_dist_lognormal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistlognormalMatrix::multiply(self : StatsdistlognormalMatrix, other : StatsdistlognormalMatrix) -> StatsdistlognormalMatrix {
  if self.cols != other.rows { return stats_dist_lognormal_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_lognormal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistlognormalMatrix::trace(self : StatsdistlognormalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistlognormalMatrix::det(self : StatsdistlognormalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistlognormalMatrix::norm(self : StatsdistlognormalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistlognormalMatrix::to_string(self : StatsdistlognormalMatrix) -> String {
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

pub(all) struct StatsdistlognormalVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_lognormal_make_vector(comps : Array[Double]) -> StatsdistlognormalVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_lognormal_vector_zero(dim : Int) -> StatsdistlognormalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistlognormalVector::add(self : StatsdistlognormalVector, other : StatsdistlognormalVector) -> StatsdistlognormalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistlognormalVector::sub(self : StatsdistlognormalVector, other : StatsdistlognormalVector) -> StatsdistlognormalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistlognormalVector::scale(self : StatsdistlognormalVector, s : Double) -> StatsdistlognormalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistlognormalVector::dot(self : StatsdistlognormalVector, other : StatsdistlognormalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistlognormalVector::norm(self : StatsdistlognormalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistlognormalVector::normalize(self : StatsdistlognormalVector) -> StatsdistlognormalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistlognormalVector::dist(self : StatsdistlognormalVector, other : StatsdistlognormalVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistlognormalVector::to_string(self : StatsdistlognormalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_lognormal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_lognormal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_lognormal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_lognormal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_lognormal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_lognormal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_lognormal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_lognormal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_lognormal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_lognormal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_lognormal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_lognormal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_lognormal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_lognormal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_lognormal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_lognormal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_lognormal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_lognormal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_lognormal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_lognormal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_lognormal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_lognormal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_lognormal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_lognormal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_lognormal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_lognormal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_lognormal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_lognormal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_lognormal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistlognormalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_frame_make(size : Int) -> StatsdistlognormalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_frame_len(s : StatsdistlognormalFrame) -> Int { s.size }

pub fn stats_dist_lognormal_frame_get(s : StatsdistlognormalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_frame_set(s : StatsdistlognormalFrame, i : Int, v : Double) -> StatsdistlognormalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_frame_sum(s : StatsdistlognormalFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_frame_mean(s : StatsdistlognormalFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_frame_scale(s : StatsdistlognormalFrame, f : Double) -> StatsdistlognormalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_frame_add(a : StatsdistlognormalFrame, b : StatsdistlognormalFrame) -> StatsdistlognormalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_frame_copy(s : StatsdistlognormalFrame) -> StatsdistlognormalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_frame_fill(s : StatsdistlognormalFrame, v : Double) -> StatsdistlognormalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_frame_min(s : StatsdistlognormalFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_frame_max(s : StatsdistlognormalFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_frame_to_string(s : StatsdistlognormalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_table_make(size : Int) -> StatsdistlognormalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_table_len(s : StatsdistlognormalTable) -> Int { s.size }

pub fn stats_dist_lognormal_table_get(s : StatsdistlognormalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_table_set(s : StatsdistlognormalTable, i : Int, v : Double) -> StatsdistlognormalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_table_sum(s : StatsdistlognormalTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_table_mean(s : StatsdistlognormalTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_table_scale(s : StatsdistlognormalTable, f : Double) -> StatsdistlognormalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_table_add(a : StatsdistlognormalTable, b : StatsdistlognormalTable) -> StatsdistlognormalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_table_copy(s : StatsdistlognormalTable) -> StatsdistlognormalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_table_fill(s : StatsdistlognormalTable, v : Double) -> StatsdistlognormalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_table_min(s : StatsdistlognormalTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_table_max(s : StatsdistlognormalTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_table_to_string(s : StatsdistlognormalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_graphn_make(size : Int) -> StatsdistlognormalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_graphn_len(s : StatsdistlognormalGraphN) -> Int { s.size }

pub fn stats_dist_lognormal_graphn_get(s : StatsdistlognormalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_graphn_set(s : StatsdistlognormalGraphN, i : Int, v : Double) -> StatsdistlognormalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_graphn_sum(s : StatsdistlognormalGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_graphn_mean(s : StatsdistlognormalGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_graphn_scale(s : StatsdistlognormalGraphN, f : Double) -> StatsdistlognormalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_graphn_add(a : StatsdistlognormalGraphN, b : StatsdistlognormalGraphN) -> StatsdistlognormalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_graphn_copy(s : StatsdistlognormalGraphN) -> StatsdistlognormalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_graphn_fill(s : StatsdistlognormalGraphN, v : Double) -> StatsdistlognormalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_graphn_min(s : StatsdistlognormalGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_graphn_max(s : StatsdistlognormalGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_graphn_to_string(s : StatsdistlognormalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_node_make(size : Int) -> StatsdistlognormalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_node_len(s : StatsdistlognormalNode) -> Int { s.size }

pub fn stats_dist_lognormal_node_get(s : StatsdistlognormalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_node_set(s : StatsdistlognormalNode, i : Int, v : Double) -> StatsdistlognormalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_node_sum(s : StatsdistlognormalNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_node_mean(s : StatsdistlognormalNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_node_scale(s : StatsdistlognormalNode, f : Double) -> StatsdistlognormalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_node_add(a : StatsdistlognormalNode, b : StatsdistlognormalNode) -> StatsdistlognormalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_node_copy(s : StatsdistlognormalNode) -> StatsdistlognormalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_node_fill(s : StatsdistlognormalNode, v : Double) -> StatsdistlognormalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_node_min(s : StatsdistlognormalNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_node_max(s : StatsdistlognormalNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_node_to_string(s : StatsdistlognormalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_edge_make(size : Int) -> StatsdistlognormalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_edge_len(s : StatsdistlognormalEdge) -> Int { s.size }

pub fn stats_dist_lognormal_edge_get(s : StatsdistlognormalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_edge_set(s : StatsdistlognormalEdge, i : Int, v : Double) -> StatsdistlognormalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_edge_sum(s : StatsdistlognormalEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_edge_mean(s : StatsdistlognormalEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_edge_scale(s : StatsdistlognormalEdge, f : Double) -> StatsdistlognormalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_edge_add(a : StatsdistlognormalEdge, b : StatsdistlognormalEdge) -> StatsdistlognormalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_edge_copy(s : StatsdistlognormalEdge) -> StatsdistlognormalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_edge_fill(s : StatsdistlognormalEdge, v : Double) -> StatsdistlognormalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_edge_min(s : StatsdistlognormalEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_edge_max(s : StatsdistlognormalEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_edge_to_string(s : StatsdistlognormalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_path_make(size : Int) -> StatsdistlognormalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_path_len(s : StatsdistlognormalPath) -> Int { s.size }

pub fn stats_dist_lognormal_path_get(s : StatsdistlognormalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_path_set(s : StatsdistlognormalPath, i : Int, v : Double) -> StatsdistlognormalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_path_sum(s : StatsdistlognormalPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_path_mean(s : StatsdistlognormalPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_path_scale(s : StatsdistlognormalPath, f : Double) -> StatsdistlognormalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_path_add(a : StatsdistlognormalPath, b : StatsdistlognormalPath) -> StatsdistlognormalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_path_copy(s : StatsdistlognormalPath) -> StatsdistlognormalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_path_fill(s : StatsdistlognormalPath, v : Double) -> StatsdistlognormalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_path_min(s : StatsdistlognormalPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_path_max(s : StatsdistlognormalPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_path_to_string(s : StatsdistlognormalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_cluster_make(size : Int) -> StatsdistlognormalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_cluster_len(s : StatsdistlognormalCluster) -> Int { s.size }

pub fn stats_dist_lognormal_cluster_get(s : StatsdistlognormalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_cluster_set(s : StatsdistlognormalCluster, i : Int, v : Double) -> StatsdistlognormalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_cluster_sum(s : StatsdistlognormalCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_cluster_mean(s : StatsdistlognormalCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_cluster_scale(s : StatsdistlognormalCluster, f : Double) -> StatsdistlognormalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_cluster_add(a : StatsdistlognormalCluster, b : StatsdistlognormalCluster) -> StatsdistlognormalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_cluster_copy(s : StatsdistlognormalCluster) -> StatsdistlognormalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_cluster_fill(s : StatsdistlognormalCluster, v : Double) -> StatsdistlognormalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_cluster_min(s : StatsdistlognormalCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_cluster_max(s : StatsdistlognormalCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_cluster_to_string(s : StatsdistlognormalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_model_make(size : Int) -> StatsdistlognormalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_model_len(s : StatsdistlognormalModel) -> Int { s.size }

pub fn stats_dist_lognormal_model_get(s : StatsdistlognormalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_model_set(s : StatsdistlognormalModel, i : Int, v : Double) -> StatsdistlognormalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_model_sum(s : StatsdistlognormalModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_model_mean(s : StatsdistlognormalModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_model_scale(s : StatsdistlognormalModel, f : Double) -> StatsdistlognormalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_model_add(a : StatsdistlognormalModel, b : StatsdistlognormalModel) -> StatsdistlognormalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_model_copy(s : StatsdistlognormalModel) -> StatsdistlognormalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_model_fill(s : StatsdistlognormalModel, v : Double) -> StatsdistlognormalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_model_min(s : StatsdistlognormalModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_model_max(s : StatsdistlognormalModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_model_to_string(s : StatsdistlognormalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_layer_make(size : Int) -> StatsdistlognormalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_layer_len(s : StatsdistlognormalLayer) -> Int { s.size }

pub fn stats_dist_lognormal_layer_get(s : StatsdistlognormalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_layer_set(s : StatsdistlognormalLayer, i : Int, v : Double) -> StatsdistlognormalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_layer_sum(s : StatsdistlognormalLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_layer_mean(s : StatsdistlognormalLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_layer_scale(s : StatsdistlognormalLayer, f : Double) -> StatsdistlognormalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_layer_add(a : StatsdistlognormalLayer, b : StatsdistlognormalLayer) -> StatsdistlognormalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_layer_copy(s : StatsdistlognormalLayer) -> StatsdistlognormalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_layer_fill(s : StatsdistlognormalLayer, v : Double) -> StatsdistlognormalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_layer_min(s : StatsdistlognormalLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_layer_max(s : StatsdistlognormalLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_layer_to_string(s : StatsdistlognormalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_buffer_make(size : Int) -> StatsdistlognormalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_buffer_len(s : StatsdistlognormalBuffer) -> Int { s.size }

pub fn stats_dist_lognormal_buffer_get(s : StatsdistlognormalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_buffer_set(s : StatsdistlognormalBuffer, i : Int, v : Double) -> StatsdistlognormalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_buffer_sum(s : StatsdistlognormalBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_buffer_mean(s : StatsdistlognormalBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_buffer_scale(s : StatsdistlognormalBuffer, f : Double) -> StatsdistlognormalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_buffer_add(a : StatsdistlognormalBuffer, b : StatsdistlognormalBuffer) -> StatsdistlognormalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_buffer_copy(s : StatsdistlognormalBuffer) -> StatsdistlognormalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_buffer_fill(s : StatsdistlognormalBuffer, v : Double) -> StatsdistlognormalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_buffer_min(s : StatsdistlognormalBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_buffer_max(s : StatsdistlognormalBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_buffer_to_string(s : StatsdistlognormalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_cursor_make(size : Int) -> StatsdistlognormalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_cursor_len(s : StatsdistlognormalCursor) -> Int { s.size }

pub fn stats_dist_lognormal_cursor_get(s : StatsdistlognormalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_cursor_set(s : StatsdistlognormalCursor, i : Int, v : Double) -> StatsdistlognormalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_cursor_sum(s : StatsdistlognormalCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_cursor_mean(s : StatsdistlognormalCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_cursor_scale(s : StatsdistlognormalCursor, f : Double) -> StatsdistlognormalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_cursor_add(a : StatsdistlognormalCursor, b : StatsdistlognormalCursor) -> StatsdistlognormalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_cursor_copy(s : StatsdistlognormalCursor) -> StatsdistlognormalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_cursor_fill(s : StatsdistlognormalCursor, v : Double) -> StatsdistlognormalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_cursor_min(s : StatsdistlognormalCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_cursor_max(s : StatsdistlognormalCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_cursor_to_string(s : StatsdistlognormalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_view_make(size : Int) -> StatsdistlognormalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_view_len(s : StatsdistlognormalView) -> Int { s.size }

pub fn stats_dist_lognormal_view_get(s : StatsdistlognormalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_view_set(s : StatsdistlognormalView, i : Int, v : Double) -> StatsdistlognormalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_view_sum(s : StatsdistlognormalView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_view_mean(s : StatsdistlognormalView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_view_scale(s : StatsdistlognormalView, f : Double) -> StatsdistlognormalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_view_add(a : StatsdistlognormalView, b : StatsdistlognormalView) -> StatsdistlognormalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_view_copy(s : StatsdistlognormalView) -> StatsdistlognormalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_view_fill(s : StatsdistlognormalView, v : Double) -> StatsdistlognormalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_view_min(s : StatsdistlognormalView) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_view_max(s : StatsdistlognormalView) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_view_to_string(s : StatsdistlognormalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_range_make(size : Int) -> StatsdistlognormalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_range_len(s : StatsdistlognormalRange) -> Int { s.size }

pub fn stats_dist_lognormal_range_get(s : StatsdistlognormalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_range_set(s : StatsdistlognormalRange, i : Int, v : Double) -> StatsdistlognormalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_range_sum(s : StatsdistlognormalRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_range_mean(s : StatsdistlognormalRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_range_scale(s : StatsdistlognormalRange, f : Double) -> StatsdistlognormalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_range_add(a : StatsdistlognormalRange, b : StatsdistlognormalRange) -> StatsdistlognormalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_range_copy(s : StatsdistlognormalRange) -> StatsdistlognormalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_range_fill(s : StatsdistlognormalRange, v : Double) -> StatsdistlognormalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_range_min(s : StatsdistlognormalRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_range_max(s : StatsdistlognormalRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_range_to_string(s : StatsdistlognormalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_slice_make(size : Int) -> StatsdistlognormalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_slice_len(s : StatsdistlognormalSlice) -> Int { s.size }

pub fn stats_dist_lognormal_slice_get(s : StatsdistlognormalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_slice_set(s : StatsdistlognormalSlice, i : Int, v : Double) -> StatsdistlognormalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_slice_sum(s : StatsdistlognormalSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_slice_mean(s : StatsdistlognormalSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_slice_scale(s : StatsdistlognormalSlice, f : Double) -> StatsdistlognormalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_slice_add(a : StatsdistlognormalSlice, b : StatsdistlognormalSlice) -> StatsdistlognormalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_lognormal_slice_copy(s : StatsdistlognormalSlice) -> StatsdistlognormalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_slice_fill(s : StatsdistlognormalSlice, v : Double) -> StatsdistlognormalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_lognormal_slice_min(s : StatsdistlognormalSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_slice_max(s : StatsdistlognormalSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_slice_to_string(s : StatsdistlognormalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

