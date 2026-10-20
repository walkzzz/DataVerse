///===
/// extcore/math_integer_prog

pub(all) struct MathintegerprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_integer_prog_make_point(x : Double, y : Double) -> MathintegerprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_integer_prog_make_point3(x : Double, y : Double, z : Double) -> MathintegerprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathintegerprogPoint::x(self : MathintegerprogPoint) -> Double { self.x }

pub fn MathintegerprogPoint::y(self : MathintegerprogPoint) -> Double { self.y }

pub fn MathintegerprogPoint::z(self : MathintegerprogPoint) -> Double { self.z }

pub fn MathintegerprogPoint::label(self : MathintegerprogPoint) -> Int { self.label }

pub fn MathintegerprogPoint::dist(self : MathintegerprogPoint, other : MathintegerprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathintegerprogPoint::add(self : MathintegerprogPoint, other : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathintegerprogPoint::sub(self : MathintegerprogPoint, other : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathintegerprogPoint::scale(self : MathintegerprogPoint, s : Double) -> MathintegerprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathintegerprogPoint::dot(self : MathintegerprogPoint, other : MathintegerprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathintegerprogPoint::cross(self : MathintegerprogPoint, other : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathintegerprogPoint::norm(self : MathintegerprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathintegerprogPoint::normalize(self : MathintegerprogPoint) -> MathintegerprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathintegerprogPoint::negate(self : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathintegerprogPoint::mid(self : MathintegerprogPoint, other : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathintegerprogPoint::lerp(self : MathintegerprogPoint, other : MathintegerprogPoint, t : Double) -> MathintegerprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathintegerprogPoint::to_string(self : MathintegerprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathintegerprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_integer_prog_make_series(vals : Array[Double], name : String) -> MathintegerprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathintegerprogSeries::len(self : MathintegerprogSeries) -> Int { self.vals.length() }

pub fn MathintegerprogSeries::sum(self : MathintegerprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathintegerprogSeries::mean(self : MathintegerprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathintegerprogSeries::min(self : MathintegerprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathintegerprogSeries::max(self : MathintegerprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathintegerprogSeries::range(self : MathintegerprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathintegerprogSeries::variance(self : MathintegerprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathintegerprogSeries::std(self : MathintegerprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathintegerprogSeries::median(self : MathintegerprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathintegerprogSeries::scale(self : MathintegerprogSeries, f : Double) -> MathintegerprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathintegerprogSeries::add(self : MathintegerprogSeries, other : MathintegerprogSeries) -> MathintegerprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathintegerprogSeries::sub(self : MathintegerprogSeries, other : MathintegerprogSeries) -> MathintegerprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathintegerprogSeries::normalize(self : MathintegerprogSeries) -> MathintegerprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathintegerprogSeries::cumsum(self : MathintegerprogSeries) -> MathintegerprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathintegerprogSeries::to_string(self : MathintegerprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathintegerprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_integer_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathintegerprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_integer_prog_matrix_identity(n : Int) -> MathintegerprogMatrix {
  let m = math_integer_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathintegerprogMatrix::get(self : MathintegerprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathintegerprogMatrix::transpose(self : MathintegerprogMatrix) -> MathintegerprogMatrix {
  let result = math_integer_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathintegerprogMatrix::add(self : MathintegerprogMatrix, other : MathintegerprogMatrix) -> MathintegerprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_integer_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathintegerprogMatrix::scale(self : MathintegerprogMatrix, s : Double) -> MathintegerprogMatrix {
  let result = math_integer_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathintegerprogMatrix::multiply(self : MathintegerprogMatrix, other : MathintegerprogMatrix) -> MathintegerprogMatrix {
  if self.cols != other.rows { return math_integer_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_integer_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathintegerprogMatrix::trace(self : MathintegerprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathintegerprogMatrix::det(self : MathintegerprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathintegerprogMatrix::norm(self : MathintegerprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathintegerprogMatrix::to_string(self : MathintegerprogMatrix) -> String {
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

pub(all) struct MathintegerprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_integer_prog_make_vector(comps : Array[Double]) -> MathintegerprogVector {
  { comps, dim: comps.length() }
}

pub fn math_integer_prog_vector_zero(dim : Int) -> MathintegerprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathintegerprogVector::add(self : MathintegerprogVector, other : MathintegerprogVector) -> MathintegerprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathintegerprogVector::sub(self : MathintegerprogVector, other : MathintegerprogVector) -> MathintegerprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathintegerprogVector::scale(self : MathintegerprogVector, s : Double) -> MathintegerprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathintegerprogVector::dot(self : MathintegerprogVector, other : MathintegerprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathintegerprogVector::norm(self : MathintegerprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathintegerprogVector::normalize(self : MathintegerprogVector) -> MathintegerprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathintegerprogVector::dist(self : MathintegerprogVector, other : MathintegerprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathintegerprogVector::to_string(self : MathintegerprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_integer_prog_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_integer_prog_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_integer_prog_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_integer_prog_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_integer_prog_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_integer_prog_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_integer_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_integer_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_integer_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_integer_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_integer_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_integer_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_integer_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_integer_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_integer_prog_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_integer_prog_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_integer_prog_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_integer_prog_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_integer_prog_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_integer_prog_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_integer_prog_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_integer_prog_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_integer_prog_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_integer_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_integer_prog_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_integer_prog_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_integer_prog_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_integer_prog_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_integer_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathintegerprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_frame_make(size : Int) -> MathintegerprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_frame_len(s : MathintegerprogFrame) -> Int { s.size }

pub fn math_integer_prog_frame_get(s : MathintegerprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_frame_set(s : MathintegerprogFrame, i : Int, v : Double) -> MathintegerprogFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_frame_sum(s : MathintegerprogFrame) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_frame_mean(s : MathintegerprogFrame) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_frame_scale(s : MathintegerprogFrame, f : Double) -> MathintegerprogFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_frame_add(a : MathintegerprogFrame, b : MathintegerprogFrame) -> MathintegerprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_frame_copy(s : MathintegerprogFrame) -> MathintegerprogFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_frame_fill(s : MathintegerprogFrame, v : Double) -> MathintegerprogFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_frame_min(s : MathintegerprogFrame) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_frame_max(s : MathintegerprogFrame) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_frame_to_string(s : MathintegerprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_table_make(size : Int) -> MathintegerprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_table_len(s : MathintegerprogTable) -> Int { s.size }

pub fn math_integer_prog_table_get(s : MathintegerprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_table_set(s : MathintegerprogTable, i : Int, v : Double) -> MathintegerprogTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_table_sum(s : MathintegerprogTable) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_table_mean(s : MathintegerprogTable) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_table_scale(s : MathintegerprogTable, f : Double) -> MathintegerprogTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_table_add(a : MathintegerprogTable, b : MathintegerprogTable) -> MathintegerprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_table_copy(s : MathintegerprogTable) -> MathintegerprogTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_table_fill(s : MathintegerprogTable, v : Double) -> MathintegerprogTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_table_min(s : MathintegerprogTable) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_table_max(s : MathintegerprogTable) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_table_to_string(s : MathintegerprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_graphn_make(size : Int) -> MathintegerprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_graphn_len(s : MathintegerprogGraphN) -> Int { s.size }

pub fn math_integer_prog_graphn_get(s : MathintegerprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_graphn_set(s : MathintegerprogGraphN, i : Int, v : Double) -> MathintegerprogGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_graphn_sum(s : MathintegerprogGraphN) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_graphn_mean(s : MathintegerprogGraphN) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_graphn_scale(s : MathintegerprogGraphN, f : Double) -> MathintegerprogGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_graphn_add(a : MathintegerprogGraphN, b : MathintegerprogGraphN) -> MathintegerprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_graphn_copy(s : MathintegerprogGraphN) -> MathintegerprogGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_graphn_fill(s : MathintegerprogGraphN, v : Double) -> MathintegerprogGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_graphn_min(s : MathintegerprogGraphN) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_graphn_max(s : MathintegerprogGraphN) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_graphn_to_string(s : MathintegerprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_node_make(size : Int) -> MathintegerprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_node_len(s : MathintegerprogNode) -> Int { s.size }

pub fn math_integer_prog_node_get(s : MathintegerprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_node_set(s : MathintegerprogNode, i : Int, v : Double) -> MathintegerprogNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_node_sum(s : MathintegerprogNode) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_node_mean(s : MathintegerprogNode) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_node_scale(s : MathintegerprogNode, f : Double) -> MathintegerprogNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_node_add(a : MathintegerprogNode, b : MathintegerprogNode) -> MathintegerprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_node_copy(s : MathintegerprogNode) -> MathintegerprogNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_node_fill(s : MathintegerprogNode, v : Double) -> MathintegerprogNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_node_min(s : MathintegerprogNode) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_node_max(s : MathintegerprogNode) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_node_to_string(s : MathintegerprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_edge_make(size : Int) -> MathintegerprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_edge_len(s : MathintegerprogEdge) -> Int { s.size }

pub fn math_integer_prog_edge_get(s : MathintegerprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_edge_set(s : MathintegerprogEdge, i : Int, v : Double) -> MathintegerprogEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_edge_sum(s : MathintegerprogEdge) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_edge_mean(s : MathintegerprogEdge) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_edge_scale(s : MathintegerprogEdge, f : Double) -> MathintegerprogEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_edge_add(a : MathintegerprogEdge, b : MathintegerprogEdge) -> MathintegerprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_edge_copy(s : MathintegerprogEdge) -> MathintegerprogEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_edge_fill(s : MathintegerprogEdge, v : Double) -> MathintegerprogEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_edge_min(s : MathintegerprogEdge) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_edge_max(s : MathintegerprogEdge) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_edge_to_string(s : MathintegerprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_path_make(size : Int) -> MathintegerprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_path_len(s : MathintegerprogPath) -> Int { s.size }

pub fn math_integer_prog_path_get(s : MathintegerprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_path_set(s : MathintegerprogPath, i : Int, v : Double) -> MathintegerprogPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_path_sum(s : MathintegerprogPath) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_path_mean(s : MathintegerprogPath) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_path_scale(s : MathintegerprogPath, f : Double) -> MathintegerprogPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_path_add(a : MathintegerprogPath, b : MathintegerprogPath) -> MathintegerprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_path_copy(s : MathintegerprogPath) -> MathintegerprogPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_path_fill(s : MathintegerprogPath, v : Double) -> MathintegerprogPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_path_min(s : MathintegerprogPath) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_path_max(s : MathintegerprogPath) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_path_to_string(s : MathintegerprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_cluster_make(size : Int) -> MathintegerprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_cluster_len(s : MathintegerprogCluster) -> Int { s.size }

pub fn math_integer_prog_cluster_get(s : MathintegerprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_cluster_set(s : MathintegerprogCluster, i : Int, v : Double) -> MathintegerprogCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_cluster_sum(s : MathintegerprogCluster) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_cluster_mean(s : MathintegerprogCluster) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_cluster_scale(s : MathintegerprogCluster, f : Double) -> MathintegerprogCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_cluster_add(a : MathintegerprogCluster, b : MathintegerprogCluster) -> MathintegerprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_cluster_copy(s : MathintegerprogCluster) -> MathintegerprogCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_cluster_fill(s : MathintegerprogCluster, v : Double) -> MathintegerprogCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_cluster_min(s : MathintegerprogCluster) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_cluster_max(s : MathintegerprogCluster) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_cluster_to_string(s : MathintegerprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_model_make(size : Int) -> MathintegerprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_model_len(s : MathintegerprogModel) -> Int { s.size }

pub fn math_integer_prog_model_get(s : MathintegerprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_model_set(s : MathintegerprogModel, i : Int, v : Double) -> MathintegerprogModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_model_sum(s : MathintegerprogModel) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_model_mean(s : MathintegerprogModel) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_model_scale(s : MathintegerprogModel, f : Double) -> MathintegerprogModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_model_add(a : MathintegerprogModel, b : MathintegerprogModel) -> MathintegerprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_model_copy(s : MathintegerprogModel) -> MathintegerprogModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_model_fill(s : MathintegerprogModel, v : Double) -> MathintegerprogModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_model_min(s : MathintegerprogModel) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_model_max(s : MathintegerprogModel) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_model_to_string(s : MathintegerprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_layer_make(size : Int) -> MathintegerprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_layer_len(s : MathintegerprogLayer) -> Int { s.size }

pub fn math_integer_prog_layer_get(s : MathintegerprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_layer_set(s : MathintegerprogLayer, i : Int, v : Double) -> MathintegerprogLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_layer_sum(s : MathintegerprogLayer) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_layer_mean(s : MathintegerprogLayer) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_layer_scale(s : MathintegerprogLayer, f : Double) -> MathintegerprogLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_layer_add(a : MathintegerprogLayer, b : MathintegerprogLayer) -> MathintegerprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_layer_copy(s : MathintegerprogLayer) -> MathintegerprogLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_layer_fill(s : MathintegerprogLayer, v : Double) -> MathintegerprogLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_layer_min(s : MathintegerprogLayer) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_layer_max(s : MathintegerprogLayer) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_layer_to_string(s : MathintegerprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_buffer_make(size : Int) -> MathintegerprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_buffer_len(s : MathintegerprogBuffer) -> Int { s.size }

pub fn math_integer_prog_buffer_get(s : MathintegerprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_buffer_set(s : MathintegerprogBuffer, i : Int, v : Double) -> MathintegerprogBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_buffer_sum(s : MathintegerprogBuffer) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_buffer_mean(s : MathintegerprogBuffer) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_buffer_scale(s : MathintegerprogBuffer, f : Double) -> MathintegerprogBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_buffer_add(a : MathintegerprogBuffer, b : MathintegerprogBuffer) -> MathintegerprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_buffer_copy(s : MathintegerprogBuffer) -> MathintegerprogBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_buffer_fill(s : MathintegerprogBuffer, v : Double) -> MathintegerprogBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_buffer_min(s : MathintegerprogBuffer) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_buffer_max(s : MathintegerprogBuffer) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_buffer_to_string(s : MathintegerprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_cursor_make(size : Int) -> MathintegerprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_cursor_len(s : MathintegerprogCursor) -> Int { s.size }

pub fn math_integer_prog_cursor_get(s : MathintegerprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_cursor_set(s : MathintegerprogCursor, i : Int, v : Double) -> MathintegerprogCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_cursor_sum(s : MathintegerprogCursor) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_cursor_mean(s : MathintegerprogCursor) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_cursor_scale(s : MathintegerprogCursor, f : Double) -> MathintegerprogCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_cursor_add(a : MathintegerprogCursor, b : MathintegerprogCursor) -> MathintegerprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_cursor_copy(s : MathintegerprogCursor) -> MathintegerprogCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_cursor_fill(s : MathintegerprogCursor, v : Double) -> MathintegerprogCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_cursor_min(s : MathintegerprogCursor) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_cursor_max(s : MathintegerprogCursor) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_cursor_to_string(s : MathintegerprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_view_make(size : Int) -> MathintegerprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_view_len(s : MathintegerprogView) -> Int { s.size }

pub fn math_integer_prog_view_get(s : MathintegerprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_view_set(s : MathintegerprogView, i : Int, v : Double) -> MathintegerprogView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_view_sum(s : MathintegerprogView) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_view_mean(s : MathintegerprogView) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_view_scale(s : MathintegerprogView, f : Double) -> MathintegerprogView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_view_add(a : MathintegerprogView, b : MathintegerprogView) -> MathintegerprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_view_copy(s : MathintegerprogView) -> MathintegerprogView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_view_fill(s : MathintegerprogView, v : Double) -> MathintegerprogView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_view_min(s : MathintegerprogView) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_view_max(s : MathintegerprogView) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_view_to_string(s : MathintegerprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_range_make(size : Int) -> MathintegerprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_range_len(s : MathintegerprogRange) -> Int { s.size }

pub fn math_integer_prog_range_get(s : MathintegerprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_range_set(s : MathintegerprogRange, i : Int, v : Double) -> MathintegerprogRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_range_sum(s : MathintegerprogRange) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_range_mean(s : MathintegerprogRange) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_range_scale(s : MathintegerprogRange, f : Double) -> MathintegerprogRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_range_add(a : MathintegerprogRange, b : MathintegerprogRange) -> MathintegerprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_range_copy(s : MathintegerprogRange) -> MathintegerprogRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_range_fill(s : MathintegerprogRange, v : Double) -> MathintegerprogRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_range_min(s : MathintegerprogRange) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_range_max(s : MathintegerprogRange) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_range_to_string(s : MathintegerprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_slice_make(size : Int) -> MathintegerprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_slice_len(s : MathintegerprogSlice) -> Int { s.size }

pub fn math_integer_prog_slice_get(s : MathintegerprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_slice_set(s : MathintegerprogSlice, i : Int, v : Double) -> MathintegerprogSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_integer_prog_slice_sum(s : MathintegerprogSlice) -> Double { @_common.sum(s.data) }

pub fn math_integer_prog_slice_mean(s : MathintegerprogSlice) -> Double { @_common.mean(s.data) }

pub fn math_integer_prog_slice_scale(s : MathintegerprogSlice, f : Double) -> MathintegerprogSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_slice_add(a : MathintegerprogSlice, b : MathintegerprogSlice) -> MathintegerprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_integer_prog_slice_copy(s : MathintegerprogSlice) -> MathintegerprogSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_slice_fill(s : MathintegerprogSlice, v : Double) -> MathintegerprogSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_integer_prog_slice_min(s : MathintegerprogSlice) -> Double { @_common.min(s.data) }

pub fn math_integer_prog_slice_max(s : MathintegerprogSlice) -> Double { @_common.max(s.data) }

pub fn math_integer_prog_slice_to_string(s : MathintegerprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

