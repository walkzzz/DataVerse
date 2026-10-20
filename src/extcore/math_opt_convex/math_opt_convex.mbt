///===
/// extcore/math_opt_convex

pub(all) struct MathoptconvexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_opt_convex_make_point(x : Double, y : Double) -> MathoptconvexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_opt_convex_make_point3(x : Double, y : Double, z : Double) -> MathoptconvexPoint {
  { x, y, z, label: 0 }
}

pub fn MathoptconvexPoint::x(self : MathoptconvexPoint) -> Double { self.x }

pub fn MathoptconvexPoint::y(self : MathoptconvexPoint) -> Double { self.y }

pub fn MathoptconvexPoint::z(self : MathoptconvexPoint) -> Double { self.z }

pub fn MathoptconvexPoint::label(self : MathoptconvexPoint) -> Int { self.label }

pub fn MathoptconvexPoint::dist(self : MathoptconvexPoint, other : MathoptconvexPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathoptconvexPoint::add(self : MathoptconvexPoint, other : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathoptconvexPoint::sub(self : MathoptconvexPoint, other : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathoptconvexPoint::scale(self : MathoptconvexPoint, s : Double) -> MathoptconvexPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathoptconvexPoint::dot(self : MathoptconvexPoint, other : MathoptconvexPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathoptconvexPoint::cross(self : MathoptconvexPoint, other : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathoptconvexPoint::norm(self : MathoptconvexPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathoptconvexPoint::normalize(self : MathoptconvexPoint) -> MathoptconvexPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathoptconvexPoint::negate(self : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathoptconvexPoint::mid(self : MathoptconvexPoint, other : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathoptconvexPoint::lerp(self : MathoptconvexPoint, other : MathoptconvexPoint, t : Double) -> MathoptconvexPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathoptconvexPoint::to_string(self : MathoptconvexPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathoptconvexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_opt_convex_make_series(vals : Array[Double], name : String) -> MathoptconvexSeries {
  { vals, name, meta: 0 }
}

pub fn MathoptconvexSeries::len(self : MathoptconvexSeries) -> Int { self.vals.length() }

pub fn MathoptconvexSeries::sum(self : MathoptconvexSeries) -> Double { @_common.sum(self.vals) }

pub fn MathoptconvexSeries::mean(self : MathoptconvexSeries) -> Double { @_common.mean(self.vals) }

pub fn MathoptconvexSeries::min(self : MathoptconvexSeries) -> Double { @_common.min(self.vals) }

pub fn MathoptconvexSeries::max(self : MathoptconvexSeries) -> Double { @_common.max(self.vals) }

pub fn MathoptconvexSeries::range(self : MathoptconvexSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathoptconvexSeries::variance(self : MathoptconvexSeries) -> Double { @_common.variance(self.vals) }

pub fn MathoptconvexSeries::std(self : MathoptconvexSeries) -> Double { @_common.std(self.vals) }

pub fn MathoptconvexSeries::median(self : MathoptconvexSeries) -> Double { @_common.median(self.vals) }

pub fn MathoptconvexSeries::scale(self : MathoptconvexSeries, f : Double) -> MathoptconvexSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathoptconvexSeries::add(self : MathoptconvexSeries, other : MathoptconvexSeries) -> MathoptconvexSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathoptconvexSeries::sub(self : MathoptconvexSeries, other : MathoptconvexSeries) -> MathoptconvexSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathoptconvexSeries::normalize(self : MathoptconvexSeries) -> MathoptconvexSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathoptconvexSeries::cumsum(self : MathoptconvexSeries) -> MathoptconvexSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathoptconvexSeries::to_string(self : MathoptconvexSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathoptconvexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_opt_convex_make_matrix(rows : Int, cols : Int, val : Double) -> MathoptconvexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_opt_convex_matrix_identity(n : Int) -> MathoptconvexMatrix {
  let m = math_opt_convex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathoptconvexMatrix::get(self : MathoptconvexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathoptconvexMatrix::transpose(self : MathoptconvexMatrix) -> MathoptconvexMatrix {
  let result = math_opt_convex_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathoptconvexMatrix::add(self : MathoptconvexMatrix, other : MathoptconvexMatrix) -> MathoptconvexMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_opt_convex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathoptconvexMatrix::scale(self : MathoptconvexMatrix, s : Double) -> MathoptconvexMatrix {
  let result = math_opt_convex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathoptconvexMatrix::multiply(self : MathoptconvexMatrix, other : MathoptconvexMatrix) -> MathoptconvexMatrix {
  if self.cols != other.rows { return math_opt_convex_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_opt_convex_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathoptconvexMatrix::trace(self : MathoptconvexMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathoptconvexMatrix::det(self : MathoptconvexMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathoptconvexMatrix::norm(self : MathoptconvexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathoptconvexMatrix::to_string(self : MathoptconvexMatrix) -> String {
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

pub(all) struct MathoptconvexVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_opt_convex_make_vector(comps : Array[Double]) -> MathoptconvexVector {
  { comps, dim: comps.length() }
}

pub fn math_opt_convex_vector_zero(dim : Int) -> MathoptconvexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathoptconvexVector::add(self : MathoptconvexVector, other : MathoptconvexVector) -> MathoptconvexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathoptconvexVector::sub(self : MathoptconvexVector, other : MathoptconvexVector) -> MathoptconvexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathoptconvexVector::scale(self : MathoptconvexVector, s : Double) -> MathoptconvexVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathoptconvexVector::dot(self : MathoptconvexVector, other : MathoptconvexVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathoptconvexVector::norm(self : MathoptconvexVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathoptconvexVector::normalize(self : MathoptconvexVector) -> MathoptconvexVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathoptconvexVector::dist(self : MathoptconvexVector, other : MathoptconvexVector) -> Double {
  self.sub(other).norm()
}

pub fn MathoptconvexVector::to_string(self : MathoptconvexVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_opt_convex_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_opt_convex_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_opt_convex_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_opt_convex_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_opt_convex_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_opt_convex_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_opt_convex_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_opt_convex_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_opt_convex_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_opt_convex_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_opt_convex_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_opt_convex_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_opt_convex_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_opt_convex_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_opt_convex_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_opt_convex_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_opt_convex_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_opt_convex_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_opt_convex_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_opt_convex_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_opt_convex_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_opt_convex_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_opt_convex_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_opt_convex_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_opt_convex_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_opt_convex_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_opt_convex_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_opt_convex_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_opt_convex_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathoptconvexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_frame_make(size : Int) -> MathoptconvexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_frame_len(s : MathoptconvexFrame) -> Int { s.size }

pub fn math_opt_convex_frame_get(s : MathoptconvexFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_frame_set(s : MathoptconvexFrame, i : Int, v : Double) -> MathoptconvexFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_frame_sum(s : MathoptconvexFrame) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_frame_mean(s : MathoptconvexFrame) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_frame_scale(s : MathoptconvexFrame, f : Double) -> MathoptconvexFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_frame_add(a : MathoptconvexFrame, b : MathoptconvexFrame) -> MathoptconvexFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_frame_copy(s : MathoptconvexFrame) -> MathoptconvexFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_frame_fill(s : MathoptconvexFrame, v : Double) -> MathoptconvexFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_frame_min(s : MathoptconvexFrame) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_frame_max(s : MathoptconvexFrame) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_frame_to_string(s : MathoptconvexFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_table_make(size : Int) -> MathoptconvexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_table_len(s : MathoptconvexTable) -> Int { s.size }

pub fn math_opt_convex_table_get(s : MathoptconvexTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_table_set(s : MathoptconvexTable, i : Int, v : Double) -> MathoptconvexTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_table_sum(s : MathoptconvexTable) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_table_mean(s : MathoptconvexTable) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_table_scale(s : MathoptconvexTable, f : Double) -> MathoptconvexTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_table_add(a : MathoptconvexTable, b : MathoptconvexTable) -> MathoptconvexTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_table_copy(s : MathoptconvexTable) -> MathoptconvexTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_table_fill(s : MathoptconvexTable, v : Double) -> MathoptconvexTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_table_min(s : MathoptconvexTable) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_table_max(s : MathoptconvexTable) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_table_to_string(s : MathoptconvexTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_graphn_make(size : Int) -> MathoptconvexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_graphn_len(s : MathoptconvexGraphN) -> Int { s.size }

pub fn math_opt_convex_graphn_get(s : MathoptconvexGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_graphn_set(s : MathoptconvexGraphN, i : Int, v : Double) -> MathoptconvexGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_graphn_sum(s : MathoptconvexGraphN) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_graphn_mean(s : MathoptconvexGraphN) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_graphn_scale(s : MathoptconvexGraphN, f : Double) -> MathoptconvexGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_graphn_add(a : MathoptconvexGraphN, b : MathoptconvexGraphN) -> MathoptconvexGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_graphn_copy(s : MathoptconvexGraphN) -> MathoptconvexGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_graphn_fill(s : MathoptconvexGraphN, v : Double) -> MathoptconvexGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_graphn_min(s : MathoptconvexGraphN) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_graphn_max(s : MathoptconvexGraphN) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_graphn_to_string(s : MathoptconvexGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_node_make(size : Int) -> MathoptconvexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_node_len(s : MathoptconvexNode) -> Int { s.size }

pub fn math_opt_convex_node_get(s : MathoptconvexNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_node_set(s : MathoptconvexNode, i : Int, v : Double) -> MathoptconvexNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_node_sum(s : MathoptconvexNode) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_node_mean(s : MathoptconvexNode) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_node_scale(s : MathoptconvexNode, f : Double) -> MathoptconvexNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_node_add(a : MathoptconvexNode, b : MathoptconvexNode) -> MathoptconvexNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_node_copy(s : MathoptconvexNode) -> MathoptconvexNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_node_fill(s : MathoptconvexNode, v : Double) -> MathoptconvexNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_node_min(s : MathoptconvexNode) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_node_max(s : MathoptconvexNode) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_node_to_string(s : MathoptconvexNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_edge_make(size : Int) -> MathoptconvexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_edge_len(s : MathoptconvexEdge) -> Int { s.size }

pub fn math_opt_convex_edge_get(s : MathoptconvexEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_edge_set(s : MathoptconvexEdge, i : Int, v : Double) -> MathoptconvexEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_edge_sum(s : MathoptconvexEdge) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_edge_mean(s : MathoptconvexEdge) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_edge_scale(s : MathoptconvexEdge, f : Double) -> MathoptconvexEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_edge_add(a : MathoptconvexEdge, b : MathoptconvexEdge) -> MathoptconvexEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_edge_copy(s : MathoptconvexEdge) -> MathoptconvexEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_edge_fill(s : MathoptconvexEdge, v : Double) -> MathoptconvexEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_edge_min(s : MathoptconvexEdge) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_edge_max(s : MathoptconvexEdge) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_edge_to_string(s : MathoptconvexEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_path_make(size : Int) -> MathoptconvexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_path_len(s : MathoptconvexPath) -> Int { s.size }

pub fn math_opt_convex_path_get(s : MathoptconvexPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_path_set(s : MathoptconvexPath, i : Int, v : Double) -> MathoptconvexPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_path_sum(s : MathoptconvexPath) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_path_mean(s : MathoptconvexPath) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_path_scale(s : MathoptconvexPath, f : Double) -> MathoptconvexPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_path_add(a : MathoptconvexPath, b : MathoptconvexPath) -> MathoptconvexPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_path_copy(s : MathoptconvexPath) -> MathoptconvexPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_path_fill(s : MathoptconvexPath, v : Double) -> MathoptconvexPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_path_min(s : MathoptconvexPath) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_path_max(s : MathoptconvexPath) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_path_to_string(s : MathoptconvexPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_cluster_make(size : Int) -> MathoptconvexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_cluster_len(s : MathoptconvexCluster) -> Int { s.size }

pub fn math_opt_convex_cluster_get(s : MathoptconvexCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_cluster_set(s : MathoptconvexCluster, i : Int, v : Double) -> MathoptconvexCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_cluster_sum(s : MathoptconvexCluster) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_cluster_mean(s : MathoptconvexCluster) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_cluster_scale(s : MathoptconvexCluster, f : Double) -> MathoptconvexCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_cluster_add(a : MathoptconvexCluster, b : MathoptconvexCluster) -> MathoptconvexCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_cluster_copy(s : MathoptconvexCluster) -> MathoptconvexCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_cluster_fill(s : MathoptconvexCluster, v : Double) -> MathoptconvexCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_cluster_min(s : MathoptconvexCluster) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_cluster_max(s : MathoptconvexCluster) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_cluster_to_string(s : MathoptconvexCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_model_make(size : Int) -> MathoptconvexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_model_len(s : MathoptconvexModel) -> Int { s.size }

pub fn math_opt_convex_model_get(s : MathoptconvexModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_model_set(s : MathoptconvexModel, i : Int, v : Double) -> MathoptconvexModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_model_sum(s : MathoptconvexModel) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_model_mean(s : MathoptconvexModel) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_model_scale(s : MathoptconvexModel, f : Double) -> MathoptconvexModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_model_add(a : MathoptconvexModel, b : MathoptconvexModel) -> MathoptconvexModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_model_copy(s : MathoptconvexModel) -> MathoptconvexModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_model_fill(s : MathoptconvexModel, v : Double) -> MathoptconvexModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_model_min(s : MathoptconvexModel) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_model_max(s : MathoptconvexModel) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_model_to_string(s : MathoptconvexModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_layer_make(size : Int) -> MathoptconvexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_layer_len(s : MathoptconvexLayer) -> Int { s.size }

pub fn math_opt_convex_layer_get(s : MathoptconvexLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_layer_set(s : MathoptconvexLayer, i : Int, v : Double) -> MathoptconvexLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_layer_sum(s : MathoptconvexLayer) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_layer_mean(s : MathoptconvexLayer) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_layer_scale(s : MathoptconvexLayer, f : Double) -> MathoptconvexLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_layer_add(a : MathoptconvexLayer, b : MathoptconvexLayer) -> MathoptconvexLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_layer_copy(s : MathoptconvexLayer) -> MathoptconvexLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_layer_fill(s : MathoptconvexLayer, v : Double) -> MathoptconvexLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_layer_min(s : MathoptconvexLayer) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_layer_max(s : MathoptconvexLayer) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_layer_to_string(s : MathoptconvexLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_buffer_make(size : Int) -> MathoptconvexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_buffer_len(s : MathoptconvexBuffer) -> Int { s.size }

pub fn math_opt_convex_buffer_get(s : MathoptconvexBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_buffer_set(s : MathoptconvexBuffer, i : Int, v : Double) -> MathoptconvexBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_buffer_sum(s : MathoptconvexBuffer) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_buffer_mean(s : MathoptconvexBuffer) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_buffer_scale(s : MathoptconvexBuffer, f : Double) -> MathoptconvexBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_buffer_add(a : MathoptconvexBuffer, b : MathoptconvexBuffer) -> MathoptconvexBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_buffer_copy(s : MathoptconvexBuffer) -> MathoptconvexBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_buffer_fill(s : MathoptconvexBuffer, v : Double) -> MathoptconvexBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_buffer_min(s : MathoptconvexBuffer) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_buffer_max(s : MathoptconvexBuffer) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_buffer_to_string(s : MathoptconvexBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_cursor_make(size : Int) -> MathoptconvexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_cursor_len(s : MathoptconvexCursor) -> Int { s.size }

pub fn math_opt_convex_cursor_get(s : MathoptconvexCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_cursor_set(s : MathoptconvexCursor, i : Int, v : Double) -> MathoptconvexCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_cursor_sum(s : MathoptconvexCursor) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_cursor_mean(s : MathoptconvexCursor) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_cursor_scale(s : MathoptconvexCursor, f : Double) -> MathoptconvexCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_cursor_add(a : MathoptconvexCursor, b : MathoptconvexCursor) -> MathoptconvexCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_cursor_copy(s : MathoptconvexCursor) -> MathoptconvexCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_cursor_fill(s : MathoptconvexCursor, v : Double) -> MathoptconvexCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_cursor_min(s : MathoptconvexCursor) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_cursor_max(s : MathoptconvexCursor) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_cursor_to_string(s : MathoptconvexCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_view_make(size : Int) -> MathoptconvexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_view_len(s : MathoptconvexView) -> Int { s.size }

pub fn math_opt_convex_view_get(s : MathoptconvexView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_view_set(s : MathoptconvexView, i : Int, v : Double) -> MathoptconvexView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_view_sum(s : MathoptconvexView) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_view_mean(s : MathoptconvexView) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_view_scale(s : MathoptconvexView, f : Double) -> MathoptconvexView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_view_add(a : MathoptconvexView, b : MathoptconvexView) -> MathoptconvexView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_view_copy(s : MathoptconvexView) -> MathoptconvexView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_view_fill(s : MathoptconvexView, v : Double) -> MathoptconvexView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_view_min(s : MathoptconvexView) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_view_max(s : MathoptconvexView) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_view_to_string(s : MathoptconvexView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_range_make(size : Int) -> MathoptconvexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_range_len(s : MathoptconvexRange) -> Int { s.size }

pub fn math_opt_convex_range_get(s : MathoptconvexRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_range_set(s : MathoptconvexRange, i : Int, v : Double) -> MathoptconvexRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_range_sum(s : MathoptconvexRange) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_range_mean(s : MathoptconvexRange) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_range_scale(s : MathoptconvexRange, f : Double) -> MathoptconvexRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_range_add(a : MathoptconvexRange, b : MathoptconvexRange) -> MathoptconvexRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_range_copy(s : MathoptconvexRange) -> MathoptconvexRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_range_fill(s : MathoptconvexRange, v : Double) -> MathoptconvexRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_range_min(s : MathoptconvexRange) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_range_max(s : MathoptconvexRange) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_range_to_string(s : MathoptconvexRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_slice_make(size : Int) -> MathoptconvexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_slice_len(s : MathoptconvexSlice) -> Int { s.size }

pub fn math_opt_convex_slice_get(s : MathoptconvexSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_slice_set(s : MathoptconvexSlice, i : Int, v : Double) -> MathoptconvexSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_opt_convex_slice_sum(s : MathoptconvexSlice) -> Double { @_common.sum(s.data) }

pub fn math_opt_convex_slice_mean(s : MathoptconvexSlice) -> Double { @_common.mean(s.data) }

pub fn math_opt_convex_slice_scale(s : MathoptconvexSlice, f : Double) -> MathoptconvexSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_slice_add(a : MathoptconvexSlice, b : MathoptconvexSlice) -> MathoptconvexSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_opt_convex_slice_copy(s : MathoptconvexSlice) -> MathoptconvexSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_slice_fill(s : MathoptconvexSlice, v : Double) -> MathoptconvexSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_opt_convex_slice_min(s : MathoptconvexSlice) -> Double { @_common.min(s.data) }

pub fn math_opt_convex_slice_max(s : MathoptconvexSlice) -> Double { @_common.max(s.data) }

pub fn math_opt_convex_slice_to_string(s : MathoptconvexSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

