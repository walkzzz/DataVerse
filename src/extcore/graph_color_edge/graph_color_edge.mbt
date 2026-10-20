///===
/// extcore/graph_color_edge

pub(all) struct GraphcoloredgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_edge_make_point(x : Double, y : Double) -> GraphcoloredgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_edge_make_point3(x : Double, y : Double, z : Double) -> GraphcoloredgePoint {
  { x, y, z, label: 0 }
}

pub fn GraphcoloredgePoint::x(self : GraphcoloredgePoint) -> Double { self.x }

pub fn GraphcoloredgePoint::y(self : GraphcoloredgePoint) -> Double { self.y }

pub fn GraphcoloredgePoint::z(self : GraphcoloredgePoint) -> Double { self.z }

pub fn GraphcoloredgePoint::label(self : GraphcoloredgePoint) -> Int { self.label }

pub fn GraphcoloredgePoint::dist(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcoloredgePoint::add(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcoloredgePoint::sub(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcoloredgePoint::scale(self : GraphcoloredgePoint, s : Double) -> GraphcoloredgePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcoloredgePoint::dot(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcoloredgePoint::cross(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcoloredgePoint::norm(self : GraphcoloredgePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcoloredgePoint::normalize(self : GraphcoloredgePoint) -> GraphcoloredgePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcoloredgePoint::negate(self : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcoloredgePoint::mid(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcoloredgePoint::lerp(self : GraphcoloredgePoint, other : GraphcoloredgePoint, t : Double) -> GraphcoloredgePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcoloredgePoint::to_string(self : GraphcoloredgePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcoloredgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_edge_make_series(vals : Array[Double], name : String) -> GraphcoloredgeSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcoloredgeSeries::len(self : GraphcoloredgeSeries) -> Int { self.vals.length() }

pub fn GraphcoloredgeSeries::sum(self : GraphcoloredgeSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcoloredgeSeries::mean(self : GraphcoloredgeSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcoloredgeSeries::min(self : GraphcoloredgeSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcoloredgeSeries::max(self : GraphcoloredgeSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcoloredgeSeries::range(self : GraphcoloredgeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcoloredgeSeries::variance(self : GraphcoloredgeSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcoloredgeSeries::std(self : GraphcoloredgeSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcoloredgeSeries::median(self : GraphcoloredgeSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcoloredgeSeries::scale(self : GraphcoloredgeSeries, f : Double) -> GraphcoloredgeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcoloredgeSeries::add(self : GraphcoloredgeSeries, other : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcoloredgeSeries::sub(self : GraphcoloredgeSeries, other : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcoloredgeSeries::normalize(self : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcoloredgeSeries::cumsum(self : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcoloredgeSeries::to_string(self : GraphcoloredgeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcoloredgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_edge_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcoloredgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_edge_matrix_identity(n : Int) -> GraphcoloredgeMatrix {
  let m = graph_color_edge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcoloredgeMatrix::get(self : GraphcoloredgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcoloredgeMatrix::transpose(self : GraphcoloredgeMatrix) -> GraphcoloredgeMatrix {
  let result = graph_color_edge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcoloredgeMatrix::add(self : GraphcoloredgeMatrix, other : GraphcoloredgeMatrix) -> GraphcoloredgeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_edge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcoloredgeMatrix::scale(self : GraphcoloredgeMatrix, s : Double) -> GraphcoloredgeMatrix {
  let result = graph_color_edge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcoloredgeMatrix::multiply(self : GraphcoloredgeMatrix, other : GraphcoloredgeMatrix) -> GraphcoloredgeMatrix {
  if self.cols != other.rows { return graph_color_edge_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_edge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcoloredgeMatrix::trace(self : GraphcoloredgeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcoloredgeMatrix::det(self : GraphcoloredgeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcoloredgeMatrix::norm(self : GraphcoloredgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcoloredgeMatrix::to_string(self : GraphcoloredgeMatrix) -> String {
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

pub(all) struct GraphcoloredgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_edge_make_vector(comps : Array[Double]) -> GraphcoloredgeVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_edge_vector_zero(dim : Int) -> GraphcoloredgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcoloredgeVector::add(self : GraphcoloredgeVector, other : GraphcoloredgeVector) -> GraphcoloredgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcoloredgeVector::sub(self : GraphcoloredgeVector, other : GraphcoloredgeVector) -> GraphcoloredgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcoloredgeVector::scale(self : GraphcoloredgeVector, s : Double) -> GraphcoloredgeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcoloredgeVector::dot(self : GraphcoloredgeVector, other : GraphcoloredgeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcoloredgeVector::norm(self : GraphcoloredgeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcoloredgeVector::normalize(self : GraphcoloredgeVector) -> GraphcoloredgeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcoloredgeVector::dist(self : GraphcoloredgeVector, other : GraphcoloredgeVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcoloredgeVector::to_string(self : GraphcoloredgeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcoloredgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_frame_make(size : Int) -> GraphcoloredgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeFrame::len(self : GraphcoloredgeFrame) -> Int { self.size }

pub fn GraphcoloredgeFrame::get(self : GraphcoloredgeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeFrame::set(self : GraphcoloredgeFrame, i : Int, v : Double) -> GraphcoloredgeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeFrame::sum(self : GraphcoloredgeFrame) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeFrame::mean(self : GraphcoloredgeFrame) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeFrame::scale(self : GraphcoloredgeFrame, f : Double) -> GraphcoloredgeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeFrame::add(self : GraphcoloredgeFrame, other : GraphcoloredgeFrame) -> GraphcoloredgeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeFrame::copy(self : GraphcoloredgeFrame) -> GraphcoloredgeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeFrame::fill(self : GraphcoloredgeFrame, v : Double) -> GraphcoloredgeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeFrame::min(self : GraphcoloredgeFrame) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeFrame::max(self : GraphcoloredgeFrame) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeFrame::to_string(self : GraphcoloredgeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_table_make(size : Int) -> GraphcoloredgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeTable::len(self : GraphcoloredgeTable) -> Int { self.size }

pub fn GraphcoloredgeTable::get(self : GraphcoloredgeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeTable::set(self : GraphcoloredgeTable, i : Int, v : Double) -> GraphcoloredgeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeTable::sum(self : GraphcoloredgeTable) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeTable::mean(self : GraphcoloredgeTable) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeTable::scale(self : GraphcoloredgeTable, f : Double) -> GraphcoloredgeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeTable::add(self : GraphcoloredgeTable, other : GraphcoloredgeTable) -> GraphcoloredgeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeTable::copy(self : GraphcoloredgeTable) -> GraphcoloredgeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeTable::fill(self : GraphcoloredgeTable, v : Double) -> GraphcoloredgeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeTable::min(self : GraphcoloredgeTable) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeTable::max(self : GraphcoloredgeTable) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeTable::to_string(self : GraphcoloredgeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_graphn_make(size : Int) -> GraphcoloredgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeGraphN::len(self : GraphcoloredgeGraphN) -> Int { self.size }

pub fn GraphcoloredgeGraphN::get(self : GraphcoloredgeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeGraphN::set(self : GraphcoloredgeGraphN, i : Int, v : Double) -> GraphcoloredgeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeGraphN::sum(self : GraphcoloredgeGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeGraphN::mean(self : GraphcoloredgeGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeGraphN::scale(self : GraphcoloredgeGraphN, f : Double) -> GraphcoloredgeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeGraphN::add(self : GraphcoloredgeGraphN, other : GraphcoloredgeGraphN) -> GraphcoloredgeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeGraphN::copy(self : GraphcoloredgeGraphN) -> GraphcoloredgeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeGraphN::fill(self : GraphcoloredgeGraphN, v : Double) -> GraphcoloredgeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeGraphN::min(self : GraphcoloredgeGraphN) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeGraphN::max(self : GraphcoloredgeGraphN) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeGraphN::to_string(self : GraphcoloredgeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_node_make(size : Int) -> GraphcoloredgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeNode::len(self : GraphcoloredgeNode) -> Int { self.size }

pub fn GraphcoloredgeNode::get(self : GraphcoloredgeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeNode::set(self : GraphcoloredgeNode, i : Int, v : Double) -> GraphcoloredgeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeNode::sum(self : GraphcoloredgeNode) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeNode::mean(self : GraphcoloredgeNode) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeNode::scale(self : GraphcoloredgeNode, f : Double) -> GraphcoloredgeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeNode::add(self : GraphcoloredgeNode, other : GraphcoloredgeNode) -> GraphcoloredgeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeNode::copy(self : GraphcoloredgeNode) -> GraphcoloredgeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeNode::fill(self : GraphcoloredgeNode, v : Double) -> GraphcoloredgeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeNode::min(self : GraphcoloredgeNode) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeNode::max(self : GraphcoloredgeNode) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeNode::to_string(self : GraphcoloredgeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_edge_make(size : Int) -> GraphcoloredgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeEdge::len(self : GraphcoloredgeEdge) -> Int { self.size }

pub fn GraphcoloredgeEdge::get(self : GraphcoloredgeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeEdge::set(self : GraphcoloredgeEdge, i : Int, v : Double) -> GraphcoloredgeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeEdge::sum(self : GraphcoloredgeEdge) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeEdge::mean(self : GraphcoloredgeEdge) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeEdge::scale(self : GraphcoloredgeEdge, f : Double) -> GraphcoloredgeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeEdge::add(self : GraphcoloredgeEdge, other : GraphcoloredgeEdge) -> GraphcoloredgeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeEdge::copy(self : GraphcoloredgeEdge) -> GraphcoloredgeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeEdge::fill(self : GraphcoloredgeEdge, v : Double) -> GraphcoloredgeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeEdge::min(self : GraphcoloredgeEdge) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeEdge::max(self : GraphcoloredgeEdge) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeEdge::to_string(self : GraphcoloredgeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_path_make(size : Int) -> GraphcoloredgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgePath::len(self : GraphcoloredgePath) -> Int { self.size }

pub fn GraphcoloredgePath::get(self : GraphcoloredgePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgePath::set(self : GraphcoloredgePath, i : Int, v : Double) -> GraphcoloredgePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgePath::sum(self : GraphcoloredgePath) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgePath::mean(self : GraphcoloredgePath) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgePath::scale(self : GraphcoloredgePath, f : Double) -> GraphcoloredgePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgePath::add(self : GraphcoloredgePath, other : GraphcoloredgePath) -> GraphcoloredgePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgePath::copy(self : GraphcoloredgePath) -> GraphcoloredgePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgePath::fill(self : GraphcoloredgePath, v : Double) -> GraphcoloredgePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgePath::min(self : GraphcoloredgePath) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgePath::max(self : GraphcoloredgePath) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgePath::to_string(self : GraphcoloredgePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_cluster_make(size : Int) -> GraphcoloredgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeCluster::len(self : GraphcoloredgeCluster) -> Int { self.size }

pub fn GraphcoloredgeCluster::get(self : GraphcoloredgeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeCluster::set(self : GraphcoloredgeCluster, i : Int, v : Double) -> GraphcoloredgeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeCluster::sum(self : GraphcoloredgeCluster) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeCluster::mean(self : GraphcoloredgeCluster) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeCluster::scale(self : GraphcoloredgeCluster, f : Double) -> GraphcoloredgeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeCluster::add(self : GraphcoloredgeCluster, other : GraphcoloredgeCluster) -> GraphcoloredgeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeCluster::copy(self : GraphcoloredgeCluster) -> GraphcoloredgeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeCluster::fill(self : GraphcoloredgeCluster, v : Double) -> GraphcoloredgeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeCluster::min(self : GraphcoloredgeCluster) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeCluster::max(self : GraphcoloredgeCluster) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeCluster::to_string(self : GraphcoloredgeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_model_make(size : Int) -> GraphcoloredgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeModel::len(self : GraphcoloredgeModel) -> Int { self.size }

pub fn GraphcoloredgeModel::get(self : GraphcoloredgeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeModel::set(self : GraphcoloredgeModel, i : Int, v : Double) -> GraphcoloredgeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeModel::sum(self : GraphcoloredgeModel) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeModel::mean(self : GraphcoloredgeModel) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeModel::scale(self : GraphcoloredgeModel, f : Double) -> GraphcoloredgeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeModel::add(self : GraphcoloredgeModel, other : GraphcoloredgeModel) -> GraphcoloredgeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeModel::copy(self : GraphcoloredgeModel) -> GraphcoloredgeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeModel::fill(self : GraphcoloredgeModel, v : Double) -> GraphcoloredgeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeModel::min(self : GraphcoloredgeModel) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeModel::max(self : GraphcoloredgeModel) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeModel::to_string(self : GraphcoloredgeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_layer_make(size : Int) -> GraphcoloredgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeLayer::len(self : GraphcoloredgeLayer) -> Int { self.size }

pub fn GraphcoloredgeLayer::get(self : GraphcoloredgeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeLayer::set(self : GraphcoloredgeLayer, i : Int, v : Double) -> GraphcoloredgeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeLayer::sum(self : GraphcoloredgeLayer) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeLayer::mean(self : GraphcoloredgeLayer) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeLayer::scale(self : GraphcoloredgeLayer, f : Double) -> GraphcoloredgeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeLayer::add(self : GraphcoloredgeLayer, other : GraphcoloredgeLayer) -> GraphcoloredgeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeLayer::copy(self : GraphcoloredgeLayer) -> GraphcoloredgeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeLayer::fill(self : GraphcoloredgeLayer, v : Double) -> GraphcoloredgeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeLayer::min(self : GraphcoloredgeLayer) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeLayer::max(self : GraphcoloredgeLayer) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeLayer::to_string(self : GraphcoloredgeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_buffer_make(size : Int) -> GraphcoloredgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeBuffer::len(self : GraphcoloredgeBuffer) -> Int { self.size }

pub fn GraphcoloredgeBuffer::get(self : GraphcoloredgeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeBuffer::set(self : GraphcoloredgeBuffer, i : Int, v : Double) -> GraphcoloredgeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeBuffer::sum(self : GraphcoloredgeBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeBuffer::mean(self : GraphcoloredgeBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeBuffer::scale(self : GraphcoloredgeBuffer, f : Double) -> GraphcoloredgeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeBuffer::add(self : GraphcoloredgeBuffer, other : GraphcoloredgeBuffer) -> GraphcoloredgeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeBuffer::copy(self : GraphcoloredgeBuffer) -> GraphcoloredgeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeBuffer::fill(self : GraphcoloredgeBuffer, v : Double) -> GraphcoloredgeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeBuffer::min(self : GraphcoloredgeBuffer) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeBuffer::max(self : GraphcoloredgeBuffer) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeBuffer::to_string(self : GraphcoloredgeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_cursor_make(size : Int) -> GraphcoloredgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeCursor::len(self : GraphcoloredgeCursor) -> Int { self.size }

pub fn GraphcoloredgeCursor::get(self : GraphcoloredgeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeCursor::set(self : GraphcoloredgeCursor, i : Int, v : Double) -> GraphcoloredgeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeCursor::sum(self : GraphcoloredgeCursor) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeCursor::mean(self : GraphcoloredgeCursor) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeCursor::scale(self : GraphcoloredgeCursor, f : Double) -> GraphcoloredgeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeCursor::add(self : GraphcoloredgeCursor, other : GraphcoloredgeCursor) -> GraphcoloredgeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeCursor::copy(self : GraphcoloredgeCursor) -> GraphcoloredgeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeCursor::fill(self : GraphcoloredgeCursor, v : Double) -> GraphcoloredgeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeCursor::min(self : GraphcoloredgeCursor) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeCursor::max(self : GraphcoloredgeCursor) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeCursor::to_string(self : GraphcoloredgeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_view_make(size : Int) -> GraphcoloredgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeView::len(self : GraphcoloredgeView) -> Int { self.size }

pub fn GraphcoloredgeView::get(self : GraphcoloredgeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeView::set(self : GraphcoloredgeView, i : Int, v : Double) -> GraphcoloredgeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeView::sum(self : GraphcoloredgeView) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeView::mean(self : GraphcoloredgeView) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeView::scale(self : GraphcoloredgeView, f : Double) -> GraphcoloredgeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeView::add(self : GraphcoloredgeView, other : GraphcoloredgeView) -> GraphcoloredgeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeView::copy(self : GraphcoloredgeView) -> GraphcoloredgeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeView::fill(self : GraphcoloredgeView, v : Double) -> GraphcoloredgeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeView::min(self : GraphcoloredgeView) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeView::max(self : GraphcoloredgeView) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeView::to_string(self : GraphcoloredgeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_range_make(size : Int) -> GraphcoloredgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeRange::len(self : GraphcoloredgeRange) -> Int { self.size }

pub fn GraphcoloredgeRange::get(self : GraphcoloredgeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeRange::set(self : GraphcoloredgeRange, i : Int, v : Double) -> GraphcoloredgeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeRange::sum(self : GraphcoloredgeRange) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeRange::mean(self : GraphcoloredgeRange) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeRange::scale(self : GraphcoloredgeRange, f : Double) -> GraphcoloredgeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeRange::add(self : GraphcoloredgeRange, other : GraphcoloredgeRange) -> GraphcoloredgeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeRange::copy(self : GraphcoloredgeRange) -> GraphcoloredgeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeRange::fill(self : GraphcoloredgeRange, v : Double) -> GraphcoloredgeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeRange::min(self : GraphcoloredgeRange) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeRange::max(self : GraphcoloredgeRange) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeRange::to_string(self : GraphcoloredgeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_slice_make(size : Int) -> GraphcoloredgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcoloredgeSlice::len(self : GraphcoloredgeSlice) -> Int { self.size }

pub fn GraphcoloredgeSlice::get(self : GraphcoloredgeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcoloredgeSlice::set(self : GraphcoloredgeSlice, i : Int, v : Double) -> GraphcoloredgeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeSlice::sum(self : GraphcoloredgeSlice) -> Double { @_common.sum(self.data) }

pub fn GraphcoloredgeSlice::mean(self : GraphcoloredgeSlice) -> Double { @_common.mean(self.data) }

pub fn GraphcoloredgeSlice::scale(self : GraphcoloredgeSlice, f : Double) -> GraphcoloredgeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeSlice::add(self : GraphcoloredgeSlice, other : GraphcoloredgeSlice) -> GraphcoloredgeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcoloredgeSlice::copy(self : GraphcoloredgeSlice) -> GraphcoloredgeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeSlice::fill(self : GraphcoloredgeSlice, v : Double) -> GraphcoloredgeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcoloredgeSlice::min(self : GraphcoloredgeSlice) -> Double { @_common.min(self.data) }

pub fn GraphcoloredgeSlice::max(self : GraphcoloredgeSlice) -> Double { @_common.max(self.data) }

pub fn GraphcoloredgeSlice::to_string(self : GraphcoloredgeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

