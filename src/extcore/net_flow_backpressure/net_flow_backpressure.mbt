///===
/// extcore/net_flow_backpressure

pub(all) struct NetflowbackpressurePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_backpressure_make_point(x : Double, y : Double) -> NetflowbackpressurePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_backpressure_make_point3(x : Double, y : Double, z : Double) -> NetflowbackpressurePoint {
  { x, y, z, label: 0 }
}

pub fn NetflowbackpressurePoint::x(self : NetflowbackpressurePoint) -> Double { self.x }

pub fn NetflowbackpressurePoint::y(self : NetflowbackpressurePoint) -> Double { self.y }

pub fn NetflowbackpressurePoint::z(self : NetflowbackpressurePoint) -> Double { self.z }

pub fn NetflowbackpressurePoint::label(self : NetflowbackpressurePoint) -> Int { self.label }

pub fn NetflowbackpressurePoint::dist(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowbackpressurePoint::add(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowbackpressurePoint::sub(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowbackpressurePoint::scale(self : NetflowbackpressurePoint, s : Double) -> NetflowbackpressurePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowbackpressurePoint::dot(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowbackpressurePoint::cross(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowbackpressurePoint::norm(self : NetflowbackpressurePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowbackpressurePoint::normalize(self : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowbackpressurePoint::negate(self : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowbackpressurePoint::mid(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowbackpressurePoint::lerp(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint, t : Double) -> NetflowbackpressurePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowbackpressurePoint::to_string(self : NetflowbackpressurePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowbackpressureSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_backpressure_make_series(vals : Array[Double], name : String) -> NetflowbackpressureSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowbackpressureSeries::len(self : NetflowbackpressureSeries) -> Int { self.vals.length() }

pub fn NetflowbackpressureSeries::sum(self : NetflowbackpressureSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowbackpressureSeries::mean(self : NetflowbackpressureSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowbackpressureSeries::min(self : NetflowbackpressureSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowbackpressureSeries::max(self : NetflowbackpressureSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowbackpressureSeries::range(self : NetflowbackpressureSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowbackpressureSeries::variance(self : NetflowbackpressureSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowbackpressureSeries::std(self : NetflowbackpressureSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowbackpressureSeries::median(self : NetflowbackpressureSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowbackpressureSeries::scale(self : NetflowbackpressureSeries, f : Double) -> NetflowbackpressureSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowbackpressureSeries::add(self : NetflowbackpressureSeries, other : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowbackpressureSeries::sub(self : NetflowbackpressureSeries, other : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowbackpressureSeries::normalize(self : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowbackpressureSeries::cumsum(self : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowbackpressureSeries::to_string(self : NetflowbackpressureSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowbackpressureMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_backpressure_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowbackpressureMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn net_flow_backpressure_matrix_identity(n : Int) -> NetflowbackpressureMatrix {
  let m = net_flow_backpressure_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowbackpressureMatrix::get(self : NetflowbackpressureMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowbackpressureMatrix::transpose(self : NetflowbackpressureMatrix) -> NetflowbackpressureMatrix {
  let result = net_flow_backpressure_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowbackpressureMatrix::add(self : NetflowbackpressureMatrix, other : NetflowbackpressureMatrix) -> NetflowbackpressureMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_backpressure_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowbackpressureMatrix::scale(self : NetflowbackpressureMatrix, s : Double) -> NetflowbackpressureMatrix {
  let result = net_flow_backpressure_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowbackpressureMatrix::multiply(self : NetflowbackpressureMatrix, other : NetflowbackpressureMatrix) -> NetflowbackpressureMatrix {
  if self.cols != other.rows { return net_flow_backpressure_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_backpressure_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetflowbackpressureMatrix::trace(self : NetflowbackpressureMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowbackpressureMatrix::det(self : NetflowbackpressureMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowbackpressureMatrix::norm(self : NetflowbackpressureMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowbackpressureMatrix::to_string(self : NetflowbackpressureMatrix) -> String {
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

pub(all) struct NetflowbackpressureVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_backpressure_make_vector(comps : Array[Double]) -> NetflowbackpressureVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_backpressure_vector_zero(dim : Int) -> NetflowbackpressureVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowbackpressureVector::add(self : NetflowbackpressureVector, other : NetflowbackpressureVector) -> NetflowbackpressureVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowbackpressureVector::sub(self : NetflowbackpressureVector, other : NetflowbackpressureVector) -> NetflowbackpressureVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowbackpressureVector::scale(self : NetflowbackpressureVector, s : Double) -> NetflowbackpressureVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowbackpressureVector::dot(self : NetflowbackpressureVector, other : NetflowbackpressureVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowbackpressureVector::norm(self : NetflowbackpressureVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowbackpressureVector::normalize(self : NetflowbackpressureVector) -> NetflowbackpressureVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowbackpressureVector::dist(self : NetflowbackpressureVector, other : NetflowbackpressureVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowbackpressureVector::to_string(self : NetflowbackpressureVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowbackpressureFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_frame_make(size : Int) -> NetflowbackpressureFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureFrame::len(self : NetflowbackpressureFrame) -> Int { self.size }

pub fn NetflowbackpressureFrame::get(self : NetflowbackpressureFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureFrame::set(self : NetflowbackpressureFrame, i : Int, v : Double) -> NetflowbackpressureFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureFrame::sum(self : NetflowbackpressureFrame) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureFrame::mean(self : NetflowbackpressureFrame) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureFrame::scale(self : NetflowbackpressureFrame, f : Double) -> NetflowbackpressureFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureFrame::add(self : NetflowbackpressureFrame, other : NetflowbackpressureFrame) -> NetflowbackpressureFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureFrame::copy(self : NetflowbackpressureFrame) -> NetflowbackpressureFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureFrame::fill(self : NetflowbackpressureFrame, v : Double) -> NetflowbackpressureFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureFrame::min(self : NetflowbackpressureFrame) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureFrame::max(self : NetflowbackpressureFrame) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureFrame::to_string(self : NetflowbackpressureFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_table_make(size : Int) -> NetflowbackpressureTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureTable::len(self : NetflowbackpressureTable) -> Int { self.size }

pub fn NetflowbackpressureTable::get(self : NetflowbackpressureTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureTable::set(self : NetflowbackpressureTable, i : Int, v : Double) -> NetflowbackpressureTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureTable::sum(self : NetflowbackpressureTable) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureTable::mean(self : NetflowbackpressureTable) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureTable::scale(self : NetflowbackpressureTable, f : Double) -> NetflowbackpressureTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureTable::add(self : NetflowbackpressureTable, other : NetflowbackpressureTable) -> NetflowbackpressureTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureTable::copy(self : NetflowbackpressureTable) -> NetflowbackpressureTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureTable::fill(self : NetflowbackpressureTable, v : Double) -> NetflowbackpressureTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureTable::min(self : NetflowbackpressureTable) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureTable::max(self : NetflowbackpressureTable) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureTable::to_string(self : NetflowbackpressureTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_graphn_make(size : Int) -> NetflowbackpressureGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureGraphN::len(self : NetflowbackpressureGraphN) -> Int { self.size }

pub fn NetflowbackpressureGraphN::get(self : NetflowbackpressureGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureGraphN::set(self : NetflowbackpressureGraphN, i : Int, v : Double) -> NetflowbackpressureGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureGraphN::sum(self : NetflowbackpressureGraphN) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureGraphN::mean(self : NetflowbackpressureGraphN) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureGraphN::scale(self : NetflowbackpressureGraphN, f : Double) -> NetflowbackpressureGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureGraphN::add(self : NetflowbackpressureGraphN, other : NetflowbackpressureGraphN) -> NetflowbackpressureGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureGraphN::copy(self : NetflowbackpressureGraphN) -> NetflowbackpressureGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureGraphN::fill(self : NetflowbackpressureGraphN, v : Double) -> NetflowbackpressureGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureGraphN::min(self : NetflowbackpressureGraphN) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureGraphN::max(self : NetflowbackpressureGraphN) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureGraphN::to_string(self : NetflowbackpressureGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_node_make(size : Int) -> NetflowbackpressureNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureNode::len(self : NetflowbackpressureNode) -> Int { self.size }

pub fn NetflowbackpressureNode::get(self : NetflowbackpressureNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureNode::set(self : NetflowbackpressureNode, i : Int, v : Double) -> NetflowbackpressureNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureNode::sum(self : NetflowbackpressureNode) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureNode::mean(self : NetflowbackpressureNode) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureNode::scale(self : NetflowbackpressureNode, f : Double) -> NetflowbackpressureNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureNode::add(self : NetflowbackpressureNode, other : NetflowbackpressureNode) -> NetflowbackpressureNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureNode::copy(self : NetflowbackpressureNode) -> NetflowbackpressureNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureNode::fill(self : NetflowbackpressureNode, v : Double) -> NetflowbackpressureNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureNode::min(self : NetflowbackpressureNode) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureNode::max(self : NetflowbackpressureNode) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureNode::to_string(self : NetflowbackpressureNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_edge_make(size : Int) -> NetflowbackpressureEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureEdge::len(self : NetflowbackpressureEdge) -> Int { self.size }

pub fn NetflowbackpressureEdge::get(self : NetflowbackpressureEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureEdge::set(self : NetflowbackpressureEdge, i : Int, v : Double) -> NetflowbackpressureEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureEdge::sum(self : NetflowbackpressureEdge) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureEdge::mean(self : NetflowbackpressureEdge) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureEdge::scale(self : NetflowbackpressureEdge, f : Double) -> NetflowbackpressureEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureEdge::add(self : NetflowbackpressureEdge, other : NetflowbackpressureEdge) -> NetflowbackpressureEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureEdge::copy(self : NetflowbackpressureEdge) -> NetflowbackpressureEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureEdge::fill(self : NetflowbackpressureEdge, v : Double) -> NetflowbackpressureEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureEdge::min(self : NetflowbackpressureEdge) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureEdge::max(self : NetflowbackpressureEdge) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureEdge::to_string(self : NetflowbackpressureEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressurePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_path_make(size : Int) -> NetflowbackpressurePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressurePath::len(self : NetflowbackpressurePath) -> Int { self.size }

pub fn NetflowbackpressurePath::get(self : NetflowbackpressurePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressurePath::set(self : NetflowbackpressurePath, i : Int, v : Double) -> NetflowbackpressurePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressurePath::sum(self : NetflowbackpressurePath) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressurePath::mean(self : NetflowbackpressurePath) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressurePath::scale(self : NetflowbackpressurePath, f : Double) -> NetflowbackpressurePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressurePath::add(self : NetflowbackpressurePath, other : NetflowbackpressurePath) -> NetflowbackpressurePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressurePath::copy(self : NetflowbackpressurePath) -> NetflowbackpressurePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressurePath::fill(self : NetflowbackpressurePath, v : Double) -> NetflowbackpressurePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressurePath::min(self : NetflowbackpressurePath) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressurePath::max(self : NetflowbackpressurePath) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressurePath::to_string(self : NetflowbackpressurePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_cluster_make(size : Int) -> NetflowbackpressureCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureCluster::len(self : NetflowbackpressureCluster) -> Int { self.size }

pub fn NetflowbackpressureCluster::get(self : NetflowbackpressureCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureCluster::set(self : NetflowbackpressureCluster, i : Int, v : Double) -> NetflowbackpressureCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureCluster::sum(self : NetflowbackpressureCluster) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureCluster::mean(self : NetflowbackpressureCluster) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureCluster::scale(self : NetflowbackpressureCluster, f : Double) -> NetflowbackpressureCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureCluster::add(self : NetflowbackpressureCluster, other : NetflowbackpressureCluster) -> NetflowbackpressureCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureCluster::copy(self : NetflowbackpressureCluster) -> NetflowbackpressureCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureCluster::fill(self : NetflowbackpressureCluster, v : Double) -> NetflowbackpressureCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureCluster::min(self : NetflowbackpressureCluster) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureCluster::max(self : NetflowbackpressureCluster) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureCluster::to_string(self : NetflowbackpressureCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_model_make(size : Int) -> NetflowbackpressureModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureModel::len(self : NetflowbackpressureModel) -> Int { self.size }

pub fn NetflowbackpressureModel::get(self : NetflowbackpressureModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureModel::set(self : NetflowbackpressureModel, i : Int, v : Double) -> NetflowbackpressureModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureModel::sum(self : NetflowbackpressureModel) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureModel::mean(self : NetflowbackpressureModel) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureModel::scale(self : NetflowbackpressureModel, f : Double) -> NetflowbackpressureModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureModel::add(self : NetflowbackpressureModel, other : NetflowbackpressureModel) -> NetflowbackpressureModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureModel::copy(self : NetflowbackpressureModel) -> NetflowbackpressureModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureModel::fill(self : NetflowbackpressureModel, v : Double) -> NetflowbackpressureModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureModel::min(self : NetflowbackpressureModel) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureModel::max(self : NetflowbackpressureModel) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureModel::to_string(self : NetflowbackpressureModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_layer_make(size : Int) -> NetflowbackpressureLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureLayer::len(self : NetflowbackpressureLayer) -> Int { self.size }

pub fn NetflowbackpressureLayer::get(self : NetflowbackpressureLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureLayer::set(self : NetflowbackpressureLayer, i : Int, v : Double) -> NetflowbackpressureLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureLayer::sum(self : NetflowbackpressureLayer) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureLayer::mean(self : NetflowbackpressureLayer) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureLayer::scale(self : NetflowbackpressureLayer, f : Double) -> NetflowbackpressureLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureLayer::add(self : NetflowbackpressureLayer, other : NetflowbackpressureLayer) -> NetflowbackpressureLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureLayer::copy(self : NetflowbackpressureLayer) -> NetflowbackpressureLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureLayer::fill(self : NetflowbackpressureLayer, v : Double) -> NetflowbackpressureLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureLayer::min(self : NetflowbackpressureLayer) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureLayer::max(self : NetflowbackpressureLayer) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureLayer::to_string(self : NetflowbackpressureLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_buffer_make(size : Int) -> NetflowbackpressureBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureBuffer::len(self : NetflowbackpressureBuffer) -> Int { self.size }

pub fn NetflowbackpressureBuffer::get(self : NetflowbackpressureBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureBuffer::set(self : NetflowbackpressureBuffer, i : Int, v : Double) -> NetflowbackpressureBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureBuffer::sum(self : NetflowbackpressureBuffer) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureBuffer::mean(self : NetflowbackpressureBuffer) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureBuffer::scale(self : NetflowbackpressureBuffer, f : Double) -> NetflowbackpressureBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureBuffer::add(self : NetflowbackpressureBuffer, other : NetflowbackpressureBuffer) -> NetflowbackpressureBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureBuffer::copy(self : NetflowbackpressureBuffer) -> NetflowbackpressureBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureBuffer::fill(self : NetflowbackpressureBuffer, v : Double) -> NetflowbackpressureBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureBuffer::min(self : NetflowbackpressureBuffer) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureBuffer::max(self : NetflowbackpressureBuffer) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureBuffer::to_string(self : NetflowbackpressureBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_cursor_make(size : Int) -> NetflowbackpressureCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureCursor::len(self : NetflowbackpressureCursor) -> Int { self.size }

pub fn NetflowbackpressureCursor::get(self : NetflowbackpressureCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureCursor::set(self : NetflowbackpressureCursor, i : Int, v : Double) -> NetflowbackpressureCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureCursor::sum(self : NetflowbackpressureCursor) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureCursor::mean(self : NetflowbackpressureCursor) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureCursor::scale(self : NetflowbackpressureCursor, f : Double) -> NetflowbackpressureCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureCursor::add(self : NetflowbackpressureCursor, other : NetflowbackpressureCursor) -> NetflowbackpressureCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureCursor::copy(self : NetflowbackpressureCursor) -> NetflowbackpressureCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureCursor::fill(self : NetflowbackpressureCursor, v : Double) -> NetflowbackpressureCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureCursor::min(self : NetflowbackpressureCursor) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureCursor::max(self : NetflowbackpressureCursor) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureCursor::to_string(self : NetflowbackpressureCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_view_make(size : Int) -> NetflowbackpressureView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureView::len(self : NetflowbackpressureView) -> Int { self.size }

pub fn NetflowbackpressureView::get(self : NetflowbackpressureView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureView::set(self : NetflowbackpressureView, i : Int, v : Double) -> NetflowbackpressureView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureView::sum(self : NetflowbackpressureView) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureView::mean(self : NetflowbackpressureView) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureView::scale(self : NetflowbackpressureView, f : Double) -> NetflowbackpressureView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureView::add(self : NetflowbackpressureView, other : NetflowbackpressureView) -> NetflowbackpressureView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureView::copy(self : NetflowbackpressureView) -> NetflowbackpressureView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureView::fill(self : NetflowbackpressureView, v : Double) -> NetflowbackpressureView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureView::min(self : NetflowbackpressureView) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureView::max(self : NetflowbackpressureView) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureView::to_string(self : NetflowbackpressureView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_range_make(size : Int) -> NetflowbackpressureRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureRange::len(self : NetflowbackpressureRange) -> Int { self.size }

pub fn NetflowbackpressureRange::get(self : NetflowbackpressureRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureRange::set(self : NetflowbackpressureRange, i : Int, v : Double) -> NetflowbackpressureRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureRange::sum(self : NetflowbackpressureRange) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureRange::mean(self : NetflowbackpressureRange) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureRange::scale(self : NetflowbackpressureRange, f : Double) -> NetflowbackpressureRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureRange::add(self : NetflowbackpressureRange, other : NetflowbackpressureRange) -> NetflowbackpressureRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureRange::copy(self : NetflowbackpressureRange) -> NetflowbackpressureRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureRange::fill(self : NetflowbackpressureRange, v : Double) -> NetflowbackpressureRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureRange::min(self : NetflowbackpressureRange) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureRange::max(self : NetflowbackpressureRange) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureRange::to_string(self : NetflowbackpressureRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_slice_make(size : Int) -> NetflowbackpressureSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbackpressureSlice::len(self : NetflowbackpressureSlice) -> Int { self.size }

pub fn NetflowbackpressureSlice::get(self : NetflowbackpressureSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbackpressureSlice::set(self : NetflowbackpressureSlice, i : Int, v : Double) -> NetflowbackpressureSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureSlice::sum(self : NetflowbackpressureSlice) -> Double { @_common.sum(self.data) }

pub fn NetflowbackpressureSlice::mean(self : NetflowbackpressureSlice) -> Double { @_common.mean(self.data) }

pub fn NetflowbackpressureSlice::scale(self : NetflowbackpressureSlice, f : Double) -> NetflowbackpressureSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureSlice::add(self : NetflowbackpressureSlice, other : NetflowbackpressureSlice) -> NetflowbackpressureSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbackpressureSlice::copy(self : NetflowbackpressureSlice) -> NetflowbackpressureSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureSlice::fill(self : NetflowbackpressureSlice, v : Double) -> NetflowbackpressureSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbackpressureSlice::min(self : NetflowbackpressureSlice) -> Double { @_common.min(self.data) }

pub fn NetflowbackpressureSlice::max(self : NetflowbackpressureSlice) -> Double { @_common.max(self.data) }

pub fn NetflowbackpressureSlice::to_string(self : NetflowbackpressureSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

