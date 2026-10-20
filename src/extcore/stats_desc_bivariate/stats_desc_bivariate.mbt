///===
/// extcore/stats_desc_bivariate

pub(all) struct StatsdescbivariatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_bivariate_make_point(x : Double, y : Double) -> StatsdescbivariatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_bivariate_make_point3(x : Double, y : Double, z : Double) -> StatsdescbivariatePoint {
  { x, y, z, label: 0 }
}

pub fn StatsdescbivariatePoint::x(self : StatsdescbivariatePoint) -> Double { self.x }

pub fn StatsdescbivariatePoint::y(self : StatsdescbivariatePoint) -> Double { self.y }

pub fn StatsdescbivariatePoint::z(self : StatsdescbivariatePoint) -> Double { self.z }

pub fn StatsdescbivariatePoint::label(self : StatsdescbivariatePoint) -> Int { self.label }

pub fn StatsdescbivariatePoint::dist(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdescbivariatePoint::add(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdescbivariatePoint::sub(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdescbivariatePoint::scale(self : StatsdescbivariatePoint, s : Double) -> StatsdescbivariatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdescbivariatePoint::dot(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdescbivariatePoint::cross(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdescbivariatePoint::norm(self : StatsdescbivariatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdescbivariatePoint::normalize(self : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescbivariatePoint::negate(self : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdescbivariatePoint::mid(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdescbivariatePoint::lerp(self : StatsdescbivariatePoint, other : StatsdescbivariatePoint, t : Double) -> StatsdescbivariatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdescbivariatePoint::to_string(self : StatsdescbivariatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdescbivariateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_bivariate_make_series(vals : Array[Double], name : String) -> StatsdescbivariateSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdescbivariateSeries::len(self : StatsdescbivariateSeries) -> Int { self.vals.length() }

pub fn StatsdescbivariateSeries::sum(self : StatsdescbivariateSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdescbivariateSeries::mean(self : StatsdescbivariateSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdescbivariateSeries::min(self : StatsdescbivariateSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdescbivariateSeries::max(self : StatsdescbivariateSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdescbivariateSeries::range(self : StatsdescbivariateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdescbivariateSeries::variance(self : StatsdescbivariateSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdescbivariateSeries::std(self : StatsdescbivariateSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdescbivariateSeries::median(self : StatsdescbivariateSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdescbivariateSeries::scale(self : StatsdescbivariateSeries, f : Double) -> StatsdescbivariateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdescbivariateSeries::add(self : StatsdescbivariateSeries, other : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdescbivariateSeries::sub(self : StatsdescbivariateSeries, other : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdescbivariateSeries::normalize(self : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdescbivariateSeries::cumsum(self : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdescbivariateSeries::to_string(self : StatsdescbivariateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescbivariateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_bivariate_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescbivariateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_bivariate_matrix_identity(n : Int) -> StatsdescbivariateMatrix {
  let m = stats_desc_bivariate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdescbivariateMatrix::get(self : StatsdescbivariateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdescbivariateMatrix::transpose(self : StatsdescbivariateMatrix) -> StatsdescbivariateMatrix {
  let result = stats_desc_bivariate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdescbivariateMatrix::add(self : StatsdescbivariateMatrix, other : StatsdescbivariateMatrix) -> StatsdescbivariateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_desc_bivariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdescbivariateMatrix::scale(self : StatsdescbivariateMatrix, s : Double) -> StatsdescbivariateMatrix {
  let result = stats_desc_bivariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdescbivariateMatrix::multiply(self : StatsdescbivariateMatrix, other : StatsdescbivariateMatrix) -> StatsdescbivariateMatrix {
  if self.cols != other.rows { return stats_desc_bivariate_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_desc_bivariate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdescbivariateMatrix::trace(self : StatsdescbivariateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdescbivariateMatrix::det(self : StatsdescbivariateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdescbivariateMatrix::norm(self : StatsdescbivariateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdescbivariateMatrix::to_string(self : StatsdescbivariateMatrix) -> String {
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

pub(all) struct StatsdescbivariateVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_bivariate_make_vector(comps : Array[Double]) -> StatsdescbivariateVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_bivariate_vector_zero(dim : Int) -> StatsdescbivariateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdescbivariateVector::add(self : StatsdescbivariateVector, other : StatsdescbivariateVector) -> StatsdescbivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescbivariateVector::sub(self : StatsdescbivariateVector, other : StatsdescbivariateVector) -> StatsdescbivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescbivariateVector::scale(self : StatsdescbivariateVector, s : Double) -> StatsdescbivariateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdescbivariateVector::dot(self : StatsdescbivariateVector, other : StatsdescbivariateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdescbivariateVector::norm(self : StatsdescbivariateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdescbivariateVector::normalize(self : StatsdescbivariateVector) -> StatsdescbivariateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescbivariateVector::dist(self : StatsdescbivariateVector, other : StatsdescbivariateVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdescbivariateVector::to_string(self : StatsdescbivariateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_bivariate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_desc_bivariate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_desc_bivariate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_desc_bivariate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_desc_bivariate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_desc_bivariate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_desc_bivariate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_desc_bivariate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_desc_bivariate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_desc_bivariate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_desc_bivariate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_desc_bivariate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_desc_bivariate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_desc_bivariate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_desc_bivariate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_desc_bivariate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_desc_bivariate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_desc_bivariate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_desc_bivariate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_desc_bivariate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_desc_bivariate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_desc_bivariate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_desc_bivariate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_desc_bivariate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_desc_bivariate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_desc_bivariate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_desc_bivariate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_desc_bivariate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_desc_bivariate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdescbivariateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_frame_make(size : Int) -> StatsdescbivariateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_frame_len(s : StatsdescbivariateFrame) -> Int { s.size }

pub fn stats_desc_bivariate_frame_get(s : StatsdescbivariateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_frame_set(s : StatsdescbivariateFrame, i : Int, v : Double) -> StatsdescbivariateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_frame_sum(s : StatsdescbivariateFrame) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_frame_mean(s : StatsdescbivariateFrame) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_frame_scale(s : StatsdescbivariateFrame, f : Double) -> StatsdescbivariateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_frame_add(a : StatsdescbivariateFrame, b : StatsdescbivariateFrame) -> StatsdescbivariateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_frame_copy(s : StatsdescbivariateFrame) -> StatsdescbivariateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_frame_fill(s : StatsdescbivariateFrame, v : Double) -> StatsdescbivariateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_frame_min(s : StatsdescbivariateFrame) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_frame_max(s : StatsdescbivariateFrame) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_frame_to_string(s : StatsdescbivariateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_table_make(size : Int) -> StatsdescbivariateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_table_len(s : StatsdescbivariateTable) -> Int { s.size }

pub fn stats_desc_bivariate_table_get(s : StatsdescbivariateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_table_set(s : StatsdescbivariateTable, i : Int, v : Double) -> StatsdescbivariateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_table_sum(s : StatsdescbivariateTable) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_table_mean(s : StatsdescbivariateTable) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_table_scale(s : StatsdescbivariateTable, f : Double) -> StatsdescbivariateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_table_add(a : StatsdescbivariateTable, b : StatsdescbivariateTable) -> StatsdescbivariateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_table_copy(s : StatsdescbivariateTable) -> StatsdescbivariateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_table_fill(s : StatsdescbivariateTable, v : Double) -> StatsdescbivariateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_table_min(s : StatsdescbivariateTable) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_table_max(s : StatsdescbivariateTable) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_table_to_string(s : StatsdescbivariateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_graphn_make(size : Int) -> StatsdescbivariateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_graphn_len(s : StatsdescbivariateGraphN) -> Int { s.size }

pub fn stats_desc_bivariate_graphn_get(s : StatsdescbivariateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_graphn_set(s : StatsdescbivariateGraphN, i : Int, v : Double) -> StatsdescbivariateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_graphn_sum(s : StatsdescbivariateGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_graphn_mean(s : StatsdescbivariateGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_graphn_scale(s : StatsdescbivariateGraphN, f : Double) -> StatsdescbivariateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_graphn_add(a : StatsdescbivariateGraphN, b : StatsdescbivariateGraphN) -> StatsdescbivariateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_graphn_copy(s : StatsdescbivariateGraphN) -> StatsdescbivariateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_graphn_fill(s : StatsdescbivariateGraphN, v : Double) -> StatsdescbivariateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_graphn_min(s : StatsdescbivariateGraphN) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_graphn_max(s : StatsdescbivariateGraphN) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_graphn_to_string(s : StatsdescbivariateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_node_make(size : Int) -> StatsdescbivariateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_node_len(s : StatsdescbivariateNode) -> Int { s.size }

pub fn stats_desc_bivariate_node_get(s : StatsdescbivariateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_node_set(s : StatsdescbivariateNode, i : Int, v : Double) -> StatsdescbivariateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_node_sum(s : StatsdescbivariateNode) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_node_mean(s : StatsdescbivariateNode) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_node_scale(s : StatsdescbivariateNode, f : Double) -> StatsdescbivariateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_node_add(a : StatsdescbivariateNode, b : StatsdescbivariateNode) -> StatsdescbivariateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_node_copy(s : StatsdescbivariateNode) -> StatsdescbivariateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_node_fill(s : StatsdescbivariateNode, v : Double) -> StatsdescbivariateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_node_min(s : StatsdescbivariateNode) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_node_max(s : StatsdescbivariateNode) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_node_to_string(s : StatsdescbivariateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_edge_make(size : Int) -> StatsdescbivariateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_edge_len(s : StatsdescbivariateEdge) -> Int { s.size }

pub fn stats_desc_bivariate_edge_get(s : StatsdescbivariateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_edge_set(s : StatsdescbivariateEdge, i : Int, v : Double) -> StatsdescbivariateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_edge_sum(s : StatsdescbivariateEdge) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_edge_mean(s : StatsdescbivariateEdge) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_edge_scale(s : StatsdescbivariateEdge, f : Double) -> StatsdescbivariateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_edge_add(a : StatsdescbivariateEdge, b : StatsdescbivariateEdge) -> StatsdescbivariateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_edge_copy(s : StatsdescbivariateEdge) -> StatsdescbivariateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_edge_fill(s : StatsdescbivariateEdge, v : Double) -> StatsdescbivariateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_edge_min(s : StatsdescbivariateEdge) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_edge_max(s : StatsdescbivariateEdge) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_edge_to_string(s : StatsdescbivariateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_path_make(size : Int) -> StatsdescbivariatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_path_len(s : StatsdescbivariatePath) -> Int { s.size }

pub fn stats_desc_bivariate_path_get(s : StatsdescbivariatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_path_set(s : StatsdescbivariatePath, i : Int, v : Double) -> StatsdescbivariatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_path_sum(s : StatsdescbivariatePath) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_path_mean(s : StatsdescbivariatePath) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_path_scale(s : StatsdescbivariatePath, f : Double) -> StatsdescbivariatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_path_add(a : StatsdescbivariatePath, b : StatsdescbivariatePath) -> StatsdescbivariatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_path_copy(s : StatsdescbivariatePath) -> StatsdescbivariatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_path_fill(s : StatsdescbivariatePath, v : Double) -> StatsdescbivariatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_path_min(s : StatsdescbivariatePath) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_path_max(s : StatsdescbivariatePath) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_path_to_string(s : StatsdescbivariatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_cluster_make(size : Int) -> StatsdescbivariateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_cluster_len(s : StatsdescbivariateCluster) -> Int { s.size }

pub fn stats_desc_bivariate_cluster_get(s : StatsdescbivariateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_cluster_set(s : StatsdescbivariateCluster, i : Int, v : Double) -> StatsdescbivariateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_cluster_sum(s : StatsdescbivariateCluster) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_cluster_mean(s : StatsdescbivariateCluster) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_cluster_scale(s : StatsdescbivariateCluster, f : Double) -> StatsdescbivariateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_cluster_add(a : StatsdescbivariateCluster, b : StatsdescbivariateCluster) -> StatsdescbivariateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_cluster_copy(s : StatsdescbivariateCluster) -> StatsdescbivariateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_cluster_fill(s : StatsdescbivariateCluster, v : Double) -> StatsdescbivariateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_cluster_min(s : StatsdescbivariateCluster) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_cluster_max(s : StatsdescbivariateCluster) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_cluster_to_string(s : StatsdescbivariateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_model_make(size : Int) -> StatsdescbivariateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_model_len(s : StatsdescbivariateModel) -> Int { s.size }

pub fn stats_desc_bivariate_model_get(s : StatsdescbivariateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_model_set(s : StatsdescbivariateModel, i : Int, v : Double) -> StatsdescbivariateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_model_sum(s : StatsdescbivariateModel) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_model_mean(s : StatsdescbivariateModel) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_model_scale(s : StatsdescbivariateModel, f : Double) -> StatsdescbivariateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_model_add(a : StatsdescbivariateModel, b : StatsdescbivariateModel) -> StatsdescbivariateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_model_copy(s : StatsdescbivariateModel) -> StatsdescbivariateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_model_fill(s : StatsdescbivariateModel, v : Double) -> StatsdescbivariateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_model_min(s : StatsdescbivariateModel) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_model_max(s : StatsdescbivariateModel) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_model_to_string(s : StatsdescbivariateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_layer_make(size : Int) -> StatsdescbivariateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_layer_len(s : StatsdescbivariateLayer) -> Int { s.size }

pub fn stats_desc_bivariate_layer_get(s : StatsdescbivariateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_layer_set(s : StatsdescbivariateLayer, i : Int, v : Double) -> StatsdescbivariateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_layer_sum(s : StatsdescbivariateLayer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_layer_mean(s : StatsdescbivariateLayer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_layer_scale(s : StatsdescbivariateLayer, f : Double) -> StatsdescbivariateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_layer_add(a : StatsdescbivariateLayer, b : StatsdescbivariateLayer) -> StatsdescbivariateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_layer_copy(s : StatsdescbivariateLayer) -> StatsdescbivariateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_layer_fill(s : StatsdescbivariateLayer, v : Double) -> StatsdescbivariateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_layer_min(s : StatsdescbivariateLayer) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_layer_max(s : StatsdescbivariateLayer) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_layer_to_string(s : StatsdescbivariateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_buffer_make(size : Int) -> StatsdescbivariateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_buffer_len(s : StatsdescbivariateBuffer) -> Int { s.size }

pub fn stats_desc_bivariate_buffer_get(s : StatsdescbivariateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_buffer_set(s : StatsdescbivariateBuffer, i : Int, v : Double) -> StatsdescbivariateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_buffer_sum(s : StatsdescbivariateBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_buffer_mean(s : StatsdescbivariateBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_buffer_scale(s : StatsdescbivariateBuffer, f : Double) -> StatsdescbivariateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_buffer_add(a : StatsdescbivariateBuffer, b : StatsdescbivariateBuffer) -> StatsdescbivariateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_buffer_copy(s : StatsdescbivariateBuffer) -> StatsdescbivariateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_buffer_fill(s : StatsdescbivariateBuffer, v : Double) -> StatsdescbivariateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_buffer_min(s : StatsdescbivariateBuffer) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_buffer_max(s : StatsdescbivariateBuffer) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_buffer_to_string(s : StatsdescbivariateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_cursor_make(size : Int) -> StatsdescbivariateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_cursor_len(s : StatsdescbivariateCursor) -> Int { s.size }

pub fn stats_desc_bivariate_cursor_get(s : StatsdescbivariateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_cursor_set(s : StatsdescbivariateCursor, i : Int, v : Double) -> StatsdescbivariateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_cursor_sum(s : StatsdescbivariateCursor) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_cursor_mean(s : StatsdescbivariateCursor) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_cursor_scale(s : StatsdescbivariateCursor, f : Double) -> StatsdescbivariateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_cursor_add(a : StatsdescbivariateCursor, b : StatsdescbivariateCursor) -> StatsdescbivariateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_cursor_copy(s : StatsdescbivariateCursor) -> StatsdescbivariateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_cursor_fill(s : StatsdescbivariateCursor, v : Double) -> StatsdescbivariateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_cursor_min(s : StatsdescbivariateCursor) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_cursor_max(s : StatsdescbivariateCursor) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_cursor_to_string(s : StatsdescbivariateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_view_make(size : Int) -> StatsdescbivariateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_view_len(s : StatsdescbivariateView) -> Int { s.size }

pub fn stats_desc_bivariate_view_get(s : StatsdescbivariateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_view_set(s : StatsdescbivariateView, i : Int, v : Double) -> StatsdescbivariateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_view_sum(s : StatsdescbivariateView) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_view_mean(s : StatsdescbivariateView) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_view_scale(s : StatsdescbivariateView, f : Double) -> StatsdescbivariateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_view_add(a : StatsdescbivariateView, b : StatsdescbivariateView) -> StatsdescbivariateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_view_copy(s : StatsdescbivariateView) -> StatsdescbivariateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_view_fill(s : StatsdescbivariateView, v : Double) -> StatsdescbivariateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_view_min(s : StatsdescbivariateView) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_view_max(s : StatsdescbivariateView) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_view_to_string(s : StatsdescbivariateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_range_make(size : Int) -> StatsdescbivariateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_range_len(s : StatsdescbivariateRange) -> Int { s.size }

pub fn stats_desc_bivariate_range_get(s : StatsdescbivariateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_range_set(s : StatsdescbivariateRange, i : Int, v : Double) -> StatsdescbivariateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_range_sum(s : StatsdescbivariateRange) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_range_mean(s : StatsdescbivariateRange) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_range_scale(s : StatsdescbivariateRange, f : Double) -> StatsdescbivariateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_range_add(a : StatsdescbivariateRange, b : StatsdescbivariateRange) -> StatsdescbivariateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_range_copy(s : StatsdescbivariateRange) -> StatsdescbivariateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_range_fill(s : StatsdescbivariateRange, v : Double) -> StatsdescbivariateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_range_min(s : StatsdescbivariateRange) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_range_max(s : StatsdescbivariateRange) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_range_to_string(s : StatsdescbivariateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_slice_make(size : Int) -> StatsdescbivariateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_slice_len(s : StatsdescbivariateSlice) -> Int { s.size }

pub fn stats_desc_bivariate_slice_get(s : StatsdescbivariateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_slice_set(s : StatsdescbivariateSlice, i : Int, v : Double) -> StatsdescbivariateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_slice_sum(s : StatsdescbivariateSlice) -> Double { @_common.sum(s.data) }

pub fn stats_desc_bivariate_slice_mean(s : StatsdescbivariateSlice) -> Double { @_common.mean(s.data) }

pub fn stats_desc_bivariate_slice_scale(s : StatsdescbivariateSlice, f : Double) -> StatsdescbivariateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_slice_add(a : StatsdescbivariateSlice, b : StatsdescbivariateSlice) -> StatsdescbivariateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_bivariate_slice_copy(s : StatsdescbivariateSlice) -> StatsdescbivariateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_slice_fill(s : StatsdescbivariateSlice, v : Double) -> StatsdescbivariateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_bivariate_slice_min(s : StatsdescbivariateSlice) -> Double { @_common.min(s.data) }

pub fn stats_desc_bivariate_slice_max(s : StatsdescbivariateSlice) -> Double { @_common.max(s.data) }

pub fn stats_desc_bivariate_slice_to_string(s : StatsdescbivariateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

