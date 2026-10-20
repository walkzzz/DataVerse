///===
/// extcore/stats_test_homogeneity

pub(all) struct StatstesthomogeneityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_homogeneity_make_point(x : Double, y : Double) -> StatstesthomogeneityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_homogeneity_make_point3(x : Double, y : Double, z : Double) -> StatstesthomogeneityPoint {
  { x, y, z, label: 0 }
}

pub fn StatstesthomogeneityPoint::x(self : StatstesthomogeneityPoint) -> Double { self.x }

pub fn StatstesthomogeneityPoint::y(self : StatstesthomogeneityPoint) -> Double { self.y }

pub fn StatstesthomogeneityPoint::z(self : StatstesthomogeneityPoint) -> Double { self.z }

pub fn StatstesthomogeneityPoint::label(self : StatstesthomogeneityPoint) -> Int { self.label }

pub fn StatstesthomogeneityPoint::dist(self : StatstesthomogeneityPoint, other : StatstesthomogeneityPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstesthomogeneityPoint::add(self : StatstesthomogeneityPoint, other : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstesthomogeneityPoint::sub(self : StatstesthomogeneityPoint, other : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstesthomogeneityPoint::scale(self : StatstesthomogeneityPoint, s : Double) -> StatstesthomogeneityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstesthomogeneityPoint::dot(self : StatstesthomogeneityPoint, other : StatstesthomogeneityPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstesthomogeneityPoint::cross(self : StatstesthomogeneityPoint, other : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstesthomogeneityPoint::norm(self : StatstesthomogeneityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstesthomogeneityPoint::normalize(self : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstesthomogeneityPoint::negate(self : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstesthomogeneityPoint::mid(self : StatstesthomogeneityPoint, other : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstesthomogeneityPoint::lerp(self : StatstesthomogeneityPoint, other : StatstesthomogeneityPoint, t : Double) -> StatstesthomogeneityPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstesthomogeneityPoint::to_string(self : StatstesthomogeneityPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstesthomogeneitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_homogeneity_make_series(vals : Array[Double], name : String) -> StatstesthomogeneitySeries {
  { vals, name, meta: 0 }
}

pub fn StatstesthomogeneitySeries::len(self : StatstesthomogeneitySeries) -> Int { self.vals.length() }

pub fn StatstesthomogeneitySeries::sum(self : StatstesthomogeneitySeries) -> Double { @_common.sum(self.vals) }

pub fn StatstesthomogeneitySeries::mean(self : StatstesthomogeneitySeries) -> Double { @_common.mean(self.vals) }

pub fn StatstesthomogeneitySeries::min(self : StatstesthomogeneitySeries) -> Double { @_common.min(self.vals) }

pub fn StatstesthomogeneitySeries::max(self : StatstesthomogeneitySeries) -> Double { @_common.max(self.vals) }

pub fn StatstesthomogeneitySeries::range(self : StatstesthomogeneitySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstesthomogeneitySeries::variance(self : StatstesthomogeneitySeries) -> Double { @_common.variance(self.vals) }

pub fn StatstesthomogeneitySeries::std(self : StatstesthomogeneitySeries) -> Double { @_common.std(self.vals) }

pub fn StatstesthomogeneitySeries::median(self : StatstesthomogeneitySeries) -> Double { @_common.median(self.vals) }

pub fn StatstesthomogeneitySeries::scale(self : StatstesthomogeneitySeries, f : Double) -> StatstesthomogeneitySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstesthomogeneitySeries::add(self : StatstesthomogeneitySeries, other : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstesthomogeneitySeries::sub(self : StatstesthomogeneitySeries, other : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstesthomogeneitySeries::normalize(self : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstesthomogeneitySeries::cumsum(self : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstesthomogeneitySeries::to_string(self : StatstesthomogeneitySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstesthomogeneityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_homogeneity_make_matrix(rows : Int, cols : Int, val : Double) -> StatstesthomogeneityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_homogeneity_matrix_identity(n : Int) -> StatstesthomogeneityMatrix {
  let m = stats_test_homogeneity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstesthomogeneityMatrix::get(self : StatstesthomogeneityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstesthomogeneityMatrix::transpose(self : StatstesthomogeneityMatrix) -> StatstesthomogeneityMatrix {
  let result = stats_test_homogeneity_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstesthomogeneityMatrix::add(self : StatstesthomogeneityMatrix, other : StatstesthomogeneityMatrix) -> StatstesthomogeneityMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_homogeneity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstesthomogeneityMatrix::scale(self : StatstesthomogeneityMatrix, s : Double) -> StatstesthomogeneityMatrix {
  let result = stats_test_homogeneity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstesthomogeneityMatrix::multiply(self : StatstesthomogeneityMatrix, other : StatstesthomogeneityMatrix) -> StatstesthomogeneityMatrix {
  if self.cols != other.rows { return stats_test_homogeneity_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_homogeneity_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatstesthomogeneityMatrix::trace(self : StatstesthomogeneityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstesthomogeneityMatrix::det(self : StatstesthomogeneityMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstesthomogeneityMatrix::norm(self : StatstesthomogeneityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstesthomogeneityMatrix::to_string(self : StatstesthomogeneityMatrix) -> String {
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

pub(all) struct StatstesthomogeneityVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_homogeneity_make_vector(comps : Array[Double]) -> StatstesthomogeneityVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_homogeneity_vector_zero(dim : Int) -> StatstesthomogeneityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstesthomogeneityVector::add(self : StatstesthomogeneityVector, other : StatstesthomogeneityVector) -> StatstesthomogeneityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstesthomogeneityVector::sub(self : StatstesthomogeneityVector, other : StatstesthomogeneityVector) -> StatstesthomogeneityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstesthomogeneityVector::scale(self : StatstesthomogeneityVector, s : Double) -> StatstesthomogeneityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstesthomogeneityVector::dot(self : StatstesthomogeneityVector, other : StatstesthomogeneityVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstesthomogeneityVector::norm(self : StatstesthomogeneityVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstesthomogeneityVector::normalize(self : StatstesthomogeneityVector) -> StatstesthomogeneityVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstesthomogeneityVector::dist(self : StatstesthomogeneityVector, other : StatstesthomogeneityVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstesthomogeneityVector::to_string(self : StatstesthomogeneityVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_homogeneity_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_homogeneity_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_homogeneity_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_homogeneity_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_homogeneity_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_homogeneity_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_homogeneity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_homogeneity_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_homogeneity_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_homogeneity_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_homogeneity_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_homogeneity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_homogeneity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_homogeneity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_homogeneity_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_homogeneity_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_homogeneity_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_homogeneity_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_homogeneity_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_homogeneity_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_homogeneity_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_homogeneity_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_homogeneity_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_homogeneity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_homogeneity_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_homogeneity_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_homogeneity_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_homogeneity_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_homogeneity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstesthomogeneityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_frame_make(size : Int) -> StatstesthomogeneityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_frame_len(s : StatstesthomogeneityFrame) -> Int { s.size }

pub fn stats_test_homogeneity_frame_get(s : StatstesthomogeneityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_frame_set(s : StatstesthomogeneityFrame, i : Int, v : Double) -> StatstesthomogeneityFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_frame_sum(s : StatstesthomogeneityFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_frame_mean(s : StatstesthomogeneityFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_frame_scale(s : StatstesthomogeneityFrame, f : Double) -> StatstesthomogeneityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_frame_add(a : StatstesthomogeneityFrame, b : StatstesthomogeneityFrame) -> StatstesthomogeneityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_frame_copy(s : StatstesthomogeneityFrame) -> StatstesthomogeneityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_frame_fill(s : StatstesthomogeneityFrame, v : Double) -> StatstesthomogeneityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_frame_min(s : StatstesthomogeneityFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_frame_max(s : StatstesthomogeneityFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_frame_to_string(s : StatstesthomogeneityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_table_make(size : Int) -> StatstesthomogeneityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_table_len(s : StatstesthomogeneityTable) -> Int { s.size }

pub fn stats_test_homogeneity_table_get(s : StatstesthomogeneityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_table_set(s : StatstesthomogeneityTable, i : Int, v : Double) -> StatstesthomogeneityTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_table_sum(s : StatstesthomogeneityTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_table_mean(s : StatstesthomogeneityTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_table_scale(s : StatstesthomogeneityTable, f : Double) -> StatstesthomogeneityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_table_add(a : StatstesthomogeneityTable, b : StatstesthomogeneityTable) -> StatstesthomogeneityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_table_copy(s : StatstesthomogeneityTable) -> StatstesthomogeneityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_table_fill(s : StatstesthomogeneityTable, v : Double) -> StatstesthomogeneityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_table_min(s : StatstesthomogeneityTable) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_table_max(s : StatstesthomogeneityTable) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_table_to_string(s : StatstesthomogeneityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_graphn_make(size : Int) -> StatstesthomogeneityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_graphn_len(s : StatstesthomogeneityGraphN) -> Int { s.size }

pub fn stats_test_homogeneity_graphn_get(s : StatstesthomogeneityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_graphn_set(s : StatstesthomogeneityGraphN, i : Int, v : Double) -> StatstesthomogeneityGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_graphn_sum(s : StatstesthomogeneityGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_graphn_mean(s : StatstesthomogeneityGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_graphn_scale(s : StatstesthomogeneityGraphN, f : Double) -> StatstesthomogeneityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_graphn_add(a : StatstesthomogeneityGraphN, b : StatstesthomogeneityGraphN) -> StatstesthomogeneityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_graphn_copy(s : StatstesthomogeneityGraphN) -> StatstesthomogeneityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_graphn_fill(s : StatstesthomogeneityGraphN, v : Double) -> StatstesthomogeneityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_graphn_min(s : StatstesthomogeneityGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_graphn_max(s : StatstesthomogeneityGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_graphn_to_string(s : StatstesthomogeneityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_node_make(size : Int) -> StatstesthomogeneityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_node_len(s : StatstesthomogeneityNode) -> Int { s.size }

pub fn stats_test_homogeneity_node_get(s : StatstesthomogeneityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_node_set(s : StatstesthomogeneityNode, i : Int, v : Double) -> StatstesthomogeneityNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_node_sum(s : StatstesthomogeneityNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_node_mean(s : StatstesthomogeneityNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_node_scale(s : StatstesthomogeneityNode, f : Double) -> StatstesthomogeneityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_node_add(a : StatstesthomogeneityNode, b : StatstesthomogeneityNode) -> StatstesthomogeneityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_node_copy(s : StatstesthomogeneityNode) -> StatstesthomogeneityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_node_fill(s : StatstesthomogeneityNode, v : Double) -> StatstesthomogeneityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_node_min(s : StatstesthomogeneityNode) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_node_max(s : StatstesthomogeneityNode) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_node_to_string(s : StatstesthomogeneityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_edge_make(size : Int) -> StatstesthomogeneityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_edge_len(s : StatstesthomogeneityEdge) -> Int { s.size }

pub fn stats_test_homogeneity_edge_get(s : StatstesthomogeneityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_edge_set(s : StatstesthomogeneityEdge, i : Int, v : Double) -> StatstesthomogeneityEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_edge_sum(s : StatstesthomogeneityEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_edge_mean(s : StatstesthomogeneityEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_edge_scale(s : StatstesthomogeneityEdge, f : Double) -> StatstesthomogeneityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_edge_add(a : StatstesthomogeneityEdge, b : StatstesthomogeneityEdge) -> StatstesthomogeneityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_edge_copy(s : StatstesthomogeneityEdge) -> StatstesthomogeneityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_edge_fill(s : StatstesthomogeneityEdge, v : Double) -> StatstesthomogeneityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_edge_min(s : StatstesthomogeneityEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_edge_max(s : StatstesthomogeneityEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_edge_to_string(s : StatstesthomogeneityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_path_make(size : Int) -> StatstesthomogeneityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_path_len(s : StatstesthomogeneityPath) -> Int { s.size }

pub fn stats_test_homogeneity_path_get(s : StatstesthomogeneityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_path_set(s : StatstesthomogeneityPath, i : Int, v : Double) -> StatstesthomogeneityPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_path_sum(s : StatstesthomogeneityPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_path_mean(s : StatstesthomogeneityPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_path_scale(s : StatstesthomogeneityPath, f : Double) -> StatstesthomogeneityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_path_add(a : StatstesthomogeneityPath, b : StatstesthomogeneityPath) -> StatstesthomogeneityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_path_copy(s : StatstesthomogeneityPath) -> StatstesthomogeneityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_path_fill(s : StatstesthomogeneityPath, v : Double) -> StatstesthomogeneityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_path_min(s : StatstesthomogeneityPath) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_path_max(s : StatstesthomogeneityPath) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_path_to_string(s : StatstesthomogeneityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_cluster_make(size : Int) -> StatstesthomogeneityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_cluster_len(s : StatstesthomogeneityCluster) -> Int { s.size }

pub fn stats_test_homogeneity_cluster_get(s : StatstesthomogeneityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_cluster_set(s : StatstesthomogeneityCluster, i : Int, v : Double) -> StatstesthomogeneityCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cluster_sum(s : StatstesthomogeneityCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_cluster_mean(s : StatstesthomogeneityCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_cluster_scale(s : StatstesthomogeneityCluster, f : Double) -> StatstesthomogeneityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cluster_add(a : StatstesthomogeneityCluster, b : StatstesthomogeneityCluster) -> StatstesthomogeneityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_cluster_copy(s : StatstesthomogeneityCluster) -> StatstesthomogeneityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cluster_fill(s : StatstesthomogeneityCluster, v : Double) -> StatstesthomogeneityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cluster_min(s : StatstesthomogeneityCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_cluster_max(s : StatstesthomogeneityCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_cluster_to_string(s : StatstesthomogeneityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_model_make(size : Int) -> StatstesthomogeneityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_model_len(s : StatstesthomogeneityModel) -> Int { s.size }

pub fn stats_test_homogeneity_model_get(s : StatstesthomogeneityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_model_set(s : StatstesthomogeneityModel, i : Int, v : Double) -> StatstesthomogeneityModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_model_sum(s : StatstesthomogeneityModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_model_mean(s : StatstesthomogeneityModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_model_scale(s : StatstesthomogeneityModel, f : Double) -> StatstesthomogeneityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_model_add(a : StatstesthomogeneityModel, b : StatstesthomogeneityModel) -> StatstesthomogeneityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_model_copy(s : StatstesthomogeneityModel) -> StatstesthomogeneityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_model_fill(s : StatstesthomogeneityModel, v : Double) -> StatstesthomogeneityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_model_min(s : StatstesthomogeneityModel) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_model_max(s : StatstesthomogeneityModel) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_model_to_string(s : StatstesthomogeneityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_layer_make(size : Int) -> StatstesthomogeneityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_layer_len(s : StatstesthomogeneityLayer) -> Int { s.size }

pub fn stats_test_homogeneity_layer_get(s : StatstesthomogeneityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_layer_set(s : StatstesthomogeneityLayer, i : Int, v : Double) -> StatstesthomogeneityLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_layer_sum(s : StatstesthomogeneityLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_layer_mean(s : StatstesthomogeneityLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_layer_scale(s : StatstesthomogeneityLayer, f : Double) -> StatstesthomogeneityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_layer_add(a : StatstesthomogeneityLayer, b : StatstesthomogeneityLayer) -> StatstesthomogeneityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_layer_copy(s : StatstesthomogeneityLayer) -> StatstesthomogeneityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_layer_fill(s : StatstesthomogeneityLayer, v : Double) -> StatstesthomogeneityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_layer_min(s : StatstesthomogeneityLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_layer_max(s : StatstesthomogeneityLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_layer_to_string(s : StatstesthomogeneityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_buffer_make(size : Int) -> StatstesthomogeneityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_buffer_len(s : StatstesthomogeneityBuffer) -> Int { s.size }

pub fn stats_test_homogeneity_buffer_get(s : StatstesthomogeneityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_buffer_set(s : StatstesthomogeneityBuffer, i : Int, v : Double) -> StatstesthomogeneityBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_buffer_sum(s : StatstesthomogeneityBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_buffer_mean(s : StatstesthomogeneityBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_buffer_scale(s : StatstesthomogeneityBuffer, f : Double) -> StatstesthomogeneityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_buffer_add(a : StatstesthomogeneityBuffer, b : StatstesthomogeneityBuffer) -> StatstesthomogeneityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_buffer_copy(s : StatstesthomogeneityBuffer) -> StatstesthomogeneityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_buffer_fill(s : StatstesthomogeneityBuffer, v : Double) -> StatstesthomogeneityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_buffer_min(s : StatstesthomogeneityBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_buffer_max(s : StatstesthomogeneityBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_buffer_to_string(s : StatstesthomogeneityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_cursor_make(size : Int) -> StatstesthomogeneityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_cursor_len(s : StatstesthomogeneityCursor) -> Int { s.size }

pub fn stats_test_homogeneity_cursor_get(s : StatstesthomogeneityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_cursor_set(s : StatstesthomogeneityCursor, i : Int, v : Double) -> StatstesthomogeneityCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cursor_sum(s : StatstesthomogeneityCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_cursor_mean(s : StatstesthomogeneityCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_cursor_scale(s : StatstesthomogeneityCursor, f : Double) -> StatstesthomogeneityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cursor_add(a : StatstesthomogeneityCursor, b : StatstesthomogeneityCursor) -> StatstesthomogeneityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_cursor_copy(s : StatstesthomogeneityCursor) -> StatstesthomogeneityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cursor_fill(s : StatstesthomogeneityCursor, v : Double) -> StatstesthomogeneityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cursor_min(s : StatstesthomogeneityCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_cursor_max(s : StatstesthomogeneityCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_cursor_to_string(s : StatstesthomogeneityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_view_make(size : Int) -> StatstesthomogeneityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_view_len(s : StatstesthomogeneityView) -> Int { s.size }

pub fn stats_test_homogeneity_view_get(s : StatstesthomogeneityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_view_set(s : StatstesthomogeneityView, i : Int, v : Double) -> StatstesthomogeneityView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_view_sum(s : StatstesthomogeneityView) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_view_mean(s : StatstesthomogeneityView) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_view_scale(s : StatstesthomogeneityView, f : Double) -> StatstesthomogeneityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_view_add(a : StatstesthomogeneityView, b : StatstesthomogeneityView) -> StatstesthomogeneityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_view_copy(s : StatstesthomogeneityView) -> StatstesthomogeneityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_view_fill(s : StatstesthomogeneityView, v : Double) -> StatstesthomogeneityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_view_min(s : StatstesthomogeneityView) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_view_max(s : StatstesthomogeneityView) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_view_to_string(s : StatstesthomogeneityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_range_make(size : Int) -> StatstesthomogeneityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_range_len(s : StatstesthomogeneityRange) -> Int { s.size }

pub fn stats_test_homogeneity_range_get(s : StatstesthomogeneityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_range_set(s : StatstesthomogeneityRange, i : Int, v : Double) -> StatstesthomogeneityRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_range_sum(s : StatstesthomogeneityRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_range_mean(s : StatstesthomogeneityRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_range_scale(s : StatstesthomogeneityRange, f : Double) -> StatstesthomogeneityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_range_add(a : StatstesthomogeneityRange, b : StatstesthomogeneityRange) -> StatstesthomogeneityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_range_copy(s : StatstesthomogeneityRange) -> StatstesthomogeneityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_range_fill(s : StatstesthomogeneityRange, v : Double) -> StatstesthomogeneityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_range_min(s : StatstesthomogeneityRange) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_range_max(s : StatstesthomogeneityRange) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_range_to_string(s : StatstesthomogeneityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_slice_make(size : Int) -> StatstesthomogeneitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_slice_len(s : StatstesthomogeneitySlice) -> Int { s.size }

pub fn stats_test_homogeneity_slice_get(s : StatstesthomogeneitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_slice_set(s : StatstesthomogeneitySlice, i : Int, v : Double) -> StatstesthomogeneitySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_slice_sum(s : StatstesthomogeneitySlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_slice_mean(s : StatstesthomogeneitySlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_slice_scale(s : StatstesthomogeneitySlice, f : Double) -> StatstesthomogeneitySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_slice_add(a : StatstesthomogeneitySlice, b : StatstesthomogeneitySlice) -> StatstesthomogeneitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_slice_copy(s : StatstesthomogeneitySlice) -> StatstesthomogeneitySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_slice_fill(s : StatstesthomogeneitySlice, v : Double) -> StatstesthomogeneitySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_slice_min(s : StatstesthomogeneitySlice) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_slice_max(s : StatstesthomogeneitySlice) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_slice_to_string(s : StatstesthomogeneitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

