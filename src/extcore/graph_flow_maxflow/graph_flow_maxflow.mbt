///===
/// extcore/graph_flow_maxflow

pub(all) struct GraphflowmaxflowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_maxflow_make_point(x : Double, y : Double) -> GraphflowmaxflowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_maxflow_make_point3(x : Double, y : Double, z : Double) -> GraphflowmaxflowPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowmaxflowPoint::x(self : GraphflowmaxflowPoint) -> Double { self.x }

pub fn GraphflowmaxflowPoint::y(self : GraphflowmaxflowPoint) -> Double { self.y }

pub fn GraphflowmaxflowPoint::z(self : GraphflowmaxflowPoint) -> Double { self.z }

pub fn GraphflowmaxflowPoint::label(self : GraphflowmaxflowPoint) -> Int { self.label }

pub fn GraphflowmaxflowPoint::dist(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowmaxflowPoint::add(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowmaxflowPoint::sub(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowmaxflowPoint::scale(self : GraphflowmaxflowPoint, s : Double) -> GraphflowmaxflowPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowmaxflowPoint::dot(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowmaxflowPoint::cross(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowmaxflowPoint::norm(self : GraphflowmaxflowPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowmaxflowPoint::normalize(self : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmaxflowPoint::negate(self : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowmaxflowPoint::mid(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowmaxflowPoint::lerp(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint, t : Double) -> GraphflowmaxflowPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowmaxflowPoint::to_string(self : GraphflowmaxflowPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowmaxflowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_maxflow_make_series(vals : Array[Double], name : String) -> GraphflowmaxflowSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowmaxflowSeries::len(self : GraphflowmaxflowSeries) -> Int { self.vals.length() }

pub fn GraphflowmaxflowSeries::sum(self : GraphflowmaxflowSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowmaxflowSeries::mean(self : GraphflowmaxflowSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowmaxflowSeries::min(self : GraphflowmaxflowSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowmaxflowSeries::max(self : GraphflowmaxflowSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowmaxflowSeries::range(self : GraphflowmaxflowSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowmaxflowSeries::variance(self : GraphflowmaxflowSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowmaxflowSeries::std(self : GraphflowmaxflowSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowmaxflowSeries::median(self : GraphflowmaxflowSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowmaxflowSeries::scale(self : GraphflowmaxflowSeries, f : Double) -> GraphflowmaxflowSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowmaxflowSeries::add(self : GraphflowmaxflowSeries, other : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowmaxflowSeries::sub(self : GraphflowmaxflowSeries, other : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowmaxflowSeries::normalize(self : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowmaxflowSeries::cumsum(self : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowmaxflowSeries::to_string(self : GraphflowmaxflowSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmaxflowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_maxflow_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmaxflowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_maxflow_matrix_identity(n : Int) -> GraphflowmaxflowMatrix {
  let m = graph_flow_maxflow_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowmaxflowMatrix::get(self : GraphflowmaxflowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowmaxflowMatrix::transpose(self : GraphflowmaxflowMatrix) -> GraphflowmaxflowMatrix {
  let result = graph_flow_maxflow_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowmaxflowMatrix::add(self : GraphflowmaxflowMatrix, other : GraphflowmaxflowMatrix) -> GraphflowmaxflowMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_maxflow_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowmaxflowMatrix::scale(self : GraphflowmaxflowMatrix, s : Double) -> GraphflowmaxflowMatrix {
  let result = graph_flow_maxflow_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowmaxflowMatrix::multiply(self : GraphflowmaxflowMatrix, other : GraphflowmaxflowMatrix) -> GraphflowmaxflowMatrix {
  if self.cols != other.rows { return graph_flow_maxflow_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_maxflow_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphflowmaxflowMatrix::trace(self : GraphflowmaxflowMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowmaxflowMatrix::det(self : GraphflowmaxflowMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowmaxflowMatrix::norm(self : GraphflowmaxflowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowmaxflowMatrix::to_string(self : GraphflowmaxflowMatrix) -> String {
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

pub(all) struct GraphflowmaxflowVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_maxflow_make_vector(comps : Array[Double]) -> GraphflowmaxflowVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_maxflow_vector_zero(dim : Int) -> GraphflowmaxflowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowmaxflowVector::add(self : GraphflowmaxflowVector, other : GraphflowmaxflowVector) -> GraphflowmaxflowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmaxflowVector::sub(self : GraphflowmaxflowVector, other : GraphflowmaxflowVector) -> GraphflowmaxflowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmaxflowVector::scale(self : GraphflowmaxflowVector, s : Double) -> GraphflowmaxflowVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowmaxflowVector::dot(self : GraphflowmaxflowVector, other : GraphflowmaxflowVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowmaxflowVector::norm(self : GraphflowmaxflowVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowmaxflowVector::normalize(self : GraphflowmaxflowVector) -> GraphflowmaxflowVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmaxflowVector::dist(self : GraphflowmaxflowVector, other : GraphflowmaxflowVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowmaxflowVector::to_string(self : GraphflowmaxflowVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmaxflowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_frame_make(size : Int) -> GraphflowmaxflowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowFrame::len(self : GraphflowmaxflowFrame) -> Int { self.size }

pub fn GraphflowmaxflowFrame::get(self : GraphflowmaxflowFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowFrame::set(self : GraphflowmaxflowFrame, i : Int, v : Double) -> GraphflowmaxflowFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowFrame::sum(self : GraphflowmaxflowFrame) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowFrame::mean(self : GraphflowmaxflowFrame) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowFrame::scale(self : GraphflowmaxflowFrame, f : Double) -> GraphflowmaxflowFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowFrame::add(self : GraphflowmaxflowFrame, other : GraphflowmaxflowFrame) -> GraphflowmaxflowFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowFrame::copy(self : GraphflowmaxflowFrame) -> GraphflowmaxflowFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowFrame::fill(self : GraphflowmaxflowFrame, v : Double) -> GraphflowmaxflowFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowFrame::min(self : GraphflowmaxflowFrame) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowFrame::max(self : GraphflowmaxflowFrame) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowFrame::to_string(self : GraphflowmaxflowFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_table_make(size : Int) -> GraphflowmaxflowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowTable::len(self : GraphflowmaxflowTable) -> Int { self.size }

pub fn GraphflowmaxflowTable::get(self : GraphflowmaxflowTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowTable::set(self : GraphflowmaxflowTable, i : Int, v : Double) -> GraphflowmaxflowTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowTable::sum(self : GraphflowmaxflowTable) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowTable::mean(self : GraphflowmaxflowTable) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowTable::scale(self : GraphflowmaxflowTable, f : Double) -> GraphflowmaxflowTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowTable::add(self : GraphflowmaxflowTable, other : GraphflowmaxflowTable) -> GraphflowmaxflowTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowTable::copy(self : GraphflowmaxflowTable) -> GraphflowmaxflowTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowTable::fill(self : GraphflowmaxflowTable, v : Double) -> GraphflowmaxflowTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowTable::min(self : GraphflowmaxflowTable) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowTable::max(self : GraphflowmaxflowTable) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowTable::to_string(self : GraphflowmaxflowTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_graphn_make(size : Int) -> GraphflowmaxflowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowGraphN::len(self : GraphflowmaxflowGraphN) -> Int { self.size }

pub fn GraphflowmaxflowGraphN::get(self : GraphflowmaxflowGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowGraphN::set(self : GraphflowmaxflowGraphN, i : Int, v : Double) -> GraphflowmaxflowGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowGraphN::sum(self : GraphflowmaxflowGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowGraphN::mean(self : GraphflowmaxflowGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowGraphN::scale(self : GraphflowmaxflowGraphN, f : Double) -> GraphflowmaxflowGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowGraphN::add(self : GraphflowmaxflowGraphN, other : GraphflowmaxflowGraphN) -> GraphflowmaxflowGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowGraphN::copy(self : GraphflowmaxflowGraphN) -> GraphflowmaxflowGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowGraphN::fill(self : GraphflowmaxflowGraphN, v : Double) -> GraphflowmaxflowGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowGraphN::min(self : GraphflowmaxflowGraphN) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowGraphN::max(self : GraphflowmaxflowGraphN) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowGraphN::to_string(self : GraphflowmaxflowGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_node_make(size : Int) -> GraphflowmaxflowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowNode::len(self : GraphflowmaxflowNode) -> Int { self.size }

pub fn GraphflowmaxflowNode::get(self : GraphflowmaxflowNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowNode::set(self : GraphflowmaxflowNode, i : Int, v : Double) -> GraphflowmaxflowNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowNode::sum(self : GraphflowmaxflowNode) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowNode::mean(self : GraphflowmaxflowNode) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowNode::scale(self : GraphflowmaxflowNode, f : Double) -> GraphflowmaxflowNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowNode::add(self : GraphflowmaxflowNode, other : GraphflowmaxflowNode) -> GraphflowmaxflowNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowNode::copy(self : GraphflowmaxflowNode) -> GraphflowmaxflowNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowNode::fill(self : GraphflowmaxflowNode, v : Double) -> GraphflowmaxflowNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowNode::min(self : GraphflowmaxflowNode) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowNode::max(self : GraphflowmaxflowNode) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowNode::to_string(self : GraphflowmaxflowNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_edge_make(size : Int) -> GraphflowmaxflowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowEdge::len(self : GraphflowmaxflowEdge) -> Int { self.size }

pub fn GraphflowmaxflowEdge::get(self : GraphflowmaxflowEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowEdge::set(self : GraphflowmaxflowEdge, i : Int, v : Double) -> GraphflowmaxflowEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowEdge::sum(self : GraphflowmaxflowEdge) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowEdge::mean(self : GraphflowmaxflowEdge) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowEdge::scale(self : GraphflowmaxflowEdge, f : Double) -> GraphflowmaxflowEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowEdge::add(self : GraphflowmaxflowEdge, other : GraphflowmaxflowEdge) -> GraphflowmaxflowEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowEdge::copy(self : GraphflowmaxflowEdge) -> GraphflowmaxflowEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowEdge::fill(self : GraphflowmaxflowEdge, v : Double) -> GraphflowmaxflowEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowEdge::min(self : GraphflowmaxflowEdge) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowEdge::max(self : GraphflowmaxflowEdge) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowEdge::to_string(self : GraphflowmaxflowEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_path_make(size : Int) -> GraphflowmaxflowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowPath::len(self : GraphflowmaxflowPath) -> Int { self.size }

pub fn GraphflowmaxflowPath::get(self : GraphflowmaxflowPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowPath::set(self : GraphflowmaxflowPath, i : Int, v : Double) -> GraphflowmaxflowPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowPath::sum(self : GraphflowmaxflowPath) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowPath::mean(self : GraphflowmaxflowPath) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowPath::scale(self : GraphflowmaxflowPath, f : Double) -> GraphflowmaxflowPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowPath::add(self : GraphflowmaxflowPath, other : GraphflowmaxflowPath) -> GraphflowmaxflowPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowPath::copy(self : GraphflowmaxflowPath) -> GraphflowmaxflowPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowPath::fill(self : GraphflowmaxflowPath, v : Double) -> GraphflowmaxflowPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowPath::min(self : GraphflowmaxflowPath) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowPath::max(self : GraphflowmaxflowPath) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowPath::to_string(self : GraphflowmaxflowPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_cluster_make(size : Int) -> GraphflowmaxflowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowCluster::len(self : GraphflowmaxflowCluster) -> Int { self.size }

pub fn GraphflowmaxflowCluster::get(self : GraphflowmaxflowCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowCluster::set(self : GraphflowmaxflowCluster, i : Int, v : Double) -> GraphflowmaxflowCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowCluster::sum(self : GraphflowmaxflowCluster) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowCluster::mean(self : GraphflowmaxflowCluster) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowCluster::scale(self : GraphflowmaxflowCluster, f : Double) -> GraphflowmaxflowCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowCluster::add(self : GraphflowmaxflowCluster, other : GraphflowmaxflowCluster) -> GraphflowmaxflowCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowCluster::copy(self : GraphflowmaxflowCluster) -> GraphflowmaxflowCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowCluster::fill(self : GraphflowmaxflowCluster, v : Double) -> GraphflowmaxflowCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowCluster::min(self : GraphflowmaxflowCluster) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowCluster::max(self : GraphflowmaxflowCluster) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowCluster::to_string(self : GraphflowmaxflowCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_model_make(size : Int) -> GraphflowmaxflowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowModel::len(self : GraphflowmaxflowModel) -> Int { self.size }

pub fn GraphflowmaxflowModel::get(self : GraphflowmaxflowModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowModel::set(self : GraphflowmaxflowModel, i : Int, v : Double) -> GraphflowmaxflowModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowModel::sum(self : GraphflowmaxflowModel) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowModel::mean(self : GraphflowmaxflowModel) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowModel::scale(self : GraphflowmaxflowModel, f : Double) -> GraphflowmaxflowModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowModel::add(self : GraphflowmaxflowModel, other : GraphflowmaxflowModel) -> GraphflowmaxflowModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowModel::copy(self : GraphflowmaxflowModel) -> GraphflowmaxflowModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowModel::fill(self : GraphflowmaxflowModel, v : Double) -> GraphflowmaxflowModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowModel::min(self : GraphflowmaxflowModel) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowModel::max(self : GraphflowmaxflowModel) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowModel::to_string(self : GraphflowmaxflowModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_layer_make(size : Int) -> GraphflowmaxflowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowLayer::len(self : GraphflowmaxflowLayer) -> Int { self.size }

pub fn GraphflowmaxflowLayer::get(self : GraphflowmaxflowLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowLayer::set(self : GraphflowmaxflowLayer, i : Int, v : Double) -> GraphflowmaxflowLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowLayer::sum(self : GraphflowmaxflowLayer) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowLayer::mean(self : GraphflowmaxflowLayer) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowLayer::scale(self : GraphflowmaxflowLayer, f : Double) -> GraphflowmaxflowLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowLayer::add(self : GraphflowmaxflowLayer, other : GraphflowmaxflowLayer) -> GraphflowmaxflowLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowLayer::copy(self : GraphflowmaxflowLayer) -> GraphflowmaxflowLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowLayer::fill(self : GraphflowmaxflowLayer, v : Double) -> GraphflowmaxflowLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowLayer::min(self : GraphflowmaxflowLayer) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowLayer::max(self : GraphflowmaxflowLayer) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowLayer::to_string(self : GraphflowmaxflowLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_buffer_make(size : Int) -> GraphflowmaxflowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowBuffer::len(self : GraphflowmaxflowBuffer) -> Int { self.size }

pub fn GraphflowmaxflowBuffer::get(self : GraphflowmaxflowBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowBuffer::set(self : GraphflowmaxflowBuffer, i : Int, v : Double) -> GraphflowmaxflowBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowBuffer::sum(self : GraphflowmaxflowBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowBuffer::mean(self : GraphflowmaxflowBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowBuffer::scale(self : GraphflowmaxflowBuffer, f : Double) -> GraphflowmaxflowBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowBuffer::add(self : GraphflowmaxflowBuffer, other : GraphflowmaxflowBuffer) -> GraphflowmaxflowBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowBuffer::copy(self : GraphflowmaxflowBuffer) -> GraphflowmaxflowBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowBuffer::fill(self : GraphflowmaxflowBuffer, v : Double) -> GraphflowmaxflowBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowBuffer::min(self : GraphflowmaxflowBuffer) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowBuffer::max(self : GraphflowmaxflowBuffer) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowBuffer::to_string(self : GraphflowmaxflowBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_cursor_make(size : Int) -> GraphflowmaxflowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowCursor::len(self : GraphflowmaxflowCursor) -> Int { self.size }

pub fn GraphflowmaxflowCursor::get(self : GraphflowmaxflowCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowCursor::set(self : GraphflowmaxflowCursor, i : Int, v : Double) -> GraphflowmaxflowCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowCursor::sum(self : GraphflowmaxflowCursor) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowCursor::mean(self : GraphflowmaxflowCursor) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowCursor::scale(self : GraphflowmaxflowCursor, f : Double) -> GraphflowmaxflowCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowCursor::add(self : GraphflowmaxflowCursor, other : GraphflowmaxflowCursor) -> GraphflowmaxflowCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowCursor::copy(self : GraphflowmaxflowCursor) -> GraphflowmaxflowCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowCursor::fill(self : GraphflowmaxflowCursor, v : Double) -> GraphflowmaxflowCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowCursor::min(self : GraphflowmaxflowCursor) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowCursor::max(self : GraphflowmaxflowCursor) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowCursor::to_string(self : GraphflowmaxflowCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_view_make(size : Int) -> GraphflowmaxflowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowView::len(self : GraphflowmaxflowView) -> Int { self.size }

pub fn GraphflowmaxflowView::get(self : GraphflowmaxflowView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowView::set(self : GraphflowmaxflowView, i : Int, v : Double) -> GraphflowmaxflowView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowView::sum(self : GraphflowmaxflowView) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowView::mean(self : GraphflowmaxflowView) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowView::scale(self : GraphflowmaxflowView, f : Double) -> GraphflowmaxflowView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowView::add(self : GraphflowmaxflowView, other : GraphflowmaxflowView) -> GraphflowmaxflowView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowView::copy(self : GraphflowmaxflowView) -> GraphflowmaxflowView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowView::fill(self : GraphflowmaxflowView, v : Double) -> GraphflowmaxflowView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowView::min(self : GraphflowmaxflowView) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowView::max(self : GraphflowmaxflowView) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowView::to_string(self : GraphflowmaxflowView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_range_make(size : Int) -> GraphflowmaxflowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowRange::len(self : GraphflowmaxflowRange) -> Int { self.size }

pub fn GraphflowmaxflowRange::get(self : GraphflowmaxflowRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowRange::set(self : GraphflowmaxflowRange, i : Int, v : Double) -> GraphflowmaxflowRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowRange::sum(self : GraphflowmaxflowRange) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowRange::mean(self : GraphflowmaxflowRange) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowRange::scale(self : GraphflowmaxflowRange, f : Double) -> GraphflowmaxflowRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowRange::add(self : GraphflowmaxflowRange, other : GraphflowmaxflowRange) -> GraphflowmaxflowRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowRange::copy(self : GraphflowmaxflowRange) -> GraphflowmaxflowRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowRange::fill(self : GraphflowmaxflowRange, v : Double) -> GraphflowmaxflowRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowRange::min(self : GraphflowmaxflowRange) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowRange::max(self : GraphflowmaxflowRange) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowRange::to_string(self : GraphflowmaxflowRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_slice_make(size : Int) -> GraphflowmaxflowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmaxflowSlice::len(self : GraphflowmaxflowSlice) -> Int { self.size }

pub fn GraphflowmaxflowSlice::get(self : GraphflowmaxflowSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmaxflowSlice::set(self : GraphflowmaxflowSlice, i : Int, v : Double) -> GraphflowmaxflowSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowSlice::sum(self : GraphflowmaxflowSlice) -> Double { @_common.sum(self.data) }

pub fn GraphflowmaxflowSlice::mean(self : GraphflowmaxflowSlice) -> Double { @_common.mean(self.data) }

pub fn GraphflowmaxflowSlice::scale(self : GraphflowmaxflowSlice, f : Double) -> GraphflowmaxflowSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowSlice::add(self : GraphflowmaxflowSlice, other : GraphflowmaxflowSlice) -> GraphflowmaxflowSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmaxflowSlice::copy(self : GraphflowmaxflowSlice) -> GraphflowmaxflowSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowSlice::fill(self : GraphflowmaxflowSlice, v : Double) -> GraphflowmaxflowSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmaxflowSlice::min(self : GraphflowmaxflowSlice) -> Double { @_common.min(self.data) }

pub fn GraphflowmaxflowSlice::max(self : GraphflowmaxflowSlice) -> Double { @_common.max(self.data) }

pub fn GraphflowmaxflowSlice::to_string(self : GraphflowmaxflowSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

