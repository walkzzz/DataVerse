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

pub fn GraphconnectbridgeFrame::len(self : GraphconnectbridgeFrame) -> Int { self.size }

pub fn GraphconnectbridgeFrame::get(self : GraphconnectbridgeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeFrame::set(self : GraphconnectbridgeFrame, i : Int, v : Double) -> GraphconnectbridgeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeFrame::sum(self : GraphconnectbridgeFrame) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeFrame::mean(self : GraphconnectbridgeFrame) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeFrame::scale(self : GraphconnectbridgeFrame, f : Double) -> GraphconnectbridgeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeFrame::add(self : GraphconnectbridgeFrame, other : GraphconnectbridgeFrame) -> GraphconnectbridgeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeFrame::copy(self : GraphconnectbridgeFrame) -> GraphconnectbridgeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeFrame::fill(self : GraphconnectbridgeFrame, v : Double) -> GraphconnectbridgeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeFrame::min(self : GraphconnectbridgeFrame) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeFrame::max(self : GraphconnectbridgeFrame) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeFrame::to_string(self : GraphconnectbridgeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_table_make(size : Int) -> GraphconnectbridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeTable::len(self : GraphconnectbridgeTable) -> Int { self.size }

pub fn GraphconnectbridgeTable::get(self : GraphconnectbridgeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeTable::set(self : GraphconnectbridgeTable, i : Int, v : Double) -> GraphconnectbridgeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeTable::sum(self : GraphconnectbridgeTable) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeTable::mean(self : GraphconnectbridgeTable) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeTable::scale(self : GraphconnectbridgeTable, f : Double) -> GraphconnectbridgeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeTable::add(self : GraphconnectbridgeTable, other : GraphconnectbridgeTable) -> GraphconnectbridgeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeTable::copy(self : GraphconnectbridgeTable) -> GraphconnectbridgeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeTable::fill(self : GraphconnectbridgeTable, v : Double) -> GraphconnectbridgeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeTable::min(self : GraphconnectbridgeTable) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeTable::max(self : GraphconnectbridgeTable) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeTable::to_string(self : GraphconnectbridgeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_graphn_make(size : Int) -> GraphconnectbridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeGraphN::len(self : GraphconnectbridgeGraphN) -> Int { self.size }

pub fn GraphconnectbridgeGraphN::get(self : GraphconnectbridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeGraphN::set(self : GraphconnectbridgeGraphN, i : Int, v : Double) -> GraphconnectbridgeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeGraphN::sum(self : GraphconnectbridgeGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeGraphN::mean(self : GraphconnectbridgeGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeGraphN::scale(self : GraphconnectbridgeGraphN, f : Double) -> GraphconnectbridgeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeGraphN::add(self : GraphconnectbridgeGraphN, other : GraphconnectbridgeGraphN) -> GraphconnectbridgeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeGraphN::copy(self : GraphconnectbridgeGraphN) -> GraphconnectbridgeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeGraphN::fill(self : GraphconnectbridgeGraphN, v : Double) -> GraphconnectbridgeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeGraphN::min(self : GraphconnectbridgeGraphN) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeGraphN::max(self : GraphconnectbridgeGraphN) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeGraphN::to_string(self : GraphconnectbridgeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_node_make(size : Int) -> GraphconnectbridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeNode::len(self : GraphconnectbridgeNode) -> Int { self.size }

pub fn GraphconnectbridgeNode::get(self : GraphconnectbridgeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeNode::set(self : GraphconnectbridgeNode, i : Int, v : Double) -> GraphconnectbridgeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeNode::sum(self : GraphconnectbridgeNode) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeNode::mean(self : GraphconnectbridgeNode) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeNode::scale(self : GraphconnectbridgeNode, f : Double) -> GraphconnectbridgeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeNode::add(self : GraphconnectbridgeNode, other : GraphconnectbridgeNode) -> GraphconnectbridgeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeNode::copy(self : GraphconnectbridgeNode) -> GraphconnectbridgeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeNode::fill(self : GraphconnectbridgeNode, v : Double) -> GraphconnectbridgeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeNode::min(self : GraphconnectbridgeNode) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeNode::max(self : GraphconnectbridgeNode) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeNode::to_string(self : GraphconnectbridgeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_edge_make(size : Int) -> GraphconnectbridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeEdge::len(self : GraphconnectbridgeEdge) -> Int { self.size }

pub fn GraphconnectbridgeEdge::get(self : GraphconnectbridgeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeEdge::set(self : GraphconnectbridgeEdge, i : Int, v : Double) -> GraphconnectbridgeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeEdge::sum(self : GraphconnectbridgeEdge) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeEdge::mean(self : GraphconnectbridgeEdge) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeEdge::scale(self : GraphconnectbridgeEdge, f : Double) -> GraphconnectbridgeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeEdge::add(self : GraphconnectbridgeEdge, other : GraphconnectbridgeEdge) -> GraphconnectbridgeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeEdge::copy(self : GraphconnectbridgeEdge) -> GraphconnectbridgeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeEdge::fill(self : GraphconnectbridgeEdge, v : Double) -> GraphconnectbridgeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeEdge::min(self : GraphconnectbridgeEdge) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeEdge::max(self : GraphconnectbridgeEdge) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeEdge::to_string(self : GraphconnectbridgeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_path_make(size : Int) -> GraphconnectbridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgePath::len(self : GraphconnectbridgePath) -> Int { self.size }

pub fn GraphconnectbridgePath::get(self : GraphconnectbridgePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgePath::set(self : GraphconnectbridgePath, i : Int, v : Double) -> GraphconnectbridgePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgePath::sum(self : GraphconnectbridgePath) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgePath::mean(self : GraphconnectbridgePath) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgePath::scale(self : GraphconnectbridgePath, f : Double) -> GraphconnectbridgePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgePath::add(self : GraphconnectbridgePath, other : GraphconnectbridgePath) -> GraphconnectbridgePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgePath::copy(self : GraphconnectbridgePath) -> GraphconnectbridgePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgePath::fill(self : GraphconnectbridgePath, v : Double) -> GraphconnectbridgePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgePath::min(self : GraphconnectbridgePath) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgePath::max(self : GraphconnectbridgePath) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgePath::to_string(self : GraphconnectbridgePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_cluster_make(size : Int) -> GraphconnectbridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeCluster::len(self : GraphconnectbridgeCluster) -> Int { self.size }

pub fn GraphconnectbridgeCluster::get(self : GraphconnectbridgeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeCluster::set(self : GraphconnectbridgeCluster, i : Int, v : Double) -> GraphconnectbridgeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeCluster::sum(self : GraphconnectbridgeCluster) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeCluster::mean(self : GraphconnectbridgeCluster) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeCluster::scale(self : GraphconnectbridgeCluster, f : Double) -> GraphconnectbridgeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeCluster::add(self : GraphconnectbridgeCluster, other : GraphconnectbridgeCluster) -> GraphconnectbridgeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeCluster::copy(self : GraphconnectbridgeCluster) -> GraphconnectbridgeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeCluster::fill(self : GraphconnectbridgeCluster, v : Double) -> GraphconnectbridgeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeCluster::min(self : GraphconnectbridgeCluster) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeCluster::max(self : GraphconnectbridgeCluster) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeCluster::to_string(self : GraphconnectbridgeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_model_make(size : Int) -> GraphconnectbridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeModel::len(self : GraphconnectbridgeModel) -> Int { self.size }

pub fn GraphconnectbridgeModel::get(self : GraphconnectbridgeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeModel::set(self : GraphconnectbridgeModel, i : Int, v : Double) -> GraphconnectbridgeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeModel::sum(self : GraphconnectbridgeModel) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeModel::mean(self : GraphconnectbridgeModel) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeModel::scale(self : GraphconnectbridgeModel, f : Double) -> GraphconnectbridgeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeModel::add(self : GraphconnectbridgeModel, other : GraphconnectbridgeModel) -> GraphconnectbridgeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeModel::copy(self : GraphconnectbridgeModel) -> GraphconnectbridgeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeModel::fill(self : GraphconnectbridgeModel, v : Double) -> GraphconnectbridgeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeModel::min(self : GraphconnectbridgeModel) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeModel::max(self : GraphconnectbridgeModel) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeModel::to_string(self : GraphconnectbridgeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_layer_make(size : Int) -> GraphconnectbridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeLayer::len(self : GraphconnectbridgeLayer) -> Int { self.size }

pub fn GraphconnectbridgeLayer::get(self : GraphconnectbridgeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeLayer::set(self : GraphconnectbridgeLayer, i : Int, v : Double) -> GraphconnectbridgeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeLayer::sum(self : GraphconnectbridgeLayer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeLayer::mean(self : GraphconnectbridgeLayer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeLayer::scale(self : GraphconnectbridgeLayer, f : Double) -> GraphconnectbridgeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeLayer::add(self : GraphconnectbridgeLayer, other : GraphconnectbridgeLayer) -> GraphconnectbridgeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeLayer::copy(self : GraphconnectbridgeLayer) -> GraphconnectbridgeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeLayer::fill(self : GraphconnectbridgeLayer, v : Double) -> GraphconnectbridgeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeLayer::min(self : GraphconnectbridgeLayer) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeLayer::max(self : GraphconnectbridgeLayer) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeLayer::to_string(self : GraphconnectbridgeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_buffer_make(size : Int) -> GraphconnectbridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeBuffer::len(self : GraphconnectbridgeBuffer) -> Int { self.size }

pub fn GraphconnectbridgeBuffer::get(self : GraphconnectbridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeBuffer::set(self : GraphconnectbridgeBuffer, i : Int, v : Double) -> GraphconnectbridgeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeBuffer::sum(self : GraphconnectbridgeBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeBuffer::mean(self : GraphconnectbridgeBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeBuffer::scale(self : GraphconnectbridgeBuffer, f : Double) -> GraphconnectbridgeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeBuffer::add(self : GraphconnectbridgeBuffer, other : GraphconnectbridgeBuffer) -> GraphconnectbridgeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeBuffer::copy(self : GraphconnectbridgeBuffer) -> GraphconnectbridgeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeBuffer::fill(self : GraphconnectbridgeBuffer, v : Double) -> GraphconnectbridgeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeBuffer::min(self : GraphconnectbridgeBuffer) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeBuffer::max(self : GraphconnectbridgeBuffer) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeBuffer::to_string(self : GraphconnectbridgeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_cursor_make(size : Int) -> GraphconnectbridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeCursor::len(self : GraphconnectbridgeCursor) -> Int { self.size }

pub fn GraphconnectbridgeCursor::get(self : GraphconnectbridgeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeCursor::set(self : GraphconnectbridgeCursor, i : Int, v : Double) -> GraphconnectbridgeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeCursor::sum(self : GraphconnectbridgeCursor) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeCursor::mean(self : GraphconnectbridgeCursor) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeCursor::scale(self : GraphconnectbridgeCursor, f : Double) -> GraphconnectbridgeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeCursor::add(self : GraphconnectbridgeCursor, other : GraphconnectbridgeCursor) -> GraphconnectbridgeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeCursor::copy(self : GraphconnectbridgeCursor) -> GraphconnectbridgeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeCursor::fill(self : GraphconnectbridgeCursor, v : Double) -> GraphconnectbridgeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeCursor::min(self : GraphconnectbridgeCursor) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeCursor::max(self : GraphconnectbridgeCursor) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeCursor::to_string(self : GraphconnectbridgeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_view_make(size : Int) -> GraphconnectbridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeView::len(self : GraphconnectbridgeView) -> Int { self.size }

pub fn GraphconnectbridgeView::get(self : GraphconnectbridgeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeView::set(self : GraphconnectbridgeView, i : Int, v : Double) -> GraphconnectbridgeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeView::sum(self : GraphconnectbridgeView) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeView::mean(self : GraphconnectbridgeView) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeView::scale(self : GraphconnectbridgeView, f : Double) -> GraphconnectbridgeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeView::add(self : GraphconnectbridgeView, other : GraphconnectbridgeView) -> GraphconnectbridgeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeView::copy(self : GraphconnectbridgeView) -> GraphconnectbridgeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeView::fill(self : GraphconnectbridgeView, v : Double) -> GraphconnectbridgeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeView::min(self : GraphconnectbridgeView) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeView::max(self : GraphconnectbridgeView) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeView::to_string(self : GraphconnectbridgeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_range_make(size : Int) -> GraphconnectbridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeRange::len(self : GraphconnectbridgeRange) -> Int { self.size }

pub fn GraphconnectbridgeRange::get(self : GraphconnectbridgeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeRange::set(self : GraphconnectbridgeRange, i : Int, v : Double) -> GraphconnectbridgeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeRange::sum(self : GraphconnectbridgeRange) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeRange::mean(self : GraphconnectbridgeRange) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeRange::scale(self : GraphconnectbridgeRange, f : Double) -> GraphconnectbridgeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeRange::add(self : GraphconnectbridgeRange, other : GraphconnectbridgeRange) -> GraphconnectbridgeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeRange::copy(self : GraphconnectbridgeRange) -> GraphconnectbridgeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeRange::fill(self : GraphconnectbridgeRange, v : Double) -> GraphconnectbridgeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeRange::min(self : GraphconnectbridgeRange) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeRange::max(self : GraphconnectbridgeRange) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeRange::to_string(self : GraphconnectbridgeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_slice_make(size : Int) -> GraphconnectbridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectbridgeSlice::len(self : GraphconnectbridgeSlice) -> Int { self.size }

pub fn GraphconnectbridgeSlice::get(self : GraphconnectbridgeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectbridgeSlice::set(self : GraphconnectbridgeSlice, i : Int, v : Double) -> GraphconnectbridgeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeSlice::sum(self : GraphconnectbridgeSlice) -> Double { @_common.sum(self.data) }

pub fn GraphconnectbridgeSlice::mean(self : GraphconnectbridgeSlice) -> Double { @_common.mean(self.data) }

pub fn GraphconnectbridgeSlice::scale(self : GraphconnectbridgeSlice, f : Double) -> GraphconnectbridgeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeSlice::add(self : GraphconnectbridgeSlice, other : GraphconnectbridgeSlice) -> GraphconnectbridgeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectbridgeSlice::copy(self : GraphconnectbridgeSlice) -> GraphconnectbridgeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeSlice::fill(self : GraphconnectbridgeSlice, v : Double) -> GraphconnectbridgeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectbridgeSlice::min(self : GraphconnectbridgeSlice) -> Double { @_common.min(self.data) }

pub fn GraphconnectbridgeSlice::max(self : GraphconnectbridgeSlice) -> Double { @_common.max(self.data) }

pub fn GraphconnectbridgeSlice::to_string(self : GraphconnectbridgeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

