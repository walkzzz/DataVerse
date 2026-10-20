///===
/// extcore/graph_connect_circuit

pub(all) struct GraphconnectcircuitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_circuit_make_point(x : Double, y : Double) -> GraphconnectcircuitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_circuit_make_point3(x : Double, y : Double, z : Double) -> GraphconnectcircuitPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectcircuitPoint::x(self : GraphconnectcircuitPoint) -> Double { self.x }

pub fn GraphconnectcircuitPoint::y(self : GraphconnectcircuitPoint) -> Double { self.y }

pub fn GraphconnectcircuitPoint::z(self : GraphconnectcircuitPoint) -> Double { self.z }

pub fn GraphconnectcircuitPoint::label(self : GraphconnectcircuitPoint) -> Int { self.label }

pub fn GraphconnectcircuitPoint::dist(self : GraphconnectcircuitPoint, other : GraphconnectcircuitPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectcircuitPoint::add(self : GraphconnectcircuitPoint, other : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectcircuitPoint::sub(self : GraphconnectcircuitPoint, other : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectcircuitPoint::scale(self : GraphconnectcircuitPoint, s : Double) -> GraphconnectcircuitPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectcircuitPoint::dot(self : GraphconnectcircuitPoint, other : GraphconnectcircuitPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectcircuitPoint::cross(self : GraphconnectcircuitPoint, other : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectcircuitPoint::norm(self : GraphconnectcircuitPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectcircuitPoint::normalize(self : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectcircuitPoint::negate(self : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectcircuitPoint::mid(self : GraphconnectcircuitPoint, other : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectcircuitPoint::lerp(self : GraphconnectcircuitPoint, other : GraphconnectcircuitPoint, t : Double) -> GraphconnectcircuitPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectcircuitPoint::to_string(self : GraphconnectcircuitPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectcircuitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_circuit_make_series(vals : Array[Double], name : String) -> GraphconnectcircuitSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectcircuitSeries::len(self : GraphconnectcircuitSeries) -> Int { self.vals.length() }

pub fn GraphconnectcircuitSeries::sum(self : GraphconnectcircuitSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectcircuitSeries::mean(self : GraphconnectcircuitSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectcircuitSeries::min(self : GraphconnectcircuitSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectcircuitSeries::max(self : GraphconnectcircuitSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectcircuitSeries::range(self : GraphconnectcircuitSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectcircuitSeries::variance(self : GraphconnectcircuitSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectcircuitSeries::std(self : GraphconnectcircuitSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectcircuitSeries::median(self : GraphconnectcircuitSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectcircuitSeries::scale(self : GraphconnectcircuitSeries, f : Double) -> GraphconnectcircuitSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectcircuitSeries::add(self : GraphconnectcircuitSeries, other : GraphconnectcircuitSeries) -> GraphconnectcircuitSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectcircuitSeries::sub(self : GraphconnectcircuitSeries, other : GraphconnectcircuitSeries) -> GraphconnectcircuitSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectcircuitSeries::normalize(self : GraphconnectcircuitSeries) -> GraphconnectcircuitSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectcircuitSeries::cumsum(self : GraphconnectcircuitSeries) -> GraphconnectcircuitSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectcircuitSeries::to_string(self : GraphconnectcircuitSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectcircuitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_circuit_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectcircuitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_circuit_matrix_identity(n : Int) -> GraphconnectcircuitMatrix {
  let m = graph_connect_circuit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectcircuitMatrix::get(self : GraphconnectcircuitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectcircuitMatrix::transpose(self : GraphconnectcircuitMatrix) -> GraphconnectcircuitMatrix {
  let result = graph_connect_circuit_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectcircuitMatrix::add(self : GraphconnectcircuitMatrix, other : GraphconnectcircuitMatrix) -> GraphconnectcircuitMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_circuit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectcircuitMatrix::scale(self : GraphconnectcircuitMatrix, s : Double) -> GraphconnectcircuitMatrix {
  let result = graph_connect_circuit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectcircuitMatrix::multiply(self : GraphconnectcircuitMatrix, other : GraphconnectcircuitMatrix) -> GraphconnectcircuitMatrix {
  if self.cols != other.rows { return graph_connect_circuit_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_circuit_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnectcircuitMatrix::trace(self : GraphconnectcircuitMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectcircuitMatrix::det(self : GraphconnectcircuitMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectcircuitMatrix::norm(self : GraphconnectcircuitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectcircuitMatrix::to_string(self : GraphconnectcircuitMatrix) -> String {
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

pub(all) struct GraphconnectcircuitVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_circuit_make_vector(comps : Array[Double]) -> GraphconnectcircuitVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_circuit_vector_zero(dim : Int) -> GraphconnectcircuitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectcircuitVector::add(self : GraphconnectcircuitVector, other : GraphconnectcircuitVector) -> GraphconnectcircuitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectcircuitVector::sub(self : GraphconnectcircuitVector, other : GraphconnectcircuitVector) -> GraphconnectcircuitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectcircuitVector::scale(self : GraphconnectcircuitVector, s : Double) -> GraphconnectcircuitVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectcircuitVector::dot(self : GraphconnectcircuitVector, other : GraphconnectcircuitVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectcircuitVector::norm(self : GraphconnectcircuitVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectcircuitVector::normalize(self : GraphconnectcircuitVector) -> GraphconnectcircuitVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectcircuitVector::dist(self : GraphconnectcircuitVector, other : GraphconnectcircuitVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectcircuitVector::to_string(self : GraphconnectcircuitVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_circuit_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_circuit_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_circuit_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_circuit_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_circuit_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_circuit_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_circuit_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_circuit_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_circuit_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_circuit_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_circuit_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_circuit_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_circuit_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_circuit_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_circuit_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_circuit_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_circuit_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_circuit_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_circuit_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_circuit_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_circuit_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_circuit_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_circuit_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_circuit_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_circuit_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_circuit_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_circuit_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_circuit_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_circuit_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectcircuitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_frame_make(size : Int) -> GraphconnectcircuitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_frame_len(s : GraphconnectcircuitFrame) -> Int { s.size }

pub fn graph_connect_circuit_frame_get(s : GraphconnectcircuitFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_frame_set(s : GraphconnectcircuitFrame, i : Int, v : Double) -> GraphconnectcircuitFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_frame_sum(s : GraphconnectcircuitFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_frame_mean(s : GraphconnectcircuitFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_frame_scale(s : GraphconnectcircuitFrame, f : Double) -> GraphconnectcircuitFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_frame_add(a : GraphconnectcircuitFrame, b : GraphconnectcircuitFrame) -> GraphconnectcircuitFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_frame_copy(s : GraphconnectcircuitFrame) -> GraphconnectcircuitFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_frame_fill(s : GraphconnectcircuitFrame, v : Double) -> GraphconnectcircuitFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_frame_min(s : GraphconnectcircuitFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_frame_max(s : GraphconnectcircuitFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_frame_to_string(s : GraphconnectcircuitFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_table_make(size : Int) -> GraphconnectcircuitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_table_len(s : GraphconnectcircuitTable) -> Int { s.size }

pub fn graph_connect_circuit_table_get(s : GraphconnectcircuitTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_table_set(s : GraphconnectcircuitTable, i : Int, v : Double) -> GraphconnectcircuitTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_table_sum(s : GraphconnectcircuitTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_table_mean(s : GraphconnectcircuitTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_table_scale(s : GraphconnectcircuitTable, f : Double) -> GraphconnectcircuitTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_table_add(a : GraphconnectcircuitTable, b : GraphconnectcircuitTable) -> GraphconnectcircuitTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_table_copy(s : GraphconnectcircuitTable) -> GraphconnectcircuitTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_table_fill(s : GraphconnectcircuitTable, v : Double) -> GraphconnectcircuitTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_table_min(s : GraphconnectcircuitTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_table_max(s : GraphconnectcircuitTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_table_to_string(s : GraphconnectcircuitTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_graphn_make(size : Int) -> GraphconnectcircuitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_graphn_len(s : GraphconnectcircuitGraphN) -> Int { s.size }

pub fn graph_connect_circuit_graphn_get(s : GraphconnectcircuitGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_graphn_set(s : GraphconnectcircuitGraphN, i : Int, v : Double) -> GraphconnectcircuitGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_graphn_sum(s : GraphconnectcircuitGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_graphn_mean(s : GraphconnectcircuitGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_graphn_scale(s : GraphconnectcircuitGraphN, f : Double) -> GraphconnectcircuitGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_graphn_add(a : GraphconnectcircuitGraphN, b : GraphconnectcircuitGraphN) -> GraphconnectcircuitGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_graphn_copy(s : GraphconnectcircuitGraphN) -> GraphconnectcircuitGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_graphn_fill(s : GraphconnectcircuitGraphN, v : Double) -> GraphconnectcircuitGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_graphn_min(s : GraphconnectcircuitGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_graphn_max(s : GraphconnectcircuitGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_graphn_to_string(s : GraphconnectcircuitGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_node_make(size : Int) -> GraphconnectcircuitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_node_len(s : GraphconnectcircuitNode) -> Int { s.size }

pub fn graph_connect_circuit_node_get(s : GraphconnectcircuitNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_node_set(s : GraphconnectcircuitNode, i : Int, v : Double) -> GraphconnectcircuitNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_node_sum(s : GraphconnectcircuitNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_node_mean(s : GraphconnectcircuitNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_node_scale(s : GraphconnectcircuitNode, f : Double) -> GraphconnectcircuitNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_node_add(a : GraphconnectcircuitNode, b : GraphconnectcircuitNode) -> GraphconnectcircuitNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_node_copy(s : GraphconnectcircuitNode) -> GraphconnectcircuitNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_node_fill(s : GraphconnectcircuitNode, v : Double) -> GraphconnectcircuitNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_node_min(s : GraphconnectcircuitNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_node_max(s : GraphconnectcircuitNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_node_to_string(s : GraphconnectcircuitNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_edge_make(size : Int) -> GraphconnectcircuitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_edge_len(s : GraphconnectcircuitEdge) -> Int { s.size }

pub fn graph_connect_circuit_edge_get(s : GraphconnectcircuitEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_edge_set(s : GraphconnectcircuitEdge, i : Int, v : Double) -> GraphconnectcircuitEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_edge_sum(s : GraphconnectcircuitEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_edge_mean(s : GraphconnectcircuitEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_edge_scale(s : GraphconnectcircuitEdge, f : Double) -> GraphconnectcircuitEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_edge_add(a : GraphconnectcircuitEdge, b : GraphconnectcircuitEdge) -> GraphconnectcircuitEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_edge_copy(s : GraphconnectcircuitEdge) -> GraphconnectcircuitEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_edge_fill(s : GraphconnectcircuitEdge, v : Double) -> GraphconnectcircuitEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_edge_min(s : GraphconnectcircuitEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_edge_max(s : GraphconnectcircuitEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_edge_to_string(s : GraphconnectcircuitEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_path_make(size : Int) -> GraphconnectcircuitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_path_len(s : GraphconnectcircuitPath) -> Int { s.size }

pub fn graph_connect_circuit_path_get(s : GraphconnectcircuitPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_path_set(s : GraphconnectcircuitPath, i : Int, v : Double) -> GraphconnectcircuitPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_path_sum(s : GraphconnectcircuitPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_path_mean(s : GraphconnectcircuitPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_path_scale(s : GraphconnectcircuitPath, f : Double) -> GraphconnectcircuitPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_path_add(a : GraphconnectcircuitPath, b : GraphconnectcircuitPath) -> GraphconnectcircuitPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_path_copy(s : GraphconnectcircuitPath) -> GraphconnectcircuitPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_path_fill(s : GraphconnectcircuitPath, v : Double) -> GraphconnectcircuitPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_path_min(s : GraphconnectcircuitPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_path_max(s : GraphconnectcircuitPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_path_to_string(s : GraphconnectcircuitPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_cluster_make(size : Int) -> GraphconnectcircuitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_cluster_len(s : GraphconnectcircuitCluster) -> Int { s.size }

pub fn graph_connect_circuit_cluster_get(s : GraphconnectcircuitCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_cluster_set(s : GraphconnectcircuitCluster, i : Int, v : Double) -> GraphconnectcircuitCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cluster_sum(s : GraphconnectcircuitCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_cluster_mean(s : GraphconnectcircuitCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_cluster_scale(s : GraphconnectcircuitCluster, f : Double) -> GraphconnectcircuitCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cluster_add(a : GraphconnectcircuitCluster, b : GraphconnectcircuitCluster) -> GraphconnectcircuitCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_cluster_copy(s : GraphconnectcircuitCluster) -> GraphconnectcircuitCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cluster_fill(s : GraphconnectcircuitCluster, v : Double) -> GraphconnectcircuitCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cluster_min(s : GraphconnectcircuitCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_cluster_max(s : GraphconnectcircuitCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_cluster_to_string(s : GraphconnectcircuitCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_model_make(size : Int) -> GraphconnectcircuitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_model_len(s : GraphconnectcircuitModel) -> Int { s.size }

pub fn graph_connect_circuit_model_get(s : GraphconnectcircuitModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_model_set(s : GraphconnectcircuitModel, i : Int, v : Double) -> GraphconnectcircuitModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_model_sum(s : GraphconnectcircuitModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_model_mean(s : GraphconnectcircuitModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_model_scale(s : GraphconnectcircuitModel, f : Double) -> GraphconnectcircuitModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_model_add(a : GraphconnectcircuitModel, b : GraphconnectcircuitModel) -> GraphconnectcircuitModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_model_copy(s : GraphconnectcircuitModel) -> GraphconnectcircuitModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_model_fill(s : GraphconnectcircuitModel, v : Double) -> GraphconnectcircuitModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_model_min(s : GraphconnectcircuitModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_model_max(s : GraphconnectcircuitModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_model_to_string(s : GraphconnectcircuitModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_layer_make(size : Int) -> GraphconnectcircuitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_layer_len(s : GraphconnectcircuitLayer) -> Int { s.size }

pub fn graph_connect_circuit_layer_get(s : GraphconnectcircuitLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_layer_set(s : GraphconnectcircuitLayer, i : Int, v : Double) -> GraphconnectcircuitLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_layer_sum(s : GraphconnectcircuitLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_layer_mean(s : GraphconnectcircuitLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_layer_scale(s : GraphconnectcircuitLayer, f : Double) -> GraphconnectcircuitLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_layer_add(a : GraphconnectcircuitLayer, b : GraphconnectcircuitLayer) -> GraphconnectcircuitLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_layer_copy(s : GraphconnectcircuitLayer) -> GraphconnectcircuitLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_layer_fill(s : GraphconnectcircuitLayer, v : Double) -> GraphconnectcircuitLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_layer_min(s : GraphconnectcircuitLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_layer_max(s : GraphconnectcircuitLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_layer_to_string(s : GraphconnectcircuitLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_buffer_make(size : Int) -> GraphconnectcircuitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_buffer_len(s : GraphconnectcircuitBuffer) -> Int { s.size }

pub fn graph_connect_circuit_buffer_get(s : GraphconnectcircuitBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_buffer_set(s : GraphconnectcircuitBuffer, i : Int, v : Double) -> GraphconnectcircuitBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_buffer_sum(s : GraphconnectcircuitBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_buffer_mean(s : GraphconnectcircuitBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_buffer_scale(s : GraphconnectcircuitBuffer, f : Double) -> GraphconnectcircuitBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_buffer_add(a : GraphconnectcircuitBuffer, b : GraphconnectcircuitBuffer) -> GraphconnectcircuitBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_buffer_copy(s : GraphconnectcircuitBuffer) -> GraphconnectcircuitBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_buffer_fill(s : GraphconnectcircuitBuffer, v : Double) -> GraphconnectcircuitBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_buffer_min(s : GraphconnectcircuitBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_buffer_max(s : GraphconnectcircuitBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_buffer_to_string(s : GraphconnectcircuitBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_cursor_make(size : Int) -> GraphconnectcircuitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_cursor_len(s : GraphconnectcircuitCursor) -> Int { s.size }

pub fn graph_connect_circuit_cursor_get(s : GraphconnectcircuitCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_cursor_set(s : GraphconnectcircuitCursor, i : Int, v : Double) -> GraphconnectcircuitCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cursor_sum(s : GraphconnectcircuitCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_cursor_mean(s : GraphconnectcircuitCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_cursor_scale(s : GraphconnectcircuitCursor, f : Double) -> GraphconnectcircuitCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cursor_add(a : GraphconnectcircuitCursor, b : GraphconnectcircuitCursor) -> GraphconnectcircuitCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_cursor_copy(s : GraphconnectcircuitCursor) -> GraphconnectcircuitCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cursor_fill(s : GraphconnectcircuitCursor, v : Double) -> GraphconnectcircuitCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cursor_min(s : GraphconnectcircuitCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_cursor_max(s : GraphconnectcircuitCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_cursor_to_string(s : GraphconnectcircuitCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_view_make(size : Int) -> GraphconnectcircuitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_view_len(s : GraphconnectcircuitView) -> Int { s.size }

pub fn graph_connect_circuit_view_get(s : GraphconnectcircuitView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_view_set(s : GraphconnectcircuitView, i : Int, v : Double) -> GraphconnectcircuitView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_view_sum(s : GraphconnectcircuitView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_view_mean(s : GraphconnectcircuitView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_view_scale(s : GraphconnectcircuitView, f : Double) -> GraphconnectcircuitView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_view_add(a : GraphconnectcircuitView, b : GraphconnectcircuitView) -> GraphconnectcircuitView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_view_copy(s : GraphconnectcircuitView) -> GraphconnectcircuitView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_view_fill(s : GraphconnectcircuitView, v : Double) -> GraphconnectcircuitView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_view_min(s : GraphconnectcircuitView) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_view_max(s : GraphconnectcircuitView) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_view_to_string(s : GraphconnectcircuitView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_range_make(size : Int) -> GraphconnectcircuitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_range_len(s : GraphconnectcircuitRange) -> Int { s.size }

pub fn graph_connect_circuit_range_get(s : GraphconnectcircuitRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_range_set(s : GraphconnectcircuitRange, i : Int, v : Double) -> GraphconnectcircuitRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_range_sum(s : GraphconnectcircuitRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_range_mean(s : GraphconnectcircuitRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_range_scale(s : GraphconnectcircuitRange, f : Double) -> GraphconnectcircuitRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_range_add(a : GraphconnectcircuitRange, b : GraphconnectcircuitRange) -> GraphconnectcircuitRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_range_copy(s : GraphconnectcircuitRange) -> GraphconnectcircuitRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_range_fill(s : GraphconnectcircuitRange, v : Double) -> GraphconnectcircuitRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_range_min(s : GraphconnectcircuitRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_range_max(s : GraphconnectcircuitRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_range_to_string(s : GraphconnectcircuitRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_slice_make(size : Int) -> GraphconnectcircuitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_slice_len(s : GraphconnectcircuitSlice) -> Int { s.size }

pub fn graph_connect_circuit_slice_get(s : GraphconnectcircuitSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_slice_set(s : GraphconnectcircuitSlice, i : Int, v : Double) -> GraphconnectcircuitSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_slice_sum(s : GraphconnectcircuitSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_slice_mean(s : GraphconnectcircuitSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_slice_scale(s : GraphconnectcircuitSlice, f : Double) -> GraphconnectcircuitSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_slice_add(a : GraphconnectcircuitSlice, b : GraphconnectcircuitSlice) -> GraphconnectcircuitSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_slice_copy(s : GraphconnectcircuitSlice) -> GraphconnectcircuitSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_slice_fill(s : GraphconnectcircuitSlice, v : Double) -> GraphconnectcircuitSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_slice_min(s : GraphconnectcircuitSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_slice_max(s : GraphconnectcircuitSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_slice_to_string(s : GraphconnectcircuitSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

