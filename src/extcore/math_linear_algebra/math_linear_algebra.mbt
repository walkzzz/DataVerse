///===
/// extcore/math_linear_algebra

pub(all) struct MathlinearalgebraPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_linear_algebra_make_point(x : Double, y : Double) -> MathlinearalgebraPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_linear_algebra_make_point3(x : Double, y : Double, z : Double) -> MathlinearalgebraPoint {
  { x, y, z, label: 0 }
}

pub fn MathlinearalgebraPoint::x(self : MathlinearalgebraPoint) -> Double { self.x }

pub fn MathlinearalgebraPoint::y(self : MathlinearalgebraPoint) -> Double { self.y }

pub fn MathlinearalgebraPoint::z(self : MathlinearalgebraPoint) -> Double { self.z }

pub fn MathlinearalgebraPoint::label(self : MathlinearalgebraPoint) -> Int { self.label }

pub fn MathlinearalgebraPoint::dist(self : MathlinearalgebraPoint, other : MathlinearalgebraPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathlinearalgebraPoint::add(self : MathlinearalgebraPoint, other : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathlinearalgebraPoint::sub(self : MathlinearalgebraPoint, other : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathlinearalgebraPoint::scale(self : MathlinearalgebraPoint, s : Double) -> MathlinearalgebraPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathlinearalgebraPoint::dot(self : MathlinearalgebraPoint, other : MathlinearalgebraPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathlinearalgebraPoint::cross(self : MathlinearalgebraPoint, other : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathlinearalgebraPoint::norm(self : MathlinearalgebraPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathlinearalgebraPoint::normalize(self : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathlinearalgebraPoint::negate(self : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathlinearalgebraPoint::mid(self : MathlinearalgebraPoint, other : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathlinearalgebraPoint::lerp(self : MathlinearalgebraPoint, other : MathlinearalgebraPoint, t : Double) -> MathlinearalgebraPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathlinearalgebraPoint::to_string(self : MathlinearalgebraPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathlinearalgebraSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_linear_algebra_make_series(vals : Array[Double], name : String) -> MathlinearalgebraSeries {
  { vals, name, meta: 0 }
}

pub fn MathlinearalgebraSeries::len(self : MathlinearalgebraSeries) -> Int { self.vals.length() }

pub fn MathlinearalgebraSeries::sum(self : MathlinearalgebraSeries) -> Double { @_common.sum(self.vals) }

pub fn MathlinearalgebraSeries::mean(self : MathlinearalgebraSeries) -> Double { @_common.mean(self.vals) }

pub fn MathlinearalgebraSeries::min(self : MathlinearalgebraSeries) -> Double { @_common.min(self.vals) }

pub fn MathlinearalgebraSeries::max(self : MathlinearalgebraSeries) -> Double { @_common.max(self.vals) }

pub fn MathlinearalgebraSeries::range(self : MathlinearalgebraSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathlinearalgebraSeries::variance(self : MathlinearalgebraSeries) -> Double { @_common.variance(self.vals) }

pub fn MathlinearalgebraSeries::std(self : MathlinearalgebraSeries) -> Double { @_common.std(self.vals) }

pub fn MathlinearalgebraSeries::median(self : MathlinearalgebraSeries) -> Double { @_common.median(self.vals) }

pub fn MathlinearalgebraSeries::scale(self : MathlinearalgebraSeries, f : Double) -> MathlinearalgebraSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathlinearalgebraSeries::add(self : MathlinearalgebraSeries, other : MathlinearalgebraSeries) -> MathlinearalgebraSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathlinearalgebraSeries::sub(self : MathlinearalgebraSeries, other : MathlinearalgebraSeries) -> MathlinearalgebraSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathlinearalgebraSeries::normalize(self : MathlinearalgebraSeries) -> MathlinearalgebraSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathlinearalgebraSeries::cumsum(self : MathlinearalgebraSeries) -> MathlinearalgebraSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathlinearalgebraSeries::to_string(self : MathlinearalgebraSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathlinearalgebraMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_linear_algebra_make_matrix(rows : Int, cols : Int, val : Double) -> MathlinearalgebraMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_linear_algebra_matrix_identity(n : Int) -> MathlinearalgebraMatrix {
  let m = math_linear_algebra_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathlinearalgebraMatrix::get(self : MathlinearalgebraMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathlinearalgebraMatrix::transpose(self : MathlinearalgebraMatrix) -> MathlinearalgebraMatrix {
  let result = math_linear_algebra_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathlinearalgebraMatrix::add(self : MathlinearalgebraMatrix, other : MathlinearalgebraMatrix) -> MathlinearalgebraMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_linear_algebra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathlinearalgebraMatrix::scale(self : MathlinearalgebraMatrix, s : Double) -> MathlinearalgebraMatrix {
  let result = math_linear_algebra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathlinearalgebraMatrix::multiply(self : MathlinearalgebraMatrix, other : MathlinearalgebraMatrix) -> MathlinearalgebraMatrix {
  if self.cols != other.rows { return math_linear_algebra_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_linear_algebra_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathlinearalgebraMatrix::trace(self : MathlinearalgebraMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathlinearalgebraMatrix::det(self : MathlinearalgebraMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathlinearalgebraMatrix::norm(self : MathlinearalgebraMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathlinearalgebraMatrix::to_string(self : MathlinearalgebraMatrix) -> String {
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

pub(all) struct MathlinearalgebraVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_linear_algebra_make_vector(comps : Array[Double]) -> MathlinearalgebraVector {
  { comps, dim: comps.length() }
}

pub fn math_linear_algebra_vector_zero(dim : Int) -> MathlinearalgebraVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathlinearalgebraVector::add(self : MathlinearalgebraVector, other : MathlinearalgebraVector) -> MathlinearalgebraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathlinearalgebraVector::sub(self : MathlinearalgebraVector, other : MathlinearalgebraVector) -> MathlinearalgebraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathlinearalgebraVector::scale(self : MathlinearalgebraVector, s : Double) -> MathlinearalgebraVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathlinearalgebraVector::dot(self : MathlinearalgebraVector, other : MathlinearalgebraVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathlinearalgebraVector::norm(self : MathlinearalgebraVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathlinearalgebraVector::normalize(self : MathlinearalgebraVector) -> MathlinearalgebraVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathlinearalgebraVector::dist(self : MathlinearalgebraVector, other : MathlinearalgebraVector) -> Double {
  self.sub(other).norm()
}

pub fn MathlinearalgebraVector::to_string(self : MathlinearalgebraVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_linear_algebra_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_linear_algebra_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_linear_algebra_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_linear_algebra_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_linear_algebra_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_linear_algebra_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_linear_algebra_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_linear_algebra_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_linear_algebra_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_linear_algebra_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_linear_algebra_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_linear_algebra_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_linear_algebra_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_linear_algebra_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_linear_algebra_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_linear_algebra_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_linear_algebra_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_linear_algebra_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_linear_algebra_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_linear_algebra_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_linear_algebra_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_linear_algebra_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_linear_algebra_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_linear_algebra_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_linear_algebra_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_linear_algebra_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_linear_algebra_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_linear_algebra_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_linear_algebra_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathlinearalgebraFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_frame_make(size : Int) -> MathlinearalgebraFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraFrame::len(self : MathlinearalgebraFrame) -> Int { self.size }

pub fn MathlinearalgebraFrame::get(self : MathlinearalgebraFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraFrame::set(self : MathlinearalgebraFrame, i : Int, v : Double) -> MathlinearalgebraFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraFrame::sum(self : MathlinearalgebraFrame) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraFrame::mean(self : MathlinearalgebraFrame) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraFrame::scale(self : MathlinearalgebraFrame, f : Double) -> MathlinearalgebraFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraFrame::add(self : MathlinearalgebraFrame, other : MathlinearalgebraFrame) -> MathlinearalgebraFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraFrame::copy(self : MathlinearalgebraFrame) -> MathlinearalgebraFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraFrame::fill(self : MathlinearalgebraFrame, v : Double) -> MathlinearalgebraFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraFrame::min(self : MathlinearalgebraFrame) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraFrame::max(self : MathlinearalgebraFrame) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraFrame::to_string(self : MathlinearalgebraFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_table_make(size : Int) -> MathlinearalgebraTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraTable::len(self : MathlinearalgebraTable) -> Int { self.size }

pub fn MathlinearalgebraTable::get(self : MathlinearalgebraTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraTable::set(self : MathlinearalgebraTable, i : Int, v : Double) -> MathlinearalgebraTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraTable::sum(self : MathlinearalgebraTable) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraTable::mean(self : MathlinearalgebraTable) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraTable::scale(self : MathlinearalgebraTable, f : Double) -> MathlinearalgebraTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraTable::add(self : MathlinearalgebraTable, other : MathlinearalgebraTable) -> MathlinearalgebraTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraTable::copy(self : MathlinearalgebraTable) -> MathlinearalgebraTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraTable::fill(self : MathlinearalgebraTable, v : Double) -> MathlinearalgebraTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraTable::min(self : MathlinearalgebraTable) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraTable::max(self : MathlinearalgebraTable) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraTable::to_string(self : MathlinearalgebraTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_graphn_make(size : Int) -> MathlinearalgebraGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraGraphN::len(self : MathlinearalgebraGraphN) -> Int { self.size }

pub fn MathlinearalgebraGraphN::get(self : MathlinearalgebraGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraGraphN::set(self : MathlinearalgebraGraphN, i : Int, v : Double) -> MathlinearalgebraGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraGraphN::sum(self : MathlinearalgebraGraphN) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraGraphN::mean(self : MathlinearalgebraGraphN) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraGraphN::scale(self : MathlinearalgebraGraphN, f : Double) -> MathlinearalgebraGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraGraphN::add(self : MathlinearalgebraGraphN, other : MathlinearalgebraGraphN) -> MathlinearalgebraGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraGraphN::copy(self : MathlinearalgebraGraphN) -> MathlinearalgebraGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraGraphN::fill(self : MathlinearalgebraGraphN, v : Double) -> MathlinearalgebraGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraGraphN::min(self : MathlinearalgebraGraphN) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraGraphN::max(self : MathlinearalgebraGraphN) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraGraphN::to_string(self : MathlinearalgebraGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_node_make(size : Int) -> MathlinearalgebraNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraNode::len(self : MathlinearalgebraNode) -> Int { self.size }

pub fn MathlinearalgebraNode::get(self : MathlinearalgebraNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraNode::set(self : MathlinearalgebraNode, i : Int, v : Double) -> MathlinearalgebraNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraNode::sum(self : MathlinearalgebraNode) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraNode::mean(self : MathlinearalgebraNode) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraNode::scale(self : MathlinearalgebraNode, f : Double) -> MathlinearalgebraNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraNode::add(self : MathlinearalgebraNode, other : MathlinearalgebraNode) -> MathlinearalgebraNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraNode::copy(self : MathlinearalgebraNode) -> MathlinearalgebraNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraNode::fill(self : MathlinearalgebraNode, v : Double) -> MathlinearalgebraNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraNode::min(self : MathlinearalgebraNode) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraNode::max(self : MathlinearalgebraNode) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraNode::to_string(self : MathlinearalgebraNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_edge_make(size : Int) -> MathlinearalgebraEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraEdge::len(self : MathlinearalgebraEdge) -> Int { self.size }

pub fn MathlinearalgebraEdge::get(self : MathlinearalgebraEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraEdge::set(self : MathlinearalgebraEdge, i : Int, v : Double) -> MathlinearalgebraEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraEdge::sum(self : MathlinearalgebraEdge) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraEdge::mean(self : MathlinearalgebraEdge) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraEdge::scale(self : MathlinearalgebraEdge, f : Double) -> MathlinearalgebraEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraEdge::add(self : MathlinearalgebraEdge, other : MathlinearalgebraEdge) -> MathlinearalgebraEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraEdge::copy(self : MathlinearalgebraEdge) -> MathlinearalgebraEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraEdge::fill(self : MathlinearalgebraEdge, v : Double) -> MathlinearalgebraEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraEdge::min(self : MathlinearalgebraEdge) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraEdge::max(self : MathlinearalgebraEdge) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraEdge::to_string(self : MathlinearalgebraEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_path_make(size : Int) -> MathlinearalgebraPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraPath::len(self : MathlinearalgebraPath) -> Int { self.size }

pub fn MathlinearalgebraPath::get(self : MathlinearalgebraPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraPath::set(self : MathlinearalgebraPath, i : Int, v : Double) -> MathlinearalgebraPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraPath::sum(self : MathlinearalgebraPath) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraPath::mean(self : MathlinearalgebraPath) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraPath::scale(self : MathlinearalgebraPath, f : Double) -> MathlinearalgebraPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraPath::add(self : MathlinearalgebraPath, other : MathlinearalgebraPath) -> MathlinearalgebraPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraPath::copy(self : MathlinearalgebraPath) -> MathlinearalgebraPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraPath::fill(self : MathlinearalgebraPath, v : Double) -> MathlinearalgebraPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraPath::min(self : MathlinearalgebraPath) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraPath::max(self : MathlinearalgebraPath) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraPath::to_string(self : MathlinearalgebraPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_cluster_make(size : Int) -> MathlinearalgebraCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraCluster::len(self : MathlinearalgebraCluster) -> Int { self.size }

pub fn MathlinearalgebraCluster::get(self : MathlinearalgebraCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraCluster::set(self : MathlinearalgebraCluster, i : Int, v : Double) -> MathlinearalgebraCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraCluster::sum(self : MathlinearalgebraCluster) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraCluster::mean(self : MathlinearalgebraCluster) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraCluster::scale(self : MathlinearalgebraCluster, f : Double) -> MathlinearalgebraCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraCluster::add(self : MathlinearalgebraCluster, other : MathlinearalgebraCluster) -> MathlinearalgebraCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraCluster::copy(self : MathlinearalgebraCluster) -> MathlinearalgebraCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraCluster::fill(self : MathlinearalgebraCluster, v : Double) -> MathlinearalgebraCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraCluster::min(self : MathlinearalgebraCluster) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraCluster::max(self : MathlinearalgebraCluster) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraCluster::to_string(self : MathlinearalgebraCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_model_make(size : Int) -> MathlinearalgebraModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraModel::len(self : MathlinearalgebraModel) -> Int { self.size }

pub fn MathlinearalgebraModel::get(self : MathlinearalgebraModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraModel::set(self : MathlinearalgebraModel, i : Int, v : Double) -> MathlinearalgebraModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraModel::sum(self : MathlinearalgebraModel) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraModel::mean(self : MathlinearalgebraModel) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraModel::scale(self : MathlinearalgebraModel, f : Double) -> MathlinearalgebraModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraModel::add(self : MathlinearalgebraModel, other : MathlinearalgebraModel) -> MathlinearalgebraModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraModel::copy(self : MathlinearalgebraModel) -> MathlinearalgebraModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraModel::fill(self : MathlinearalgebraModel, v : Double) -> MathlinearalgebraModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraModel::min(self : MathlinearalgebraModel) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraModel::max(self : MathlinearalgebraModel) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraModel::to_string(self : MathlinearalgebraModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_layer_make(size : Int) -> MathlinearalgebraLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraLayer::len(self : MathlinearalgebraLayer) -> Int { self.size }

pub fn MathlinearalgebraLayer::get(self : MathlinearalgebraLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraLayer::set(self : MathlinearalgebraLayer, i : Int, v : Double) -> MathlinearalgebraLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraLayer::sum(self : MathlinearalgebraLayer) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraLayer::mean(self : MathlinearalgebraLayer) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraLayer::scale(self : MathlinearalgebraLayer, f : Double) -> MathlinearalgebraLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraLayer::add(self : MathlinearalgebraLayer, other : MathlinearalgebraLayer) -> MathlinearalgebraLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraLayer::copy(self : MathlinearalgebraLayer) -> MathlinearalgebraLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraLayer::fill(self : MathlinearalgebraLayer, v : Double) -> MathlinearalgebraLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraLayer::min(self : MathlinearalgebraLayer) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraLayer::max(self : MathlinearalgebraLayer) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraLayer::to_string(self : MathlinearalgebraLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_buffer_make(size : Int) -> MathlinearalgebraBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraBuffer::len(self : MathlinearalgebraBuffer) -> Int { self.size }

pub fn MathlinearalgebraBuffer::get(self : MathlinearalgebraBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraBuffer::set(self : MathlinearalgebraBuffer, i : Int, v : Double) -> MathlinearalgebraBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraBuffer::sum(self : MathlinearalgebraBuffer) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraBuffer::mean(self : MathlinearalgebraBuffer) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraBuffer::scale(self : MathlinearalgebraBuffer, f : Double) -> MathlinearalgebraBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraBuffer::add(self : MathlinearalgebraBuffer, other : MathlinearalgebraBuffer) -> MathlinearalgebraBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraBuffer::copy(self : MathlinearalgebraBuffer) -> MathlinearalgebraBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraBuffer::fill(self : MathlinearalgebraBuffer, v : Double) -> MathlinearalgebraBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraBuffer::min(self : MathlinearalgebraBuffer) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraBuffer::max(self : MathlinearalgebraBuffer) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraBuffer::to_string(self : MathlinearalgebraBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_cursor_make(size : Int) -> MathlinearalgebraCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraCursor::len(self : MathlinearalgebraCursor) -> Int { self.size }

pub fn MathlinearalgebraCursor::get(self : MathlinearalgebraCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraCursor::set(self : MathlinearalgebraCursor, i : Int, v : Double) -> MathlinearalgebraCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraCursor::sum(self : MathlinearalgebraCursor) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraCursor::mean(self : MathlinearalgebraCursor) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraCursor::scale(self : MathlinearalgebraCursor, f : Double) -> MathlinearalgebraCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraCursor::add(self : MathlinearalgebraCursor, other : MathlinearalgebraCursor) -> MathlinearalgebraCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraCursor::copy(self : MathlinearalgebraCursor) -> MathlinearalgebraCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraCursor::fill(self : MathlinearalgebraCursor, v : Double) -> MathlinearalgebraCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraCursor::min(self : MathlinearalgebraCursor) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraCursor::max(self : MathlinearalgebraCursor) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraCursor::to_string(self : MathlinearalgebraCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_view_make(size : Int) -> MathlinearalgebraView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraView::len(self : MathlinearalgebraView) -> Int { self.size }

pub fn MathlinearalgebraView::get(self : MathlinearalgebraView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraView::set(self : MathlinearalgebraView, i : Int, v : Double) -> MathlinearalgebraView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraView::sum(self : MathlinearalgebraView) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraView::mean(self : MathlinearalgebraView) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraView::scale(self : MathlinearalgebraView, f : Double) -> MathlinearalgebraView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraView::add(self : MathlinearalgebraView, other : MathlinearalgebraView) -> MathlinearalgebraView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraView::copy(self : MathlinearalgebraView) -> MathlinearalgebraView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraView::fill(self : MathlinearalgebraView, v : Double) -> MathlinearalgebraView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraView::min(self : MathlinearalgebraView) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraView::max(self : MathlinearalgebraView) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraView::to_string(self : MathlinearalgebraView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_range_make(size : Int) -> MathlinearalgebraRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraRange::len(self : MathlinearalgebraRange) -> Int { self.size }

pub fn MathlinearalgebraRange::get(self : MathlinearalgebraRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraRange::set(self : MathlinearalgebraRange, i : Int, v : Double) -> MathlinearalgebraRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraRange::sum(self : MathlinearalgebraRange) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraRange::mean(self : MathlinearalgebraRange) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraRange::scale(self : MathlinearalgebraRange, f : Double) -> MathlinearalgebraRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraRange::add(self : MathlinearalgebraRange, other : MathlinearalgebraRange) -> MathlinearalgebraRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraRange::copy(self : MathlinearalgebraRange) -> MathlinearalgebraRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraRange::fill(self : MathlinearalgebraRange, v : Double) -> MathlinearalgebraRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraRange::min(self : MathlinearalgebraRange) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraRange::max(self : MathlinearalgebraRange) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraRange::to_string(self : MathlinearalgebraRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_slice_make(size : Int) -> MathlinearalgebraSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearalgebraSlice::len(self : MathlinearalgebraSlice) -> Int { self.size }

pub fn MathlinearalgebraSlice::get(self : MathlinearalgebraSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearalgebraSlice::set(self : MathlinearalgebraSlice, i : Int, v : Double) -> MathlinearalgebraSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraSlice::sum(self : MathlinearalgebraSlice) -> Double { @_common.sum(self.data) }

pub fn MathlinearalgebraSlice::mean(self : MathlinearalgebraSlice) -> Double { @_common.mean(self.data) }

pub fn MathlinearalgebraSlice::scale(self : MathlinearalgebraSlice, f : Double) -> MathlinearalgebraSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraSlice::add(self : MathlinearalgebraSlice, other : MathlinearalgebraSlice) -> MathlinearalgebraSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearalgebraSlice::copy(self : MathlinearalgebraSlice) -> MathlinearalgebraSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraSlice::fill(self : MathlinearalgebraSlice, v : Double) -> MathlinearalgebraSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearalgebraSlice::min(self : MathlinearalgebraSlice) -> Double { @_common.min(self.data) }

pub fn MathlinearalgebraSlice::max(self : MathlinearalgebraSlice) -> Double { @_common.max(self.data) }

pub fn MathlinearalgebraSlice::to_string(self : MathlinearalgebraSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

