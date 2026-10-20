///===
/// extcore/stats_dist_chi_sq

pub(all) struct StatsdistchisqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_chi_sq_make_point(x : Double, y : Double) -> StatsdistchisqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_chi_sq_make_point3(x : Double, y : Double, z : Double) -> StatsdistchisqPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistchisqPoint::x(self : StatsdistchisqPoint) -> Double { self.x }

pub fn StatsdistchisqPoint::y(self : StatsdistchisqPoint) -> Double { self.y }

pub fn StatsdistchisqPoint::z(self : StatsdistchisqPoint) -> Double { self.z }

pub fn StatsdistchisqPoint::label(self : StatsdistchisqPoint) -> Int { self.label }

pub fn StatsdistchisqPoint::dist(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistchisqPoint::add(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistchisqPoint::sub(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistchisqPoint::scale(self : StatsdistchisqPoint, s : Double) -> StatsdistchisqPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistchisqPoint::dot(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistchisqPoint::cross(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistchisqPoint::norm(self : StatsdistchisqPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistchisqPoint::normalize(self : StatsdistchisqPoint) -> StatsdistchisqPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistchisqPoint::negate(self : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistchisqPoint::mid(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistchisqPoint::lerp(self : StatsdistchisqPoint, other : StatsdistchisqPoint, t : Double) -> StatsdistchisqPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistchisqPoint::to_string(self : StatsdistchisqPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistchisqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_chi_sq_make_series(vals : Array[Double], name : String) -> StatsdistchisqSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistchisqSeries::len(self : StatsdistchisqSeries) -> Int { self.vals.length() }

pub fn StatsdistchisqSeries::sum(self : StatsdistchisqSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistchisqSeries::mean(self : StatsdistchisqSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistchisqSeries::min(self : StatsdistchisqSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistchisqSeries::max(self : StatsdistchisqSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistchisqSeries::range(self : StatsdistchisqSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistchisqSeries::variance(self : StatsdistchisqSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistchisqSeries::std(self : StatsdistchisqSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistchisqSeries::median(self : StatsdistchisqSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistchisqSeries::scale(self : StatsdistchisqSeries, f : Double) -> StatsdistchisqSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistchisqSeries::add(self : StatsdistchisqSeries, other : StatsdistchisqSeries) -> StatsdistchisqSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistchisqSeries::sub(self : StatsdistchisqSeries, other : StatsdistchisqSeries) -> StatsdistchisqSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistchisqSeries::normalize(self : StatsdistchisqSeries) -> StatsdistchisqSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistchisqSeries::cumsum(self : StatsdistchisqSeries) -> StatsdistchisqSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistchisqSeries::to_string(self : StatsdistchisqSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistchisqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_chi_sq_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistchisqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_chi_sq_matrix_identity(n : Int) -> StatsdistchisqMatrix {
  let m = stats_dist_chi_sq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistchisqMatrix::get(self : StatsdistchisqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistchisqMatrix::transpose(self : StatsdistchisqMatrix) -> StatsdistchisqMatrix {
  let result = stats_dist_chi_sq_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistchisqMatrix::add(self : StatsdistchisqMatrix, other : StatsdistchisqMatrix) -> StatsdistchisqMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_chi_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistchisqMatrix::scale(self : StatsdistchisqMatrix, s : Double) -> StatsdistchisqMatrix {
  let result = stats_dist_chi_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistchisqMatrix::multiply(self : StatsdistchisqMatrix, other : StatsdistchisqMatrix) -> StatsdistchisqMatrix {
  if self.cols != other.rows { return stats_dist_chi_sq_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_chi_sq_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistchisqMatrix::trace(self : StatsdistchisqMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistchisqMatrix::det(self : StatsdistchisqMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistchisqMatrix::norm(self : StatsdistchisqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistchisqMatrix::to_string(self : StatsdistchisqMatrix) -> String {
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

pub(all) struct StatsdistchisqVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_chi_sq_make_vector(comps : Array[Double]) -> StatsdistchisqVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_chi_sq_vector_zero(dim : Int) -> StatsdistchisqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistchisqVector::add(self : StatsdistchisqVector, other : StatsdistchisqVector) -> StatsdistchisqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistchisqVector::sub(self : StatsdistchisqVector, other : StatsdistchisqVector) -> StatsdistchisqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistchisqVector::scale(self : StatsdistchisqVector, s : Double) -> StatsdistchisqVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistchisqVector::dot(self : StatsdistchisqVector, other : StatsdistchisqVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistchisqVector::norm(self : StatsdistchisqVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistchisqVector::normalize(self : StatsdistchisqVector) -> StatsdistchisqVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistchisqVector::dist(self : StatsdistchisqVector, other : StatsdistchisqVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistchisqVector::to_string(self : StatsdistchisqVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_chi_sq_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_chi_sq_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_chi_sq_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_chi_sq_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_chi_sq_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_chi_sq_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_chi_sq_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_chi_sq_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_chi_sq_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_chi_sq_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_chi_sq_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_chi_sq_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_chi_sq_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_chi_sq_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_chi_sq_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_chi_sq_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_chi_sq_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_chi_sq_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_chi_sq_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_chi_sq_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_chi_sq_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_chi_sq_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_chi_sq_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_chi_sq_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_chi_sq_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_chi_sq_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_chi_sq_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_chi_sq_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_chi_sq_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistchisqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_frame_make(size : Int) -> StatsdistchisqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_frame_len(s : StatsdistchisqFrame) -> Int { s.size }

pub fn stats_dist_chi_sq_frame_get(s : StatsdistchisqFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_frame_set(s : StatsdistchisqFrame, i : Int, v : Double) -> StatsdistchisqFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_frame_sum(s : StatsdistchisqFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_frame_mean(s : StatsdistchisqFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_frame_scale(s : StatsdistchisqFrame, f : Double) -> StatsdistchisqFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_frame_add(a : StatsdistchisqFrame, b : StatsdistchisqFrame) -> StatsdistchisqFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_frame_copy(s : StatsdistchisqFrame) -> StatsdistchisqFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_frame_fill(s : StatsdistchisqFrame, v : Double) -> StatsdistchisqFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_frame_min(s : StatsdistchisqFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_frame_max(s : StatsdistchisqFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_frame_to_string(s : StatsdistchisqFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_table_make(size : Int) -> StatsdistchisqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_table_len(s : StatsdistchisqTable) -> Int { s.size }

pub fn stats_dist_chi_sq_table_get(s : StatsdistchisqTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_table_set(s : StatsdistchisqTable, i : Int, v : Double) -> StatsdistchisqTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_table_sum(s : StatsdistchisqTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_table_mean(s : StatsdistchisqTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_table_scale(s : StatsdistchisqTable, f : Double) -> StatsdistchisqTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_table_add(a : StatsdistchisqTable, b : StatsdistchisqTable) -> StatsdistchisqTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_table_copy(s : StatsdistchisqTable) -> StatsdistchisqTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_table_fill(s : StatsdistchisqTable, v : Double) -> StatsdistchisqTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_table_min(s : StatsdistchisqTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_table_max(s : StatsdistchisqTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_table_to_string(s : StatsdistchisqTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_graphn_make(size : Int) -> StatsdistchisqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_graphn_len(s : StatsdistchisqGraphN) -> Int { s.size }

pub fn stats_dist_chi_sq_graphn_get(s : StatsdistchisqGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_graphn_set(s : StatsdistchisqGraphN, i : Int, v : Double) -> StatsdistchisqGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_graphn_sum(s : StatsdistchisqGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_graphn_mean(s : StatsdistchisqGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_graphn_scale(s : StatsdistchisqGraphN, f : Double) -> StatsdistchisqGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_graphn_add(a : StatsdistchisqGraphN, b : StatsdistchisqGraphN) -> StatsdistchisqGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_graphn_copy(s : StatsdistchisqGraphN) -> StatsdistchisqGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_graphn_fill(s : StatsdistchisqGraphN, v : Double) -> StatsdistchisqGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_graphn_min(s : StatsdistchisqGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_graphn_max(s : StatsdistchisqGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_graphn_to_string(s : StatsdistchisqGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_node_make(size : Int) -> StatsdistchisqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_node_len(s : StatsdistchisqNode) -> Int { s.size }

pub fn stats_dist_chi_sq_node_get(s : StatsdistchisqNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_node_set(s : StatsdistchisqNode, i : Int, v : Double) -> StatsdistchisqNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_node_sum(s : StatsdistchisqNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_node_mean(s : StatsdistchisqNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_node_scale(s : StatsdistchisqNode, f : Double) -> StatsdistchisqNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_node_add(a : StatsdistchisqNode, b : StatsdistchisqNode) -> StatsdistchisqNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_node_copy(s : StatsdistchisqNode) -> StatsdistchisqNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_node_fill(s : StatsdistchisqNode, v : Double) -> StatsdistchisqNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_node_min(s : StatsdistchisqNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_node_max(s : StatsdistchisqNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_node_to_string(s : StatsdistchisqNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_edge_make(size : Int) -> StatsdistchisqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_edge_len(s : StatsdistchisqEdge) -> Int { s.size }

pub fn stats_dist_chi_sq_edge_get(s : StatsdistchisqEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_edge_set(s : StatsdistchisqEdge, i : Int, v : Double) -> StatsdistchisqEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_edge_sum(s : StatsdistchisqEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_edge_mean(s : StatsdistchisqEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_edge_scale(s : StatsdistchisqEdge, f : Double) -> StatsdistchisqEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_edge_add(a : StatsdistchisqEdge, b : StatsdistchisqEdge) -> StatsdistchisqEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_edge_copy(s : StatsdistchisqEdge) -> StatsdistchisqEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_edge_fill(s : StatsdistchisqEdge, v : Double) -> StatsdistchisqEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_edge_min(s : StatsdistchisqEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_edge_max(s : StatsdistchisqEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_edge_to_string(s : StatsdistchisqEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_path_make(size : Int) -> StatsdistchisqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_path_len(s : StatsdistchisqPath) -> Int { s.size }

pub fn stats_dist_chi_sq_path_get(s : StatsdistchisqPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_path_set(s : StatsdistchisqPath, i : Int, v : Double) -> StatsdistchisqPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_path_sum(s : StatsdistchisqPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_path_mean(s : StatsdistchisqPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_path_scale(s : StatsdistchisqPath, f : Double) -> StatsdistchisqPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_path_add(a : StatsdistchisqPath, b : StatsdistchisqPath) -> StatsdistchisqPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_path_copy(s : StatsdistchisqPath) -> StatsdistchisqPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_path_fill(s : StatsdistchisqPath, v : Double) -> StatsdistchisqPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_path_min(s : StatsdistchisqPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_path_max(s : StatsdistchisqPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_path_to_string(s : StatsdistchisqPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_cluster_make(size : Int) -> StatsdistchisqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_cluster_len(s : StatsdistchisqCluster) -> Int { s.size }

pub fn stats_dist_chi_sq_cluster_get(s : StatsdistchisqCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_cluster_set(s : StatsdistchisqCluster, i : Int, v : Double) -> StatsdistchisqCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_cluster_sum(s : StatsdistchisqCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_cluster_mean(s : StatsdistchisqCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_cluster_scale(s : StatsdistchisqCluster, f : Double) -> StatsdistchisqCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_cluster_add(a : StatsdistchisqCluster, b : StatsdistchisqCluster) -> StatsdistchisqCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_cluster_copy(s : StatsdistchisqCluster) -> StatsdistchisqCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_cluster_fill(s : StatsdistchisqCluster, v : Double) -> StatsdistchisqCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_cluster_min(s : StatsdistchisqCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_cluster_max(s : StatsdistchisqCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_cluster_to_string(s : StatsdistchisqCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_model_make(size : Int) -> StatsdistchisqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_model_len(s : StatsdistchisqModel) -> Int { s.size }

pub fn stats_dist_chi_sq_model_get(s : StatsdistchisqModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_model_set(s : StatsdistchisqModel, i : Int, v : Double) -> StatsdistchisqModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_model_sum(s : StatsdistchisqModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_model_mean(s : StatsdistchisqModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_model_scale(s : StatsdistchisqModel, f : Double) -> StatsdistchisqModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_model_add(a : StatsdistchisqModel, b : StatsdistchisqModel) -> StatsdistchisqModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_model_copy(s : StatsdistchisqModel) -> StatsdistchisqModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_model_fill(s : StatsdistchisqModel, v : Double) -> StatsdistchisqModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_model_min(s : StatsdistchisqModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_model_max(s : StatsdistchisqModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_model_to_string(s : StatsdistchisqModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_layer_make(size : Int) -> StatsdistchisqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_layer_len(s : StatsdistchisqLayer) -> Int { s.size }

pub fn stats_dist_chi_sq_layer_get(s : StatsdistchisqLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_layer_set(s : StatsdistchisqLayer, i : Int, v : Double) -> StatsdistchisqLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_layer_sum(s : StatsdistchisqLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_layer_mean(s : StatsdistchisqLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_layer_scale(s : StatsdistchisqLayer, f : Double) -> StatsdistchisqLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_layer_add(a : StatsdistchisqLayer, b : StatsdistchisqLayer) -> StatsdistchisqLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_layer_copy(s : StatsdistchisqLayer) -> StatsdistchisqLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_layer_fill(s : StatsdistchisqLayer, v : Double) -> StatsdistchisqLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_layer_min(s : StatsdistchisqLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_layer_max(s : StatsdistchisqLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_layer_to_string(s : StatsdistchisqLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_buffer_make(size : Int) -> StatsdistchisqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_buffer_len(s : StatsdistchisqBuffer) -> Int { s.size }

pub fn stats_dist_chi_sq_buffer_get(s : StatsdistchisqBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_buffer_set(s : StatsdistchisqBuffer, i : Int, v : Double) -> StatsdistchisqBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_buffer_sum(s : StatsdistchisqBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_buffer_mean(s : StatsdistchisqBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_buffer_scale(s : StatsdistchisqBuffer, f : Double) -> StatsdistchisqBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_buffer_add(a : StatsdistchisqBuffer, b : StatsdistchisqBuffer) -> StatsdistchisqBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_buffer_copy(s : StatsdistchisqBuffer) -> StatsdistchisqBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_buffer_fill(s : StatsdistchisqBuffer, v : Double) -> StatsdistchisqBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_buffer_min(s : StatsdistchisqBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_buffer_max(s : StatsdistchisqBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_buffer_to_string(s : StatsdistchisqBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_cursor_make(size : Int) -> StatsdistchisqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_cursor_len(s : StatsdistchisqCursor) -> Int { s.size }

pub fn stats_dist_chi_sq_cursor_get(s : StatsdistchisqCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_cursor_set(s : StatsdistchisqCursor, i : Int, v : Double) -> StatsdistchisqCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_cursor_sum(s : StatsdistchisqCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_cursor_mean(s : StatsdistchisqCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_cursor_scale(s : StatsdistchisqCursor, f : Double) -> StatsdistchisqCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_cursor_add(a : StatsdistchisqCursor, b : StatsdistchisqCursor) -> StatsdistchisqCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_cursor_copy(s : StatsdistchisqCursor) -> StatsdistchisqCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_cursor_fill(s : StatsdistchisqCursor, v : Double) -> StatsdistchisqCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_cursor_min(s : StatsdistchisqCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_cursor_max(s : StatsdistchisqCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_cursor_to_string(s : StatsdistchisqCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_view_make(size : Int) -> StatsdistchisqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_view_len(s : StatsdistchisqView) -> Int { s.size }

pub fn stats_dist_chi_sq_view_get(s : StatsdistchisqView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_view_set(s : StatsdistchisqView, i : Int, v : Double) -> StatsdistchisqView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_view_sum(s : StatsdistchisqView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_view_mean(s : StatsdistchisqView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_view_scale(s : StatsdistchisqView, f : Double) -> StatsdistchisqView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_view_add(a : StatsdistchisqView, b : StatsdistchisqView) -> StatsdistchisqView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_view_copy(s : StatsdistchisqView) -> StatsdistchisqView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_view_fill(s : StatsdistchisqView, v : Double) -> StatsdistchisqView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_view_min(s : StatsdistchisqView) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_view_max(s : StatsdistchisqView) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_view_to_string(s : StatsdistchisqView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_range_make(size : Int) -> StatsdistchisqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_range_len(s : StatsdistchisqRange) -> Int { s.size }

pub fn stats_dist_chi_sq_range_get(s : StatsdistchisqRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_range_set(s : StatsdistchisqRange, i : Int, v : Double) -> StatsdistchisqRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_range_sum(s : StatsdistchisqRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_range_mean(s : StatsdistchisqRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_range_scale(s : StatsdistchisqRange, f : Double) -> StatsdistchisqRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_range_add(a : StatsdistchisqRange, b : StatsdistchisqRange) -> StatsdistchisqRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_range_copy(s : StatsdistchisqRange) -> StatsdistchisqRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_range_fill(s : StatsdistchisqRange, v : Double) -> StatsdistchisqRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_range_min(s : StatsdistchisqRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_range_max(s : StatsdistchisqRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_range_to_string(s : StatsdistchisqRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_slice_make(size : Int) -> StatsdistchisqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_slice_len(s : StatsdistchisqSlice) -> Int { s.size }

pub fn stats_dist_chi_sq_slice_get(s : StatsdistchisqSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_slice_set(s : StatsdistchisqSlice, i : Int, v : Double) -> StatsdistchisqSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_slice_sum(s : StatsdistchisqSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_chi_sq_slice_mean(s : StatsdistchisqSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_chi_sq_slice_scale(s : StatsdistchisqSlice, f : Double) -> StatsdistchisqSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_slice_add(a : StatsdistchisqSlice, b : StatsdistchisqSlice) -> StatsdistchisqSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_chi_sq_slice_copy(s : StatsdistchisqSlice) -> StatsdistchisqSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_slice_fill(s : StatsdistchisqSlice, v : Double) -> StatsdistchisqSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_chi_sq_slice_min(s : StatsdistchisqSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_chi_sq_slice_max(s : StatsdistchisqSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_chi_sq_slice_to_string(s : StatsdistchisqSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

