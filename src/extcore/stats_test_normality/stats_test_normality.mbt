///===
/// extcore/stats_test_normality

pub(all) struct StatstestnormalityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_normality_make_point(x : Double, y : Double) -> StatstestnormalityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_normality_make_point3(x : Double, y : Double, z : Double) -> StatstestnormalityPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestnormalityPoint::x(self : StatstestnormalityPoint) -> Double { self.x }

pub fn StatstestnormalityPoint::y(self : StatstestnormalityPoint) -> Double { self.y }

pub fn StatstestnormalityPoint::z(self : StatstestnormalityPoint) -> Double { self.z }

pub fn StatstestnormalityPoint::label(self : StatstestnormalityPoint) -> Int { self.label }

pub fn StatstestnormalityPoint::dist(self : StatstestnormalityPoint, other : StatstestnormalityPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestnormalityPoint::add(self : StatstestnormalityPoint, other : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestnormalityPoint::sub(self : StatstestnormalityPoint, other : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestnormalityPoint::scale(self : StatstestnormalityPoint, s : Double) -> StatstestnormalityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestnormalityPoint::dot(self : StatstestnormalityPoint, other : StatstestnormalityPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestnormalityPoint::cross(self : StatstestnormalityPoint, other : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestnormalityPoint::norm(self : StatstestnormalityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestnormalityPoint::normalize(self : StatstestnormalityPoint) -> StatstestnormalityPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestnormalityPoint::negate(self : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestnormalityPoint::mid(self : StatstestnormalityPoint, other : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestnormalityPoint::lerp(self : StatstestnormalityPoint, other : StatstestnormalityPoint, t : Double) -> StatstestnormalityPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestnormalityPoint::to_string(self : StatstestnormalityPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestnormalitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_normality_make_series(vals : Array[Double], name : String) -> StatstestnormalitySeries {
  { vals, name, meta: 0 }
}

pub fn StatstestnormalitySeries::len(self : StatstestnormalitySeries) -> Int { self.vals.length() }

pub fn StatstestnormalitySeries::sum(self : StatstestnormalitySeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestnormalitySeries::mean(self : StatstestnormalitySeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestnormalitySeries::min(self : StatstestnormalitySeries) -> Double { @_common.min(self.vals) }

pub fn StatstestnormalitySeries::max(self : StatstestnormalitySeries) -> Double { @_common.max(self.vals) }

pub fn StatstestnormalitySeries::range(self : StatstestnormalitySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestnormalitySeries::variance(self : StatstestnormalitySeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestnormalitySeries::std(self : StatstestnormalitySeries) -> Double { @_common.std(self.vals) }

pub fn StatstestnormalitySeries::median(self : StatstestnormalitySeries) -> Double { @_common.median(self.vals) }

pub fn StatstestnormalitySeries::scale(self : StatstestnormalitySeries, f : Double) -> StatstestnormalitySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestnormalitySeries::add(self : StatstestnormalitySeries, other : StatstestnormalitySeries) -> StatstestnormalitySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestnormalitySeries::sub(self : StatstestnormalitySeries, other : StatstestnormalitySeries) -> StatstestnormalitySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestnormalitySeries::normalize(self : StatstestnormalitySeries) -> StatstestnormalitySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestnormalitySeries::cumsum(self : StatstestnormalitySeries) -> StatstestnormalitySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestnormalitySeries::to_string(self : StatstestnormalitySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestnormalityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_normality_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestnormalityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_normality_matrix_identity(n : Int) -> StatstestnormalityMatrix {
  let m = stats_test_normality_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestnormalityMatrix::get(self : StatstestnormalityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestnormalityMatrix::transpose(self : StatstestnormalityMatrix) -> StatstestnormalityMatrix {
  let result = stats_test_normality_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestnormalityMatrix::add(self : StatstestnormalityMatrix, other : StatstestnormalityMatrix) -> StatstestnormalityMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_normality_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestnormalityMatrix::scale(self : StatstestnormalityMatrix, s : Double) -> StatstestnormalityMatrix {
  let result = stats_test_normality_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestnormalityMatrix::multiply(self : StatstestnormalityMatrix, other : StatstestnormalityMatrix) -> StatstestnormalityMatrix {
  if self.cols != other.rows { return stats_test_normality_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_normality_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatstestnormalityMatrix::trace(self : StatstestnormalityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestnormalityMatrix::det(self : StatstestnormalityMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestnormalityMatrix::norm(self : StatstestnormalityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestnormalityMatrix::to_string(self : StatstestnormalityMatrix) -> String {
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

pub(all) struct StatstestnormalityVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_normality_make_vector(comps : Array[Double]) -> StatstestnormalityVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_normality_vector_zero(dim : Int) -> StatstestnormalityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestnormalityVector::add(self : StatstestnormalityVector, other : StatstestnormalityVector) -> StatstestnormalityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestnormalityVector::sub(self : StatstestnormalityVector, other : StatstestnormalityVector) -> StatstestnormalityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestnormalityVector::scale(self : StatstestnormalityVector, s : Double) -> StatstestnormalityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestnormalityVector::dot(self : StatstestnormalityVector, other : StatstestnormalityVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestnormalityVector::norm(self : StatstestnormalityVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestnormalityVector::normalize(self : StatstestnormalityVector) -> StatstestnormalityVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestnormalityVector::dist(self : StatstestnormalityVector, other : StatstestnormalityVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestnormalityVector::to_string(self : StatstestnormalityVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_normality_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_normality_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_normality_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_normality_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_normality_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_normality_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_normality_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_normality_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_normality_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_normality_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_normality_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_normality_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_normality_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_normality_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_normality_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_normality_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_normality_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_normality_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_normality_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_normality_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_normality_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_normality_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_normality_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_normality_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_normality_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_normality_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_normality_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_normality_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_normality_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestnormalityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_frame_make(size : Int) -> StatstestnormalityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_frame_len(s : StatstestnormalityFrame) -> Int { s.size }

pub fn stats_test_normality_frame_get(s : StatstestnormalityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_frame_set(s : StatstestnormalityFrame, i : Int, v : Double) -> StatstestnormalityFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_frame_sum(s : StatstestnormalityFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_frame_mean(s : StatstestnormalityFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_frame_scale(s : StatstestnormalityFrame, f : Double) -> StatstestnormalityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_frame_add(a : StatstestnormalityFrame, b : StatstestnormalityFrame) -> StatstestnormalityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_frame_copy(s : StatstestnormalityFrame) -> StatstestnormalityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_frame_fill(s : StatstestnormalityFrame, v : Double) -> StatstestnormalityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_frame_min(s : StatstestnormalityFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_frame_max(s : StatstestnormalityFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_frame_to_string(s : StatstestnormalityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_table_make(size : Int) -> StatstestnormalityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_table_len(s : StatstestnormalityTable) -> Int { s.size }

pub fn stats_test_normality_table_get(s : StatstestnormalityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_table_set(s : StatstestnormalityTable, i : Int, v : Double) -> StatstestnormalityTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_table_sum(s : StatstestnormalityTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_table_mean(s : StatstestnormalityTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_table_scale(s : StatstestnormalityTable, f : Double) -> StatstestnormalityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_table_add(a : StatstestnormalityTable, b : StatstestnormalityTable) -> StatstestnormalityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_table_copy(s : StatstestnormalityTable) -> StatstestnormalityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_table_fill(s : StatstestnormalityTable, v : Double) -> StatstestnormalityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_table_min(s : StatstestnormalityTable) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_table_max(s : StatstestnormalityTable) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_table_to_string(s : StatstestnormalityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_graphn_make(size : Int) -> StatstestnormalityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_graphn_len(s : StatstestnormalityGraphN) -> Int { s.size }

pub fn stats_test_normality_graphn_get(s : StatstestnormalityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_graphn_set(s : StatstestnormalityGraphN, i : Int, v : Double) -> StatstestnormalityGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_graphn_sum(s : StatstestnormalityGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_graphn_mean(s : StatstestnormalityGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_graphn_scale(s : StatstestnormalityGraphN, f : Double) -> StatstestnormalityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_graphn_add(a : StatstestnormalityGraphN, b : StatstestnormalityGraphN) -> StatstestnormalityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_graphn_copy(s : StatstestnormalityGraphN) -> StatstestnormalityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_graphn_fill(s : StatstestnormalityGraphN, v : Double) -> StatstestnormalityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_graphn_min(s : StatstestnormalityGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_graphn_max(s : StatstestnormalityGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_graphn_to_string(s : StatstestnormalityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_node_make(size : Int) -> StatstestnormalityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_node_len(s : StatstestnormalityNode) -> Int { s.size }

pub fn stats_test_normality_node_get(s : StatstestnormalityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_node_set(s : StatstestnormalityNode, i : Int, v : Double) -> StatstestnormalityNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_node_sum(s : StatstestnormalityNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_node_mean(s : StatstestnormalityNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_node_scale(s : StatstestnormalityNode, f : Double) -> StatstestnormalityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_node_add(a : StatstestnormalityNode, b : StatstestnormalityNode) -> StatstestnormalityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_node_copy(s : StatstestnormalityNode) -> StatstestnormalityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_node_fill(s : StatstestnormalityNode, v : Double) -> StatstestnormalityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_node_min(s : StatstestnormalityNode) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_node_max(s : StatstestnormalityNode) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_node_to_string(s : StatstestnormalityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_edge_make(size : Int) -> StatstestnormalityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_edge_len(s : StatstestnormalityEdge) -> Int { s.size }

pub fn stats_test_normality_edge_get(s : StatstestnormalityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_edge_set(s : StatstestnormalityEdge, i : Int, v : Double) -> StatstestnormalityEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_edge_sum(s : StatstestnormalityEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_edge_mean(s : StatstestnormalityEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_edge_scale(s : StatstestnormalityEdge, f : Double) -> StatstestnormalityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_edge_add(a : StatstestnormalityEdge, b : StatstestnormalityEdge) -> StatstestnormalityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_edge_copy(s : StatstestnormalityEdge) -> StatstestnormalityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_edge_fill(s : StatstestnormalityEdge, v : Double) -> StatstestnormalityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_edge_min(s : StatstestnormalityEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_edge_max(s : StatstestnormalityEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_edge_to_string(s : StatstestnormalityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_path_make(size : Int) -> StatstestnormalityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_path_len(s : StatstestnormalityPath) -> Int { s.size }

pub fn stats_test_normality_path_get(s : StatstestnormalityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_path_set(s : StatstestnormalityPath, i : Int, v : Double) -> StatstestnormalityPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_path_sum(s : StatstestnormalityPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_path_mean(s : StatstestnormalityPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_path_scale(s : StatstestnormalityPath, f : Double) -> StatstestnormalityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_path_add(a : StatstestnormalityPath, b : StatstestnormalityPath) -> StatstestnormalityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_path_copy(s : StatstestnormalityPath) -> StatstestnormalityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_path_fill(s : StatstestnormalityPath, v : Double) -> StatstestnormalityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_path_min(s : StatstestnormalityPath) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_path_max(s : StatstestnormalityPath) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_path_to_string(s : StatstestnormalityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_cluster_make(size : Int) -> StatstestnormalityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_cluster_len(s : StatstestnormalityCluster) -> Int { s.size }

pub fn stats_test_normality_cluster_get(s : StatstestnormalityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_cluster_set(s : StatstestnormalityCluster, i : Int, v : Double) -> StatstestnormalityCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cluster_sum(s : StatstestnormalityCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_cluster_mean(s : StatstestnormalityCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_cluster_scale(s : StatstestnormalityCluster, f : Double) -> StatstestnormalityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cluster_add(a : StatstestnormalityCluster, b : StatstestnormalityCluster) -> StatstestnormalityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_cluster_copy(s : StatstestnormalityCluster) -> StatstestnormalityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cluster_fill(s : StatstestnormalityCluster, v : Double) -> StatstestnormalityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cluster_min(s : StatstestnormalityCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_cluster_max(s : StatstestnormalityCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_cluster_to_string(s : StatstestnormalityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_model_make(size : Int) -> StatstestnormalityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_model_len(s : StatstestnormalityModel) -> Int { s.size }

pub fn stats_test_normality_model_get(s : StatstestnormalityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_model_set(s : StatstestnormalityModel, i : Int, v : Double) -> StatstestnormalityModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_model_sum(s : StatstestnormalityModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_model_mean(s : StatstestnormalityModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_model_scale(s : StatstestnormalityModel, f : Double) -> StatstestnormalityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_model_add(a : StatstestnormalityModel, b : StatstestnormalityModel) -> StatstestnormalityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_model_copy(s : StatstestnormalityModel) -> StatstestnormalityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_model_fill(s : StatstestnormalityModel, v : Double) -> StatstestnormalityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_model_min(s : StatstestnormalityModel) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_model_max(s : StatstestnormalityModel) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_model_to_string(s : StatstestnormalityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_layer_make(size : Int) -> StatstestnormalityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_layer_len(s : StatstestnormalityLayer) -> Int { s.size }

pub fn stats_test_normality_layer_get(s : StatstestnormalityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_layer_set(s : StatstestnormalityLayer, i : Int, v : Double) -> StatstestnormalityLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_layer_sum(s : StatstestnormalityLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_layer_mean(s : StatstestnormalityLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_layer_scale(s : StatstestnormalityLayer, f : Double) -> StatstestnormalityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_layer_add(a : StatstestnormalityLayer, b : StatstestnormalityLayer) -> StatstestnormalityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_layer_copy(s : StatstestnormalityLayer) -> StatstestnormalityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_layer_fill(s : StatstestnormalityLayer, v : Double) -> StatstestnormalityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_layer_min(s : StatstestnormalityLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_layer_max(s : StatstestnormalityLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_layer_to_string(s : StatstestnormalityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_buffer_make(size : Int) -> StatstestnormalityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_buffer_len(s : StatstestnormalityBuffer) -> Int { s.size }

pub fn stats_test_normality_buffer_get(s : StatstestnormalityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_buffer_set(s : StatstestnormalityBuffer, i : Int, v : Double) -> StatstestnormalityBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_buffer_sum(s : StatstestnormalityBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_buffer_mean(s : StatstestnormalityBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_buffer_scale(s : StatstestnormalityBuffer, f : Double) -> StatstestnormalityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_buffer_add(a : StatstestnormalityBuffer, b : StatstestnormalityBuffer) -> StatstestnormalityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_buffer_copy(s : StatstestnormalityBuffer) -> StatstestnormalityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_buffer_fill(s : StatstestnormalityBuffer, v : Double) -> StatstestnormalityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_buffer_min(s : StatstestnormalityBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_buffer_max(s : StatstestnormalityBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_buffer_to_string(s : StatstestnormalityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_cursor_make(size : Int) -> StatstestnormalityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_cursor_len(s : StatstestnormalityCursor) -> Int { s.size }

pub fn stats_test_normality_cursor_get(s : StatstestnormalityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_cursor_set(s : StatstestnormalityCursor, i : Int, v : Double) -> StatstestnormalityCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cursor_sum(s : StatstestnormalityCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_cursor_mean(s : StatstestnormalityCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_cursor_scale(s : StatstestnormalityCursor, f : Double) -> StatstestnormalityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cursor_add(a : StatstestnormalityCursor, b : StatstestnormalityCursor) -> StatstestnormalityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_cursor_copy(s : StatstestnormalityCursor) -> StatstestnormalityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cursor_fill(s : StatstestnormalityCursor, v : Double) -> StatstestnormalityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cursor_min(s : StatstestnormalityCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_cursor_max(s : StatstestnormalityCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_cursor_to_string(s : StatstestnormalityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_view_make(size : Int) -> StatstestnormalityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_view_len(s : StatstestnormalityView) -> Int { s.size }

pub fn stats_test_normality_view_get(s : StatstestnormalityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_view_set(s : StatstestnormalityView, i : Int, v : Double) -> StatstestnormalityView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_view_sum(s : StatstestnormalityView) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_view_mean(s : StatstestnormalityView) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_view_scale(s : StatstestnormalityView, f : Double) -> StatstestnormalityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_view_add(a : StatstestnormalityView, b : StatstestnormalityView) -> StatstestnormalityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_view_copy(s : StatstestnormalityView) -> StatstestnormalityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_view_fill(s : StatstestnormalityView, v : Double) -> StatstestnormalityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_view_min(s : StatstestnormalityView) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_view_max(s : StatstestnormalityView) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_view_to_string(s : StatstestnormalityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_range_make(size : Int) -> StatstestnormalityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_range_len(s : StatstestnormalityRange) -> Int { s.size }

pub fn stats_test_normality_range_get(s : StatstestnormalityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_range_set(s : StatstestnormalityRange, i : Int, v : Double) -> StatstestnormalityRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_range_sum(s : StatstestnormalityRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_range_mean(s : StatstestnormalityRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_range_scale(s : StatstestnormalityRange, f : Double) -> StatstestnormalityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_range_add(a : StatstestnormalityRange, b : StatstestnormalityRange) -> StatstestnormalityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_range_copy(s : StatstestnormalityRange) -> StatstestnormalityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_range_fill(s : StatstestnormalityRange, v : Double) -> StatstestnormalityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_range_min(s : StatstestnormalityRange) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_range_max(s : StatstestnormalityRange) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_range_to_string(s : StatstestnormalityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_slice_make(size : Int) -> StatstestnormalitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_slice_len(s : StatstestnormalitySlice) -> Int { s.size }

pub fn stats_test_normality_slice_get(s : StatstestnormalitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_slice_set(s : StatstestnormalitySlice, i : Int, v : Double) -> StatstestnormalitySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_slice_sum(s : StatstestnormalitySlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_slice_mean(s : StatstestnormalitySlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_slice_scale(s : StatstestnormalitySlice, f : Double) -> StatstestnormalitySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_slice_add(a : StatstestnormalitySlice, b : StatstestnormalitySlice) -> StatstestnormalitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_slice_copy(s : StatstestnormalitySlice) -> StatstestnormalitySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_slice_fill(s : StatstestnormalitySlice, v : Double) -> StatstestnormalitySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_slice_min(s : StatstestnormalitySlice) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_slice_max(s : StatstestnormalitySlice) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_slice_to_string(s : StatstestnormalitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

