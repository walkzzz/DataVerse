///===
/// extcore/graph_connect_bridge

pub(all) struct GraphconnectbridgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_bridge_make_point(x : Double, y : Double) -> GraphconnectbridgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_bridge_make_point3(x : Double, y : Double, z : Double) -> GraphconnectbridgePoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectbridgePoint::x(self : GraphconnectbridgePoint) -> Double { self.x }

pub fn GraphconnectbridgePoint::y(self : GraphconnectbridgePoint) -> Double { self.y }

pub fn GraphconnectbridgePoint::z(self : GraphconnectbridgePoint) -> Double { self.z }

pub fn GraphconnectbridgePoint::label(self : GraphconnectbridgePoint) -> Int { self.label }

pub fn GraphconnectbridgePoint::dist(self : GraphconnectbridgePoint, other : GraphconnectbridgePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectbridgePoint::add(self : GraphconnectbridgePoint, other : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectbridgePoint::sub(self : GraphconnectbridgePoint, other : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectbridgePoint::scale(self : GraphconnectbridgePoint, s : Double) -> GraphconnectbridgePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectbridgePoint::dot(self : GraphconnectbridgePoint, other : GraphconnectbridgePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectbridgePoint::cross(self : GraphconnectbridgePoint, other : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectbridgePoint::norm(self : GraphconnectbridgePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectbridgePoint::normalize(self : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectbridgePoint::negate(self : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectbridgePoint::mid(self : GraphconnectbridgePoint, other : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectbridgePoint::lerp(self : GraphconnectbridgePoint, other : GraphconnectbridgePoint, t : Double) -> GraphconnectbridgePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectbridgePoint::to_string(self : GraphconnectbridgePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectbridgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_bridge_make_series(vals : Array[Double], name : String) -> GraphconnectbridgeSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectbridgeSeries::len(self : GraphconnectbridgeSeries) -> Int { self.vals.length() }

pub fn GraphconnectbridgeSeries::sum(self : GraphconnectbridgeSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectbridgeSeries::mean(self : GraphconnectbridgeSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectbridgeSeries::min(self : GraphconnectbridgeSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectbridgeSeries::max(self : GraphconnectbridgeSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectbridgeSeries::range(self : GraphconnectbridgeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectbridgeSeries::variance(self : GraphconnectbridgeSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectbridgeSeries::std(self : GraphconnectbridgeSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectbridgeSeries::median(self : GraphconnectbridgeSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectbridgeSeries::scale(self : GraphconnectbridgeSeries, f : Double) -> GraphconnectbridgeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectbridgeSeries::add(self : GraphconnectbridgeSeries, other : GraphconnectbridgeSeries) -> GraphconnectbridgeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectbridgeSeries::sub(self : GraphconnectbridgeSeries, other : GraphconnectbridgeSeries) -> GraphconnectbridgeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectbridgeSeries::normalize(self : GraphconnectbridgeSeries) -> GraphconnectbridgeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectbridgeSeries::cumsum(self : GraphconnectbridgeSeries) -> GraphconnectbridgeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectbridgeSeries::to_string(self : GraphconnectbridgeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectbridgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_bridge_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectbridgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_bridge_matrix_identity(n : Int) -> GraphconnectbridgeMatrix {
  let m = graph_connect_bridge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectbridgeMatrix::get(self : GraphconnectbridgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectbridgeMatrix::transpose(self : GraphconnectbridgeMatrix) -> GraphconnectbridgeMatrix {
  let result = graph_connect_bridge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectbridgeMatrix::add(self : GraphconnectbridgeMatrix, other : GraphconnectbridgeMatrix) -> GraphconnectbridgeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_bridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectbridgeMatrix::scale(self : GraphconnectbridgeMatrix, s : Double) -> GraphconnectbridgeMatrix {
  let result = graph_connect_bridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectbridgeMatrix::multiply(self : GraphconnectbridgeMatrix, other : GraphconnectbridgeMatrix) -> GraphconnectbridgeMatrix {
  if self.cols != other.rows { return graph_connect_bridge_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_bridge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnectbridgeMatrix::trace(self : GraphconnectbridgeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectbridgeMatrix::det(self : GraphconnectbridgeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectbridgeMatrix::norm(self : GraphconnectbridgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectbridgeMatrix::to_string(self : GraphconnectbridgeMatrix) -> String {
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

pub(all) struct GraphconnectbridgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_bridge_make_vector(comps : Array[Double]) -> GraphconnectbridgeVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_bridge_vector_zero(dim : Int) -> GraphconnectbridgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectbridgeVector::add(self : GraphconnectbridgeVector, other : GraphconnectbridgeVector) -> GraphconnectbridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectbridgeVector::sub(self : GraphconnectbridgeVector, other : GraphconnectbridgeVector) -> GraphconnectbridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectbridgeVector::scale(self : GraphconnectbridgeVector, s : Double) -> GraphconnectbridgeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectbridgeVector::dot(self : GraphconnectbridgeVector, other : GraphconnectbridgeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectbridgeVector::norm(self : GraphconnectbridgeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectbridgeVector::normalize(self : GraphconnectbridgeVector) -> GraphconnectbridgeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectbridgeVector::dist(self : GraphconnectbridgeVector, other : GraphconnectbridgeVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectbridgeVector::to_string(self : GraphconnectbridgeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_bridge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_bridge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_bridge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_bridge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_bridge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_bridge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_bridge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_bridge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_bridge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_bridge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_bridge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_bridge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_bridge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_bridge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_bridge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_bridge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_bridge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_bridge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_bridge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_bridge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_bridge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_bridge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_bridge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_bridge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_bridge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_bridge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_bridge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_bridge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_bridge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectbridgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_frame_make(size : Int) -> GraphconnectbridgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_frame_len(s : GraphconnectbridgeFrame) -> Int { s.size }

pub fn graph_connect_bridge_frame_get(s : GraphconnectbridgeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_frame_set(s : GraphconnectbridgeFrame, i : Int, v : Double) -> GraphconnectbridgeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_frame_sum(s : GraphconnectbridgeFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_frame_mean(s : GraphconnectbridgeFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_frame_scale(s : GraphconnectbridgeFrame, f : Double) -> GraphconnectbridgeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_frame_add(a : GraphconnectbridgeFrame, b : GraphconnectbridgeFrame) -> GraphconnectbridgeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_frame_copy(s : GraphconnectbridgeFrame) -> GraphconnectbridgeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_frame_fill(s : GraphconnectbridgeFrame, v : Double) -> GraphconnectbridgeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_frame_min(s : GraphconnectbridgeFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_frame_max(s : GraphconnectbridgeFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_frame_to_string(s : GraphconnectbridgeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_table_make(size : Int) -> GraphconnectbridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_table_len(s : GraphconnectbridgeTable) -> Int { s.size }

pub fn graph_connect_bridge_table_get(s : GraphconnectbridgeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_table_set(s : GraphconnectbridgeTable, i : Int, v : Double) -> GraphconnectbridgeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_table_sum(s : GraphconnectbridgeTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_table_mean(s : GraphconnectbridgeTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_table_scale(s : GraphconnectbridgeTable, f : Double) -> GraphconnectbridgeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_table_add(a : GraphconnectbridgeTable, b : GraphconnectbridgeTable) -> GraphconnectbridgeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_table_copy(s : GraphconnectbridgeTable) -> GraphconnectbridgeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_table_fill(s : GraphconnectbridgeTable, v : Double) -> GraphconnectbridgeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_table_min(s : GraphconnectbridgeTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_table_max(s : GraphconnectbridgeTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_table_to_string(s : GraphconnectbridgeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_graphn_make(size : Int) -> GraphconnectbridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_graphn_len(s : GraphconnectbridgeGraphN) -> Int { s.size }

pub fn graph_connect_bridge_graphn_get(s : GraphconnectbridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_graphn_set(s : GraphconnectbridgeGraphN, i : Int, v : Double) -> GraphconnectbridgeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_graphn_sum(s : GraphconnectbridgeGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_graphn_mean(s : GraphconnectbridgeGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_graphn_scale(s : GraphconnectbridgeGraphN, f : Double) -> GraphconnectbridgeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_graphn_add(a : GraphconnectbridgeGraphN, b : GraphconnectbridgeGraphN) -> GraphconnectbridgeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_graphn_copy(s : GraphconnectbridgeGraphN) -> GraphconnectbridgeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_graphn_fill(s : GraphconnectbridgeGraphN, v : Double) -> GraphconnectbridgeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_graphn_min(s : GraphconnectbridgeGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_graphn_max(s : GraphconnectbridgeGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_graphn_to_string(s : GraphconnectbridgeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_node_make(size : Int) -> GraphconnectbridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_node_len(s : GraphconnectbridgeNode) -> Int { s.size }

pub fn graph_connect_bridge_node_get(s : GraphconnectbridgeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_node_set(s : GraphconnectbridgeNode, i : Int, v : Double) -> GraphconnectbridgeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_node_sum(s : GraphconnectbridgeNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_node_mean(s : GraphconnectbridgeNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_node_scale(s : GraphconnectbridgeNode, f : Double) -> GraphconnectbridgeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_node_add(a : GraphconnectbridgeNode, b : GraphconnectbridgeNode) -> GraphconnectbridgeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_node_copy(s : GraphconnectbridgeNode) -> GraphconnectbridgeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_node_fill(s : GraphconnectbridgeNode, v : Double) -> GraphconnectbridgeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_node_min(s : GraphconnectbridgeNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_node_max(s : GraphconnectbridgeNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_node_to_string(s : GraphconnectbridgeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_edge_make(size : Int) -> GraphconnectbridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_edge_len(s : GraphconnectbridgeEdge) -> Int { s.size }

pub fn graph_connect_bridge_edge_get(s : GraphconnectbridgeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_edge_set(s : GraphconnectbridgeEdge, i : Int, v : Double) -> GraphconnectbridgeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_edge_sum(s : GraphconnectbridgeEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_edge_mean(s : GraphconnectbridgeEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_edge_scale(s : GraphconnectbridgeEdge, f : Double) -> GraphconnectbridgeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_edge_add(a : GraphconnectbridgeEdge, b : GraphconnectbridgeEdge) -> GraphconnectbridgeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_edge_copy(s : GraphconnectbridgeEdge) -> GraphconnectbridgeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_edge_fill(s : GraphconnectbridgeEdge, v : Double) -> GraphconnectbridgeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_edge_min(s : GraphconnectbridgeEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_edge_max(s : GraphconnectbridgeEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_edge_to_string(s : GraphconnectbridgeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_path_make(size : Int) -> GraphconnectbridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_path_len(s : GraphconnectbridgePath) -> Int { s.size }

pub fn graph_connect_bridge_path_get(s : GraphconnectbridgePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_path_set(s : GraphconnectbridgePath, i : Int, v : Double) -> GraphconnectbridgePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_path_sum(s : GraphconnectbridgePath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_path_mean(s : GraphconnectbridgePath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_path_scale(s : GraphconnectbridgePath, f : Double) -> GraphconnectbridgePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_path_add(a : GraphconnectbridgePath, b : GraphconnectbridgePath) -> GraphconnectbridgePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_path_copy(s : GraphconnectbridgePath) -> GraphconnectbridgePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_path_fill(s : GraphconnectbridgePath, v : Double) -> GraphconnectbridgePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_path_min(s : GraphconnectbridgePath) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_path_max(s : GraphconnectbridgePath) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_path_to_string(s : GraphconnectbridgePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_cluster_make(size : Int) -> GraphconnectbridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_cluster_len(s : GraphconnectbridgeCluster) -> Int { s.size }

pub fn graph_connect_bridge_cluster_get(s : GraphconnectbridgeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_cluster_set(s : GraphconnectbridgeCluster, i : Int, v : Double) -> GraphconnectbridgeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cluster_sum(s : GraphconnectbridgeCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_cluster_mean(s : GraphconnectbridgeCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_cluster_scale(s : GraphconnectbridgeCluster, f : Double) -> GraphconnectbridgeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cluster_add(a : GraphconnectbridgeCluster, b : GraphconnectbridgeCluster) -> GraphconnectbridgeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_cluster_copy(s : GraphconnectbridgeCluster) -> GraphconnectbridgeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cluster_fill(s : GraphconnectbridgeCluster, v : Double) -> GraphconnectbridgeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cluster_min(s : GraphconnectbridgeCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_cluster_max(s : GraphconnectbridgeCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_cluster_to_string(s : GraphconnectbridgeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_model_make(size : Int) -> GraphconnectbridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_model_len(s : GraphconnectbridgeModel) -> Int { s.size }

pub fn graph_connect_bridge_model_get(s : GraphconnectbridgeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_model_set(s : GraphconnectbridgeModel, i : Int, v : Double) -> GraphconnectbridgeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_model_sum(s : GraphconnectbridgeModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_model_mean(s : GraphconnectbridgeModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_model_scale(s : GraphconnectbridgeModel, f : Double) -> GraphconnectbridgeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_model_add(a : GraphconnectbridgeModel, b : GraphconnectbridgeModel) -> GraphconnectbridgeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_model_copy(s : GraphconnectbridgeModel) -> GraphconnectbridgeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_model_fill(s : GraphconnectbridgeModel, v : Double) -> GraphconnectbridgeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_model_min(s : GraphconnectbridgeModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_model_max(s : GraphconnectbridgeModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_model_to_string(s : GraphconnectbridgeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_layer_make(size : Int) -> GraphconnectbridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_layer_len(s : GraphconnectbridgeLayer) -> Int { s.size }

pub fn graph_connect_bridge_layer_get(s : GraphconnectbridgeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_layer_set(s : GraphconnectbridgeLayer, i : Int, v : Double) -> GraphconnectbridgeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_layer_sum(s : GraphconnectbridgeLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_layer_mean(s : GraphconnectbridgeLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_layer_scale(s : GraphconnectbridgeLayer, f : Double) -> GraphconnectbridgeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_layer_add(a : GraphconnectbridgeLayer, b : GraphconnectbridgeLayer) -> GraphconnectbridgeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_layer_copy(s : GraphconnectbridgeLayer) -> GraphconnectbridgeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_layer_fill(s : GraphconnectbridgeLayer, v : Double) -> GraphconnectbridgeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_layer_min(s : GraphconnectbridgeLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_layer_max(s : GraphconnectbridgeLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_layer_to_string(s : GraphconnectbridgeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_buffer_make(size : Int) -> GraphconnectbridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_buffer_len(s : GraphconnectbridgeBuffer) -> Int { s.size }

pub fn graph_connect_bridge_buffer_get(s : GraphconnectbridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_buffer_set(s : GraphconnectbridgeBuffer, i : Int, v : Double) -> GraphconnectbridgeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_buffer_sum(s : GraphconnectbridgeBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_buffer_mean(s : GraphconnectbridgeBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_buffer_scale(s : GraphconnectbridgeBuffer, f : Double) -> GraphconnectbridgeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_buffer_add(a : GraphconnectbridgeBuffer, b : GraphconnectbridgeBuffer) -> GraphconnectbridgeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_buffer_copy(s : GraphconnectbridgeBuffer) -> GraphconnectbridgeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_buffer_fill(s : GraphconnectbridgeBuffer, v : Double) -> GraphconnectbridgeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_buffer_min(s : GraphconnectbridgeBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_buffer_max(s : GraphconnectbridgeBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_buffer_to_string(s : GraphconnectbridgeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_cursor_make(size : Int) -> GraphconnectbridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_cursor_len(s : GraphconnectbridgeCursor) -> Int { s.size }

pub fn graph_connect_bridge_cursor_get(s : GraphconnectbridgeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_cursor_set(s : GraphconnectbridgeCursor, i : Int, v : Double) -> GraphconnectbridgeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cursor_sum(s : GraphconnectbridgeCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_cursor_mean(s : GraphconnectbridgeCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_cursor_scale(s : GraphconnectbridgeCursor, f : Double) -> GraphconnectbridgeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cursor_add(a : GraphconnectbridgeCursor, b : GraphconnectbridgeCursor) -> GraphconnectbridgeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_cursor_copy(s : GraphconnectbridgeCursor) -> GraphconnectbridgeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cursor_fill(s : GraphconnectbridgeCursor, v : Double) -> GraphconnectbridgeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cursor_min(s : GraphconnectbridgeCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_cursor_max(s : GraphconnectbridgeCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_cursor_to_string(s : GraphconnectbridgeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_view_make(size : Int) -> GraphconnectbridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_view_len(s : GraphconnectbridgeView) -> Int { s.size }

pub fn graph_connect_bridge_view_get(s : GraphconnectbridgeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_view_set(s : GraphconnectbridgeView, i : Int, v : Double) -> GraphconnectbridgeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_view_sum(s : GraphconnectbridgeView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_view_mean(s : GraphconnectbridgeView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_view_scale(s : GraphconnectbridgeView, f : Double) -> GraphconnectbridgeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_view_add(a : GraphconnectbridgeView, b : GraphconnectbridgeView) -> GraphconnectbridgeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_view_copy(s : GraphconnectbridgeView) -> GraphconnectbridgeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_view_fill(s : GraphconnectbridgeView, v : Double) -> GraphconnectbridgeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_view_min(s : GraphconnectbridgeView) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_view_max(s : GraphconnectbridgeView) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_view_to_string(s : GraphconnectbridgeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_range_make(size : Int) -> GraphconnectbridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_range_len(s : GraphconnectbridgeRange) -> Int { s.size }

pub fn graph_connect_bridge_range_get(s : GraphconnectbridgeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_range_set(s : GraphconnectbridgeRange, i : Int, v : Double) -> GraphconnectbridgeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_range_sum(s : GraphconnectbridgeRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_range_mean(s : GraphconnectbridgeRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_range_scale(s : GraphconnectbridgeRange, f : Double) -> GraphconnectbridgeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_range_add(a : GraphconnectbridgeRange, b : GraphconnectbridgeRange) -> GraphconnectbridgeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_range_copy(s : GraphconnectbridgeRange) -> GraphconnectbridgeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_range_fill(s : GraphconnectbridgeRange, v : Double) -> GraphconnectbridgeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_range_min(s : GraphconnectbridgeRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_range_max(s : GraphconnectbridgeRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_range_to_string(s : GraphconnectbridgeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_slice_make(size : Int) -> GraphconnectbridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_slice_len(s : GraphconnectbridgeSlice) -> Int { s.size }

pub fn graph_connect_bridge_slice_get(s : GraphconnectbridgeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_slice_set(s : GraphconnectbridgeSlice, i : Int, v : Double) -> GraphconnectbridgeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_slice_sum(s : GraphconnectbridgeSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_slice_mean(s : GraphconnectbridgeSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_slice_scale(s : GraphconnectbridgeSlice, f : Double) -> GraphconnectbridgeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_slice_add(a : GraphconnectbridgeSlice, b : GraphconnectbridgeSlice) -> GraphconnectbridgeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_slice_copy(s : GraphconnectbridgeSlice) -> GraphconnectbridgeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_slice_fill(s : GraphconnectbridgeSlice, v : Double) -> GraphconnectbridgeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_slice_min(s : GraphconnectbridgeSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_slice_max(s : GraphconnectbridgeSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_slice_to_string(s : GraphconnectbridgeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

