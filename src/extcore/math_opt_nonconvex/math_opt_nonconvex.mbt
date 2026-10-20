///===
/// extcore/math_opt_nonconvex

pub(all) struct MathoptnonconvexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_opt_nonconvex_make_point(x : Double, y : Double) -> MathoptnonconvexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_opt_nonconvex_make_point3(x : Double, y : Double, z : Double) -> MathoptnonconvexPoint {
  { x, y, z, label: 0 }
}

pub fn MathoptnonconvexPoint::x(self : MathoptnonconvexPoint) -> Double { self.x }

pub fn MathoptnonconvexPoint::y(self : MathoptnonconvexPoint) -> Double { self.y }

pub fn MathoptnonconvexPoint::z(self : MathoptnonconvexPoint) -> Double { self.z }

pub fn MathoptnonconvexPoint::label(self : MathoptnonconvexPoint) -> Int { self.label }

pub fn MathoptnonconvexPoint::dist(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathoptnonconvexPoint::add(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathoptnonconvexPoint::sub(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathoptnonconvexPoint::scale(self : MathoptnonconvexPoint, s : Double) -> MathoptnonconvexPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathoptnonconvexPoint::dot(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathoptnonconvexPoint::cross(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathoptnonconvexPoint::norm(self : MathoptnonconvexPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathoptnonconvexPoint::normalize(self : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathoptnonconvexPoint::negate(self : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathoptnonconvexPoint::mid(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathoptnonconvexPoint::lerp(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint, t : Double) -> MathoptnonconvexPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathoptnonconvexPoint::to_string(self : MathoptnonconvexPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathoptnonconvexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_opt_nonconvex_make_series(vals : Array[Double], name : String) -> MathoptnonconvexSeries {
  { vals, name, meta: 0 }
}

pub fn MathoptnonconvexSeries::len(self : MathoptnonconvexSeries) -> Int { self.vals.length() }

pub fn MathoptnonconvexSeries::sum(self : MathoptnonconvexSeries) -> Double { @_common.sum(self.vals) }

pub fn MathoptnonconvexSeries::mean(self : MathoptnonconvexSeries) -> Double { @_common.mean(self.vals) }

pub fn MathoptnonconvexSeries::min(self : MathoptnonconvexSeries) -> Double { @_common.min(self.vals) }

pub fn MathoptnonconvexSeries::max(self : MathoptnonconvexSeries) -> Double { @_common.max(self.vals) }

pub fn MathoptnonconvexSeries::range(self : MathoptnonconvexSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathoptnonconvexSeries::variance(self : MathoptnonconvexSeries) -> Double { @_common.variance(self.vals) }

pub fn MathoptnonconvexSeries::std(self : MathoptnonconvexSeries) -> Double { @_common.std(self.vals) }

pub fn MathoptnonconvexSeries::median(self : MathoptnonconvexSeries) -> Double { @_common.median(self.vals) }

pub fn MathoptnonconvexSeries::scale(self : MathoptnonconvexSeries, f : Double) -> MathoptnonconvexSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathoptnonconvexSeries::add(self : MathoptnonconvexSeries, other : MathoptnonconvexSeries) -> MathoptnonconvexSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathoptnonconvexSeries::sub(self : MathoptnonconvexSeries, other : MathoptnonconvexSeries) -> MathoptnonconvexSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathoptnonconvexSeries::normalize(self : MathoptnonconvexSeries) -> MathoptnonconvexSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathoptnonconvexSeries::cumsum(self : MathoptnonconvexSeries) -> MathoptnonconvexSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathoptnonconvexSeries::to_string(self : MathoptnonconvexSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathoptnonconvexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_opt_nonconvex_make_matrix(rows : Int, cols : Int, val : Double) -> MathoptnonconvexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_opt_nonconvex_matrix_identity(n : Int) -> MathoptnonconvexMatrix {
  let m = math_opt_nonconvex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathoptnonconvexMatrix::get(self : MathoptnonconvexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathoptnonconvexMatrix::transpose(self : MathoptnonconvexMatrix) -> MathoptnonconvexMatrix {
  let result = math_opt_nonconvex_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathoptnonconvexMatrix::add(self : MathoptnonconvexMatrix, other : MathoptnonconvexMatrix) -> MathoptnonconvexMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_opt_nonconvex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathoptnonconvexMatrix::scale(self : MathoptnonconvexMatrix, s : Double) -> MathoptnonconvexMatrix {
  let result = math_opt_nonconvex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathoptnonconvexMatrix::multiply(self : MathoptnonconvexMatrix, other : MathoptnonconvexMatrix) -> MathoptnonconvexMatrix {
  if self.cols != other.rows { return math_opt_nonconvex_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_opt_nonconvex_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathoptnonconvexMatrix::trace(self : MathoptnonconvexMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathoptnonconvexMatrix::det(self : MathoptnonconvexMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathoptnonconvexMatrix::norm(self : MathoptnonconvexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathoptnonconvexMatrix::to_string(self : MathoptnonconvexMatrix) -> String {
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

pub(all) struct MathoptnonconvexVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_opt_nonconvex_make_vector(comps : Array[Double]) -> MathoptnonconvexVector {
  { comps, dim: comps.length() }
}

pub fn math_opt_nonconvex_vector_zero(dim : Int) -> MathoptnonconvexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathoptnonconvexVector::add(self : MathoptnonconvexVector, other : MathoptnonconvexVector) -> MathoptnonconvexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathoptnonconvexVector::sub(self : MathoptnonconvexVector, other : MathoptnonconvexVector) -> MathoptnonconvexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathoptnonconvexVector::scale(self : MathoptnonconvexVector, s : Double) -> MathoptnonconvexVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathoptnonconvexVector::dot(self : MathoptnonconvexVector, other : MathoptnonconvexVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathoptnonconvexVector::norm(self : MathoptnonconvexVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathoptnonconvexVector::normalize(self : MathoptnonconvexVector) -> MathoptnonconvexVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathoptnonconvexVector::dist(self : MathoptnonconvexVector, other : MathoptnonconvexVector) -> Double {
  self.sub(other).norm()
}

pub fn MathoptnonconvexVector::to_string(self : MathoptnonconvexVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_opt_nonconvex_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_opt_nonconvex_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_opt_nonconvex_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_opt_nonconvex_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_opt_nonconvex_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_opt_nonconvex_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_opt_nonconvex_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_opt_nonconvex_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_opt_nonconvex_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_opt_nonconvex_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_opt_nonconvex_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_opt_nonconvex_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_opt_nonconvex_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_opt_nonconvex_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_opt_nonconvex_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_opt_nonconvex_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_opt_nonconvex_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_opt_nonconvex_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_opt_nonconvex_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_opt_nonconvex_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_opt_nonconvex_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_opt_nonconvex_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_opt_nonconvex_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_opt_nonconvex_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_opt_nonconvex_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_opt_nonconvex_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_opt_nonconvex_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_opt_nonconvex_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_opt_nonconvex_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathoptnonconvexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_frame_make(size : Int) -> MathoptnonconvexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_frame_len(s : MathoptnonconvexFrame) -> Int { s.size }

pub fn math_opt_nonconvex_frame_get(s : MathoptnonconvexFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_frame_set(s : MathoptnonconvexFrame, i : Int, v : Double) -> MathoptnonconvexFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_frame_sum(s : MathoptnonconvexFrame) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_frame_mean(s : MathoptnonconvexFrame) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_frame_scale(s : MathoptnonconvexFrame, f : Double) -> MathoptnonconvexFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_frame_add(a : MathoptnonconvexFrame, b : MathoptnonconvexFrame) -> MathoptnonconvexFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_frame_copy(s : MathoptnonconvexFrame) -> MathoptnonconvexFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_frame_fill(s : MathoptnonconvexFrame, v : Double) -> MathoptnonconvexFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_frame_min(s : MathoptnonconvexFrame) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_frame_max(s : MathoptnonconvexFrame) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_frame_to_string(s : MathoptnonconvexFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_table_make(size : Int) -> MathoptnonconvexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_table_len(s : MathoptnonconvexTable) -> Int { s.size }

pub fn math_opt_nonconvex_table_get(s : MathoptnonconvexTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_table_set(s : MathoptnonconvexTable, i : Int, v : Double) -> MathoptnonconvexTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_table_sum(s : MathoptnonconvexTable) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_table_mean(s : MathoptnonconvexTable) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_table_scale(s : MathoptnonconvexTable, f : Double) -> MathoptnonconvexTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_table_add(a : MathoptnonconvexTable, b : MathoptnonconvexTable) -> MathoptnonconvexTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_table_copy(s : MathoptnonconvexTable) -> MathoptnonconvexTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_table_fill(s : MathoptnonconvexTable, v : Double) -> MathoptnonconvexTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_table_min(s : MathoptnonconvexTable) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_table_max(s : MathoptnonconvexTable) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_table_to_string(s : MathoptnonconvexTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_graphn_make(size : Int) -> MathoptnonconvexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_graphn_len(s : MathoptnonconvexGraphN) -> Int { s.size }

pub fn math_opt_nonconvex_graphn_get(s : MathoptnonconvexGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_graphn_set(s : MathoptnonconvexGraphN, i : Int, v : Double) -> MathoptnonconvexGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_graphn_sum(s : MathoptnonconvexGraphN) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_graphn_mean(s : MathoptnonconvexGraphN) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_graphn_scale(s : MathoptnonconvexGraphN, f : Double) -> MathoptnonconvexGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_graphn_add(a : MathoptnonconvexGraphN, b : MathoptnonconvexGraphN) -> MathoptnonconvexGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_graphn_copy(s : MathoptnonconvexGraphN) -> MathoptnonconvexGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_graphn_fill(s : MathoptnonconvexGraphN, v : Double) -> MathoptnonconvexGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_graphn_min(s : MathoptnonconvexGraphN) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_graphn_max(s : MathoptnonconvexGraphN) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_graphn_to_string(s : MathoptnonconvexGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_node_make(size : Int) -> MathoptnonconvexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_node_len(s : MathoptnonconvexNode) -> Int { s.size }

pub fn math_opt_nonconvex_node_get(s : MathoptnonconvexNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_node_set(s : MathoptnonconvexNode, i : Int, v : Double) -> MathoptnonconvexNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_node_sum(s : MathoptnonconvexNode) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_node_mean(s : MathoptnonconvexNode) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_node_scale(s : MathoptnonconvexNode, f : Double) -> MathoptnonconvexNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_node_add(a : MathoptnonconvexNode, b : MathoptnonconvexNode) -> MathoptnonconvexNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_node_copy(s : MathoptnonconvexNode) -> MathoptnonconvexNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_node_fill(s : MathoptnonconvexNode, v : Double) -> MathoptnonconvexNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_node_min(s : MathoptnonconvexNode) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_node_max(s : MathoptnonconvexNode) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_node_to_string(s : MathoptnonconvexNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_edge_make(size : Int) -> MathoptnonconvexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_edge_len(s : MathoptnonconvexEdge) -> Int { s.size }

pub fn math_opt_nonconvex_edge_get(s : MathoptnonconvexEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_edge_set(s : MathoptnonconvexEdge, i : Int, v : Double) -> MathoptnonconvexEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_edge_sum(s : MathoptnonconvexEdge) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_edge_mean(s : MathoptnonconvexEdge) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_edge_scale(s : MathoptnonconvexEdge, f : Double) -> MathoptnonconvexEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_edge_add(a : MathoptnonconvexEdge, b : MathoptnonconvexEdge) -> MathoptnonconvexEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_edge_copy(s : MathoptnonconvexEdge) -> MathoptnonconvexEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_edge_fill(s : MathoptnonconvexEdge, v : Double) -> MathoptnonconvexEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_edge_min(s : MathoptnonconvexEdge) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_edge_max(s : MathoptnonconvexEdge) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_edge_to_string(s : MathoptnonconvexEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_path_make(size : Int) -> MathoptnonconvexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_path_len(s : MathoptnonconvexPath) -> Int { s.size }

pub fn math_opt_nonconvex_path_get(s : MathoptnonconvexPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_path_set(s : MathoptnonconvexPath, i : Int, v : Double) -> MathoptnonconvexPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_path_sum(s : MathoptnonconvexPath) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_path_mean(s : MathoptnonconvexPath) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_path_scale(s : MathoptnonconvexPath, f : Double) -> MathoptnonconvexPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_path_add(a : MathoptnonconvexPath, b : MathoptnonconvexPath) -> MathoptnonconvexPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_path_copy(s : MathoptnonconvexPath) -> MathoptnonconvexPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_path_fill(s : MathoptnonconvexPath, v : Double) -> MathoptnonconvexPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_path_min(s : MathoptnonconvexPath) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_path_max(s : MathoptnonconvexPath) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_path_to_string(s : MathoptnonconvexPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_cluster_make(size : Int) -> MathoptnonconvexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_cluster_len(s : MathoptnonconvexCluster) -> Int { s.size }

pub fn math_opt_nonconvex_cluster_get(s : MathoptnonconvexCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_cluster_set(s : MathoptnonconvexCluster, i : Int, v : Double) -> MathoptnonconvexCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_cluster_sum(s : MathoptnonconvexCluster) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_cluster_mean(s : MathoptnonconvexCluster) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_cluster_scale(s : MathoptnonconvexCluster, f : Double) -> MathoptnonconvexCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_cluster_add(a : MathoptnonconvexCluster, b : MathoptnonconvexCluster) -> MathoptnonconvexCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_cluster_copy(s : MathoptnonconvexCluster) -> MathoptnonconvexCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_cluster_fill(s : MathoptnonconvexCluster, v : Double) -> MathoptnonconvexCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_cluster_min(s : MathoptnonconvexCluster) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_cluster_max(s : MathoptnonconvexCluster) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_cluster_to_string(s : MathoptnonconvexCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_model_make(size : Int) -> MathoptnonconvexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_model_len(s : MathoptnonconvexModel) -> Int { s.size }

pub fn math_opt_nonconvex_model_get(s : MathoptnonconvexModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_model_set(s : MathoptnonconvexModel, i : Int, v : Double) -> MathoptnonconvexModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_model_sum(s : MathoptnonconvexModel) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_model_mean(s : MathoptnonconvexModel) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_model_scale(s : MathoptnonconvexModel, f : Double) -> MathoptnonconvexModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_model_add(a : MathoptnonconvexModel, b : MathoptnonconvexModel) -> MathoptnonconvexModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_model_copy(s : MathoptnonconvexModel) -> MathoptnonconvexModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_model_fill(s : MathoptnonconvexModel, v : Double) -> MathoptnonconvexModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_model_min(s : MathoptnonconvexModel) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_model_max(s : MathoptnonconvexModel) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_model_to_string(s : MathoptnonconvexModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_layer_make(size : Int) -> MathoptnonconvexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_layer_len(s : MathoptnonconvexLayer) -> Int { s.size }

pub fn math_opt_nonconvex_layer_get(s : MathoptnonconvexLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_layer_set(s : MathoptnonconvexLayer, i : Int, v : Double) -> MathoptnonconvexLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_layer_sum(s : MathoptnonconvexLayer) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_layer_mean(s : MathoptnonconvexLayer) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_layer_scale(s : MathoptnonconvexLayer, f : Double) -> MathoptnonconvexLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_layer_add(a : MathoptnonconvexLayer, b : MathoptnonconvexLayer) -> MathoptnonconvexLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_layer_copy(s : MathoptnonconvexLayer) -> MathoptnonconvexLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_layer_fill(s : MathoptnonconvexLayer, v : Double) -> MathoptnonconvexLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_layer_min(s : MathoptnonconvexLayer) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_layer_max(s : MathoptnonconvexLayer) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_layer_to_string(s : MathoptnonconvexLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_buffer_make(size : Int) -> MathoptnonconvexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_buffer_len(s : MathoptnonconvexBuffer) -> Int { s.size }

pub fn math_opt_nonconvex_buffer_get(s : MathoptnonconvexBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_buffer_set(s : MathoptnonconvexBuffer, i : Int, v : Double) -> MathoptnonconvexBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_buffer_sum(s : MathoptnonconvexBuffer) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_buffer_mean(s : MathoptnonconvexBuffer) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_buffer_scale(s : MathoptnonconvexBuffer, f : Double) -> MathoptnonconvexBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_buffer_add(a : MathoptnonconvexBuffer, b : MathoptnonconvexBuffer) -> MathoptnonconvexBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_buffer_copy(s : MathoptnonconvexBuffer) -> MathoptnonconvexBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_buffer_fill(s : MathoptnonconvexBuffer, v : Double) -> MathoptnonconvexBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_buffer_min(s : MathoptnonconvexBuffer) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_buffer_max(s : MathoptnonconvexBuffer) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_buffer_to_string(s : MathoptnonconvexBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_cursor_make(size : Int) -> MathoptnonconvexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_cursor_len(s : MathoptnonconvexCursor) -> Int { s.size }

pub fn math_opt_nonconvex_cursor_get(s : MathoptnonconvexCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_cursor_set(s : MathoptnonconvexCursor, i : Int, v : Double) -> MathoptnonconvexCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_cursor_sum(s : MathoptnonconvexCursor) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_cursor_mean(s : MathoptnonconvexCursor) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_cursor_scale(s : MathoptnonconvexCursor, f : Double) -> MathoptnonconvexCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_cursor_add(a : MathoptnonconvexCursor, b : MathoptnonconvexCursor) -> MathoptnonconvexCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_cursor_copy(s : MathoptnonconvexCursor) -> MathoptnonconvexCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_cursor_fill(s : MathoptnonconvexCursor, v : Double) -> MathoptnonconvexCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_cursor_min(s : MathoptnonconvexCursor) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_cursor_max(s : MathoptnonconvexCursor) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_cursor_to_string(s : MathoptnonconvexCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_view_make(size : Int) -> MathoptnonconvexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_view_len(s : MathoptnonconvexView) -> Int { s.size }

pub fn math_opt_nonconvex_view_get(s : MathoptnonconvexView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_view_set(s : MathoptnonconvexView, i : Int, v : Double) -> MathoptnonconvexView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_view_sum(s : MathoptnonconvexView) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_view_mean(s : MathoptnonconvexView) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_view_scale(s : MathoptnonconvexView, f : Double) -> MathoptnonconvexView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_view_add(a : MathoptnonconvexView, b : MathoptnonconvexView) -> MathoptnonconvexView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_view_copy(s : MathoptnonconvexView) -> MathoptnonconvexView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_view_fill(s : MathoptnonconvexView, v : Double) -> MathoptnonconvexView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_view_min(s : MathoptnonconvexView) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_view_max(s : MathoptnonconvexView) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_view_to_string(s : MathoptnonconvexView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_range_make(size : Int) -> MathoptnonconvexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_range_len(s : MathoptnonconvexRange) -> Int { s.size }

pub fn math_opt_nonconvex_range_get(s : MathoptnonconvexRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_range_set(s : MathoptnonconvexRange, i : Int, v : Double) -> MathoptnonconvexRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_range_sum(s : MathoptnonconvexRange) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_range_mean(s : MathoptnonconvexRange) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_range_scale(s : MathoptnonconvexRange, f : Double) -> MathoptnonconvexRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_range_add(a : MathoptnonconvexRange, b : MathoptnonconvexRange) -> MathoptnonconvexRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_range_copy(s : MathoptnonconvexRange) -> MathoptnonconvexRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_range_fill(s : MathoptnonconvexRange, v : Double) -> MathoptnonconvexRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_range_min(s : MathoptnonconvexRange) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_range_max(s : MathoptnonconvexRange) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_range_to_string(s : MathoptnonconvexRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_slice_make(size : Int) -> MathoptnonconvexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_nonconvex_slice_len(s : MathoptnonconvexSlice) -> Int { s.size }

pub fn math_opt_nonconvex_slice_get(s : MathoptnonconvexSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_nonconvex_slice_set(s : MathoptnonconvexSlice, i : Int, v : Double) -> MathoptnonconvexSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_slice_sum(s : MathoptnonconvexSlice) -> Double { @_common.sum(s.data) }

pub fn math_opt_nonconvex_slice_mean(s : MathoptnonconvexSlice) -> Double { @_common.mean(s.data) }

pub fn math_opt_nonconvex_slice_scale(s : MathoptnonconvexSlice, f : Double) -> MathoptnonconvexSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_slice_add(a : MathoptnonconvexSlice, b : MathoptnonconvexSlice) -> MathoptnonconvexSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_nonconvex_slice_copy(s : MathoptnonconvexSlice) -> MathoptnonconvexSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_slice_fill(s : MathoptnonconvexSlice, v : Double) -> MathoptnonconvexSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_nonconvex_slice_min(s : MathoptnonconvexSlice) -> Double { @_common.min(s.data) }

pub fn math_opt_nonconvex_slice_max(s : MathoptnonconvexSlice) -> Double { @_common.max(s.data) }

pub fn math_opt_nonconvex_slice_to_string(s : MathoptnonconvexSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

