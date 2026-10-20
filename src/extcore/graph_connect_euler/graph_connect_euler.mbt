///===
/// extcore/graph_connect_euler

pub(all) struct GraphconnecteulerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_euler_make_point(x : Double, y : Double) -> GraphconnecteulerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_euler_make_point3(x : Double, y : Double, z : Double) -> GraphconnecteulerPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnecteulerPoint::x(self : GraphconnecteulerPoint) -> Double { self.x }

pub fn GraphconnecteulerPoint::y(self : GraphconnecteulerPoint) -> Double { self.y }

pub fn GraphconnecteulerPoint::z(self : GraphconnecteulerPoint) -> Double { self.z }

pub fn GraphconnecteulerPoint::label(self : GraphconnecteulerPoint) -> Int { self.label }

pub fn GraphconnecteulerPoint::dist(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnecteulerPoint::add(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnecteulerPoint::sub(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnecteulerPoint::scale(self : GraphconnecteulerPoint, s : Double) -> GraphconnecteulerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnecteulerPoint::dot(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnecteulerPoint::cross(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnecteulerPoint::norm(self : GraphconnecteulerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnecteulerPoint::normalize(self : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnecteulerPoint::negate(self : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnecteulerPoint::mid(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnecteulerPoint::lerp(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint, t : Double) -> GraphconnecteulerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnecteulerPoint::to_string(self : GraphconnecteulerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnecteulerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_euler_make_series(vals : Array[Double], name : String) -> GraphconnecteulerSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnecteulerSeries::len(self : GraphconnecteulerSeries) -> Int { self.vals.length() }

pub fn GraphconnecteulerSeries::sum(self : GraphconnecteulerSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnecteulerSeries::mean(self : GraphconnecteulerSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnecteulerSeries::min(self : GraphconnecteulerSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnecteulerSeries::max(self : GraphconnecteulerSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnecteulerSeries::range(self : GraphconnecteulerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnecteulerSeries::variance(self : GraphconnecteulerSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnecteulerSeries::std(self : GraphconnecteulerSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnecteulerSeries::median(self : GraphconnecteulerSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnecteulerSeries::scale(self : GraphconnecteulerSeries, f : Double) -> GraphconnecteulerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnecteulerSeries::add(self : GraphconnecteulerSeries, other : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnecteulerSeries::sub(self : GraphconnecteulerSeries, other : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnecteulerSeries::normalize(self : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnecteulerSeries::cumsum(self : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnecteulerSeries::to_string(self : GraphconnecteulerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnecteulerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_euler_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnecteulerMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn graph_connect_euler_matrix_identity(n : Int) -> GraphconnecteulerMatrix {
  let m = graph_connect_euler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnecteulerMatrix::get(self : GraphconnecteulerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnecteulerMatrix::transpose(self : GraphconnecteulerMatrix) -> GraphconnecteulerMatrix {
  let result = graph_connect_euler_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnecteulerMatrix::add(self : GraphconnecteulerMatrix, other : GraphconnecteulerMatrix) -> GraphconnecteulerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_euler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnecteulerMatrix::scale(self : GraphconnecteulerMatrix, s : Double) -> GraphconnecteulerMatrix {
  let result = graph_connect_euler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnecteulerMatrix::multiply(self : GraphconnecteulerMatrix, other : GraphconnecteulerMatrix) -> GraphconnecteulerMatrix {
  if self.cols != other.rows { return graph_connect_euler_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_euler_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphconnecteulerMatrix::trace(self : GraphconnecteulerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnecteulerMatrix::det(self : GraphconnecteulerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnecteulerMatrix::norm(self : GraphconnecteulerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnecteulerMatrix::to_string(self : GraphconnecteulerMatrix) -> String {
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

pub(all) struct GraphconnecteulerVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_euler_make_vector(comps : Array[Double]) -> GraphconnecteulerVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_euler_vector_zero(dim : Int) -> GraphconnecteulerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnecteulerVector::add(self : GraphconnecteulerVector, other : GraphconnecteulerVector) -> GraphconnecteulerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnecteulerVector::sub(self : GraphconnecteulerVector, other : GraphconnecteulerVector) -> GraphconnecteulerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnecteulerVector::scale(self : GraphconnecteulerVector, s : Double) -> GraphconnecteulerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnecteulerVector::dot(self : GraphconnecteulerVector, other : GraphconnecteulerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnecteulerVector::norm(self : GraphconnecteulerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnecteulerVector::normalize(self : GraphconnecteulerVector) -> GraphconnecteulerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnecteulerVector::dist(self : GraphconnecteulerVector, other : GraphconnecteulerVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnecteulerVector::to_string(self : GraphconnecteulerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnecteulerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_frame_make(size : Int) -> GraphconnecteulerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerFrame::len(self : GraphconnecteulerFrame) -> Int { self.size }

pub fn GraphconnecteulerFrame::get(self : GraphconnecteulerFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerFrame::set(self : GraphconnecteulerFrame, i : Int, v : Double) -> GraphconnecteulerFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerFrame::sum(self : GraphconnecteulerFrame) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerFrame::mean(self : GraphconnecteulerFrame) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerFrame::scale(self : GraphconnecteulerFrame, f : Double) -> GraphconnecteulerFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerFrame::add(self : GraphconnecteulerFrame, other : GraphconnecteulerFrame) -> GraphconnecteulerFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerFrame::copy(self : GraphconnecteulerFrame) -> GraphconnecteulerFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerFrame::fill(self : GraphconnecteulerFrame, v : Double) -> GraphconnecteulerFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerFrame::min(self : GraphconnecteulerFrame) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerFrame::max(self : GraphconnecteulerFrame) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerFrame::to_string(self : GraphconnecteulerFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_table_make(size : Int) -> GraphconnecteulerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerTable::len(self : GraphconnecteulerTable) -> Int { self.size }

pub fn GraphconnecteulerTable::get(self : GraphconnecteulerTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerTable::set(self : GraphconnecteulerTable, i : Int, v : Double) -> GraphconnecteulerTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerTable::sum(self : GraphconnecteulerTable) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerTable::mean(self : GraphconnecteulerTable) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerTable::scale(self : GraphconnecteulerTable, f : Double) -> GraphconnecteulerTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerTable::add(self : GraphconnecteulerTable, other : GraphconnecteulerTable) -> GraphconnecteulerTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerTable::copy(self : GraphconnecteulerTable) -> GraphconnecteulerTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerTable::fill(self : GraphconnecteulerTable, v : Double) -> GraphconnecteulerTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerTable::min(self : GraphconnecteulerTable) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerTable::max(self : GraphconnecteulerTable) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerTable::to_string(self : GraphconnecteulerTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_graphn_make(size : Int) -> GraphconnecteulerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerGraphN::len(self : GraphconnecteulerGraphN) -> Int { self.size }

pub fn GraphconnecteulerGraphN::get(self : GraphconnecteulerGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerGraphN::set(self : GraphconnecteulerGraphN, i : Int, v : Double) -> GraphconnecteulerGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerGraphN::sum(self : GraphconnecteulerGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerGraphN::mean(self : GraphconnecteulerGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerGraphN::scale(self : GraphconnecteulerGraphN, f : Double) -> GraphconnecteulerGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerGraphN::add(self : GraphconnecteulerGraphN, other : GraphconnecteulerGraphN) -> GraphconnecteulerGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerGraphN::copy(self : GraphconnecteulerGraphN) -> GraphconnecteulerGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerGraphN::fill(self : GraphconnecteulerGraphN, v : Double) -> GraphconnecteulerGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerGraphN::min(self : GraphconnecteulerGraphN) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerGraphN::max(self : GraphconnecteulerGraphN) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerGraphN::to_string(self : GraphconnecteulerGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_node_make(size : Int) -> GraphconnecteulerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerNode::len(self : GraphconnecteulerNode) -> Int { self.size }

pub fn GraphconnecteulerNode::get(self : GraphconnecteulerNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerNode::set(self : GraphconnecteulerNode, i : Int, v : Double) -> GraphconnecteulerNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerNode::sum(self : GraphconnecteulerNode) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerNode::mean(self : GraphconnecteulerNode) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerNode::scale(self : GraphconnecteulerNode, f : Double) -> GraphconnecteulerNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerNode::add(self : GraphconnecteulerNode, other : GraphconnecteulerNode) -> GraphconnecteulerNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerNode::copy(self : GraphconnecteulerNode) -> GraphconnecteulerNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerNode::fill(self : GraphconnecteulerNode, v : Double) -> GraphconnecteulerNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerNode::min(self : GraphconnecteulerNode) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerNode::max(self : GraphconnecteulerNode) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerNode::to_string(self : GraphconnecteulerNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_edge_make(size : Int) -> GraphconnecteulerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerEdge::len(self : GraphconnecteulerEdge) -> Int { self.size }

pub fn GraphconnecteulerEdge::get(self : GraphconnecteulerEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerEdge::set(self : GraphconnecteulerEdge, i : Int, v : Double) -> GraphconnecteulerEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerEdge::sum(self : GraphconnecteulerEdge) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerEdge::mean(self : GraphconnecteulerEdge) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerEdge::scale(self : GraphconnecteulerEdge, f : Double) -> GraphconnecteulerEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerEdge::add(self : GraphconnecteulerEdge, other : GraphconnecteulerEdge) -> GraphconnecteulerEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerEdge::copy(self : GraphconnecteulerEdge) -> GraphconnecteulerEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerEdge::fill(self : GraphconnecteulerEdge, v : Double) -> GraphconnecteulerEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerEdge::min(self : GraphconnecteulerEdge) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerEdge::max(self : GraphconnecteulerEdge) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerEdge::to_string(self : GraphconnecteulerEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_path_make(size : Int) -> GraphconnecteulerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerPath::len(self : GraphconnecteulerPath) -> Int { self.size }

pub fn GraphconnecteulerPath::get(self : GraphconnecteulerPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerPath::set(self : GraphconnecteulerPath, i : Int, v : Double) -> GraphconnecteulerPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerPath::sum(self : GraphconnecteulerPath) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerPath::mean(self : GraphconnecteulerPath) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerPath::scale(self : GraphconnecteulerPath, f : Double) -> GraphconnecteulerPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerPath::add(self : GraphconnecteulerPath, other : GraphconnecteulerPath) -> GraphconnecteulerPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerPath::copy(self : GraphconnecteulerPath) -> GraphconnecteulerPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerPath::fill(self : GraphconnecteulerPath, v : Double) -> GraphconnecteulerPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerPath::min(self : GraphconnecteulerPath) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerPath::max(self : GraphconnecteulerPath) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerPath::to_string(self : GraphconnecteulerPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_cluster_make(size : Int) -> GraphconnecteulerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerCluster::len(self : GraphconnecteulerCluster) -> Int { self.size }

pub fn GraphconnecteulerCluster::get(self : GraphconnecteulerCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerCluster::set(self : GraphconnecteulerCluster, i : Int, v : Double) -> GraphconnecteulerCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerCluster::sum(self : GraphconnecteulerCluster) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerCluster::mean(self : GraphconnecteulerCluster) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerCluster::scale(self : GraphconnecteulerCluster, f : Double) -> GraphconnecteulerCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerCluster::add(self : GraphconnecteulerCluster, other : GraphconnecteulerCluster) -> GraphconnecteulerCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerCluster::copy(self : GraphconnecteulerCluster) -> GraphconnecteulerCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerCluster::fill(self : GraphconnecteulerCluster, v : Double) -> GraphconnecteulerCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerCluster::min(self : GraphconnecteulerCluster) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerCluster::max(self : GraphconnecteulerCluster) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerCluster::to_string(self : GraphconnecteulerCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_model_make(size : Int) -> GraphconnecteulerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerModel::len(self : GraphconnecteulerModel) -> Int { self.size }

pub fn GraphconnecteulerModel::get(self : GraphconnecteulerModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerModel::set(self : GraphconnecteulerModel, i : Int, v : Double) -> GraphconnecteulerModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerModel::sum(self : GraphconnecteulerModel) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerModel::mean(self : GraphconnecteulerModel) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerModel::scale(self : GraphconnecteulerModel, f : Double) -> GraphconnecteulerModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerModel::add(self : GraphconnecteulerModel, other : GraphconnecteulerModel) -> GraphconnecteulerModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerModel::copy(self : GraphconnecteulerModel) -> GraphconnecteulerModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerModel::fill(self : GraphconnecteulerModel, v : Double) -> GraphconnecteulerModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerModel::min(self : GraphconnecteulerModel) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerModel::max(self : GraphconnecteulerModel) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerModel::to_string(self : GraphconnecteulerModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_layer_make(size : Int) -> GraphconnecteulerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerLayer::len(self : GraphconnecteulerLayer) -> Int { self.size }

pub fn GraphconnecteulerLayer::get(self : GraphconnecteulerLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerLayer::set(self : GraphconnecteulerLayer, i : Int, v : Double) -> GraphconnecteulerLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerLayer::sum(self : GraphconnecteulerLayer) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerLayer::mean(self : GraphconnecteulerLayer) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerLayer::scale(self : GraphconnecteulerLayer, f : Double) -> GraphconnecteulerLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerLayer::add(self : GraphconnecteulerLayer, other : GraphconnecteulerLayer) -> GraphconnecteulerLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerLayer::copy(self : GraphconnecteulerLayer) -> GraphconnecteulerLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerLayer::fill(self : GraphconnecteulerLayer, v : Double) -> GraphconnecteulerLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerLayer::min(self : GraphconnecteulerLayer) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerLayer::max(self : GraphconnecteulerLayer) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerLayer::to_string(self : GraphconnecteulerLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_buffer_make(size : Int) -> GraphconnecteulerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerBuffer::len(self : GraphconnecteulerBuffer) -> Int { self.size }

pub fn GraphconnecteulerBuffer::get(self : GraphconnecteulerBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerBuffer::set(self : GraphconnecteulerBuffer, i : Int, v : Double) -> GraphconnecteulerBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerBuffer::sum(self : GraphconnecteulerBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerBuffer::mean(self : GraphconnecteulerBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerBuffer::scale(self : GraphconnecteulerBuffer, f : Double) -> GraphconnecteulerBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerBuffer::add(self : GraphconnecteulerBuffer, other : GraphconnecteulerBuffer) -> GraphconnecteulerBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerBuffer::copy(self : GraphconnecteulerBuffer) -> GraphconnecteulerBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerBuffer::fill(self : GraphconnecteulerBuffer, v : Double) -> GraphconnecteulerBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerBuffer::min(self : GraphconnecteulerBuffer) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerBuffer::max(self : GraphconnecteulerBuffer) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerBuffer::to_string(self : GraphconnecteulerBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_cursor_make(size : Int) -> GraphconnecteulerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerCursor::len(self : GraphconnecteulerCursor) -> Int { self.size }

pub fn GraphconnecteulerCursor::get(self : GraphconnecteulerCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerCursor::set(self : GraphconnecteulerCursor, i : Int, v : Double) -> GraphconnecteulerCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerCursor::sum(self : GraphconnecteulerCursor) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerCursor::mean(self : GraphconnecteulerCursor) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerCursor::scale(self : GraphconnecteulerCursor, f : Double) -> GraphconnecteulerCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerCursor::add(self : GraphconnecteulerCursor, other : GraphconnecteulerCursor) -> GraphconnecteulerCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerCursor::copy(self : GraphconnecteulerCursor) -> GraphconnecteulerCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerCursor::fill(self : GraphconnecteulerCursor, v : Double) -> GraphconnecteulerCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerCursor::min(self : GraphconnecteulerCursor) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerCursor::max(self : GraphconnecteulerCursor) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerCursor::to_string(self : GraphconnecteulerCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_view_make(size : Int) -> GraphconnecteulerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerView::len(self : GraphconnecteulerView) -> Int { self.size }

pub fn GraphconnecteulerView::get(self : GraphconnecteulerView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerView::set(self : GraphconnecteulerView, i : Int, v : Double) -> GraphconnecteulerView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerView::sum(self : GraphconnecteulerView) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerView::mean(self : GraphconnecteulerView) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerView::scale(self : GraphconnecteulerView, f : Double) -> GraphconnecteulerView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerView::add(self : GraphconnecteulerView, other : GraphconnecteulerView) -> GraphconnecteulerView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerView::copy(self : GraphconnecteulerView) -> GraphconnecteulerView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerView::fill(self : GraphconnecteulerView, v : Double) -> GraphconnecteulerView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerView::min(self : GraphconnecteulerView) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerView::max(self : GraphconnecteulerView) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerView::to_string(self : GraphconnecteulerView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_range_make(size : Int) -> GraphconnecteulerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerRange::len(self : GraphconnecteulerRange) -> Int { self.size }

pub fn GraphconnecteulerRange::get(self : GraphconnecteulerRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerRange::set(self : GraphconnecteulerRange, i : Int, v : Double) -> GraphconnecteulerRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerRange::sum(self : GraphconnecteulerRange) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerRange::mean(self : GraphconnecteulerRange) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerRange::scale(self : GraphconnecteulerRange, f : Double) -> GraphconnecteulerRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerRange::add(self : GraphconnecteulerRange, other : GraphconnecteulerRange) -> GraphconnecteulerRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerRange::copy(self : GraphconnecteulerRange) -> GraphconnecteulerRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerRange::fill(self : GraphconnecteulerRange, v : Double) -> GraphconnecteulerRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerRange::min(self : GraphconnecteulerRange) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerRange::max(self : GraphconnecteulerRange) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerRange::to_string(self : GraphconnecteulerRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_slice_make(size : Int) -> GraphconnecteulerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnecteulerSlice::len(self : GraphconnecteulerSlice) -> Int { self.size }

pub fn GraphconnecteulerSlice::get(self : GraphconnecteulerSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnecteulerSlice::set(self : GraphconnecteulerSlice, i : Int, v : Double) -> GraphconnecteulerSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerSlice::sum(self : GraphconnecteulerSlice) -> Double { @_common.sum(self.data) }

pub fn GraphconnecteulerSlice::mean(self : GraphconnecteulerSlice) -> Double { @_common.mean(self.data) }

pub fn GraphconnecteulerSlice::scale(self : GraphconnecteulerSlice, f : Double) -> GraphconnecteulerSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerSlice::add(self : GraphconnecteulerSlice, other : GraphconnecteulerSlice) -> GraphconnecteulerSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnecteulerSlice::copy(self : GraphconnecteulerSlice) -> GraphconnecteulerSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerSlice::fill(self : GraphconnecteulerSlice, v : Double) -> GraphconnecteulerSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnecteulerSlice::min(self : GraphconnecteulerSlice) -> Double { @_common.min(self.data) }

pub fn GraphconnecteulerSlice::max(self : GraphconnecteulerSlice) -> Double { @_common.max(self.data) }

pub fn GraphconnecteulerSlice::to_string(self : GraphconnecteulerSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

