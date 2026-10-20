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

pub fn StatstestshapiroFrame::len(self : StatstestshapiroFrame) -> Int { self.size }

pub fn StatstestshapiroFrame::get(self : StatstestshapiroFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroFrame::set(self : StatstestshapiroFrame, i : Int, v : Double) -> StatstestshapiroFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroFrame::sum(self : StatstestshapiroFrame) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroFrame::mean(self : StatstestshapiroFrame) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroFrame::scale(self : StatstestshapiroFrame, f : Double) -> StatstestshapiroFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroFrame::add(self : StatstestshapiroFrame, other : StatstestshapiroFrame) -> StatstestshapiroFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroFrame::copy(self : StatstestshapiroFrame) -> StatstestshapiroFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroFrame::fill(self : StatstestshapiroFrame, v : Double) -> StatstestshapiroFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroFrame::min(self : StatstestshapiroFrame) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroFrame::max(self : StatstestshapiroFrame) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroFrame::to_string(self : StatstestshapiroFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_table_make(size : Int) -> StatstestshapiroTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroTable::len(self : StatstestshapiroTable) -> Int { self.size }

pub fn StatstestshapiroTable::get(self : StatstestshapiroTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroTable::set(self : StatstestshapiroTable, i : Int, v : Double) -> StatstestshapiroTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroTable::sum(self : StatstestshapiroTable) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroTable::mean(self : StatstestshapiroTable) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroTable::scale(self : StatstestshapiroTable, f : Double) -> StatstestshapiroTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroTable::add(self : StatstestshapiroTable, other : StatstestshapiroTable) -> StatstestshapiroTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroTable::copy(self : StatstestshapiroTable) -> StatstestshapiroTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroTable::fill(self : StatstestshapiroTable, v : Double) -> StatstestshapiroTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroTable::min(self : StatstestshapiroTable) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroTable::max(self : StatstestshapiroTable) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroTable::to_string(self : StatstestshapiroTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_graphn_make(size : Int) -> StatstestshapiroGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroGraphN::len(self : StatstestshapiroGraphN) -> Int { self.size }

pub fn StatstestshapiroGraphN::get(self : StatstestshapiroGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroGraphN::set(self : StatstestshapiroGraphN, i : Int, v : Double) -> StatstestshapiroGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroGraphN::sum(self : StatstestshapiroGraphN) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroGraphN::mean(self : StatstestshapiroGraphN) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroGraphN::scale(self : StatstestshapiroGraphN, f : Double) -> StatstestshapiroGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroGraphN::add(self : StatstestshapiroGraphN, other : StatstestshapiroGraphN) -> StatstestshapiroGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroGraphN::copy(self : StatstestshapiroGraphN) -> StatstestshapiroGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroGraphN::fill(self : StatstestshapiroGraphN, v : Double) -> StatstestshapiroGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroGraphN::min(self : StatstestshapiroGraphN) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroGraphN::max(self : StatstestshapiroGraphN) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroGraphN::to_string(self : StatstestshapiroGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_node_make(size : Int) -> StatstestshapiroNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroNode::len(self : StatstestshapiroNode) -> Int { self.size }

pub fn StatstestshapiroNode::get(self : StatstestshapiroNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroNode::set(self : StatstestshapiroNode, i : Int, v : Double) -> StatstestshapiroNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroNode::sum(self : StatstestshapiroNode) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroNode::mean(self : StatstestshapiroNode) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroNode::scale(self : StatstestshapiroNode, f : Double) -> StatstestshapiroNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroNode::add(self : StatstestshapiroNode, other : StatstestshapiroNode) -> StatstestshapiroNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroNode::copy(self : StatstestshapiroNode) -> StatstestshapiroNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroNode::fill(self : StatstestshapiroNode, v : Double) -> StatstestshapiroNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroNode::min(self : StatstestshapiroNode) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroNode::max(self : StatstestshapiroNode) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroNode::to_string(self : StatstestshapiroNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_edge_make(size : Int) -> StatstestshapiroEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroEdge::len(self : StatstestshapiroEdge) -> Int { self.size }

pub fn StatstestshapiroEdge::get(self : StatstestshapiroEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroEdge::set(self : StatstestshapiroEdge, i : Int, v : Double) -> StatstestshapiroEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroEdge::sum(self : StatstestshapiroEdge) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroEdge::mean(self : StatstestshapiroEdge) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroEdge::scale(self : StatstestshapiroEdge, f : Double) -> StatstestshapiroEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroEdge::add(self : StatstestshapiroEdge, other : StatstestshapiroEdge) -> StatstestshapiroEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroEdge::copy(self : StatstestshapiroEdge) -> StatstestshapiroEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroEdge::fill(self : StatstestshapiroEdge, v : Double) -> StatstestshapiroEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroEdge::min(self : StatstestshapiroEdge) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroEdge::max(self : StatstestshapiroEdge) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroEdge::to_string(self : StatstestshapiroEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_path_make(size : Int) -> StatstestshapiroPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroPath::len(self : StatstestshapiroPath) -> Int { self.size }

pub fn StatstestshapiroPath::get(self : StatstestshapiroPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroPath::set(self : StatstestshapiroPath, i : Int, v : Double) -> StatstestshapiroPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroPath::sum(self : StatstestshapiroPath) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroPath::mean(self : StatstestshapiroPath) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroPath::scale(self : StatstestshapiroPath, f : Double) -> StatstestshapiroPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroPath::add(self : StatstestshapiroPath, other : StatstestshapiroPath) -> StatstestshapiroPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroPath::copy(self : StatstestshapiroPath) -> StatstestshapiroPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroPath::fill(self : StatstestshapiroPath, v : Double) -> StatstestshapiroPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroPath::min(self : StatstestshapiroPath) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroPath::max(self : StatstestshapiroPath) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroPath::to_string(self : StatstestshapiroPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_cluster_make(size : Int) -> StatstestshapiroCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroCluster::len(self : StatstestshapiroCluster) -> Int { self.size }

pub fn StatstestshapiroCluster::get(self : StatstestshapiroCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroCluster::set(self : StatstestshapiroCluster, i : Int, v : Double) -> StatstestshapiroCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroCluster::sum(self : StatstestshapiroCluster) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroCluster::mean(self : StatstestshapiroCluster) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroCluster::scale(self : StatstestshapiroCluster, f : Double) -> StatstestshapiroCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroCluster::add(self : StatstestshapiroCluster, other : StatstestshapiroCluster) -> StatstestshapiroCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroCluster::copy(self : StatstestshapiroCluster) -> StatstestshapiroCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroCluster::fill(self : StatstestshapiroCluster, v : Double) -> StatstestshapiroCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroCluster::min(self : StatstestshapiroCluster) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroCluster::max(self : StatstestshapiroCluster) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroCluster::to_string(self : StatstestshapiroCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_model_make(size : Int) -> StatstestshapiroModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroModel::len(self : StatstestshapiroModel) -> Int { self.size }

pub fn StatstestshapiroModel::get(self : StatstestshapiroModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroModel::set(self : StatstestshapiroModel, i : Int, v : Double) -> StatstestshapiroModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroModel::sum(self : StatstestshapiroModel) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroModel::mean(self : StatstestshapiroModel) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroModel::scale(self : StatstestshapiroModel, f : Double) -> StatstestshapiroModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroModel::add(self : StatstestshapiroModel, other : StatstestshapiroModel) -> StatstestshapiroModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroModel::copy(self : StatstestshapiroModel) -> StatstestshapiroModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroModel::fill(self : StatstestshapiroModel, v : Double) -> StatstestshapiroModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroModel::min(self : StatstestshapiroModel) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroModel::max(self : StatstestshapiroModel) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroModel::to_string(self : StatstestshapiroModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_layer_make(size : Int) -> StatstestshapiroLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroLayer::len(self : StatstestshapiroLayer) -> Int { self.size }

pub fn StatstestshapiroLayer::get(self : StatstestshapiroLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroLayer::set(self : StatstestshapiroLayer, i : Int, v : Double) -> StatstestshapiroLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroLayer::sum(self : StatstestshapiroLayer) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroLayer::mean(self : StatstestshapiroLayer) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroLayer::scale(self : StatstestshapiroLayer, f : Double) -> StatstestshapiroLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroLayer::add(self : StatstestshapiroLayer, other : StatstestshapiroLayer) -> StatstestshapiroLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroLayer::copy(self : StatstestshapiroLayer) -> StatstestshapiroLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroLayer::fill(self : StatstestshapiroLayer, v : Double) -> StatstestshapiroLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroLayer::min(self : StatstestshapiroLayer) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroLayer::max(self : StatstestshapiroLayer) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroLayer::to_string(self : StatstestshapiroLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_buffer_make(size : Int) -> StatstestshapiroBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroBuffer::len(self : StatstestshapiroBuffer) -> Int { self.size }

pub fn StatstestshapiroBuffer::get(self : StatstestshapiroBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroBuffer::set(self : StatstestshapiroBuffer, i : Int, v : Double) -> StatstestshapiroBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroBuffer::sum(self : StatstestshapiroBuffer) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroBuffer::mean(self : StatstestshapiroBuffer) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroBuffer::scale(self : StatstestshapiroBuffer, f : Double) -> StatstestshapiroBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroBuffer::add(self : StatstestshapiroBuffer, other : StatstestshapiroBuffer) -> StatstestshapiroBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroBuffer::copy(self : StatstestshapiroBuffer) -> StatstestshapiroBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroBuffer::fill(self : StatstestshapiroBuffer, v : Double) -> StatstestshapiroBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroBuffer::min(self : StatstestshapiroBuffer) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroBuffer::max(self : StatstestshapiroBuffer) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroBuffer::to_string(self : StatstestshapiroBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_cursor_make(size : Int) -> StatstestshapiroCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroCursor::len(self : StatstestshapiroCursor) -> Int { self.size }

pub fn StatstestshapiroCursor::get(self : StatstestshapiroCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroCursor::set(self : StatstestshapiroCursor, i : Int, v : Double) -> StatstestshapiroCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroCursor::sum(self : StatstestshapiroCursor) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroCursor::mean(self : StatstestshapiroCursor) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroCursor::scale(self : StatstestshapiroCursor, f : Double) -> StatstestshapiroCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroCursor::add(self : StatstestshapiroCursor, other : StatstestshapiroCursor) -> StatstestshapiroCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroCursor::copy(self : StatstestshapiroCursor) -> StatstestshapiroCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroCursor::fill(self : StatstestshapiroCursor, v : Double) -> StatstestshapiroCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroCursor::min(self : StatstestshapiroCursor) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroCursor::max(self : StatstestshapiroCursor) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroCursor::to_string(self : StatstestshapiroCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_view_make(size : Int) -> StatstestshapiroView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroView::len(self : StatstestshapiroView) -> Int { self.size }

pub fn StatstestshapiroView::get(self : StatstestshapiroView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroView::set(self : StatstestshapiroView, i : Int, v : Double) -> StatstestshapiroView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroView::sum(self : StatstestshapiroView) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroView::mean(self : StatstestshapiroView) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroView::scale(self : StatstestshapiroView, f : Double) -> StatstestshapiroView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroView::add(self : StatstestshapiroView, other : StatstestshapiroView) -> StatstestshapiroView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroView::copy(self : StatstestshapiroView) -> StatstestshapiroView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroView::fill(self : StatstestshapiroView, v : Double) -> StatstestshapiroView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroView::min(self : StatstestshapiroView) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroView::max(self : StatstestshapiroView) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroView::to_string(self : StatstestshapiroView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_range_make(size : Int) -> StatstestshapiroRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroRange::len(self : StatstestshapiroRange) -> Int { self.size }

pub fn StatstestshapiroRange::get(self : StatstestshapiroRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroRange::set(self : StatstestshapiroRange, i : Int, v : Double) -> StatstestshapiroRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroRange::sum(self : StatstestshapiroRange) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroRange::mean(self : StatstestshapiroRange) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroRange::scale(self : StatstestshapiroRange, f : Double) -> StatstestshapiroRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroRange::add(self : StatstestshapiroRange, other : StatstestshapiroRange) -> StatstestshapiroRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroRange::copy(self : StatstestshapiroRange) -> StatstestshapiroRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroRange::fill(self : StatstestshapiroRange, v : Double) -> StatstestshapiroRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroRange::min(self : StatstestshapiroRange) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroRange::max(self : StatstestshapiroRange) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroRange::to_string(self : StatstestshapiroRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_slice_make(size : Int) -> StatstestshapiroSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestshapiroSlice::len(self : StatstestshapiroSlice) -> Int { self.size }

pub fn StatstestshapiroSlice::get(self : StatstestshapiroSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestshapiroSlice::set(self : StatstestshapiroSlice, i : Int, v : Double) -> StatstestshapiroSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestshapiroSlice::sum(self : StatstestshapiroSlice) -> Double { @_common.sum(self.data) }

pub fn StatstestshapiroSlice::mean(self : StatstestshapiroSlice) -> Double { @_common.mean(self.data) }

pub fn StatstestshapiroSlice::scale(self : StatstestshapiroSlice, f : Double) -> StatstestshapiroSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroSlice::add(self : StatstestshapiroSlice, other : StatstestshapiroSlice) -> StatstestshapiroSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestshapiroSlice::copy(self : StatstestshapiroSlice) -> StatstestshapiroSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroSlice::fill(self : StatstestshapiroSlice, v : Double) -> StatstestshapiroSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestshapiroSlice::min(self : StatstestshapiroSlice) -> Double { @_common.min(self.data) }

pub fn StatstestshapiroSlice::max(self : StatstestshapiroSlice) -> Double { @_common.max(self.data) }

pub fn StatstestshapiroSlice::to_string(self : StatstestshapiroSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

