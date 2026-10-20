///===
/// extcore/net_flow_scheduling

pub(all) struct NetflowschedulingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_scheduling_make_point(x : Double, y : Double) -> NetflowschedulingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_scheduling_make_point3(x : Double, y : Double, z : Double) -> NetflowschedulingPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowschedulingPoint::x(self : NetflowschedulingPoint) -> Double { self.x }

pub fn NetflowschedulingPoint::y(self : NetflowschedulingPoint) -> Double { self.y }

pub fn NetflowschedulingPoint::z(self : NetflowschedulingPoint) -> Double { self.z }

pub fn NetflowschedulingPoint::label(self : NetflowschedulingPoint) -> Int { self.label }

pub fn NetflowschedulingPoint::dist(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowschedulingPoint::add(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowschedulingPoint::sub(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowschedulingPoint::scale(self : NetflowschedulingPoint, s : Double) -> NetflowschedulingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowschedulingPoint::dot(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowschedulingPoint::cross(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowschedulingPoint::norm(self : NetflowschedulingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowschedulingPoint::normalize(self : NetflowschedulingPoint) -> NetflowschedulingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowschedulingPoint::negate(self : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowschedulingPoint::mid(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowschedulingPoint::lerp(self : NetflowschedulingPoint, other : NetflowschedulingPoint, t : Double) -> NetflowschedulingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowschedulingPoint::to_string(self : NetflowschedulingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowschedulingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_scheduling_make_series(vals : Array[Double], name : String) -> NetflowschedulingSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowschedulingSeries::len(self : NetflowschedulingSeries) -> Int { self.vals.length() }

pub fn NetflowschedulingSeries::sum(self : NetflowschedulingSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowschedulingSeries::mean(self : NetflowschedulingSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowschedulingSeries::min(self : NetflowschedulingSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowschedulingSeries::max(self : NetflowschedulingSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowschedulingSeries::range(self : NetflowschedulingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowschedulingSeries::variance(self : NetflowschedulingSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowschedulingSeries::std(self : NetflowschedulingSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowschedulingSeries::median(self : NetflowschedulingSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowschedulingSeries::scale(self : NetflowschedulingSeries, f : Double) -> NetflowschedulingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowschedulingSeries::add(self : NetflowschedulingSeries, other : NetflowschedulingSeries) -> NetflowschedulingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowschedulingSeries::sub(self : NetflowschedulingSeries, other : NetflowschedulingSeries) -> NetflowschedulingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowschedulingSeries::normalize(self : NetflowschedulingSeries) -> NetflowschedulingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowschedulingSeries::cumsum(self : NetflowschedulingSeries) -> NetflowschedulingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowschedulingSeries::to_string(self : NetflowschedulingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowschedulingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_scheduling_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowschedulingMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn net_flow_scheduling_matrix_identity(n : Int) -> NetflowschedulingMatrix {
  let m = net_flow_scheduling_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowschedulingMatrix::get(self : NetflowschedulingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowschedulingMatrix::transpose(self : NetflowschedulingMatrix) -> NetflowschedulingMatrix {
  let result = net_flow_scheduling_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowschedulingMatrix::add(self : NetflowschedulingMatrix, other : NetflowschedulingMatrix) -> NetflowschedulingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_scheduling_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowschedulingMatrix::scale(self : NetflowschedulingMatrix, s : Double) -> NetflowschedulingMatrix {
  let result = net_flow_scheduling_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowschedulingMatrix::multiply(self : NetflowschedulingMatrix, other : NetflowschedulingMatrix) -> NetflowschedulingMatrix {
  if self.cols != other.rows { return net_flow_scheduling_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_scheduling_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetflowschedulingMatrix::trace(self : NetflowschedulingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowschedulingMatrix::det(self : NetflowschedulingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowschedulingMatrix::norm(self : NetflowschedulingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowschedulingMatrix::to_string(self : NetflowschedulingMatrix) -> String {
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

pub(all) struct NetflowschedulingVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_scheduling_make_vector(comps : Array[Double]) -> NetflowschedulingVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_scheduling_vector_zero(dim : Int) -> NetflowschedulingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowschedulingVector::add(self : NetflowschedulingVector, other : NetflowschedulingVector) -> NetflowschedulingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowschedulingVector::sub(self : NetflowschedulingVector, other : NetflowschedulingVector) -> NetflowschedulingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowschedulingVector::scale(self : NetflowschedulingVector, s : Double) -> NetflowschedulingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowschedulingVector::dot(self : NetflowschedulingVector, other : NetflowschedulingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowschedulingVector::norm(self : NetflowschedulingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowschedulingVector::normalize(self : NetflowschedulingVector) -> NetflowschedulingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowschedulingVector::dist(self : NetflowschedulingVector, other : NetflowschedulingVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowschedulingVector::to_string(self : NetflowschedulingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowschedulingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_frame_make(size : Int) -> NetflowschedulingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingFrame::len(self : NetflowschedulingFrame) -> Int { self.size }

pub fn NetflowschedulingFrame::get(self : NetflowschedulingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingFrame::set(self : NetflowschedulingFrame, i : Int, v : Double) -> NetflowschedulingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingFrame::sum(self : NetflowschedulingFrame) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingFrame::mean(self : NetflowschedulingFrame) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingFrame::scale(self : NetflowschedulingFrame, f : Double) -> NetflowschedulingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingFrame::add(self : NetflowschedulingFrame, other : NetflowschedulingFrame) -> NetflowschedulingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingFrame::copy(self : NetflowschedulingFrame) -> NetflowschedulingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingFrame::fill(self : NetflowschedulingFrame, v : Double) -> NetflowschedulingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingFrame::min(self : NetflowschedulingFrame) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingFrame::max(self : NetflowschedulingFrame) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingFrame::to_string(self : NetflowschedulingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_table_make(size : Int) -> NetflowschedulingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingTable::len(self : NetflowschedulingTable) -> Int { self.size }

pub fn NetflowschedulingTable::get(self : NetflowschedulingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingTable::set(self : NetflowschedulingTable, i : Int, v : Double) -> NetflowschedulingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingTable::sum(self : NetflowschedulingTable) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingTable::mean(self : NetflowschedulingTable) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingTable::scale(self : NetflowschedulingTable, f : Double) -> NetflowschedulingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingTable::add(self : NetflowschedulingTable, other : NetflowschedulingTable) -> NetflowschedulingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingTable::copy(self : NetflowschedulingTable) -> NetflowschedulingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingTable::fill(self : NetflowschedulingTable, v : Double) -> NetflowschedulingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingTable::min(self : NetflowschedulingTable) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingTable::max(self : NetflowschedulingTable) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingTable::to_string(self : NetflowschedulingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_graphn_make(size : Int) -> NetflowschedulingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingGraphN::len(self : NetflowschedulingGraphN) -> Int { self.size }

pub fn NetflowschedulingGraphN::get(self : NetflowschedulingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingGraphN::set(self : NetflowschedulingGraphN, i : Int, v : Double) -> NetflowschedulingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingGraphN::sum(self : NetflowschedulingGraphN) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingGraphN::mean(self : NetflowschedulingGraphN) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingGraphN::scale(self : NetflowschedulingGraphN, f : Double) -> NetflowschedulingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingGraphN::add(self : NetflowschedulingGraphN, other : NetflowschedulingGraphN) -> NetflowschedulingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingGraphN::copy(self : NetflowschedulingGraphN) -> NetflowschedulingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingGraphN::fill(self : NetflowschedulingGraphN, v : Double) -> NetflowschedulingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingGraphN::min(self : NetflowschedulingGraphN) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingGraphN::max(self : NetflowschedulingGraphN) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingGraphN::to_string(self : NetflowschedulingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_node_make(size : Int) -> NetflowschedulingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingNode::len(self : NetflowschedulingNode) -> Int { self.size }

pub fn NetflowschedulingNode::get(self : NetflowschedulingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingNode::set(self : NetflowschedulingNode, i : Int, v : Double) -> NetflowschedulingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingNode::sum(self : NetflowschedulingNode) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingNode::mean(self : NetflowschedulingNode) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingNode::scale(self : NetflowschedulingNode, f : Double) -> NetflowschedulingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingNode::add(self : NetflowschedulingNode, other : NetflowschedulingNode) -> NetflowschedulingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingNode::copy(self : NetflowschedulingNode) -> NetflowschedulingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingNode::fill(self : NetflowschedulingNode, v : Double) -> NetflowschedulingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingNode::min(self : NetflowschedulingNode) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingNode::max(self : NetflowschedulingNode) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingNode::to_string(self : NetflowschedulingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_edge_make(size : Int) -> NetflowschedulingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingEdge::len(self : NetflowschedulingEdge) -> Int { self.size }

pub fn NetflowschedulingEdge::get(self : NetflowschedulingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingEdge::set(self : NetflowschedulingEdge, i : Int, v : Double) -> NetflowschedulingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingEdge::sum(self : NetflowschedulingEdge) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingEdge::mean(self : NetflowschedulingEdge) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingEdge::scale(self : NetflowschedulingEdge, f : Double) -> NetflowschedulingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingEdge::add(self : NetflowschedulingEdge, other : NetflowschedulingEdge) -> NetflowschedulingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingEdge::copy(self : NetflowschedulingEdge) -> NetflowschedulingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingEdge::fill(self : NetflowschedulingEdge, v : Double) -> NetflowschedulingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingEdge::min(self : NetflowschedulingEdge) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingEdge::max(self : NetflowschedulingEdge) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingEdge::to_string(self : NetflowschedulingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_path_make(size : Int) -> NetflowschedulingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingPath::len(self : NetflowschedulingPath) -> Int { self.size }

pub fn NetflowschedulingPath::get(self : NetflowschedulingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingPath::set(self : NetflowschedulingPath, i : Int, v : Double) -> NetflowschedulingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingPath::sum(self : NetflowschedulingPath) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingPath::mean(self : NetflowschedulingPath) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingPath::scale(self : NetflowschedulingPath, f : Double) -> NetflowschedulingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingPath::add(self : NetflowschedulingPath, other : NetflowschedulingPath) -> NetflowschedulingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingPath::copy(self : NetflowschedulingPath) -> NetflowschedulingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingPath::fill(self : NetflowschedulingPath, v : Double) -> NetflowschedulingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingPath::min(self : NetflowschedulingPath) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingPath::max(self : NetflowschedulingPath) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingPath::to_string(self : NetflowschedulingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_cluster_make(size : Int) -> NetflowschedulingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingCluster::len(self : NetflowschedulingCluster) -> Int { self.size }

pub fn NetflowschedulingCluster::get(self : NetflowschedulingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingCluster::set(self : NetflowschedulingCluster, i : Int, v : Double) -> NetflowschedulingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingCluster::sum(self : NetflowschedulingCluster) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingCluster::mean(self : NetflowschedulingCluster) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingCluster::scale(self : NetflowschedulingCluster, f : Double) -> NetflowschedulingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingCluster::add(self : NetflowschedulingCluster, other : NetflowschedulingCluster) -> NetflowschedulingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingCluster::copy(self : NetflowschedulingCluster) -> NetflowschedulingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingCluster::fill(self : NetflowschedulingCluster, v : Double) -> NetflowschedulingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingCluster::min(self : NetflowschedulingCluster) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingCluster::max(self : NetflowschedulingCluster) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingCluster::to_string(self : NetflowschedulingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_model_make(size : Int) -> NetflowschedulingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingModel::len(self : NetflowschedulingModel) -> Int { self.size }

pub fn NetflowschedulingModel::get(self : NetflowschedulingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingModel::set(self : NetflowschedulingModel, i : Int, v : Double) -> NetflowschedulingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingModel::sum(self : NetflowschedulingModel) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingModel::mean(self : NetflowschedulingModel) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingModel::scale(self : NetflowschedulingModel, f : Double) -> NetflowschedulingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingModel::add(self : NetflowschedulingModel, other : NetflowschedulingModel) -> NetflowschedulingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingModel::copy(self : NetflowschedulingModel) -> NetflowschedulingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingModel::fill(self : NetflowschedulingModel, v : Double) -> NetflowschedulingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingModel::min(self : NetflowschedulingModel) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingModel::max(self : NetflowschedulingModel) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingModel::to_string(self : NetflowschedulingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_layer_make(size : Int) -> NetflowschedulingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingLayer::len(self : NetflowschedulingLayer) -> Int { self.size }

pub fn NetflowschedulingLayer::get(self : NetflowschedulingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingLayer::set(self : NetflowschedulingLayer, i : Int, v : Double) -> NetflowschedulingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingLayer::sum(self : NetflowschedulingLayer) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingLayer::mean(self : NetflowschedulingLayer) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingLayer::scale(self : NetflowschedulingLayer, f : Double) -> NetflowschedulingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingLayer::add(self : NetflowschedulingLayer, other : NetflowschedulingLayer) -> NetflowschedulingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingLayer::copy(self : NetflowschedulingLayer) -> NetflowschedulingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingLayer::fill(self : NetflowschedulingLayer, v : Double) -> NetflowschedulingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingLayer::min(self : NetflowschedulingLayer) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingLayer::max(self : NetflowschedulingLayer) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingLayer::to_string(self : NetflowschedulingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_buffer_make(size : Int) -> NetflowschedulingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingBuffer::len(self : NetflowschedulingBuffer) -> Int { self.size }

pub fn NetflowschedulingBuffer::get(self : NetflowschedulingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingBuffer::set(self : NetflowschedulingBuffer, i : Int, v : Double) -> NetflowschedulingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingBuffer::sum(self : NetflowschedulingBuffer) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingBuffer::mean(self : NetflowschedulingBuffer) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingBuffer::scale(self : NetflowschedulingBuffer, f : Double) -> NetflowschedulingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingBuffer::add(self : NetflowschedulingBuffer, other : NetflowschedulingBuffer) -> NetflowschedulingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingBuffer::copy(self : NetflowschedulingBuffer) -> NetflowschedulingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingBuffer::fill(self : NetflowschedulingBuffer, v : Double) -> NetflowschedulingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingBuffer::min(self : NetflowschedulingBuffer) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingBuffer::max(self : NetflowschedulingBuffer) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingBuffer::to_string(self : NetflowschedulingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_cursor_make(size : Int) -> NetflowschedulingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingCursor::len(self : NetflowschedulingCursor) -> Int { self.size }

pub fn NetflowschedulingCursor::get(self : NetflowschedulingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingCursor::set(self : NetflowschedulingCursor, i : Int, v : Double) -> NetflowschedulingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingCursor::sum(self : NetflowschedulingCursor) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingCursor::mean(self : NetflowschedulingCursor) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingCursor::scale(self : NetflowschedulingCursor, f : Double) -> NetflowschedulingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingCursor::add(self : NetflowschedulingCursor, other : NetflowschedulingCursor) -> NetflowschedulingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingCursor::copy(self : NetflowschedulingCursor) -> NetflowschedulingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingCursor::fill(self : NetflowschedulingCursor, v : Double) -> NetflowschedulingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingCursor::min(self : NetflowschedulingCursor) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingCursor::max(self : NetflowschedulingCursor) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingCursor::to_string(self : NetflowschedulingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_view_make(size : Int) -> NetflowschedulingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingView::len(self : NetflowschedulingView) -> Int { self.size }

pub fn NetflowschedulingView::get(self : NetflowschedulingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingView::set(self : NetflowschedulingView, i : Int, v : Double) -> NetflowschedulingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingView::sum(self : NetflowschedulingView) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingView::mean(self : NetflowschedulingView) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingView::scale(self : NetflowschedulingView, f : Double) -> NetflowschedulingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingView::add(self : NetflowschedulingView, other : NetflowschedulingView) -> NetflowschedulingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingView::copy(self : NetflowschedulingView) -> NetflowschedulingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingView::fill(self : NetflowschedulingView, v : Double) -> NetflowschedulingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingView::min(self : NetflowschedulingView) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingView::max(self : NetflowschedulingView) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingView::to_string(self : NetflowschedulingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_range_make(size : Int) -> NetflowschedulingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingRange::len(self : NetflowschedulingRange) -> Int { self.size }

pub fn NetflowschedulingRange::get(self : NetflowschedulingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingRange::set(self : NetflowschedulingRange, i : Int, v : Double) -> NetflowschedulingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingRange::sum(self : NetflowschedulingRange) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingRange::mean(self : NetflowschedulingRange) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingRange::scale(self : NetflowschedulingRange, f : Double) -> NetflowschedulingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingRange::add(self : NetflowschedulingRange, other : NetflowschedulingRange) -> NetflowschedulingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingRange::copy(self : NetflowschedulingRange) -> NetflowschedulingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingRange::fill(self : NetflowschedulingRange, v : Double) -> NetflowschedulingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingRange::min(self : NetflowschedulingRange) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingRange::max(self : NetflowschedulingRange) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingRange::to_string(self : NetflowschedulingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_slice_make(size : Int) -> NetflowschedulingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowschedulingSlice::len(self : NetflowschedulingSlice) -> Int { self.size }

pub fn NetflowschedulingSlice::get(self : NetflowschedulingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowschedulingSlice::set(self : NetflowschedulingSlice, i : Int, v : Double) -> NetflowschedulingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowschedulingSlice::sum(self : NetflowschedulingSlice) -> Double { @_common.sum(self.data) }

pub fn NetflowschedulingSlice::mean(self : NetflowschedulingSlice) -> Double { @_common.mean(self.data) }

pub fn NetflowschedulingSlice::scale(self : NetflowschedulingSlice, f : Double) -> NetflowschedulingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingSlice::add(self : NetflowschedulingSlice, other : NetflowschedulingSlice) -> NetflowschedulingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowschedulingSlice::copy(self : NetflowschedulingSlice) -> NetflowschedulingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingSlice::fill(self : NetflowschedulingSlice, v : Double) -> NetflowschedulingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowschedulingSlice::min(self : NetflowschedulingSlice) -> Double { @_common.min(self.data) }

pub fn NetflowschedulingSlice::max(self : NetflowschedulingSlice) -> Double { @_common.max(self.data) }

pub fn NetflowschedulingSlice::to_string(self : NetflowschedulingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

