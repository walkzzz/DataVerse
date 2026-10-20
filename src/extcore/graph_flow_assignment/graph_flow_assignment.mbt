///===
/// extcore/graph_flow_assignment

pub(all) struct GraphflowassignmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_assignment_make_point(x : Double, y : Double) -> GraphflowassignmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_assignment_make_point3(x : Double, y : Double, z : Double) -> GraphflowassignmentPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowassignmentPoint::x(self : GraphflowassignmentPoint) -> Double { self.x }

pub fn GraphflowassignmentPoint::y(self : GraphflowassignmentPoint) -> Double { self.y }

pub fn GraphflowassignmentPoint::z(self : GraphflowassignmentPoint) -> Double { self.z }

pub fn GraphflowassignmentPoint::label(self : GraphflowassignmentPoint) -> Int { self.label }

pub fn GraphflowassignmentPoint::dist(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowassignmentPoint::add(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowassignmentPoint::sub(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowassignmentPoint::scale(self : GraphflowassignmentPoint, s : Double) -> GraphflowassignmentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowassignmentPoint::dot(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowassignmentPoint::cross(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowassignmentPoint::norm(self : GraphflowassignmentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowassignmentPoint::normalize(self : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowassignmentPoint::negate(self : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowassignmentPoint::mid(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowassignmentPoint::lerp(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint, t : Double) -> GraphflowassignmentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowassignmentPoint::to_string(self : GraphflowassignmentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowassignmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_assignment_make_series(vals : Array[Double], name : String) -> GraphflowassignmentSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowassignmentSeries::len(self : GraphflowassignmentSeries) -> Int { self.vals.length() }

pub fn GraphflowassignmentSeries::sum(self : GraphflowassignmentSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowassignmentSeries::mean(self : GraphflowassignmentSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowassignmentSeries::min(self : GraphflowassignmentSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowassignmentSeries::max(self : GraphflowassignmentSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowassignmentSeries::range(self : GraphflowassignmentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowassignmentSeries::variance(self : GraphflowassignmentSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowassignmentSeries::std(self : GraphflowassignmentSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowassignmentSeries::median(self : GraphflowassignmentSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowassignmentSeries::scale(self : GraphflowassignmentSeries, f : Double) -> GraphflowassignmentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowassignmentSeries::add(self : GraphflowassignmentSeries, other : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowassignmentSeries::sub(self : GraphflowassignmentSeries, other : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowassignmentSeries::normalize(self : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowassignmentSeries::cumsum(self : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowassignmentSeries::to_string(self : GraphflowassignmentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowassignmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_assignment_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowassignmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_assignment_matrix_identity(n : Int) -> GraphflowassignmentMatrix {
  let m = graph_flow_assignment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowassignmentMatrix::get(self : GraphflowassignmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowassignmentMatrix::transpose(self : GraphflowassignmentMatrix) -> GraphflowassignmentMatrix {
  let result = graph_flow_assignment_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowassignmentMatrix::add(self : GraphflowassignmentMatrix, other : GraphflowassignmentMatrix) -> GraphflowassignmentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_assignment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowassignmentMatrix::scale(self : GraphflowassignmentMatrix, s : Double) -> GraphflowassignmentMatrix {
  let result = graph_flow_assignment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowassignmentMatrix::multiply(self : GraphflowassignmentMatrix, other : GraphflowassignmentMatrix) -> GraphflowassignmentMatrix {
  if self.cols != other.rows { return graph_flow_assignment_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_assignment_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphflowassignmentMatrix::trace(self : GraphflowassignmentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowassignmentMatrix::det(self : GraphflowassignmentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowassignmentMatrix::norm(self : GraphflowassignmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowassignmentMatrix::to_string(self : GraphflowassignmentMatrix) -> String {
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

pub(all) struct GraphflowassignmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_assignment_make_vector(comps : Array[Double]) -> GraphflowassignmentVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_assignment_vector_zero(dim : Int) -> GraphflowassignmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowassignmentVector::add(self : GraphflowassignmentVector, other : GraphflowassignmentVector) -> GraphflowassignmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowassignmentVector::sub(self : GraphflowassignmentVector, other : GraphflowassignmentVector) -> GraphflowassignmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowassignmentVector::scale(self : GraphflowassignmentVector, s : Double) -> GraphflowassignmentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowassignmentVector::dot(self : GraphflowassignmentVector, other : GraphflowassignmentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowassignmentVector::norm(self : GraphflowassignmentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowassignmentVector::normalize(self : GraphflowassignmentVector) -> GraphflowassignmentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowassignmentVector::dist(self : GraphflowassignmentVector, other : GraphflowassignmentVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowassignmentVector::to_string(self : GraphflowassignmentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowassignmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_frame_make(size : Int) -> GraphflowassignmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentFrame::len(self : GraphflowassignmentFrame) -> Int { self.size }

pub fn GraphflowassignmentFrame::get(self : GraphflowassignmentFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentFrame::set(self : GraphflowassignmentFrame, i : Int, v : Double) -> GraphflowassignmentFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentFrame::sum(self : GraphflowassignmentFrame) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentFrame::mean(self : GraphflowassignmentFrame) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentFrame::scale(self : GraphflowassignmentFrame, f : Double) -> GraphflowassignmentFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentFrame::add(self : GraphflowassignmentFrame, other : GraphflowassignmentFrame) -> GraphflowassignmentFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentFrame::copy(self : GraphflowassignmentFrame) -> GraphflowassignmentFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentFrame::fill(self : GraphflowassignmentFrame, v : Double) -> GraphflowassignmentFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentFrame::min(self : GraphflowassignmentFrame) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentFrame::max(self : GraphflowassignmentFrame) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentFrame::to_string(self : GraphflowassignmentFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_table_make(size : Int) -> GraphflowassignmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentTable::len(self : GraphflowassignmentTable) -> Int { self.size }

pub fn GraphflowassignmentTable::get(self : GraphflowassignmentTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentTable::set(self : GraphflowassignmentTable, i : Int, v : Double) -> GraphflowassignmentTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentTable::sum(self : GraphflowassignmentTable) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentTable::mean(self : GraphflowassignmentTable) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentTable::scale(self : GraphflowassignmentTable, f : Double) -> GraphflowassignmentTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentTable::add(self : GraphflowassignmentTable, other : GraphflowassignmentTable) -> GraphflowassignmentTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentTable::copy(self : GraphflowassignmentTable) -> GraphflowassignmentTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentTable::fill(self : GraphflowassignmentTable, v : Double) -> GraphflowassignmentTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentTable::min(self : GraphflowassignmentTable) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentTable::max(self : GraphflowassignmentTable) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentTable::to_string(self : GraphflowassignmentTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_graphn_make(size : Int) -> GraphflowassignmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentGraphN::len(self : GraphflowassignmentGraphN) -> Int { self.size }

pub fn GraphflowassignmentGraphN::get(self : GraphflowassignmentGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentGraphN::set(self : GraphflowassignmentGraphN, i : Int, v : Double) -> GraphflowassignmentGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentGraphN::sum(self : GraphflowassignmentGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentGraphN::mean(self : GraphflowassignmentGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentGraphN::scale(self : GraphflowassignmentGraphN, f : Double) -> GraphflowassignmentGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentGraphN::add(self : GraphflowassignmentGraphN, other : GraphflowassignmentGraphN) -> GraphflowassignmentGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentGraphN::copy(self : GraphflowassignmentGraphN) -> GraphflowassignmentGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentGraphN::fill(self : GraphflowassignmentGraphN, v : Double) -> GraphflowassignmentGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentGraphN::min(self : GraphflowassignmentGraphN) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentGraphN::max(self : GraphflowassignmentGraphN) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentGraphN::to_string(self : GraphflowassignmentGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_node_make(size : Int) -> GraphflowassignmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentNode::len(self : GraphflowassignmentNode) -> Int { self.size }

pub fn GraphflowassignmentNode::get(self : GraphflowassignmentNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentNode::set(self : GraphflowassignmentNode, i : Int, v : Double) -> GraphflowassignmentNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentNode::sum(self : GraphflowassignmentNode) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentNode::mean(self : GraphflowassignmentNode) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentNode::scale(self : GraphflowassignmentNode, f : Double) -> GraphflowassignmentNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentNode::add(self : GraphflowassignmentNode, other : GraphflowassignmentNode) -> GraphflowassignmentNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentNode::copy(self : GraphflowassignmentNode) -> GraphflowassignmentNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentNode::fill(self : GraphflowassignmentNode, v : Double) -> GraphflowassignmentNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentNode::min(self : GraphflowassignmentNode) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentNode::max(self : GraphflowassignmentNode) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentNode::to_string(self : GraphflowassignmentNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_edge_make(size : Int) -> GraphflowassignmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentEdge::len(self : GraphflowassignmentEdge) -> Int { self.size }

pub fn GraphflowassignmentEdge::get(self : GraphflowassignmentEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentEdge::set(self : GraphflowassignmentEdge, i : Int, v : Double) -> GraphflowassignmentEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentEdge::sum(self : GraphflowassignmentEdge) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentEdge::mean(self : GraphflowassignmentEdge) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentEdge::scale(self : GraphflowassignmentEdge, f : Double) -> GraphflowassignmentEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentEdge::add(self : GraphflowassignmentEdge, other : GraphflowassignmentEdge) -> GraphflowassignmentEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentEdge::copy(self : GraphflowassignmentEdge) -> GraphflowassignmentEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentEdge::fill(self : GraphflowassignmentEdge, v : Double) -> GraphflowassignmentEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentEdge::min(self : GraphflowassignmentEdge) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentEdge::max(self : GraphflowassignmentEdge) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentEdge::to_string(self : GraphflowassignmentEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_path_make(size : Int) -> GraphflowassignmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentPath::len(self : GraphflowassignmentPath) -> Int { self.size }

pub fn GraphflowassignmentPath::get(self : GraphflowassignmentPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentPath::set(self : GraphflowassignmentPath, i : Int, v : Double) -> GraphflowassignmentPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentPath::sum(self : GraphflowassignmentPath) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentPath::mean(self : GraphflowassignmentPath) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentPath::scale(self : GraphflowassignmentPath, f : Double) -> GraphflowassignmentPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentPath::add(self : GraphflowassignmentPath, other : GraphflowassignmentPath) -> GraphflowassignmentPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentPath::copy(self : GraphflowassignmentPath) -> GraphflowassignmentPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentPath::fill(self : GraphflowassignmentPath, v : Double) -> GraphflowassignmentPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentPath::min(self : GraphflowassignmentPath) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentPath::max(self : GraphflowassignmentPath) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentPath::to_string(self : GraphflowassignmentPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_cluster_make(size : Int) -> GraphflowassignmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentCluster::len(self : GraphflowassignmentCluster) -> Int { self.size }

pub fn GraphflowassignmentCluster::get(self : GraphflowassignmentCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentCluster::set(self : GraphflowassignmentCluster, i : Int, v : Double) -> GraphflowassignmentCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentCluster::sum(self : GraphflowassignmentCluster) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentCluster::mean(self : GraphflowassignmentCluster) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentCluster::scale(self : GraphflowassignmentCluster, f : Double) -> GraphflowassignmentCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentCluster::add(self : GraphflowassignmentCluster, other : GraphflowassignmentCluster) -> GraphflowassignmentCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentCluster::copy(self : GraphflowassignmentCluster) -> GraphflowassignmentCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentCluster::fill(self : GraphflowassignmentCluster, v : Double) -> GraphflowassignmentCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentCluster::min(self : GraphflowassignmentCluster) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentCluster::max(self : GraphflowassignmentCluster) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentCluster::to_string(self : GraphflowassignmentCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_model_make(size : Int) -> GraphflowassignmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentModel::len(self : GraphflowassignmentModel) -> Int { self.size }

pub fn GraphflowassignmentModel::get(self : GraphflowassignmentModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentModel::set(self : GraphflowassignmentModel, i : Int, v : Double) -> GraphflowassignmentModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentModel::sum(self : GraphflowassignmentModel) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentModel::mean(self : GraphflowassignmentModel) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentModel::scale(self : GraphflowassignmentModel, f : Double) -> GraphflowassignmentModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentModel::add(self : GraphflowassignmentModel, other : GraphflowassignmentModel) -> GraphflowassignmentModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentModel::copy(self : GraphflowassignmentModel) -> GraphflowassignmentModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentModel::fill(self : GraphflowassignmentModel, v : Double) -> GraphflowassignmentModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentModel::min(self : GraphflowassignmentModel) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentModel::max(self : GraphflowassignmentModel) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentModel::to_string(self : GraphflowassignmentModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_layer_make(size : Int) -> GraphflowassignmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentLayer::len(self : GraphflowassignmentLayer) -> Int { self.size }

pub fn GraphflowassignmentLayer::get(self : GraphflowassignmentLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentLayer::set(self : GraphflowassignmentLayer, i : Int, v : Double) -> GraphflowassignmentLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentLayer::sum(self : GraphflowassignmentLayer) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentLayer::mean(self : GraphflowassignmentLayer) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentLayer::scale(self : GraphflowassignmentLayer, f : Double) -> GraphflowassignmentLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentLayer::add(self : GraphflowassignmentLayer, other : GraphflowassignmentLayer) -> GraphflowassignmentLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentLayer::copy(self : GraphflowassignmentLayer) -> GraphflowassignmentLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentLayer::fill(self : GraphflowassignmentLayer, v : Double) -> GraphflowassignmentLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentLayer::min(self : GraphflowassignmentLayer) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentLayer::max(self : GraphflowassignmentLayer) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentLayer::to_string(self : GraphflowassignmentLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_buffer_make(size : Int) -> GraphflowassignmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentBuffer::len(self : GraphflowassignmentBuffer) -> Int { self.size }

pub fn GraphflowassignmentBuffer::get(self : GraphflowassignmentBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentBuffer::set(self : GraphflowassignmentBuffer, i : Int, v : Double) -> GraphflowassignmentBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentBuffer::sum(self : GraphflowassignmentBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentBuffer::mean(self : GraphflowassignmentBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentBuffer::scale(self : GraphflowassignmentBuffer, f : Double) -> GraphflowassignmentBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentBuffer::add(self : GraphflowassignmentBuffer, other : GraphflowassignmentBuffer) -> GraphflowassignmentBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentBuffer::copy(self : GraphflowassignmentBuffer) -> GraphflowassignmentBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentBuffer::fill(self : GraphflowassignmentBuffer, v : Double) -> GraphflowassignmentBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentBuffer::min(self : GraphflowassignmentBuffer) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentBuffer::max(self : GraphflowassignmentBuffer) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentBuffer::to_string(self : GraphflowassignmentBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_cursor_make(size : Int) -> GraphflowassignmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentCursor::len(self : GraphflowassignmentCursor) -> Int { self.size }

pub fn GraphflowassignmentCursor::get(self : GraphflowassignmentCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentCursor::set(self : GraphflowassignmentCursor, i : Int, v : Double) -> GraphflowassignmentCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentCursor::sum(self : GraphflowassignmentCursor) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentCursor::mean(self : GraphflowassignmentCursor) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentCursor::scale(self : GraphflowassignmentCursor, f : Double) -> GraphflowassignmentCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentCursor::add(self : GraphflowassignmentCursor, other : GraphflowassignmentCursor) -> GraphflowassignmentCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentCursor::copy(self : GraphflowassignmentCursor) -> GraphflowassignmentCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentCursor::fill(self : GraphflowassignmentCursor, v : Double) -> GraphflowassignmentCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentCursor::min(self : GraphflowassignmentCursor) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentCursor::max(self : GraphflowassignmentCursor) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentCursor::to_string(self : GraphflowassignmentCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_view_make(size : Int) -> GraphflowassignmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentView::len(self : GraphflowassignmentView) -> Int { self.size }

pub fn GraphflowassignmentView::get(self : GraphflowassignmentView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentView::set(self : GraphflowassignmentView, i : Int, v : Double) -> GraphflowassignmentView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentView::sum(self : GraphflowassignmentView) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentView::mean(self : GraphflowassignmentView) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentView::scale(self : GraphflowassignmentView, f : Double) -> GraphflowassignmentView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentView::add(self : GraphflowassignmentView, other : GraphflowassignmentView) -> GraphflowassignmentView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentView::copy(self : GraphflowassignmentView) -> GraphflowassignmentView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentView::fill(self : GraphflowassignmentView, v : Double) -> GraphflowassignmentView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentView::min(self : GraphflowassignmentView) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentView::max(self : GraphflowassignmentView) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentView::to_string(self : GraphflowassignmentView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_range_make(size : Int) -> GraphflowassignmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentRange::len(self : GraphflowassignmentRange) -> Int { self.size }

pub fn GraphflowassignmentRange::get(self : GraphflowassignmentRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentRange::set(self : GraphflowassignmentRange, i : Int, v : Double) -> GraphflowassignmentRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentRange::sum(self : GraphflowassignmentRange) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentRange::mean(self : GraphflowassignmentRange) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentRange::scale(self : GraphflowassignmentRange, f : Double) -> GraphflowassignmentRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentRange::add(self : GraphflowassignmentRange, other : GraphflowassignmentRange) -> GraphflowassignmentRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentRange::copy(self : GraphflowassignmentRange) -> GraphflowassignmentRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentRange::fill(self : GraphflowassignmentRange, v : Double) -> GraphflowassignmentRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentRange::min(self : GraphflowassignmentRange) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentRange::max(self : GraphflowassignmentRange) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentRange::to_string(self : GraphflowassignmentRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_slice_make(size : Int) -> GraphflowassignmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowassignmentSlice::len(self : GraphflowassignmentSlice) -> Int { self.size }

pub fn GraphflowassignmentSlice::get(self : GraphflowassignmentSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowassignmentSlice::set(self : GraphflowassignmentSlice, i : Int, v : Double) -> GraphflowassignmentSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentSlice::sum(self : GraphflowassignmentSlice) -> Double { @_common.sum(self.data) }

pub fn GraphflowassignmentSlice::mean(self : GraphflowassignmentSlice) -> Double { @_common.mean(self.data) }

pub fn GraphflowassignmentSlice::scale(self : GraphflowassignmentSlice, f : Double) -> GraphflowassignmentSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentSlice::add(self : GraphflowassignmentSlice, other : GraphflowassignmentSlice) -> GraphflowassignmentSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowassignmentSlice::copy(self : GraphflowassignmentSlice) -> GraphflowassignmentSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentSlice::fill(self : GraphflowassignmentSlice, v : Double) -> GraphflowassignmentSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowassignmentSlice::min(self : GraphflowassignmentSlice) -> Double { @_common.min(self.data) }

pub fn GraphflowassignmentSlice::max(self : GraphflowassignmentSlice) -> Double { @_common.max(self.data) }

pub fn GraphflowassignmentSlice::to_string(self : GraphflowassignmentSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

