///===
/// extcore/math_quaternion

pub(all) struct MathquaternionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_quaternion_make_point(x : Double, y : Double) -> MathquaternionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_quaternion_make_point3(x : Double, y : Double, z : Double) -> MathquaternionPoint {
  { x, y, z, label: 0 }
}

pub fn MathquaternionPoint::x(self : MathquaternionPoint) -> Double { self.x }

pub fn MathquaternionPoint::y(self : MathquaternionPoint) -> Double { self.y }

pub fn MathquaternionPoint::z(self : MathquaternionPoint) -> Double { self.z }

pub fn MathquaternionPoint::label(self : MathquaternionPoint) -> Int { self.label }

pub fn MathquaternionPoint::dist(self : MathquaternionPoint, other : MathquaternionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathquaternionPoint::add(self : MathquaternionPoint, other : MathquaternionPoint) -> MathquaternionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathquaternionPoint::sub(self : MathquaternionPoint, other : MathquaternionPoint) -> MathquaternionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathquaternionPoint::scale(self : MathquaternionPoint, s : Double) -> MathquaternionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathquaternionPoint::dot(self : MathquaternionPoint, other : MathquaternionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathquaternionPoint::cross(self : MathquaternionPoint, other : MathquaternionPoint) -> MathquaternionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathquaternionPoint::norm(self : MathquaternionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathquaternionPoint::normalize(self : MathquaternionPoint) -> MathquaternionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathquaternionPoint::negate(self : MathquaternionPoint) -> MathquaternionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathquaternionPoint::mid(self : MathquaternionPoint, other : MathquaternionPoint) -> MathquaternionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathquaternionPoint::lerp(self : MathquaternionPoint, other : MathquaternionPoint, t : Double) -> MathquaternionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathquaternionPoint::to_string(self : MathquaternionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathquaternionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_quaternion_make_series(vals : Array[Double], name : String) -> MathquaternionSeries {
  { vals, name, meta: 0 }
}

pub fn MathquaternionSeries::len(self : MathquaternionSeries) -> Int { self.vals.length() }

pub fn MathquaternionSeries::sum(self : MathquaternionSeries) -> Double { @_common.sum(self.vals) }

pub fn MathquaternionSeries::mean(self : MathquaternionSeries) -> Double { @_common.mean(self.vals) }

pub fn MathquaternionSeries::min(self : MathquaternionSeries) -> Double { @_common.min(self.vals) }

pub fn MathquaternionSeries::max(self : MathquaternionSeries) -> Double { @_common.max(self.vals) }

pub fn MathquaternionSeries::range(self : MathquaternionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathquaternionSeries::variance(self : MathquaternionSeries) -> Double { @_common.variance(self.vals) }

pub fn MathquaternionSeries::std(self : MathquaternionSeries) -> Double { @_common.std(self.vals) }

pub fn MathquaternionSeries::median(self : MathquaternionSeries) -> Double { @_common.median(self.vals) }

pub fn MathquaternionSeries::scale(self : MathquaternionSeries, f : Double) -> MathquaternionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathquaternionSeries::add(self : MathquaternionSeries, other : MathquaternionSeries) -> MathquaternionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathquaternionSeries::sub(self : MathquaternionSeries, other : MathquaternionSeries) -> MathquaternionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathquaternionSeries::normalize(self : MathquaternionSeries) -> MathquaternionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathquaternionSeries::cumsum(self : MathquaternionSeries) -> MathquaternionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathquaternionSeries::to_string(self : MathquaternionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathquaternionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_quaternion_make_matrix(rows : Int, cols : Int, val : Double) -> MathquaternionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_quaternion_matrix_identity(n : Int) -> MathquaternionMatrix {
  let m = math_quaternion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathquaternionMatrix::get(self : MathquaternionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathquaternionMatrix::transpose(self : MathquaternionMatrix) -> MathquaternionMatrix {
  let result = math_quaternion_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathquaternionMatrix::add(self : MathquaternionMatrix, other : MathquaternionMatrix) -> MathquaternionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_quaternion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathquaternionMatrix::scale(self : MathquaternionMatrix, s : Double) -> MathquaternionMatrix {
  let result = math_quaternion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathquaternionMatrix::multiply(self : MathquaternionMatrix, other : MathquaternionMatrix) -> MathquaternionMatrix {
  if self.cols != other.rows { return math_quaternion_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_quaternion_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathquaternionMatrix::trace(self : MathquaternionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathquaternionMatrix::det(self : MathquaternionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathquaternionMatrix::norm(self : MathquaternionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathquaternionMatrix::to_string(self : MathquaternionMatrix) -> String {
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

pub(all) struct MathquaternionVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_quaternion_make_vector(comps : Array[Double]) -> MathquaternionVector {
  { comps, dim: comps.length() }
}

pub fn math_quaternion_vector_zero(dim : Int) -> MathquaternionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathquaternionVector::add(self : MathquaternionVector, other : MathquaternionVector) -> MathquaternionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathquaternionVector::sub(self : MathquaternionVector, other : MathquaternionVector) -> MathquaternionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathquaternionVector::scale(self : MathquaternionVector, s : Double) -> MathquaternionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathquaternionVector::dot(self : MathquaternionVector, other : MathquaternionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathquaternionVector::norm(self : MathquaternionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathquaternionVector::normalize(self : MathquaternionVector) -> MathquaternionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathquaternionVector::dist(self : MathquaternionVector, other : MathquaternionVector) -> Double {
  self.sub(other).norm()
}

pub fn MathquaternionVector::to_string(self : MathquaternionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_quaternion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_quaternion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_quaternion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_quaternion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_quaternion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_quaternion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_quaternion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_quaternion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_quaternion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_quaternion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_quaternion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_quaternion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_quaternion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_quaternion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_quaternion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_quaternion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_quaternion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_quaternion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_quaternion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_quaternion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_quaternion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_quaternion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_quaternion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_quaternion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_quaternion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_quaternion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_quaternion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_quaternion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_quaternion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathquaternionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_frame_make(size : Int) -> MathquaternionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_frame_len(s : MathquaternionFrame) -> Int { s.size }

pub fn math_quaternion_frame_get(s : MathquaternionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_frame_set(s : MathquaternionFrame, i : Int, v : Double) -> MathquaternionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_frame_sum(s : MathquaternionFrame) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_frame_mean(s : MathquaternionFrame) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_frame_scale(s : MathquaternionFrame, f : Double) -> MathquaternionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_frame_add(a : MathquaternionFrame, b : MathquaternionFrame) -> MathquaternionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_frame_copy(s : MathquaternionFrame) -> MathquaternionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_frame_fill(s : MathquaternionFrame, v : Double) -> MathquaternionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_frame_min(s : MathquaternionFrame) -> Double { @_common.min(s.data) }

pub fn math_quaternion_frame_max(s : MathquaternionFrame) -> Double { @_common.max(s.data) }

pub fn math_quaternion_frame_to_string(s : MathquaternionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_table_make(size : Int) -> MathquaternionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_table_len(s : MathquaternionTable) -> Int { s.size }

pub fn math_quaternion_table_get(s : MathquaternionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_table_set(s : MathquaternionTable, i : Int, v : Double) -> MathquaternionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_table_sum(s : MathquaternionTable) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_table_mean(s : MathquaternionTable) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_table_scale(s : MathquaternionTable, f : Double) -> MathquaternionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_table_add(a : MathquaternionTable, b : MathquaternionTable) -> MathquaternionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_table_copy(s : MathquaternionTable) -> MathquaternionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_table_fill(s : MathquaternionTable, v : Double) -> MathquaternionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_table_min(s : MathquaternionTable) -> Double { @_common.min(s.data) }

pub fn math_quaternion_table_max(s : MathquaternionTable) -> Double { @_common.max(s.data) }

pub fn math_quaternion_table_to_string(s : MathquaternionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_graphn_make(size : Int) -> MathquaternionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_graphn_len(s : MathquaternionGraphN) -> Int { s.size }

pub fn math_quaternion_graphn_get(s : MathquaternionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_graphn_set(s : MathquaternionGraphN, i : Int, v : Double) -> MathquaternionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_graphn_sum(s : MathquaternionGraphN) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_graphn_mean(s : MathquaternionGraphN) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_graphn_scale(s : MathquaternionGraphN, f : Double) -> MathquaternionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_graphn_add(a : MathquaternionGraphN, b : MathquaternionGraphN) -> MathquaternionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_graphn_copy(s : MathquaternionGraphN) -> MathquaternionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_graphn_fill(s : MathquaternionGraphN, v : Double) -> MathquaternionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_graphn_min(s : MathquaternionGraphN) -> Double { @_common.min(s.data) }

pub fn math_quaternion_graphn_max(s : MathquaternionGraphN) -> Double { @_common.max(s.data) }

pub fn math_quaternion_graphn_to_string(s : MathquaternionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_node_make(size : Int) -> MathquaternionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_node_len(s : MathquaternionNode) -> Int { s.size }

pub fn math_quaternion_node_get(s : MathquaternionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_node_set(s : MathquaternionNode, i : Int, v : Double) -> MathquaternionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_node_sum(s : MathquaternionNode) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_node_mean(s : MathquaternionNode) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_node_scale(s : MathquaternionNode, f : Double) -> MathquaternionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_node_add(a : MathquaternionNode, b : MathquaternionNode) -> MathquaternionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_node_copy(s : MathquaternionNode) -> MathquaternionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_node_fill(s : MathquaternionNode, v : Double) -> MathquaternionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_node_min(s : MathquaternionNode) -> Double { @_common.min(s.data) }

pub fn math_quaternion_node_max(s : MathquaternionNode) -> Double { @_common.max(s.data) }

pub fn math_quaternion_node_to_string(s : MathquaternionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_edge_make(size : Int) -> MathquaternionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_edge_len(s : MathquaternionEdge) -> Int { s.size }

pub fn math_quaternion_edge_get(s : MathquaternionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_edge_set(s : MathquaternionEdge, i : Int, v : Double) -> MathquaternionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_edge_sum(s : MathquaternionEdge) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_edge_mean(s : MathquaternionEdge) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_edge_scale(s : MathquaternionEdge, f : Double) -> MathquaternionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_edge_add(a : MathquaternionEdge, b : MathquaternionEdge) -> MathquaternionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_edge_copy(s : MathquaternionEdge) -> MathquaternionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_edge_fill(s : MathquaternionEdge, v : Double) -> MathquaternionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_edge_min(s : MathquaternionEdge) -> Double { @_common.min(s.data) }

pub fn math_quaternion_edge_max(s : MathquaternionEdge) -> Double { @_common.max(s.data) }

pub fn math_quaternion_edge_to_string(s : MathquaternionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_path_make(size : Int) -> MathquaternionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_path_len(s : MathquaternionPath) -> Int { s.size }

pub fn math_quaternion_path_get(s : MathquaternionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_path_set(s : MathquaternionPath, i : Int, v : Double) -> MathquaternionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_path_sum(s : MathquaternionPath) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_path_mean(s : MathquaternionPath) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_path_scale(s : MathquaternionPath, f : Double) -> MathquaternionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_path_add(a : MathquaternionPath, b : MathquaternionPath) -> MathquaternionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_path_copy(s : MathquaternionPath) -> MathquaternionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_path_fill(s : MathquaternionPath, v : Double) -> MathquaternionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_path_min(s : MathquaternionPath) -> Double { @_common.min(s.data) }

pub fn math_quaternion_path_max(s : MathquaternionPath) -> Double { @_common.max(s.data) }

pub fn math_quaternion_path_to_string(s : MathquaternionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_cluster_make(size : Int) -> MathquaternionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_cluster_len(s : MathquaternionCluster) -> Int { s.size }

pub fn math_quaternion_cluster_get(s : MathquaternionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_cluster_set(s : MathquaternionCluster, i : Int, v : Double) -> MathquaternionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_cluster_sum(s : MathquaternionCluster) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_cluster_mean(s : MathquaternionCluster) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_cluster_scale(s : MathquaternionCluster, f : Double) -> MathquaternionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_cluster_add(a : MathquaternionCluster, b : MathquaternionCluster) -> MathquaternionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_cluster_copy(s : MathquaternionCluster) -> MathquaternionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_cluster_fill(s : MathquaternionCluster, v : Double) -> MathquaternionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_cluster_min(s : MathquaternionCluster) -> Double { @_common.min(s.data) }

pub fn math_quaternion_cluster_max(s : MathquaternionCluster) -> Double { @_common.max(s.data) }

pub fn math_quaternion_cluster_to_string(s : MathquaternionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_model_make(size : Int) -> MathquaternionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_model_len(s : MathquaternionModel) -> Int { s.size }

pub fn math_quaternion_model_get(s : MathquaternionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_model_set(s : MathquaternionModel, i : Int, v : Double) -> MathquaternionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_model_sum(s : MathquaternionModel) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_model_mean(s : MathquaternionModel) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_model_scale(s : MathquaternionModel, f : Double) -> MathquaternionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_model_add(a : MathquaternionModel, b : MathquaternionModel) -> MathquaternionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_model_copy(s : MathquaternionModel) -> MathquaternionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_model_fill(s : MathquaternionModel, v : Double) -> MathquaternionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_model_min(s : MathquaternionModel) -> Double { @_common.min(s.data) }

pub fn math_quaternion_model_max(s : MathquaternionModel) -> Double { @_common.max(s.data) }

pub fn math_quaternion_model_to_string(s : MathquaternionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_layer_make(size : Int) -> MathquaternionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_layer_len(s : MathquaternionLayer) -> Int { s.size }

pub fn math_quaternion_layer_get(s : MathquaternionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_layer_set(s : MathquaternionLayer, i : Int, v : Double) -> MathquaternionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_layer_sum(s : MathquaternionLayer) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_layer_mean(s : MathquaternionLayer) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_layer_scale(s : MathquaternionLayer, f : Double) -> MathquaternionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_layer_add(a : MathquaternionLayer, b : MathquaternionLayer) -> MathquaternionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_layer_copy(s : MathquaternionLayer) -> MathquaternionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_layer_fill(s : MathquaternionLayer, v : Double) -> MathquaternionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_layer_min(s : MathquaternionLayer) -> Double { @_common.min(s.data) }

pub fn math_quaternion_layer_max(s : MathquaternionLayer) -> Double { @_common.max(s.data) }

pub fn math_quaternion_layer_to_string(s : MathquaternionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_buffer_make(size : Int) -> MathquaternionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_buffer_len(s : MathquaternionBuffer) -> Int { s.size }

pub fn math_quaternion_buffer_get(s : MathquaternionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_buffer_set(s : MathquaternionBuffer, i : Int, v : Double) -> MathquaternionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_buffer_sum(s : MathquaternionBuffer) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_buffer_mean(s : MathquaternionBuffer) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_buffer_scale(s : MathquaternionBuffer, f : Double) -> MathquaternionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_buffer_add(a : MathquaternionBuffer, b : MathquaternionBuffer) -> MathquaternionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_buffer_copy(s : MathquaternionBuffer) -> MathquaternionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_buffer_fill(s : MathquaternionBuffer, v : Double) -> MathquaternionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_buffer_min(s : MathquaternionBuffer) -> Double { @_common.min(s.data) }

pub fn math_quaternion_buffer_max(s : MathquaternionBuffer) -> Double { @_common.max(s.data) }

pub fn math_quaternion_buffer_to_string(s : MathquaternionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_cursor_make(size : Int) -> MathquaternionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_cursor_len(s : MathquaternionCursor) -> Int { s.size }

pub fn math_quaternion_cursor_get(s : MathquaternionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_cursor_set(s : MathquaternionCursor, i : Int, v : Double) -> MathquaternionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_cursor_sum(s : MathquaternionCursor) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_cursor_mean(s : MathquaternionCursor) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_cursor_scale(s : MathquaternionCursor, f : Double) -> MathquaternionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_cursor_add(a : MathquaternionCursor, b : MathquaternionCursor) -> MathquaternionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_cursor_copy(s : MathquaternionCursor) -> MathquaternionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_cursor_fill(s : MathquaternionCursor, v : Double) -> MathquaternionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_cursor_min(s : MathquaternionCursor) -> Double { @_common.min(s.data) }

pub fn math_quaternion_cursor_max(s : MathquaternionCursor) -> Double { @_common.max(s.data) }

pub fn math_quaternion_cursor_to_string(s : MathquaternionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_view_make(size : Int) -> MathquaternionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_view_len(s : MathquaternionView) -> Int { s.size }

pub fn math_quaternion_view_get(s : MathquaternionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_view_set(s : MathquaternionView, i : Int, v : Double) -> MathquaternionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_view_sum(s : MathquaternionView) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_view_mean(s : MathquaternionView) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_view_scale(s : MathquaternionView, f : Double) -> MathquaternionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_view_add(a : MathquaternionView, b : MathquaternionView) -> MathquaternionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_view_copy(s : MathquaternionView) -> MathquaternionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_view_fill(s : MathquaternionView, v : Double) -> MathquaternionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_view_min(s : MathquaternionView) -> Double { @_common.min(s.data) }

pub fn math_quaternion_view_max(s : MathquaternionView) -> Double { @_common.max(s.data) }

pub fn math_quaternion_view_to_string(s : MathquaternionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_range_make(size : Int) -> MathquaternionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_range_len(s : MathquaternionRange) -> Int { s.size }

pub fn math_quaternion_range_get(s : MathquaternionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_range_set(s : MathquaternionRange, i : Int, v : Double) -> MathquaternionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_range_sum(s : MathquaternionRange) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_range_mean(s : MathquaternionRange) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_range_scale(s : MathquaternionRange, f : Double) -> MathquaternionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_range_add(a : MathquaternionRange, b : MathquaternionRange) -> MathquaternionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_range_copy(s : MathquaternionRange) -> MathquaternionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_range_fill(s : MathquaternionRange, v : Double) -> MathquaternionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_range_min(s : MathquaternionRange) -> Double { @_common.min(s.data) }

pub fn math_quaternion_range_max(s : MathquaternionRange) -> Double { @_common.max(s.data) }

pub fn math_quaternion_range_to_string(s : MathquaternionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_slice_make(size : Int) -> MathquaternionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_slice_len(s : MathquaternionSlice) -> Int { s.size }

pub fn math_quaternion_slice_get(s : MathquaternionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_slice_set(s : MathquaternionSlice, i : Int, v : Double) -> MathquaternionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quaternion_slice_sum(s : MathquaternionSlice) -> Double { @_common.sum(s.data) }

pub fn math_quaternion_slice_mean(s : MathquaternionSlice) -> Double { @_common.mean(s.data) }

pub fn math_quaternion_slice_scale(s : MathquaternionSlice, f : Double) -> MathquaternionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quaternion_slice_add(a : MathquaternionSlice, b : MathquaternionSlice) -> MathquaternionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quaternion_slice_copy(s : MathquaternionSlice) -> MathquaternionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quaternion_slice_fill(s : MathquaternionSlice, v : Double) -> MathquaternionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quaternion_slice_min(s : MathquaternionSlice) -> Double { @_common.min(s.data) }

pub fn math_quaternion_slice_max(s : MathquaternionSlice) -> Double { @_common.max(s.data) }

pub fn math_quaternion_slice_to_string(s : MathquaternionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

