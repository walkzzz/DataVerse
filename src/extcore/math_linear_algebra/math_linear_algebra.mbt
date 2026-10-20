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

pub fn math_linear_algebra_frame_len(s : MathlinearalgebraFrame) -> Int { s.size }

pub fn math_linear_algebra_frame_get(s : MathlinearalgebraFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_frame_set(s : MathlinearalgebraFrame, i : Int, v : Double) -> MathlinearalgebraFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_frame_sum(s : MathlinearalgebraFrame) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_frame_mean(s : MathlinearalgebraFrame) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_frame_scale(s : MathlinearalgebraFrame, f : Double) -> MathlinearalgebraFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_frame_add(a : MathlinearalgebraFrame, b : MathlinearalgebraFrame) -> MathlinearalgebraFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_frame_copy(s : MathlinearalgebraFrame) -> MathlinearalgebraFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_frame_fill(s : MathlinearalgebraFrame, v : Double) -> MathlinearalgebraFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_frame_min(s : MathlinearalgebraFrame) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_frame_max(s : MathlinearalgebraFrame) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_frame_to_string(s : MathlinearalgebraFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_table_make(size : Int) -> MathlinearalgebraTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_table_len(s : MathlinearalgebraTable) -> Int { s.size }

pub fn math_linear_algebra_table_get(s : MathlinearalgebraTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_table_set(s : MathlinearalgebraTable, i : Int, v : Double) -> MathlinearalgebraTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_table_sum(s : MathlinearalgebraTable) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_table_mean(s : MathlinearalgebraTable) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_table_scale(s : MathlinearalgebraTable, f : Double) -> MathlinearalgebraTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_table_add(a : MathlinearalgebraTable, b : MathlinearalgebraTable) -> MathlinearalgebraTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_table_copy(s : MathlinearalgebraTable) -> MathlinearalgebraTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_table_fill(s : MathlinearalgebraTable, v : Double) -> MathlinearalgebraTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_table_min(s : MathlinearalgebraTable) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_table_max(s : MathlinearalgebraTable) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_table_to_string(s : MathlinearalgebraTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_graphn_make(size : Int) -> MathlinearalgebraGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_graphn_len(s : MathlinearalgebraGraphN) -> Int { s.size }

pub fn math_linear_algebra_graphn_get(s : MathlinearalgebraGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_graphn_set(s : MathlinearalgebraGraphN, i : Int, v : Double) -> MathlinearalgebraGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_graphn_sum(s : MathlinearalgebraGraphN) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_graphn_mean(s : MathlinearalgebraGraphN) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_graphn_scale(s : MathlinearalgebraGraphN, f : Double) -> MathlinearalgebraGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_graphn_add(a : MathlinearalgebraGraphN, b : MathlinearalgebraGraphN) -> MathlinearalgebraGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_graphn_copy(s : MathlinearalgebraGraphN) -> MathlinearalgebraGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_graphn_fill(s : MathlinearalgebraGraphN, v : Double) -> MathlinearalgebraGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_graphn_min(s : MathlinearalgebraGraphN) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_graphn_max(s : MathlinearalgebraGraphN) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_graphn_to_string(s : MathlinearalgebraGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_node_make(size : Int) -> MathlinearalgebraNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_node_len(s : MathlinearalgebraNode) -> Int { s.size }

pub fn math_linear_algebra_node_get(s : MathlinearalgebraNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_node_set(s : MathlinearalgebraNode, i : Int, v : Double) -> MathlinearalgebraNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_node_sum(s : MathlinearalgebraNode) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_node_mean(s : MathlinearalgebraNode) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_node_scale(s : MathlinearalgebraNode, f : Double) -> MathlinearalgebraNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_node_add(a : MathlinearalgebraNode, b : MathlinearalgebraNode) -> MathlinearalgebraNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_node_copy(s : MathlinearalgebraNode) -> MathlinearalgebraNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_node_fill(s : MathlinearalgebraNode, v : Double) -> MathlinearalgebraNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_node_min(s : MathlinearalgebraNode) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_node_max(s : MathlinearalgebraNode) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_node_to_string(s : MathlinearalgebraNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_edge_make(size : Int) -> MathlinearalgebraEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_edge_len(s : MathlinearalgebraEdge) -> Int { s.size }

pub fn math_linear_algebra_edge_get(s : MathlinearalgebraEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_edge_set(s : MathlinearalgebraEdge, i : Int, v : Double) -> MathlinearalgebraEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_edge_sum(s : MathlinearalgebraEdge) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_edge_mean(s : MathlinearalgebraEdge) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_edge_scale(s : MathlinearalgebraEdge, f : Double) -> MathlinearalgebraEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_edge_add(a : MathlinearalgebraEdge, b : MathlinearalgebraEdge) -> MathlinearalgebraEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_edge_copy(s : MathlinearalgebraEdge) -> MathlinearalgebraEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_edge_fill(s : MathlinearalgebraEdge, v : Double) -> MathlinearalgebraEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_edge_min(s : MathlinearalgebraEdge) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_edge_max(s : MathlinearalgebraEdge) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_edge_to_string(s : MathlinearalgebraEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_path_make(size : Int) -> MathlinearalgebraPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_path_len(s : MathlinearalgebraPath) -> Int { s.size }

pub fn math_linear_algebra_path_get(s : MathlinearalgebraPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_path_set(s : MathlinearalgebraPath, i : Int, v : Double) -> MathlinearalgebraPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_path_sum(s : MathlinearalgebraPath) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_path_mean(s : MathlinearalgebraPath) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_path_scale(s : MathlinearalgebraPath, f : Double) -> MathlinearalgebraPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_path_add(a : MathlinearalgebraPath, b : MathlinearalgebraPath) -> MathlinearalgebraPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_path_copy(s : MathlinearalgebraPath) -> MathlinearalgebraPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_path_fill(s : MathlinearalgebraPath, v : Double) -> MathlinearalgebraPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_path_min(s : MathlinearalgebraPath) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_path_max(s : MathlinearalgebraPath) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_path_to_string(s : MathlinearalgebraPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_cluster_make(size : Int) -> MathlinearalgebraCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_cluster_len(s : MathlinearalgebraCluster) -> Int { s.size }

pub fn math_linear_algebra_cluster_get(s : MathlinearalgebraCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_cluster_set(s : MathlinearalgebraCluster, i : Int, v : Double) -> MathlinearalgebraCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cluster_sum(s : MathlinearalgebraCluster) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_cluster_mean(s : MathlinearalgebraCluster) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_cluster_scale(s : MathlinearalgebraCluster, f : Double) -> MathlinearalgebraCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cluster_add(a : MathlinearalgebraCluster, b : MathlinearalgebraCluster) -> MathlinearalgebraCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_cluster_copy(s : MathlinearalgebraCluster) -> MathlinearalgebraCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cluster_fill(s : MathlinearalgebraCluster, v : Double) -> MathlinearalgebraCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cluster_min(s : MathlinearalgebraCluster) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_cluster_max(s : MathlinearalgebraCluster) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_cluster_to_string(s : MathlinearalgebraCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_model_make(size : Int) -> MathlinearalgebraModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_model_len(s : MathlinearalgebraModel) -> Int { s.size }

pub fn math_linear_algebra_model_get(s : MathlinearalgebraModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_model_set(s : MathlinearalgebraModel, i : Int, v : Double) -> MathlinearalgebraModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_model_sum(s : MathlinearalgebraModel) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_model_mean(s : MathlinearalgebraModel) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_model_scale(s : MathlinearalgebraModel, f : Double) -> MathlinearalgebraModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_model_add(a : MathlinearalgebraModel, b : MathlinearalgebraModel) -> MathlinearalgebraModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_model_copy(s : MathlinearalgebraModel) -> MathlinearalgebraModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_model_fill(s : MathlinearalgebraModel, v : Double) -> MathlinearalgebraModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_model_min(s : MathlinearalgebraModel) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_model_max(s : MathlinearalgebraModel) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_model_to_string(s : MathlinearalgebraModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_layer_make(size : Int) -> MathlinearalgebraLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_layer_len(s : MathlinearalgebraLayer) -> Int { s.size }

pub fn math_linear_algebra_layer_get(s : MathlinearalgebraLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_layer_set(s : MathlinearalgebraLayer, i : Int, v : Double) -> MathlinearalgebraLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_layer_sum(s : MathlinearalgebraLayer) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_layer_mean(s : MathlinearalgebraLayer) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_layer_scale(s : MathlinearalgebraLayer, f : Double) -> MathlinearalgebraLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_layer_add(a : MathlinearalgebraLayer, b : MathlinearalgebraLayer) -> MathlinearalgebraLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_layer_copy(s : MathlinearalgebraLayer) -> MathlinearalgebraLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_layer_fill(s : MathlinearalgebraLayer, v : Double) -> MathlinearalgebraLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_layer_min(s : MathlinearalgebraLayer) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_layer_max(s : MathlinearalgebraLayer) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_layer_to_string(s : MathlinearalgebraLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_buffer_make(size : Int) -> MathlinearalgebraBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_buffer_len(s : MathlinearalgebraBuffer) -> Int { s.size }

pub fn math_linear_algebra_buffer_get(s : MathlinearalgebraBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_buffer_set(s : MathlinearalgebraBuffer, i : Int, v : Double) -> MathlinearalgebraBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_buffer_sum(s : MathlinearalgebraBuffer) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_buffer_mean(s : MathlinearalgebraBuffer) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_buffer_scale(s : MathlinearalgebraBuffer, f : Double) -> MathlinearalgebraBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_buffer_add(a : MathlinearalgebraBuffer, b : MathlinearalgebraBuffer) -> MathlinearalgebraBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_buffer_copy(s : MathlinearalgebraBuffer) -> MathlinearalgebraBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_buffer_fill(s : MathlinearalgebraBuffer, v : Double) -> MathlinearalgebraBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_buffer_min(s : MathlinearalgebraBuffer) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_buffer_max(s : MathlinearalgebraBuffer) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_buffer_to_string(s : MathlinearalgebraBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_cursor_make(size : Int) -> MathlinearalgebraCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_cursor_len(s : MathlinearalgebraCursor) -> Int { s.size }

pub fn math_linear_algebra_cursor_get(s : MathlinearalgebraCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_cursor_set(s : MathlinearalgebraCursor, i : Int, v : Double) -> MathlinearalgebraCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cursor_sum(s : MathlinearalgebraCursor) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_cursor_mean(s : MathlinearalgebraCursor) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_cursor_scale(s : MathlinearalgebraCursor, f : Double) -> MathlinearalgebraCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cursor_add(a : MathlinearalgebraCursor, b : MathlinearalgebraCursor) -> MathlinearalgebraCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_cursor_copy(s : MathlinearalgebraCursor) -> MathlinearalgebraCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cursor_fill(s : MathlinearalgebraCursor, v : Double) -> MathlinearalgebraCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cursor_min(s : MathlinearalgebraCursor) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_cursor_max(s : MathlinearalgebraCursor) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_cursor_to_string(s : MathlinearalgebraCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_view_make(size : Int) -> MathlinearalgebraView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_view_len(s : MathlinearalgebraView) -> Int { s.size }

pub fn math_linear_algebra_view_get(s : MathlinearalgebraView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_view_set(s : MathlinearalgebraView, i : Int, v : Double) -> MathlinearalgebraView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_view_sum(s : MathlinearalgebraView) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_view_mean(s : MathlinearalgebraView) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_view_scale(s : MathlinearalgebraView, f : Double) -> MathlinearalgebraView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_view_add(a : MathlinearalgebraView, b : MathlinearalgebraView) -> MathlinearalgebraView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_view_copy(s : MathlinearalgebraView) -> MathlinearalgebraView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_view_fill(s : MathlinearalgebraView, v : Double) -> MathlinearalgebraView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_view_min(s : MathlinearalgebraView) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_view_max(s : MathlinearalgebraView) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_view_to_string(s : MathlinearalgebraView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_range_make(size : Int) -> MathlinearalgebraRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_range_len(s : MathlinearalgebraRange) -> Int { s.size }

pub fn math_linear_algebra_range_get(s : MathlinearalgebraRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_range_set(s : MathlinearalgebraRange, i : Int, v : Double) -> MathlinearalgebraRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_range_sum(s : MathlinearalgebraRange) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_range_mean(s : MathlinearalgebraRange) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_range_scale(s : MathlinearalgebraRange, f : Double) -> MathlinearalgebraRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_range_add(a : MathlinearalgebraRange, b : MathlinearalgebraRange) -> MathlinearalgebraRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_range_copy(s : MathlinearalgebraRange) -> MathlinearalgebraRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_range_fill(s : MathlinearalgebraRange, v : Double) -> MathlinearalgebraRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_range_min(s : MathlinearalgebraRange) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_range_max(s : MathlinearalgebraRange) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_range_to_string(s : MathlinearalgebraRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_slice_make(size : Int) -> MathlinearalgebraSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_slice_len(s : MathlinearalgebraSlice) -> Int { s.size }

pub fn math_linear_algebra_slice_get(s : MathlinearalgebraSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_slice_set(s : MathlinearalgebraSlice, i : Int, v : Double) -> MathlinearalgebraSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_slice_sum(s : MathlinearalgebraSlice) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_slice_mean(s : MathlinearalgebraSlice) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_slice_scale(s : MathlinearalgebraSlice, f : Double) -> MathlinearalgebraSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_slice_add(a : MathlinearalgebraSlice, b : MathlinearalgebraSlice) -> MathlinearalgebraSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_slice_copy(s : MathlinearalgebraSlice) -> MathlinearalgebraSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_slice_fill(s : MathlinearalgebraSlice, v : Double) -> MathlinearalgebraSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_slice_min(s : MathlinearalgebraSlice) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_slice_max(s : MathlinearalgebraSlice) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_slice_to_string(s : MathlinearalgebraSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

