///===
/// extcore/net_proto_tcp

pub(all) struct NetprototcpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_tcp_make_point(x : Double, y : Double) -> NetprototcpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_tcp_make_point3(x : Double, y : Double, z : Double) -> NetprototcpPoint {
  { x, y, z, label: 0 }
}

pub fn NetprototcpPoint::x(self : NetprototcpPoint) -> Double { self.x }

pub fn NetprototcpPoint::y(self : NetprototcpPoint) -> Double { self.y }

pub fn NetprototcpPoint::z(self : NetprototcpPoint) -> Double { self.z }

pub fn NetprototcpPoint::label(self : NetprototcpPoint) -> Int { self.label }

pub fn NetprototcpPoint::dist(self : NetprototcpPoint, other : NetprototcpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetprototcpPoint::add(self : NetprototcpPoint, other : NetprototcpPoint) -> NetprototcpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetprototcpPoint::sub(self : NetprototcpPoint, other : NetprototcpPoint) -> NetprototcpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetprototcpPoint::scale(self : NetprototcpPoint, s : Double) -> NetprototcpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetprototcpPoint::dot(self : NetprototcpPoint, other : NetprototcpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetprototcpPoint::cross(self : NetprototcpPoint, other : NetprototcpPoint) -> NetprototcpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetprototcpPoint::norm(self : NetprototcpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetprototcpPoint::normalize(self : NetprototcpPoint) -> NetprototcpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprototcpPoint::negate(self : NetprototcpPoint) -> NetprototcpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetprototcpPoint::mid(self : NetprototcpPoint, other : NetprototcpPoint) -> NetprototcpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetprototcpPoint::lerp(self : NetprototcpPoint, other : NetprototcpPoint, t : Double) -> NetprototcpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetprototcpPoint::to_string(self : NetprototcpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetprototcpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_tcp_make_series(vals : Array[Double], name : String) -> NetprototcpSeries {
  { vals, name, meta: 0 }
}

pub fn NetprototcpSeries::len(self : NetprototcpSeries) -> Int { self.vals.length() }

pub fn NetprototcpSeries::sum(self : NetprototcpSeries) -> Double { @_common.sum(self.vals) }

pub fn NetprototcpSeries::mean(self : NetprototcpSeries) -> Double { @_common.mean(self.vals) }

pub fn NetprototcpSeries::min(self : NetprototcpSeries) -> Double { @_common.min(self.vals) }

pub fn NetprototcpSeries::max(self : NetprototcpSeries) -> Double { @_common.max(self.vals) }

pub fn NetprototcpSeries::range(self : NetprototcpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetprototcpSeries::variance(self : NetprototcpSeries) -> Double { @_common.variance(self.vals) }

pub fn NetprototcpSeries::std(self : NetprototcpSeries) -> Double { @_common.std(self.vals) }

pub fn NetprototcpSeries::median(self : NetprototcpSeries) -> Double { @_common.median(self.vals) }

pub fn NetprototcpSeries::scale(self : NetprototcpSeries, f : Double) -> NetprototcpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetprototcpSeries::add(self : NetprototcpSeries, other : NetprototcpSeries) -> NetprototcpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetprototcpSeries::sub(self : NetprototcpSeries, other : NetprototcpSeries) -> NetprototcpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetprototcpSeries::normalize(self : NetprototcpSeries) -> NetprototcpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetprototcpSeries::cumsum(self : NetprototcpSeries) -> NetprototcpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetprototcpSeries::to_string(self : NetprototcpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprototcpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_tcp_make_matrix(rows : Int, cols : Int, val : Double) -> NetprototcpMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn net_proto_tcp_matrix_identity(n : Int) -> NetprototcpMatrix {
  let m = net_proto_tcp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetprototcpMatrix::get(self : NetprototcpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetprototcpMatrix::transpose(self : NetprototcpMatrix) -> NetprototcpMatrix {
  let result = net_proto_tcp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetprototcpMatrix::add(self : NetprototcpMatrix, other : NetprototcpMatrix) -> NetprototcpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_tcp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetprototcpMatrix::scale(self : NetprototcpMatrix, s : Double) -> NetprototcpMatrix {
  let result = net_proto_tcp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetprototcpMatrix::multiply(self : NetprototcpMatrix, other : NetprototcpMatrix) -> NetprototcpMatrix {
  if self.cols != other.rows { return net_proto_tcp_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_tcp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetprototcpMatrix::trace(self : NetprototcpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetprototcpMatrix::det(self : NetprototcpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetprototcpMatrix::norm(self : NetprototcpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetprototcpMatrix::to_string(self : NetprototcpMatrix) -> String {
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

pub(all) struct NetprototcpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_tcp_make_vector(comps : Array[Double]) -> NetprototcpVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_tcp_vector_zero(dim : Int) -> NetprototcpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetprototcpVector::add(self : NetprototcpVector, other : NetprototcpVector) -> NetprototcpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetprototcpVector::sub(self : NetprototcpVector, other : NetprototcpVector) -> NetprototcpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetprototcpVector::scale(self : NetprototcpVector, s : Double) -> NetprototcpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetprototcpVector::dot(self : NetprototcpVector, other : NetprototcpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetprototcpVector::norm(self : NetprototcpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetprototcpVector::normalize(self : NetprototcpVector) -> NetprototcpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprototcpVector::dist(self : NetprototcpVector, other : NetprototcpVector) -> Double {
  self.sub(other).norm()
}

pub fn NetprototcpVector::to_string(self : NetprototcpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprototcpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_frame_make(size : Int) -> NetprototcpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpFrame::len(self : NetprototcpFrame) -> Int { self.size }

pub fn NetprototcpFrame::get(self : NetprototcpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpFrame::set(self : NetprototcpFrame, i : Int, v : Double) -> NetprototcpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpFrame::sum(self : NetprototcpFrame) -> Double { @_common.sum(self.data) }

pub fn NetprototcpFrame::mean(self : NetprototcpFrame) -> Double { @_common.mean(self.data) }

pub fn NetprototcpFrame::scale(self : NetprototcpFrame, f : Double) -> NetprototcpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpFrame::add(self : NetprototcpFrame, other : NetprototcpFrame) -> NetprototcpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpFrame::copy(self : NetprototcpFrame) -> NetprototcpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpFrame::fill(self : NetprototcpFrame, v : Double) -> NetprototcpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpFrame::min(self : NetprototcpFrame) -> Double { @_common.min(self.data) }

pub fn NetprototcpFrame::max(self : NetprototcpFrame) -> Double { @_common.max(self.data) }

pub fn NetprototcpFrame::to_string(self : NetprototcpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_table_make(size : Int) -> NetprototcpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpTable::len(self : NetprototcpTable) -> Int { self.size }

pub fn NetprototcpTable::get(self : NetprototcpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpTable::set(self : NetprototcpTable, i : Int, v : Double) -> NetprototcpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpTable::sum(self : NetprototcpTable) -> Double { @_common.sum(self.data) }

pub fn NetprototcpTable::mean(self : NetprototcpTable) -> Double { @_common.mean(self.data) }

pub fn NetprototcpTable::scale(self : NetprototcpTable, f : Double) -> NetprototcpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpTable::add(self : NetprototcpTable, other : NetprototcpTable) -> NetprototcpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpTable::copy(self : NetprototcpTable) -> NetprototcpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpTable::fill(self : NetprototcpTable, v : Double) -> NetprototcpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpTable::min(self : NetprototcpTable) -> Double { @_common.min(self.data) }

pub fn NetprototcpTable::max(self : NetprototcpTable) -> Double { @_common.max(self.data) }

pub fn NetprototcpTable::to_string(self : NetprototcpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_graphn_make(size : Int) -> NetprototcpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpGraphN::len(self : NetprototcpGraphN) -> Int { self.size }

pub fn NetprototcpGraphN::get(self : NetprototcpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpGraphN::set(self : NetprototcpGraphN, i : Int, v : Double) -> NetprototcpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpGraphN::sum(self : NetprototcpGraphN) -> Double { @_common.sum(self.data) }

pub fn NetprototcpGraphN::mean(self : NetprototcpGraphN) -> Double { @_common.mean(self.data) }

pub fn NetprototcpGraphN::scale(self : NetprototcpGraphN, f : Double) -> NetprototcpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpGraphN::add(self : NetprototcpGraphN, other : NetprototcpGraphN) -> NetprototcpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpGraphN::copy(self : NetprototcpGraphN) -> NetprototcpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpGraphN::fill(self : NetprototcpGraphN, v : Double) -> NetprototcpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpGraphN::min(self : NetprototcpGraphN) -> Double { @_common.min(self.data) }

pub fn NetprototcpGraphN::max(self : NetprototcpGraphN) -> Double { @_common.max(self.data) }

pub fn NetprototcpGraphN::to_string(self : NetprototcpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_node_make(size : Int) -> NetprototcpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpNode::len(self : NetprototcpNode) -> Int { self.size }

pub fn NetprototcpNode::get(self : NetprototcpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpNode::set(self : NetprototcpNode, i : Int, v : Double) -> NetprototcpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpNode::sum(self : NetprototcpNode) -> Double { @_common.sum(self.data) }

pub fn NetprototcpNode::mean(self : NetprototcpNode) -> Double { @_common.mean(self.data) }

pub fn NetprototcpNode::scale(self : NetprototcpNode, f : Double) -> NetprototcpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpNode::add(self : NetprototcpNode, other : NetprototcpNode) -> NetprototcpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpNode::copy(self : NetprototcpNode) -> NetprototcpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpNode::fill(self : NetprototcpNode, v : Double) -> NetprototcpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpNode::min(self : NetprototcpNode) -> Double { @_common.min(self.data) }

pub fn NetprototcpNode::max(self : NetprototcpNode) -> Double { @_common.max(self.data) }

pub fn NetprototcpNode::to_string(self : NetprototcpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_edge_make(size : Int) -> NetprototcpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpEdge::len(self : NetprototcpEdge) -> Int { self.size }

pub fn NetprototcpEdge::get(self : NetprototcpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpEdge::set(self : NetprototcpEdge, i : Int, v : Double) -> NetprototcpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpEdge::sum(self : NetprototcpEdge) -> Double { @_common.sum(self.data) }

pub fn NetprototcpEdge::mean(self : NetprototcpEdge) -> Double { @_common.mean(self.data) }

pub fn NetprototcpEdge::scale(self : NetprototcpEdge, f : Double) -> NetprototcpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpEdge::add(self : NetprototcpEdge, other : NetprototcpEdge) -> NetprototcpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpEdge::copy(self : NetprototcpEdge) -> NetprototcpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpEdge::fill(self : NetprototcpEdge, v : Double) -> NetprototcpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpEdge::min(self : NetprototcpEdge) -> Double { @_common.min(self.data) }

pub fn NetprototcpEdge::max(self : NetprototcpEdge) -> Double { @_common.max(self.data) }

pub fn NetprototcpEdge::to_string(self : NetprototcpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_path_make(size : Int) -> NetprototcpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpPath::len(self : NetprototcpPath) -> Int { self.size }

pub fn NetprototcpPath::get(self : NetprototcpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpPath::set(self : NetprototcpPath, i : Int, v : Double) -> NetprototcpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpPath::sum(self : NetprototcpPath) -> Double { @_common.sum(self.data) }

pub fn NetprototcpPath::mean(self : NetprototcpPath) -> Double { @_common.mean(self.data) }

pub fn NetprototcpPath::scale(self : NetprototcpPath, f : Double) -> NetprototcpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpPath::add(self : NetprototcpPath, other : NetprototcpPath) -> NetprototcpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpPath::copy(self : NetprototcpPath) -> NetprototcpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpPath::fill(self : NetprototcpPath, v : Double) -> NetprototcpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpPath::min(self : NetprototcpPath) -> Double { @_common.min(self.data) }

pub fn NetprototcpPath::max(self : NetprototcpPath) -> Double { @_common.max(self.data) }

pub fn NetprototcpPath::to_string(self : NetprototcpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_cluster_make(size : Int) -> NetprototcpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpCluster::len(self : NetprototcpCluster) -> Int { self.size }

pub fn NetprototcpCluster::get(self : NetprototcpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpCluster::set(self : NetprototcpCluster, i : Int, v : Double) -> NetprototcpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpCluster::sum(self : NetprototcpCluster) -> Double { @_common.sum(self.data) }

pub fn NetprototcpCluster::mean(self : NetprototcpCluster) -> Double { @_common.mean(self.data) }

pub fn NetprototcpCluster::scale(self : NetprototcpCluster, f : Double) -> NetprototcpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpCluster::add(self : NetprototcpCluster, other : NetprototcpCluster) -> NetprototcpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpCluster::copy(self : NetprototcpCluster) -> NetprototcpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpCluster::fill(self : NetprototcpCluster, v : Double) -> NetprototcpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpCluster::min(self : NetprototcpCluster) -> Double { @_common.min(self.data) }

pub fn NetprototcpCluster::max(self : NetprototcpCluster) -> Double { @_common.max(self.data) }

pub fn NetprototcpCluster::to_string(self : NetprototcpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_model_make(size : Int) -> NetprototcpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpModel::len(self : NetprototcpModel) -> Int { self.size }

pub fn NetprototcpModel::get(self : NetprototcpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpModel::set(self : NetprototcpModel, i : Int, v : Double) -> NetprototcpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpModel::sum(self : NetprototcpModel) -> Double { @_common.sum(self.data) }

pub fn NetprototcpModel::mean(self : NetprototcpModel) -> Double { @_common.mean(self.data) }

pub fn NetprototcpModel::scale(self : NetprototcpModel, f : Double) -> NetprototcpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpModel::add(self : NetprototcpModel, other : NetprototcpModel) -> NetprototcpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpModel::copy(self : NetprototcpModel) -> NetprototcpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpModel::fill(self : NetprototcpModel, v : Double) -> NetprototcpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpModel::min(self : NetprototcpModel) -> Double { @_common.min(self.data) }

pub fn NetprototcpModel::max(self : NetprototcpModel) -> Double { @_common.max(self.data) }

pub fn NetprototcpModel::to_string(self : NetprototcpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_layer_make(size : Int) -> NetprototcpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpLayer::len(self : NetprototcpLayer) -> Int { self.size }

pub fn NetprototcpLayer::get(self : NetprototcpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpLayer::set(self : NetprototcpLayer, i : Int, v : Double) -> NetprototcpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpLayer::sum(self : NetprototcpLayer) -> Double { @_common.sum(self.data) }

pub fn NetprototcpLayer::mean(self : NetprototcpLayer) -> Double { @_common.mean(self.data) }

pub fn NetprototcpLayer::scale(self : NetprototcpLayer, f : Double) -> NetprototcpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpLayer::add(self : NetprototcpLayer, other : NetprototcpLayer) -> NetprototcpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpLayer::copy(self : NetprototcpLayer) -> NetprototcpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpLayer::fill(self : NetprototcpLayer, v : Double) -> NetprototcpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpLayer::min(self : NetprototcpLayer) -> Double { @_common.min(self.data) }

pub fn NetprototcpLayer::max(self : NetprototcpLayer) -> Double { @_common.max(self.data) }

pub fn NetprototcpLayer::to_string(self : NetprototcpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_buffer_make(size : Int) -> NetprototcpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpBuffer::len(self : NetprototcpBuffer) -> Int { self.size }

pub fn NetprototcpBuffer::get(self : NetprototcpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpBuffer::set(self : NetprototcpBuffer, i : Int, v : Double) -> NetprototcpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpBuffer::sum(self : NetprototcpBuffer) -> Double { @_common.sum(self.data) }

pub fn NetprototcpBuffer::mean(self : NetprototcpBuffer) -> Double { @_common.mean(self.data) }

pub fn NetprototcpBuffer::scale(self : NetprototcpBuffer, f : Double) -> NetprototcpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpBuffer::add(self : NetprototcpBuffer, other : NetprototcpBuffer) -> NetprototcpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpBuffer::copy(self : NetprototcpBuffer) -> NetprototcpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpBuffer::fill(self : NetprototcpBuffer, v : Double) -> NetprototcpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpBuffer::min(self : NetprototcpBuffer) -> Double { @_common.min(self.data) }

pub fn NetprototcpBuffer::max(self : NetprototcpBuffer) -> Double { @_common.max(self.data) }

pub fn NetprototcpBuffer::to_string(self : NetprototcpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_cursor_make(size : Int) -> NetprototcpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpCursor::len(self : NetprototcpCursor) -> Int { self.size }

pub fn NetprototcpCursor::get(self : NetprototcpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpCursor::set(self : NetprototcpCursor, i : Int, v : Double) -> NetprototcpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpCursor::sum(self : NetprototcpCursor) -> Double { @_common.sum(self.data) }

pub fn NetprototcpCursor::mean(self : NetprototcpCursor) -> Double { @_common.mean(self.data) }

pub fn NetprototcpCursor::scale(self : NetprototcpCursor, f : Double) -> NetprototcpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpCursor::add(self : NetprototcpCursor, other : NetprototcpCursor) -> NetprototcpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpCursor::copy(self : NetprototcpCursor) -> NetprototcpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpCursor::fill(self : NetprototcpCursor, v : Double) -> NetprototcpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpCursor::min(self : NetprototcpCursor) -> Double { @_common.min(self.data) }

pub fn NetprototcpCursor::max(self : NetprototcpCursor) -> Double { @_common.max(self.data) }

pub fn NetprototcpCursor::to_string(self : NetprototcpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_view_make(size : Int) -> NetprototcpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpView::len(self : NetprototcpView) -> Int { self.size }

pub fn NetprototcpView::get(self : NetprototcpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpView::set(self : NetprototcpView, i : Int, v : Double) -> NetprototcpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpView::sum(self : NetprototcpView) -> Double { @_common.sum(self.data) }

pub fn NetprototcpView::mean(self : NetprototcpView) -> Double { @_common.mean(self.data) }

pub fn NetprototcpView::scale(self : NetprototcpView, f : Double) -> NetprototcpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpView::add(self : NetprototcpView, other : NetprototcpView) -> NetprototcpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpView::copy(self : NetprototcpView) -> NetprototcpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpView::fill(self : NetprototcpView, v : Double) -> NetprototcpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpView::min(self : NetprototcpView) -> Double { @_common.min(self.data) }

pub fn NetprototcpView::max(self : NetprototcpView) -> Double { @_common.max(self.data) }

pub fn NetprototcpView::to_string(self : NetprototcpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_range_make(size : Int) -> NetprototcpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpRange::len(self : NetprototcpRange) -> Int { self.size }

pub fn NetprototcpRange::get(self : NetprototcpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpRange::set(self : NetprototcpRange, i : Int, v : Double) -> NetprototcpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpRange::sum(self : NetprototcpRange) -> Double { @_common.sum(self.data) }

pub fn NetprototcpRange::mean(self : NetprototcpRange) -> Double { @_common.mean(self.data) }

pub fn NetprototcpRange::scale(self : NetprototcpRange, f : Double) -> NetprototcpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpRange::add(self : NetprototcpRange, other : NetprototcpRange) -> NetprototcpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpRange::copy(self : NetprototcpRange) -> NetprototcpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpRange::fill(self : NetprototcpRange, v : Double) -> NetprototcpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpRange::min(self : NetprototcpRange) -> Double { @_common.min(self.data) }

pub fn NetprototcpRange::max(self : NetprototcpRange) -> Double { @_common.max(self.data) }

pub fn NetprototcpRange::to_string(self : NetprototcpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprototcpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_slice_make(size : Int) -> NetprototcpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprototcpSlice::len(self : NetprototcpSlice) -> Int { self.size }

pub fn NetprototcpSlice::get(self : NetprototcpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprototcpSlice::set(self : NetprototcpSlice, i : Int, v : Double) -> NetprototcpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprototcpSlice::sum(self : NetprototcpSlice) -> Double { @_common.sum(self.data) }

pub fn NetprototcpSlice::mean(self : NetprototcpSlice) -> Double { @_common.mean(self.data) }

pub fn NetprototcpSlice::scale(self : NetprototcpSlice, f : Double) -> NetprototcpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprototcpSlice::add(self : NetprototcpSlice, other : NetprototcpSlice) -> NetprototcpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprototcpSlice::copy(self : NetprototcpSlice) -> NetprototcpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprototcpSlice::fill(self : NetprototcpSlice, v : Double) -> NetprototcpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprototcpSlice::min(self : NetprototcpSlice) -> Double { @_common.min(self.data) }

pub fn NetprototcpSlice::max(self : NetprototcpSlice) -> Double { @_common.max(self.data) }

pub fn NetprototcpSlice::to_string(self : NetprototcpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

