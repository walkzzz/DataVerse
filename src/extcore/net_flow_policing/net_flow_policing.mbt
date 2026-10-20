///===
/// extcore/net_flow_policing

pub(all) struct NetflowpolicingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_policing_make_point(x : Double, y : Double) -> NetflowpolicingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_policing_make_point3(x : Double, y : Double, z : Double) -> NetflowpolicingPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowpolicingPoint::x(self : NetflowpolicingPoint) -> Double { self.x }

pub fn NetflowpolicingPoint::y(self : NetflowpolicingPoint) -> Double { self.y }

pub fn NetflowpolicingPoint::z(self : NetflowpolicingPoint) -> Double { self.z }

pub fn NetflowpolicingPoint::label(self : NetflowpolicingPoint) -> Int { self.label }

pub fn NetflowpolicingPoint::dist(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowpolicingPoint::add(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowpolicingPoint::sub(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowpolicingPoint::scale(self : NetflowpolicingPoint, s : Double) -> NetflowpolicingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowpolicingPoint::dot(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowpolicingPoint::cross(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowpolicingPoint::norm(self : NetflowpolicingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowpolicingPoint::normalize(self : NetflowpolicingPoint) -> NetflowpolicingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowpolicingPoint::negate(self : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowpolicingPoint::mid(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowpolicingPoint::lerp(self : NetflowpolicingPoint, other : NetflowpolicingPoint, t : Double) -> NetflowpolicingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowpolicingPoint::to_string(self : NetflowpolicingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowpolicingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_policing_make_series(vals : Array[Double], name : String) -> NetflowpolicingSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowpolicingSeries::len(self : NetflowpolicingSeries) -> Int { self.vals.length() }

pub fn NetflowpolicingSeries::sum(self : NetflowpolicingSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowpolicingSeries::mean(self : NetflowpolicingSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowpolicingSeries::min(self : NetflowpolicingSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowpolicingSeries::max(self : NetflowpolicingSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowpolicingSeries::range(self : NetflowpolicingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowpolicingSeries::variance(self : NetflowpolicingSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowpolicingSeries::std(self : NetflowpolicingSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowpolicingSeries::median(self : NetflowpolicingSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowpolicingSeries::scale(self : NetflowpolicingSeries, f : Double) -> NetflowpolicingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowpolicingSeries::add(self : NetflowpolicingSeries, other : NetflowpolicingSeries) -> NetflowpolicingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowpolicingSeries::sub(self : NetflowpolicingSeries, other : NetflowpolicingSeries) -> NetflowpolicingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowpolicingSeries::normalize(self : NetflowpolicingSeries) -> NetflowpolicingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowpolicingSeries::cumsum(self : NetflowpolicingSeries) -> NetflowpolicingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowpolicingSeries::to_string(self : NetflowpolicingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowpolicingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_policing_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowpolicingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_policing_matrix_identity(n : Int) -> NetflowpolicingMatrix {
  let m = net_flow_policing_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowpolicingMatrix::get(self : NetflowpolicingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowpolicingMatrix::transpose(self : NetflowpolicingMatrix) -> NetflowpolicingMatrix {
  let result = net_flow_policing_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowpolicingMatrix::add(self : NetflowpolicingMatrix, other : NetflowpolicingMatrix) -> NetflowpolicingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_policing_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowpolicingMatrix::scale(self : NetflowpolicingMatrix, s : Double) -> NetflowpolicingMatrix {
  let result = net_flow_policing_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowpolicingMatrix::multiply(self : NetflowpolicingMatrix, other : NetflowpolicingMatrix) -> NetflowpolicingMatrix {
  if self.cols != other.rows { return net_flow_policing_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_policing_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowpolicingMatrix::trace(self : NetflowpolicingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowpolicingMatrix::det(self : NetflowpolicingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowpolicingMatrix::norm(self : NetflowpolicingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowpolicingMatrix::to_string(self : NetflowpolicingMatrix) -> String {
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

pub(all) struct NetflowpolicingVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_policing_make_vector(comps : Array[Double]) -> NetflowpolicingVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_policing_vector_zero(dim : Int) -> NetflowpolicingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowpolicingVector::add(self : NetflowpolicingVector, other : NetflowpolicingVector) -> NetflowpolicingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowpolicingVector::sub(self : NetflowpolicingVector, other : NetflowpolicingVector) -> NetflowpolicingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowpolicingVector::scale(self : NetflowpolicingVector, s : Double) -> NetflowpolicingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowpolicingVector::dot(self : NetflowpolicingVector, other : NetflowpolicingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowpolicingVector::norm(self : NetflowpolicingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowpolicingVector::normalize(self : NetflowpolicingVector) -> NetflowpolicingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowpolicingVector::dist(self : NetflowpolicingVector, other : NetflowpolicingVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowpolicingVector::to_string(self : NetflowpolicingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowpolicingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_frame_make(size : Int) -> NetflowpolicingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingFrame::len(self : NetflowpolicingFrame) -> Int { self.size }

pub fn NetflowpolicingFrame::get(self : NetflowpolicingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingFrame::set(self : NetflowpolicingFrame, i : Int, v : Double) -> NetflowpolicingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingFrame::sum(self : NetflowpolicingFrame) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingFrame::mean(self : NetflowpolicingFrame) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingFrame::scale(self : NetflowpolicingFrame, f : Double) -> NetflowpolicingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingFrame::add(self : NetflowpolicingFrame, other : NetflowpolicingFrame) -> NetflowpolicingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingFrame::copy(self : NetflowpolicingFrame) -> NetflowpolicingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingFrame::fill(self : NetflowpolicingFrame, v : Double) -> NetflowpolicingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingFrame::min(self : NetflowpolicingFrame) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingFrame::max(self : NetflowpolicingFrame) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingFrame::to_string(self : NetflowpolicingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_table_make(size : Int) -> NetflowpolicingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingTable::len(self : NetflowpolicingTable) -> Int { self.size }

pub fn NetflowpolicingTable::get(self : NetflowpolicingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingTable::set(self : NetflowpolicingTable, i : Int, v : Double) -> NetflowpolicingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingTable::sum(self : NetflowpolicingTable) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingTable::mean(self : NetflowpolicingTable) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingTable::scale(self : NetflowpolicingTable, f : Double) -> NetflowpolicingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingTable::add(self : NetflowpolicingTable, other : NetflowpolicingTable) -> NetflowpolicingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingTable::copy(self : NetflowpolicingTable) -> NetflowpolicingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingTable::fill(self : NetflowpolicingTable, v : Double) -> NetflowpolicingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingTable::min(self : NetflowpolicingTable) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingTable::max(self : NetflowpolicingTable) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingTable::to_string(self : NetflowpolicingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_graphn_make(size : Int) -> NetflowpolicingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingGraphN::len(self : NetflowpolicingGraphN) -> Int { self.size }

pub fn NetflowpolicingGraphN::get(self : NetflowpolicingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingGraphN::set(self : NetflowpolicingGraphN, i : Int, v : Double) -> NetflowpolicingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingGraphN::sum(self : NetflowpolicingGraphN) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingGraphN::mean(self : NetflowpolicingGraphN) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingGraphN::scale(self : NetflowpolicingGraphN, f : Double) -> NetflowpolicingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingGraphN::add(self : NetflowpolicingGraphN, other : NetflowpolicingGraphN) -> NetflowpolicingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingGraphN::copy(self : NetflowpolicingGraphN) -> NetflowpolicingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingGraphN::fill(self : NetflowpolicingGraphN, v : Double) -> NetflowpolicingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingGraphN::min(self : NetflowpolicingGraphN) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingGraphN::max(self : NetflowpolicingGraphN) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingGraphN::to_string(self : NetflowpolicingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_node_make(size : Int) -> NetflowpolicingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingNode::len(self : NetflowpolicingNode) -> Int { self.size }

pub fn NetflowpolicingNode::get(self : NetflowpolicingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingNode::set(self : NetflowpolicingNode, i : Int, v : Double) -> NetflowpolicingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingNode::sum(self : NetflowpolicingNode) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingNode::mean(self : NetflowpolicingNode) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingNode::scale(self : NetflowpolicingNode, f : Double) -> NetflowpolicingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingNode::add(self : NetflowpolicingNode, other : NetflowpolicingNode) -> NetflowpolicingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingNode::copy(self : NetflowpolicingNode) -> NetflowpolicingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingNode::fill(self : NetflowpolicingNode, v : Double) -> NetflowpolicingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingNode::min(self : NetflowpolicingNode) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingNode::max(self : NetflowpolicingNode) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingNode::to_string(self : NetflowpolicingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_edge_make(size : Int) -> NetflowpolicingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingEdge::len(self : NetflowpolicingEdge) -> Int { self.size }

pub fn NetflowpolicingEdge::get(self : NetflowpolicingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingEdge::set(self : NetflowpolicingEdge, i : Int, v : Double) -> NetflowpolicingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingEdge::sum(self : NetflowpolicingEdge) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingEdge::mean(self : NetflowpolicingEdge) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingEdge::scale(self : NetflowpolicingEdge, f : Double) -> NetflowpolicingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingEdge::add(self : NetflowpolicingEdge, other : NetflowpolicingEdge) -> NetflowpolicingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingEdge::copy(self : NetflowpolicingEdge) -> NetflowpolicingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingEdge::fill(self : NetflowpolicingEdge, v : Double) -> NetflowpolicingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingEdge::min(self : NetflowpolicingEdge) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingEdge::max(self : NetflowpolicingEdge) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingEdge::to_string(self : NetflowpolicingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_path_make(size : Int) -> NetflowpolicingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingPath::len(self : NetflowpolicingPath) -> Int { self.size }

pub fn NetflowpolicingPath::get(self : NetflowpolicingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingPath::set(self : NetflowpolicingPath, i : Int, v : Double) -> NetflowpolicingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingPath::sum(self : NetflowpolicingPath) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingPath::mean(self : NetflowpolicingPath) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingPath::scale(self : NetflowpolicingPath, f : Double) -> NetflowpolicingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingPath::add(self : NetflowpolicingPath, other : NetflowpolicingPath) -> NetflowpolicingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingPath::copy(self : NetflowpolicingPath) -> NetflowpolicingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingPath::fill(self : NetflowpolicingPath, v : Double) -> NetflowpolicingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingPath::min(self : NetflowpolicingPath) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingPath::max(self : NetflowpolicingPath) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingPath::to_string(self : NetflowpolicingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_cluster_make(size : Int) -> NetflowpolicingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingCluster::len(self : NetflowpolicingCluster) -> Int { self.size }

pub fn NetflowpolicingCluster::get(self : NetflowpolicingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingCluster::set(self : NetflowpolicingCluster, i : Int, v : Double) -> NetflowpolicingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingCluster::sum(self : NetflowpolicingCluster) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingCluster::mean(self : NetflowpolicingCluster) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingCluster::scale(self : NetflowpolicingCluster, f : Double) -> NetflowpolicingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingCluster::add(self : NetflowpolicingCluster, other : NetflowpolicingCluster) -> NetflowpolicingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingCluster::copy(self : NetflowpolicingCluster) -> NetflowpolicingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingCluster::fill(self : NetflowpolicingCluster, v : Double) -> NetflowpolicingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingCluster::min(self : NetflowpolicingCluster) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingCluster::max(self : NetflowpolicingCluster) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingCluster::to_string(self : NetflowpolicingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_model_make(size : Int) -> NetflowpolicingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingModel::len(self : NetflowpolicingModel) -> Int { self.size }

pub fn NetflowpolicingModel::get(self : NetflowpolicingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingModel::set(self : NetflowpolicingModel, i : Int, v : Double) -> NetflowpolicingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingModel::sum(self : NetflowpolicingModel) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingModel::mean(self : NetflowpolicingModel) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingModel::scale(self : NetflowpolicingModel, f : Double) -> NetflowpolicingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingModel::add(self : NetflowpolicingModel, other : NetflowpolicingModel) -> NetflowpolicingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingModel::copy(self : NetflowpolicingModel) -> NetflowpolicingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingModel::fill(self : NetflowpolicingModel, v : Double) -> NetflowpolicingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingModel::min(self : NetflowpolicingModel) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingModel::max(self : NetflowpolicingModel) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingModel::to_string(self : NetflowpolicingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_layer_make(size : Int) -> NetflowpolicingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingLayer::len(self : NetflowpolicingLayer) -> Int { self.size }

pub fn NetflowpolicingLayer::get(self : NetflowpolicingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingLayer::set(self : NetflowpolicingLayer, i : Int, v : Double) -> NetflowpolicingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingLayer::sum(self : NetflowpolicingLayer) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingLayer::mean(self : NetflowpolicingLayer) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingLayer::scale(self : NetflowpolicingLayer, f : Double) -> NetflowpolicingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingLayer::add(self : NetflowpolicingLayer, other : NetflowpolicingLayer) -> NetflowpolicingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingLayer::copy(self : NetflowpolicingLayer) -> NetflowpolicingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingLayer::fill(self : NetflowpolicingLayer, v : Double) -> NetflowpolicingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingLayer::min(self : NetflowpolicingLayer) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingLayer::max(self : NetflowpolicingLayer) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingLayer::to_string(self : NetflowpolicingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_buffer_make(size : Int) -> NetflowpolicingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingBuffer::len(self : NetflowpolicingBuffer) -> Int { self.size }

pub fn NetflowpolicingBuffer::get(self : NetflowpolicingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingBuffer::set(self : NetflowpolicingBuffer, i : Int, v : Double) -> NetflowpolicingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingBuffer::sum(self : NetflowpolicingBuffer) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingBuffer::mean(self : NetflowpolicingBuffer) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingBuffer::scale(self : NetflowpolicingBuffer, f : Double) -> NetflowpolicingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingBuffer::add(self : NetflowpolicingBuffer, other : NetflowpolicingBuffer) -> NetflowpolicingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingBuffer::copy(self : NetflowpolicingBuffer) -> NetflowpolicingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingBuffer::fill(self : NetflowpolicingBuffer, v : Double) -> NetflowpolicingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingBuffer::min(self : NetflowpolicingBuffer) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingBuffer::max(self : NetflowpolicingBuffer) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingBuffer::to_string(self : NetflowpolicingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_cursor_make(size : Int) -> NetflowpolicingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingCursor::len(self : NetflowpolicingCursor) -> Int { self.size }

pub fn NetflowpolicingCursor::get(self : NetflowpolicingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingCursor::set(self : NetflowpolicingCursor, i : Int, v : Double) -> NetflowpolicingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingCursor::sum(self : NetflowpolicingCursor) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingCursor::mean(self : NetflowpolicingCursor) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingCursor::scale(self : NetflowpolicingCursor, f : Double) -> NetflowpolicingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingCursor::add(self : NetflowpolicingCursor, other : NetflowpolicingCursor) -> NetflowpolicingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingCursor::copy(self : NetflowpolicingCursor) -> NetflowpolicingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingCursor::fill(self : NetflowpolicingCursor, v : Double) -> NetflowpolicingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingCursor::min(self : NetflowpolicingCursor) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingCursor::max(self : NetflowpolicingCursor) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingCursor::to_string(self : NetflowpolicingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_view_make(size : Int) -> NetflowpolicingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingView::len(self : NetflowpolicingView) -> Int { self.size }

pub fn NetflowpolicingView::get(self : NetflowpolicingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingView::set(self : NetflowpolicingView, i : Int, v : Double) -> NetflowpolicingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingView::sum(self : NetflowpolicingView) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingView::mean(self : NetflowpolicingView) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingView::scale(self : NetflowpolicingView, f : Double) -> NetflowpolicingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingView::add(self : NetflowpolicingView, other : NetflowpolicingView) -> NetflowpolicingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingView::copy(self : NetflowpolicingView) -> NetflowpolicingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingView::fill(self : NetflowpolicingView, v : Double) -> NetflowpolicingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingView::min(self : NetflowpolicingView) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingView::max(self : NetflowpolicingView) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingView::to_string(self : NetflowpolicingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_range_make(size : Int) -> NetflowpolicingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingRange::len(self : NetflowpolicingRange) -> Int { self.size }

pub fn NetflowpolicingRange::get(self : NetflowpolicingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingRange::set(self : NetflowpolicingRange, i : Int, v : Double) -> NetflowpolicingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingRange::sum(self : NetflowpolicingRange) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingRange::mean(self : NetflowpolicingRange) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingRange::scale(self : NetflowpolicingRange, f : Double) -> NetflowpolicingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingRange::add(self : NetflowpolicingRange, other : NetflowpolicingRange) -> NetflowpolicingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingRange::copy(self : NetflowpolicingRange) -> NetflowpolicingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingRange::fill(self : NetflowpolicingRange, v : Double) -> NetflowpolicingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingRange::min(self : NetflowpolicingRange) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingRange::max(self : NetflowpolicingRange) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingRange::to_string(self : NetflowpolicingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_slice_make(size : Int) -> NetflowpolicingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowpolicingSlice::len(self : NetflowpolicingSlice) -> Int { self.size }

pub fn NetflowpolicingSlice::get(self : NetflowpolicingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowpolicingSlice::set(self : NetflowpolicingSlice, i : Int, v : Double) -> NetflowpolicingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowpolicingSlice::sum(self : NetflowpolicingSlice) -> Double { @_common.sum(self.data) }

pub fn NetflowpolicingSlice::mean(self : NetflowpolicingSlice) -> Double { @_common.mean(self.data) }

pub fn NetflowpolicingSlice::scale(self : NetflowpolicingSlice, f : Double) -> NetflowpolicingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingSlice::add(self : NetflowpolicingSlice, other : NetflowpolicingSlice) -> NetflowpolicingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowpolicingSlice::copy(self : NetflowpolicingSlice) -> NetflowpolicingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingSlice::fill(self : NetflowpolicingSlice, v : Double) -> NetflowpolicingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowpolicingSlice::min(self : NetflowpolicingSlice) -> Double { @_common.min(self.data) }

pub fn NetflowpolicingSlice::max(self : NetflowpolicingSlice) -> Double { @_common.max(self.data) }

pub fn NetflowpolicingSlice::to_string(self : NetflowpolicingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

