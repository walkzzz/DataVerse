///===
/// extcore/graph_tree_encoding

pub(all) struct GraphtreeencodingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_encoding_make_point(x : Double, y : Double) -> GraphtreeencodingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_encoding_make_point3(x : Double, y : Double, z : Double) -> GraphtreeencodingPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreeencodingPoint::x(self : GraphtreeencodingPoint) -> Double { self.x }

pub fn GraphtreeencodingPoint::y(self : GraphtreeencodingPoint) -> Double { self.y }

pub fn GraphtreeencodingPoint::z(self : GraphtreeencodingPoint) -> Double { self.z }

pub fn GraphtreeencodingPoint::label(self : GraphtreeencodingPoint) -> Int { self.label }

pub fn GraphtreeencodingPoint::dist(self : GraphtreeencodingPoint, other : GraphtreeencodingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreeencodingPoint::add(self : GraphtreeencodingPoint, other : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreeencodingPoint::sub(self : GraphtreeencodingPoint, other : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreeencodingPoint::scale(self : GraphtreeencodingPoint, s : Double) -> GraphtreeencodingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreeencodingPoint::dot(self : GraphtreeencodingPoint, other : GraphtreeencodingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreeencodingPoint::cross(self : GraphtreeencodingPoint, other : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreeencodingPoint::norm(self : GraphtreeencodingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreeencodingPoint::normalize(self : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreeencodingPoint::negate(self : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreeencodingPoint::mid(self : GraphtreeencodingPoint, other : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreeencodingPoint::lerp(self : GraphtreeencodingPoint, other : GraphtreeencodingPoint, t : Double) -> GraphtreeencodingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreeencodingPoint::to_string(self : GraphtreeencodingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreeencodingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_encoding_make_series(vals : Array[Double], name : String) -> GraphtreeencodingSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreeencodingSeries::len(self : GraphtreeencodingSeries) -> Int { self.vals.length() }

pub fn GraphtreeencodingSeries::sum(self : GraphtreeencodingSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreeencodingSeries::mean(self : GraphtreeencodingSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreeencodingSeries::min(self : GraphtreeencodingSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreeencodingSeries::max(self : GraphtreeencodingSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreeencodingSeries::range(self : GraphtreeencodingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreeencodingSeries::variance(self : GraphtreeencodingSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreeencodingSeries::std(self : GraphtreeencodingSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreeencodingSeries::median(self : GraphtreeencodingSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreeencodingSeries::scale(self : GraphtreeencodingSeries, f : Double) -> GraphtreeencodingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreeencodingSeries::add(self : GraphtreeencodingSeries, other : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreeencodingSeries::sub(self : GraphtreeencodingSeries, other : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreeencodingSeries::normalize(self : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreeencodingSeries::cumsum(self : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreeencodingSeries::to_string(self : GraphtreeencodingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreeencodingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_encoding_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreeencodingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_encoding_matrix_identity(n : Int) -> GraphtreeencodingMatrix {
  let m = graph_tree_encoding_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreeencodingMatrix::get(self : GraphtreeencodingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreeencodingMatrix::transpose(self : GraphtreeencodingMatrix) -> GraphtreeencodingMatrix {
  let result = graph_tree_encoding_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreeencodingMatrix::add(self : GraphtreeencodingMatrix, other : GraphtreeencodingMatrix) -> GraphtreeencodingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_encoding_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreeencodingMatrix::scale(self : GraphtreeencodingMatrix, s : Double) -> GraphtreeencodingMatrix {
  let result = graph_tree_encoding_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreeencodingMatrix::multiply(self : GraphtreeencodingMatrix, other : GraphtreeencodingMatrix) -> GraphtreeencodingMatrix {
  if self.cols != other.rows { return graph_tree_encoding_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_encoding_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphtreeencodingMatrix::trace(self : GraphtreeencodingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreeencodingMatrix::det(self : GraphtreeencodingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreeencodingMatrix::norm(self : GraphtreeencodingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreeencodingMatrix::to_string(self : GraphtreeencodingMatrix) -> String {
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

pub(all) struct GraphtreeencodingVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_encoding_make_vector(comps : Array[Double]) -> GraphtreeencodingVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_encoding_vector_zero(dim : Int) -> GraphtreeencodingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreeencodingVector::add(self : GraphtreeencodingVector, other : GraphtreeencodingVector) -> GraphtreeencodingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreeencodingVector::sub(self : GraphtreeencodingVector, other : GraphtreeencodingVector) -> GraphtreeencodingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreeencodingVector::scale(self : GraphtreeencodingVector, s : Double) -> GraphtreeencodingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreeencodingVector::dot(self : GraphtreeencodingVector, other : GraphtreeencodingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreeencodingVector::norm(self : GraphtreeencodingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreeencodingVector::normalize(self : GraphtreeencodingVector) -> GraphtreeencodingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreeencodingVector::dist(self : GraphtreeencodingVector, other : GraphtreeencodingVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreeencodingVector::to_string(self : GraphtreeencodingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreeencodingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_frame_make(size : Int) -> GraphtreeencodingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingFrame::len(self : GraphtreeencodingFrame) -> Int { self.size }

pub fn GraphtreeencodingFrame::get(self : GraphtreeencodingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingFrame::set(self : GraphtreeencodingFrame, i : Int, v : Double) -> GraphtreeencodingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingFrame::sum(self : GraphtreeencodingFrame) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingFrame::mean(self : GraphtreeencodingFrame) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingFrame::scale(self : GraphtreeencodingFrame, f : Double) -> GraphtreeencodingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingFrame::add(self : GraphtreeencodingFrame, other : GraphtreeencodingFrame) -> GraphtreeencodingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingFrame::copy(self : GraphtreeencodingFrame) -> GraphtreeencodingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingFrame::fill(self : GraphtreeencodingFrame, v : Double) -> GraphtreeencodingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingFrame::min(self : GraphtreeencodingFrame) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingFrame::max(self : GraphtreeencodingFrame) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingFrame::to_string(self : GraphtreeencodingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_table_make(size : Int) -> GraphtreeencodingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingTable::len(self : GraphtreeencodingTable) -> Int { self.size }

pub fn GraphtreeencodingTable::get(self : GraphtreeencodingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingTable::set(self : GraphtreeencodingTable, i : Int, v : Double) -> GraphtreeencodingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingTable::sum(self : GraphtreeencodingTable) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingTable::mean(self : GraphtreeencodingTable) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingTable::scale(self : GraphtreeencodingTable, f : Double) -> GraphtreeencodingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingTable::add(self : GraphtreeencodingTable, other : GraphtreeencodingTable) -> GraphtreeencodingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingTable::copy(self : GraphtreeencodingTable) -> GraphtreeencodingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingTable::fill(self : GraphtreeencodingTable, v : Double) -> GraphtreeencodingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingTable::min(self : GraphtreeencodingTable) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingTable::max(self : GraphtreeencodingTable) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingTable::to_string(self : GraphtreeencodingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_graphn_make(size : Int) -> GraphtreeencodingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingGraphN::len(self : GraphtreeencodingGraphN) -> Int { self.size }

pub fn GraphtreeencodingGraphN::get(self : GraphtreeencodingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingGraphN::set(self : GraphtreeencodingGraphN, i : Int, v : Double) -> GraphtreeencodingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingGraphN::sum(self : GraphtreeencodingGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingGraphN::mean(self : GraphtreeencodingGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingGraphN::scale(self : GraphtreeencodingGraphN, f : Double) -> GraphtreeencodingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingGraphN::add(self : GraphtreeencodingGraphN, other : GraphtreeencodingGraphN) -> GraphtreeencodingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingGraphN::copy(self : GraphtreeencodingGraphN) -> GraphtreeencodingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingGraphN::fill(self : GraphtreeencodingGraphN, v : Double) -> GraphtreeencodingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingGraphN::min(self : GraphtreeencodingGraphN) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingGraphN::max(self : GraphtreeencodingGraphN) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingGraphN::to_string(self : GraphtreeencodingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_node_make(size : Int) -> GraphtreeencodingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingNode::len(self : GraphtreeencodingNode) -> Int { self.size }

pub fn GraphtreeencodingNode::get(self : GraphtreeencodingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingNode::set(self : GraphtreeencodingNode, i : Int, v : Double) -> GraphtreeencodingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingNode::sum(self : GraphtreeencodingNode) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingNode::mean(self : GraphtreeencodingNode) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingNode::scale(self : GraphtreeencodingNode, f : Double) -> GraphtreeencodingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingNode::add(self : GraphtreeencodingNode, other : GraphtreeencodingNode) -> GraphtreeencodingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingNode::copy(self : GraphtreeencodingNode) -> GraphtreeencodingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingNode::fill(self : GraphtreeencodingNode, v : Double) -> GraphtreeencodingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingNode::min(self : GraphtreeencodingNode) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingNode::max(self : GraphtreeencodingNode) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingNode::to_string(self : GraphtreeencodingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_edge_make(size : Int) -> GraphtreeencodingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingEdge::len(self : GraphtreeencodingEdge) -> Int { self.size }

pub fn GraphtreeencodingEdge::get(self : GraphtreeencodingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingEdge::set(self : GraphtreeencodingEdge, i : Int, v : Double) -> GraphtreeencodingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingEdge::sum(self : GraphtreeencodingEdge) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingEdge::mean(self : GraphtreeencodingEdge) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingEdge::scale(self : GraphtreeencodingEdge, f : Double) -> GraphtreeencodingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingEdge::add(self : GraphtreeencodingEdge, other : GraphtreeencodingEdge) -> GraphtreeencodingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingEdge::copy(self : GraphtreeencodingEdge) -> GraphtreeencodingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingEdge::fill(self : GraphtreeencodingEdge, v : Double) -> GraphtreeencodingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingEdge::min(self : GraphtreeencodingEdge) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingEdge::max(self : GraphtreeencodingEdge) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingEdge::to_string(self : GraphtreeencodingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_path_make(size : Int) -> GraphtreeencodingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingPath::len(self : GraphtreeencodingPath) -> Int { self.size }

pub fn GraphtreeencodingPath::get(self : GraphtreeencodingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingPath::set(self : GraphtreeencodingPath, i : Int, v : Double) -> GraphtreeencodingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingPath::sum(self : GraphtreeencodingPath) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingPath::mean(self : GraphtreeencodingPath) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingPath::scale(self : GraphtreeencodingPath, f : Double) -> GraphtreeencodingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingPath::add(self : GraphtreeencodingPath, other : GraphtreeencodingPath) -> GraphtreeencodingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingPath::copy(self : GraphtreeencodingPath) -> GraphtreeencodingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingPath::fill(self : GraphtreeencodingPath, v : Double) -> GraphtreeencodingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingPath::min(self : GraphtreeencodingPath) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingPath::max(self : GraphtreeencodingPath) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingPath::to_string(self : GraphtreeencodingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_cluster_make(size : Int) -> GraphtreeencodingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingCluster::len(self : GraphtreeencodingCluster) -> Int { self.size }

pub fn GraphtreeencodingCluster::get(self : GraphtreeencodingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingCluster::set(self : GraphtreeencodingCluster, i : Int, v : Double) -> GraphtreeencodingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingCluster::sum(self : GraphtreeencodingCluster) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingCluster::mean(self : GraphtreeencodingCluster) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingCluster::scale(self : GraphtreeencodingCluster, f : Double) -> GraphtreeencodingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingCluster::add(self : GraphtreeencodingCluster, other : GraphtreeencodingCluster) -> GraphtreeencodingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingCluster::copy(self : GraphtreeencodingCluster) -> GraphtreeencodingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingCluster::fill(self : GraphtreeencodingCluster, v : Double) -> GraphtreeencodingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingCluster::min(self : GraphtreeencodingCluster) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingCluster::max(self : GraphtreeencodingCluster) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingCluster::to_string(self : GraphtreeencodingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_model_make(size : Int) -> GraphtreeencodingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingModel::len(self : GraphtreeencodingModel) -> Int { self.size }

pub fn GraphtreeencodingModel::get(self : GraphtreeencodingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingModel::set(self : GraphtreeencodingModel, i : Int, v : Double) -> GraphtreeencodingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingModel::sum(self : GraphtreeencodingModel) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingModel::mean(self : GraphtreeencodingModel) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingModel::scale(self : GraphtreeencodingModel, f : Double) -> GraphtreeencodingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingModel::add(self : GraphtreeencodingModel, other : GraphtreeencodingModel) -> GraphtreeencodingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingModel::copy(self : GraphtreeencodingModel) -> GraphtreeencodingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingModel::fill(self : GraphtreeencodingModel, v : Double) -> GraphtreeencodingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingModel::min(self : GraphtreeencodingModel) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingModel::max(self : GraphtreeencodingModel) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingModel::to_string(self : GraphtreeencodingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_layer_make(size : Int) -> GraphtreeencodingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingLayer::len(self : GraphtreeencodingLayer) -> Int { self.size }

pub fn GraphtreeencodingLayer::get(self : GraphtreeencodingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingLayer::set(self : GraphtreeencodingLayer, i : Int, v : Double) -> GraphtreeencodingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingLayer::sum(self : GraphtreeencodingLayer) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingLayer::mean(self : GraphtreeencodingLayer) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingLayer::scale(self : GraphtreeencodingLayer, f : Double) -> GraphtreeencodingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingLayer::add(self : GraphtreeencodingLayer, other : GraphtreeencodingLayer) -> GraphtreeencodingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingLayer::copy(self : GraphtreeencodingLayer) -> GraphtreeencodingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingLayer::fill(self : GraphtreeencodingLayer, v : Double) -> GraphtreeencodingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingLayer::min(self : GraphtreeencodingLayer) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingLayer::max(self : GraphtreeencodingLayer) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingLayer::to_string(self : GraphtreeencodingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_buffer_make(size : Int) -> GraphtreeencodingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingBuffer::len(self : GraphtreeencodingBuffer) -> Int { self.size }

pub fn GraphtreeencodingBuffer::get(self : GraphtreeencodingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingBuffer::set(self : GraphtreeencodingBuffer, i : Int, v : Double) -> GraphtreeencodingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingBuffer::sum(self : GraphtreeencodingBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingBuffer::mean(self : GraphtreeencodingBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingBuffer::scale(self : GraphtreeencodingBuffer, f : Double) -> GraphtreeencodingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingBuffer::add(self : GraphtreeencodingBuffer, other : GraphtreeencodingBuffer) -> GraphtreeencodingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingBuffer::copy(self : GraphtreeencodingBuffer) -> GraphtreeencodingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingBuffer::fill(self : GraphtreeencodingBuffer, v : Double) -> GraphtreeencodingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingBuffer::min(self : GraphtreeencodingBuffer) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingBuffer::max(self : GraphtreeencodingBuffer) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingBuffer::to_string(self : GraphtreeencodingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_cursor_make(size : Int) -> GraphtreeencodingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingCursor::len(self : GraphtreeencodingCursor) -> Int { self.size }

pub fn GraphtreeencodingCursor::get(self : GraphtreeencodingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingCursor::set(self : GraphtreeencodingCursor, i : Int, v : Double) -> GraphtreeencodingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingCursor::sum(self : GraphtreeencodingCursor) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingCursor::mean(self : GraphtreeencodingCursor) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingCursor::scale(self : GraphtreeencodingCursor, f : Double) -> GraphtreeencodingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingCursor::add(self : GraphtreeencodingCursor, other : GraphtreeencodingCursor) -> GraphtreeencodingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingCursor::copy(self : GraphtreeencodingCursor) -> GraphtreeencodingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingCursor::fill(self : GraphtreeencodingCursor, v : Double) -> GraphtreeencodingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingCursor::min(self : GraphtreeencodingCursor) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingCursor::max(self : GraphtreeencodingCursor) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingCursor::to_string(self : GraphtreeencodingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_view_make(size : Int) -> GraphtreeencodingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingView::len(self : GraphtreeencodingView) -> Int { self.size }

pub fn GraphtreeencodingView::get(self : GraphtreeencodingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingView::set(self : GraphtreeencodingView, i : Int, v : Double) -> GraphtreeencodingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingView::sum(self : GraphtreeencodingView) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingView::mean(self : GraphtreeencodingView) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingView::scale(self : GraphtreeencodingView, f : Double) -> GraphtreeencodingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingView::add(self : GraphtreeencodingView, other : GraphtreeencodingView) -> GraphtreeencodingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingView::copy(self : GraphtreeencodingView) -> GraphtreeencodingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingView::fill(self : GraphtreeencodingView, v : Double) -> GraphtreeencodingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingView::min(self : GraphtreeencodingView) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingView::max(self : GraphtreeencodingView) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingView::to_string(self : GraphtreeencodingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_range_make(size : Int) -> GraphtreeencodingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingRange::len(self : GraphtreeencodingRange) -> Int { self.size }

pub fn GraphtreeencodingRange::get(self : GraphtreeencodingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingRange::set(self : GraphtreeencodingRange, i : Int, v : Double) -> GraphtreeencodingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingRange::sum(self : GraphtreeencodingRange) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingRange::mean(self : GraphtreeencodingRange) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingRange::scale(self : GraphtreeencodingRange, f : Double) -> GraphtreeencodingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingRange::add(self : GraphtreeencodingRange, other : GraphtreeencodingRange) -> GraphtreeencodingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingRange::copy(self : GraphtreeencodingRange) -> GraphtreeencodingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingRange::fill(self : GraphtreeencodingRange, v : Double) -> GraphtreeencodingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingRange::min(self : GraphtreeencodingRange) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingRange::max(self : GraphtreeencodingRange) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingRange::to_string(self : GraphtreeencodingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_slice_make(size : Int) -> GraphtreeencodingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreeencodingSlice::len(self : GraphtreeencodingSlice) -> Int { self.size }

pub fn GraphtreeencodingSlice::get(self : GraphtreeencodingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreeencodingSlice::set(self : GraphtreeencodingSlice, i : Int, v : Double) -> GraphtreeencodingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingSlice::sum(self : GraphtreeencodingSlice) -> Double { @_common.sum(self.data) }

pub fn GraphtreeencodingSlice::mean(self : GraphtreeencodingSlice) -> Double { @_common.mean(self.data) }

pub fn GraphtreeencodingSlice::scale(self : GraphtreeencodingSlice, f : Double) -> GraphtreeencodingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingSlice::add(self : GraphtreeencodingSlice, other : GraphtreeencodingSlice) -> GraphtreeencodingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreeencodingSlice::copy(self : GraphtreeencodingSlice) -> GraphtreeencodingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingSlice::fill(self : GraphtreeencodingSlice, v : Double) -> GraphtreeencodingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreeencodingSlice::min(self : GraphtreeencodingSlice) -> Double { @_common.min(self.data) }

pub fn GraphtreeencodingSlice::max(self : GraphtreeencodingSlice) -> Double { @_common.max(self.data) }

pub fn GraphtreeencodingSlice::to_string(self : GraphtreeencodingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

