///===
/// extcore/graph_flow_matching

pub(all) struct GraphflowmatchingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_matching_make_point(x : Double, y : Double) -> GraphflowmatchingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_matching_make_point3(x : Double, y : Double, z : Double) -> GraphflowmatchingPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowmatchingPoint::x(self : GraphflowmatchingPoint) -> Double { self.x }

pub fn GraphflowmatchingPoint::y(self : GraphflowmatchingPoint) -> Double { self.y }

pub fn GraphflowmatchingPoint::z(self : GraphflowmatchingPoint) -> Double { self.z }

pub fn GraphflowmatchingPoint::label(self : GraphflowmatchingPoint) -> Int { self.label }

pub fn GraphflowmatchingPoint::dist(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowmatchingPoint::add(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowmatchingPoint::sub(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowmatchingPoint::scale(self : GraphflowmatchingPoint, s : Double) -> GraphflowmatchingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowmatchingPoint::dot(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowmatchingPoint::cross(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowmatchingPoint::norm(self : GraphflowmatchingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowmatchingPoint::normalize(self : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmatchingPoint::negate(self : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowmatchingPoint::mid(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowmatchingPoint::lerp(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint, t : Double) -> GraphflowmatchingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowmatchingPoint::to_string(self : GraphflowmatchingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowmatchingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_matching_make_series(vals : Array[Double], name : String) -> GraphflowmatchingSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowmatchingSeries::len(self : GraphflowmatchingSeries) -> Int { self.vals.length() }

pub fn GraphflowmatchingSeries::sum(self : GraphflowmatchingSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowmatchingSeries::mean(self : GraphflowmatchingSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowmatchingSeries::min(self : GraphflowmatchingSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowmatchingSeries::max(self : GraphflowmatchingSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowmatchingSeries::range(self : GraphflowmatchingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowmatchingSeries::variance(self : GraphflowmatchingSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowmatchingSeries::std(self : GraphflowmatchingSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowmatchingSeries::median(self : GraphflowmatchingSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowmatchingSeries::scale(self : GraphflowmatchingSeries, f : Double) -> GraphflowmatchingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowmatchingSeries::add(self : GraphflowmatchingSeries, other : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowmatchingSeries::sub(self : GraphflowmatchingSeries, other : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowmatchingSeries::normalize(self : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowmatchingSeries::cumsum(self : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowmatchingSeries::to_string(self : GraphflowmatchingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmatchingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_matching_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmatchingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_matching_matrix_identity(n : Int) -> GraphflowmatchingMatrix {
  let m = graph_flow_matching_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowmatchingMatrix::get(self : GraphflowmatchingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowmatchingMatrix::transpose(self : GraphflowmatchingMatrix) -> GraphflowmatchingMatrix {
  let result = graph_flow_matching_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowmatchingMatrix::add(self : GraphflowmatchingMatrix, other : GraphflowmatchingMatrix) -> GraphflowmatchingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_matching_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowmatchingMatrix::scale(self : GraphflowmatchingMatrix, s : Double) -> GraphflowmatchingMatrix {
  let result = graph_flow_matching_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowmatchingMatrix::multiply(self : GraphflowmatchingMatrix, other : GraphflowmatchingMatrix) -> GraphflowmatchingMatrix {
  if self.cols != other.rows { return graph_flow_matching_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_matching_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphflowmatchingMatrix::trace(self : GraphflowmatchingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowmatchingMatrix::det(self : GraphflowmatchingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowmatchingMatrix::norm(self : GraphflowmatchingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowmatchingMatrix::to_string(self : GraphflowmatchingMatrix) -> String {
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

pub(all) struct GraphflowmatchingVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_matching_make_vector(comps : Array[Double]) -> GraphflowmatchingVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_matching_vector_zero(dim : Int) -> GraphflowmatchingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowmatchingVector::add(self : GraphflowmatchingVector, other : GraphflowmatchingVector) -> GraphflowmatchingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmatchingVector::sub(self : GraphflowmatchingVector, other : GraphflowmatchingVector) -> GraphflowmatchingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmatchingVector::scale(self : GraphflowmatchingVector, s : Double) -> GraphflowmatchingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowmatchingVector::dot(self : GraphflowmatchingVector, other : GraphflowmatchingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowmatchingVector::norm(self : GraphflowmatchingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowmatchingVector::normalize(self : GraphflowmatchingVector) -> GraphflowmatchingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmatchingVector::dist(self : GraphflowmatchingVector, other : GraphflowmatchingVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowmatchingVector::to_string(self : GraphflowmatchingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmatchingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_frame_make(size : Int) -> GraphflowmatchingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingFrame::len(self : GraphflowmatchingFrame) -> Int { self.size }

pub fn GraphflowmatchingFrame::get(self : GraphflowmatchingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingFrame::set(self : GraphflowmatchingFrame, i : Int, v : Double) -> GraphflowmatchingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingFrame::sum(self : GraphflowmatchingFrame) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingFrame::mean(self : GraphflowmatchingFrame) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingFrame::scale(self : GraphflowmatchingFrame, f : Double) -> GraphflowmatchingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingFrame::add(self : GraphflowmatchingFrame, other : GraphflowmatchingFrame) -> GraphflowmatchingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingFrame::copy(self : GraphflowmatchingFrame) -> GraphflowmatchingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingFrame::fill(self : GraphflowmatchingFrame, v : Double) -> GraphflowmatchingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingFrame::min(self : GraphflowmatchingFrame) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingFrame::max(self : GraphflowmatchingFrame) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingFrame::to_string(self : GraphflowmatchingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_table_make(size : Int) -> GraphflowmatchingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingTable::len(self : GraphflowmatchingTable) -> Int { self.size }

pub fn GraphflowmatchingTable::get(self : GraphflowmatchingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingTable::set(self : GraphflowmatchingTable, i : Int, v : Double) -> GraphflowmatchingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingTable::sum(self : GraphflowmatchingTable) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingTable::mean(self : GraphflowmatchingTable) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingTable::scale(self : GraphflowmatchingTable, f : Double) -> GraphflowmatchingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingTable::add(self : GraphflowmatchingTable, other : GraphflowmatchingTable) -> GraphflowmatchingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingTable::copy(self : GraphflowmatchingTable) -> GraphflowmatchingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingTable::fill(self : GraphflowmatchingTable, v : Double) -> GraphflowmatchingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingTable::min(self : GraphflowmatchingTable) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingTable::max(self : GraphflowmatchingTable) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingTable::to_string(self : GraphflowmatchingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_graphn_make(size : Int) -> GraphflowmatchingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingGraphN::len(self : GraphflowmatchingGraphN) -> Int { self.size }

pub fn GraphflowmatchingGraphN::get(self : GraphflowmatchingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingGraphN::set(self : GraphflowmatchingGraphN, i : Int, v : Double) -> GraphflowmatchingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingGraphN::sum(self : GraphflowmatchingGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingGraphN::mean(self : GraphflowmatchingGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingGraphN::scale(self : GraphflowmatchingGraphN, f : Double) -> GraphflowmatchingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingGraphN::add(self : GraphflowmatchingGraphN, other : GraphflowmatchingGraphN) -> GraphflowmatchingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingGraphN::copy(self : GraphflowmatchingGraphN) -> GraphflowmatchingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingGraphN::fill(self : GraphflowmatchingGraphN, v : Double) -> GraphflowmatchingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingGraphN::min(self : GraphflowmatchingGraphN) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingGraphN::max(self : GraphflowmatchingGraphN) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingGraphN::to_string(self : GraphflowmatchingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_node_make(size : Int) -> GraphflowmatchingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingNode::len(self : GraphflowmatchingNode) -> Int { self.size }

pub fn GraphflowmatchingNode::get(self : GraphflowmatchingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingNode::set(self : GraphflowmatchingNode, i : Int, v : Double) -> GraphflowmatchingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingNode::sum(self : GraphflowmatchingNode) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingNode::mean(self : GraphflowmatchingNode) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingNode::scale(self : GraphflowmatchingNode, f : Double) -> GraphflowmatchingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingNode::add(self : GraphflowmatchingNode, other : GraphflowmatchingNode) -> GraphflowmatchingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingNode::copy(self : GraphflowmatchingNode) -> GraphflowmatchingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingNode::fill(self : GraphflowmatchingNode, v : Double) -> GraphflowmatchingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingNode::min(self : GraphflowmatchingNode) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingNode::max(self : GraphflowmatchingNode) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingNode::to_string(self : GraphflowmatchingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_edge_make(size : Int) -> GraphflowmatchingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingEdge::len(self : GraphflowmatchingEdge) -> Int { self.size }

pub fn GraphflowmatchingEdge::get(self : GraphflowmatchingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingEdge::set(self : GraphflowmatchingEdge, i : Int, v : Double) -> GraphflowmatchingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingEdge::sum(self : GraphflowmatchingEdge) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingEdge::mean(self : GraphflowmatchingEdge) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingEdge::scale(self : GraphflowmatchingEdge, f : Double) -> GraphflowmatchingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingEdge::add(self : GraphflowmatchingEdge, other : GraphflowmatchingEdge) -> GraphflowmatchingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingEdge::copy(self : GraphflowmatchingEdge) -> GraphflowmatchingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingEdge::fill(self : GraphflowmatchingEdge, v : Double) -> GraphflowmatchingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingEdge::min(self : GraphflowmatchingEdge) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingEdge::max(self : GraphflowmatchingEdge) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingEdge::to_string(self : GraphflowmatchingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_path_make(size : Int) -> GraphflowmatchingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingPath::len(self : GraphflowmatchingPath) -> Int { self.size }

pub fn GraphflowmatchingPath::get(self : GraphflowmatchingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingPath::set(self : GraphflowmatchingPath, i : Int, v : Double) -> GraphflowmatchingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingPath::sum(self : GraphflowmatchingPath) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingPath::mean(self : GraphflowmatchingPath) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingPath::scale(self : GraphflowmatchingPath, f : Double) -> GraphflowmatchingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingPath::add(self : GraphflowmatchingPath, other : GraphflowmatchingPath) -> GraphflowmatchingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingPath::copy(self : GraphflowmatchingPath) -> GraphflowmatchingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingPath::fill(self : GraphflowmatchingPath, v : Double) -> GraphflowmatchingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingPath::min(self : GraphflowmatchingPath) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingPath::max(self : GraphflowmatchingPath) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingPath::to_string(self : GraphflowmatchingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_cluster_make(size : Int) -> GraphflowmatchingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingCluster::len(self : GraphflowmatchingCluster) -> Int { self.size }

pub fn GraphflowmatchingCluster::get(self : GraphflowmatchingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingCluster::set(self : GraphflowmatchingCluster, i : Int, v : Double) -> GraphflowmatchingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingCluster::sum(self : GraphflowmatchingCluster) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingCluster::mean(self : GraphflowmatchingCluster) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingCluster::scale(self : GraphflowmatchingCluster, f : Double) -> GraphflowmatchingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingCluster::add(self : GraphflowmatchingCluster, other : GraphflowmatchingCluster) -> GraphflowmatchingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingCluster::copy(self : GraphflowmatchingCluster) -> GraphflowmatchingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingCluster::fill(self : GraphflowmatchingCluster, v : Double) -> GraphflowmatchingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingCluster::min(self : GraphflowmatchingCluster) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingCluster::max(self : GraphflowmatchingCluster) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingCluster::to_string(self : GraphflowmatchingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_model_make(size : Int) -> GraphflowmatchingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingModel::len(self : GraphflowmatchingModel) -> Int { self.size }

pub fn GraphflowmatchingModel::get(self : GraphflowmatchingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingModel::set(self : GraphflowmatchingModel, i : Int, v : Double) -> GraphflowmatchingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingModel::sum(self : GraphflowmatchingModel) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingModel::mean(self : GraphflowmatchingModel) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingModel::scale(self : GraphflowmatchingModel, f : Double) -> GraphflowmatchingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingModel::add(self : GraphflowmatchingModel, other : GraphflowmatchingModel) -> GraphflowmatchingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingModel::copy(self : GraphflowmatchingModel) -> GraphflowmatchingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingModel::fill(self : GraphflowmatchingModel, v : Double) -> GraphflowmatchingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingModel::min(self : GraphflowmatchingModel) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingModel::max(self : GraphflowmatchingModel) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingModel::to_string(self : GraphflowmatchingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_layer_make(size : Int) -> GraphflowmatchingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingLayer::len(self : GraphflowmatchingLayer) -> Int { self.size }

pub fn GraphflowmatchingLayer::get(self : GraphflowmatchingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingLayer::set(self : GraphflowmatchingLayer, i : Int, v : Double) -> GraphflowmatchingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingLayer::sum(self : GraphflowmatchingLayer) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingLayer::mean(self : GraphflowmatchingLayer) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingLayer::scale(self : GraphflowmatchingLayer, f : Double) -> GraphflowmatchingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingLayer::add(self : GraphflowmatchingLayer, other : GraphflowmatchingLayer) -> GraphflowmatchingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingLayer::copy(self : GraphflowmatchingLayer) -> GraphflowmatchingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingLayer::fill(self : GraphflowmatchingLayer, v : Double) -> GraphflowmatchingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingLayer::min(self : GraphflowmatchingLayer) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingLayer::max(self : GraphflowmatchingLayer) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingLayer::to_string(self : GraphflowmatchingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_buffer_make(size : Int) -> GraphflowmatchingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingBuffer::len(self : GraphflowmatchingBuffer) -> Int { self.size }

pub fn GraphflowmatchingBuffer::get(self : GraphflowmatchingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingBuffer::set(self : GraphflowmatchingBuffer, i : Int, v : Double) -> GraphflowmatchingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingBuffer::sum(self : GraphflowmatchingBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingBuffer::mean(self : GraphflowmatchingBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingBuffer::scale(self : GraphflowmatchingBuffer, f : Double) -> GraphflowmatchingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingBuffer::add(self : GraphflowmatchingBuffer, other : GraphflowmatchingBuffer) -> GraphflowmatchingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingBuffer::copy(self : GraphflowmatchingBuffer) -> GraphflowmatchingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingBuffer::fill(self : GraphflowmatchingBuffer, v : Double) -> GraphflowmatchingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingBuffer::min(self : GraphflowmatchingBuffer) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingBuffer::max(self : GraphflowmatchingBuffer) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingBuffer::to_string(self : GraphflowmatchingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_cursor_make(size : Int) -> GraphflowmatchingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingCursor::len(self : GraphflowmatchingCursor) -> Int { self.size }

pub fn GraphflowmatchingCursor::get(self : GraphflowmatchingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingCursor::set(self : GraphflowmatchingCursor, i : Int, v : Double) -> GraphflowmatchingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingCursor::sum(self : GraphflowmatchingCursor) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingCursor::mean(self : GraphflowmatchingCursor) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingCursor::scale(self : GraphflowmatchingCursor, f : Double) -> GraphflowmatchingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingCursor::add(self : GraphflowmatchingCursor, other : GraphflowmatchingCursor) -> GraphflowmatchingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingCursor::copy(self : GraphflowmatchingCursor) -> GraphflowmatchingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingCursor::fill(self : GraphflowmatchingCursor, v : Double) -> GraphflowmatchingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingCursor::min(self : GraphflowmatchingCursor) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingCursor::max(self : GraphflowmatchingCursor) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingCursor::to_string(self : GraphflowmatchingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_view_make(size : Int) -> GraphflowmatchingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingView::len(self : GraphflowmatchingView) -> Int { self.size }

pub fn GraphflowmatchingView::get(self : GraphflowmatchingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingView::set(self : GraphflowmatchingView, i : Int, v : Double) -> GraphflowmatchingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingView::sum(self : GraphflowmatchingView) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingView::mean(self : GraphflowmatchingView) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingView::scale(self : GraphflowmatchingView, f : Double) -> GraphflowmatchingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingView::add(self : GraphflowmatchingView, other : GraphflowmatchingView) -> GraphflowmatchingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingView::copy(self : GraphflowmatchingView) -> GraphflowmatchingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingView::fill(self : GraphflowmatchingView, v : Double) -> GraphflowmatchingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingView::min(self : GraphflowmatchingView) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingView::max(self : GraphflowmatchingView) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingView::to_string(self : GraphflowmatchingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_range_make(size : Int) -> GraphflowmatchingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingRange::len(self : GraphflowmatchingRange) -> Int { self.size }

pub fn GraphflowmatchingRange::get(self : GraphflowmatchingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingRange::set(self : GraphflowmatchingRange, i : Int, v : Double) -> GraphflowmatchingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingRange::sum(self : GraphflowmatchingRange) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingRange::mean(self : GraphflowmatchingRange) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingRange::scale(self : GraphflowmatchingRange, f : Double) -> GraphflowmatchingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingRange::add(self : GraphflowmatchingRange, other : GraphflowmatchingRange) -> GraphflowmatchingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingRange::copy(self : GraphflowmatchingRange) -> GraphflowmatchingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingRange::fill(self : GraphflowmatchingRange, v : Double) -> GraphflowmatchingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingRange::min(self : GraphflowmatchingRange) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingRange::max(self : GraphflowmatchingRange) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingRange::to_string(self : GraphflowmatchingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_slice_make(size : Int) -> GraphflowmatchingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmatchingSlice::len(self : GraphflowmatchingSlice) -> Int { self.size }

pub fn GraphflowmatchingSlice::get(self : GraphflowmatchingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmatchingSlice::set(self : GraphflowmatchingSlice, i : Int, v : Double) -> GraphflowmatchingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingSlice::sum(self : GraphflowmatchingSlice) -> Double { @_common.sum(self.data) }

pub fn GraphflowmatchingSlice::mean(self : GraphflowmatchingSlice) -> Double { @_common.mean(self.data) }

pub fn GraphflowmatchingSlice::scale(self : GraphflowmatchingSlice, f : Double) -> GraphflowmatchingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingSlice::add(self : GraphflowmatchingSlice, other : GraphflowmatchingSlice) -> GraphflowmatchingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmatchingSlice::copy(self : GraphflowmatchingSlice) -> GraphflowmatchingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingSlice::fill(self : GraphflowmatchingSlice, v : Double) -> GraphflowmatchingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmatchingSlice::min(self : GraphflowmatchingSlice) -> Double { @_common.min(self.data) }

pub fn GraphflowmatchingSlice::max(self : GraphflowmatchingSlice) -> Double { @_common.max(self.data) }

pub fn GraphflowmatchingSlice::to_string(self : GraphflowmatchingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

