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

pub fn StatstesthomogeneityFrame::len(self : StatstesthomogeneityFrame) -> Int { self.size }

pub fn StatstesthomogeneityFrame::get(self : StatstesthomogeneityFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityFrame::set(self : StatstesthomogeneityFrame, i : Int, v : Double) -> StatstesthomogeneityFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityFrame::sum(self : StatstesthomogeneityFrame) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityFrame::mean(self : StatstesthomogeneityFrame) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityFrame::scale(self : StatstesthomogeneityFrame, f : Double) -> StatstesthomogeneityFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityFrame::add(self : StatstesthomogeneityFrame, other : StatstesthomogeneityFrame) -> StatstesthomogeneityFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityFrame::copy(self : StatstesthomogeneityFrame) -> StatstesthomogeneityFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityFrame::fill(self : StatstesthomogeneityFrame, v : Double) -> StatstesthomogeneityFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityFrame::min(self : StatstesthomogeneityFrame) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityFrame::max(self : StatstesthomogeneityFrame) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityFrame::to_string(self : StatstesthomogeneityFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_table_make(size : Int) -> StatstesthomogeneityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityTable::len(self : StatstesthomogeneityTable) -> Int { self.size }

pub fn StatstesthomogeneityTable::get(self : StatstesthomogeneityTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityTable::set(self : StatstesthomogeneityTable, i : Int, v : Double) -> StatstesthomogeneityTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityTable::sum(self : StatstesthomogeneityTable) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityTable::mean(self : StatstesthomogeneityTable) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityTable::scale(self : StatstesthomogeneityTable, f : Double) -> StatstesthomogeneityTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityTable::add(self : StatstesthomogeneityTable, other : StatstesthomogeneityTable) -> StatstesthomogeneityTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityTable::copy(self : StatstesthomogeneityTable) -> StatstesthomogeneityTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityTable::fill(self : StatstesthomogeneityTable, v : Double) -> StatstesthomogeneityTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityTable::min(self : StatstesthomogeneityTable) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityTable::max(self : StatstesthomogeneityTable) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityTable::to_string(self : StatstesthomogeneityTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_graphn_make(size : Int) -> StatstesthomogeneityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityGraphN::len(self : StatstesthomogeneityGraphN) -> Int { self.size }

pub fn StatstesthomogeneityGraphN::get(self : StatstesthomogeneityGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityGraphN::set(self : StatstesthomogeneityGraphN, i : Int, v : Double) -> StatstesthomogeneityGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityGraphN::sum(self : StatstesthomogeneityGraphN) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityGraphN::mean(self : StatstesthomogeneityGraphN) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityGraphN::scale(self : StatstesthomogeneityGraphN, f : Double) -> StatstesthomogeneityGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityGraphN::add(self : StatstesthomogeneityGraphN, other : StatstesthomogeneityGraphN) -> StatstesthomogeneityGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityGraphN::copy(self : StatstesthomogeneityGraphN) -> StatstesthomogeneityGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityGraphN::fill(self : StatstesthomogeneityGraphN, v : Double) -> StatstesthomogeneityGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityGraphN::min(self : StatstesthomogeneityGraphN) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityGraphN::max(self : StatstesthomogeneityGraphN) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityGraphN::to_string(self : StatstesthomogeneityGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_node_make(size : Int) -> StatstesthomogeneityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityNode::len(self : StatstesthomogeneityNode) -> Int { self.size }

pub fn StatstesthomogeneityNode::get(self : StatstesthomogeneityNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityNode::set(self : StatstesthomogeneityNode, i : Int, v : Double) -> StatstesthomogeneityNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityNode::sum(self : StatstesthomogeneityNode) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityNode::mean(self : StatstesthomogeneityNode) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityNode::scale(self : StatstesthomogeneityNode, f : Double) -> StatstesthomogeneityNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityNode::add(self : StatstesthomogeneityNode, other : StatstesthomogeneityNode) -> StatstesthomogeneityNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityNode::copy(self : StatstesthomogeneityNode) -> StatstesthomogeneityNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityNode::fill(self : StatstesthomogeneityNode, v : Double) -> StatstesthomogeneityNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityNode::min(self : StatstesthomogeneityNode) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityNode::max(self : StatstesthomogeneityNode) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityNode::to_string(self : StatstesthomogeneityNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_edge_make(size : Int) -> StatstesthomogeneityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityEdge::len(self : StatstesthomogeneityEdge) -> Int { self.size }

pub fn StatstesthomogeneityEdge::get(self : StatstesthomogeneityEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityEdge::set(self : StatstesthomogeneityEdge, i : Int, v : Double) -> StatstesthomogeneityEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityEdge::sum(self : StatstesthomogeneityEdge) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityEdge::mean(self : StatstesthomogeneityEdge) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityEdge::scale(self : StatstesthomogeneityEdge, f : Double) -> StatstesthomogeneityEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityEdge::add(self : StatstesthomogeneityEdge, other : StatstesthomogeneityEdge) -> StatstesthomogeneityEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityEdge::copy(self : StatstesthomogeneityEdge) -> StatstesthomogeneityEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityEdge::fill(self : StatstesthomogeneityEdge, v : Double) -> StatstesthomogeneityEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityEdge::min(self : StatstesthomogeneityEdge) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityEdge::max(self : StatstesthomogeneityEdge) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityEdge::to_string(self : StatstesthomogeneityEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_path_make(size : Int) -> StatstesthomogeneityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityPath::len(self : StatstesthomogeneityPath) -> Int { self.size }

pub fn StatstesthomogeneityPath::get(self : StatstesthomogeneityPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityPath::set(self : StatstesthomogeneityPath, i : Int, v : Double) -> StatstesthomogeneityPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityPath::sum(self : StatstesthomogeneityPath) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityPath::mean(self : StatstesthomogeneityPath) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityPath::scale(self : StatstesthomogeneityPath, f : Double) -> StatstesthomogeneityPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityPath::add(self : StatstesthomogeneityPath, other : StatstesthomogeneityPath) -> StatstesthomogeneityPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityPath::copy(self : StatstesthomogeneityPath) -> StatstesthomogeneityPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityPath::fill(self : StatstesthomogeneityPath, v : Double) -> StatstesthomogeneityPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityPath::min(self : StatstesthomogeneityPath) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityPath::max(self : StatstesthomogeneityPath) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityPath::to_string(self : StatstesthomogeneityPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_cluster_make(size : Int) -> StatstesthomogeneityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityCluster::len(self : StatstesthomogeneityCluster) -> Int { self.size }

pub fn StatstesthomogeneityCluster::get(self : StatstesthomogeneityCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityCluster::set(self : StatstesthomogeneityCluster, i : Int, v : Double) -> StatstesthomogeneityCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityCluster::sum(self : StatstesthomogeneityCluster) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityCluster::mean(self : StatstesthomogeneityCluster) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityCluster::scale(self : StatstesthomogeneityCluster, f : Double) -> StatstesthomogeneityCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityCluster::add(self : StatstesthomogeneityCluster, other : StatstesthomogeneityCluster) -> StatstesthomogeneityCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityCluster::copy(self : StatstesthomogeneityCluster) -> StatstesthomogeneityCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityCluster::fill(self : StatstesthomogeneityCluster, v : Double) -> StatstesthomogeneityCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityCluster::min(self : StatstesthomogeneityCluster) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityCluster::max(self : StatstesthomogeneityCluster) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityCluster::to_string(self : StatstesthomogeneityCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_model_make(size : Int) -> StatstesthomogeneityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityModel::len(self : StatstesthomogeneityModel) -> Int { self.size }

pub fn StatstesthomogeneityModel::get(self : StatstesthomogeneityModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityModel::set(self : StatstesthomogeneityModel, i : Int, v : Double) -> StatstesthomogeneityModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityModel::sum(self : StatstesthomogeneityModel) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityModel::mean(self : StatstesthomogeneityModel) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityModel::scale(self : StatstesthomogeneityModel, f : Double) -> StatstesthomogeneityModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityModel::add(self : StatstesthomogeneityModel, other : StatstesthomogeneityModel) -> StatstesthomogeneityModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityModel::copy(self : StatstesthomogeneityModel) -> StatstesthomogeneityModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityModel::fill(self : StatstesthomogeneityModel, v : Double) -> StatstesthomogeneityModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityModel::min(self : StatstesthomogeneityModel) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityModel::max(self : StatstesthomogeneityModel) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityModel::to_string(self : StatstesthomogeneityModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_layer_make(size : Int) -> StatstesthomogeneityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityLayer::len(self : StatstesthomogeneityLayer) -> Int { self.size }

pub fn StatstesthomogeneityLayer::get(self : StatstesthomogeneityLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityLayer::set(self : StatstesthomogeneityLayer, i : Int, v : Double) -> StatstesthomogeneityLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityLayer::sum(self : StatstesthomogeneityLayer) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityLayer::mean(self : StatstesthomogeneityLayer) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityLayer::scale(self : StatstesthomogeneityLayer, f : Double) -> StatstesthomogeneityLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityLayer::add(self : StatstesthomogeneityLayer, other : StatstesthomogeneityLayer) -> StatstesthomogeneityLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityLayer::copy(self : StatstesthomogeneityLayer) -> StatstesthomogeneityLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityLayer::fill(self : StatstesthomogeneityLayer, v : Double) -> StatstesthomogeneityLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityLayer::min(self : StatstesthomogeneityLayer) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityLayer::max(self : StatstesthomogeneityLayer) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityLayer::to_string(self : StatstesthomogeneityLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_buffer_make(size : Int) -> StatstesthomogeneityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityBuffer::len(self : StatstesthomogeneityBuffer) -> Int { self.size }

pub fn StatstesthomogeneityBuffer::get(self : StatstesthomogeneityBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityBuffer::set(self : StatstesthomogeneityBuffer, i : Int, v : Double) -> StatstesthomogeneityBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityBuffer::sum(self : StatstesthomogeneityBuffer) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityBuffer::mean(self : StatstesthomogeneityBuffer) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityBuffer::scale(self : StatstesthomogeneityBuffer, f : Double) -> StatstesthomogeneityBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityBuffer::add(self : StatstesthomogeneityBuffer, other : StatstesthomogeneityBuffer) -> StatstesthomogeneityBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityBuffer::copy(self : StatstesthomogeneityBuffer) -> StatstesthomogeneityBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityBuffer::fill(self : StatstesthomogeneityBuffer, v : Double) -> StatstesthomogeneityBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityBuffer::min(self : StatstesthomogeneityBuffer) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityBuffer::max(self : StatstesthomogeneityBuffer) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityBuffer::to_string(self : StatstesthomogeneityBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_cursor_make(size : Int) -> StatstesthomogeneityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityCursor::len(self : StatstesthomogeneityCursor) -> Int { self.size }

pub fn StatstesthomogeneityCursor::get(self : StatstesthomogeneityCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityCursor::set(self : StatstesthomogeneityCursor, i : Int, v : Double) -> StatstesthomogeneityCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityCursor::sum(self : StatstesthomogeneityCursor) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityCursor::mean(self : StatstesthomogeneityCursor) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityCursor::scale(self : StatstesthomogeneityCursor, f : Double) -> StatstesthomogeneityCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityCursor::add(self : StatstesthomogeneityCursor, other : StatstesthomogeneityCursor) -> StatstesthomogeneityCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityCursor::copy(self : StatstesthomogeneityCursor) -> StatstesthomogeneityCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityCursor::fill(self : StatstesthomogeneityCursor, v : Double) -> StatstesthomogeneityCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityCursor::min(self : StatstesthomogeneityCursor) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityCursor::max(self : StatstesthomogeneityCursor) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityCursor::to_string(self : StatstesthomogeneityCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_view_make(size : Int) -> StatstesthomogeneityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityView::len(self : StatstesthomogeneityView) -> Int { self.size }

pub fn StatstesthomogeneityView::get(self : StatstesthomogeneityView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityView::set(self : StatstesthomogeneityView, i : Int, v : Double) -> StatstesthomogeneityView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityView::sum(self : StatstesthomogeneityView) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityView::mean(self : StatstesthomogeneityView) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityView::scale(self : StatstesthomogeneityView, f : Double) -> StatstesthomogeneityView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityView::add(self : StatstesthomogeneityView, other : StatstesthomogeneityView) -> StatstesthomogeneityView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityView::copy(self : StatstesthomogeneityView) -> StatstesthomogeneityView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityView::fill(self : StatstesthomogeneityView, v : Double) -> StatstesthomogeneityView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityView::min(self : StatstesthomogeneityView) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityView::max(self : StatstesthomogeneityView) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityView::to_string(self : StatstesthomogeneityView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_range_make(size : Int) -> StatstesthomogeneityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneityRange::len(self : StatstesthomogeneityRange) -> Int { self.size }

pub fn StatstesthomogeneityRange::get(self : StatstesthomogeneityRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneityRange::set(self : StatstesthomogeneityRange, i : Int, v : Double) -> StatstesthomogeneityRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityRange::sum(self : StatstesthomogeneityRange) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneityRange::mean(self : StatstesthomogeneityRange) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneityRange::scale(self : StatstesthomogeneityRange, f : Double) -> StatstesthomogeneityRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityRange::add(self : StatstesthomogeneityRange, other : StatstesthomogeneityRange) -> StatstesthomogeneityRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneityRange::copy(self : StatstesthomogeneityRange) -> StatstesthomogeneityRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityRange::fill(self : StatstesthomogeneityRange, v : Double) -> StatstesthomogeneityRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneityRange::min(self : StatstesthomogeneityRange) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneityRange::max(self : StatstesthomogeneityRange) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneityRange::to_string(self : StatstesthomogeneityRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_slice_make(size : Int) -> StatstesthomogeneitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesthomogeneitySlice::len(self : StatstesthomogeneitySlice) -> Int { self.size }

pub fn StatstesthomogeneitySlice::get(self : StatstesthomogeneitySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesthomogeneitySlice::set(self : StatstesthomogeneitySlice, i : Int, v : Double) -> StatstesthomogeneitySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneitySlice::sum(self : StatstesthomogeneitySlice) -> Double { @_common.sum(self.data) }

pub fn StatstesthomogeneitySlice::mean(self : StatstesthomogeneitySlice) -> Double { @_common.mean(self.data) }

pub fn StatstesthomogeneitySlice::scale(self : StatstesthomogeneitySlice, f : Double) -> StatstesthomogeneitySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneitySlice::add(self : StatstesthomogeneitySlice, other : StatstesthomogeneitySlice) -> StatstesthomogeneitySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesthomogeneitySlice::copy(self : StatstesthomogeneitySlice) -> StatstesthomogeneitySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneitySlice::fill(self : StatstesthomogeneitySlice, v : Double) -> StatstesthomogeneitySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesthomogeneitySlice::min(self : StatstesthomogeneitySlice) -> Double { @_common.min(self.data) }

pub fn StatstesthomogeneitySlice::max(self : StatstesthomogeneitySlice) -> Double { @_common.max(self.data) }

pub fn StatstesthomogeneitySlice::to_string(self : StatstesthomogeneitySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

