///===
/// extcore/stats_dist_cauchy

pub(all) struct StatsdistcauchyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_cauchy_make_point(x : Double, y : Double) -> StatsdistcauchyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_cauchy_make_point3(x : Double, y : Double, z : Double) -> StatsdistcauchyPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistcauchyPoint::x(self : StatsdistcauchyPoint) -> Double { self.x }

pub fn StatsdistcauchyPoint::y(self : StatsdistcauchyPoint) -> Double { self.y }

pub fn StatsdistcauchyPoint::z(self : StatsdistcauchyPoint) -> Double { self.z }

pub fn StatsdistcauchyPoint::label(self : StatsdistcauchyPoint) -> Int { self.label }

pub fn StatsdistcauchyPoint::dist(self : StatsdistcauchyPoint, other : StatsdistcauchyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistcauchyPoint::add(self : StatsdistcauchyPoint, other : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistcauchyPoint::sub(self : StatsdistcauchyPoint, other : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistcauchyPoint::scale(self : StatsdistcauchyPoint, s : Double) -> StatsdistcauchyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistcauchyPoint::dot(self : StatsdistcauchyPoint, other : StatsdistcauchyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistcauchyPoint::cross(self : StatsdistcauchyPoint, other : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistcauchyPoint::norm(self : StatsdistcauchyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistcauchyPoint::normalize(self : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistcauchyPoint::negate(self : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistcauchyPoint::mid(self : StatsdistcauchyPoint, other : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistcauchyPoint::lerp(self : StatsdistcauchyPoint, other : StatsdistcauchyPoint, t : Double) -> StatsdistcauchyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistcauchyPoint::to_string(self : StatsdistcauchyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistcauchySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_cauchy_make_series(vals : Array[Double], name : String) -> StatsdistcauchySeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistcauchySeries::len(self : StatsdistcauchySeries) -> Int { self.vals.length() }

pub fn StatsdistcauchySeries::sum(self : StatsdistcauchySeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistcauchySeries::mean(self : StatsdistcauchySeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistcauchySeries::min(self : StatsdistcauchySeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistcauchySeries::max(self : StatsdistcauchySeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistcauchySeries::range(self : StatsdistcauchySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistcauchySeries::variance(self : StatsdistcauchySeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistcauchySeries::std(self : StatsdistcauchySeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistcauchySeries::median(self : StatsdistcauchySeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistcauchySeries::scale(self : StatsdistcauchySeries, f : Double) -> StatsdistcauchySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistcauchySeries::add(self : StatsdistcauchySeries, other : StatsdistcauchySeries) -> StatsdistcauchySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistcauchySeries::sub(self : StatsdistcauchySeries, other : StatsdistcauchySeries) -> StatsdistcauchySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistcauchySeries::normalize(self : StatsdistcauchySeries) -> StatsdistcauchySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistcauchySeries::cumsum(self : StatsdistcauchySeries) -> StatsdistcauchySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistcauchySeries::to_string(self : StatsdistcauchySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistcauchyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_cauchy_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistcauchyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_cauchy_matrix_identity(n : Int) -> StatsdistcauchyMatrix {
  let m = stats_dist_cauchy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistcauchyMatrix::get(self : StatsdistcauchyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistcauchyMatrix::transpose(self : StatsdistcauchyMatrix) -> StatsdistcauchyMatrix {
  let result = stats_dist_cauchy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistcauchyMatrix::add(self : StatsdistcauchyMatrix, other : StatsdistcauchyMatrix) -> StatsdistcauchyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_cauchy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistcauchyMatrix::scale(self : StatsdistcauchyMatrix, s : Double) -> StatsdistcauchyMatrix {
  let result = stats_dist_cauchy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistcauchyMatrix::multiply(self : StatsdistcauchyMatrix, other : StatsdistcauchyMatrix) -> StatsdistcauchyMatrix {
  if self.cols != other.rows { return stats_dist_cauchy_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_cauchy_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistcauchyMatrix::trace(self : StatsdistcauchyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistcauchyMatrix::det(self : StatsdistcauchyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistcauchyMatrix::norm(self : StatsdistcauchyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistcauchyMatrix::to_string(self : StatsdistcauchyMatrix) -> String {
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

pub(all) struct StatsdistcauchyVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_cauchy_make_vector(comps : Array[Double]) -> StatsdistcauchyVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_cauchy_vector_zero(dim : Int) -> StatsdistcauchyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistcauchyVector::add(self : StatsdistcauchyVector, other : StatsdistcauchyVector) -> StatsdistcauchyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistcauchyVector::sub(self : StatsdistcauchyVector, other : StatsdistcauchyVector) -> StatsdistcauchyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistcauchyVector::scale(self : StatsdistcauchyVector, s : Double) -> StatsdistcauchyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistcauchyVector::dot(self : StatsdistcauchyVector, other : StatsdistcauchyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistcauchyVector::norm(self : StatsdistcauchyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistcauchyVector::normalize(self : StatsdistcauchyVector) -> StatsdistcauchyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistcauchyVector::dist(self : StatsdistcauchyVector, other : StatsdistcauchyVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistcauchyVector::to_string(self : StatsdistcauchyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_cauchy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_cauchy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_cauchy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_cauchy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_cauchy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_cauchy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_cauchy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_cauchy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_cauchy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_cauchy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_cauchy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_cauchy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_cauchy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_cauchy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_cauchy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_cauchy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_cauchy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_cauchy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_cauchy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_cauchy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_cauchy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_cauchy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_cauchy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_cauchy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_cauchy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_cauchy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_cauchy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_cauchy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_cauchy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistcauchyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_frame_make(size : Int) -> StatsdistcauchyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_frame_len(s : StatsdistcauchyFrame) -> Int { s.size }

pub fn stats_dist_cauchy_frame_get(s : StatsdistcauchyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_frame_set(s : StatsdistcauchyFrame, i : Int, v : Double) -> StatsdistcauchyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_frame_sum(s : StatsdistcauchyFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_frame_mean(s : StatsdistcauchyFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_frame_scale(s : StatsdistcauchyFrame, f : Double) -> StatsdistcauchyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_frame_add(a : StatsdistcauchyFrame, b : StatsdistcauchyFrame) -> StatsdistcauchyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_frame_copy(s : StatsdistcauchyFrame) -> StatsdistcauchyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_frame_fill(s : StatsdistcauchyFrame, v : Double) -> StatsdistcauchyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_frame_min(s : StatsdistcauchyFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_frame_max(s : StatsdistcauchyFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_frame_to_string(s : StatsdistcauchyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_table_make(size : Int) -> StatsdistcauchyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_table_len(s : StatsdistcauchyTable) -> Int { s.size }

pub fn stats_dist_cauchy_table_get(s : StatsdistcauchyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_table_set(s : StatsdistcauchyTable, i : Int, v : Double) -> StatsdistcauchyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_table_sum(s : StatsdistcauchyTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_table_mean(s : StatsdistcauchyTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_table_scale(s : StatsdistcauchyTable, f : Double) -> StatsdistcauchyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_table_add(a : StatsdistcauchyTable, b : StatsdistcauchyTable) -> StatsdistcauchyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_table_copy(s : StatsdistcauchyTable) -> StatsdistcauchyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_table_fill(s : StatsdistcauchyTable, v : Double) -> StatsdistcauchyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_table_min(s : StatsdistcauchyTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_table_max(s : StatsdistcauchyTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_table_to_string(s : StatsdistcauchyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_graphn_make(size : Int) -> StatsdistcauchyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_graphn_len(s : StatsdistcauchyGraphN) -> Int { s.size }

pub fn stats_dist_cauchy_graphn_get(s : StatsdistcauchyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_graphn_set(s : StatsdistcauchyGraphN, i : Int, v : Double) -> StatsdistcauchyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_graphn_sum(s : StatsdistcauchyGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_graphn_mean(s : StatsdistcauchyGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_graphn_scale(s : StatsdistcauchyGraphN, f : Double) -> StatsdistcauchyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_graphn_add(a : StatsdistcauchyGraphN, b : StatsdistcauchyGraphN) -> StatsdistcauchyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_graphn_copy(s : StatsdistcauchyGraphN) -> StatsdistcauchyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_graphn_fill(s : StatsdistcauchyGraphN, v : Double) -> StatsdistcauchyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_graphn_min(s : StatsdistcauchyGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_graphn_max(s : StatsdistcauchyGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_graphn_to_string(s : StatsdistcauchyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_node_make(size : Int) -> StatsdistcauchyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_node_len(s : StatsdistcauchyNode) -> Int { s.size }

pub fn stats_dist_cauchy_node_get(s : StatsdistcauchyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_node_set(s : StatsdistcauchyNode, i : Int, v : Double) -> StatsdistcauchyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_node_sum(s : StatsdistcauchyNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_node_mean(s : StatsdistcauchyNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_node_scale(s : StatsdistcauchyNode, f : Double) -> StatsdistcauchyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_node_add(a : StatsdistcauchyNode, b : StatsdistcauchyNode) -> StatsdistcauchyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_node_copy(s : StatsdistcauchyNode) -> StatsdistcauchyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_node_fill(s : StatsdistcauchyNode, v : Double) -> StatsdistcauchyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_node_min(s : StatsdistcauchyNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_node_max(s : StatsdistcauchyNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_node_to_string(s : StatsdistcauchyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_edge_make(size : Int) -> StatsdistcauchyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_edge_len(s : StatsdistcauchyEdge) -> Int { s.size }

pub fn stats_dist_cauchy_edge_get(s : StatsdistcauchyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_edge_set(s : StatsdistcauchyEdge, i : Int, v : Double) -> StatsdistcauchyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_edge_sum(s : StatsdistcauchyEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_edge_mean(s : StatsdistcauchyEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_edge_scale(s : StatsdistcauchyEdge, f : Double) -> StatsdistcauchyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_edge_add(a : StatsdistcauchyEdge, b : StatsdistcauchyEdge) -> StatsdistcauchyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_edge_copy(s : StatsdistcauchyEdge) -> StatsdistcauchyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_edge_fill(s : StatsdistcauchyEdge, v : Double) -> StatsdistcauchyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_edge_min(s : StatsdistcauchyEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_edge_max(s : StatsdistcauchyEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_edge_to_string(s : StatsdistcauchyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_path_make(size : Int) -> StatsdistcauchyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_path_len(s : StatsdistcauchyPath) -> Int { s.size }

pub fn stats_dist_cauchy_path_get(s : StatsdistcauchyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_path_set(s : StatsdistcauchyPath, i : Int, v : Double) -> StatsdistcauchyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_path_sum(s : StatsdistcauchyPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_path_mean(s : StatsdistcauchyPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_path_scale(s : StatsdistcauchyPath, f : Double) -> StatsdistcauchyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_path_add(a : StatsdistcauchyPath, b : StatsdistcauchyPath) -> StatsdistcauchyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_path_copy(s : StatsdistcauchyPath) -> StatsdistcauchyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_path_fill(s : StatsdistcauchyPath, v : Double) -> StatsdistcauchyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_path_min(s : StatsdistcauchyPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_path_max(s : StatsdistcauchyPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_path_to_string(s : StatsdistcauchyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_cluster_make(size : Int) -> StatsdistcauchyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_cluster_len(s : StatsdistcauchyCluster) -> Int { s.size }

pub fn stats_dist_cauchy_cluster_get(s : StatsdistcauchyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_cluster_set(s : StatsdistcauchyCluster, i : Int, v : Double) -> StatsdistcauchyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_cluster_sum(s : StatsdistcauchyCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_cluster_mean(s : StatsdistcauchyCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_cluster_scale(s : StatsdistcauchyCluster, f : Double) -> StatsdistcauchyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_cluster_add(a : StatsdistcauchyCluster, b : StatsdistcauchyCluster) -> StatsdistcauchyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_cluster_copy(s : StatsdistcauchyCluster) -> StatsdistcauchyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_cluster_fill(s : StatsdistcauchyCluster, v : Double) -> StatsdistcauchyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_cluster_min(s : StatsdistcauchyCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_cluster_max(s : StatsdistcauchyCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_cluster_to_string(s : StatsdistcauchyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_model_make(size : Int) -> StatsdistcauchyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_model_len(s : StatsdistcauchyModel) -> Int { s.size }

pub fn stats_dist_cauchy_model_get(s : StatsdistcauchyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_model_set(s : StatsdistcauchyModel, i : Int, v : Double) -> StatsdistcauchyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_model_sum(s : StatsdistcauchyModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_model_mean(s : StatsdistcauchyModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_model_scale(s : StatsdistcauchyModel, f : Double) -> StatsdistcauchyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_model_add(a : StatsdistcauchyModel, b : StatsdistcauchyModel) -> StatsdistcauchyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_model_copy(s : StatsdistcauchyModel) -> StatsdistcauchyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_model_fill(s : StatsdistcauchyModel, v : Double) -> StatsdistcauchyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_model_min(s : StatsdistcauchyModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_model_max(s : StatsdistcauchyModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_model_to_string(s : StatsdistcauchyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_layer_make(size : Int) -> StatsdistcauchyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_layer_len(s : StatsdistcauchyLayer) -> Int { s.size }

pub fn stats_dist_cauchy_layer_get(s : StatsdistcauchyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_layer_set(s : StatsdistcauchyLayer, i : Int, v : Double) -> StatsdistcauchyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_layer_sum(s : StatsdistcauchyLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_layer_mean(s : StatsdistcauchyLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_layer_scale(s : StatsdistcauchyLayer, f : Double) -> StatsdistcauchyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_layer_add(a : StatsdistcauchyLayer, b : StatsdistcauchyLayer) -> StatsdistcauchyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_layer_copy(s : StatsdistcauchyLayer) -> StatsdistcauchyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_layer_fill(s : StatsdistcauchyLayer, v : Double) -> StatsdistcauchyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_layer_min(s : StatsdistcauchyLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_layer_max(s : StatsdistcauchyLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_layer_to_string(s : StatsdistcauchyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_buffer_make(size : Int) -> StatsdistcauchyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_buffer_len(s : StatsdistcauchyBuffer) -> Int { s.size }

pub fn stats_dist_cauchy_buffer_get(s : StatsdistcauchyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_buffer_set(s : StatsdistcauchyBuffer, i : Int, v : Double) -> StatsdistcauchyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_buffer_sum(s : StatsdistcauchyBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_buffer_mean(s : StatsdistcauchyBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_buffer_scale(s : StatsdistcauchyBuffer, f : Double) -> StatsdistcauchyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_buffer_add(a : StatsdistcauchyBuffer, b : StatsdistcauchyBuffer) -> StatsdistcauchyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_buffer_copy(s : StatsdistcauchyBuffer) -> StatsdistcauchyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_buffer_fill(s : StatsdistcauchyBuffer, v : Double) -> StatsdistcauchyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_buffer_min(s : StatsdistcauchyBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_buffer_max(s : StatsdistcauchyBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_buffer_to_string(s : StatsdistcauchyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_cursor_make(size : Int) -> StatsdistcauchyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_cursor_len(s : StatsdistcauchyCursor) -> Int { s.size }

pub fn stats_dist_cauchy_cursor_get(s : StatsdistcauchyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_cursor_set(s : StatsdistcauchyCursor, i : Int, v : Double) -> StatsdistcauchyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_cursor_sum(s : StatsdistcauchyCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_cursor_mean(s : StatsdistcauchyCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_cursor_scale(s : StatsdistcauchyCursor, f : Double) -> StatsdistcauchyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_cursor_add(a : StatsdistcauchyCursor, b : StatsdistcauchyCursor) -> StatsdistcauchyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_cursor_copy(s : StatsdistcauchyCursor) -> StatsdistcauchyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_cursor_fill(s : StatsdistcauchyCursor, v : Double) -> StatsdistcauchyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_cursor_min(s : StatsdistcauchyCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_cursor_max(s : StatsdistcauchyCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_cursor_to_string(s : StatsdistcauchyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_view_make(size : Int) -> StatsdistcauchyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_view_len(s : StatsdistcauchyView) -> Int { s.size }

pub fn stats_dist_cauchy_view_get(s : StatsdistcauchyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_view_set(s : StatsdistcauchyView, i : Int, v : Double) -> StatsdistcauchyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_view_sum(s : StatsdistcauchyView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_view_mean(s : StatsdistcauchyView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_view_scale(s : StatsdistcauchyView, f : Double) -> StatsdistcauchyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_view_add(a : StatsdistcauchyView, b : StatsdistcauchyView) -> StatsdistcauchyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_view_copy(s : StatsdistcauchyView) -> StatsdistcauchyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_view_fill(s : StatsdistcauchyView, v : Double) -> StatsdistcauchyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_view_min(s : StatsdistcauchyView) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_view_max(s : StatsdistcauchyView) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_view_to_string(s : StatsdistcauchyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_range_make(size : Int) -> StatsdistcauchyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_range_len(s : StatsdistcauchyRange) -> Int { s.size }

pub fn stats_dist_cauchy_range_get(s : StatsdistcauchyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_range_set(s : StatsdistcauchyRange, i : Int, v : Double) -> StatsdistcauchyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_range_sum(s : StatsdistcauchyRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_range_mean(s : StatsdistcauchyRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_range_scale(s : StatsdistcauchyRange, f : Double) -> StatsdistcauchyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_range_add(a : StatsdistcauchyRange, b : StatsdistcauchyRange) -> StatsdistcauchyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_range_copy(s : StatsdistcauchyRange) -> StatsdistcauchyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_range_fill(s : StatsdistcauchyRange, v : Double) -> StatsdistcauchyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_range_min(s : StatsdistcauchyRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_range_max(s : StatsdistcauchyRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_range_to_string(s : StatsdistcauchyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_slice_make(size : Int) -> StatsdistcauchySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_slice_len(s : StatsdistcauchySlice) -> Int { s.size }

pub fn stats_dist_cauchy_slice_get(s : StatsdistcauchySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_slice_set(s : StatsdistcauchySlice, i : Int, v : Double) -> StatsdistcauchySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_slice_sum(s : StatsdistcauchySlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_cauchy_slice_mean(s : StatsdistcauchySlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_cauchy_slice_scale(s : StatsdistcauchySlice, f : Double) -> StatsdistcauchySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_slice_add(a : StatsdistcauchySlice, b : StatsdistcauchySlice) -> StatsdistcauchySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_cauchy_slice_copy(s : StatsdistcauchySlice) -> StatsdistcauchySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_slice_fill(s : StatsdistcauchySlice, v : Double) -> StatsdistcauchySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_cauchy_slice_min(s : StatsdistcauchySlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_cauchy_slice_max(s : StatsdistcauchySlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_cauchy_slice_to_string(s : StatsdistcauchySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

