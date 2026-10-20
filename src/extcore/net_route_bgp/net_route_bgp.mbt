///===
/// extcore/net_route_bgp

pub(all) struct NetroutebgpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_bgp_make_point(x : Double, y : Double) -> NetroutebgpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_bgp_make_point3(x : Double, y : Double, z : Double) -> NetroutebgpPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutebgpPoint::x(self : NetroutebgpPoint) -> Double { self.x }

pub fn NetroutebgpPoint::y(self : NetroutebgpPoint) -> Double { self.y }

pub fn NetroutebgpPoint::z(self : NetroutebgpPoint) -> Double { self.z }

pub fn NetroutebgpPoint::label(self : NetroutebgpPoint) -> Int { self.label }

pub fn NetroutebgpPoint::dist(self : NetroutebgpPoint, other : NetroutebgpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutebgpPoint::add(self : NetroutebgpPoint, other : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutebgpPoint::sub(self : NetroutebgpPoint, other : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutebgpPoint::scale(self : NetroutebgpPoint, s : Double) -> NetroutebgpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutebgpPoint::dot(self : NetroutebgpPoint, other : NetroutebgpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutebgpPoint::cross(self : NetroutebgpPoint, other : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutebgpPoint::norm(self : NetroutebgpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutebgpPoint::normalize(self : NetroutebgpPoint) -> NetroutebgpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutebgpPoint::negate(self : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutebgpPoint::mid(self : NetroutebgpPoint, other : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutebgpPoint::lerp(self : NetroutebgpPoint, other : NetroutebgpPoint, t : Double) -> NetroutebgpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutebgpPoint::to_string(self : NetroutebgpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutebgpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_bgp_make_series(vals : Array[Double], name : String) -> NetroutebgpSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutebgpSeries::len(self : NetroutebgpSeries) -> Int { self.vals.length() }

pub fn NetroutebgpSeries::sum(self : NetroutebgpSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutebgpSeries::mean(self : NetroutebgpSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutebgpSeries::min(self : NetroutebgpSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutebgpSeries::max(self : NetroutebgpSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutebgpSeries::range(self : NetroutebgpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutebgpSeries::variance(self : NetroutebgpSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutebgpSeries::std(self : NetroutebgpSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutebgpSeries::median(self : NetroutebgpSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutebgpSeries::scale(self : NetroutebgpSeries, f : Double) -> NetroutebgpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutebgpSeries::add(self : NetroutebgpSeries, other : NetroutebgpSeries) -> NetroutebgpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutebgpSeries::sub(self : NetroutebgpSeries, other : NetroutebgpSeries) -> NetroutebgpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutebgpSeries::normalize(self : NetroutebgpSeries) -> NetroutebgpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutebgpSeries::cumsum(self : NetroutebgpSeries) -> NetroutebgpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutebgpSeries::to_string(self : NetroutebgpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutebgpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_bgp_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutebgpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_bgp_matrix_identity(n : Int) -> NetroutebgpMatrix {
  let m = net_route_bgp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutebgpMatrix::get(self : NetroutebgpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutebgpMatrix::transpose(self : NetroutebgpMatrix) -> NetroutebgpMatrix {
  let result = net_route_bgp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutebgpMatrix::add(self : NetroutebgpMatrix, other : NetroutebgpMatrix) -> NetroutebgpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_bgp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutebgpMatrix::scale(self : NetroutebgpMatrix, s : Double) -> NetroutebgpMatrix {
  let result = net_route_bgp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutebgpMatrix::multiply(self : NetroutebgpMatrix, other : NetroutebgpMatrix) -> NetroutebgpMatrix {
  if self.cols != other.rows { return net_route_bgp_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_bgp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetroutebgpMatrix::trace(self : NetroutebgpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutebgpMatrix::det(self : NetroutebgpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutebgpMatrix::norm(self : NetroutebgpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutebgpMatrix::to_string(self : NetroutebgpMatrix) -> String {
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

pub(all) struct NetroutebgpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_bgp_make_vector(comps : Array[Double]) -> NetroutebgpVector {
  { comps, dim: comps.length() }
}

pub fn net_route_bgp_vector_zero(dim : Int) -> NetroutebgpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutebgpVector::add(self : NetroutebgpVector, other : NetroutebgpVector) -> NetroutebgpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutebgpVector::sub(self : NetroutebgpVector, other : NetroutebgpVector) -> NetroutebgpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutebgpVector::scale(self : NetroutebgpVector, s : Double) -> NetroutebgpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutebgpVector::dot(self : NetroutebgpVector, other : NetroutebgpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutebgpVector::norm(self : NetroutebgpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutebgpVector::normalize(self : NetroutebgpVector) -> NetroutebgpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutebgpVector::dist(self : NetroutebgpVector, other : NetroutebgpVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutebgpVector::to_string(self : NetroutebgpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutebgpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_frame_make(size : Int) -> NetroutebgpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpFrame::len(self : NetroutebgpFrame) -> Int { self.size }

pub fn NetroutebgpFrame::get(self : NetroutebgpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpFrame::set(self : NetroutebgpFrame, i : Int, v : Double) -> NetroutebgpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpFrame::sum(self : NetroutebgpFrame) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpFrame::mean(self : NetroutebgpFrame) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpFrame::scale(self : NetroutebgpFrame, f : Double) -> NetroutebgpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpFrame::add(self : NetroutebgpFrame, other : NetroutebgpFrame) -> NetroutebgpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpFrame::copy(self : NetroutebgpFrame) -> NetroutebgpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpFrame::fill(self : NetroutebgpFrame, v : Double) -> NetroutebgpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpFrame::min(self : NetroutebgpFrame) -> Double { @_common.min(self.data) }

pub fn NetroutebgpFrame::max(self : NetroutebgpFrame) -> Double { @_common.max(self.data) }

pub fn NetroutebgpFrame::to_string(self : NetroutebgpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_table_make(size : Int) -> NetroutebgpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpTable::len(self : NetroutebgpTable) -> Int { self.size }

pub fn NetroutebgpTable::get(self : NetroutebgpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpTable::set(self : NetroutebgpTable, i : Int, v : Double) -> NetroutebgpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpTable::sum(self : NetroutebgpTable) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpTable::mean(self : NetroutebgpTable) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpTable::scale(self : NetroutebgpTable, f : Double) -> NetroutebgpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpTable::add(self : NetroutebgpTable, other : NetroutebgpTable) -> NetroutebgpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpTable::copy(self : NetroutebgpTable) -> NetroutebgpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpTable::fill(self : NetroutebgpTable, v : Double) -> NetroutebgpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpTable::min(self : NetroutebgpTable) -> Double { @_common.min(self.data) }

pub fn NetroutebgpTable::max(self : NetroutebgpTable) -> Double { @_common.max(self.data) }

pub fn NetroutebgpTable::to_string(self : NetroutebgpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_graphn_make(size : Int) -> NetroutebgpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpGraphN::len(self : NetroutebgpGraphN) -> Int { self.size }

pub fn NetroutebgpGraphN::get(self : NetroutebgpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpGraphN::set(self : NetroutebgpGraphN, i : Int, v : Double) -> NetroutebgpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpGraphN::sum(self : NetroutebgpGraphN) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpGraphN::mean(self : NetroutebgpGraphN) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpGraphN::scale(self : NetroutebgpGraphN, f : Double) -> NetroutebgpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpGraphN::add(self : NetroutebgpGraphN, other : NetroutebgpGraphN) -> NetroutebgpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpGraphN::copy(self : NetroutebgpGraphN) -> NetroutebgpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpGraphN::fill(self : NetroutebgpGraphN, v : Double) -> NetroutebgpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpGraphN::min(self : NetroutebgpGraphN) -> Double { @_common.min(self.data) }

pub fn NetroutebgpGraphN::max(self : NetroutebgpGraphN) -> Double { @_common.max(self.data) }

pub fn NetroutebgpGraphN::to_string(self : NetroutebgpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_node_make(size : Int) -> NetroutebgpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpNode::len(self : NetroutebgpNode) -> Int { self.size }

pub fn NetroutebgpNode::get(self : NetroutebgpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpNode::set(self : NetroutebgpNode, i : Int, v : Double) -> NetroutebgpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpNode::sum(self : NetroutebgpNode) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpNode::mean(self : NetroutebgpNode) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpNode::scale(self : NetroutebgpNode, f : Double) -> NetroutebgpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpNode::add(self : NetroutebgpNode, other : NetroutebgpNode) -> NetroutebgpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpNode::copy(self : NetroutebgpNode) -> NetroutebgpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpNode::fill(self : NetroutebgpNode, v : Double) -> NetroutebgpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpNode::min(self : NetroutebgpNode) -> Double { @_common.min(self.data) }

pub fn NetroutebgpNode::max(self : NetroutebgpNode) -> Double { @_common.max(self.data) }

pub fn NetroutebgpNode::to_string(self : NetroutebgpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_edge_make(size : Int) -> NetroutebgpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpEdge::len(self : NetroutebgpEdge) -> Int { self.size }

pub fn NetroutebgpEdge::get(self : NetroutebgpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpEdge::set(self : NetroutebgpEdge, i : Int, v : Double) -> NetroutebgpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpEdge::sum(self : NetroutebgpEdge) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpEdge::mean(self : NetroutebgpEdge) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpEdge::scale(self : NetroutebgpEdge, f : Double) -> NetroutebgpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpEdge::add(self : NetroutebgpEdge, other : NetroutebgpEdge) -> NetroutebgpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpEdge::copy(self : NetroutebgpEdge) -> NetroutebgpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpEdge::fill(self : NetroutebgpEdge, v : Double) -> NetroutebgpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpEdge::min(self : NetroutebgpEdge) -> Double { @_common.min(self.data) }

pub fn NetroutebgpEdge::max(self : NetroutebgpEdge) -> Double { @_common.max(self.data) }

pub fn NetroutebgpEdge::to_string(self : NetroutebgpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_path_make(size : Int) -> NetroutebgpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpPath::len(self : NetroutebgpPath) -> Int { self.size }

pub fn NetroutebgpPath::get(self : NetroutebgpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpPath::set(self : NetroutebgpPath, i : Int, v : Double) -> NetroutebgpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpPath::sum(self : NetroutebgpPath) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpPath::mean(self : NetroutebgpPath) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpPath::scale(self : NetroutebgpPath, f : Double) -> NetroutebgpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpPath::add(self : NetroutebgpPath, other : NetroutebgpPath) -> NetroutebgpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpPath::copy(self : NetroutebgpPath) -> NetroutebgpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpPath::fill(self : NetroutebgpPath, v : Double) -> NetroutebgpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpPath::min(self : NetroutebgpPath) -> Double { @_common.min(self.data) }

pub fn NetroutebgpPath::max(self : NetroutebgpPath) -> Double { @_common.max(self.data) }

pub fn NetroutebgpPath::to_string(self : NetroutebgpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_cluster_make(size : Int) -> NetroutebgpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpCluster::len(self : NetroutebgpCluster) -> Int { self.size }

pub fn NetroutebgpCluster::get(self : NetroutebgpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpCluster::set(self : NetroutebgpCluster, i : Int, v : Double) -> NetroutebgpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpCluster::sum(self : NetroutebgpCluster) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpCluster::mean(self : NetroutebgpCluster) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpCluster::scale(self : NetroutebgpCluster, f : Double) -> NetroutebgpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpCluster::add(self : NetroutebgpCluster, other : NetroutebgpCluster) -> NetroutebgpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpCluster::copy(self : NetroutebgpCluster) -> NetroutebgpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpCluster::fill(self : NetroutebgpCluster, v : Double) -> NetroutebgpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpCluster::min(self : NetroutebgpCluster) -> Double { @_common.min(self.data) }

pub fn NetroutebgpCluster::max(self : NetroutebgpCluster) -> Double { @_common.max(self.data) }

pub fn NetroutebgpCluster::to_string(self : NetroutebgpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_model_make(size : Int) -> NetroutebgpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpModel::len(self : NetroutebgpModel) -> Int { self.size }

pub fn NetroutebgpModel::get(self : NetroutebgpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpModel::set(self : NetroutebgpModel, i : Int, v : Double) -> NetroutebgpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpModel::sum(self : NetroutebgpModel) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpModel::mean(self : NetroutebgpModel) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpModel::scale(self : NetroutebgpModel, f : Double) -> NetroutebgpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpModel::add(self : NetroutebgpModel, other : NetroutebgpModel) -> NetroutebgpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpModel::copy(self : NetroutebgpModel) -> NetroutebgpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpModel::fill(self : NetroutebgpModel, v : Double) -> NetroutebgpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpModel::min(self : NetroutebgpModel) -> Double { @_common.min(self.data) }

pub fn NetroutebgpModel::max(self : NetroutebgpModel) -> Double { @_common.max(self.data) }

pub fn NetroutebgpModel::to_string(self : NetroutebgpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_layer_make(size : Int) -> NetroutebgpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpLayer::len(self : NetroutebgpLayer) -> Int { self.size }

pub fn NetroutebgpLayer::get(self : NetroutebgpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpLayer::set(self : NetroutebgpLayer, i : Int, v : Double) -> NetroutebgpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpLayer::sum(self : NetroutebgpLayer) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpLayer::mean(self : NetroutebgpLayer) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpLayer::scale(self : NetroutebgpLayer, f : Double) -> NetroutebgpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpLayer::add(self : NetroutebgpLayer, other : NetroutebgpLayer) -> NetroutebgpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpLayer::copy(self : NetroutebgpLayer) -> NetroutebgpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpLayer::fill(self : NetroutebgpLayer, v : Double) -> NetroutebgpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpLayer::min(self : NetroutebgpLayer) -> Double { @_common.min(self.data) }

pub fn NetroutebgpLayer::max(self : NetroutebgpLayer) -> Double { @_common.max(self.data) }

pub fn NetroutebgpLayer::to_string(self : NetroutebgpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_buffer_make(size : Int) -> NetroutebgpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpBuffer::len(self : NetroutebgpBuffer) -> Int { self.size }

pub fn NetroutebgpBuffer::get(self : NetroutebgpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpBuffer::set(self : NetroutebgpBuffer, i : Int, v : Double) -> NetroutebgpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpBuffer::sum(self : NetroutebgpBuffer) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpBuffer::mean(self : NetroutebgpBuffer) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpBuffer::scale(self : NetroutebgpBuffer, f : Double) -> NetroutebgpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpBuffer::add(self : NetroutebgpBuffer, other : NetroutebgpBuffer) -> NetroutebgpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpBuffer::copy(self : NetroutebgpBuffer) -> NetroutebgpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpBuffer::fill(self : NetroutebgpBuffer, v : Double) -> NetroutebgpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpBuffer::min(self : NetroutebgpBuffer) -> Double { @_common.min(self.data) }

pub fn NetroutebgpBuffer::max(self : NetroutebgpBuffer) -> Double { @_common.max(self.data) }

pub fn NetroutebgpBuffer::to_string(self : NetroutebgpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_cursor_make(size : Int) -> NetroutebgpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpCursor::len(self : NetroutebgpCursor) -> Int { self.size }

pub fn NetroutebgpCursor::get(self : NetroutebgpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpCursor::set(self : NetroutebgpCursor, i : Int, v : Double) -> NetroutebgpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpCursor::sum(self : NetroutebgpCursor) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpCursor::mean(self : NetroutebgpCursor) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpCursor::scale(self : NetroutebgpCursor, f : Double) -> NetroutebgpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpCursor::add(self : NetroutebgpCursor, other : NetroutebgpCursor) -> NetroutebgpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpCursor::copy(self : NetroutebgpCursor) -> NetroutebgpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpCursor::fill(self : NetroutebgpCursor, v : Double) -> NetroutebgpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpCursor::min(self : NetroutebgpCursor) -> Double { @_common.min(self.data) }

pub fn NetroutebgpCursor::max(self : NetroutebgpCursor) -> Double { @_common.max(self.data) }

pub fn NetroutebgpCursor::to_string(self : NetroutebgpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_view_make(size : Int) -> NetroutebgpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpView::len(self : NetroutebgpView) -> Int { self.size }

pub fn NetroutebgpView::get(self : NetroutebgpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpView::set(self : NetroutebgpView, i : Int, v : Double) -> NetroutebgpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpView::sum(self : NetroutebgpView) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpView::mean(self : NetroutebgpView) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpView::scale(self : NetroutebgpView, f : Double) -> NetroutebgpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpView::add(self : NetroutebgpView, other : NetroutebgpView) -> NetroutebgpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpView::copy(self : NetroutebgpView) -> NetroutebgpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpView::fill(self : NetroutebgpView, v : Double) -> NetroutebgpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpView::min(self : NetroutebgpView) -> Double { @_common.min(self.data) }

pub fn NetroutebgpView::max(self : NetroutebgpView) -> Double { @_common.max(self.data) }

pub fn NetroutebgpView::to_string(self : NetroutebgpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_range_make(size : Int) -> NetroutebgpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpRange::len(self : NetroutebgpRange) -> Int { self.size }

pub fn NetroutebgpRange::get(self : NetroutebgpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpRange::set(self : NetroutebgpRange, i : Int, v : Double) -> NetroutebgpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpRange::sum(self : NetroutebgpRange) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpRange::mean(self : NetroutebgpRange) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpRange::scale(self : NetroutebgpRange, f : Double) -> NetroutebgpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpRange::add(self : NetroutebgpRange, other : NetroutebgpRange) -> NetroutebgpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpRange::copy(self : NetroutebgpRange) -> NetroutebgpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpRange::fill(self : NetroutebgpRange, v : Double) -> NetroutebgpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpRange::min(self : NetroutebgpRange) -> Double { @_common.min(self.data) }

pub fn NetroutebgpRange::max(self : NetroutebgpRange) -> Double { @_common.max(self.data) }

pub fn NetroutebgpRange::to_string(self : NetroutebgpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebgpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_slice_make(size : Int) -> NetroutebgpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebgpSlice::len(self : NetroutebgpSlice) -> Int { self.size }

pub fn NetroutebgpSlice::get(self : NetroutebgpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebgpSlice::set(self : NetroutebgpSlice, i : Int, v : Double) -> NetroutebgpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebgpSlice::sum(self : NetroutebgpSlice) -> Double { @_common.sum(self.data) }

pub fn NetroutebgpSlice::mean(self : NetroutebgpSlice) -> Double { @_common.mean(self.data) }

pub fn NetroutebgpSlice::scale(self : NetroutebgpSlice, f : Double) -> NetroutebgpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebgpSlice::add(self : NetroutebgpSlice, other : NetroutebgpSlice) -> NetroutebgpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebgpSlice::copy(self : NetroutebgpSlice) -> NetroutebgpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebgpSlice::fill(self : NetroutebgpSlice, v : Double) -> NetroutebgpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebgpSlice::min(self : NetroutebgpSlice) -> Double { @_common.min(self.data) }

pub fn NetroutebgpSlice::max(self : NetroutebgpSlice) -> Double { @_common.max(self.data) }

pub fn NetroutebgpSlice::to_string(self : NetroutebgpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

