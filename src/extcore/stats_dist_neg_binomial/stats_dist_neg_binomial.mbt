///===
/// extcore/stats_dist_neg_binomial

pub(all) struct StatsdistnegbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_neg_binomial_make_point(x : Double, y : Double) -> StatsdistnegbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_neg_binomial_make_point3(x : Double, y : Double, z : Double) -> StatsdistnegbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistnegbinomialPoint::x(self : StatsdistnegbinomialPoint) -> Double { self.x }

pub fn StatsdistnegbinomialPoint::y(self : StatsdistnegbinomialPoint) -> Double { self.y }

pub fn StatsdistnegbinomialPoint::z(self : StatsdistnegbinomialPoint) -> Double { self.z }

pub fn StatsdistnegbinomialPoint::label(self : StatsdistnegbinomialPoint) -> Int { self.label }

pub fn StatsdistnegbinomialPoint::dist(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistnegbinomialPoint::add(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistnegbinomialPoint::sub(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistnegbinomialPoint::scale(self : StatsdistnegbinomialPoint, s : Double) -> StatsdistnegbinomialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistnegbinomialPoint::dot(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistnegbinomialPoint::cross(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistnegbinomialPoint::norm(self : StatsdistnegbinomialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistnegbinomialPoint::normalize(self : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistnegbinomialPoint::negate(self : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistnegbinomialPoint::mid(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistnegbinomialPoint::lerp(self : StatsdistnegbinomialPoint, other : StatsdistnegbinomialPoint, t : Double) -> StatsdistnegbinomialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistnegbinomialPoint::to_string(self : StatsdistnegbinomialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_neg_binomial_make_series(vals : Array[Double], name : String) -> StatsdistnegbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistnegbinomialSeries::len(self : StatsdistnegbinomialSeries) -> Int { self.vals.length() }

pub fn StatsdistnegbinomialSeries::sum(self : StatsdistnegbinomialSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistnegbinomialSeries::mean(self : StatsdistnegbinomialSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistnegbinomialSeries::min(self : StatsdistnegbinomialSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistnegbinomialSeries::max(self : StatsdistnegbinomialSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistnegbinomialSeries::range(self : StatsdistnegbinomialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistnegbinomialSeries::variance(self : StatsdistnegbinomialSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistnegbinomialSeries::std(self : StatsdistnegbinomialSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistnegbinomialSeries::median(self : StatsdistnegbinomialSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistnegbinomialSeries::scale(self : StatsdistnegbinomialSeries, f : Double) -> StatsdistnegbinomialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistnegbinomialSeries::add(self : StatsdistnegbinomialSeries, other : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistnegbinomialSeries::sub(self : StatsdistnegbinomialSeries, other : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistnegbinomialSeries::normalize(self : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistnegbinomialSeries::cumsum(self : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistnegbinomialSeries::to_string(self : StatsdistnegbinomialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistnegbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_neg_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistnegbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_neg_binomial_matrix_identity(n : Int) -> StatsdistnegbinomialMatrix {
  let m = stats_dist_neg_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistnegbinomialMatrix::get(self : StatsdistnegbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistnegbinomialMatrix::transpose(self : StatsdistnegbinomialMatrix) -> StatsdistnegbinomialMatrix {
  let result = stats_dist_neg_binomial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistnegbinomialMatrix::add(self : StatsdistnegbinomialMatrix, other : StatsdistnegbinomialMatrix) -> StatsdistnegbinomialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_neg_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistnegbinomialMatrix::scale(self : StatsdistnegbinomialMatrix, s : Double) -> StatsdistnegbinomialMatrix {
  let result = stats_dist_neg_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistnegbinomialMatrix::multiply(self : StatsdistnegbinomialMatrix, other : StatsdistnegbinomialMatrix) -> StatsdistnegbinomialMatrix {
  if self.cols != other.rows { return stats_dist_neg_binomial_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_neg_binomial_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistnegbinomialMatrix::trace(self : StatsdistnegbinomialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistnegbinomialMatrix::det(self : StatsdistnegbinomialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistnegbinomialMatrix::norm(self : StatsdistnegbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistnegbinomialMatrix::to_string(self : StatsdistnegbinomialMatrix) -> String {
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

pub(all) struct StatsdistnegbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_neg_binomial_make_vector(comps : Array[Double]) -> StatsdistnegbinomialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_neg_binomial_vector_zero(dim : Int) -> StatsdistnegbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistnegbinomialVector::add(self : StatsdistnegbinomialVector, other : StatsdistnegbinomialVector) -> StatsdistnegbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistnegbinomialVector::sub(self : StatsdistnegbinomialVector, other : StatsdistnegbinomialVector) -> StatsdistnegbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistnegbinomialVector::scale(self : StatsdistnegbinomialVector, s : Double) -> StatsdistnegbinomialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistnegbinomialVector::dot(self : StatsdistnegbinomialVector, other : StatsdistnegbinomialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistnegbinomialVector::norm(self : StatsdistnegbinomialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistnegbinomialVector::normalize(self : StatsdistnegbinomialVector) -> StatsdistnegbinomialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistnegbinomialVector::dist(self : StatsdistnegbinomialVector, other : StatsdistnegbinomialVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistnegbinomialVector::to_string(self : StatsdistnegbinomialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_neg_binomial_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_neg_binomial_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_neg_binomial_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_neg_binomial_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_neg_binomial_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_neg_binomial_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_neg_binomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_neg_binomial_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_neg_binomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_neg_binomial_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_neg_binomial_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_neg_binomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_neg_binomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_neg_binomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_neg_binomial_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_neg_binomial_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_neg_binomial_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_neg_binomial_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_neg_binomial_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_neg_binomial_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_neg_binomial_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_neg_binomial_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_neg_binomial_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_neg_binomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_neg_binomial_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_neg_binomial_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_neg_binomial_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_neg_binomial_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_neg_binomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistnegbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_frame_make(size : Int) -> StatsdistnegbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_frame_len(s : StatsdistnegbinomialFrame) -> Int { s.size }

pub fn stats_dist_neg_binomial_frame_get(s : StatsdistnegbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_frame_set(s : StatsdistnegbinomialFrame, i : Int, v : Double) -> StatsdistnegbinomialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_frame_sum(s : StatsdistnegbinomialFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_frame_mean(s : StatsdistnegbinomialFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_frame_scale(s : StatsdistnegbinomialFrame, f : Double) -> StatsdistnegbinomialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_frame_add(a : StatsdistnegbinomialFrame, b : StatsdistnegbinomialFrame) -> StatsdistnegbinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_frame_copy(s : StatsdistnegbinomialFrame) -> StatsdistnegbinomialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_frame_fill(s : StatsdistnegbinomialFrame, v : Double) -> StatsdistnegbinomialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_frame_min(s : StatsdistnegbinomialFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_frame_max(s : StatsdistnegbinomialFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_frame_to_string(s : StatsdistnegbinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_table_make(size : Int) -> StatsdistnegbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_table_len(s : StatsdistnegbinomialTable) -> Int { s.size }

pub fn stats_dist_neg_binomial_table_get(s : StatsdistnegbinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_table_set(s : StatsdistnegbinomialTable, i : Int, v : Double) -> StatsdistnegbinomialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_table_sum(s : StatsdistnegbinomialTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_table_mean(s : StatsdistnegbinomialTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_table_scale(s : StatsdistnegbinomialTable, f : Double) -> StatsdistnegbinomialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_table_add(a : StatsdistnegbinomialTable, b : StatsdistnegbinomialTable) -> StatsdistnegbinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_table_copy(s : StatsdistnegbinomialTable) -> StatsdistnegbinomialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_table_fill(s : StatsdistnegbinomialTable, v : Double) -> StatsdistnegbinomialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_table_min(s : StatsdistnegbinomialTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_table_max(s : StatsdistnegbinomialTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_table_to_string(s : StatsdistnegbinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_graphn_make(size : Int) -> StatsdistnegbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_graphn_len(s : StatsdistnegbinomialGraphN) -> Int { s.size }

pub fn stats_dist_neg_binomial_graphn_get(s : StatsdistnegbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_graphn_set(s : StatsdistnegbinomialGraphN, i : Int, v : Double) -> StatsdistnegbinomialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_graphn_sum(s : StatsdistnegbinomialGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_graphn_mean(s : StatsdistnegbinomialGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_graphn_scale(s : StatsdistnegbinomialGraphN, f : Double) -> StatsdistnegbinomialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_graphn_add(a : StatsdistnegbinomialGraphN, b : StatsdistnegbinomialGraphN) -> StatsdistnegbinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_graphn_copy(s : StatsdistnegbinomialGraphN) -> StatsdistnegbinomialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_graphn_fill(s : StatsdistnegbinomialGraphN, v : Double) -> StatsdistnegbinomialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_graphn_min(s : StatsdistnegbinomialGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_graphn_max(s : StatsdistnegbinomialGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_graphn_to_string(s : StatsdistnegbinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_node_make(size : Int) -> StatsdistnegbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_node_len(s : StatsdistnegbinomialNode) -> Int { s.size }

pub fn stats_dist_neg_binomial_node_get(s : StatsdistnegbinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_node_set(s : StatsdistnegbinomialNode, i : Int, v : Double) -> StatsdistnegbinomialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_node_sum(s : StatsdistnegbinomialNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_node_mean(s : StatsdistnegbinomialNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_node_scale(s : StatsdistnegbinomialNode, f : Double) -> StatsdistnegbinomialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_node_add(a : StatsdistnegbinomialNode, b : StatsdistnegbinomialNode) -> StatsdistnegbinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_node_copy(s : StatsdistnegbinomialNode) -> StatsdistnegbinomialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_node_fill(s : StatsdistnegbinomialNode, v : Double) -> StatsdistnegbinomialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_node_min(s : StatsdistnegbinomialNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_node_max(s : StatsdistnegbinomialNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_node_to_string(s : StatsdistnegbinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_edge_make(size : Int) -> StatsdistnegbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_edge_len(s : StatsdistnegbinomialEdge) -> Int { s.size }

pub fn stats_dist_neg_binomial_edge_get(s : StatsdistnegbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_edge_set(s : StatsdistnegbinomialEdge, i : Int, v : Double) -> StatsdistnegbinomialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_edge_sum(s : StatsdistnegbinomialEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_edge_mean(s : StatsdistnegbinomialEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_edge_scale(s : StatsdistnegbinomialEdge, f : Double) -> StatsdistnegbinomialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_edge_add(a : StatsdistnegbinomialEdge, b : StatsdistnegbinomialEdge) -> StatsdistnegbinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_edge_copy(s : StatsdistnegbinomialEdge) -> StatsdistnegbinomialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_edge_fill(s : StatsdistnegbinomialEdge, v : Double) -> StatsdistnegbinomialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_edge_min(s : StatsdistnegbinomialEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_edge_max(s : StatsdistnegbinomialEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_edge_to_string(s : StatsdistnegbinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_path_make(size : Int) -> StatsdistnegbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_path_len(s : StatsdistnegbinomialPath) -> Int { s.size }

pub fn stats_dist_neg_binomial_path_get(s : StatsdistnegbinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_path_set(s : StatsdistnegbinomialPath, i : Int, v : Double) -> StatsdistnegbinomialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_path_sum(s : StatsdistnegbinomialPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_path_mean(s : StatsdistnegbinomialPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_path_scale(s : StatsdistnegbinomialPath, f : Double) -> StatsdistnegbinomialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_path_add(a : StatsdistnegbinomialPath, b : StatsdistnegbinomialPath) -> StatsdistnegbinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_path_copy(s : StatsdistnegbinomialPath) -> StatsdistnegbinomialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_path_fill(s : StatsdistnegbinomialPath, v : Double) -> StatsdistnegbinomialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_path_min(s : StatsdistnegbinomialPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_path_max(s : StatsdistnegbinomialPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_path_to_string(s : StatsdistnegbinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_cluster_make(size : Int) -> StatsdistnegbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_cluster_len(s : StatsdistnegbinomialCluster) -> Int { s.size }

pub fn stats_dist_neg_binomial_cluster_get(s : StatsdistnegbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_cluster_set(s : StatsdistnegbinomialCluster, i : Int, v : Double) -> StatsdistnegbinomialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_cluster_sum(s : StatsdistnegbinomialCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_cluster_mean(s : StatsdistnegbinomialCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_cluster_scale(s : StatsdistnegbinomialCluster, f : Double) -> StatsdistnegbinomialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_cluster_add(a : StatsdistnegbinomialCluster, b : StatsdistnegbinomialCluster) -> StatsdistnegbinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_cluster_copy(s : StatsdistnegbinomialCluster) -> StatsdistnegbinomialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_cluster_fill(s : StatsdistnegbinomialCluster, v : Double) -> StatsdistnegbinomialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_cluster_min(s : StatsdistnegbinomialCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_cluster_max(s : StatsdistnegbinomialCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_cluster_to_string(s : StatsdistnegbinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_model_make(size : Int) -> StatsdistnegbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_model_len(s : StatsdistnegbinomialModel) -> Int { s.size }

pub fn stats_dist_neg_binomial_model_get(s : StatsdistnegbinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_model_set(s : StatsdistnegbinomialModel, i : Int, v : Double) -> StatsdistnegbinomialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_model_sum(s : StatsdistnegbinomialModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_model_mean(s : StatsdistnegbinomialModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_model_scale(s : StatsdistnegbinomialModel, f : Double) -> StatsdistnegbinomialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_model_add(a : StatsdistnegbinomialModel, b : StatsdistnegbinomialModel) -> StatsdistnegbinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_model_copy(s : StatsdistnegbinomialModel) -> StatsdistnegbinomialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_model_fill(s : StatsdistnegbinomialModel, v : Double) -> StatsdistnegbinomialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_model_min(s : StatsdistnegbinomialModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_model_max(s : StatsdistnegbinomialModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_model_to_string(s : StatsdistnegbinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_layer_make(size : Int) -> StatsdistnegbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_layer_len(s : StatsdistnegbinomialLayer) -> Int { s.size }

pub fn stats_dist_neg_binomial_layer_get(s : StatsdistnegbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_layer_set(s : StatsdistnegbinomialLayer, i : Int, v : Double) -> StatsdistnegbinomialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_layer_sum(s : StatsdistnegbinomialLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_layer_mean(s : StatsdistnegbinomialLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_layer_scale(s : StatsdistnegbinomialLayer, f : Double) -> StatsdistnegbinomialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_layer_add(a : StatsdistnegbinomialLayer, b : StatsdistnegbinomialLayer) -> StatsdistnegbinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_layer_copy(s : StatsdistnegbinomialLayer) -> StatsdistnegbinomialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_layer_fill(s : StatsdistnegbinomialLayer, v : Double) -> StatsdistnegbinomialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_layer_min(s : StatsdistnegbinomialLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_layer_max(s : StatsdistnegbinomialLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_layer_to_string(s : StatsdistnegbinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_buffer_make(size : Int) -> StatsdistnegbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_buffer_len(s : StatsdistnegbinomialBuffer) -> Int { s.size }

pub fn stats_dist_neg_binomial_buffer_get(s : StatsdistnegbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_buffer_set(s : StatsdistnegbinomialBuffer, i : Int, v : Double) -> StatsdistnegbinomialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_buffer_sum(s : StatsdistnegbinomialBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_buffer_mean(s : StatsdistnegbinomialBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_buffer_scale(s : StatsdistnegbinomialBuffer, f : Double) -> StatsdistnegbinomialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_buffer_add(a : StatsdistnegbinomialBuffer, b : StatsdistnegbinomialBuffer) -> StatsdistnegbinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_buffer_copy(s : StatsdistnegbinomialBuffer) -> StatsdistnegbinomialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_buffer_fill(s : StatsdistnegbinomialBuffer, v : Double) -> StatsdistnegbinomialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_buffer_min(s : StatsdistnegbinomialBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_buffer_max(s : StatsdistnegbinomialBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_buffer_to_string(s : StatsdistnegbinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_cursor_make(size : Int) -> StatsdistnegbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_cursor_len(s : StatsdistnegbinomialCursor) -> Int { s.size }

pub fn stats_dist_neg_binomial_cursor_get(s : StatsdistnegbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_cursor_set(s : StatsdistnegbinomialCursor, i : Int, v : Double) -> StatsdistnegbinomialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_cursor_sum(s : StatsdistnegbinomialCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_cursor_mean(s : StatsdistnegbinomialCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_cursor_scale(s : StatsdistnegbinomialCursor, f : Double) -> StatsdistnegbinomialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_cursor_add(a : StatsdistnegbinomialCursor, b : StatsdistnegbinomialCursor) -> StatsdistnegbinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_cursor_copy(s : StatsdistnegbinomialCursor) -> StatsdistnegbinomialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_cursor_fill(s : StatsdistnegbinomialCursor, v : Double) -> StatsdistnegbinomialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_cursor_min(s : StatsdistnegbinomialCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_cursor_max(s : StatsdistnegbinomialCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_cursor_to_string(s : StatsdistnegbinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_view_make(size : Int) -> StatsdistnegbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_view_len(s : StatsdistnegbinomialView) -> Int { s.size }

pub fn stats_dist_neg_binomial_view_get(s : StatsdistnegbinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_view_set(s : StatsdistnegbinomialView, i : Int, v : Double) -> StatsdistnegbinomialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_view_sum(s : StatsdistnegbinomialView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_view_mean(s : StatsdistnegbinomialView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_view_scale(s : StatsdistnegbinomialView, f : Double) -> StatsdistnegbinomialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_view_add(a : StatsdistnegbinomialView, b : StatsdistnegbinomialView) -> StatsdistnegbinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_view_copy(s : StatsdistnegbinomialView) -> StatsdistnegbinomialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_view_fill(s : StatsdistnegbinomialView, v : Double) -> StatsdistnegbinomialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_view_min(s : StatsdistnegbinomialView) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_view_max(s : StatsdistnegbinomialView) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_view_to_string(s : StatsdistnegbinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_range_make(size : Int) -> StatsdistnegbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_range_len(s : StatsdistnegbinomialRange) -> Int { s.size }

pub fn stats_dist_neg_binomial_range_get(s : StatsdistnegbinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_range_set(s : StatsdistnegbinomialRange, i : Int, v : Double) -> StatsdistnegbinomialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_range_sum(s : StatsdistnegbinomialRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_range_mean(s : StatsdistnegbinomialRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_range_scale(s : StatsdistnegbinomialRange, f : Double) -> StatsdistnegbinomialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_range_add(a : StatsdistnegbinomialRange, b : StatsdistnegbinomialRange) -> StatsdistnegbinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_range_copy(s : StatsdistnegbinomialRange) -> StatsdistnegbinomialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_range_fill(s : StatsdistnegbinomialRange, v : Double) -> StatsdistnegbinomialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_range_min(s : StatsdistnegbinomialRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_range_max(s : StatsdistnegbinomialRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_range_to_string(s : StatsdistnegbinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_slice_make(size : Int) -> StatsdistnegbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_slice_len(s : StatsdistnegbinomialSlice) -> Int { s.size }

pub fn stats_dist_neg_binomial_slice_get(s : StatsdistnegbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_slice_set(s : StatsdistnegbinomialSlice, i : Int, v : Double) -> StatsdistnegbinomialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_slice_sum(s : StatsdistnegbinomialSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_neg_binomial_slice_mean(s : StatsdistnegbinomialSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_neg_binomial_slice_scale(s : StatsdistnegbinomialSlice, f : Double) -> StatsdistnegbinomialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_slice_add(a : StatsdistnegbinomialSlice, b : StatsdistnegbinomialSlice) -> StatsdistnegbinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_neg_binomial_slice_copy(s : StatsdistnegbinomialSlice) -> StatsdistnegbinomialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_slice_fill(s : StatsdistnegbinomialSlice, v : Double) -> StatsdistnegbinomialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_neg_binomial_slice_min(s : StatsdistnegbinomialSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_neg_binomial_slice_max(s : StatsdistnegbinomialSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_neg_binomial_slice_to_string(s : StatsdistnegbinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

