///===
/// extcore/stats_dist_weibull

pub(all) struct StatsdistweibullPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_weibull_make_point(x : Double, y : Double) -> StatsdistweibullPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_weibull_make_point3(x : Double, y : Double, z : Double) -> StatsdistweibullPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistweibullPoint::x(self : StatsdistweibullPoint) -> Double { self.x }

pub fn StatsdistweibullPoint::y(self : StatsdistweibullPoint) -> Double { self.y }

pub fn StatsdistweibullPoint::z(self : StatsdistweibullPoint) -> Double { self.z }

pub fn StatsdistweibullPoint::label(self : StatsdistweibullPoint) -> Int { self.label }

pub fn StatsdistweibullPoint::dist(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistweibullPoint::add(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistweibullPoint::sub(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistweibullPoint::scale(self : StatsdistweibullPoint, s : Double) -> StatsdistweibullPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistweibullPoint::dot(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistweibullPoint::cross(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistweibullPoint::norm(self : StatsdistweibullPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistweibullPoint::normalize(self : StatsdistweibullPoint) -> StatsdistweibullPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistweibullPoint::negate(self : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistweibullPoint::mid(self : StatsdistweibullPoint, other : StatsdistweibullPoint) -> StatsdistweibullPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistweibullPoint::lerp(self : StatsdistweibullPoint, other : StatsdistweibullPoint, t : Double) -> StatsdistweibullPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistweibullPoint::to_string(self : StatsdistweibullPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistweibullSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_weibull_make_series(vals : Array[Double], name : String) -> StatsdistweibullSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistweibullSeries::len(self : StatsdistweibullSeries) -> Int { self.vals.length() }

pub fn StatsdistweibullSeries::sum(self : StatsdistweibullSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistweibullSeries::mean(self : StatsdistweibullSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistweibullSeries::min(self : StatsdistweibullSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistweibullSeries::max(self : StatsdistweibullSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistweibullSeries::range(self : StatsdistweibullSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistweibullSeries::variance(self : StatsdistweibullSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistweibullSeries::std(self : StatsdistweibullSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistweibullSeries::median(self : StatsdistweibullSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistweibullSeries::scale(self : StatsdistweibullSeries, f : Double) -> StatsdistweibullSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistweibullSeries::add(self : StatsdistweibullSeries, other : StatsdistweibullSeries) -> StatsdistweibullSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistweibullSeries::sub(self : StatsdistweibullSeries, other : StatsdistweibullSeries) -> StatsdistweibullSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistweibullSeries::normalize(self : StatsdistweibullSeries) -> StatsdistweibullSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistweibullSeries::cumsum(self : StatsdistweibullSeries) -> StatsdistweibullSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistweibullSeries::to_string(self : StatsdistweibullSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistweibullMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_weibull_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistweibullMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_weibull_matrix_identity(n : Int) -> StatsdistweibullMatrix {
  let m = stats_dist_weibull_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistweibullMatrix::get(self : StatsdistweibullMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistweibullMatrix::transpose(self : StatsdistweibullMatrix) -> StatsdistweibullMatrix {
  let result = stats_dist_weibull_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistweibullMatrix::add(self : StatsdistweibullMatrix, other : StatsdistweibullMatrix) -> StatsdistweibullMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_weibull_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistweibullMatrix::scale(self : StatsdistweibullMatrix, s : Double) -> StatsdistweibullMatrix {
  let result = stats_dist_weibull_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistweibullMatrix::multiply(self : StatsdistweibullMatrix, other : StatsdistweibullMatrix) -> StatsdistweibullMatrix {
  if self.cols != other.rows { return stats_dist_weibull_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_weibull_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistweibullMatrix::trace(self : StatsdistweibullMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistweibullMatrix::det(self : StatsdistweibullMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistweibullMatrix::norm(self : StatsdistweibullMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistweibullMatrix::to_string(self : StatsdistweibullMatrix) -> String {
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

pub(all) struct StatsdistweibullVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_weibull_make_vector(comps : Array[Double]) -> StatsdistweibullVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_weibull_vector_zero(dim : Int) -> StatsdistweibullVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistweibullVector::add(self : StatsdistweibullVector, other : StatsdistweibullVector) -> StatsdistweibullVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistweibullVector::sub(self : StatsdistweibullVector, other : StatsdistweibullVector) -> StatsdistweibullVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistweibullVector::scale(self : StatsdistweibullVector, s : Double) -> StatsdistweibullVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistweibullVector::dot(self : StatsdistweibullVector, other : StatsdistweibullVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistweibullVector::norm(self : StatsdistweibullVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistweibullVector::normalize(self : StatsdistweibullVector) -> StatsdistweibullVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistweibullVector::dist(self : StatsdistweibullVector, other : StatsdistweibullVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistweibullVector::to_string(self : StatsdistweibullVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_weibull_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_weibull_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_weibull_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_weibull_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_weibull_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_weibull_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_weibull_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_weibull_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_weibull_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_weibull_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_weibull_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_weibull_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_weibull_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_weibull_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_weibull_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_weibull_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_weibull_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_weibull_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_weibull_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_weibull_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_weibull_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_weibull_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_weibull_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_weibull_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_weibull_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_weibull_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_weibull_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_weibull_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_weibull_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistweibullFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_frame_make(size : Int) -> StatsdistweibullFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_frame_len(s : StatsdistweibullFrame) -> Int { s.size }

pub fn stats_dist_weibull_frame_get(s : StatsdistweibullFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_frame_set(s : StatsdistweibullFrame, i : Int, v : Double) -> StatsdistweibullFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_frame_sum(s : StatsdistweibullFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_frame_mean(s : StatsdistweibullFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_frame_scale(s : StatsdistweibullFrame, f : Double) -> StatsdistweibullFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_frame_add(a : StatsdistweibullFrame, b : StatsdistweibullFrame) -> StatsdistweibullFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_frame_copy(s : StatsdistweibullFrame) -> StatsdistweibullFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_frame_fill(s : StatsdistweibullFrame, v : Double) -> StatsdistweibullFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_frame_min(s : StatsdistweibullFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_frame_max(s : StatsdistweibullFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_frame_to_string(s : StatsdistweibullFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_table_make(size : Int) -> StatsdistweibullTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_table_len(s : StatsdistweibullTable) -> Int { s.size }

pub fn stats_dist_weibull_table_get(s : StatsdistweibullTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_table_set(s : StatsdistweibullTable, i : Int, v : Double) -> StatsdistweibullTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_table_sum(s : StatsdistweibullTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_table_mean(s : StatsdistweibullTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_table_scale(s : StatsdistweibullTable, f : Double) -> StatsdistweibullTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_table_add(a : StatsdistweibullTable, b : StatsdistweibullTable) -> StatsdistweibullTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_table_copy(s : StatsdistweibullTable) -> StatsdistweibullTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_table_fill(s : StatsdistweibullTable, v : Double) -> StatsdistweibullTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_table_min(s : StatsdistweibullTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_table_max(s : StatsdistweibullTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_table_to_string(s : StatsdistweibullTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_graphn_make(size : Int) -> StatsdistweibullGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_graphn_len(s : StatsdistweibullGraphN) -> Int { s.size }

pub fn stats_dist_weibull_graphn_get(s : StatsdistweibullGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_graphn_set(s : StatsdistweibullGraphN, i : Int, v : Double) -> StatsdistweibullGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_graphn_sum(s : StatsdistweibullGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_graphn_mean(s : StatsdistweibullGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_graphn_scale(s : StatsdistweibullGraphN, f : Double) -> StatsdistweibullGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_graphn_add(a : StatsdistweibullGraphN, b : StatsdistweibullGraphN) -> StatsdistweibullGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_graphn_copy(s : StatsdistweibullGraphN) -> StatsdistweibullGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_graphn_fill(s : StatsdistweibullGraphN, v : Double) -> StatsdistweibullGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_graphn_min(s : StatsdistweibullGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_graphn_max(s : StatsdistweibullGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_graphn_to_string(s : StatsdistweibullGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_node_make(size : Int) -> StatsdistweibullNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_node_len(s : StatsdistweibullNode) -> Int { s.size }

pub fn stats_dist_weibull_node_get(s : StatsdistweibullNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_node_set(s : StatsdistweibullNode, i : Int, v : Double) -> StatsdistweibullNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_node_sum(s : StatsdistweibullNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_node_mean(s : StatsdistweibullNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_node_scale(s : StatsdistweibullNode, f : Double) -> StatsdistweibullNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_node_add(a : StatsdistweibullNode, b : StatsdistweibullNode) -> StatsdistweibullNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_node_copy(s : StatsdistweibullNode) -> StatsdistweibullNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_node_fill(s : StatsdistweibullNode, v : Double) -> StatsdistweibullNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_node_min(s : StatsdistweibullNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_node_max(s : StatsdistweibullNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_node_to_string(s : StatsdistweibullNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_edge_make(size : Int) -> StatsdistweibullEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_edge_len(s : StatsdistweibullEdge) -> Int { s.size }

pub fn stats_dist_weibull_edge_get(s : StatsdistweibullEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_edge_set(s : StatsdistweibullEdge, i : Int, v : Double) -> StatsdistweibullEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_edge_sum(s : StatsdistweibullEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_edge_mean(s : StatsdistweibullEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_edge_scale(s : StatsdistweibullEdge, f : Double) -> StatsdistweibullEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_edge_add(a : StatsdistweibullEdge, b : StatsdistweibullEdge) -> StatsdistweibullEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_edge_copy(s : StatsdistweibullEdge) -> StatsdistweibullEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_edge_fill(s : StatsdistweibullEdge, v : Double) -> StatsdistweibullEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_edge_min(s : StatsdistweibullEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_edge_max(s : StatsdistweibullEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_edge_to_string(s : StatsdistweibullEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_path_make(size : Int) -> StatsdistweibullPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_path_len(s : StatsdistweibullPath) -> Int { s.size }

pub fn stats_dist_weibull_path_get(s : StatsdistweibullPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_path_set(s : StatsdistweibullPath, i : Int, v : Double) -> StatsdistweibullPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_path_sum(s : StatsdistweibullPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_path_mean(s : StatsdistweibullPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_path_scale(s : StatsdistweibullPath, f : Double) -> StatsdistweibullPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_path_add(a : StatsdistweibullPath, b : StatsdistweibullPath) -> StatsdistweibullPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_path_copy(s : StatsdistweibullPath) -> StatsdistweibullPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_path_fill(s : StatsdistweibullPath, v : Double) -> StatsdistweibullPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_path_min(s : StatsdistweibullPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_path_max(s : StatsdistweibullPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_path_to_string(s : StatsdistweibullPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_cluster_make(size : Int) -> StatsdistweibullCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_cluster_len(s : StatsdistweibullCluster) -> Int { s.size }

pub fn stats_dist_weibull_cluster_get(s : StatsdistweibullCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_cluster_set(s : StatsdistweibullCluster, i : Int, v : Double) -> StatsdistweibullCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_cluster_sum(s : StatsdistweibullCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_cluster_mean(s : StatsdistweibullCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_cluster_scale(s : StatsdistweibullCluster, f : Double) -> StatsdistweibullCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_cluster_add(a : StatsdistweibullCluster, b : StatsdistweibullCluster) -> StatsdistweibullCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_cluster_copy(s : StatsdistweibullCluster) -> StatsdistweibullCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_cluster_fill(s : StatsdistweibullCluster, v : Double) -> StatsdistweibullCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_cluster_min(s : StatsdistweibullCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_cluster_max(s : StatsdistweibullCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_cluster_to_string(s : StatsdistweibullCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_model_make(size : Int) -> StatsdistweibullModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_model_len(s : StatsdistweibullModel) -> Int { s.size }

pub fn stats_dist_weibull_model_get(s : StatsdistweibullModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_model_set(s : StatsdistweibullModel, i : Int, v : Double) -> StatsdistweibullModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_model_sum(s : StatsdistweibullModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_model_mean(s : StatsdistweibullModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_model_scale(s : StatsdistweibullModel, f : Double) -> StatsdistweibullModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_model_add(a : StatsdistweibullModel, b : StatsdistweibullModel) -> StatsdistweibullModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_model_copy(s : StatsdistweibullModel) -> StatsdistweibullModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_model_fill(s : StatsdistweibullModel, v : Double) -> StatsdistweibullModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_model_min(s : StatsdistweibullModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_model_max(s : StatsdistweibullModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_model_to_string(s : StatsdistweibullModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_layer_make(size : Int) -> StatsdistweibullLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_layer_len(s : StatsdistweibullLayer) -> Int { s.size }

pub fn stats_dist_weibull_layer_get(s : StatsdistweibullLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_layer_set(s : StatsdistweibullLayer, i : Int, v : Double) -> StatsdistweibullLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_layer_sum(s : StatsdistweibullLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_layer_mean(s : StatsdistweibullLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_layer_scale(s : StatsdistweibullLayer, f : Double) -> StatsdistweibullLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_layer_add(a : StatsdistweibullLayer, b : StatsdistweibullLayer) -> StatsdistweibullLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_layer_copy(s : StatsdistweibullLayer) -> StatsdistweibullLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_layer_fill(s : StatsdistweibullLayer, v : Double) -> StatsdistweibullLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_layer_min(s : StatsdistweibullLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_layer_max(s : StatsdistweibullLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_layer_to_string(s : StatsdistweibullLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_buffer_make(size : Int) -> StatsdistweibullBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_buffer_len(s : StatsdistweibullBuffer) -> Int { s.size }

pub fn stats_dist_weibull_buffer_get(s : StatsdistweibullBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_buffer_set(s : StatsdistweibullBuffer, i : Int, v : Double) -> StatsdistweibullBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_buffer_sum(s : StatsdistweibullBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_buffer_mean(s : StatsdistweibullBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_buffer_scale(s : StatsdistweibullBuffer, f : Double) -> StatsdistweibullBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_buffer_add(a : StatsdistweibullBuffer, b : StatsdistweibullBuffer) -> StatsdistweibullBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_buffer_copy(s : StatsdistweibullBuffer) -> StatsdistweibullBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_buffer_fill(s : StatsdistweibullBuffer, v : Double) -> StatsdistweibullBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_buffer_min(s : StatsdistweibullBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_buffer_max(s : StatsdistweibullBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_buffer_to_string(s : StatsdistweibullBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_cursor_make(size : Int) -> StatsdistweibullCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_cursor_len(s : StatsdistweibullCursor) -> Int { s.size }

pub fn stats_dist_weibull_cursor_get(s : StatsdistweibullCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_cursor_set(s : StatsdistweibullCursor, i : Int, v : Double) -> StatsdistweibullCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_cursor_sum(s : StatsdistweibullCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_cursor_mean(s : StatsdistweibullCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_cursor_scale(s : StatsdistweibullCursor, f : Double) -> StatsdistweibullCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_cursor_add(a : StatsdistweibullCursor, b : StatsdistweibullCursor) -> StatsdistweibullCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_cursor_copy(s : StatsdistweibullCursor) -> StatsdistweibullCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_cursor_fill(s : StatsdistweibullCursor, v : Double) -> StatsdistweibullCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_cursor_min(s : StatsdistweibullCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_cursor_max(s : StatsdistweibullCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_cursor_to_string(s : StatsdistweibullCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_view_make(size : Int) -> StatsdistweibullView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_view_len(s : StatsdistweibullView) -> Int { s.size }

pub fn stats_dist_weibull_view_get(s : StatsdistweibullView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_view_set(s : StatsdistweibullView, i : Int, v : Double) -> StatsdistweibullView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_view_sum(s : StatsdistweibullView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_view_mean(s : StatsdistweibullView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_view_scale(s : StatsdistweibullView, f : Double) -> StatsdistweibullView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_view_add(a : StatsdistweibullView, b : StatsdistweibullView) -> StatsdistweibullView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_view_copy(s : StatsdistweibullView) -> StatsdistweibullView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_view_fill(s : StatsdistweibullView, v : Double) -> StatsdistweibullView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_view_min(s : StatsdistweibullView) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_view_max(s : StatsdistweibullView) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_view_to_string(s : StatsdistweibullView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_range_make(size : Int) -> StatsdistweibullRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_range_len(s : StatsdistweibullRange) -> Int { s.size }

pub fn stats_dist_weibull_range_get(s : StatsdistweibullRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_range_set(s : StatsdistweibullRange, i : Int, v : Double) -> StatsdistweibullRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_range_sum(s : StatsdistweibullRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_range_mean(s : StatsdistweibullRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_range_scale(s : StatsdistweibullRange, f : Double) -> StatsdistweibullRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_range_add(a : StatsdistweibullRange, b : StatsdistweibullRange) -> StatsdistweibullRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_range_copy(s : StatsdistweibullRange) -> StatsdistweibullRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_range_fill(s : StatsdistweibullRange, v : Double) -> StatsdistweibullRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_range_min(s : StatsdistweibullRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_range_max(s : StatsdistweibullRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_range_to_string(s : StatsdistweibullRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistweibullSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_weibull_slice_make(size : Int) -> StatsdistweibullSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_weibull_slice_len(s : StatsdistweibullSlice) -> Int { s.size }

pub fn stats_dist_weibull_slice_get(s : StatsdistweibullSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_weibull_slice_set(s : StatsdistweibullSlice, i : Int, v : Double) -> StatsdistweibullSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_slice_sum(s : StatsdistweibullSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_weibull_slice_mean(s : StatsdistweibullSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_weibull_slice_scale(s : StatsdistweibullSlice, f : Double) -> StatsdistweibullSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_slice_add(a : StatsdistweibullSlice, b : StatsdistweibullSlice) -> StatsdistweibullSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_weibull_slice_copy(s : StatsdistweibullSlice) -> StatsdistweibullSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_slice_fill(s : StatsdistweibullSlice, v : Double) -> StatsdistweibullSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_weibull_slice_min(s : StatsdistweibullSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_weibull_slice_max(s : StatsdistweibullSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_weibull_slice_to_string(s : StatsdistweibullSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

