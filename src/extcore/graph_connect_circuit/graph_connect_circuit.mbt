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
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
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
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
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

pub(all) struct GraphconnectcircuitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_frame_make(size : Int) -> GraphconnectcircuitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitFrame::len(self : GraphconnectcircuitFrame) -> Int { self.size }

pub fn GraphconnectcircuitFrame::get(self : GraphconnectcircuitFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitFrame::set(self : GraphconnectcircuitFrame, i : Int, v : Double) -> GraphconnectcircuitFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitFrame::sum(self : GraphconnectcircuitFrame) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitFrame::mean(self : GraphconnectcircuitFrame) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitFrame::scale(self : GraphconnectcircuitFrame, f : Double) -> GraphconnectcircuitFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitFrame::add(self : GraphconnectcircuitFrame, other : GraphconnectcircuitFrame) -> GraphconnectcircuitFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitFrame::copy(self : GraphconnectcircuitFrame) -> GraphconnectcircuitFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitFrame::fill(self : GraphconnectcircuitFrame, v : Double) -> GraphconnectcircuitFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitFrame::min(self : GraphconnectcircuitFrame) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitFrame::max(self : GraphconnectcircuitFrame) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitFrame::to_string(self : GraphconnectcircuitFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_table_make(size : Int) -> GraphconnectcircuitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitTable::len(self : GraphconnectcircuitTable) -> Int { self.size }

pub fn GraphconnectcircuitTable::get(self : GraphconnectcircuitTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitTable::set(self : GraphconnectcircuitTable, i : Int, v : Double) -> GraphconnectcircuitTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitTable::sum(self : GraphconnectcircuitTable) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitTable::mean(self : GraphconnectcircuitTable) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitTable::scale(self : GraphconnectcircuitTable, f : Double) -> GraphconnectcircuitTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitTable::add(self : GraphconnectcircuitTable, other : GraphconnectcircuitTable) -> GraphconnectcircuitTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitTable::copy(self : GraphconnectcircuitTable) -> GraphconnectcircuitTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitTable::fill(self : GraphconnectcircuitTable, v : Double) -> GraphconnectcircuitTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitTable::min(self : GraphconnectcircuitTable) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitTable::max(self : GraphconnectcircuitTable) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitTable::to_string(self : GraphconnectcircuitTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_graphn_make(size : Int) -> GraphconnectcircuitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitGraphN::len(self : GraphconnectcircuitGraphN) -> Int { self.size }

pub fn GraphconnectcircuitGraphN::get(self : GraphconnectcircuitGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitGraphN::set(self : GraphconnectcircuitGraphN, i : Int, v : Double) -> GraphconnectcircuitGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitGraphN::sum(self : GraphconnectcircuitGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitGraphN::mean(self : GraphconnectcircuitGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitGraphN::scale(self : GraphconnectcircuitGraphN, f : Double) -> GraphconnectcircuitGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitGraphN::add(self : GraphconnectcircuitGraphN, other : GraphconnectcircuitGraphN) -> GraphconnectcircuitGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitGraphN::copy(self : GraphconnectcircuitGraphN) -> GraphconnectcircuitGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitGraphN::fill(self : GraphconnectcircuitGraphN, v : Double) -> GraphconnectcircuitGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitGraphN::min(self : GraphconnectcircuitGraphN) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitGraphN::max(self : GraphconnectcircuitGraphN) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitGraphN::to_string(self : GraphconnectcircuitGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_node_make(size : Int) -> GraphconnectcircuitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitNode::len(self : GraphconnectcircuitNode) -> Int { self.size }

pub fn GraphconnectcircuitNode::get(self : GraphconnectcircuitNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitNode::set(self : GraphconnectcircuitNode, i : Int, v : Double) -> GraphconnectcircuitNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitNode::sum(self : GraphconnectcircuitNode) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitNode::mean(self : GraphconnectcircuitNode) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitNode::scale(self : GraphconnectcircuitNode, f : Double) -> GraphconnectcircuitNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitNode::add(self : GraphconnectcircuitNode, other : GraphconnectcircuitNode) -> GraphconnectcircuitNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitNode::copy(self : GraphconnectcircuitNode) -> GraphconnectcircuitNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitNode::fill(self : GraphconnectcircuitNode, v : Double) -> GraphconnectcircuitNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitNode::min(self : GraphconnectcircuitNode) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitNode::max(self : GraphconnectcircuitNode) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitNode::to_string(self : GraphconnectcircuitNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_edge_make(size : Int) -> GraphconnectcircuitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitEdge::len(self : GraphconnectcircuitEdge) -> Int { self.size }

pub fn GraphconnectcircuitEdge::get(self : GraphconnectcircuitEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitEdge::set(self : GraphconnectcircuitEdge, i : Int, v : Double) -> GraphconnectcircuitEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitEdge::sum(self : GraphconnectcircuitEdge) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitEdge::mean(self : GraphconnectcircuitEdge) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitEdge::scale(self : GraphconnectcircuitEdge, f : Double) -> GraphconnectcircuitEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitEdge::add(self : GraphconnectcircuitEdge, other : GraphconnectcircuitEdge) -> GraphconnectcircuitEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitEdge::copy(self : GraphconnectcircuitEdge) -> GraphconnectcircuitEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitEdge::fill(self : GraphconnectcircuitEdge, v : Double) -> GraphconnectcircuitEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitEdge::min(self : GraphconnectcircuitEdge) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitEdge::max(self : GraphconnectcircuitEdge) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitEdge::to_string(self : GraphconnectcircuitEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_path_make(size : Int) -> GraphconnectcircuitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitPath::len(self : GraphconnectcircuitPath) -> Int { self.size }

pub fn GraphconnectcircuitPath::get(self : GraphconnectcircuitPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitPath::set(self : GraphconnectcircuitPath, i : Int, v : Double) -> GraphconnectcircuitPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitPath::sum(self : GraphconnectcircuitPath) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitPath::mean(self : GraphconnectcircuitPath) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitPath::scale(self : GraphconnectcircuitPath, f : Double) -> GraphconnectcircuitPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitPath::add(self : GraphconnectcircuitPath, other : GraphconnectcircuitPath) -> GraphconnectcircuitPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitPath::copy(self : GraphconnectcircuitPath) -> GraphconnectcircuitPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitPath::fill(self : GraphconnectcircuitPath, v : Double) -> GraphconnectcircuitPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitPath::min(self : GraphconnectcircuitPath) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitPath::max(self : GraphconnectcircuitPath) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitPath::to_string(self : GraphconnectcircuitPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_cluster_make(size : Int) -> GraphconnectcircuitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitCluster::len(self : GraphconnectcircuitCluster) -> Int { self.size }

pub fn GraphconnectcircuitCluster::get(self : GraphconnectcircuitCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitCluster::set(self : GraphconnectcircuitCluster, i : Int, v : Double) -> GraphconnectcircuitCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitCluster::sum(self : GraphconnectcircuitCluster) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitCluster::mean(self : GraphconnectcircuitCluster) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitCluster::scale(self : GraphconnectcircuitCluster, f : Double) -> GraphconnectcircuitCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitCluster::add(self : GraphconnectcircuitCluster, other : GraphconnectcircuitCluster) -> GraphconnectcircuitCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitCluster::copy(self : GraphconnectcircuitCluster) -> GraphconnectcircuitCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitCluster::fill(self : GraphconnectcircuitCluster, v : Double) -> GraphconnectcircuitCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitCluster::min(self : GraphconnectcircuitCluster) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitCluster::max(self : GraphconnectcircuitCluster) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitCluster::to_string(self : GraphconnectcircuitCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_model_make(size : Int) -> GraphconnectcircuitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitModel::len(self : GraphconnectcircuitModel) -> Int { self.size }

pub fn GraphconnectcircuitModel::get(self : GraphconnectcircuitModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitModel::set(self : GraphconnectcircuitModel, i : Int, v : Double) -> GraphconnectcircuitModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitModel::sum(self : GraphconnectcircuitModel) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitModel::mean(self : GraphconnectcircuitModel) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitModel::scale(self : GraphconnectcircuitModel, f : Double) -> GraphconnectcircuitModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitModel::add(self : GraphconnectcircuitModel, other : GraphconnectcircuitModel) -> GraphconnectcircuitModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitModel::copy(self : GraphconnectcircuitModel) -> GraphconnectcircuitModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitModel::fill(self : GraphconnectcircuitModel, v : Double) -> GraphconnectcircuitModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitModel::min(self : GraphconnectcircuitModel) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitModel::max(self : GraphconnectcircuitModel) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitModel::to_string(self : GraphconnectcircuitModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_layer_make(size : Int) -> GraphconnectcircuitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitLayer::len(self : GraphconnectcircuitLayer) -> Int { self.size }

pub fn GraphconnectcircuitLayer::get(self : GraphconnectcircuitLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitLayer::set(self : GraphconnectcircuitLayer, i : Int, v : Double) -> GraphconnectcircuitLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitLayer::sum(self : GraphconnectcircuitLayer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitLayer::mean(self : GraphconnectcircuitLayer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitLayer::scale(self : GraphconnectcircuitLayer, f : Double) -> GraphconnectcircuitLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitLayer::add(self : GraphconnectcircuitLayer, other : GraphconnectcircuitLayer) -> GraphconnectcircuitLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitLayer::copy(self : GraphconnectcircuitLayer) -> GraphconnectcircuitLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitLayer::fill(self : GraphconnectcircuitLayer, v : Double) -> GraphconnectcircuitLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitLayer::min(self : GraphconnectcircuitLayer) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitLayer::max(self : GraphconnectcircuitLayer) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitLayer::to_string(self : GraphconnectcircuitLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_buffer_make(size : Int) -> GraphconnectcircuitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitBuffer::len(self : GraphconnectcircuitBuffer) -> Int { self.size }

pub fn GraphconnectcircuitBuffer::get(self : GraphconnectcircuitBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitBuffer::set(self : GraphconnectcircuitBuffer, i : Int, v : Double) -> GraphconnectcircuitBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitBuffer::sum(self : GraphconnectcircuitBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitBuffer::mean(self : GraphconnectcircuitBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitBuffer::scale(self : GraphconnectcircuitBuffer, f : Double) -> GraphconnectcircuitBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitBuffer::add(self : GraphconnectcircuitBuffer, other : GraphconnectcircuitBuffer) -> GraphconnectcircuitBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitBuffer::copy(self : GraphconnectcircuitBuffer) -> GraphconnectcircuitBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitBuffer::fill(self : GraphconnectcircuitBuffer, v : Double) -> GraphconnectcircuitBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitBuffer::min(self : GraphconnectcircuitBuffer) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitBuffer::max(self : GraphconnectcircuitBuffer) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitBuffer::to_string(self : GraphconnectcircuitBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_cursor_make(size : Int) -> GraphconnectcircuitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitCursor::len(self : GraphconnectcircuitCursor) -> Int { self.size }

pub fn GraphconnectcircuitCursor::get(self : GraphconnectcircuitCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitCursor::set(self : GraphconnectcircuitCursor, i : Int, v : Double) -> GraphconnectcircuitCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitCursor::sum(self : GraphconnectcircuitCursor) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitCursor::mean(self : GraphconnectcircuitCursor) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitCursor::scale(self : GraphconnectcircuitCursor, f : Double) -> GraphconnectcircuitCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitCursor::add(self : GraphconnectcircuitCursor, other : GraphconnectcircuitCursor) -> GraphconnectcircuitCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitCursor::copy(self : GraphconnectcircuitCursor) -> GraphconnectcircuitCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitCursor::fill(self : GraphconnectcircuitCursor, v : Double) -> GraphconnectcircuitCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitCursor::min(self : GraphconnectcircuitCursor) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitCursor::max(self : GraphconnectcircuitCursor) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitCursor::to_string(self : GraphconnectcircuitCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_view_make(size : Int) -> GraphconnectcircuitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitView::len(self : GraphconnectcircuitView) -> Int { self.size }

pub fn GraphconnectcircuitView::get(self : GraphconnectcircuitView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitView::set(self : GraphconnectcircuitView, i : Int, v : Double) -> GraphconnectcircuitView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitView::sum(self : GraphconnectcircuitView) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitView::mean(self : GraphconnectcircuitView) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitView::scale(self : GraphconnectcircuitView, f : Double) -> GraphconnectcircuitView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitView::add(self : GraphconnectcircuitView, other : GraphconnectcircuitView) -> GraphconnectcircuitView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitView::copy(self : GraphconnectcircuitView) -> GraphconnectcircuitView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitView::fill(self : GraphconnectcircuitView, v : Double) -> GraphconnectcircuitView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitView::min(self : GraphconnectcircuitView) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitView::max(self : GraphconnectcircuitView) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitView::to_string(self : GraphconnectcircuitView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_range_make(size : Int) -> GraphconnectcircuitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitRange::len(self : GraphconnectcircuitRange) -> Int { self.size }

pub fn GraphconnectcircuitRange::get(self : GraphconnectcircuitRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitRange::set(self : GraphconnectcircuitRange, i : Int, v : Double) -> GraphconnectcircuitRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitRange::sum(self : GraphconnectcircuitRange) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitRange::mean(self : GraphconnectcircuitRange) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitRange::scale(self : GraphconnectcircuitRange, f : Double) -> GraphconnectcircuitRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitRange::add(self : GraphconnectcircuitRange, other : GraphconnectcircuitRange) -> GraphconnectcircuitRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitRange::copy(self : GraphconnectcircuitRange) -> GraphconnectcircuitRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitRange::fill(self : GraphconnectcircuitRange, v : Double) -> GraphconnectcircuitRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitRange::min(self : GraphconnectcircuitRange) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitRange::max(self : GraphconnectcircuitRange) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitRange::to_string(self : GraphconnectcircuitRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_slice_make(size : Int) -> GraphconnectcircuitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcircuitSlice::len(self : GraphconnectcircuitSlice) -> Int { self.size }

pub fn GraphconnectcircuitSlice::get(self : GraphconnectcircuitSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcircuitSlice::set(self : GraphconnectcircuitSlice, i : Int, v : Double) -> GraphconnectcircuitSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitSlice::sum(self : GraphconnectcircuitSlice) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcircuitSlice::mean(self : GraphconnectcircuitSlice) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcircuitSlice::scale(self : GraphconnectcircuitSlice, f : Double) -> GraphconnectcircuitSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitSlice::add(self : GraphconnectcircuitSlice, other : GraphconnectcircuitSlice) -> GraphconnectcircuitSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcircuitSlice::copy(self : GraphconnectcircuitSlice) -> GraphconnectcircuitSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitSlice::fill(self : GraphconnectcircuitSlice, v : Double) -> GraphconnectcircuitSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcircuitSlice::min(self : GraphconnectcircuitSlice) -> Double { @_common.min(self.data) }

pub fn GraphconnectcircuitSlice::max(self : GraphconnectcircuitSlice) -> Double { @_common.max(self.data) }

pub fn GraphconnectcircuitSlice::to_string(self : GraphconnectcircuitSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

