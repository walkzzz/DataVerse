///===
/// extcore/stats_desc_multivariate

pub(all) struct StatsdescmultivariatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_multivariate_make_point(x : Double, y : Double) -> StatsdescmultivariatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_multivariate_make_point3(x : Double, y : Double, z : Double) -> StatsdescmultivariatePoint {
  { x, y, z, label: 0 }
}

pub fn StatsdescmultivariatePoint::x(self : StatsdescmultivariatePoint) -> Double { self.x }

pub fn StatsdescmultivariatePoint::y(self : StatsdescmultivariatePoint) -> Double { self.y }

pub fn StatsdescmultivariatePoint::z(self : StatsdescmultivariatePoint) -> Double { self.z }

pub fn StatsdescmultivariatePoint::label(self : StatsdescmultivariatePoint) -> Int { self.label }

pub fn StatsdescmultivariatePoint::dist(self : StatsdescmultivariatePoint, other : StatsdescmultivariatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdescmultivariatePoint::add(self : StatsdescmultivariatePoint, other : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdescmultivariatePoint::sub(self : StatsdescmultivariatePoint, other : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdescmultivariatePoint::scale(self : StatsdescmultivariatePoint, s : Double) -> StatsdescmultivariatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdescmultivariatePoint::dot(self : StatsdescmultivariatePoint, other : StatsdescmultivariatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdescmultivariatePoint::cross(self : StatsdescmultivariatePoint, other : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdescmultivariatePoint::norm(self : StatsdescmultivariatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdescmultivariatePoint::normalize(self : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescmultivariatePoint::negate(self : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdescmultivariatePoint::mid(self : StatsdescmultivariatePoint, other : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdescmultivariatePoint::lerp(self : StatsdescmultivariatePoint, other : StatsdescmultivariatePoint, t : Double) -> StatsdescmultivariatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdescmultivariatePoint::to_string(self : StatsdescmultivariatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdescmultivariateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_multivariate_make_series(vals : Array[Double], name : String) -> StatsdescmultivariateSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdescmultivariateSeries::len(self : StatsdescmultivariateSeries) -> Int { self.vals.length() }

pub fn StatsdescmultivariateSeries::sum(self : StatsdescmultivariateSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdescmultivariateSeries::mean(self : StatsdescmultivariateSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdescmultivariateSeries::min(self : StatsdescmultivariateSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdescmultivariateSeries::max(self : StatsdescmultivariateSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdescmultivariateSeries::range(self : StatsdescmultivariateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdescmultivariateSeries::variance(self : StatsdescmultivariateSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdescmultivariateSeries::std(self : StatsdescmultivariateSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdescmultivariateSeries::median(self : StatsdescmultivariateSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdescmultivariateSeries::scale(self : StatsdescmultivariateSeries, f : Double) -> StatsdescmultivariateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdescmultivariateSeries::add(self : StatsdescmultivariateSeries, other : StatsdescmultivariateSeries) -> StatsdescmultivariateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdescmultivariateSeries::sub(self : StatsdescmultivariateSeries, other : StatsdescmultivariateSeries) -> StatsdescmultivariateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdescmultivariateSeries::normalize(self : StatsdescmultivariateSeries) -> StatsdescmultivariateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdescmultivariateSeries::cumsum(self : StatsdescmultivariateSeries) -> StatsdescmultivariateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdescmultivariateSeries::to_string(self : StatsdescmultivariateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescmultivariateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_multivariate_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescmultivariateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_multivariate_matrix_identity(n : Int) -> StatsdescmultivariateMatrix {
  let m = stats_desc_multivariate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdescmultivariateMatrix::get(self : StatsdescmultivariateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdescmultivariateMatrix::transpose(self : StatsdescmultivariateMatrix) -> StatsdescmultivariateMatrix {
  let result = stats_desc_multivariate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdescmultivariateMatrix::add(self : StatsdescmultivariateMatrix, other : StatsdescmultivariateMatrix) -> StatsdescmultivariateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_desc_multivariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdescmultivariateMatrix::scale(self : StatsdescmultivariateMatrix, s : Double) -> StatsdescmultivariateMatrix {
  let result = stats_desc_multivariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdescmultivariateMatrix::multiply(self : StatsdescmultivariateMatrix, other : StatsdescmultivariateMatrix) -> StatsdescmultivariateMatrix {
  if self.cols != other.rows { return stats_desc_multivariate_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_desc_multivariate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdescmultivariateMatrix::trace(self : StatsdescmultivariateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdescmultivariateMatrix::det(self : StatsdescmultivariateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdescmultivariateMatrix::norm(self : StatsdescmultivariateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdescmultivariateMatrix::to_string(self : StatsdescmultivariateMatrix) -> String {
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

pub(all) struct StatsdescmultivariateVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_multivariate_make_vector(comps : Array[Double]) -> StatsdescmultivariateVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_multivariate_vector_zero(dim : Int) -> StatsdescmultivariateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdescmultivariateVector::add(self : StatsdescmultivariateVector, other : StatsdescmultivariateVector) -> StatsdescmultivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescmultivariateVector::sub(self : StatsdescmultivariateVector, other : StatsdescmultivariateVector) -> StatsdescmultivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescmultivariateVector::scale(self : StatsdescmultivariateVector, s : Double) -> StatsdescmultivariateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdescmultivariateVector::dot(self : StatsdescmultivariateVector, other : StatsdescmultivariateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdescmultivariateVector::norm(self : StatsdescmultivariateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdescmultivariateVector::normalize(self : StatsdescmultivariateVector) -> StatsdescmultivariateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescmultivariateVector::dist(self : StatsdescmultivariateVector, other : StatsdescmultivariateVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdescmultivariateVector::to_string(self : StatsdescmultivariateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_multivariate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_desc_multivariate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_desc_multivariate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_desc_multivariate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_desc_multivariate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_desc_multivariate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_desc_multivariate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_desc_multivariate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_desc_multivariate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_desc_multivariate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_desc_multivariate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_desc_multivariate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_desc_multivariate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_desc_multivariate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_desc_multivariate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_desc_multivariate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_desc_multivariate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_desc_multivariate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_desc_multivariate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_desc_multivariate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_desc_multivariate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_desc_multivariate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_desc_multivariate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_desc_multivariate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_desc_multivariate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_desc_multivariate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_desc_multivariate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_desc_multivariate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_desc_multivariate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdescmultivariateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_frame_make(size : Int) -> StatsdescmultivariateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_frame_len(s : StatsdescmultivariateFrame) -> Int { s.size }

pub fn stats_desc_multivariate_frame_get(s : StatsdescmultivariateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_frame_set(s : StatsdescmultivariateFrame, i : Int, v : Double) -> StatsdescmultivariateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_frame_sum(s : StatsdescmultivariateFrame) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_frame_mean(s : StatsdescmultivariateFrame) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_frame_scale(s : StatsdescmultivariateFrame, f : Double) -> StatsdescmultivariateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_frame_add(a : StatsdescmultivariateFrame, b : StatsdescmultivariateFrame) -> StatsdescmultivariateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_frame_copy(s : StatsdescmultivariateFrame) -> StatsdescmultivariateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_frame_fill(s : StatsdescmultivariateFrame, v : Double) -> StatsdescmultivariateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_frame_min(s : StatsdescmultivariateFrame) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_frame_max(s : StatsdescmultivariateFrame) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_frame_to_string(s : StatsdescmultivariateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_table_make(size : Int) -> StatsdescmultivariateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_table_len(s : StatsdescmultivariateTable) -> Int { s.size }

pub fn stats_desc_multivariate_table_get(s : StatsdescmultivariateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_table_set(s : StatsdescmultivariateTable, i : Int, v : Double) -> StatsdescmultivariateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_table_sum(s : StatsdescmultivariateTable) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_table_mean(s : StatsdescmultivariateTable) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_table_scale(s : StatsdescmultivariateTable, f : Double) -> StatsdescmultivariateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_table_add(a : StatsdescmultivariateTable, b : StatsdescmultivariateTable) -> StatsdescmultivariateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_table_copy(s : StatsdescmultivariateTable) -> StatsdescmultivariateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_table_fill(s : StatsdescmultivariateTable, v : Double) -> StatsdescmultivariateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_table_min(s : StatsdescmultivariateTable) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_table_max(s : StatsdescmultivariateTable) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_table_to_string(s : StatsdescmultivariateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_graphn_make(size : Int) -> StatsdescmultivariateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_graphn_len(s : StatsdescmultivariateGraphN) -> Int { s.size }

pub fn stats_desc_multivariate_graphn_get(s : StatsdescmultivariateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_graphn_set(s : StatsdescmultivariateGraphN, i : Int, v : Double) -> StatsdescmultivariateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_graphn_sum(s : StatsdescmultivariateGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_graphn_mean(s : StatsdescmultivariateGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_graphn_scale(s : StatsdescmultivariateGraphN, f : Double) -> StatsdescmultivariateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_graphn_add(a : StatsdescmultivariateGraphN, b : StatsdescmultivariateGraphN) -> StatsdescmultivariateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_graphn_copy(s : StatsdescmultivariateGraphN) -> StatsdescmultivariateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_graphn_fill(s : StatsdescmultivariateGraphN, v : Double) -> StatsdescmultivariateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_graphn_min(s : StatsdescmultivariateGraphN) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_graphn_max(s : StatsdescmultivariateGraphN) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_graphn_to_string(s : StatsdescmultivariateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_node_make(size : Int) -> StatsdescmultivariateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_node_len(s : StatsdescmultivariateNode) -> Int { s.size }

pub fn stats_desc_multivariate_node_get(s : StatsdescmultivariateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_node_set(s : StatsdescmultivariateNode, i : Int, v : Double) -> StatsdescmultivariateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_node_sum(s : StatsdescmultivariateNode) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_node_mean(s : StatsdescmultivariateNode) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_node_scale(s : StatsdescmultivariateNode, f : Double) -> StatsdescmultivariateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_node_add(a : StatsdescmultivariateNode, b : StatsdescmultivariateNode) -> StatsdescmultivariateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_node_copy(s : StatsdescmultivariateNode) -> StatsdescmultivariateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_node_fill(s : StatsdescmultivariateNode, v : Double) -> StatsdescmultivariateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_node_min(s : StatsdescmultivariateNode) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_node_max(s : StatsdescmultivariateNode) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_node_to_string(s : StatsdescmultivariateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_edge_make(size : Int) -> StatsdescmultivariateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_edge_len(s : StatsdescmultivariateEdge) -> Int { s.size }

pub fn stats_desc_multivariate_edge_get(s : StatsdescmultivariateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_edge_set(s : StatsdescmultivariateEdge, i : Int, v : Double) -> StatsdescmultivariateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_edge_sum(s : StatsdescmultivariateEdge) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_edge_mean(s : StatsdescmultivariateEdge) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_edge_scale(s : StatsdescmultivariateEdge, f : Double) -> StatsdescmultivariateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_edge_add(a : StatsdescmultivariateEdge, b : StatsdescmultivariateEdge) -> StatsdescmultivariateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_edge_copy(s : StatsdescmultivariateEdge) -> StatsdescmultivariateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_edge_fill(s : StatsdescmultivariateEdge, v : Double) -> StatsdescmultivariateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_edge_min(s : StatsdescmultivariateEdge) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_edge_max(s : StatsdescmultivariateEdge) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_edge_to_string(s : StatsdescmultivariateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_path_make(size : Int) -> StatsdescmultivariatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_path_len(s : StatsdescmultivariatePath) -> Int { s.size }

pub fn stats_desc_multivariate_path_get(s : StatsdescmultivariatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_path_set(s : StatsdescmultivariatePath, i : Int, v : Double) -> StatsdescmultivariatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_path_sum(s : StatsdescmultivariatePath) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_path_mean(s : StatsdescmultivariatePath) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_path_scale(s : StatsdescmultivariatePath, f : Double) -> StatsdescmultivariatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_path_add(a : StatsdescmultivariatePath, b : StatsdescmultivariatePath) -> StatsdescmultivariatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_path_copy(s : StatsdescmultivariatePath) -> StatsdescmultivariatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_path_fill(s : StatsdescmultivariatePath, v : Double) -> StatsdescmultivariatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_path_min(s : StatsdescmultivariatePath) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_path_max(s : StatsdescmultivariatePath) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_path_to_string(s : StatsdescmultivariatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_cluster_make(size : Int) -> StatsdescmultivariateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_cluster_len(s : StatsdescmultivariateCluster) -> Int { s.size }

pub fn stats_desc_multivariate_cluster_get(s : StatsdescmultivariateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_cluster_set(s : StatsdescmultivariateCluster, i : Int, v : Double) -> StatsdescmultivariateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_cluster_sum(s : StatsdescmultivariateCluster) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_cluster_mean(s : StatsdescmultivariateCluster) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_cluster_scale(s : StatsdescmultivariateCluster, f : Double) -> StatsdescmultivariateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_cluster_add(a : StatsdescmultivariateCluster, b : StatsdescmultivariateCluster) -> StatsdescmultivariateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_cluster_copy(s : StatsdescmultivariateCluster) -> StatsdescmultivariateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_cluster_fill(s : StatsdescmultivariateCluster, v : Double) -> StatsdescmultivariateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_cluster_min(s : StatsdescmultivariateCluster) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_cluster_max(s : StatsdescmultivariateCluster) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_cluster_to_string(s : StatsdescmultivariateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_model_make(size : Int) -> StatsdescmultivariateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_model_len(s : StatsdescmultivariateModel) -> Int { s.size }

pub fn stats_desc_multivariate_model_get(s : StatsdescmultivariateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_model_set(s : StatsdescmultivariateModel, i : Int, v : Double) -> StatsdescmultivariateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_model_sum(s : StatsdescmultivariateModel) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_model_mean(s : StatsdescmultivariateModel) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_model_scale(s : StatsdescmultivariateModel, f : Double) -> StatsdescmultivariateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_model_add(a : StatsdescmultivariateModel, b : StatsdescmultivariateModel) -> StatsdescmultivariateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_model_copy(s : StatsdescmultivariateModel) -> StatsdescmultivariateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_model_fill(s : StatsdescmultivariateModel, v : Double) -> StatsdescmultivariateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_model_min(s : StatsdescmultivariateModel) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_model_max(s : StatsdescmultivariateModel) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_model_to_string(s : StatsdescmultivariateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_layer_make(size : Int) -> StatsdescmultivariateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_layer_len(s : StatsdescmultivariateLayer) -> Int { s.size }

pub fn stats_desc_multivariate_layer_get(s : StatsdescmultivariateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_layer_set(s : StatsdescmultivariateLayer, i : Int, v : Double) -> StatsdescmultivariateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_layer_sum(s : StatsdescmultivariateLayer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_layer_mean(s : StatsdescmultivariateLayer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_layer_scale(s : StatsdescmultivariateLayer, f : Double) -> StatsdescmultivariateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_layer_add(a : StatsdescmultivariateLayer, b : StatsdescmultivariateLayer) -> StatsdescmultivariateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_layer_copy(s : StatsdescmultivariateLayer) -> StatsdescmultivariateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_layer_fill(s : StatsdescmultivariateLayer, v : Double) -> StatsdescmultivariateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_layer_min(s : StatsdescmultivariateLayer) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_layer_max(s : StatsdescmultivariateLayer) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_layer_to_string(s : StatsdescmultivariateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_buffer_make(size : Int) -> StatsdescmultivariateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_buffer_len(s : StatsdescmultivariateBuffer) -> Int { s.size }

pub fn stats_desc_multivariate_buffer_get(s : StatsdescmultivariateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_buffer_set(s : StatsdescmultivariateBuffer, i : Int, v : Double) -> StatsdescmultivariateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_buffer_sum(s : StatsdescmultivariateBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_buffer_mean(s : StatsdescmultivariateBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_buffer_scale(s : StatsdescmultivariateBuffer, f : Double) -> StatsdescmultivariateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_buffer_add(a : StatsdescmultivariateBuffer, b : StatsdescmultivariateBuffer) -> StatsdescmultivariateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_buffer_copy(s : StatsdescmultivariateBuffer) -> StatsdescmultivariateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_buffer_fill(s : StatsdescmultivariateBuffer, v : Double) -> StatsdescmultivariateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_buffer_min(s : StatsdescmultivariateBuffer) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_buffer_max(s : StatsdescmultivariateBuffer) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_buffer_to_string(s : StatsdescmultivariateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_cursor_make(size : Int) -> StatsdescmultivariateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_cursor_len(s : StatsdescmultivariateCursor) -> Int { s.size }

pub fn stats_desc_multivariate_cursor_get(s : StatsdescmultivariateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_cursor_set(s : StatsdescmultivariateCursor, i : Int, v : Double) -> StatsdescmultivariateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_cursor_sum(s : StatsdescmultivariateCursor) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_cursor_mean(s : StatsdescmultivariateCursor) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_cursor_scale(s : StatsdescmultivariateCursor, f : Double) -> StatsdescmultivariateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_cursor_add(a : StatsdescmultivariateCursor, b : StatsdescmultivariateCursor) -> StatsdescmultivariateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_cursor_copy(s : StatsdescmultivariateCursor) -> StatsdescmultivariateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_cursor_fill(s : StatsdescmultivariateCursor, v : Double) -> StatsdescmultivariateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_cursor_min(s : StatsdescmultivariateCursor) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_cursor_max(s : StatsdescmultivariateCursor) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_cursor_to_string(s : StatsdescmultivariateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_view_make(size : Int) -> StatsdescmultivariateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_view_len(s : StatsdescmultivariateView) -> Int { s.size }

pub fn stats_desc_multivariate_view_get(s : StatsdescmultivariateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_view_set(s : StatsdescmultivariateView, i : Int, v : Double) -> StatsdescmultivariateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_view_sum(s : StatsdescmultivariateView) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_view_mean(s : StatsdescmultivariateView) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_view_scale(s : StatsdescmultivariateView, f : Double) -> StatsdescmultivariateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_view_add(a : StatsdescmultivariateView, b : StatsdescmultivariateView) -> StatsdescmultivariateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_view_copy(s : StatsdescmultivariateView) -> StatsdescmultivariateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_view_fill(s : StatsdescmultivariateView, v : Double) -> StatsdescmultivariateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_view_min(s : StatsdescmultivariateView) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_view_max(s : StatsdescmultivariateView) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_view_to_string(s : StatsdescmultivariateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_range_make(size : Int) -> StatsdescmultivariateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_range_len(s : StatsdescmultivariateRange) -> Int { s.size }

pub fn stats_desc_multivariate_range_get(s : StatsdescmultivariateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_range_set(s : StatsdescmultivariateRange, i : Int, v : Double) -> StatsdescmultivariateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_range_sum(s : StatsdescmultivariateRange) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_range_mean(s : StatsdescmultivariateRange) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_range_scale(s : StatsdescmultivariateRange, f : Double) -> StatsdescmultivariateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_range_add(a : StatsdescmultivariateRange, b : StatsdescmultivariateRange) -> StatsdescmultivariateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_range_copy(s : StatsdescmultivariateRange) -> StatsdescmultivariateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_range_fill(s : StatsdescmultivariateRange, v : Double) -> StatsdescmultivariateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_range_min(s : StatsdescmultivariateRange) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_range_max(s : StatsdescmultivariateRange) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_range_to_string(s : StatsdescmultivariateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_slice_make(size : Int) -> StatsdescmultivariateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_slice_len(s : StatsdescmultivariateSlice) -> Int { s.size }

pub fn stats_desc_multivariate_slice_get(s : StatsdescmultivariateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_slice_set(s : StatsdescmultivariateSlice, i : Int, v : Double) -> StatsdescmultivariateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_slice_sum(s : StatsdescmultivariateSlice) -> Double { @_common.sum(s.data) }

pub fn stats_desc_multivariate_slice_mean(s : StatsdescmultivariateSlice) -> Double { @_common.mean(s.data) }

pub fn stats_desc_multivariate_slice_scale(s : StatsdescmultivariateSlice, f : Double) -> StatsdescmultivariateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_slice_add(a : StatsdescmultivariateSlice, b : StatsdescmultivariateSlice) -> StatsdescmultivariateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_multivariate_slice_copy(s : StatsdescmultivariateSlice) -> StatsdescmultivariateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_slice_fill(s : StatsdescmultivariateSlice, v : Double) -> StatsdescmultivariateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_multivariate_slice_min(s : StatsdescmultivariateSlice) -> Double { @_common.min(s.data) }

pub fn stats_desc_multivariate_slice_max(s : StatsdescmultivariateSlice) -> Double { @_common.max(s.data) }

pub fn stats_desc_multivariate_slice_to_string(s : StatsdescmultivariateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

