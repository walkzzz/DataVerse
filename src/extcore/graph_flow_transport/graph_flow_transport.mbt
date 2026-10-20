///===
/// extcore/graph_flow_transport

pub(all) struct GraphflowtransportPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_transport_make_point(x : Double, y : Double) -> GraphflowtransportPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_transport_make_point3(x : Double, y : Double, z : Double) -> GraphflowtransportPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowtransportPoint::x(self : GraphflowtransportPoint) -> Double { self.x }

pub fn GraphflowtransportPoint::y(self : GraphflowtransportPoint) -> Double { self.y }

pub fn GraphflowtransportPoint::z(self : GraphflowtransportPoint) -> Double { self.z }

pub fn GraphflowtransportPoint::label(self : GraphflowtransportPoint) -> Int { self.label }

pub fn GraphflowtransportPoint::dist(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowtransportPoint::add(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowtransportPoint::sub(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowtransportPoint::scale(self : GraphflowtransportPoint, s : Double) -> GraphflowtransportPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowtransportPoint::dot(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowtransportPoint::cross(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowtransportPoint::norm(self : GraphflowtransportPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowtransportPoint::normalize(self : GraphflowtransportPoint) -> GraphflowtransportPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowtransportPoint::negate(self : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowtransportPoint::mid(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowtransportPoint::lerp(self : GraphflowtransportPoint, other : GraphflowtransportPoint, t : Double) -> GraphflowtransportPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowtransportPoint::to_string(self : GraphflowtransportPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowtransportSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_transport_make_series(vals : Array[Double], name : String) -> GraphflowtransportSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowtransportSeries::len(self : GraphflowtransportSeries) -> Int { self.vals.length() }

pub fn GraphflowtransportSeries::sum(self : GraphflowtransportSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowtransportSeries::mean(self : GraphflowtransportSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowtransportSeries::min(self : GraphflowtransportSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowtransportSeries::max(self : GraphflowtransportSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowtransportSeries::range(self : GraphflowtransportSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowtransportSeries::variance(self : GraphflowtransportSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowtransportSeries::std(self : GraphflowtransportSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowtransportSeries::median(self : GraphflowtransportSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowtransportSeries::scale(self : GraphflowtransportSeries, f : Double) -> GraphflowtransportSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowtransportSeries::add(self : GraphflowtransportSeries, other : GraphflowtransportSeries) -> GraphflowtransportSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowtransportSeries::sub(self : GraphflowtransportSeries, other : GraphflowtransportSeries) -> GraphflowtransportSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowtransportSeries::normalize(self : GraphflowtransportSeries) -> GraphflowtransportSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowtransportSeries::cumsum(self : GraphflowtransportSeries) -> GraphflowtransportSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowtransportSeries::to_string(self : GraphflowtransportSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowtransportMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_transport_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowtransportMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_transport_matrix_identity(n : Int) -> GraphflowtransportMatrix {
  let m = graph_flow_transport_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowtransportMatrix::get(self : GraphflowtransportMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowtransportMatrix::transpose(self : GraphflowtransportMatrix) -> GraphflowtransportMatrix {
  let result = graph_flow_transport_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowtransportMatrix::add(self : GraphflowtransportMatrix, other : GraphflowtransportMatrix) -> GraphflowtransportMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_transport_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowtransportMatrix::scale(self : GraphflowtransportMatrix, s : Double) -> GraphflowtransportMatrix {
  let result = graph_flow_transport_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowtransportMatrix::multiply(self : GraphflowtransportMatrix, other : GraphflowtransportMatrix) -> GraphflowtransportMatrix {
  if self.cols != other.rows { return graph_flow_transport_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_transport_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowtransportMatrix::trace(self : GraphflowtransportMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowtransportMatrix::det(self : GraphflowtransportMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowtransportMatrix::norm(self : GraphflowtransportMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowtransportMatrix::to_string(self : GraphflowtransportMatrix) -> String {
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

pub(all) struct GraphflowtransportVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_transport_make_vector(comps : Array[Double]) -> GraphflowtransportVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_transport_vector_zero(dim : Int) -> GraphflowtransportVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowtransportVector::add(self : GraphflowtransportVector, other : GraphflowtransportVector) -> GraphflowtransportVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowtransportVector::sub(self : GraphflowtransportVector, other : GraphflowtransportVector) -> GraphflowtransportVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowtransportVector::scale(self : GraphflowtransportVector, s : Double) -> GraphflowtransportVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowtransportVector::dot(self : GraphflowtransportVector, other : GraphflowtransportVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowtransportVector::norm(self : GraphflowtransportVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowtransportVector::normalize(self : GraphflowtransportVector) -> GraphflowtransportVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowtransportVector::dist(self : GraphflowtransportVector, other : GraphflowtransportVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowtransportVector::to_string(self : GraphflowtransportVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowtransportFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_frame_make(size : Int) -> GraphflowtransportFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportFrame::len(self : GraphflowtransportFrame) -> Int { self.size }

pub fn GraphflowtransportFrame::get(self : GraphflowtransportFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportFrame::set(self : GraphflowtransportFrame, i : Int, v : Double) -> GraphflowtransportFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportFrame::sum(self : GraphflowtransportFrame) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportFrame::mean(self : GraphflowtransportFrame) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportFrame::scale(self : GraphflowtransportFrame, f : Double) -> GraphflowtransportFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportFrame::add(self : GraphflowtransportFrame, other : GraphflowtransportFrame) -> GraphflowtransportFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportFrame::copy(self : GraphflowtransportFrame) -> GraphflowtransportFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportFrame::fill(self : GraphflowtransportFrame, v : Double) -> GraphflowtransportFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportFrame::min(self : GraphflowtransportFrame) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportFrame::max(self : GraphflowtransportFrame) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportFrame::to_string(self : GraphflowtransportFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_table_make(size : Int) -> GraphflowtransportTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportTable::len(self : GraphflowtransportTable) -> Int { self.size }

pub fn GraphflowtransportTable::get(self : GraphflowtransportTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportTable::set(self : GraphflowtransportTable, i : Int, v : Double) -> GraphflowtransportTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportTable::sum(self : GraphflowtransportTable) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportTable::mean(self : GraphflowtransportTable) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportTable::scale(self : GraphflowtransportTable, f : Double) -> GraphflowtransportTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportTable::add(self : GraphflowtransportTable, other : GraphflowtransportTable) -> GraphflowtransportTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportTable::copy(self : GraphflowtransportTable) -> GraphflowtransportTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportTable::fill(self : GraphflowtransportTable, v : Double) -> GraphflowtransportTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportTable::min(self : GraphflowtransportTable) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportTable::max(self : GraphflowtransportTable) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportTable::to_string(self : GraphflowtransportTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_graphn_make(size : Int) -> GraphflowtransportGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportGraphN::len(self : GraphflowtransportGraphN) -> Int { self.size }

pub fn GraphflowtransportGraphN::get(self : GraphflowtransportGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportGraphN::set(self : GraphflowtransportGraphN, i : Int, v : Double) -> GraphflowtransportGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportGraphN::sum(self : GraphflowtransportGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportGraphN::mean(self : GraphflowtransportGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportGraphN::scale(self : GraphflowtransportGraphN, f : Double) -> GraphflowtransportGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportGraphN::add(self : GraphflowtransportGraphN, other : GraphflowtransportGraphN) -> GraphflowtransportGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportGraphN::copy(self : GraphflowtransportGraphN) -> GraphflowtransportGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportGraphN::fill(self : GraphflowtransportGraphN, v : Double) -> GraphflowtransportGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportGraphN::min(self : GraphflowtransportGraphN) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportGraphN::max(self : GraphflowtransportGraphN) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportGraphN::to_string(self : GraphflowtransportGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_node_make(size : Int) -> GraphflowtransportNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportNode::len(self : GraphflowtransportNode) -> Int { self.size }

pub fn GraphflowtransportNode::get(self : GraphflowtransportNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportNode::set(self : GraphflowtransportNode, i : Int, v : Double) -> GraphflowtransportNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportNode::sum(self : GraphflowtransportNode) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportNode::mean(self : GraphflowtransportNode) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportNode::scale(self : GraphflowtransportNode, f : Double) -> GraphflowtransportNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportNode::add(self : GraphflowtransportNode, other : GraphflowtransportNode) -> GraphflowtransportNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportNode::copy(self : GraphflowtransportNode) -> GraphflowtransportNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportNode::fill(self : GraphflowtransportNode, v : Double) -> GraphflowtransportNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportNode::min(self : GraphflowtransportNode) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportNode::max(self : GraphflowtransportNode) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportNode::to_string(self : GraphflowtransportNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_edge_make(size : Int) -> GraphflowtransportEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportEdge::len(self : GraphflowtransportEdge) -> Int { self.size }

pub fn GraphflowtransportEdge::get(self : GraphflowtransportEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportEdge::set(self : GraphflowtransportEdge, i : Int, v : Double) -> GraphflowtransportEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportEdge::sum(self : GraphflowtransportEdge) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportEdge::mean(self : GraphflowtransportEdge) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportEdge::scale(self : GraphflowtransportEdge, f : Double) -> GraphflowtransportEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportEdge::add(self : GraphflowtransportEdge, other : GraphflowtransportEdge) -> GraphflowtransportEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportEdge::copy(self : GraphflowtransportEdge) -> GraphflowtransportEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportEdge::fill(self : GraphflowtransportEdge, v : Double) -> GraphflowtransportEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportEdge::min(self : GraphflowtransportEdge) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportEdge::max(self : GraphflowtransportEdge) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportEdge::to_string(self : GraphflowtransportEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_path_make(size : Int) -> GraphflowtransportPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportPath::len(self : GraphflowtransportPath) -> Int { self.size }

pub fn GraphflowtransportPath::get(self : GraphflowtransportPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportPath::set(self : GraphflowtransportPath, i : Int, v : Double) -> GraphflowtransportPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportPath::sum(self : GraphflowtransportPath) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportPath::mean(self : GraphflowtransportPath) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportPath::scale(self : GraphflowtransportPath, f : Double) -> GraphflowtransportPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportPath::add(self : GraphflowtransportPath, other : GraphflowtransportPath) -> GraphflowtransportPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportPath::copy(self : GraphflowtransportPath) -> GraphflowtransportPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportPath::fill(self : GraphflowtransportPath, v : Double) -> GraphflowtransportPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportPath::min(self : GraphflowtransportPath) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportPath::max(self : GraphflowtransportPath) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportPath::to_string(self : GraphflowtransportPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_cluster_make(size : Int) -> GraphflowtransportCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportCluster::len(self : GraphflowtransportCluster) -> Int { self.size }

pub fn GraphflowtransportCluster::get(self : GraphflowtransportCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportCluster::set(self : GraphflowtransportCluster, i : Int, v : Double) -> GraphflowtransportCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportCluster::sum(self : GraphflowtransportCluster) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportCluster::mean(self : GraphflowtransportCluster) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportCluster::scale(self : GraphflowtransportCluster, f : Double) -> GraphflowtransportCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportCluster::add(self : GraphflowtransportCluster, other : GraphflowtransportCluster) -> GraphflowtransportCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportCluster::copy(self : GraphflowtransportCluster) -> GraphflowtransportCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportCluster::fill(self : GraphflowtransportCluster, v : Double) -> GraphflowtransportCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportCluster::min(self : GraphflowtransportCluster) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportCluster::max(self : GraphflowtransportCluster) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportCluster::to_string(self : GraphflowtransportCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_model_make(size : Int) -> GraphflowtransportModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportModel::len(self : GraphflowtransportModel) -> Int { self.size }

pub fn GraphflowtransportModel::get(self : GraphflowtransportModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportModel::set(self : GraphflowtransportModel, i : Int, v : Double) -> GraphflowtransportModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportModel::sum(self : GraphflowtransportModel) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportModel::mean(self : GraphflowtransportModel) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportModel::scale(self : GraphflowtransportModel, f : Double) -> GraphflowtransportModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportModel::add(self : GraphflowtransportModel, other : GraphflowtransportModel) -> GraphflowtransportModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportModel::copy(self : GraphflowtransportModel) -> GraphflowtransportModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportModel::fill(self : GraphflowtransportModel, v : Double) -> GraphflowtransportModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportModel::min(self : GraphflowtransportModel) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportModel::max(self : GraphflowtransportModel) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportModel::to_string(self : GraphflowtransportModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_layer_make(size : Int) -> GraphflowtransportLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportLayer::len(self : GraphflowtransportLayer) -> Int { self.size }

pub fn GraphflowtransportLayer::get(self : GraphflowtransportLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportLayer::set(self : GraphflowtransportLayer, i : Int, v : Double) -> GraphflowtransportLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportLayer::sum(self : GraphflowtransportLayer) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportLayer::mean(self : GraphflowtransportLayer) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportLayer::scale(self : GraphflowtransportLayer, f : Double) -> GraphflowtransportLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportLayer::add(self : GraphflowtransportLayer, other : GraphflowtransportLayer) -> GraphflowtransportLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportLayer::copy(self : GraphflowtransportLayer) -> GraphflowtransportLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportLayer::fill(self : GraphflowtransportLayer, v : Double) -> GraphflowtransportLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportLayer::min(self : GraphflowtransportLayer) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportLayer::max(self : GraphflowtransportLayer) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportLayer::to_string(self : GraphflowtransportLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_buffer_make(size : Int) -> GraphflowtransportBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportBuffer::len(self : GraphflowtransportBuffer) -> Int { self.size }

pub fn GraphflowtransportBuffer::get(self : GraphflowtransportBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportBuffer::set(self : GraphflowtransportBuffer, i : Int, v : Double) -> GraphflowtransportBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportBuffer::sum(self : GraphflowtransportBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportBuffer::mean(self : GraphflowtransportBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportBuffer::scale(self : GraphflowtransportBuffer, f : Double) -> GraphflowtransportBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportBuffer::add(self : GraphflowtransportBuffer, other : GraphflowtransportBuffer) -> GraphflowtransportBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportBuffer::copy(self : GraphflowtransportBuffer) -> GraphflowtransportBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportBuffer::fill(self : GraphflowtransportBuffer, v : Double) -> GraphflowtransportBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportBuffer::min(self : GraphflowtransportBuffer) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportBuffer::max(self : GraphflowtransportBuffer) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportBuffer::to_string(self : GraphflowtransportBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_cursor_make(size : Int) -> GraphflowtransportCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportCursor::len(self : GraphflowtransportCursor) -> Int { self.size }

pub fn GraphflowtransportCursor::get(self : GraphflowtransportCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportCursor::set(self : GraphflowtransportCursor, i : Int, v : Double) -> GraphflowtransportCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportCursor::sum(self : GraphflowtransportCursor) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportCursor::mean(self : GraphflowtransportCursor) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportCursor::scale(self : GraphflowtransportCursor, f : Double) -> GraphflowtransportCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportCursor::add(self : GraphflowtransportCursor, other : GraphflowtransportCursor) -> GraphflowtransportCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportCursor::copy(self : GraphflowtransportCursor) -> GraphflowtransportCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportCursor::fill(self : GraphflowtransportCursor, v : Double) -> GraphflowtransportCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportCursor::min(self : GraphflowtransportCursor) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportCursor::max(self : GraphflowtransportCursor) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportCursor::to_string(self : GraphflowtransportCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_view_make(size : Int) -> GraphflowtransportView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportView::len(self : GraphflowtransportView) -> Int { self.size }

pub fn GraphflowtransportView::get(self : GraphflowtransportView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportView::set(self : GraphflowtransportView, i : Int, v : Double) -> GraphflowtransportView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportView::sum(self : GraphflowtransportView) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportView::mean(self : GraphflowtransportView) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportView::scale(self : GraphflowtransportView, f : Double) -> GraphflowtransportView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportView::add(self : GraphflowtransportView, other : GraphflowtransportView) -> GraphflowtransportView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportView::copy(self : GraphflowtransportView) -> GraphflowtransportView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportView::fill(self : GraphflowtransportView, v : Double) -> GraphflowtransportView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportView::min(self : GraphflowtransportView) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportView::max(self : GraphflowtransportView) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportView::to_string(self : GraphflowtransportView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_range_make(size : Int) -> GraphflowtransportRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportRange::len(self : GraphflowtransportRange) -> Int { self.size }

pub fn GraphflowtransportRange::get(self : GraphflowtransportRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportRange::set(self : GraphflowtransportRange, i : Int, v : Double) -> GraphflowtransportRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportRange::sum(self : GraphflowtransportRange) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportRange::mean(self : GraphflowtransportRange) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportRange::scale(self : GraphflowtransportRange, f : Double) -> GraphflowtransportRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportRange::add(self : GraphflowtransportRange, other : GraphflowtransportRange) -> GraphflowtransportRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportRange::copy(self : GraphflowtransportRange) -> GraphflowtransportRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportRange::fill(self : GraphflowtransportRange, v : Double) -> GraphflowtransportRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportRange::min(self : GraphflowtransportRange) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportRange::max(self : GraphflowtransportRange) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportRange::to_string(self : GraphflowtransportRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_slice_make(size : Int) -> GraphflowtransportSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowtransportSlice::len(self : GraphflowtransportSlice) -> Int { self.size }

pub fn GraphflowtransportSlice::get(self : GraphflowtransportSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowtransportSlice::set(self : GraphflowtransportSlice, i : Int, v : Double) -> GraphflowtransportSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowtransportSlice::sum(self : GraphflowtransportSlice) -> Double { @_common.sum(self.data) }

pub fn GraphflowtransportSlice::mean(self : GraphflowtransportSlice) -> Double { @_common.mean(self.data) }

pub fn GraphflowtransportSlice::scale(self : GraphflowtransportSlice, f : Double) -> GraphflowtransportSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportSlice::add(self : GraphflowtransportSlice, other : GraphflowtransportSlice) -> GraphflowtransportSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowtransportSlice::copy(self : GraphflowtransportSlice) -> GraphflowtransportSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportSlice::fill(self : GraphflowtransportSlice, v : Double) -> GraphflowtransportSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowtransportSlice::min(self : GraphflowtransportSlice) -> Double { @_common.min(self.data) }

pub fn GraphflowtransportSlice::max(self : GraphflowtransportSlice) -> Double { @_common.max(self.data) }

pub fn GraphflowtransportSlice::to_string(self : GraphflowtransportSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

