///===
/// extcore/net_route_eigrp

pub(all) struct NetrouteeigrpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_eigrp_make_point(x : Double, y : Double) -> NetrouteeigrpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_eigrp_make_point3(x : Double, y : Double, z : Double) -> NetrouteeigrpPoint {
  { x, y, z, label: 0 }
}

pub fn NetrouteeigrpPoint::x(self : NetrouteeigrpPoint) -> Double { self.x }

pub fn NetrouteeigrpPoint::y(self : NetrouteeigrpPoint) -> Double { self.y }

pub fn NetrouteeigrpPoint::z(self : NetrouteeigrpPoint) -> Double { self.z }

pub fn NetrouteeigrpPoint::label(self : NetrouteeigrpPoint) -> Int { self.label }

pub fn NetrouteeigrpPoint::dist(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetrouteeigrpPoint::add(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetrouteeigrpPoint::sub(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetrouteeigrpPoint::scale(self : NetrouteeigrpPoint, s : Double) -> NetrouteeigrpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetrouteeigrpPoint::dot(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetrouteeigrpPoint::cross(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetrouteeigrpPoint::norm(self : NetrouteeigrpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetrouteeigrpPoint::normalize(self : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteeigrpPoint::negate(self : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetrouteeigrpPoint::mid(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetrouteeigrpPoint::lerp(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint, t : Double) -> NetrouteeigrpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetrouteeigrpPoint::to_string(self : NetrouteeigrpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetrouteeigrpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_eigrp_make_series(vals : Array[Double], name : String) -> NetrouteeigrpSeries {
  { vals, name, meta: 0 }
}

pub fn NetrouteeigrpSeries::len(self : NetrouteeigrpSeries) -> Int { self.vals.length() }

pub fn NetrouteeigrpSeries::sum(self : NetrouteeigrpSeries) -> Double { @_common.sum(self.vals) }

pub fn NetrouteeigrpSeries::mean(self : NetrouteeigrpSeries) -> Double { @_common.mean(self.vals) }

pub fn NetrouteeigrpSeries::min(self : NetrouteeigrpSeries) -> Double { @_common.min(self.vals) }

pub fn NetrouteeigrpSeries::max(self : NetrouteeigrpSeries) -> Double { @_common.max(self.vals) }

pub fn NetrouteeigrpSeries::range(self : NetrouteeigrpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetrouteeigrpSeries::variance(self : NetrouteeigrpSeries) -> Double { @_common.variance(self.vals) }

pub fn NetrouteeigrpSeries::std(self : NetrouteeigrpSeries) -> Double { @_common.std(self.vals) }

pub fn NetrouteeigrpSeries::median(self : NetrouteeigrpSeries) -> Double { @_common.median(self.vals) }

pub fn NetrouteeigrpSeries::scale(self : NetrouteeigrpSeries, f : Double) -> NetrouteeigrpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetrouteeigrpSeries::add(self : NetrouteeigrpSeries, other : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetrouteeigrpSeries::sub(self : NetrouteeigrpSeries, other : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetrouteeigrpSeries::normalize(self : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetrouteeigrpSeries::cumsum(self : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetrouteeigrpSeries::to_string(self : NetrouteeigrpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteeigrpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_eigrp_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteeigrpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_eigrp_matrix_identity(n : Int) -> NetrouteeigrpMatrix {
  let m = net_route_eigrp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetrouteeigrpMatrix::get(self : NetrouteeigrpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetrouteeigrpMatrix::transpose(self : NetrouteeigrpMatrix) -> NetrouteeigrpMatrix {
  let result = net_route_eigrp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetrouteeigrpMatrix::add(self : NetrouteeigrpMatrix, other : NetrouteeigrpMatrix) -> NetrouteeigrpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_eigrp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetrouteeigrpMatrix::scale(self : NetrouteeigrpMatrix, s : Double) -> NetrouteeigrpMatrix {
  let result = net_route_eigrp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetrouteeigrpMatrix::multiply(self : NetrouteeigrpMatrix, other : NetrouteeigrpMatrix) -> NetrouteeigrpMatrix {
  if self.cols != other.rows { return net_route_eigrp_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_eigrp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetrouteeigrpMatrix::trace(self : NetrouteeigrpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetrouteeigrpMatrix::det(self : NetrouteeigrpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetrouteeigrpMatrix::norm(self : NetrouteeigrpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetrouteeigrpMatrix::to_string(self : NetrouteeigrpMatrix) -> String {
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

pub(all) struct NetrouteeigrpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_eigrp_make_vector(comps : Array[Double]) -> NetrouteeigrpVector {
  { comps, dim: comps.length() }
}

pub fn net_route_eigrp_vector_zero(dim : Int) -> NetrouteeigrpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetrouteeigrpVector::add(self : NetrouteeigrpVector, other : NetrouteeigrpVector) -> NetrouteeigrpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteeigrpVector::sub(self : NetrouteeigrpVector, other : NetrouteeigrpVector) -> NetrouteeigrpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteeigrpVector::scale(self : NetrouteeigrpVector, s : Double) -> NetrouteeigrpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetrouteeigrpVector::dot(self : NetrouteeigrpVector, other : NetrouteeigrpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetrouteeigrpVector::norm(self : NetrouteeigrpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetrouteeigrpVector::normalize(self : NetrouteeigrpVector) -> NetrouteeigrpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteeigrpVector::dist(self : NetrouteeigrpVector, other : NetrouteeigrpVector) -> Double {
  self.sub(other).norm()
}

pub fn NetrouteeigrpVector::to_string(self : NetrouteeigrpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteeigrpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_frame_make(size : Int) -> NetrouteeigrpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpFrame::len(self : NetrouteeigrpFrame) -> Int { self.size }

pub fn NetrouteeigrpFrame::get(self : NetrouteeigrpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpFrame::set(self : NetrouteeigrpFrame, i : Int, v : Double) -> NetrouteeigrpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpFrame::sum(self : NetrouteeigrpFrame) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpFrame::mean(self : NetrouteeigrpFrame) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpFrame::scale(self : NetrouteeigrpFrame, f : Double) -> NetrouteeigrpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpFrame::add(self : NetrouteeigrpFrame, other : NetrouteeigrpFrame) -> NetrouteeigrpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpFrame::copy(self : NetrouteeigrpFrame) -> NetrouteeigrpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpFrame::fill(self : NetrouteeigrpFrame, v : Double) -> NetrouteeigrpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpFrame::min(self : NetrouteeigrpFrame) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpFrame::max(self : NetrouteeigrpFrame) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpFrame::to_string(self : NetrouteeigrpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_table_make(size : Int) -> NetrouteeigrpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpTable::len(self : NetrouteeigrpTable) -> Int { self.size }

pub fn NetrouteeigrpTable::get(self : NetrouteeigrpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpTable::set(self : NetrouteeigrpTable, i : Int, v : Double) -> NetrouteeigrpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpTable::sum(self : NetrouteeigrpTable) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpTable::mean(self : NetrouteeigrpTable) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpTable::scale(self : NetrouteeigrpTable, f : Double) -> NetrouteeigrpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpTable::add(self : NetrouteeigrpTable, other : NetrouteeigrpTable) -> NetrouteeigrpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpTable::copy(self : NetrouteeigrpTable) -> NetrouteeigrpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpTable::fill(self : NetrouteeigrpTable, v : Double) -> NetrouteeigrpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpTable::min(self : NetrouteeigrpTable) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpTable::max(self : NetrouteeigrpTable) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpTable::to_string(self : NetrouteeigrpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_graphn_make(size : Int) -> NetrouteeigrpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpGraphN::len(self : NetrouteeigrpGraphN) -> Int { self.size }

pub fn NetrouteeigrpGraphN::get(self : NetrouteeigrpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpGraphN::set(self : NetrouteeigrpGraphN, i : Int, v : Double) -> NetrouteeigrpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpGraphN::sum(self : NetrouteeigrpGraphN) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpGraphN::mean(self : NetrouteeigrpGraphN) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpGraphN::scale(self : NetrouteeigrpGraphN, f : Double) -> NetrouteeigrpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpGraphN::add(self : NetrouteeigrpGraphN, other : NetrouteeigrpGraphN) -> NetrouteeigrpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpGraphN::copy(self : NetrouteeigrpGraphN) -> NetrouteeigrpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpGraphN::fill(self : NetrouteeigrpGraphN, v : Double) -> NetrouteeigrpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpGraphN::min(self : NetrouteeigrpGraphN) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpGraphN::max(self : NetrouteeigrpGraphN) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpGraphN::to_string(self : NetrouteeigrpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_node_make(size : Int) -> NetrouteeigrpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpNode::len(self : NetrouteeigrpNode) -> Int { self.size }

pub fn NetrouteeigrpNode::get(self : NetrouteeigrpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpNode::set(self : NetrouteeigrpNode, i : Int, v : Double) -> NetrouteeigrpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpNode::sum(self : NetrouteeigrpNode) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpNode::mean(self : NetrouteeigrpNode) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpNode::scale(self : NetrouteeigrpNode, f : Double) -> NetrouteeigrpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpNode::add(self : NetrouteeigrpNode, other : NetrouteeigrpNode) -> NetrouteeigrpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpNode::copy(self : NetrouteeigrpNode) -> NetrouteeigrpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpNode::fill(self : NetrouteeigrpNode, v : Double) -> NetrouteeigrpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpNode::min(self : NetrouteeigrpNode) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpNode::max(self : NetrouteeigrpNode) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpNode::to_string(self : NetrouteeigrpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_edge_make(size : Int) -> NetrouteeigrpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpEdge::len(self : NetrouteeigrpEdge) -> Int { self.size }

pub fn NetrouteeigrpEdge::get(self : NetrouteeigrpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpEdge::set(self : NetrouteeigrpEdge, i : Int, v : Double) -> NetrouteeigrpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpEdge::sum(self : NetrouteeigrpEdge) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpEdge::mean(self : NetrouteeigrpEdge) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpEdge::scale(self : NetrouteeigrpEdge, f : Double) -> NetrouteeigrpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpEdge::add(self : NetrouteeigrpEdge, other : NetrouteeigrpEdge) -> NetrouteeigrpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpEdge::copy(self : NetrouteeigrpEdge) -> NetrouteeigrpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpEdge::fill(self : NetrouteeigrpEdge, v : Double) -> NetrouteeigrpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpEdge::min(self : NetrouteeigrpEdge) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpEdge::max(self : NetrouteeigrpEdge) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpEdge::to_string(self : NetrouteeigrpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_path_make(size : Int) -> NetrouteeigrpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpPath::len(self : NetrouteeigrpPath) -> Int { self.size }

pub fn NetrouteeigrpPath::get(self : NetrouteeigrpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpPath::set(self : NetrouteeigrpPath, i : Int, v : Double) -> NetrouteeigrpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpPath::sum(self : NetrouteeigrpPath) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpPath::mean(self : NetrouteeigrpPath) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpPath::scale(self : NetrouteeigrpPath, f : Double) -> NetrouteeigrpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpPath::add(self : NetrouteeigrpPath, other : NetrouteeigrpPath) -> NetrouteeigrpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpPath::copy(self : NetrouteeigrpPath) -> NetrouteeigrpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpPath::fill(self : NetrouteeigrpPath, v : Double) -> NetrouteeigrpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpPath::min(self : NetrouteeigrpPath) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpPath::max(self : NetrouteeigrpPath) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpPath::to_string(self : NetrouteeigrpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_cluster_make(size : Int) -> NetrouteeigrpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpCluster::len(self : NetrouteeigrpCluster) -> Int { self.size }

pub fn NetrouteeigrpCluster::get(self : NetrouteeigrpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpCluster::set(self : NetrouteeigrpCluster, i : Int, v : Double) -> NetrouteeigrpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpCluster::sum(self : NetrouteeigrpCluster) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpCluster::mean(self : NetrouteeigrpCluster) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpCluster::scale(self : NetrouteeigrpCluster, f : Double) -> NetrouteeigrpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpCluster::add(self : NetrouteeigrpCluster, other : NetrouteeigrpCluster) -> NetrouteeigrpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpCluster::copy(self : NetrouteeigrpCluster) -> NetrouteeigrpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpCluster::fill(self : NetrouteeigrpCluster, v : Double) -> NetrouteeigrpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpCluster::min(self : NetrouteeigrpCluster) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpCluster::max(self : NetrouteeigrpCluster) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpCluster::to_string(self : NetrouteeigrpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_model_make(size : Int) -> NetrouteeigrpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpModel::len(self : NetrouteeigrpModel) -> Int { self.size }

pub fn NetrouteeigrpModel::get(self : NetrouteeigrpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpModel::set(self : NetrouteeigrpModel, i : Int, v : Double) -> NetrouteeigrpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpModel::sum(self : NetrouteeigrpModel) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpModel::mean(self : NetrouteeigrpModel) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpModel::scale(self : NetrouteeigrpModel, f : Double) -> NetrouteeigrpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpModel::add(self : NetrouteeigrpModel, other : NetrouteeigrpModel) -> NetrouteeigrpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpModel::copy(self : NetrouteeigrpModel) -> NetrouteeigrpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpModel::fill(self : NetrouteeigrpModel, v : Double) -> NetrouteeigrpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpModel::min(self : NetrouteeigrpModel) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpModel::max(self : NetrouteeigrpModel) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpModel::to_string(self : NetrouteeigrpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_layer_make(size : Int) -> NetrouteeigrpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpLayer::len(self : NetrouteeigrpLayer) -> Int { self.size }

pub fn NetrouteeigrpLayer::get(self : NetrouteeigrpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpLayer::set(self : NetrouteeigrpLayer, i : Int, v : Double) -> NetrouteeigrpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpLayer::sum(self : NetrouteeigrpLayer) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpLayer::mean(self : NetrouteeigrpLayer) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpLayer::scale(self : NetrouteeigrpLayer, f : Double) -> NetrouteeigrpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpLayer::add(self : NetrouteeigrpLayer, other : NetrouteeigrpLayer) -> NetrouteeigrpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpLayer::copy(self : NetrouteeigrpLayer) -> NetrouteeigrpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpLayer::fill(self : NetrouteeigrpLayer, v : Double) -> NetrouteeigrpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpLayer::min(self : NetrouteeigrpLayer) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpLayer::max(self : NetrouteeigrpLayer) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpLayer::to_string(self : NetrouteeigrpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_buffer_make(size : Int) -> NetrouteeigrpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpBuffer::len(self : NetrouteeigrpBuffer) -> Int { self.size }

pub fn NetrouteeigrpBuffer::get(self : NetrouteeigrpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpBuffer::set(self : NetrouteeigrpBuffer, i : Int, v : Double) -> NetrouteeigrpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpBuffer::sum(self : NetrouteeigrpBuffer) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpBuffer::mean(self : NetrouteeigrpBuffer) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpBuffer::scale(self : NetrouteeigrpBuffer, f : Double) -> NetrouteeigrpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpBuffer::add(self : NetrouteeigrpBuffer, other : NetrouteeigrpBuffer) -> NetrouteeigrpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpBuffer::copy(self : NetrouteeigrpBuffer) -> NetrouteeigrpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpBuffer::fill(self : NetrouteeigrpBuffer, v : Double) -> NetrouteeigrpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpBuffer::min(self : NetrouteeigrpBuffer) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpBuffer::max(self : NetrouteeigrpBuffer) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpBuffer::to_string(self : NetrouteeigrpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_cursor_make(size : Int) -> NetrouteeigrpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpCursor::len(self : NetrouteeigrpCursor) -> Int { self.size }

pub fn NetrouteeigrpCursor::get(self : NetrouteeigrpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpCursor::set(self : NetrouteeigrpCursor, i : Int, v : Double) -> NetrouteeigrpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpCursor::sum(self : NetrouteeigrpCursor) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpCursor::mean(self : NetrouteeigrpCursor) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpCursor::scale(self : NetrouteeigrpCursor, f : Double) -> NetrouteeigrpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpCursor::add(self : NetrouteeigrpCursor, other : NetrouteeigrpCursor) -> NetrouteeigrpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpCursor::copy(self : NetrouteeigrpCursor) -> NetrouteeigrpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpCursor::fill(self : NetrouteeigrpCursor, v : Double) -> NetrouteeigrpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpCursor::min(self : NetrouteeigrpCursor) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpCursor::max(self : NetrouteeigrpCursor) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpCursor::to_string(self : NetrouteeigrpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_view_make(size : Int) -> NetrouteeigrpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpView::len(self : NetrouteeigrpView) -> Int { self.size }

pub fn NetrouteeigrpView::get(self : NetrouteeigrpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpView::set(self : NetrouteeigrpView, i : Int, v : Double) -> NetrouteeigrpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpView::sum(self : NetrouteeigrpView) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpView::mean(self : NetrouteeigrpView) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpView::scale(self : NetrouteeigrpView, f : Double) -> NetrouteeigrpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpView::add(self : NetrouteeigrpView, other : NetrouteeigrpView) -> NetrouteeigrpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpView::copy(self : NetrouteeigrpView) -> NetrouteeigrpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpView::fill(self : NetrouteeigrpView, v : Double) -> NetrouteeigrpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpView::min(self : NetrouteeigrpView) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpView::max(self : NetrouteeigrpView) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpView::to_string(self : NetrouteeigrpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_range_make(size : Int) -> NetrouteeigrpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpRange::len(self : NetrouteeigrpRange) -> Int { self.size }

pub fn NetrouteeigrpRange::get(self : NetrouteeigrpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpRange::set(self : NetrouteeigrpRange, i : Int, v : Double) -> NetrouteeigrpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpRange::sum(self : NetrouteeigrpRange) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpRange::mean(self : NetrouteeigrpRange) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpRange::scale(self : NetrouteeigrpRange, f : Double) -> NetrouteeigrpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpRange::add(self : NetrouteeigrpRange, other : NetrouteeigrpRange) -> NetrouteeigrpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpRange::copy(self : NetrouteeigrpRange) -> NetrouteeigrpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpRange::fill(self : NetrouteeigrpRange, v : Double) -> NetrouteeigrpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpRange::min(self : NetrouteeigrpRange) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpRange::max(self : NetrouteeigrpRange) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpRange::to_string(self : NetrouteeigrpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_slice_make(size : Int) -> NetrouteeigrpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteeigrpSlice::len(self : NetrouteeigrpSlice) -> Int { self.size }

pub fn NetrouteeigrpSlice::get(self : NetrouteeigrpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteeigrpSlice::set(self : NetrouteeigrpSlice, i : Int, v : Double) -> NetrouteeigrpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpSlice::sum(self : NetrouteeigrpSlice) -> Double { @_common.sum(self.data) }

pub fn NetrouteeigrpSlice::mean(self : NetrouteeigrpSlice) -> Double { @_common.mean(self.data) }

pub fn NetrouteeigrpSlice::scale(self : NetrouteeigrpSlice, f : Double) -> NetrouteeigrpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpSlice::add(self : NetrouteeigrpSlice, other : NetrouteeigrpSlice) -> NetrouteeigrpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteeigrpSlice::copy(self : NetrouteeigrpSlice) -> NetrouteeigrpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpSlice::fill(self : NetrouteeigrpSlice, v : Double) -> NetrouteeigrpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteeigrpSlice::min(self : NetrouteeigrpSlice) -> Double { @_common.min(self.data) }

pub fn NetrouteeigrpSlice::max(self : NetrouteeigrpSlice) -> Double { @_common.max(self.data) }

pub fn NetrouteeigrpSlice::to_string(self : NetrouteeigrpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

