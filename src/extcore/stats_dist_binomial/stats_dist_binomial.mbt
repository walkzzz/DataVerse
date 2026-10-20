///===
/// extcore/stats_dist_binomial

pub(all) struct StatsdistbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_binomial_make_point(x : Double, y : Double) -> StatsdistbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_binomial_make_point3(x : Double, y : Double, z : Double) -> StatsdistbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistbinomialPoint::x(self : StatsdistbinomialPoint) -> Double { self.x }

pub fn StatsdistbinomialPoint::y(self : StatsdistbinomialPoint) -> Double { self.y }

pub fn StatsdistbinomialPoint::z(self : StatsdistbinomialPoint) -> Double { self.z }

pub fn StatsdistbinomialPoint::label(self : StatsdistbinomialPoint) -> Int { self.label }

pub fn StatsdistbinomialPoint::dist(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistbinomialPoint::add(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistbinomialPoint::sub(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistbinomialPoint::scale(self : StatsdistbinomialPoint, s : Double) -> StatsdistbinomialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistbinomialPoint::dot(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistbinomialPoint::cross(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistbinomialPoint::norm(self : StatsdistbinomialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistbinomialPoint::normalize(self : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistbinomialPoint::negate(self : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistbinomialPoint::mid(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistbinomialPoint::lerp(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint, t : Double) -> StatsdistbinomialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistbinomialPoint::to_string(self : StatsdistbinomialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_binomial_make_series(vals : Array[Double], name : String) -> StatsdistbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistbinomialSeries::len(self : StatsdistbinomialSeries) -> Int { self.vals.length() }

pub fn StatsdistbinomialSeries::sum(self : StatsdistbinomialSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistbinomialSeries::mean(self : StatsdistbinomialSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistbinomialSeries::min(self : StatsdistbinomialSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistbinomialSeries::max(self : StatsdistbinomialSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistbinomialSeries::range(self : StatsdistbinomialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistbinomialSeries::variance(self : StatsdistbinomialSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistbinomialSeries::std(self : StatsdistbinomialSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistbinomialSeries::median(self : StatsdistbinomialSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistbinomialSeries::scale(self : StatsdistbinomialSeries, f : Double) -> StatsdistbinomialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistbinomialSeries::add(self : StatsdistbinomialSeries, other : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistbinomialSeries::sub(self : StatsdistbinomialSeries, other : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistbinomialSeries::normalize(self : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistbinomialSeries::cumsum(self : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistbinomialSeries::to_string(self : StatsdistbinomialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_binomial_matrix_identity(n : Int) -> StatsdistbinomialMatrix {
  let m = stats_dist_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistbinomialMatrix::get(self : StatsdistbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistbinomialMatrix::transpose(self : StatsdistbinomialMatrix) -> StatsdistbinomialMatrix {
  let result = stats_dist_binomial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistbinomialMatrix::add(self : StatsdistbinomialMatrix, other : StatsdistbinomialMatrix) -> StatsdistbinomialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistbinomialMatrix::scale(self : StatsdistbinomialMatrix, s : Double) -> StatsdistbinomialMatrix {
  let result = stats_dist_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistbinomialMatrix::multiply(self : StatsdistbinomialMatrix, other : StatsdistbinomialMatrix) -> StatsdistbinomialMatrix {
  if self.cols != other.rows { return stats_dist_binomial_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_binomial_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistbinomialMatrix::trace(self : StatsdistbinomialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistbinomialMatrix::det(self : StatsdistbinomialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistbinomialMatrix::norm(self : StatsdistbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistbinomialMatrix::to_string(self : StatsdistbinomialMatrix) -> String {
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

pub(all) struct StatsdistbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_binomial_make_vector(comps : Array[Double]) -> StatsdistbinomialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_binomial_vector_zero(dim : Int) -> StatsdistbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistbinomialVector::add(self : StatsdistbinomialVector, other : StatsdistbinomialVector) -> StatsdistbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistbinomialVector::sub(self : StatsdistbinomialVector, other : StatsdistbinomialVector) -> StatsdistbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistbinomialVector::scale(self : StatsdistbinomialVector, s : Double) -> StatsdistbinomialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistbinomialVector::dot(self : StatsdistbinomialVector, other : StatsdistbinomialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistbinomialVector::norm(self : StatsdistbinomialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistbinomialVector::normalize(self : StatsdistbinomialVector) -> StatsdistbinomialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistbinomialVector::dist(self : StatsdistbinomialVector, other : StatsdistbinomialVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistbinomialVector::to_string(self : StatsdistbinomialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_binomial_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_binomial_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_binomial_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_binomial_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_binomial_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_binomial_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_binomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_binomial_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_binomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_binomial_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_binomial_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_binomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_binomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_binomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_binomial_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_binomial_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_binomial_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_binomial_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_binomial_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_binomial_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_binomial_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_binomial_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_binomial_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_binomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_binomial_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_binomial_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_binomial_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_binomial_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_binomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_frame_make(size : Int) -> StatsdistbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_frame_len(s : StatsdistbinomialFrame) -> Int { s.size }

pub fn stats_dist_binomial_frame_get(s : StatsdistbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_frame_set(s : StatsdistbinomialFrame, i : Int, v : Double) -> StatsdistbinomialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_frame_sum(s : StatsdistbinomialFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_frame_mean(s : StatsdistbinomialFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_frame_scale(s : StatsdistbinomialFrame, f : Double) -> StatsdistbinomialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_frame_add(a : StatsdistbinomialFrame, b : StatsdistbinomialFrame) -> StatsdistbinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_frame_copy(s : StatsdistbinomialFrame) -> StatsdistbinomialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_frame_fill(s : StatsdistbinomialFrame, v : Double) -> StatsdistbinomialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_frame_min(s : StatsdistbinomialFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_frame_max(s : StatsdistbinomialFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_frame_to_string(s : StatsdistbinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_table_make(size : Int) -> StatsdistbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_table_len(s : StatsdistbinomialTable) -> Int { s.size }

pub fn stats_dist_binomial_table_get(s : StatsdistbinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_table_set(s : StatsdistbinomialTable, i : Int, v : Double) -> StatsdistbinomialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_table_sum(s : StatsdistbinomialTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_table_mean(s : StatsdistbinomialTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_table_scale(s : StatsdistbinomialTable, f : Double) -> StatsdistbinomialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_table_add(a : StatsdistbinomialTable, b : StatsdistbinomialTable) -> StatsdistbinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_table_copy(s : StatsdistbinomialTable) -> StatsdistbinomialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_table_fill(s : StatsdistbinomialTable, v : Double) -> StatsdistbinomialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_table_min(s : StatsdistbinomialTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_table_max(s : StatsdistbinomialTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_table_to_string(s : StatsdistbinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_graphn_make(size : Int) -> StatsdistbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_graphn_len(s : StatsdistbinomialGraphN) -> Int { s.size }

pub fn stats_dist_binomial_graphn_get(s : StatsdistbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_graphn_set(s : StatsdistbinomialGraphN, i : Int, v : Double) -> StatsdistbinomialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_graphn_sum(s : StatsdistbinomialGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_graphn_mean(s : StatsdistbinomialGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_graphn_scale(s : StatsdistbinomialGraphN, f : Double) -> StatsdistbinomialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_graphn_add(a : StatsdistbinomialGraphN, b : StatsdistbinomialGraphN) -> StatsdistbinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_graphn_copy(s : StatsdistbinomialGraphN) -> StatsdistbinomialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_graphn_fill(s : StatsdistbinomialGraphN, v : Double) -> StatsdistbinomialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_graphn_min(s : StatsdistbinomialGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_graphn_max(s : StatsdistbinomialGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_graphn_to_string(s : StatsdistbinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_node_make(size : Int) -> StatsdistbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_node_len(s : StatsdistbinomialNode) -> Int { s.size }

pub fn stats_dist_binomial_node_get(s : StatsdistbinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_node_set(s : StatsdistbinomialNode, i : Int, v : Double) -> StatsdistbinomialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_node_sum(s : StatsdistbinomialNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_node_mean(s : StatsdistbinomialNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_node_scale(s : StatsdistbinomialNode, f : Double) -> StatsdistbinomialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_node_add(a : StatsdistbinomialNode, b : StatsdistbinomialNode) -> StatsdistbinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_node_copy(s : StatsdistbinomialNode) -> StatsdistbinomialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_node_fill(s : StatsdistbinomialNode, v : Double) -> StatsdistbinomialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_node_min(s : StatsdistbinomialNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_node_max(s : StatsdistbinomialNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_node_to_string(s : StatsdistbinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_edge_make(size : Int) -> StatsdistbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_edge_len(s : StatsdistbinomialEdge) -> Int { s.size }

pub fn stats_dist_binomial_edge_get(s : StatsdistbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_edge_set(s : StatsdistbinomialEdge, i : Int, v : Double) -> StatsdistbinomialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_edge_sum(s : StatsdistbinomialEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_edge_mean(s : StatsdistbinomialEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_edge_scale(s : StatsdistbinomialEdge, f : Double) -> StatsdistbinomialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_edge_add(a : StatsdistbinomialEdge, b : StatsdistbinomialEdge) -> StatsdistbinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_edge_copy(s : StatsdistbinomialEdge) -> StatsdistbinomialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_edge_fill(s : StatsdistbinomialEdge, v : Double) -> StatsdistbinomialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_edge_min(s : StatsdistbinomialEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_edge_max(s : StatsdistbinomialEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_edge_to_string(s : StatsdistbinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_path_make(size : Int) -> StatsdistbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_path_len(s : StatsdistbinomialPath) -> Int { s.size }

pub fn stats_dist_binomial_path_get(s : StatsdistbinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_path_set(s : StatsdistbinomialPath, i : Int, v : Double) -> StatsdistbinomialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_path_sum(s : StatsdistbinomialPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_path_mean(s : StatsdistbinomialPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_path_scale(s : StatsdistbinomialPath, f : Double) -> StatsdistbinomialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_path_add(a : StatsdistbinomialPath, b : StatsdistbinomialPath) -> StatsdistbinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_path_copy(s : StatsdistbinomialPath) -> StatsdistbinomialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_path_fill(s : StatsdistbinomialPath, v : Double) -> StatsdistbinomialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_path_min(s : StatsdistbinomialPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_path_max(s : StatsdistbinomialPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_path_to_string(s : StatsdistbinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_cluster_make(size : Int) -> StatsdistbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_cluster_len(s : StatsdistbinomialCluster) -> Int { s.size }

pub fn stats_dist_binomial_cluster_get(s : StatsdistbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_cluster_set(s : StatsdistbinomialCluster, i : Int, v : Double) -> StatsdistbinomialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_cluster_sum(s : StatsdistbinomialCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_cluster_mean(s : StatsdistbinomialCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_cluster_scale(s : StatsdistbinomialCluster, f : Double) -> StatsdistbinomialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_cluster_add(a : StatsdistbinomialCluster, b : StatsdistbinomialCluster) -> StatsdistbinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_cluster_copy(s : StatsdistbinomialCluster) -> StatsdistbinomialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_cluster_fill(s : StatsdistbinomialCluster, v : Double) -> StatsdistbinomialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_cluster_min(s : StatsdistbinomialCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_cluster_max(s : StatsdistbinomialCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_cluster_to_string(s : StatsdistbinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_model_make(size : Int) -> StatsdistbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_model_len(s : StatsdistbinomialModel) -> Int { s.size }

pub fn stats_dist_binomial_model_get(s : StatsdistbinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_model_set(s : StatsdistbinomialModel, i : Int, v : Double) -> StatsdistbinomialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_model_sum(s : StatsdistbinomialModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_model_mean(s : StatsdistbinomialModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_model_scale(s : StatsdistbinomialModel, f : Double) -> StatsdistbinomialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_model_add(a : StatsdistbinomialModel, b : StatsdistbinomialModel) -> StatsdistbinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_model_copy(s : StatsdistbinomialModel) -> StatsdistbinomialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_model_fill(s : StatsdistbinomialModel, v : Double) -> StatsdistbinomialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_model_min(s : StatsdistbinomialModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_model_max(s : StatsdistbinomialModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_model_to_string(s : StatsdistbinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_layer_make(size : Int) -> StatsdistbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_layer_len(s : StatsdistbinomialLayer) -> Int { s.size }

pub fn stats_dist_binomial_layer_get(s : StatsdistbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_layer_set(s : StatsdistbinomialLayer, i : Int, v : Double) -> StatsdistbinomialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_layer_sum(s : StatsdistbinomialLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_layer_mean(s : StatsdistbinomialLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_layer_scale(s : StatsdistbinomialLayer, f : Double) -> StatsdistbinomialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_layer_add(a : StatsdistbinomialLayer, b : StatsdistbinomialLayer) -> StatsdistbinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_layer_copy(s : StatsdistbinomialLayer) -> StatsdistbinomialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_layer_fill(s : StatsdistbinomialLayer, v : Double) -> StatsdistbinomialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_layer_min(s : StatsdistbinomialLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_layer_max(s : StatsdistbinomialLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_layer_to_string(s : StatsdistbinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_buffer_make(size : Int) -> StatsdistbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_buffer_len(s : StatsdistbinomialBuffer) -> Int { s.size }

pub fn stats_dist_binomial_buffer_get(s : StatsdistbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_buffer_set(s : StatsdistbinomialBuffer, i : Int, v : Double) -> StatsdistbinomialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_buffer_sum(s : StatsdistbinomialBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_buffer_mean(s : StatsdistbinomialBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_buffer_scale(s : StatsdistbinomialBuffer, f : Double) -> StatsdistbinomialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_buffer_add(a : StatsdistbinomialBuffer, b : StatsdistbinomialBuffer) -> StatsdistbinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_buffer_copy(s : StatsdistbinomialBuffer) -> StatsdistbinomialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_buffer_fill(s : StatsdistbinomialBuffer, v : Double) -> StatsdistbinomialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_buffer_min(s : StatsdistbinomialBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_buffer_max(s : StatsdistbinomialBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_buffer_to_string(s : StatsdistbinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_cursor_make(size : Int) -> StatsdistbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_cursor_len(s : StatsdistbinomialCursor) -> Int { s.size }

pub fn stats_dist_binomial_cursor_get(s : StatsdistbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_cursor_set(s : StatsdistbinomialCursor, i : Int, v : Double) -> StatsdistbinomialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_cursor_sum(s : StatsdistbinomialCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_cursor_mean(s : StatsdistbinomialCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_cursor_scale(s : StatsdistbinomialCursor, f : Double) -> StatsdistbinomialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_cursor_add(a : StatsdistbinomialCursor, b : StatsdistbinomialCursor) -> StatsdistbinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_cursor_copy(s : StatsdistbinomialCursor) -> StatsdistbinomialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_cursor_fill(s : StatsdistbinomialCursor, v : Double) -> StatsdistbinomialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_cursor_min(s : StatsdistbinomialCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_cursor_max(s : StatsdistbinomialCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_cursor_to_string(s : StatsdistbinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_view_make(size : Int) -> StatsdistbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_view_len(s : StatsdistbinomialView) -> Int { s.size }

pub fn stats_dist_binomial_view_get(s : StatsdistbinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_view_set(s : StatsdistbinomialView, i : Int, v : Double) -> StatsdistbinomialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_view_sum(s : StatsdistbinomialView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_view_mean(s : StatsdistbinomialView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_view_scale(s : StatsdistbinomialView, f : Double) -> StatsdistbinomialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_view_add(a : StatsdistbinomialView, b : StatsdistbinomialView) -> StatsdistbinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_view_copy(s : StatsdistbinomialView) -> StatsdistbinomialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_view_fill(s : StatsdistbinomialView, v : Double) -> StatsdistbinomialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_view_min(s : StatsdistbinomialView) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_view_max(s : StatsdistbinomialView) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_view_to_string(s : StatsdistbinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_range_make(size : Int) -> StatsdistbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_range_len(s : StatsdistbinomialRange) -> Int { s.size }

pub fn stats_dist_binomial_range_get(s : StatsdistbinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_range_set(s : StatsdistbinomialRange, i : Int, v : Double) -> StatsdistbinomialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_range_sum(s : StatsdistbinomialRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_range_mean(s : StatsdistbinomialRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_range_scale(s : StatsdistbinomialRange, f : Double) -> StatsdistbinomialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_range_add(a : StatsdistbinomialRange, b : StatsdistbinomialRange) -> StatsdistbinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_range_copy(s : StatsdistbinomialRange) -> StatsdistbinomialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_range_fill(s : StatsdistbinomialRange, v : Double) -> StatsdistbinomialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_range_min(s : StatsdistbinomialRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_range_max(s : StatsdistbinomialRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_range_to_string(s : StatsdistbinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_slice_make(size : Int) -> StatsdistbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_slice_len(s : StatsdistbinomialSlice) -> Int { s.size }

pub fn stats_dist_binomial_slice_get(s : StatsdistbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_slice_set(s : StatsdistbinomialSlice, i : Int, v : Double) -> StatsdistbinomialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_slice_sum(s : StatsdistbinomialSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_binomial_slice_mean(s : StatsdistbinomialSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_binomial_slice_scale(s : StatsdistbinomialSlice, f : Double) -> StatsdistbinomialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_slice_add(a : StatsdistbinomialSlice, b : StatsdistbinomialSlice) -> StatsdistbinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_binomial_slice_copy(s : StatsdistbinomialSlice) -> StatsdistbinomialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_slice_fill(s : StatsdistbinomialSlice, v : Double) -> StatsdistbinomialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_binomial_slice_min(s : StatsdistbinomialSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_binomial_slice_max(s : StatsdistbinomialSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_binomial_slice_to_string(s : StatsdistbinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

