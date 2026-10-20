///===
/// extcore/stats_test_chi_sq

pub(all) struct StatstestchisqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_chi_sq_make_point(x : Double, y : Double) -> StatstestchisqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_chi_sq_make_point3(x : Double, y : Double, z : Double) -> StatstestchisqPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestchisqPoint::x(self : StatstestchisqPoint) -> Double { self.x }

pub fn StatstestchisqPoint::y(self : StatstestchisqPoint) -> Double { self.y }

pub fn StatstestchisqPoint::z(self : StatstestchisqPoint) -> Double { self.z }

pub fn StatstestchisqPoint::label(self : StatstestchisqPoint) -> Int { self.label }

pub fn StatstestchisqPoint::dist(self : StatstestchisqPoint, other : StatstestchisqPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestchisqPoint::add(self : StatstestchisqPoint, other : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestchisqPoint::sub(self : StatstestchisqPoint, other : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestchisqPoint::scale(self : StatstestchisqPoint, s : Double) -> StatstestchisqPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestchisqPoint::dot(self : StatstestchisqPoint, other : StatstestchisqPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestchisqPoint::cross(self : StatstestchisqPoint, other : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestchisqPoint::norm(self : StatstestchisqPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestchisqPoint::normalize(self : StatstestchisqPoint) -> StatstestchisqPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestchisqPoint::negate(self : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestchisqPoint::mid(self : StatstestchisqPoint, other : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestchisqPoint::lerp(self : StatstestchisqPoint, other : StatstestchisqPoint, t : Double) -> StatstestchisqPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestchisqPoint::to_string(self : StatstestchisqPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestchisqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_chi_sq_make_series(vals : Array[Double], name : String) -> StatstestchisqSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestchisqSeries::len(self : StatstestchisqSeries) -> Int { self.vals.length() }

pub fn StatstestchisqSeries::sum(self : StatstestchisqSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestchisqSeries::mean(self : StatstestchisqSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestchisqSeries::min(self : StatstestchisqSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestchisqSeries::max(self : StatstestchisqSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestchisqSeries::range(self : StatstestchisqSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestchisqSeries::variance(self : StatstestchisqSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestchisqSeries::std(self : StatstestchisqSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestchisqSeries::median(self : StatstestchisqSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestchisqSeries::scale(self : StatstestchisqSeries, f : Double) -> StatstestchisqSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestchisqSeries::add(self : StatstestchisqSeries, other : StatstestchisqSeries) -> StatstestchisqSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestchisqSeries::sub(self : StatstestchisqSeries, other : StatstestchisqSeries) -> StatstestchisqSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestchisqSeries::normalize(self : StatstestchisqSeries) -> StatstestchisqSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestchisqSeries::cumsum(self : StatstestchisqSeries) -> StatstestchisqSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestchisqSeries::to_string(self : StatstestchisqSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestchisqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_chi_sq_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestchisqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_chi_sq_matrix_identity(n : Int) -> StatstestchisqMatrix {
  let m = stats_test_chi_sq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestchisqMatrix::get(self : StatstestchisqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestchisqMatrix::transpose(self : StatstestchisqMatrix) -> StatstestchisqMatrix {
  let result = stats_test_chi_sq_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestchisqMatrix::add(self : StatstestchisqMatrix, other : StatstestchisqMatrix) -> StatstestchisqMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_chi_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestchisqMatrix::scale(self : StatstestchisqMatrix, s : Double) -> StatstestchisqMatrix {
  let result = stats_test_chi_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestchisqMatrix::multiply(self : StatstestchisqMatrix, other : StatstestchisqMatrix) -> StatstestchisqMatrix {
  if self.cols != other.rows { return stats_test_chi_sq_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_chi_sq_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatstestchisqMatrix::trace(self : StatstestchisqMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestchisqMatrix::det(self : StatstestchisqMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestchisqMatrix::norm(self : StatstestchisqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestchisqMatrix::to_string(self : StatstestchisqMatrix) -> String {
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

pub(all) struct StatstestchisqVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_chi_sq_make_vector(comps : Array[Double]) -> StatstestchisqVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_chi_sq_vector_zero(dim : Int) -> StatstestchisqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestchisqVector::add(self : StatstestchisqVector, other : StatstestchisqVector) -> StatstestchisqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestchisqVector::sub(self : StatstestchisqVector, other : StatstestchisqVector) -> StatstestchisqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestchisqVector::scale(self : StatstestchisqVector, s : Double) -> StatstestchisqVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestchisqVector::dot(self : StatstestchisqVector, other : StatstestchisqVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestchisqVector::norm(self : StatstestchisqVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestchisqVector::normalize(self : StatstestchisqVector) -> StatstestchisqVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestchisqVector::dist(self : StatstestchisqVector, other : StatstestchisqVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestchisqVector::to_string(self : StatstestchisqVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_chi_sq_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_chi_sq_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_chi_sq_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_chi_sq_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_chi_sq_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_chi_sq_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_chi_sq_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_chi_sq_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_chi_sq_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_chi_sq_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_chi_sq_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_chi_sq_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_chi_sq_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_chi_sq_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_chi_sq_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_chi_sq_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_chi_sq_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_chi_sq_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_chi_sq_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_chi_sq_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_chi_sq_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_chi_sq_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_chi_sq_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_chi_sq_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_chi_sq_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_chi_sq_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_chi_sq_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_chi_sq_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_chi_sq_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestchisqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_frame_make(size : Int) -> StatstestchisqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_frame_len(s : StatstestchisqFrame) -> Int { s.size }

pub fn stats_test_chi_sq_frame_get(s : StatstestchisqFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_frame_set(s : StatstestchisqFrame, i : Int, v : Double) -> StatstestchisqFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_frame_sum(s : StatstestchisqFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_frame_mean(s : StatstestchisqFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_frame_scale(s : StatstestchisqFrame, f : Double) -> StatstestchisqFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_frame_add(a : StatstestchisqFrame, b : StatstestchisqFrame) -> StatstestchisqFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_frame_copy(s : StatstestchisqFrame) -> StatstestchisqFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_frame_fill(s : StatstestchisqFrame, v : Double) -> StatstestchisqFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_frame_min(s : StatstestchisqFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_frame_max(s : StatstestchisqFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_frame_to_string(s : StatstestchisqFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_table_make(size : Int) -> StatstestchisqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_table_len(s : StatstestchisqTable) -> Int { s.size }

pub fn stats_test_chi_sq_table_get(s : StatstestchisqTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_table_set(s : StatstestchisqTable, i : Int, v : Double) -> StatstestchisqTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_table_sum(s : StatstestchisqTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_table_mean(s : StatstestchisqTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_table_scale(s : StatstestchisqTable, f : Double) -> StatstestchisqTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_table_add(a : StatstestchisqTable, b : StatstestchisqTable) -> StatstestchisqTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_table_copy(s : StatstestchisqTable) -> StatstestchisqTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_table_fill(s : StatstestchisqTable, v : Double) -> StatstestchisqTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_table_min(s : StatstestchisqTable) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_table_max(s : StatstestchisqTable) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_table_to_string(s : StatstestchisqTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_graphn_make(size : Int) -> StatstestchisqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_graphn_len(s : StatstestchisqGraphN) -> Int { s.size }

pub fn stats_test_chi_sq_graphn_get(s : StatstestchisqGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_graphn_set(s : StatstestchisqGraphN, i : Int, v : Double) -> StatstestchisqGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_graphn_sum(s : StatstestchisqGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_graphn_mean(s : StatstestchisqGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_graphn_scale(s : StatstestchisqGraphN, f : Double) -> StatstestchisqGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_graphn_add(a : StatstestchisqGraphN, b : StatstestchisqGraphN) -> StatstestchisqGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_graphn_copy(s : StatstestchisqGraphN) -> StatstestchisqGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_graphn_fill(s : StatstestchisqGraphN, v : Double) -> StatstestchisqGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_graphn_min(s : StatstestchisqGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_graphn_max(s : StatstestchisqGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_graphn_to_string(s : StatstestchisqGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_node_make(size : Int) -> StatstestchisqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_node_len(s : StatstestchisqNode) -> Int { s.size }

pub fn stats_test_chi_sq_node_get(s : StatstestchisqNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_node_set(s : StatstestchisqNode, i : Int, v : Double) -> StatstestchisqNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_node_sum(s : StatstestchisqNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_node_mean(s : StatstestchisqNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_node_scale(s : StatstestchisqNode, f : Double) -> StatstestchisqNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_node_add(a : StatstestchisqNode, b : StatstestchisqNode) -> StatstestchisqNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_node_copy(s : StatstestchisqNode) -> StatstestchisqNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_node_fill(s : StatstestchisqNode, v : Double) -> StatstestchisqNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_node_min(s : StatstestchisqNode) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_node_max(s : StatstestchisqNode) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_node_to_string(s : StatstestchisqNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_edge_make(size : Int) -> StatstestchisqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_edge_len(s : StatstestchisqEdge) -> Int { s.size }

pub fn stats_test_chi_sq_edge_get(s : StatstestchisqEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_edge_set(s : StatstestchisqEdge, i : Int, v : Double) -> StatstestchisqEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_edge_sum(s : StatstestchisqEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_edge_mean(s : StatstestchisqEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_edge_scale(s : StatstestchisqEdge, f : Double) -> StatstestchisqEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_edge_add(a : StatstestchisqEdge, b : StatstestchisqEdge) -> StatstestchisqEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_edge_copy(s : StatstestchisqEdge) -> StatstestchisqEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_edge_fill(s : StatstestchisqEdge, v : Double) -> StatstestchisqEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_edge_min(s : StatstestchisqEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_edge_max(s : StatstestchisqEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_edge_to_string(s : StatstestchisqEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_path_make(size : Int) -> StatstestchisqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_path_len(s : StatstestchisqPath) -> Int { s.size }

pub fn stats_test_chi_sq_path_get(s : StatstestchisqPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_path_set(s : StatstestchisqPath, i : Int, v : Double) -> StatstestchisqPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_path_sum(s : StatstestchisqPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_path_mean(s : StatstestchisqPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_path_scale(s : StatstestchisqPath, f : Double) -> StatstestchisqPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_path_add(a : StatstestchisqPath, b : StatstestchisqPath) -> StatstestchisqPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_path_copy(s : StatstestchisqPath) -> StatstestchisqPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_path_fill(s : StatstestchisqPath, v : Double) -> StatstestchisqPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_path_min(s : StatstestchisqPath) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_path_max(s : StatstestchisqPath) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_path_to_string(s : StatstestchisqPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_cluster_make(size : Int) -> StatstestchisqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_cluster_len(s : StatstestchisqCluster) -> Int { s.size }

pub fn stats_test_chi_sq_cluster_get(s : StatstestchisqCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_cluster_set(s : StatstestchisqCluster, i : Int, v : Double) -> StatstestchisqCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_cluster_sum(s : StatstestchisqCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_cluster_mean(s : StatstestchisqCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_cluster_scale(s : StatstestchisqCluster, f : Double) -> StatstestchisqCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_cluster_add(a : StatstestchisqCluster, b : StatstestchisqCluster) -> StatstestchisqCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_cluster_copy(s : StatstestchisqCluster) -> StatstestchisqCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_cluster_fill(s : StatstestchisqCluster, v : Double) -> StatstestchisqCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_cluster_min(s : StatstestchisqCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_cluster_max(s : StatstestchisqCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_cluster_to_string(s : StatstestchisqCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_model_make(size : Int) -> StatstestchisqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_model_len(s : StatstestchisqModel) -> Int { s.size }

pub fn stats_test_chi_sq_model_get(s : StatstestchisqModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_model_set(s : StatstestchisqModel, i : Int, v : Double) -> StatstestchisqModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_model_sum(s : StatstestchisqModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_model_mean(s : StatstestchisqModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_model_scale(s : StatstestchisqModel, f : Double) -> StatstestchisqModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_model_add(a : StatstestchisqModel, b : StatstestchisqModel) -> StatstestchisqModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_model_copy(s : StatstestchisqModel) -> StatstestchisqModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_model_fill(s : StatstestchisqModel, v : Double) -> StatstestchisqModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_model_min(s : StatstestchisqModel) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_model_max(s : StatstestchisqModel) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_model_to_string(s : StatstestchisqModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_layer_make(size : Int) -> StatstestchisqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_layer_len(s : StatstestchisqLayer) -> Int { s.size }

pub fn stats_test_chi_sq_layer_get(s : StatstestchisqLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_layer_set(s : StatstestchisqLayer, i : Int, v : Double) -> StatstestchisqLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_layer_sum(s : StatstestchisqLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_layer_mean(s : StatstestchisqLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_layer_scale(s : StatstestchisqLayer, f : Double) -> StatstestchisqLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_layer_add(a : StatstestchisqLayer, b : StatstestchisqLayer) -> StatstestchisqLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_layer_copy(s : StatstestchisqLayer) -> StatstestchisqLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_layer_fill(s : StatstestchisqLayer, v : Double) -> StatstestchisqLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_layer_min(s : StatstestchisqLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_layer_max(s : StatstestchisqLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_layer_to_string(s : StatstestchisqLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_buffer_make(size : Int) -> StatstestchisqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_buffer_len(s : StatstestchisqBuffer) -> Int { s.size }

pub fn stats_test_chi_sq_buffer_get(s : StatstestchisqBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_buffer_set(s : StatstestchisqBuffer, i : Int, v : Double) -> StatstestchisqBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_buffer_sum(s : StatstestchisqBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_buffer_mean(s : StatstestchisqBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_buffer_scale(s : StatstestchisqBuffer, f : Double) -> StatstestchisqBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_buffer_add(a : StatstestchisqBuffer, b : StatstestchisqBuffer) -> StatstestchisqBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_buffer_copy(s : StatstestchisqBuffer) -> StatstestchisqBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_buffer_fill(s : StatstestchisqBuffer, v : Double) -> StatstestchisqBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_buffer_min(s : StatstestchisqBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_buffer_max(s : StatstestchisqBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_buffer_to_string(s : StatstestchisqBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_cursor_make(size : Int) -> StatstestchisqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_cursor_len(s : StatstestchisqCursor) -> Int { s.size }

pub fn stats_test_chi_sq_cursor_get(s : StatstestchisqCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_cursor_set(s : StatstestchisqCursor, i : Int, v : Double) -> StatstestchisqCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_cursor_sum(s : StatstestchisqCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_cursor_mean(s : StatstestchisqCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_cursor_scale(s : StatstestchisqCursor, f : Double) -> StatstestchisqCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_cursor_add(a : StatstestchisqCursor, b : StatstestchisqCursor) -> StatstestchisqCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_cursor_copy(s : StatstestchisqCursor) -> StatstestchisqCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_cursor_fill(s : StatstestchisqCursor, v : Double) -> StatstestchisqCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_cursor_min(s : StatstestchisqCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_cursor_max(s : StatstestchisqCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_cursor_to_string(s : StatstestchisqCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_view_make(size : Int) -> StatstestchisqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_view_len(s : StatstestchisqView) -> Int { s.size }

pub fn stats_test_chi_sq_view_get(s : StatstestchisqView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_view_set(s : StatstestchisqView, i : Int, v : Double) -> StatstestchisqView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_view_sum(s : StatstestchisqView) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_view_mean(s : StatstestchisqView) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_view_scale(s : StatstestchisqView, f : Double) -> StatstestchisqView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_view_add(a : StatstestchisqView, b : StatstestchisqView) -> StatstestchisqView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_view_copy(s : StatstestchisqView) -> StatstestchisqView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_view_fill(s : StatstestchisqView, v : Double) -> StatstestchisqView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_view_min(s : StatstestchisqView) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_view_max(s : StatstestchisqView) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_view_to_string(s : StatstestchisqView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_range_make(size : Int) -> StatstestchisqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_range_len(s : StatstestchisqRange) -> Int { s.size }

pub fn stats_test_chi_sq_range_get(s : StatstestchisqRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_range_set(s : StatstestchisqRange, i : Int, v : Double) -> StatstestchisqRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_range_sum(s : StatstestchisqRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_range_mean(s : StatstestchisqRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_range_scale(s : StatstestchisqRange, f : Double) -> StatstestchisqRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_range_add(a : StatstestchisqRange, b : StatstestchisqRange) -> StatstestchisqRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_range_copy(s : StatstestchisqRange) -> StatstestchisqRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_range_fill(s : StatstestchisqRange, v : Double) -> StatstestchisqRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_range_min(s : StatstestchisqRange) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_range_max(s : StatstestchisqRange) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_range_to_string(s : StatstestchisqRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_slice_make(size : Int) -> StatstestchisqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_slice_len(s : StatstestchisqSlice) -> Int { s.size }

pub fn stats_test_chi_sq_slice_get(s : StatstestchisqSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_slice_set(s : StatstestchisqSlice, i : Int, v : Double) -> StatstestchisqSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_slice_sum(s : StatstestchisqSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_chi_sq_slice_mean(s : StatstestchisqSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_chi_sq_slice_scale(s : StatstestchisqSlice, f : Double) -> StatstestchisqSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_slice_add(a : StatstestchisqSlice, b : StatstestchisqSlice) -> StatstestchisqSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_chi_sq_slice_copy(s : StatstestchisqSlice) -> StatstestchisqSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_slice_fill(s : StatstestchisqSlice, v : Double) -> StatstestchisqSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_chi_sq_slice_min(s : StatstestchisqSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_chi_sq_slice_max(s : StatstestchisqSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_chi_sq_slice_to_string(s : StatstestchisqSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

