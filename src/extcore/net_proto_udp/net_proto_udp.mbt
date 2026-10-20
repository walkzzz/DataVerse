///===
/// extcore/net_proto_udp

pub(all) struct NetprotoudpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_udp_make_point(x : Double, y : Double) -> NetprotoudpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_udp_make_point3(x : Double, y : Double, z : Double) -> NetprotoudpPoint {
  { x, y, z, label: 0 }
}

pub fn NetprotoudpPoint::x(self : NetprotoudpPoint) -> Double { self.x }

pub fn NetprotoudpPoint::y(self : NetprotoudpPoint) -> Double { self.y }

pub fn NetprotoudpPoint::z(self : NetprotoudpPoint) -> Double { self.z }

pub fn NetprotoudpPoint::label(self : NetprotoudpPoint) -> Int { self.label }

pub fn NetprotoudpPoint::dist(self : NetprotoudpPoint, other : NetprotoudpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetprotoudpPoint::add(self : NetprotoudpPoint, other : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetprotoudpPoint::sub(self : NetprotoudpPoint, other : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetprotoudpPoint::scale(self : NetprotoudpPoint, s : Double) -> NetprotoudpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetprotoudpPoint::dot(self : NetprotoudpPoint, other : NetprotoudpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetprotoudpPoint::cross(self : NetprotoudpPoint, other : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetprotoudpPoint::norm(self : NetprotoudpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetprotoudpPoint::normalize(self : NetprotoudpPoint) -> NetprotoudpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotoudpPoint::negate(self : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetprotoudpPoint::mid(self : NetprotoudpPoint, other : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetprotoudpPoint::lerp(self : NetprotoudpPoint, other : NetprotoudpPoint, t : Double) -> NetprotoudpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetprotoudpPoint::to_string(self : NetprotoudpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetprotoudpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_udp_make_series(vals : Array[Double], name : String) -> NetprotoudpSeries {
  { vals, name, meta: 0 }
}

pub fn NetprotoudpSeries::len(self : NetprotoudpSeries) -> Int { self.vals.length() }

pub fn NetprotoudpSeries::sum(self : NetprotoudpSeries) -> Double { @_common.sum(self.vals) }

pub fn NetprotoudpSeries::mean(self : NetprotoudpSeries) -> Double { @_common.mean(self.vals) }

pub fn NetprotoudpSeries::min(self : NetprotoudpSeries) -> Double { @_common.min(self.vals) }

pub fn NetprotoudpSeries::max(self : NetprotoudpSeries) -> Double { @_common.max(self.vals) }

pub fn NetprotoudpSeries::range(self : NetprotoudpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetprotoudpSeries::variance(self : NetprotoudpSeries) -> Double { @_common.variance(self.vals) }

pub fn NetprotoudpSeries::std(self : NetprotoudpSeries) -> Double { @_common.std(self.vals) }

pub fn NetprotoudpSeries::median(self : NetprotoudpSeries) -> Double { @_common.median(self.vals) }

pub fn NetprotoudpSeries::scale(self : NetprotoudpSeries, f : Double) -> NetprotoudpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetprotoudpSeries::add(self : NetprotoudpSeries, other : NetprotoudpSeries) -> NetprotoudpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetprotoudpSeries::sub(self : NetprotoudpSeries, other : NetprotoudpSeries) -> NetprotoudpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetprotoudpSeries::normalize(self : NetprotoudpSeries) -> NetprotoudpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetprotoudpSeries::cumsum(self : NetprotoudpSeries) -> NetprotoudpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetprotoudpSeries::to_string(self : NetprotoudpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotoudpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_udp_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotoudpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_udp_matrix_identity(n : Int) -> NetprotoudpMatrix {
  let m = net_proto_udp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetprotoudpMatrix::get(self : NetprotoudpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetprotoudpMatrix::transpose(self : NetprotoudpMatrix) -> NetprotoudpMatrix {
  let result = net_proto_udp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetprotoudpMatrix::add(self : NetprotoudpMatrix, other : NetprotoudpMatrix) -> NetprotoudpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_udp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetprotoudpMatrix::scale(self : NetprotoudpMatrix, s : Double) -> NetprotoudpMatrix {
  let result = net_proto_udp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetprotoudpMatrix::multiply(self : NetprotoudpMatrix, other : NetprotoudpMatrix) -> NetprotoudpMatrix {
  if self.cols != other.rows { return net_proto_udp_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_udp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetprotoudpMatrix::trace(self : NetprotoudpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetprotoudpMatrix::det(self : NetprotoudpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetprotoudpMatrix::norm(self : NetprotoudpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetprotoudpMatrix::to_string(self : NetprotoudpMatrix) -> String {
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

pub(all) struct NetprotoudpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_udp_make_vector(comps : Array[Double]) -> NetprotoudpVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_udp_vector_zero(dim : Int) -> NetprotoudpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetprotoudpVector::add(self : NetprotoudpVector, other : NetprotoudpVector) -> NetprotoudpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotoudpVector::sub(self : NetprotoudpVector, other : NetprotoudpVector) -> NetprotoudpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotoudpVector::scale(self : NetprotoudpVector, s : Double) -> NetprotoudpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetprotoudpVector::dot(self : NetprotoudpVector, other : NetprotoudpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetprotoudpVector::norm(self : NetprotoudpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetprotoudpVector::normalize(self : NetprotoudpVector) -> NetprotoudpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotoudpVector::dist(self : NetprotoudpVector, other : NetprotoudpVector) -> Double {
  self.sub(other).norm()
}

pub fn NetprotoudpVector::to_string(self : NetprotoudpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotoudpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_frame_make(size : Int) -> NetprotoudpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpFrame::len(self : NetprotoudpFrame) -> Int { self.size }

pub fn NetprotoudpFrame::get(self : NetprotoudpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpFrame::set(self : NetprotoudpFrame, i : Int, v : Double) -> NetprotoudpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpFrame::sum(self : NetprotoudpFrame) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpFrame::mean(self : NetprotoudpFrame) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpFrame::scale(self : NetprotoudpFrame, f : Double) -> NetprotoudpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpFrame::add(self : NetprotoudpFrame, other : NetprotoudpFrame) -> NetprotoudpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpFrame::copy(self : NetprotoudpFrame) -> NetprotoudpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpFrame::fill(self : NetprotoudpFrame, v : Double) -> NetprotoudpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpFrame::min(self : NetprotoudpFrame) -> Double { @_common.min(self.data) }

pub fn NetprotoudpFrame::max(self : NetprotoudpFrame) -> Double { @_common.max(self.data) }

pub fn NetprotoudpFrame::to_string(self : NetprotoudpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_table_make(size : Int) -> NetprotoudpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpTable::len(self : NetprotoudpTable) -> Int { self.size }

pub fn NetprotoudpTable::get(self : NetprotoudpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpTable::set(self : NetprotoudpTable, i : Int, v : Double) -> NetprotoudpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpTable::sum(self : NetprotoudpTable) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpTable::mean(self : NetprotoudpTable) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpTable::scale(self : NetprotoudpTable, f : Double) -> NetprotoudpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpTable::add(self : NetprotoudpTable, other : NetprotoudpTable) -> NetprotoudpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpTable::copy(self : NetprotoudpTable) -> NetprotoudpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpTable::fill(self : NetprotoudpTable, v : Double) -> NetprotoudpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpTable::min(self : NetprotoudpTable) -> Double { @_common.min(self.data) }

pub fn NetprotoudpTable::max(self : NetprotoudpTable) -> Double { @_common.max(self.data) }

pub fn NetprotoudpTable::to_string(self : NetprotoudpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_graphn_make(size : Int) -> NetprotoudpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpGraphN::len(self : NetprotoudpGraphN) -> Int { self.size }

pub fn NetprotoudpGraphN::get(self : NetprotoudpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpGraphN::set(self : NetprotoudpGraphN, i : Int, v : Double) -> NetprotoudpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpGraphN::sum(self : NetprotoudpGraphN) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpGraphN::mean(self : NetprotoudpGraphN) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpGraphN::scale(self : NetprotoudpGraphN, f : Double) -> NetprotoudpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpGraphN::add(self : NetprotoudpGraphN, other : NetprotoudpGraphN) -> NetprotoudpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpGraphN::copy(self : NetprotoudpGraphN) -> NetprotoudpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpGraphN::fill(self : NetprotoudpGraphN, v : Double) -> NetprotoudpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpGraphN::min(self : NetprotoudpGraphN) -> Double { @_common.min(self.data) }

pub fn NetprotoudpGraphN::max(self : NetprotoudpGraphN) -> Double { @_common.max(self.data) }

pub fn NetprotoudpGraphN::to_string(self : NetprotoudpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_node_make(size : Int) -> NetprotoudpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpNode::len(self : NetprotoudpNode) -> Int { self.size }

pub fn NetprotoudpNode::get(self : NetprotoudpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpNode::set(self : NetprotoudpNode, i : Int, v : Double) -> NetprotoudpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpNode::sum(self : NetprotoudpNode) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpNode::mean(self : NetprotoudpNode) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpNode::scale(self : NetprotoudpNode, f : Double) -> NetprotoudpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpNode::add(self : NetprotoudpNode, other : NetprotoudpNode) -> NetprotoudpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpNode::copy(self : NetprotoudpNode) -> NetprotoudpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpNode::fill(self : NetprotoudpNode, v : Double) -> NetprotoudpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpNode::min(self : NetprotoudpNode) -> Double { @_common.min(self.data) }

pub fn NetprotoudpNode::max(self : NetprotoudpNode) -> Double { @_common.max(self.data) }

pub fn NetprotoudpNode::to_string(self : NetprotoudpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_edge_make(size : Int) -> NetprotoudpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpEdge::len(self : NetprotoudpEdge) -> Int { self.size }

pub fn NetprotoudpEdge::get(self : NetprotoudpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpEdge::set(self : NetprotoudpEdge, i : Int, v : Double) -> NetprotoudpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpEdge::sum(self : NetprotoudpEdge) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpEdge::mean(self : NetprotoudpEdge) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpEdge::scale(self : NetprotoudpEdge, f : Double) -> NetprotoudpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpEdge::add(self : NetprotoudpEdge, other : NetprotoudpEdge) -> NetprotoudpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpEdge::copy(self : NetprotoudpEdge) -> NetprotoudpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpEdge::fill(self : NetprotoudpEdge, v : Double) -> NetprotoudpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpEdge::min(self : NetprotoudpEdge) -> Double { @_common.min(self.data) }

pub fn NetprotoudpEdge::max(self : NetprotoudpEdge) -> Double { @_common.max(self.data) }

pub fn NetprotoudpEdge::to_string(self : NetprotoudpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_path_make(size : Int) -> NetprotoudpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpPath::len(self : NetprotoudpPath) -> Int { self.size }

pub fn NetprotoudpPath::get(self : NetprotoudpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpPath::set(self : NetprotoudpPath, i : Int, v : Double) -> NetprotoudpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpPath::sum(self : NetprotoudpPath) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpPath::mean(self : NetprotoudpPath) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpPath::scale(self : NetprotoudpPath, f : Double) -> NetprotoudpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpPath::add(self : NetprotoudpPath, other : NetprotoudpPath) -> NetprotoudpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpPath::copy(self : NetprotoudpPath) -> NetprotoudpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpPath::fill(self : NetprotoudpPath, v : Double) -> NetprotoudpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpPath::min(self : NetprotoudpPath) -> Double { @_common.min(self.data) }

pub fn NetprotoudpPath::max(self : NetprotoudpPath) -> Double { @_common.max(self.data) }

pub fn NetprotoudpPath::to_string(self : NetprotoudpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_cluster_make(size : Int) -> NetprotoudpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpCluster::len(self : NetprotoudpCluster) -> Int { self.size }

pub fn NetprotoudpCluster::get(self : NetprotoudpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpCluster::set(self : NetprotoudpCluster, i : Int, v : Double) -> NetprotoudpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpCluster::sum(self : NetprotoudpCluster) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpCluster::mean(self : NetprotoudpCluster) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpCluster::scale(self : NetprotoudpCluster, f : Double) -> NetprotoudpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpCluster::add(self : NetprotoudpCluster, other : NetprotoudpCluster) -> NetprotoudpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpCluster::copy(self : NetprotoudpCluster) -> NetprotoudpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpCluster::fill(self : NetprotoudpCluster, v : Double) -> NetprotoudpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpCluster::min(self : NetprotoudpCluster) -> Double { @_common.min(self.data) }

pub fn NetprotoudpCluster::max(self : NetprotoudpCluster) -> Double { @_common.max(self.data) }

pub fn NetprotoudpCluster::to_string(self : NetprotoudpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_model_make(size : Int) -> NetprotoudpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpModel::len(self : NetprotoudpModel) -> Int { self.size }

pub fn NetprotoudpModel::get(self : NetprotoudpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpModel::set(self : NetprotoudpModel, i : Int, v : Double) -> NetprotoudpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpModel::sum(self : NetprotoudpModel) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpModel::mean(self : NetprotoudpModel) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpModel::scale(self : NetprotoudpModel, f : Double) -> NetprotoudpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpModel::add(self : NetprotoudpModel, other : NetprotoudpModel) -> NetprotoudpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpModel::copy(self : NetprotoudpModel) -> NetprotoudpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpModel::fill(self : NetprotoudpModel, v : Double) -> NetprotoudpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpModel::min(self : NetprotoudpModel) -> Double { @_common.min(self.data) }

pub fn NetprotoudpModel::max(self : NetprotoudpModel) -> Double { @_common.max(self.data) }

pub fn NetprotoudpModel::to_string(self : NetprotoudpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_layer_make(size : Int) -> NetprotoudpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpLayer::len(self : NetprotoudpLayer) -> Int { self.size }

pub fn NetprotoudpLayer::get(self : NetprotoudpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpLayer::set(self : NetprotoudpLayer, i : Int, v : Double) -> NetprotoudpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpLayer::sum(self : NetprotoudpLayer) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpLayer::mean(self : NetprotoudpLayer) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpLayer::scale(self : NetprotoudpLayer, f : Double) -> NetprotoudpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpLayer::add(self : NetprotoudpLayer, other : NetprotoudpLayer) -> NetprotoudpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpLayer::copy(self : NetprotoudpLayer) -> NetprotoudpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpLayer::fill(self : NetprotoudpLayer, v : Double) -> NetprotoudpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpLayer::min(self : NetprotoudpLayer) -> Double { @_common.min(self.data) }

pub fn NetprotoudpLayer::max(self : NetprotoudpLayer) -> Double { @_common.max(self.data) }

pub fn NetprotoudpLayer::to_string(self : NetprotoudpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_buffer_make(size : Int) -> NetprotoudpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpBuffer::len(self : NetprotoudpBuffer) -> Int { self.size }

pub fn NetprotoudpBuffer::get(self : NetprotoudpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpBuffer::set(self : NetprotoudpBuffer, i : Int, v : Double) -> NetprotoudpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpBuffer::sum(self : NetprotoudpBuffer) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpBuffer::mean(self : NetprotoudpBuffer) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpBuffer::scale(self : NetprotoudpBuffer, f : Double) -> NetprotoudpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpBuffer::add(self : NetprotoudpBuffer, other : NetprotoudpBuffer) -> NetprotoudpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpBuffer::copy(self : NetprotoudpBuffer) -> NetprotoudpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpBuffer::fill(self : NetprotoudpBuffer, v : Double) -> NetprotoudpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpBuffer::min(self : NetprotoudpBuffer) -> Double { @_common.min(self.data) }

pub fn NetprotoudpBuffer::max(self : NetprotoudpBuffer) -> Double { @_common.max(self.data) }

pub fn NetprotoudpBuffer::to_string(self : NetprotoudpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_cursor_make(size : Int) -> NetprotoudpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpCursor::len(self : NetprotoudpCursor) -> Int { self.size }

pub fn NetprotoudpCursor::get(self : NetprotoudpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpCursor::set(self : NetprotoudpCursor, i : Int, v : Double) -> NetprotoudpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpCursor::sum(self : NetprotoudpCursor) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpCursor::mean(self : NetprotoudpCursor) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpCursor::scale(self : NetprotoudpCursor, f : Double) -> NetprotoudpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpCursor::add(self : NetprotoudpCursor, other : NetprotoudpCursor) -> NetprotoudpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpCursor::copy(self : NetprotoudpCursor) -> NetprotoudpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpCursor::fill(self : NetprotoudpCursor, v : Double) -> NetprotoudpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpCursor::min(self : NetprotoudpCursor) -> Double { @_common.min(self.data) }

pub fn NetprotoudpCursor::max(self : NetprotoudpCursor) -> Double { @_common.max(self.data) }

pub fn NetprotoudpCursor::to_string(self : NetprotoudpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_view_make(size : Int) -> NetprotoudpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpView::len(self : NetprotoudpView) -> Int { self.size }

pub fn NetprotoudpView::get(self : NetprotoudpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpView::set(self : NetprotoudpView, i : Int, v : Double) -> NetprotoudpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpView::sum(self : NetprotoudpView) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpView::mean(self : NetprotoudpView) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpView::scale(self : NetprotoudpView, f : Double) -> NetprotoudpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpView::add(self : NetprotoudpView, other : NetprotoudpView) -> NetprotoudpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpView::copy(self : NetprotoudpView) -> NetprotoudpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpView::fill(self : NetprotoudpView, v : Double) -> NetprotoudpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpView::min(self : NetprotoudpView) -> Double { @_common.min(self.data) }

pub fn NetprotoudpView::max(self : NetprotoudpView) -> Double { @_common.max(self.data) }

pub fn NetprotoudpView::to_string(self : NetprotoudpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_range_make(size : Int) -> NetprotoudpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpRange::len(self : NetprotoudpRange) -> Int { self.size }

pub fn NetprotoudpRange::get(self : NetprotoudpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpRange::set(self : NetprotoudpRange, i : Int, v : Double) -> NetprotoudpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpRange::sum(self : NetprotoudpRange) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpRange::mean(self : NetprotoudpRange) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpRange::scale(self : NetprotoudpRange, f : Double) -> NetprotoudpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpRange::add(self : NetprotoudpRange, other : NetprotoudpRange) -> NetprotoudpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpRange::copy(self : NetprotoudpRange) -> NetprotoudpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpRange::fill(self : NetprotoudpRange, v : Double) -> NetprotoudpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpRange::min(self : NetprotoudpRange) -> Double { @_common.min(self.data) }

pub fn NetprotoudpRange::max(self : NetprotoudpRange) -> Double { @_common.max(self.data) }

pub fn NetprotoudpRange::to_string(self : NetprotoudpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoudpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_slice_make(size : Int) -> NetprotoudpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoudpSlice::len(self : NetprotoudpSlice) -> Int { self.size }

pub fn NetprotoudpSlice::get(self : NetprotoudpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoudpSlice::set(self : NetprotoudpSlice, i : Int, v : Double) -> NetprotoudpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoudpSlice::sum(self : NetprotoudpSlice) -> Double { @_common.sum(self.data) }

pub fn NetprotoudpSlice::mean(self : NetprotoudpSlice) -> Double { @_common.mean(self.data) }

pub fn NetprotoudpSlice::scale(self : NetprotoudpSlice, f : Double) -> NetprotoudpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoudpSlice::add(self : NetprotoudpSlice, other : NetprotoudpSlice) -> NetprotoudpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoudpSlice::copy(self : NetprotoudpSlice) -> NetprotoudpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoudpSlice::fill(self : NetprotoudpSlice, v : Double) -> NetprotoudpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoudpSlice::min(self : NetprotoudpSlice) -> Double { @_common.min(self.data) }

pub fn NetprotoudpSlice::max(self : NetprotoudpSlice) -> Double { @_common.max(self.data) }

pub fn NetprotoudpSlice::to_string(self : NetprotoudpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

