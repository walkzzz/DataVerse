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

pub fn MathquaternionFrame::len(self : MathquaternionFrame) -> Int { self.size }

pub fn MathquaternionFrame::get(self : MathquaternionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionFrame::set(self : MathquaternionFrame, i : Int, v : Double) -> MathquaternionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionFrame::sum(self : MathquaternionFrame) -> Double { @_common.sum(self.data) }

pub fn MathquaternionFrame::mean(self : MathquaternionFrame) -> Double { @_common.mean(self.data) }

pub fn MathquaternionFrame::scale(self : MathquaternionFrame, f : Double) -> MathquaternionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionFrame::add(self : MathquaternionFrame, other : MathquaternionFrame) -> MathquaternionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionFrame::copy(self : MathquaternionFrame) -> MathquaternionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionFrame::fill(self : MathquaternionFrame, v : Double) -> MathquaternionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionFrame::min(self : MathquaternionFrame) -> Double { @_common.min(self.data) }

pub fn MathquaternionFrame::max(self : MathquaternionFrame) -> Double { @_common.max(self.data) }

pub fn MathquaternionFrame::to_string(self : MathquaternionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_table_make(size : Int) -> MathquaternionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionTable::len(self : MathquaternionTable) -> Int { self.size }

pub fn MathquaternionTable::get(self : MathquaternionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionTable::set(self : MathquaternionTable, i : Int, v : Double) -> MathquaternionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionTable::sum(self : MathquaternionTable) -> Double { @_common.sum(self.data) }

pub fn MathquaternionTable::mean(self : MathquaternionTable) -> Double { @_common.mean(self.data) }

pub fn MathquaternionTable::scale(self : MathquaternionTable, f : Double) -> MathquaternionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionTable::add(self : MathquaternionTable, other : MathquaternionTable) -> MathquaternionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionTable::copy(self : MathquaternionTable) -> MathquaternionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionTable::fill(self : MathquaternionTable, v : Double) -> MathquaternionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionTable::min(self : MathquaternionTable) -> Double { @_common.min(self.data) }

pub fn MathquaternionTable::max(self : MathquaternionTable) -> Double { @_common.max(self.data) }

pub fn MathquaternionTable::to_string(self : MathquaternionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_graphn_make(size : Int) -> MathquaternionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionGraphN::len(self : MathquaternionGraphN) -> Int { self.size }

pub fn MathquaternionGraphN::get(self : MathquaternionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionGraphN::set(self : MathquaternionGraphN, i : Int, v : Double) -> MathquaternionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionGraphN::sum(self : MathquaternionGraphN) -> Double { @_common.sum(self.data) }

pub fn MathquaternionGraphN::mean(self : MathquaternionGraphN) -> Double { @_common.mean(self.data) }

pub fn MathquaternionGraphN::scale(self : MathquaternionGraphN, f : Double) -> MathquaternionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionGraphN::add(self : MathquaternionGraphN, other : MathquaternionGraphN) -> MathquaternionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionGraphN::copy(self : MathquaternionGraphN) -> MathquaternionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionGraphN::fill(self : MathquaternionGraphN, v : Double) -> MathquaternionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionGraphN::min(self : MathquaternionGraphN) -> Double { @_common.min(self.data) }

pub fn MathquaternionGraphN::max(self : MathquaternionGraphN) -> Double { @_common.max(self.data) }

pub fn MathquaternionGraphN::to_string(self : MathquaternionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_node_make(size : Int) -> MathquaternionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionNode::len(self : MathquaternionNode) -> Int { self.size }

pub fn MathquaternionNode::get(self : MathquaternionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionNode::set(self : MathquaternionNode, i : Int, v : Double) -> MathquaternionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionNode::sum(self : MathquaternionNode) -> Double { @_common.sum(self.data) }

pub fn MathquaternionNode::mean(self : MathquaternionNode) -> Double { @_common.mean(self.data) }

pub fn MathquaternionNode::scale(self : MathquaternionNode, f : Double) -> MathquaternionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionNode::add(self : MathquaternionNode, other : MathquaternionNode) -> MathquaternionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionNode::copy(self : MathquaternionNode) -> MathquaternionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionNode::fill(self : MathquaternionNode, v : Double) -> MathquaternionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionNode::min(self : MathquaternionNode) -> Double { @_common.min(self.data) }

pub fn MathquaternionNode::max(self : MathquaternionNode) -> Double { @_common.max(self.data) }

pub fn MathquaternionNode::to_string(self : MathquaternionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_edge_make(size : Int) -> MathquaternionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionEdge::len(self : MathquaternionEdge) -> Int { self.size }

pub fn MathquaternionEdge::get(self : MathquaternionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionEdge::set(self : MathquaternionEdge, i : Int, v : Double) -> MathquaternionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionEdge::sum(self : MathquaternionEdge) -> Double { @_common.sum(self.data) }

pub fn MathquaternionEdge::mean(self : MathquaternionEdge) -> Double { @_common.mean(self.data) }

pub fn MathquaternionEdge::scale(self : MathquaternionEdge, f : Double) -> MathquaternionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionEdge::add(self : MathquaternionEdge, other : MathquaternionEdge) -> MathquaternionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionEdge::copy(self : MathquaternionEdge) -> MathquaternionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionEdge::fill(self : MathquaternionEdge, v : Double) -> MathquaternionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionEdge::min(self : MathquaternionEdge) -> Double { @_common.min(self.data) }

pub fn MathquaternionEdge::max(self : MathquaternionEdge) -> Double { @_common.max(self.data) }

pub fn MathquaternionEdge::to_string(self : MathquaternionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_path_make(size : Int) -> MathquaternionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionPath::len(self : MathquaternionPath) -> Int { self.size }

pub fn MathquaternionPath::get(self : MathquaternionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionPath::set(self : MathquaternionPath, i : Int, v : Double) -> MathquaternionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionPath::sum(self : MathquaternionPath) -> Double { @_common.sum(self.data) }

pub fn MathquaternionPath::mean(self : MathquaternionPath) -> Double { @_common.mean(self.data) }

pub fn MathquaternionPath::scale(self : MathquaternionPath, f : Double) -> MathquaternionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionPath::add(self : MathquaternionPath, other : MathquaternionPath) -> MathquaternionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionPath::copy(self : MathquaternionPath) -> MathquaternionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionPath::fill(self : MathquaternionPath, v : Double) -> MathquaternionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionPath::min(self : MathquaternionPath) -> Double { @_common.min(self.data) }

pub fn MathquaternionPath::max(self : MathquaternionPath) -> Double { @_common.max(self.data) }

pub fn MathquaternionPath::to_string(self : MathquaternionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_cluster_make(size : Int) -> MathquaternionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionCluster::len(self : MathquaternionCluster) -> Int { self.size }

pub fn MathquaternionCluster::get(self : MathquaternionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionCluster::set(self : MathquaternionCluster, i : Int, v : Double) -> MathquaternionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionCluster::sum(self : MathquaternionCluster) -> Double { @_common.sum(self.data) }

pub fn MathquaternionCluster::mean(self : MathquaternionCluster) -> Double { @_common.mean(self.data) }

pub fn MathquaternionCluster::scale(self : MathquaternionCluster, f : Double) -> MathquaternionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionCluster::add(self : MathquaternionCluster, other : MathquaternionCluster) -> MathquaternionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionCluster::copy(self : MathquaternionCluster) -> MathquaternionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionCluster::fill(self : MathquaternionCluster, v : Double) -> MathquaternionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionCluster::min(self : MathquaternionCluster) -> Double { @_common.min(self.data) }

pub fn MathquaternionCluster::max(self : MathquaternionCluster) -> Double { @_common.max(self.data) }

pub fn MathquaternionCluster::to_string(self : MathquaternionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_model_make(size : Int) -> MathquaternionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionModel::len(self : MathquaternionModel) -> Int { self.size }

pub fn MathquaternionModel::get(self : MathquaternionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionModel::set(self : MathquaternionModel, i : Int, v : Double) -> MathquaternionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionModel::sum(self : MathquaternionModel) -> Double { @_common.sum(self.data) }

pub fn MathquaternionModel::mean(self : MathquaternionModel) -> Double { @_common.mean(self.data) }

pub fn MathquaternionModel::scale(self : MathquaternionModel, f : Double) -> MathquaternionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionModel::add(self : MathquaternionModel, other : MathquaternionModel) -> MathquaternionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionModel::copy(self : MathquaternionModel) -> MathquaternionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionModel::fill(self : MathquaternionModel, v : Double) -> MathquaternionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionModel::min(self : MathquaternionModel) -> Double { @_common.min(self.data) }

pub fn MathquaternionModel::max(self : MathquaternionModel) -> Double { @_common.max(self.data) }

pub fn MathquaternionModel::to_string(self : MathquaternionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_layer_make(size : Int) -> MathquaternionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionLayer::len(self : MathquaternionLayer) -> Int { self.size }

pub fn MathquaternionLayer::get(self : MathquaternionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionLayer::set(self : MathquaternionLayer, i : Int, v : Double) -> MathquaternionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionLayer::sum(self : MathquaternionLayer) -> Double { @_common.sum(self.data) }

pub fn MathquaternionLayer::mean(self : MathquaternionLayer) -> Double { @_common.mean(self.data) }

pub fn MathquaternionLayer::scale(self : MathquaternionLayer, f : Double) -> MathquaternionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionLayer::add(self : MathquaternionLayer, other : MathquaternionLayer) -> MathquaternionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionLayer::copy(self : MathquaternionLayer) -> MathquaternionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionLayer::fill(self : MathquaternionLayer, v : Double) -> MathquaternionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionLayer::min(self : MathquaternionLayer) -> Double { @_common.min(self.data) }

pub fn MathquaternionLayer::max(self : MathquaternionLayer) -> Double { @_common.max(self.data) }

pub fn MathquaternionLayer::to_string(self : MathquaternionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_buffer_make(size : Int) -> MathquaternionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionBuffer::len(self : MathquaternionBuffer) -> Int { self.size }

pub fn MathquaternionBuffer::get(self : MathquaternionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionBuffer::set(self : MathquaternionBuffer, i : Int, v : Double) -> MathquaternionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionBuffer::sum(self : MathquaternionBuffer) -> Double { @_common.sum(self.data) }

pub fn MathquaternionBuffer::mean(self : MathquaternionBuffer) -> Double { @_common.mean(self.data) }

pub fn MathquaternionBuffer::scale(self : MathquaternionBuffer, f : Double) -> MathquaternionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionBuffer::add(self : MathquaternionBuffer, other : MathquaternionBuffer) -> MathquaternionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionBuffer::copy(self : MathquaternionBuffer) -> MathquaternionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionBuffer::fill(self : MathquaternionBuffer, v : Double) -> MathquaternionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionBuffer::min(self : MathquaternionBuffer) -> Double { @_common.min(self.data) }

pub fn MathquaternionBuffer::max(self : MathquaternionBuffer) -> Double { @_common.max(self.data) }

pub fn MathquaternionBuffer::to_string(self : MathquaternionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_cursor_make(size : Int) -> MathquaternionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionCursor::len(self : MathquaternionCursor) -> Int { self.size }

pub fn MathquaternionCursor::get(self : MathquaternionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionCursor::set(self : MathquaternionCursor, i : Int, v : Double) -> MathquaternionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionCursor::sum(self : MathquaternionCursor) -> Double { @_common.sum(self.data) }

pub fn MathquaternionCursor::mean(self : MathquaternionCursor) -> Double { @_common.mean(self.data) }

pub fn MathquaternionCursor::scale(self : MathquaternionCursor, f : Double) -> MathquaternionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionCursor::add(self : MathquaternionCursor, other : MathquaternionCursor) -> MathquaternionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionCursor::copy(self : MathquaternionCursor) -> MathquaternionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionCursor::fill(self : MathquaternionCursor, v : Double) -> MathquaternionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionCursor::min(self : MathquaternionCursor) -> Double { @_common.min(self.data) }

pub fn MathquaternionCursor::max(self : MathquaternionCursor) -> Double { @_common.max(self.data) }

pub fn MathquaternionCursor::to_string(self : MathquaternionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_view_make(size : Int) -> MathquaternionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionView::len(self : MathquaternionView) -> Int { self.size }

pub fn MathquaternionView::get(self : MathquaternionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionView::set(self : MathquaternionView, i : Int, v : Double) -> MathquaternionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionView::sum(self : MathquaternionView) -> Double { @_common.sum(self.data) }

pub fn MathquaternionView::mean(self : MathquaternionView) -> Double { @_common.mean(self.data) }

pub fn MathquaternionView::scale(self : MathquaternionView, f : Double) -> MathquaternionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionView::add(self : MathquaternionView, other : MathquaternionView) -> MathquaternionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionView::copy(self : MathquaternionView) -> MathquaternionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionView::fill(self : MathquaternionView, v : Double) -> MathquaternionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionView::min(self : MathquaternionView) -> Double { @_common.min(self.data) }

pub fn MathquaternionView::max(self : MathquaternionView) -> Double { @_common.max(self.data) }

pub fn MathquaternionView::to_string(self : MathquaternionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_range_make(size : Int) -> MathquaternionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionRange::len(self : MathquaternionRange) -> Int { self.size }

pub fn MathquaternionRange::get(self : MathquaternionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionRange::set(self : MathquaternionRange, i : Int, v : Double) -> MathquaternionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionRange::sum(self : MathquaternionRange) -> Double { @_common.sum(self.data) }

pub fn MathquaternionRange::mean(self : MathquaternionRange) -> Double { @_common.mean(self.data) }

pub fn MathquaternionRange::scale(self : MathquaternionRange, f : Double) -> MathquaternionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionRange::add(self : MathquaternionRange, other : MathquaternionRange) -> MathquaternionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionRange::copy(self : MathquaternionRange) -> MathquaternionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionRange::fill(self : MathquaternionRange, v : Double) -> MathquaternionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionRange::min(self : MathquaternionRange) -> Double { @_common.min(self.data) }

pub fn MathquaternionRange::max(self : MathquaternionRange) -> Double { @_common.max(self.data) }

pub fn MathquaternionRange::to_string(self : MathquaternionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathquaternionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_slice_make(size : Int) -> MathquaternionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathquaternionSlice::len(self : MathquaternionSlice) -> Int { self.size }

pub fn MathquaternionSlice::get(self : MathquaternionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathquaternionSlice::set(self : MathquaternionSlice, i : Int, v : Double) -> MathquaternionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathquaternionSlice::sum(self : MathquaternionSlice) -> Double { @_common.sum(self.data) }

pub fn MathquaternionSlice::mean(self : MathquaternionSlice) -> Double { @_common.mean(self.data) }

pub fn MathquaternionSlice::scale(self : MathquaternionSlice, f : Double) -> MathquaternionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathquaternionSlice::add(self : MathquaternionSlice, other : MathquaternionSlice) -> MathquaternionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathquaternionSlice::copy(self : MathquaternionSlice) -> MathquaternionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathquaternionSlice::fill(self : MathquaternionSlice, v : Double) -> MathquaternionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathquaternionSlice::min(self : MathquaternionSlice) -> Double { @_common.min(self.data) }

pub fn MathquaternionSlice::max(self : MathquaternionSlice) -> Double { @_common.max(self.data) }

pub fn MathquaternionSlice::to_string(self : MathquaternionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

