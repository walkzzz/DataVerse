///===
/// extcore/stats_desc_univariate

pub(all) struct StatsdescunivariatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_univariate_make_point(x : Double, y : Double) -> StatsdescunivariatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_univariate_make_point3(x : Double, y : Double, z : Double) -> StatsdescunivariatePoint {
  { x, y, z, label: 0 }
}

pub fn StatsdescunivariatePoint::x(self : StatsdescunivariatePoint) -> Double { self.x }

pub fn StatsdescunivariatePoint::y(self : StatsdescunivariatePoint) -> Double { self.y }

pub fn StatsdescunivariatePoint::z(self : StatsdescunivariatePoint) -> Double { self.z }

pub fn StatsdescunivariatePoint::label(self : StatsdescunivariatePoint) -> Int { self.label }

pub fn StatsdescunivariatePoint::dist(self : StatsdescunivariatePoint, other : StatsdescunivariatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdescunivariatePoint::add(self : StatsdescunivariatePoint, other : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdescunivariatePoint::sub(self : StatsdescunivariatePoint, other : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdescunivariatePoint::scale(self : StatsdescunivariatePoint, s : Double) -> StatsdescunivariatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdescunivariatePoint::dot(self : StatsdescunivariatePoint, other : StatsdescunivariatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdescunivariatePoint::cross(self : StatsdescunivariatePoint, other : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdescunivariatePoint::norm(self : StatsdescunivariatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdescunivariatePoint::normalize(self : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescunivariatePoint::negate(self : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdescunivariatePoint::mid(self : StatsdescunivariatePoint, other : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdescunivariatePoint::lerp(self : StatsdescunivariatePoint, other : StatsdescunivariatePoint, t : Double) -> StatsdescunivariatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdescunivariatePoint::to_string(self : StatsdescunivariatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdescunivariateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_univariate_make_series(vals : Array[Double], name : String) -> StatsdescunivariateSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdescunivariateSeries::len(self : StatsdescunivariateSeries) -> Int { self.vals.length() }

pub fn StatsdescunivariateSeries::sum(self : StatsdescunivariateSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdescunivariateSeries::mean(self : StatsdescunivariateSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdescunivariateSeries::min(self : StatsdescunivariateSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdescunivariateSeries::max(self : StatsdescunivariateSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdescunivariateSeries::range(self : StatsdescunivariateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdescunivariateSeries::variance(self : StatsdescunivariateSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdescunivariateSeries::std(self : StatsdescunivariateSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdescunivariateSeries::median(self : StatsdescunivariateSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdescunivariateSeries::scale(self : StatsdescunivariateSeries, f : Double) -> StatsdescunivariateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdescunivariateSeries::add(self : StatsdescunivariateSeries, other : StatsdescunivariateSeries) -> StatsdescunivariateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdescunivariateSeries::sub(self : StatsdescunivariateSeries, other : StatsdescunivariateSeries) -> StatsdescunivariateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdescunivariateSeries::normalize(self : StatsdescunivariateSeries) -> StatsdescunivariateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdescunivariateSeries::cumsum(self : StatsdescunivariateSeries) -> StatsdescunivariateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdescunivariateSeries::to_string(self : StatsdescunivariateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescunivariateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_univariate_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescunivariateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_univariate_matrix_identity(n : Int) -> StatsdescunivariateMatrix {
  let m = stats_desc_univariate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdescunivariateMatrix::get(self : StatsdescunivariateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdescunivariateMatrix::transpose(self : StatsdescunivariateMatrix) -> StatsdescunivariateMatrix {
  let result = stats_desc_univariate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdescunivariateMatrix::add(self : StatsdescunivariateMatrix, other : StatsdescunivariateMatrix) -> StatsdescunivariateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_desc_univariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdescunivariateMatrix::scale(self : StatsdescunivariateMatrix, s : Double) -> StatsdescunivariateMatrix {
  let result = stats_desc_univariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdescunivariateMatrix::multiply(self : StatsdescunivariateMatrix, other : StatsdescunivariateMatrix) -> StatsdescunivariateMatrix {
  if self.cols != other.rows { return stats_desc_univariate_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_desc_univariate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdescunivariateMatrix::trace(self : StatsdescunivariateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdescunivariateMatrix::det(self : StatsdescunivariateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdescunivariateMatrix::norm(self : StatsdescunivariateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdescunivariateMatrix::to_string(self : StatsdescunivariateMatrix) -> String {
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

pub(all) struct StatsdescunivariateVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_univariate_make_vector(comps : Array[Double]) -> StatsdescunivariateVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_univariate_vector_zero(dim : Int) -> StatsdescunivariateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdescunivariateVector::add(self : StatsdescunivariateVector, other : StatsdescunivariateVector) -> StatsdescunivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescunivariateVector::sub(self : StatsdescunivariateVector, other : StatsdescunivariateVector) -> StatsdescunivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescunivariateVector::scale(self : StatsdescunivariateVector, s : Double) -> StatsdescunivariateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdescunivariateVector::dot(self : StatsdescunivariateVector, other : StatsdescunivariateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdescunivariateVector::norm(self : StatsdescunivariateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdescunivariateVector::normalize(self : StatsdescunivariateVector) -> StatsdescunivariateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescunivariateVector::dist(self : StatsdescunivariateVector, other : StatsdescunivariateVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdescunivariateVector::to_string(self : StatsdescunivariateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_univariate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_desc_univariate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_desc_univariate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_desc_univariate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_desc_univariate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_desc_univariate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_desc_univariate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_desc_univariate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_desc_univariate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_desc_univariate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_desc_univariate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_desc_univariate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_desc_univariate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_desc_univariate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_desc_univariate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_desc_univariate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_desc_univariate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_desc_univariate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_desc_univariate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_desc_univariate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_desc_univariate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_desc_univariate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_desc_univariate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_desc_univariate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_desc_univariate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_desc_univariate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_desc_univariate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_desc_univariate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_desc_univariate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdescunivariateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_frame_make(size : Int) -> StatsdescunivariateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_frame_len(s : StatsdescunivariateFrame) -> Int { s.size }

pub fn stats_desc_univariate_frame_get(s : StatsdescunivariateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_frame_set(s : StatsdescunivariateFrame, i : Int, v : Double) -> StatsdescunivariateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_frame_sum(s : StatsdescunivariateFrame) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_frame_mean(s : StatsdescunivariateFrame) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_frame_scale(s : StatsdescunivariateFrame, f : Double) -> StatsdescunivariateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_frame_add(a : StatsdescunivariateFrame, b : StatsdescunivariateFrame) -> StatsdescunivariateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_frame_copy(s : StatsdescunivariateFrame) -> StatsdescunivariateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_frame_fill(s : StatsdescunivariateFrame, v : Double) -> StatsdescunivariateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_frame_min(s : StatsdescunivariateFrame) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_frame_max(s : StatsdescunivariateFrame) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_frame_to_string(s : StatsdescunivariateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_table_make(size : Int) -> StatsdescunivariateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_table_len(s : StatsdescunivariateTable) -> Int { s.size }

pub fn stats_desc_univariate_table_get(s : StatsdescunivariateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_table_set(s : StatsdescunivariateTable, i : Int, v : Double) -> StatsdescunivariateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_table_sum(s : StatsdescunivariateTable) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_table_mean(s : StatsdescunivariateTable) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_table_scale(s : StatsdescunivariateTable, f : Double) -> StatsdescunivariateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_table_add(a : StatsdescunivariateTable, b : StatsdescunivariateTable) -> StatsdescunivariateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_table_copy(s : StatsdescunivariateTable) -> StatsdescunivariateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_table_fill(s : StatsdescunivariateTable, v : Double) -> StatsdescunivariateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_table_min(s : StatsdescunivariateTable) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_table_max(s : StatsdescunivariateTable) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_table_to_string(s : StatsdescunivariateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_graphn_make(size : Int) -> StatsdescunivariateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_graphn_len(s : StatsdescunivariateGraphN) -> Int { s.size }

pub fn stats_desc_univariate_graphn_get(s : StatsdescunivariateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_graphn_set(s : StatsdescunivariateGraphN, i : Int, v : Double) -> StatsdescunivariateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_graphn_sum(s : StatsdescunivariateGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_graphn_mean(s : StatsdescunivariateGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_graphn_scale(s : StatsdescunivariateGraphN, f : Double) -> StatsdescunivariateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_graphn_add(a : StatsdescunivariateGraphN, b : StatsdescunivariateGraphN) -> StatsdescunivariateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_graphn_copy(s : StatsdescunivariateGraphN) -> StatsdescunivariateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_graphn_fill(s : StatsdescunivariateGraphN, v : Double) -> StatsdescunivariateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_graphn_min(s : StatsdescunivariateGraphN) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_graphn_max(s : StatsdescunivariateGraphN) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_graphn_to_string(s : StatsdescunivariateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_node_make(size : Int) -> StatsdescunivariateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_node_len(s : StatsdescunivariateNode) -> Int { s.size }

pub fn stats_desc_univariate_node_get(s : StatsdescunivariateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_node_set(s : StatsdescunivariateNode, i : Int, v : Double) -> StatsdescunivariateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_node_sum(s : StatsdescunivariateNode) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_node_mean(s : StatsdescunivariateNode) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_node_scale(s : StatsdescunivariateNode, f : Double) -> StatsdescunivariateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_node_add(a : StatsdescunivariateNode, b : StatsdescunivariateNode) -> StatsdescunivariateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_node_copy(s : StatsdescunivariateNode) -> StatsdescunivariateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_node_fill(s : StatsdescunivariateNode, v : Double) -> StatsdescunivariateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_node_min(s : StatsdescunivariateNode) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_node_max(s : StatsdescunivariateNode) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_node_to_string(s : StatsdescunivariateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_edge_make(size : Int) -> StatsdescunivariateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_edge_len(s : StatsdescunivariateEdge) -> Int { s.size }

pub fn stats_desc_univariate_edge_get(s : StatsdescunivariateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_edge_set(s : StatsdescunivariateEdge, i : Int, v : Double) -> StatsdescunivariateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_edge_sum(s : StatsdescunivariateEdge) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_edge_mean(s : StatsdescunivariateEdge) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_edge_scale(s : StatsdescunivariateEdge, f : Double) -> StatsdescunivariateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_edge_add(a : StatsdescunivariateEdge, b : StatsdescunivariateEdge) -> StatsdescunivariateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_edge_copy(s : StatsdescunivariateEdge) -> StatsdescunivariateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_edge_fill(s : StatsdescunivariateEdge, v : Double) -> StatsdescunivariateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_edge_min(s : StatsdescunivariateEdge) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_edge_max(s : StatsdescunivariateEdge) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_edge_to_string(s : StatsdescunivariateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_path_make(size : Int) -> StatsdescunivariatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_path_len(s : StatsdescunivariatePath) -> Int { s.size }

pub fn stats_desc_univariate_path_get(s : StatsdescunivariatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_path_set(s : StatsdescunivariatePath, i : Int, v : Double) -> StatsdescunivariatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_path_sum(s : StatsdescunivariatePath) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_path_mean(s : StatsdescunivariatePath) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_path_scale(s : StatsdescunivariatePath, f : Double) -> StatsdescunivariatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_path_add(a : StatsdescunivariatePath, b : StatsdescunivariatePath) -> StatsdescunivariatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_path_copy(s : StatsdescunivariatePath) -> StatsdescunivariatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_path_fill(s : StatsdescunivariatePath, v : Double) -> StatsdescunivariatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_path_min(s : StatsdescunivariatePath) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_path_max(s : StatsdescunivariatePath) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_path_to_string(s : StatsdescunivariatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_cluster_make(size : Int) -> StatsdescunivariateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_cluster_len(s : StatsdescunivariateCluster) -> Int { s.size }

pub fn stats_desc_univariate_cluster_get(s : StatsdescunivariateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_cluster_set(s : StatsdescunivariateCluster, i : Int, v : Double) -> StatsdescunivariateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_cluster_sum(s : StatsdescunivariateCluster) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_cluster_mean(s : StatsdescunivariateCluster) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_cluster_scale(s : StatsdescunivariateCluster, f : Double) -> StatsdescunivariateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_cluster_add(a : StatsdescunivariateCluster, b : StatsdescunivariateCluster) -> StatsdescunivariateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_cluster_copy(s : StatsdescunivariateCluster) -> StatsdescunivariateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_cluster_fill(s : StatsdescunivariateCluster, v : Double) -> StatsdescunivariateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_cluster_min(s : StatsdescunivariateCluster) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_cluster_max(s : StatsdescunivariateCluster) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_cluster_to_string(s : StatsdescunivariateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_model_make(size : Int) -> StatsdescunivariateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_model_len(s : StatsdescunivariateModel) -> Int { s.size }

pub fn stats_desc_univariate_model_get(s : StatsdescunivariateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_model_set(s : StatsdescunivariateModel, i : Int, v : Double) -> StatsdescunivariateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_model_sum(s : StatsdescunivariateModel) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_model_mean(s : StatsdescunivariateModel) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_model_scale(s : StatsdescunivariateModel, f : Double) -> StatsdescunivariateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_model_add(a : StatsdescunivariateModel, b : StatsdescunivariateModel) -> StatsdescunivariateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_model_copy(s : StatsdescunivariateModel) -> StatsdescunivariateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_model_fill(s : StatsdescunivariateModel, v : Double) -> StatsdescunivariateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_model_min(s : StatsdescunivariateModel) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_model_max(s : StatsdescunivariateModel) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_model_to_string(s : StatsdescunivariateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_layer_make(size : Int) -> StatsdescunivariateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_layer_len(s : StatsdescunivariateLayer) -> Int { s.size }

pub fn stats_desc_univariate_layer_get(s : StatsdescunivariateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_layer_set(s : StatsdescunivariateLayer, i : Int, v : Double) -> StatsdescunivariateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_layer_sum(s : StatsdescunivariateLayer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_layer_mean(s : StatsdescunivariateLayer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_layer_scale(s : StatsdescunivariateLayer, f : Double) -> StatsdescunivariateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_layer_add(a : StatsdescunivariateLayer, b : StatsdescunivariateLayer) -> StatsdescunivariateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_layer_copy(s : StatsdescunivariateLayer) -> StatsdescunivariateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_layer_fill(s : StatsdescunivariateLayer, v : Double) -> StatsdescunivariateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_layer_min(s : StatsdescunivariateLayer) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_layer_max(s : StatsdescunivariateLayer) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_layer_to_string(s : StatsdescunivariateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_buffer_make(size : Int) -> StatsdescunivariateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_buffer_len(s : StatsdescunivariateBuffer) -> Int { s.size }

pub fn stats_desc_univariate_buffer_get(s : StatsdescunivariateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_buffer_set(s : StatsdescunivariateBuffer, i : Int, v : Double) -> StatsdescunivariateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_buffer_sum(s : StatsdescunivariateBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_buffer_mean(s : StatsdescunivariateBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_buffer_scale(s : StatsdescunivariateBuffer, f : Double) -> StatsdescunivariateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_buffer_add(a : StatsdescunivariateBuffer, b : StatsdescunivariateBuffer) -> StatsdescunivariateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_buffer_copy(s : StatsdescunivariateBuffer) -> StatsdescunivariateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_buffer_fill(s : StatsdescunivariateBuffer, v : Double) -> StatsdescunivariateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_buffer_min(s : StatsdescunivariateBuffer) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_buffer_max(s : StatsdescunivariateBuffer) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_buffer_to_string(s : StatsdescunivariateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_cursor_make(size : Int) -> StatsdescunivariateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_cursor_len(s : StatsdescunivariateCursor) -> Int { s.size }

pub fn stats_desc_univariate_cursor_get(s : StatsdescunivariateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_cursor_set(s : StatsdescunivariateCursor, i : Int, v : Double) -> StatsdescunivariateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_cursor_sum(s : StatsdescunivariateCursor) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_cursor_mean(s : StatsdescunivariateCursor) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_cursor_scale(s : StatsdescunivariateCursor, f : Double) -> StatsdescunivariateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_cursor_add(a : StatsdescunivariateCursor, b : StatsdescunivariateCursor) -> StatsdescunivariateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_cursor_copy(s : StatsdescunivariateCursor) -> StatsdescunivariateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_cursor_fill(s : StatsdescunivariateCursor, v : Double) -> StatsdescunivariateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_cursor_min(s : StatsdescunivariateCursor) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_cursor_max(s : StatsdescunivariateCursor) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_cursor_to_string(s : StatsdescunivariateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_view_make(size : Int) -> StatsdescunivariateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_view_len(s : StatsdescunivariateView) -> Int { s.size }

pub fn stats_desc_univariate_view_get(s : StatsdescunivariateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_view_set(s : StatsdescunivariateView, i : Int, v : Double) -> StatsdescunivariateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_view_sum(s : StatsdescunivariateView) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_view_mean(s : StatsdescunivariateView) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_view_scale(s : StatsdescunivariateView, f : Double) -> StatsdescunivariateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_view_add(a : StatsdescunivariateView, b : StatsdescunivariateView) -> StatsdescunivariateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_view_copy(s : StatsdescunivariateView) -> StatsdescunivariateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_view_fill(s : StatsdescunivariateView, v : Double) -> StatsdescunivariateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_view_min(s : StatsdescunivariateView) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_view_max(s : StatsdescunivariateView) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_view_to_string(s : StatsdescunivariateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_range_make(size : Int) -> StatsdescunivariateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_range_len(s : StatsdescunivariateRange) -> Int { s.size }

pub fn stats_desc_univariate_range_get(s : StatsdescunivariateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_range_set(s : StatsdescunivariateRange, i : Int, v : Double) -> StatsdescunivariateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_range_sum(s : StatsdescunivariateRange) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_range_mean(s : StatsdescunivariateRange) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_range_scale(s : StatsdescunivariateRange, f : Double) -> StatsdescunivariateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_range_add(a : StatsdescunivariateRange, b : StatsdescunivariateRange) -> StatsdescunivariateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_range_copy(s : StatsdescunivariateRange) -> StatsdescunivariateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_range_fill(s : StatsdescunivariateRange, v : Double) -> StatsdescunivariateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_range_min(s : StatsdescunivariateRange) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_range_max(s : StatsdescunivariateRange) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_range_to_string(s : StatsdescunivariateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_slice_make(size : Int) -> StatsdescunivariateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_slice_len(s : StatsdescunivariateSlice) -> Int { s.size }

pub fn stats_desc_univariate_slice_get(s : StatsdescunivariateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_slice_set(s : StatsdescunivariateSlice, i : Int, v : Double) -> StatsdescunivariateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_slice_sum(s : StatsdescunivariateSlice) -> Double { @_common.sum(s.data) }

pub fn stats_desc_univariate_slice_mean(s : StatsdescunivariateSlice) -> Double { @_common.mean(s.data) }

pub fn stats_desc_univariate_slice_scale(s : StatsdescunivariateSlice, f : Double) -> StatsdescunivariateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_slice_add(a : StatsdescunivariateSlice, b : StatsdescunivariateSlice) -> StatsdescunivariateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_univariate_slice_copy(s : StatsdescunivariateSlice) -> StatsdescunivariateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_slice_fill(s : StatsdescunivariateSlice, v : Double) -> StatsdescunivariateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_univariate_slice_min(s : StatsdescunivariateSlice) -> Double { @_common.min(s.data) }

pub fn stats_desc_univariate_slice_max(s : StatsdescunivariateSlice) -> Double { @_common.max(s.data) }

pub fn stats_desc_univariate_slice_to_string(s : StatsdescunivariateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

