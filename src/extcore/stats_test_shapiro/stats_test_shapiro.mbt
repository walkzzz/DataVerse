///===
/// extcore/stats_test_shapiro

pub(all) struct StatstestshapiroPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_shapiro_make_point(x : Double, y : Double) -> StatstestshapiroPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_shapiro_make_point3(x : Double, y : Double, z : Double) -> StatstestshapiroPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestshapiroPoint::x(self : StatstestshapiroPoint) -> Double { self.x }

pub fn StatstestshapiroPoint::y(self : StatstestshapiroPoint) -> Double { self.y }

pub fn StatstestshapiroPoint::z(self : StatstestshapiroPoint) -> Double { self.z }

pub fn StatstestshapiroPoint::label(self : StatstestshapiroPoint) -> Int { self.label }

pub fn StatstestshapiroPoint::dist(self : StatstestshapiroPoint, other : StatstestshapiroPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestshapiroPoint::add(self : StatstestshapiroPoint, other : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestshapiroPoint::sub(self : StatstestshapiroPoint, other : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestshapiroPoint::scale(self : StatstestshapiroPoint, s : Double) -> StatstestshapiroPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestshapiroPoint::dot(self : StatstestshapiroPoint, other : StatstestshapiroPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestshapiroPoint::cross(self : StatstestshapiroPoint, other : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestshapiroPoint::norm(self : StatstestshapiroPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestshapiroPoint::normalize(self : StatstestshapiroPoint) -> StatstestshapiroPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestshapiroPoint::negate(self : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestshapiroPoint::mid(self : StatstestshapiroPoint, other : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestshapiroPoint::lerp(self : StatstestshapiroPoint, other : StatstestshapiroPoint, t : Double) -> StatstestshapiroPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestshapiroPoint::to_string(self : StatstestshapiroPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestshapiroSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_shapiro_make_series(vals : Array[Double], name : String) -> StatstestshapiroSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestshapiroSeries::len(self : StatstestshapiroSeries) -> Int { self.vals.length() }

pub fn StatstestshapiroSeries::sum(self : StatstestshapiroSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestshapiroSeries::mean(self : StatstestshapiroSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestshapiroSeries::min(self : StatstestshapiroSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestshapiroSeries::max(self : StatstestshapiroSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestshapiroSeries::range(self : StatstestshapiroSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestshapiroSeries::variance(self : StatstestshapiroSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestshapiroSeries::std(self : StatstestshapiroSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestshapiroSeries::median(self : StatstestshapiroSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestshapiroSeries::scale(self : StatstestshapiroSeries, f : Double) -> StatstestshapiroSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestshapiroSeries::add(self : StatstestshapiroSeries, other : StatstestshapiroSeries) -> StatstestshapiroSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestshapiroSeries::sub(self : StatstestshapiroSeries, other : StatstestshapiroSeries) -> StatstestshapiroSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestshapiroSeries::normalize(self : StatstestshapiroSeries) -> StatstestshapiroSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestshapiroSeries::cumsum(self : StatstestshapiroSeries) -> StatstestshapiroSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestshapiroSeries::to_string(self : StatstestshapiroSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestshapiroMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_shapiro_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestshapiroMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_shapiro_matrix_identity(n : Int) -> StatstestshapiroMatrix {
  let m = stats_test_shapiro_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestshapiroMatrix::get(self : StatstestshapiroMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestshapiroMatrix::transpose(self : StatstestshapiroMatrix) -> StatstestshapiroMatrix {
  let result = stats_test_shapiro_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestshapiroMatrix::add(self : StatstestshapiroMatrix, other : StatstestshapiroMatrix) -> StatstestshapiroMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_shapiro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestshapiroMatrix::scale(self : StatstestshapiroMatrix, s : Double) -> StatstestshapiroMatrix {
  let result = stats_test_shapiro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestshapiroMatrix::multiply(self : StatstestshapiroMatrix, other : StatstestshapiroMatrix) -> StatstestshapiroMatrix {
  if self.cols != other.rows { return stats_test_shapiro_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_shapiro_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatstestshapiroMatrix::trace(self : StatstestshapiroMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestshapiroMatrix::det(self : StatstestshapiroMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestshapiroMatrix::norm(self : StatstestshapiroMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestshapiroMatrix::to_string(self : StatstestshapiroMatrix) -> String {
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

pub(all) struct StatstestshapiroVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_shapiro_make_vector(comps : Array[Double]) -> StatstestshapiroVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_shapiro_vector_zero(dim : Int) -> StatstestshapiroVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestshapiroVector::add(self : StatstestshapiroVector, other : StatstestshapiroVector) -> StatstestshapiroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestshapiroVector::sub(self : StatstestshapiroVector, other : StatstestshapiroVector) -> StatstestshapiroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestshapiroVector::scale(self : StatstestshapiroVector, s : Double) -> StatstestshapiroVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestshapiroVector::dot(self : StatstestshapiroVector, other : StatstestshapiroVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestshapiroVector::norm(self : StatstestshapiroVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestshapiroVector::normalize(self : StatstestshapiroVector) -> StatstestshapiroVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestshapiroVector::dist(self : StatstestshapiroVector, other : StatstestshapiroVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestshapiroVector::to_string(self : StatstestshapiroVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_shapiro_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_shapiro_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_shapiro_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_shapiro_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_shapiro_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_shapiro_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_shapiro_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_shapiro_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_shapiro_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_shapiro_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_shapiro_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_shapiro_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_shapiro_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_shapiro_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_shapiro_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_shapiro_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_shapiro_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_shapiro_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_shapiro_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_shapiro_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_shapiro_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_shapiro_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_shapiro_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_shapiro_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_shapiro_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_shapiro_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_shapiro_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_shapiro_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_shapiro_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestshapiroFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_frame_make(size : Int) -> StatstestshapiroFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_frame_len(s : StatstestshapiroFrame) -> Int { s.size }

pub fn stats_test_shapiro_frame_get(s : StatstestshapiroFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_frame_set(s : StatstestshapiroFrame, i : Int, v : Double) -> StatstestshapiroFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_frame_sum(s : StatstestshapiroFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_frame_mean(s : StatstestshapiroFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_frame_scale(s : StatstestshapiroFrame, f : Double) -> StatstestshapiroFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_frame_add(a : StatstestshapiroFrame, b : StatstestshapiroFrame) -> StatstestshapiroFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_frame_copy(s : StatstestshapiroFrame) -> StatstestshapiroFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_frame_fill(s : StatstestshapiroFrame, v : Double) -> StatstestshapiroFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_frame_min(s : StatstestshapiroFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_frame_max(s : StatstestshapiroFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_frame_to_string(s : StatstestshapiroFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_table_make(size : Int) -> StatstestshapiroTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_table_len(s : StatstestshapiroTable) -> Int { s.size }

pub fn stats_test_shapiro_table_get(s : StatstestshapiroTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_table_set(s : StatstestshapiroTable, i : Int, v : Double) -> StatstestshapiroTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_table_sum(s : StatstestshapiroTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_table_mean(s : StatstestshapiroTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_table_scale(s : StatstestshapiroTable, f : Double) -> StatstestshapiroTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_table_add(a : StatstestshapiroTable, b : StatstestshapiroTable) -> StatstestshapiroTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_table_copy(s : StatstestshapiroTable) -> StatstestshapiroTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_table_fill(s : StatstestshapiroTable, v : Double) -> StatstestshapiroTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_table_min(s : StatstestshapiroTable) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_table_max(s : StatstestshapiroTable) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_table_to_string(s : StatstestshapiroTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_graphn_make(size : Int) -> StatstestshapiroGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_graphn_len(s : StatstestshapiroGraphN) -> Int { s.size }

pub fn stats_test_shapiro_graphn_get(s : StatstestshapiroGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_graphn_set(s : StatstestshapiroGraphN, i : Int, v : Double) -> StatstestshapiroGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_graphn_sum(s : StatstestshapiroGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_graphn_mean(s : StatstestshapiroGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_graphn_scale(s : StatstestshapiroGraphN, f : Double) -> StatstestshapiroGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_graphn_add(a : StatstestshapiroGraphN, b : StatstestshapiroGraphN) -> StatstestshapiroGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_graphn_copy(s : StatstestshapiroGraphN) -> StatstestshapiroGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_graphn_fill(s : StatstestshapiroGraphN, v : Double) -> StatstestshapiroGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_graphn_min(s : StatstestshapiroGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_graphn_max(s : StatstestshapiroGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_graphn_to_string(s : StatstestshapiroGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_node_make(size : Int) -> StatstestshapiroNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_node_len(s : StatstestshapiroNode) -> Int { s.size }

pub fn stats_test_shapiro_node_get(s : StatstestshapiroNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_node_set(s : StatstestshapiroNode, i : Int, v : Double) -> StatstestshapiroNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_node_sum(s : StatstestshapiroNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_node_mean(s : StatstestshapiroNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_node_scale(s : StatstestshapiroNode, f : Double) -> StatstestshapiroNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_node_add(a : StatstestshapiroNode, b : StatstestshapiroNode) -> StatstestshapiroNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_node_copy(s : StatstestshapiroNode) -> StatstestshapiroNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_node_fill(s : StatstestshapiroNode, v : Double) -> StatstestshapiroNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_node_min(s : StatstestshapiroNode) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_node_max(s : StatstestshapiroNode) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_node_to_string(s : StatstestshapiroNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_edge_make(size : Int) -> StatstestshapiroEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_edge_len(s : StatstestshapiroEdge) -> Int { s.size }

pub fn stats_test_shapiro_edge_get(s : StatstestshapiroEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_edge_set(s : StatstestshapiroEdge, i : Int, v : Double) -> StatstestshapiroEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_edge_sum(s : StatstestshapiroEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_edge_mean(s : StatstestshapiroEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_edge_scale(s : StatstestshapiroEdge, f : Double) -> StatstestshapiroEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_edge_add(a : StatstestshapiroEdge, b : StatstestshapiroEdge) -> StatstestshapiroEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_edge_copy(s : StatstestshapiroEdge) -> StatstestshapiroEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_edge_fill(s : StatstestshapiroEdge, v : Double) -> StatstestshapiroEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_edge_min(s : StatstestshapiroEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_edge_max(s : StatstestshapiroEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_edge_to_string(s : StatstestshapiroEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_path_make(size : Int) -> StatstestshapiroPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_path_len(s : StatstestshapiroPath) -> Int { s.size }

pub fn stats_test_shapiro_path_get(s : StatstestshapiroPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_path_set(s : StatstestshapiroPath, i : Int, v : Double) -> StatstestshapiroPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_path_sum(s : StatstestshapiroPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_path_mean(s : StatstestshapiroPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_path_scale(s : StatstestshapiroPath, f : Double) -> StatstestshapiroPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_path_add(a : StatstestshapiroPath, b : StatstestshapiroPath) -> StatstestshapiroPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_path_copy(s : StatstestshapiroPath) -> StatstestshapiroPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_path_fill(s : StatstestshapiroPath, v : Double) -> StatstestshapiroPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_path_min(s : StatstestshapiroPath) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_path_max(s : StatstestshapiroPath) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_path_to_string(s : StatstestshapiroPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_cluster_make(size : Int) -> StatstestshapiroCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_cluster_len(s : StatstestshapiroCluster) -> Int { s.size }

pub fn stats_test_shapiro_cluster_get(s : StatstestshapiroCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_cluster_set(s : StatstestshapiroCluster, i : Int, v : Double) -> StatstestshapiroCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_cluster_sum(s : StatstestshapiroCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_cluster_mean(s : StatstestshapiroCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_cluster_scale(s : StatstestshapiroCluster, f : Double) -> StatstestshapiroCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_cluster_add(a : StatstestshapiroCluster, b : StatstestshapiroCluster) -> StatstestshapiroCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_cluster_copy(s : StatstestshapiroCluster) -> StatstestshapiroCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_cluster_fill(s : StatstestshapiroCluster, v : Double) -> StatstestshapiroCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_cluster_min(s : StatstestshapiroCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_cluster_max(s : StatstestshapiroCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_cluster_to_string(s : StatstestshapiroCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_model_make(size : Int) -> StatstestshapiroModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_model_len(s : StatstestshapiroModel) -> Int { s.size }

pub fn stats_test_shapiro_model_get(s : StatstestshapiroModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_model_set(s : StatstestshapiroModel, i : Int, v : Double) -> StatstestshapiroModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_model_sum(s : StatstestshapiroModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_model_mean(s : StatstestshapiroModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_model_scale(s : StatstestshapiroModel, f : Double) -> StatstestshapiroModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_model_add(a : StatstestshapiroModel, b : StatstestshapiroModel) -> StatstestshapiroModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_model_copy(s : StatstestshapiroModel) -> StatstestshapiroModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_model_fill(s : StatstestshapiroModel, v : Double) -> StatstestshapiroModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_model_min(s : StatstestshapiroModel) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_model_max(s : StatstestshapiroModel) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_model_to_string(s : StatstestshapiroModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_layer_make(size : Int) -> StatstestshapiroLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_layer_len(s : StatstestshapiroLayer) -> Int { s.size }

pub fn stats_test_shapiro_layer_get(s : StatstestshapiroLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_layer_set(s : StatstestshapiroLayer, i : Int, v : Double) -> StatstestshapiroLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_layer_sum(s : StatstestshapiroLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_layer_mean(s : StatstestshapiroLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_layer_scale(s : StatstestshapiroLayer, f : Double) -> StatstestshapiroLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_layer_add(a : StatstestshapiroLayer, b : StatstestshapiroLayer) -> StatstestshapiroLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_layer_copy(s : StatstestshapiroLayer) -> StatstestshapiroLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_layer_fill(s : StatstestshapiroLayer, v : Double) -> StatstestshapiroLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_layer_min(s : StatstestshapiroLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_layer_max(s : StatstestshapiroLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_layer_to_string(s : StatstestshapiroLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_buffer_make(size : Int) -> StatstestshapiroBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_buffer_len(s : StatstestshapiroBuffer) -> Int { s.size }

pub fn stats_test_shapiro_buffer_get(s : StatstestshapiroBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_buffer_set(s : StatstestshapiroBuffer, i : Int, v : Double) -> StatstestshapiroBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_buffer_sum(s : StatstestshapiroBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_buffer_mean(s : StatstestshapiroBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_buffer_scale(s : StatstestshapiroBuffer, f : Double) -> StatstestshapiroBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_buffer_add(a : StatstestshapiroBuffer, b : StatstestshapiroBuffer) -> StatstestshapiroBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_buffer_copy(s : StatstestshapiroBuffer) -> StatstestshapiroBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_buffer_fill(s : StatstestshapiroBuffer, v : Double) -> StatstestshapiroBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_buffer_min(s : StatstestshapiroBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_buffer_max(s : StatstestshapiroBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_buffer_to_string(s : StatstestshapiroBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_cursor_make(size : Int) -> StatstestshapiroCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_cursor_len(s : StatstestshapiroCursor) -> Int { s.size }

pub fn stats_test_shapiro_cursor_get(s : StatstestshapiroCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_cursor_set(s : StatstestshapiroCursor, i : Int, v : Double) -> StatstestshapiroCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_cursor_sum(s : StatstestshapiroCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_cursor_mean(s : StatstestshapiroCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_cursor_scale(s : StatstestshapiroCursor, f : Double) -> StatstestshapiroCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_cursor_add(a : StatstestshapiroCursor, b : StatstestshapiroCursor) -> StatstestshapiroCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_cursor_copy(s : StatstestshapiroCursor) -> StatstestshapiroCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_cursor_fill(s : StatstestshapiroCursor, v : Double) -> StatstestshapiroCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_cursor_min(s : StatstestshapiroCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_cursor_max(s : StatstestshapiroCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_cursor_to_string(s : StatstestshapiroCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_view_make(size : Int) -> StatstestshapiroView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_view_len(s : StatstestshapiroView) -> Int { s.size }

pub fn stats_test_shapiro_view_get(s : StatstestshapiroView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_view_set(s : StatstestshapiroView, i : Int, v : Double) -> StatstestshapiroView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_view_sum(s : StatstestshapiroView) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_view_mean(s : StatstestshapiroView) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_view_scale(s : StatstestshapiroView, f : Double) -> StatstestshapiroView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_view_add(a : StatstestshapiroView, b : StatstestshapiroView) -> StatstestshapiroView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_view_copy(s : StatstestshapiroView) -> StatstestshapiroView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_view_fill(s : StatstestshapiroView, v : Double) -> StatstestshapiroView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_view_min(s : StatstestshapiroView) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_view_max(s : StatstestshapiroView) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_view_to_string(s : StatstestshapiroView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_range_make(size : Int) -> StatstestshapiroRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_range_len(s : StatstestshapiroRange) -> Int { s.size }

pub fn stats_test_shapiro_range_get(s : StatstestshapiroRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_range_set(s : StatstestshapiroRange, i : Int, v : Double) -> StatstestshapiroRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_range_sum(s : StatstestshapiroRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_range_mean(s : StatstestshapiroRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_range_scale(s : StatstestshapiroRange, f : Double) -> StatstestshapiroRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_range_add(a : StatstestshapiroRange, b : StatstestshapiroRange) -> StatstestshapiroRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_range_copy(s : StatstestshapiroRange) -> StatstestshapiroRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_range_fill(s : StatstestshapiroRange, v : Double) -> StatstestshapiroRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_range_min(s : StatstestshapiroRange) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_range_max(s : StatstestshapiroRange) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_range_to_string(s : StatstestshapiroRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_slice_make(size : Int) -> StatstestshapiroSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_slice_len(s : StatstestshapiroSlice) -> Int { s.size }

pub fn stats_test_shapiro_slice_get(s : StatstestshapiroSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_slice_set(s : StatstestshapiroSlice, i : Int, v : Double) -> StatstestshapiroSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_slice_sum(s : StatstestshapiroSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_shapiro_slice_mean(s : StatstestshapiroSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_shapiro_slice_scale(s : StatstestshapiroSlice, f : Double) -> StatstestshapiroSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_slice_add(a : StatstestshapiroSlice, b : StatstestshapiroSlice) -> StatstestshapiroSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_shapiro_slice_copy(s : StatstestshapiroSlice) -> StatstestshapiroSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_slice_fill(s : StatstestshapiroSlice, v : Double) -> StatstestshapiroSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_shapiro_slice_min(s : StatstestshapiroSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_shapiro_slice_max(s : StatstestshapiroSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_shapiro_slice_to_string(s : StatstestshapiroSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

