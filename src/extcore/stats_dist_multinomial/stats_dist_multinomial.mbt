///===
/// extcore/stats_dist_multinomial

pub(all) struct StatsdistmultinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_multinomial_make_point(x : Double, y : Double) -> StatsdistmultinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_multinomial_make_point3(x : Double, y : Double, z : Double) -> StatsdistmultinomialPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistmultinomialPoint::x(self : StatsdistmultinomialPoint) -> Double { self.x }

pub fn StatsdistmultinomialPoint::y(self : StatsdistmultinomialPoint) -> Double { self.y }

pub fn StatsdistmultinomialPoint::z(self : StatsdistmultinomialPoint) -> Double { self.z }

pub fn StatsdistmultinomialPoint::label(self : StatsdistmultinomialPoint) -> Int { self.label }

pub fn StatsdistmultinomialPoint::dist(self : StatsdistmultinomialPoint, other : StatsdistmultinomialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistmultinomialPoint::add(self : StatsdistmultinomialPoint, other : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistmultinomialPoint::sub(self : StatsdistmultinomialPoint, other : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistmultinomialPoint::scale(self : StatsdistmultinomialPoint, s : Double) -> StatsdistmultinomialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistmultinomialPoint::dot(self : StatsdistmultinomialPoint, other : StatsdistmultinomialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistmultinomialPoint::cross(self : StatsdistmultinomialPoint, other : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistmultinomialPoint::norm(self : StatsdistmultinomialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistmultinomialPoint::normalize(self : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistmultinomialPoint::negate(self : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistmultinomialPoint::mid(self : StatsdistmultinomialPoint, other : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistmultinomialPoint::lerp(self : StatsdistmultinomialPoint, other : StatsdistmultinomialPoint, t : Double) -> StatsdistmultinomialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistmultinomialPoint::to_string(self : StatsdistmultinomialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistmultinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_multinomial_make_series(vals : Array[Double], name : String) -> StatsdistmultinomialSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistmultinomialSeries::len(self : StatsdistmultinomialSeries) -> Int { self.vals.length() }

pub fn StatsdistmultinomialSeries::sum(self : StatsdistmultinomialSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistmultinomialSeries::mean(self : StatsdistmultinomialSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistmultinomialSeries::min(self : StatsdistmultinomialSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistmultinomialSeries::max(self : StatsdistmultinomialSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistmultinomialSeries::range(self : StatsdistmultinomialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistmultinomialSeries::variance(self : StatsdistmultinomialSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistmultinomialSeries::std(self : StatsdistmultinomialSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistmultinomialSeries::median(self : StatsdistmultinomialSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistmultinomialSeries::scale(self : StatsdistmultinomialSeries, f : Double) -> StatsdistmultinomialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistmultinomialSeries::add(self : StatsdistmultinomialSeries, other : StatsdistmultinomialSeries) -> StatsdistmultinomialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistmultinomialSeries::sub(self : StatsdistmultinomialSeries, other : StatsdistmultinomialSeries) -> StatsdistmultinomialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistmultinomialSeries::normalize(self : StatsdistmultinomialSeries) -> StatsdistmultinomialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistmultinomialSeries::cumsum(self : StatsdistmultinomialSeries) -> StatsdistmultinomialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistmultinomialSeries::to_string(self : StatsdistmultinomialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistmultinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_multinomial_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistmultinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_multinomial_matrix_identity(n : Int) -> StatsdistmultinomialMatrix {
  let m = stats_dist_multinomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistmultinomialMatrix::get(self : StatsdistmultinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistmultinomialMatrix::transpose(self : StatsdistmultinomialMatrix) -> StatsdistmultinomialMatrix {
  let result = stats_dist_multinomial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistmultinomialMatrix::add(self : StatsdistmultinomialMatrix, other : StatsdistmultinomialMatrix) -> StatsdistmultinomialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_multinomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistmultinomialMatrix::scale(self : StatsdistmultinomialMatrix, s : Double) -> StatsdistmultinomialMatrix {
  let result = stats_dist_multinomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistmultinomialMatrix::multiply(self : StatsdistmultinomialMatrix, other : StatsdistmultinomialMatrix) -> StatsdistmultinomialMatrix {
  if self.cols != other.rows { return stats_dist_multinomial_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_multinomial_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistmultinomialMatrix::trace(self : StatsdistmultinomialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistmultinomialMatrix::det(self : StatsdistmultinomialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistmultinomialMatrix::norm(self : StatsdistmultinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistmultinomialMatrix::to_string(self : StatsdistmultinomialMatrix) -> String {
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

pub(all) struct StatsdistmultinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_multinomial_make_vector(comps : Array[Double]) -> StatsdistmultinomialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_multinomial_vector_zero(dim : Int) -> StatsdistmultinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistmultinomialVector::add(self : StatsdistmultinomialVector, other : StatsdistmultinomialVector) -> StatsdistmultinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistmultinomialVector::sub(self : StatsdistmultinomialVector, other : StatsdistmultinomialVector) -> StatsdistmultinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistmultinomialVector::scale(self : StatsdistmultinomialVector, s : Double) -> StatsdistmultinomialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistmultinomialVector::dot(self : StatsdistmultinomialVector, other : StatsdistmultinomialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistmultinomialVector::norm(self : StatsdistmultinomialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistmultinomialVector::normalize(self : StatsdistmultinomialVector) -> StatsdistmultinomialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistmultinomialVector::dist(self : StatsdistmultinomialVector, other : StatsdistmultinomialVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistmultinomialVector::to_string(self : StatsdistmultinomialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_multinomial_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_multinomial_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_multinomial_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_multinomial_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_multinomial_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_multinomial_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_multinomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_multinomial_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_multinomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_multinomial_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_multinomial_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_multinomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_multinomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_multinomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_multinomial_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_multinomial_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_multinomial_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_multinomial_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_multinomial_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_multinomial_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_multinomial_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_multinomial_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_multinomial_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_multinomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_multinomial_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_multinomial_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_multinomial_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_multinomial_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_multinomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistmultinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_frame_make(size : Int) -> StatsdistmultinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_frame_len(s : StatsdistmultinomialFrame) -> Int { s.size }

pub fn stats_dist_multinomial_frame_get(s : StatsdistmultinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_frame_set(s : StatsdistmultinomialFrame, i : Int, v : Double) -> StatsdistmultinomialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_frame_sum(s : StatsdistmultinomialFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_frame_mean(s : StatsdistmultinomialFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_frame_scale(s : StatsdistmultinomialFrame, f : Double) -> StatsdistmultinomialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_frame_add(a : StatsdistmultinomialFrame, b : StatsdistmultinomialFrame) -> StatsdistmultinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_frame_copy(s : StatsdistmultinomialFrame) -> StatsdistmultinomialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_frame_fill(s : StatsdistmultinomialFrame, v : Double) -> StatsdistmultinomialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_frame_min(s : StatsdistmultinomialFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_frame_max(s : StatsdistmultinomialFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_frame_to_string(s : StatsdistmultinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_table_make(size : Int) -> StatsdistmultinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_table_len(s : StatsdistmultinomialTable) -> Int { s.size }

pub fn stats_dist_multinomial_table_get(s : StatsdistmultinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_table_set(s : StatsdistmultinomialTable, i : Int, v : Double) -> StatsdistmultinomialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_table_sum(s : StatsdistmultinomialTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_table_mean(s : StatsdistmultinomialTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_table_scale(s : StatsdistmultinomialTable, f : Double) -> StatsdistmultinomialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_table_add(a : StatsdistmultinomialTable, b : StatsdistmultinomialTable) -> StatsdistmultinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_table_copy(s : StatsdistmultinomialTable) -> StatsdistmultinomialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_table_fill(s : StatsdistmultinomialTable, v : Double) -> StatsdistmultinomialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_table_min(s : StatsdistmultinomialTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_table_max(s : StatsdistmultinomialTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_table_to_string(s : StatsdistmultinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_graphn_make(size : Int) -> StatsdistmultinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_graphn_len(s : StatsdistmultinomialGraphN) -> Int { s.size }

pub fn stats_dist_multinomial_graphn_get(s : StatsdistmultinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_graphn_set(s : StatsdistmultinomialGraphN, i : Int, v : Double) -> StatsdistmultinomialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_graphn_sum(s : StatsdistmultinomialGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_graphn_mean(s : StatsdistmultinomialGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_graphn_scale(s : StatsdistmultinomialGraphN, f : Double) -> StatsdistmultinomialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_graphn_add(a : StatsdistmultinomialGraphN, b : StatsdistmultinomialGraphN) -> StatsdistmultinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_graphn_copy(s : StatsdistmultinomialGraphN) -> StatsdistmultinomialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_graphn_fill(s : StatsdistmultinomialGraphN, v : Double) -> StatsdistmultinomialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_graphn_min(s : StatsdistmultinomialGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_graphn_max(s : StatsdistmultinomialGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_graphn_to_string(s : StatsdistmultinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_node_make(size : Int) -> StatsdistmultinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_node_len(s : StatsdistmultinomialNode) -> Int { s.size }

pub fn stats_dist_multinomial_node_get(s : StatsdistmultinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_node_set(s : StatsdistmultinomialNode, i : Int, v : Double) -> StatsdistmultinomialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_node_sum(s : StatsdistmultinomialNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_node_mean(s : StatsdistmultinomialNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_node_scale(s : StatsdistmultinomialNode, f : Double) -> StatsdistmultinomialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_node_add(a : StatsdistmultinomialNode, b : StatsdistmultinomialNode) -> StatsdistmultinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_node_copy(s : StatsdistmultinomialNode) -> StatsdistmultinomialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_node_fill(s : StatsdistmultinomialNode, v : Double) -> StatsdistmultinomialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_node_min(s : StatsdistmultinomialNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_node_max(s : StatsdistmultinomialNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_node_to_string(s : StatsdistmultinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_edge_make(size : Int) -> StatsdistmultinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_edge_len(s : StatsdistmultinomialEdge) -> Int { s.size }

pub fn stats_dist_multinomial_edge_get(s : StatsdistmultinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_edge_set(s : StatsdistmultinomialEdge, i : Int, v : Double) -> StatsdistmultinomialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_edge_sum(s : StatsdistmultinomialEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_edge_mean(s : StatsdistmultinomialEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_edge_scale(s : StatsdistmultinomialEdge, f : Double) -> StatsdistmultinomialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_edge_add(a : StatsdistmultinomialEdge, b : StatsdistmultinomialEdge) -> StatsdistmultinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_edge_copy(s : StatsdistmultinomialEdge) -> StatsdistmultinomialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_edge_fill(s : StatsdistmultinomialEdge, v : Double) -> StatsdistmultinomialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_edge_min(s : StatsdistmultinomialEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_edge_max(s : StatsdistmultinomialEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_edge_to_string(s : StatsdistmultinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_path_make(size : Int) -> StatsdistmultinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_path_len(s : StatsdistmultinomialPath) -> Int { s.size }

pub fn stats_dist_multinomial_path_get(s : StatsdistmultinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_path_set(s : StatsdistmultinomialPath, i : Int, v : Double) -> StatsdistmultinomialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_path_sum(s : StatsdistmultinomialPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_path_mean(s : StatsdistmultinomialPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_path_scale(s : StatsdistmultinomialPath, f : Double) -> StatsdistmultinomialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_path_add(a : StatsdistmultinomialPath, b : StatsdistmultinomialPath) -> StatsdistmultinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_path_copy(s : StatsdistmultinomialPath) -> StatsdistmultinomialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_path_fill(s : StatsdistmultinomialPath, v : Double) -> StatsdistmultinomialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_path_min(s : StatsdistmultinomialPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_path_max(s : StatsdistmultinomialPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_path_to_string(s : StatsdistmultinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_cluster_make(size : Int) -> StatsdistmultinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_cluster_len(s : StatsdistmultinomialCluster) -> Int { s.size }

pub fn stats_dist_multinomial_cluster_get(s : StatsdistmultinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_cluster_set(s : StatsdistmultinomialCluster, i : Int, v : Double) -> StatsdistmultinomialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_cluster_sum(s : StatsdistmultinomialCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_cluster_mean(s : StatsdistmultinomialCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_cluster_scale(s : StatsdistmultinomialCluster, f : Double) -> StatsdistmultinomialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_cluster_add(a : StatsdistmultinomialCluster, b : StatsdistmultinomialCluster) -> StatsdistmultinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_cluster_copy(s : StatsdistmultinomialCluster) -> StatsdistmultinomialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_cluster_fill(s : StatsdistmultinomialCluster, v : Double) -> StatsdistmultinomialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_cluster_min(s : StatsdistmultinomialCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_cluster_max(s : StatsdistmultinomialCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_cluster_to_string(s : StatsdistmultinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_model_make(size : Int) -> StatsdistmultinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_model_len(s : StatsdistmultinomialModel) -> Int { s.size }

pub fn stats_dist_multinomial_model_get(s : StatsdistmultinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_model_set(s : StatsdistmultinomialModel, i : Int, v : Double) -> StatsdistmultinomialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_model_sum(s : StatsdistmultinomialModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_model_mean(s : StatsdistmultinomialModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_model_scale(s : StatsdistmultinomialModel, f : Double) -> StatsdistmultinomialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_model_add(a : StatsdistmultinomialModel, b : StatsdistmultinomialModel) -> StatsdistmultinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_model_copy(s : StatsdistmultinomialModel) -> StatsdistmultinomialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_model_fill(s : StatsdistmultinomialModel, v : Double) -> StatsdistmultinomialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_model_min(s : StatsdistmultinomialModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_model_max(s : StatsdistmultinomialModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_model_to_string(s : StatsdistmultinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_layer_make(size : Int) -> StatsdistmultinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_layer_len(s : StatsdistmultinomialLayer) -> Int { s.size }

pub fn stats_dist_multinomial_layer_get(s : StatsdistmultinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_layer_set(s : StatsdistmultinomialLayer, i : Int, v : Double) -> StatsdistmultinomialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_layer_sum(s : StatsdistmultinomialLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_layer_mean(s : StatsdistmultinomialLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_layer_scale(s : StatsdistmultinomialLayer, f : Double) -> StatsdistmultinomialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_layer_add(a : StatsdistmultinomialLayer, b : StatsdistmultinomialLayer) -> StatsdistmultinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_layer_copy(s : StatsdistmultinomialLayer) -> StatsdistmultinomialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_layer_fill(s : StatsdistmultinomialLayer, v : Double) -> StatsdistmultinomialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_layer_min(s : StatsdistmultinomialLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_layer_max(s : StatsdistmultinomialLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_layer_to_string(s : StatsdistmultinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_buffer_make(size : Int) -> StatsdistmultinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_buffer_len(s : StatsdistmultinomialBuffer) -> Int { s.size }

pub fn stats_dist_multinomial_buffer_get(s : StatsdistmultinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_buffer_set(s : StatsdistmultinomialBuffer, i : Int, v : Double) -> StatsdistmultinomialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_buffer_sum(s : StatsdistmultinomialBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_buffer_mean(s : StatsdistmultinomialBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_buffer_scale(s : StatsdistmultinomialBuffer, f : Double) -> StatsdistmultinomialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_buffer_add(a : StatsdistmultinomialBuffer, b : StatsdistmultinomialBuffer) -> StatsdistmultinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_buffer_copy(s : StatsdistmultinomialBuffer) -> StatsdistmultinomialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_buffer_fill(s : StatsdistmultinomialBuffer, v : Double) -> StatsdistmultinomialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_buffer_min(s : StatsdistmultinomialBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_buffer_max(s : StatsdistmultinomialBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_buffer_to_string(s : StatsdistmultinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_cursor_make(size : Int) -> StatsdistmultinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_cursor_len(s : StatsdistmultinomialCursor) -> Int { s.size }

pub fn stats_dist_multinomial_cursor_get(s : StatsdistmultinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_cursor_set(s : StatsdistmultinomialCursor, i : Int, v : Double) -> StatsdistmultinomialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_cursor_sum(s : StatsdistmultinomialCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_cursor_mean(s : StatsdistmultinomialCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_cursor_scale(s : StatsdistmultinomialCursor, f : Double) -> StatsdistmultinomialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_cursor_add(a : StatsdistmultinomialCursor, b : StatsdistmultinomialCursor) -> StatsdistmultinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_cursor_copy(s : StatsdistmultinomialCursor) -> StatsdistmultinomialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_cursor_fill(s : StatsdistmultinomialCursor, v : Double) -> StatsdistmultinomialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_cursor_min(s : StatsdistmultinomialCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_cursor_max(s : StatsdistmultinomialCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_cursor_to_string(s : StatsdistmultinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_view_make(size : Int) -> StatsdistmultinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_view_len(s : StatsdistmultinomialView) -> Int { s.size }

pub fn stats_dist_multinomial_view_get(s : StatsdistmultinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_view_set(s : StatsdistmultinomialView, i : Int, v : Double) -> StatsdistmultinomialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_view_sum(s : StatsdistmultinomialView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_view_mean(s : StatsdistmultinomialView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_view_scale(s : StatsdistmultinomialView, f : Double) -> StatsdistmultinomialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_view_add(a : StatsdistmultinomialView, b : StatsdistmultinomialView) -> StatsdistmultinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_view_copy(s : StatsdistmultinomialView) -> StatsdistmultinomialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_view_fill(s : StatsdistmultinomialView, v : Double) -> StatsdistmultinomialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_view_min(s : StatsdistmultinomialView) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_view_max(s : StatsdistmultinomialView) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_view_to_string(s : StatsdistmultinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_range_make(size : Int) -> StatsdistmultinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_range_len(s : StatsdistmultinomialRange) -> Int { s.size }

pub fn stats_dist_multinomial_range_get(s : StatsdistmultinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_range_set(s : StatsdistmultinomialRange, i : Int, v : Double) -> StatsdistmultinomialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_range_sum(s : StatsdistmultinomialRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_range_mean(s : StatsdistmultinomialRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_range_scale(s : StatsdistmultinomialRange, f : Double) -> StatsdistmultinomialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_range_add(a : StatsdistmultinomialRange, b : StatsdistmultinomialRange) -> StatsdistmultinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_range_copy(s : StatsdistmultinomialRange) -> StatsdistmultinomialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_range_fill(s : StatsdistmultinomialRange, v : Double) -> StatsdistmultinomialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_range_min(s : StatsdistmultinomialRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_range_max(s : StatsdistmultinomialRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_range_to_string(s : StatsdistmultinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_slice_make(size : Int) -> StatsdistmultinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_slice_len(s : StatsdistmultinomialSlice) -> Int { s.size }

pub fn stats_dist_multinomial_slice_get(s : StatsdistmultinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_slice_set(s : StatsdistmultinomialSlice, i : Int, v : Double) -> StatsdistmultinomialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_slice_sum(s : StatsdistmultinomialSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_multinomial_slice_mean(s : StatsdistmultinomialSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_multinomial_slice_scale(s : StatsdistmultinomialSlice, f : Double) -> StatsdistmultinomialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_slice_add(a : StatsdistmultinomialSlice, b : StatsdistmultinomialSlice) -> StatsdistmultinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_multinomial_slice_copy(s : StatsdistmultinomialSlice) -> StatsdistmultinomialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_slice_fill(s : StatsdistmultinomialSlice, v : Double) -> StatsdistmultinomialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_multinomial_slice_min(s : StatsdistmultinomialSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_multinomial_slice_max(s : StatsdistmultinomialSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_multinomial_slice_to_string(s : StatsdistmultinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

