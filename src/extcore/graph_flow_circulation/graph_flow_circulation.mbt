///===
/// extcore/graph_flow_circulation

pub(all) struct GraphflowcirculationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_circulation_make_point(x : Double, y : Double) -> GraphflowcirculationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_circulation_make_point3(x : Double, y : Double, z : Double) -> GraphflowcirculationPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowcirculationPoint::x(self : GraphflowcirculationPoint) -> Double { self.x }

pub fn GraphflowcirculationPoint::y(self : GraphflowcirculationPoint) -> Double { self.y }

pub fn GraphflowcirculationPoint::z(self : GraphflowcirculationPoint) -> Double { self.z }

pub fn GraphflowcirculationPoint::label(self : GraphflowcirculationPoint) -> Int { self.label }

pub fn GraphflowcirculationPoint::dist(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowcirculationPoint::add(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowcirculationPoint::sub(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowcirculationPoint::scale(self : GraphflowcirculationPoint, s : Double) -> GraphflowcirculationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowcirculationPoint::dot(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowcirculationPoint::cross(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowcirculationPoint::norm(self : GraphflowcirculationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowcirculationPoint::normalize(self : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowcirculationPoint::negate(self : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowcirculationPoint::mid(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowcirculationPoint::lerp(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint, t : Double) -> GraphflowcirculationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowcirculationPoint::to_string(self : GraphflowcirculationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowcirculationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_circulation_make_series(vals : Array[Double], name : String) -> GraphflowcirculationSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowcirculationSeries::len(self : GraphflowcirculationSeries) -> Int { self.vals.length() }

pub fn GraphflowcirculationSeries::sum(self : GraphflowcirculationSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowcirculationSeries::mean(self : GraphflowcirculationSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowcirculationSeries::min(self : GraphflowcirculationSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowcirculationSeries::max(self : GraphflowcirculationSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowcirculationSeries::range(self : GraphflowcirculationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowcirculationSeries::variance(self : GraphflowcirculationSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowcirculationSeries::std(self : GraphflowcirculationSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowcirculationSeries::median(self : GraphflowcirculationSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowcirculationSeries::scale(self : GraphflowcirculationSeries, f : Double) -> GraphflowcirculationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowcirculationSeries::add(self : GraphflowcirculationSeries, other : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowcirculationSeries::sub(self : GraphflowcirculationSeries, other : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowcirculationSeries::normalize(self : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowcirculationSeries::cumsum(self : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowcirculationSeries::to_string(self : GraphflowcirculationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowcirculationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_circulation_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowcirculationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_circulation_matrix_identity(n : Int) -> GraphflowcirculationMatrix {
  let m = graph_flow_circulation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowcirculationMatrix::get(self : GraphflowcirculationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowcirculationMatrix::transpose(self : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  let result = graph_flow_circulation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowcirculationMatrix::add(self : GraphflowcirculationMatrix, other : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_circulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowcirculationMatrix::scale(self : GraphflowcirculationMatrix, s : Double) -> GraphflowcirculationMatrix {
  let result = graph_flow_circulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowcirculationMatrix::multiply(self : GraphflowcirculationMatrix, other : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  if self.cols != other.rows { return graph_flow_circulation_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_circulation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowcirculationMatrix::trace(self : GraphflowcirculationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowcirculationMatrix::det(self : GraphflowcirculationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowcirculationMatrix::norm(self : GraphflowcirculationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowcirculationMatrix::to_string(self : GraphflowcirculationMatrix) -> String {
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

pub(all) struct GraphflowcirculationVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_circulation_make_vector(comps : Array[Double]) -> GraphflowcirculationVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_circulation_vector_zero(dim : Int) -> GraphflowcirculationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowcirculationVector::add(self : GraphflowcirculationVector, other : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowcirculationVector::sub(self : GraphflowcirculationVector, other : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowcirculationVector::scale(self : GraphflowcirculationVector, s : Double) -> GraphflowcirculationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowcirculationVector::dot(self : GraphflowcirculationVector, other : GraphflowcirculationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowcirculationVector::norm(self : GraphflowcirculationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowcirculationVector::normalize(self : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowcirculationVector::dist(self : GraphflowcirculationVector, other : GraphflowcirculationVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowcirculationVector::to_string(self : GraphflowcirculationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowcirculationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_frame_make(size : Int) -> GraphflowcirculationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationFrame::len(self : GraphflowcirculationFrame) -> Int { self.size }

pub fn GraphflowcirculationFrame::get(self : GraphflowcirculationFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationFrame::set(self : GraphflowcirculationFrame, i : Int, v : Double) -> GraphflowcirculationFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationFrame::sum(self : GraphflowcirculationFrame) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationFrame::mean(self : GraphflowcirculationFrame) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationFrame::scale(self : GraphflowcirculationFrame, f : Double) -> GraphflowcirculationFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationFrame::add(self : GraphflowcirculationFrame, other : GraphflowcirculationFrame) -> GraphflowcirculationFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationFrame::copy(self : GraphflowcirculationFrame) -> GraphflowcirculationFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationFrame::fill(self : GraphflowcirculationFrame, v : Double) -> GraphflowcirculationFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationFrame::min(self : GraphflowcirculationFrame) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationFrame::max(self : GraphflowcirculationFrame) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationFrame::to_string(self : GraphflowcirculationFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_table_make(size : Int) -> GraphflowcirculationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationTable::len(self : GraphflowcirculationTable) -> Int { self.size }

pub fn GraphflowcirculationTable::get(self : GraphflowcirculationTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationTable::set(self : GraphflowcirculationTable, i : Int, v : Double) -> GraphflowcirculationTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationTable::sum(self : GraphflowcirculationTable) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationTable::mean(self : GraphflowcirculationTable) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationTable::scale(self : GraphflowcirculationTable, f : Double) -> GraphflowcirculationTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationTable::add(self : GraphflowcirculationTable, other : GraphflowcirculationTable) -> GraphflowcirculationTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationTable::copy(self : GraphflowcirculationTable) -> GraphflowcirculationTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationTable::fill(self : GraphflowcirculationTable, v : Double) -> GraphflowcirculationTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationTable::min(self : GraphflowcirculationTable) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationTable::max(self : GraphflowcirculationTable) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationTable::to_string(self : GraphflowcirculationTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_graphn_make(size : Int) -> GraphflowcirculationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationGraphN::len(self : GraphflowcirculationGraphN) -> Int { self.size }

pub fn GraphflowcirculationGraphN::get(self : GraphflowcirculationGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationGraphN::set(self : GraphflowcirculationGraphN, i : Int, v : Double) -> GraphflowcirculationGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationGraphN::sum(self : GraphflowcirculationGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationGraphN::mean(self : GraphflowcirculationGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationGraphN::scale(self : GraphflowcirculationGraphN, f : Double) -> GraphflowcirculationGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationGraphN::add(self : GraphflowcirculationGraphN, other : GraphflowcirculationGraphN) -> GraphflowcirculationGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationGraphN::copy(self : GraphflowcirculationGraphN) -> GraphflowcirculationGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationGraphN::fill(self : GraphflowcirculationGraphN, v : Double) -> GraphflowcirculationGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationGraphN::min(self : GraphflowcirculationGraphN) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationGraphN::max(self : GraphflowcirculationGraphN) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationGraphN::to_string(self : GraphflowcirculationGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_node_make(size : Int) -> GraphflowcirculationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationNode::len(self : GraphflowcirculationNode) -> Int { self.size }

pub fn GraphflowcirculationNode::get(self : GraphflowcirculationNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationNode::set(self : GraphflowcirculationNode, i : Int, v : Double) -> GraphflowcirculationNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationNode::sum(self : GraphflowcirculationNode) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationNode::mean(self : GraphflowcirculationNode) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationNode::scale(self : GraphflowcirculationNode, f : Double) -> GraphflowcirculationNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationNode::add(self : GraphflowcirculationNode, other : GraphflowcirculationNode) -> GraphflowcirculationNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationNode::copy(self : GraphflowcirculationNode) -> GraphflowcirculationNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationNode::fill(self : GraphflowcirculationNode, v : Double) -> GraphflowcirculationNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationNode::min(self : GraphflowcirculationNode) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationNode::max(self : GraphflowcirculationNode) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationNode::to_string(self : GraphflowcirculationNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_edge_make(size : Int) -> GraphflowcirculationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationEdge::len(self : GraphflowcirculationEdge) -> Int { self.size }

pub fn GraphflowcirculationEdge::get(self : GraphflowcirculationEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationEdge::set(self : GraphflowcirculationEdge, i : Int, v : Double) -> GraphflowcirculationEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationEdge::sum(self : GraphflowcirculationEdge) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationEdge::mean(self : GraphflowcirculationEdge) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationEdge::scale(self : GraphflowcirculationEdge, f : Double) -> GraphflowcirculationEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationEdge::add(self : GraphflowcirculationEdge, other : GraphflowcirculationEdge) -> GraphflowcirculationEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationEdge::copy(self : GraphflowcirculationEdge) -> GraphflowcirculationEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationEdge::fill(self : GraphflowcirculationEdge, v : Double) -> GraphflowcirculationEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationEdge::min(self : GraphflowcirculationEdge) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationEdge::max(self : GraphflowcirculationEdge) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationEdge::to_string(self : GraphflowcirculationEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_path_make(size : Int) -> GraphflowcirculationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationPath::len(self : GraphflowcirculationPath) -> Int { self.size }

pub fn GraphflowcirculationPath::get(self : GraphflowcirculationPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationPath::set(self : GraphflowcirculationPath, i : Int, v : Double) -> GraphflowcirculationPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationPath::sum(self : GraphflowcirculationPath) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationPath::mean(self : GraphflowcirculationPath) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationPath::scale(self : GraphflowcirculationPath, f : Double) -> GraphflowcirculationPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationPath::add(self : GraphflowcirculationPath, other : GraphflowcirculationPath) -> GraphflowcirculationPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationPath::copy(self : GraphflowcirculationPath) -> GraphflowcirculationPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationPath::fill(self : GraphflowcirculationPath, v : Double) -> GraphflowcirculationPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationPath::min(self : GraphflowcirculationPath) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationPath::max(self : GraphflowcirculationPath) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationPath::to_string(self : GraphflowcirculationPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_cluster_make(size : Int) -> GraphflowcirculationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationCluster::len(self : GraphflowcirculationCluster) -> Int { self.size }

pub fn GraphflowcirculationCluster::get(self : GraphflowcirculationCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationCluster::set(self : GraphflowcirculationCluster, i : Int, v : Double) -> GraphflowcirculationCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationCluster::sum(self : GraphflowcirculationCluster) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationCluster::mean(self : GraphflowcirculationCluster) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationCluster::scale(self : GraphflowcirculationCluster, f : Double) -> GraphflowcirculationCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationCluster::add(self : GraphflowcirculationCluster, other : GraphflowcirculationCluster) -> GraphflowcirculationCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationCluster::copy(self : GraphflowcirculationCluster) -> GraphflowcirculationCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationCluster::fill(self : GraphflowcirculationCluster, v : Double) -> GraphflowcirculationCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationCluster::min(self : GraphflowcirculationCluster) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationCluster::max(self : GraphflowcirculationCluster) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationCluster::to_string(self : GraphflowcirculationCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_model_make(size : Int) -> GraphflowcirculationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationModel::len(self : GraphflowcirculationModel) -> Int { self.size }

pub fn GraphflowcirculationModel::get(self : GraphflowcirculationModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationModel::set(self : GraphflowcirculationModel, i : Int, v : Double) -> GraphflowcirculationModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationModel::sum(self : GraphflowcirculationModel) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationModel::mean(self : GraphflowcirculationModel) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationModel::scale(self : GraphflowcirculationModel, f : Double) -> GraphflowcirculationModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationModel::add(self : GraphflowcirculationModel, other : GraphflowcirculationModel) -> GraphflowcirculationModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationModel::copy(self : GraphflowcirculationModel) -> GraphflowcirculationModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationModel::fill(self : GraphflowcirculationModel, v : Double) -> GraphflowcirculationModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationModel::min(self : GraphflowcirculationModel) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationModel::max(self : GraphflowcirculationModel) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationModel::to_string(self : GraphflowcirculationModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_layer_make(size : Int) -> GraphflowcirculationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationLayer::len(self : GraphflowcirculationLayer) -> Int { self.size }

pub fn GraphflowcirculationLayer::get(self : GraphflowcirculationLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationLayer::set(self : GraphflowcirculationLayer, i : Int, v : Double) -> GraphflowcirculationLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationLayer::sum(self : GraphflowcirculationLayer) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationLayer::mean(self : GraphflowcirculationLayer) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationLayer::scale(self : GraphflowcirculationLayer, f : Double) -> GraphflowcirculationLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationLayer::add(self : GraphflowcirculationLayer, other : GraphflowcirculationLayer) -> GraphflowcirculationLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationLayer::copy(self : GraphflowcirculationLayer) -> GraphflowcirculationLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationLayer::fill(self : GraphflowcirculationLayer, v : Double) -> GraphflowcirculationLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationLayer::min(self : GraphflowcirculationLayer) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationLayer::max(self : GraphflowcirculationLayer) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationLayer::to_string(self : GraphflowcirculationLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_buffer_make(size : Int) -> GraphflowcirculationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationBuffer::len(self : GraphflowcirculationBuffer) -> Int { self.size }

pub fn GraphflowcirculationBuffer::get(self : GraphflowcirculationBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationBuffer::set(self : GraphflowcirculationBuffer, i : Int, v : Double) -> GraphflowcirculationBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationBuffer::sum(self : GraphflowcirculationBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationBuffer::mean(self : GraphflowcirculationBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationBuffer::scale(self : GraphflowcirculationBuffer, f : Double) -> GraphflowcirculationBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationBuffer::add(self : GraphflowcirculationBuffer, other : GraphflowcirculationBuffer) -> GraphflowcirculationBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationBuffer::copy(self : GraphflowcirculationBuffer) -> GraphflowcirculationBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationBuffer::fill(self : GraphflowcirculationBuffer, v : Double) -> GraphflowcirculationBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationBuffer::min(self : GraphflowcirculationBuffer) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationBuffer::max(self : GraphflowcirculationBuffer) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationBuffer::to_string(self : GraphflowcirculationBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_cursor_make(size : Int) -> GraphflowcirculationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationCursor::len(self : GraphflowcirculationCursor) -> Int { self.size }

pub fn GraphflowcirculationCursor::get(self : GraphflowcirculationCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationCursor::set(self : GraphflowcirculationCursor, i : Int, v : Double) -> GraphflowcirculationCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationCursor::sum(self : GraphflowcirculationCursor) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationCursor::mean(self : GraphflowcirculationCursor) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationCursor::scale(self : GraphflowcirculationCursor, f : Double) -> GraphflowcirculationCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationCursor::add(self : GraphflowcirculationCursor, other : GraphflowcirculationCursor) -> GraphflowcirculationCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationCursor::copy(self : GraphflowcirculationCursor) -> GraphflowcirculationCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationCursor::fill(self : GraphflowcirculationCursor, v : Double) -> GraphflowcirculationCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationCursor::min(self : GraphflowcirculationCursor) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationCursor::max(self : GraphflowcirculationCursor) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationCursor::to_string(self : GraphflowcirculationCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_view_make(size : Int) -> GraphflowcirculationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationView::len(self : GraphflowcirculationView) -> Int { self.size }

pub fn GraphflowcirculationView::get(self : GraphflowcirculationView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationView::set(self : GraphflowcirculationView, i : Int, v : Double) -> GraphflowcirculationView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationView::sum(self : GraphflowcirculationView) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationView::mean(self : GraphflowcirculationView) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationView::scale(self : GraphflowcirculationView, f : Double) -> GraphflowcirculationView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationView::add(self : GraphflowcirculationView, other : GraphflowcirculationView) -> GraphflowcirculationView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationView::copy(self : GraphflowcirculationView) -> GraphflowcirculationView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationView::fill(self : GraphflowcirculationView, v : Double) -> GraphflowcirculationView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationView::min(self : GraphflowcirculationView) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationView::max(self : GraphflowcirculationView) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationView::to_string(self : GraphflowcirculationView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_range_make(size : Int) -> GraphflowcirculationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationRange::len(self : GraphflowcirculationRange) -> Int { self.size }

pub fn GraphflowcirculationRange::get(self : GraphflowcirculationRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationRange::set(self : GraphflowcirculationRange, i : Int, v : Double) -> GraphflowcirculationRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationRange::sum(self : GraphflowcirculationRange) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationRange::mean(self : GraphflowcirculationRange) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationRange::scale(self : GraphflowcirculationRange, f : Double) -> GraphflowcirculationRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationRange::add(self : GraphflowcirculationRange, other : GraphflowcirculationRange) -> GraphflowcirculationRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationRange::copy(self : GraphflowcirculationRange) -> GraphflowcirculationRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationRange::fill(self : GraphflowcirculationRange, v : Double) -> GraphflowcirculationRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationRange::min(self : GraphflowcirculationRange) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationRange::max(self : GraphflowcirculationRange) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationRange::to_string(self : GraphflowcirculationRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_slice_make(size : Int) -> GraphflowcirculationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowcirculationSlice::len(self : GraphflowcirculationSlice) -> Int { self.size }

pub fn GraphflowcirculationSlice::get(self : GraphflowcirculationSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowcirculationSlice::set(self : GraphflowcirculationSlice, i : Int, v : Double) -> GraphflowcirculationSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationSlice::sum(self : GraphflowcirculationSlice) -> Double { @_common.sum(self.data) }

pub fn GraphflowcirculationSlice::mean(self : GraphflowcirculationSlice) -> Double { @_common.mean(self.data) }

pub fn GraphflowcirculationSlice::scale(self : GraphflowcirculationSlice, f : Double) -> GraphflowcirculationSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationSlice::add(self : GraphflowcirculationSlice, other : GraphflowcirculationSlice) -> GraphflowcirculationSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowcirculationSlice::copy(self : GraphflowcirculationSlice) -> GraphflowcirculationSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationSlice::fill(self : GraphflowcirculationSlice, v : Double) -> GraphflowcirculationSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowcirculationSlice::min(self : GraphflowcirculationSlice) -> Double { @_common.min(self.data) }

pub fn GraphflowcirculationSlice::max(self : GraphflowcirculationSlice) -> Double { @_common.max(self.data) }

pub fn GraphflowcirculationSlice::to_string(self : GraphflowcirculationSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

