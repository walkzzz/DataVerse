///===
/// extcore/math_linear_prog

pub(all) struct MathlinearprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_linear_prog_make_point(x : Double, y : Double) -> MathlinearprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_linear_prog_make_point3(x : Double, y : Double, z : Double) -> MathlinearprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathlinearprogPoint::x(self : MathlinearprogPoint) -> Double { self.x }

pub fn MathlinearprogPoint::y(self : MathlinearprogPoint) -> Double { self.y }

pub fn MathlinearprogPoint::z(self : MathlinearprogPoint) -> Double { self.z }

pub fn MathlinearprogPoint::label(self : MathlinearprogPoint) -> Int { self.label }

pub fn MathlinearprogPoint::dist(self : MathlinearprogPoint, other : MathlinearprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathlinearprogPoint::add(self : MathlinearprogPoint, other : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathlinearprogPoint::sub(self : MathlinearprogPoint, other : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathlinearprogPoint::scale(self : MathlinearprogPoint, s : Double) -> MathlinearprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathlinearprogPoint::dot(self : MathlinearprogPoint, other : MathlinearprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathlinearprogPoint::cross(self : MathlinearprogPoint, other : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathlinearprogPoint::norm(self : MathlinearprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathlinearprogPoint::normalize(self : MathlinearprogPoint) -> MathlinearprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathlinearprogPoint::negate(self : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathlinearprogPoint::mid(self : MathlinearprogPoint, other : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathlinearprogPoint::lerp(self : MathlinearprogPoint, other : MathlinearprogPoint, t : Double) -> MathlinearprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathlinearprogPoint::to_string(self : MathlinearprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathlinearprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_linear_prog_make_series(vals : Array[Double], name : String) -> MathlinearprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathlinearprogSeries::len(self : MathlinearprogSeries) -> Int { self.vals.length() }

pub fn MathlinearprogSeries::sum(self : MathlinearprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathlinearprogSeries::mean(self : MathlinearprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathlinearprogSeries::min(self : MathlinearprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathlinearprogSeries::max(self : MathlinearprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathlinearprogSeries::range(self : MathlinearprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathlinearprogSeries::variance(self : MathlinearprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathlinearprogSeries::std(self : MathlinearprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathlinearprogSeries::median(self : MathlinearprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathlinearprogSeries::scale(self : MathlinearprogSeries, f : Double) -> MathlinearprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathlinearprogSeries::add(self : MathlinearprogSeries, other : MathlinearprogSeries) -> MathlinearprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathlinearprogSeries::sub(self : MathlinearprogSeries, other : MathlinearprogSeries) -> MathlinearprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathlinearprogSeries::normalize(self : MathlinearprogSeries) -> MathlinearprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathlinearprogSeries::cumsum(self : MathlinearprogSeries) -> MathlinearprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathlinearprogSeries::to_string(self : MathlinearprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathlinearprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_linear_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathlinearprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_linear_prog_matrix_identity(n : Int) -> MathlinearprogMatrix {
  let m = math_linear_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathlinearprogMatrix::get(self : MathlinearprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathlinearprogMatrix::transpose(self : MathlinearprogMatrix) -> MathlinearprogMatrix {
  let result = math_linear_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathlinearprogMatrix::add(self : MathlinearprogMatrix, other : MathlinearprogMatrix) -> MathlinearprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_linear_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathlinearprogMatrix::scale(self : MathlinearprogMatrix, s : Double) -> MathlinearprogMatrix {
  let result = math_linear_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathlinearprogMatrix::multiply(self : MathlinearprogMatrix, other : MathlinearprogMatrix) -> MathlinearprogMatrix {
  if self.cols != other.rows { return math_linear_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_linear_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathlinearprogMatrix::trace(self : MathlinearprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathlinearprogMatrix::det(self : MathlinearprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathlinearprogMatrix::norm(self : MathlinearprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathlinearprogMatrix::to_string(self : MathlinearprogMatrix) -> String {
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

pub(all) struct MathlinearprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_linear_prog_make_vector(comps : Array[Double]) -> MathlinearprogVector {
  { comps, dim: comps.length() }
}

pub fn math_linear_prog_vector_zero(dim : Int) -> MathlinearprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathlinearprogVector::add(self : MathlinearprogVector, other : MathlinearprogVector) -> MathlinearprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathlinearprogVector::sub(self : MathlinearprogVector, other : MathlinearprogVector) -> MathlinearprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathlinearprogVector::scale(self : MathlinearprogVector, s : Double) -> MathlinearprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathlinearprogVector::dot(self : MathlinearprogVector, other : MathlinearprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathlinearprogVector::norm(self : MathlinearprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathlinearprogVector::normalize(self : MathlinearprogVector) -> MathlinearprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathlinearprogVector::dist(self : MathlinearprogVector, other : MathlinearprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathlinearprogVector::to_string(self : MathlinearprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_linear_prog_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_linear_prog_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_linear_prog_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_linear_prog_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_linear_prog_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_linear_prog_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_linear_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_linear_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_linear_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_linear_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_linear_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_linear_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_linear_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_linear_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_linear_prog_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_linear_prog_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_linear_prog_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_linear_prog_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_linear_prog_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_linear_prog_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_linear_prog_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_linear_prog_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_linear_prog_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_linear_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_linear_prog_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_linear_prog_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_linear_prog_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_linear_prog_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_linear_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathlinearprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_frame_make(size : Int) -> MathlinearprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_frame_len(s : MathlinearprogFrame) -> Int { s.size }

pub fn math_linear_prog_frame_get(s : MathlinearprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_frame_set(s : MathlinearprogFrame, i : Int, v : Double) -> MathlinearprogFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_frame_sum(s : MathlinearprogFrame) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_frame_mean(s : MathlinearprogFrame) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_frame_scale(s : MathlinearprogFrame, f : Double) -> MathlinearprogFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_frame_add(a : MathlinearprogFrame, b : MathlinearprogFrame) -> MathlinearprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_frame_copy(s : MathlinearprogFrame) -> MathlinearprogFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_frame_fill(s : MathlinearprogFrame, v : Double) -> MathlinearprogFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_frame_min(s : MathlinearprogFrame) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_frame_max(s : MathlinearprogFrame) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_frame_to_string(s : MathlinearprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_table_make(size : Int) -> MathlinearprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_table_len(s : MathlinearprogTable) -> Int { s.size }

pub fn math_linear_prog_table_get(s : MathlinearprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_table_set(s : MathlinearprogTable, i : Int, v : Double) -> MathlinearprogTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_table_sum(s : MathlinearprogTable) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_table_mean(s : MathlinearprogTable) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_table_scale(s : MathlinearprogTable, f : Double) -> MathlinearprogTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_table_add(a : MathlinearprogTable, b : MathlinearprogTable) -> MathlinearprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_table_copy(s : MathlinearprogTable) -> MathlinearprogTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_table_fill(s : MathlinearprogTable, v : Double) -> MathlinearprogTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_table_min(s : MathlinearprogTable) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_table_max(s : MathlinearprogTable) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_table_to_string(s : MathlinearprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_graphn_make(size : Int) -> MathlinearprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_graphn_len(s : MathlinearprogGraphN) -> Int { s.size }

pub fn math_linear_prog_graphn_get(s : MathlinearprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_graphn_set(s : MathlinearprogGraphN, i : Int, v : Double) -> MathlinearprogGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_graphn_sum(s : MathlinearprogGraphN) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_graphn_mean(s : MathlinearprogGraphN) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_graphn_scale(s : MathlinearprogGraphN, f : Double) -> MathlinearprogGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_graphn_add(a : MathlinearprogGraphN, b : MathlinearprogGraphN) -> MathlinearprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_graphn_copy(s : MathlinearprogGraphN) -> MathlinearprogGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_graphn_fill(s : MathlinearprogGraphN, v : Double) -> MathlinearprogGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_graphn_min(s : MathlinearprogGraphN) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_graphn_max(s : MathlinearprogGraphN) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_graphn_to_string(s : MathlinearprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_node_make(size : Int) -> MathlinearprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_node_len(s : MathlinearprogNode) -> Int { s.size }

pub fn math_linear_prog_node_get(s : MathlinearprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_node_set(s : MathlinearprogNode, i : Int, v : Double) -> MathlinearprogNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_node_sum(s : MathlinearprogNode) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_node_mean(s : MathlinearprogNode) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_node_scale(s : MathlinearprogNode, f : Double) -> MathlinearprogNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_node_add(a : MathlinearprogNode, b : MathlinearprogNode) -> MathlinearprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_node_copy(s : MathlinearprogNode) -> MathlinearprogNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_node_fill(s : MathlinearprogNode, v : Double) -> MathlinearprogNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_node_min(s : MathlinearprogNode) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_node_max(s : MathlinearprogNode) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_node_to_string(s : MathlinearprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_edge_make(size : Int) -> MathlinearprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_edge_len(s : MathlinearprogEdge) -> Int { s.size }

pub fn math_linear_prog_edge_get(s : MathlinearprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_edge_set(s : MathlinearprogEdge, i : Int, v : Double) -> MathlinearprogEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_edge_sum(s : MathlinearprogEdge) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_edge_mean(s : MathlinearprogEdge) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_edge_scale(s : MathlinearprogEdge, f : Double) -> MathlinearprogEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_edge_add(a : MathlinearprogEdge, b : MathlinearprogEdge) -> MathlinearprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_edge_copy(s : MathlinearprogEdge) -> MathlinearprogEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_edge_fill(s : MathlinearprogEdge, v : Double) -> MathlinearprogEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_edge_min(s : MathlinearprogEdge) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_edge_max(s : MathlinearprogEdge) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_edge_to_string(s : MathlinearprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_path_make(size : Int) -> MathlinearprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_path_len(s : MathlinearprogPath) -> Int { s.size }

pub fn math_linear_prog_path_get(s : MathlinearprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_path_set(s : MathlinearprogPath, i : Int, v : Double) -> MathlinearprogPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_path_sum(s : MathlinearprogPath) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_path_mean(s : MathlinearprogPath) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_path_scale(s : MathlinearprogPath, f : Double) -> MathlinearprogPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_path_add(a : MathlinearprogPath, b : MathlinearprogPath) -> MathlinearprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_path_copy(s : MathlinearprogPath) -> MathlinearprogPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_path_fill(s : MathlinearprogPath, v : Double) -> MathlinearprogPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_path_min(s : MathlinearprogPath) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_path_max(s : MathlinearprogPath) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_path_to_string(s : MathlinearprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_cluster_make(size : Int) -> MathlinearprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_cluster_len(s : MathlinearprogCluster) -> Int { s.size }

pub fn math_linear_prog_cluster_get(s : MathlinearprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_cluster_set(s : MathlinearprogCluster, i : Int, v : Double) -> MathlinearprogCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cluster_sum(s : MathlinearprogCluster) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_cluster_mean(s : MathlinearprogCluster) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_cluster_scale(s : MathlinearprogCluster, f : Double) -> MathlinearprogCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cluster_add(a : MathlinearprogCluster, b : MathlinearprogCluster) -> MathlinearprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_cluster_copy(s : MathlinearprogCluster) -> MathlinearprogCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cluster_fill(s : MathlinearprogCluster, v : Double) -> MathlinearprogCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cluster_min(s : MathlinearprogCluster) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_cluster_max(s : MathlinearprogCluster) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_cluster_to_string(s : MathlinearprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_model_make(size : Int) -> MathlinearprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_model_len(s : MathlinearprogModel) -> Int { s.size }

pub fn math_linear_prog_model_get(s : MathlinearprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_model_set(s : MathlinearprogModel, i : Int, v : Double) -> MathlinearprogModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_model_sum(s : MathlinearprogModel) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_model_mean(s : MathlinearprogModel) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_model_scale(s : MathlinearprogModel, f : Double) -> MathlinearprogModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_model_add(a : MathlinearprogModel, b : MathlinearprogModel) -> MathlinearprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_model_copy(s : MathlinearprogModel) -> MathlinearprogModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_model_fill(s : MathlinearprogModel, v : Double) -> MathlinearprogModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_model_min(s : MathlinearprogModel) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_model_max(s : MathlinearprogModel) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_model_to_string(s : MathlinearprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_layer_make(size : Int) -> MathlinearprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_layer_len(s : MathlinearprogLayer) -> Int { s.size }

pub fn math_linear_prog_layer_get(s : MathlinearprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_layer_set(s : MathlinearprogLayer, i : Int, v : Double) -> MathlinearprogLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_layer_sum(s : MathlinearprogLayer) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_layer_mean(s : MathlinearprogLayer) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_layer_scale(s : MathlinearprogLayer, f : Double) -> MathlinearprogLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_layer_add(a : MathlinearprogLayer, b : MathlinearprogLayer) -> MathlinearprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_layer_copy(s : MathlinearprogLayer) -> MathlinearprogLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_layer_fill(s : MathlinearprogLayer, v : Double) -> MathlinearprogLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_layer_min(s : MathlinearprogLayer) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_layer_max(s : MathlinearprogLayer) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_layer_to_string(s : MathlinearprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_buffer_make(size : Int) -> MathlinearprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_buffer_len(s : MathlinearprogBuffer) -> Int { s.size }

pub fn math_linear_prog_buffer_get(s : MathlinearprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_buffer_set(s : MathlinearprogBuffer, i : Int, v : Double) -> MathlinearprogBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_buffer_sum(s : MathlinearprogBuffer) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_buffer_mean(s : MathlinearprogBuffer) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_buffer_scale(s : MathlinearprogBuffer, f : Double) -> MathlinearprogBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_buffer_add(a : MathlinearprogBuffer, b : MathlinearprogBuffer) -> MathlinearprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_buffer_copy(s : MathlinearprogBuffer) -> MathlinearprogBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_buffer_fill(s : MathlinearprogBuffer, v : Double) -> MathlinearprogBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_buffer_min(s : MathlinearprogBuffer) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_buffer_max(s : MathlinearprogBuffer) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_buffer_to_string(s : MathlinearprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_cursor_make(size : Int) -> MathlinearprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_cursor_len(s : MathlinearprogCursor) -> Int { s.size }

pub fn math_linear_prog_cursor_get(s : MathlinearprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_cursor_set(s : MathlinearprogCursor, i : Int, v : Double) -> MathlinearprogCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cursor_sum(s : MathlinearprogCursor) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_cursor_mean(s : MathlinearprogCursor) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_cursor_scale(s : MathlinearprogCursor, f : Double) -> MathlinearprogCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cursor_add(a : MathlinearprogCursor, b : MathlinearprogCursor) -> MathlinearprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_cursor_copy(s : MathlinearprogCursor) -> MathlinearprogCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cursor_fill(s : MathlinearprogCursor, v : Double) -> MathlinearprogCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cursor_min(s : MathlinearprogCursor) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_cursor_max(s : MathlinearprogCursor) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_cursor_to_string(s : MathlinearprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_view_make(size : Int) -> MathlinearprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_view_len(s : MathlinearprogView) -> Int { s.size }

pub fn math_linear_prog_view_get(s : MathlinearprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_view_set(s : MathlinearprogView, i : Int, v : Double) -> MathlinearprogView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_view_sum(s : MathlinearprogView) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_view_mean(s : MathlinearprogView) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_view_scale(s : MathlinearprogView, f : Double) -> MathlinearprogView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_view_add(a : MathlinearprogView, b : MathlinearprogView) -> MathlinearprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_view_copy(s : MathlinearprogView) -> MathlinearprogView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_view_fill(s : MathlinearprogView, v : Double) -> MathlinearprogView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_view_min(s : MathlinearprogView) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_view_max(s : MathlinearprogView) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_view_to_string(s : MathlinearprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_range_make(size : Int) -> MathlinearprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_range_len(s : MathlinearprogRange) -> Int { s.size }

pub fn math_linear_prog_range_get(s : MathlinearprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_range_set(s : MathlinearprogRange, i : Int, v : Double) -> MathlinearprogRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_range_sum(s : MathlinearprogRange) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_range_mean(s : MathlinearprogRange) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_range_scale(s : MathlinearprogRange, f : Double) -> MathlinearprogRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_range_add(a : MathlinearprogRange, b : MathlinearprogRange) -> MathlinearprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_range_copy(s : MathlinearprogRange) -> MathlinearprogRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_range_fill(s : MathlinearprogRange, v : Double) -> MathlinearprogRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_range_min(s : MathlinearprogRange) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_range_max(s : MathlinearprogRange) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_range_to_string(s : MathlinearprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_slice_make(size : Int) -> MathlinearprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_slice_len(s : MathlinearprogSlice) -> Int { s.size }

pub fn math_linear_prog_slice_get(s : MathlinearprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_slice_set(s : MathlinearprogSlice, i : Int, v : Double) -> MathlinearprogSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_slice_sum(s : MathlinearprogSlice) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_slice_mean(s : MathlinearprogSlice) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_slice_scale(s : MathlinearprogSlice, f : Double) -> MathlinearprogSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_slice_add(a : MathlinearprogSlice, b : MathlinearprogSlice) -> MathlinearprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_slice_copy(s : MathlinearprogSlice) -> MathlinearprogSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_slice_fill(s : MathlinearprogSlice, v : Double) -> MathlinearprogSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_slice_min(s : MathlinearprogSlice) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_slice_max(s : MathlinearprogSlice) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_slice_to_string(s : MathlinearprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

