///===
/// extcore/net_route_rip

pub(all) struct NetrouteripPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_rip_make_point(x : Double, y : Double) -> NetrouteripPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_rip_make_point3(x : Double, y : Double, z : Double) -> NetrouteripPoint {
  { x, y, z, label: 0 }
}

pub fn NetrouteripPoint::x(self : NetrouteripPoint) -> Double { self.x }

pub fn NetrouteripPoint::y(self : NetrouteripPoint) -> Double { self.y }

pub fn NetrouteripPoint::z(self : NetrouteripPoint) -> Double { self.z }

pub fn NetrouteripPoint::label(self : NetrouteripPoint) -> Int { self.label }

pub fn NetrouteripPoint::dist(self : NetrouteripPoint, other : NetrouteripPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetrouteripPoint::add(self : NetrouteripPoint, other : NetrouteripPoint) -> NetrouteripPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetrouteripPoint::sub(self : NetrouteripPoint, other : NetrouteripPoint) -> NetrouteripPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetrouteripPoint::scale(self : NetrouteripPoint, s : Double) -> NetrouteripPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetrouteripPoint::dot(self : NetrouteripPoint, other : NetrouteripPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetrouteripPoint::cross(self : NetrouteripPoint, other : NetrouteripPoint) -> NetrouteripPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetrouteripPoint::norm(self : NetrouteripPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetrouteripPoint::normalize(self : NetrouteripPoint) -> NetrouteripPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteripPoint::negate(self : NetrouteripPoint) -> NetrouteripPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetrouteripPoint::mid(self : NetrouteripPoint, other : NetrouteripPoint) -> NetrouteripPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetrouteripPoint::lerp(self : NetrouteripPoint, other : NetrouteripPoint, t : Double) -> NetrouteripPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetrouteripPoint::to_string(self : NetrouteripPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetrouteripSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_rip_make_series(vals : Array[Double], name : String) -> NetrouteripSeries {
  { vals, name, meta: 0 }
}

pub fn NetrouteripSeries::len(self : NetrouteripSeries) -> Int { self.vals.length() }

pub fn NetrouteripSeries::sum(self : NetrouteripSeries) -> Double { @_common.sum(self.vals) }

pub fn NetrouteripSeries::mean(self : NetrouteripSeries) -> Double { @_common.mean(self.vals) }

pub fn NetrouteripSeries::min(self : NetrouteripSeries) -> Double { @_common.min(self.vals) }

pub fn NetrouteripSeries::max(self : NetrouteripSeries) -> Double { @_common.max(self.vals) }

pub fn NetrouteripSeries::range(self : NetrouteripSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetrouteripSeries::variance(self : NetrouteripSeries) -> Double { @_common.variance(self.vals) }

pub fn NetrouteripSeries::std(self : NetrouteripSeries) -> Double { @_common.std(self.vals) }

pub fn NetrouteripSeries::median(self : NetrouteripSeries) -> Double { @_common.median(self.vals) }

pub fn NetrouteripSeries::scale(self : NetrouteripSeries, f : Double) -> NetrouteripSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetrouteripSeries::add(self : NetrouteripSeries, other : NetrouteripSeries) -> NetrouteripSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetrouteripSeries::sub(self : NetrouteripSeries, other : NetrouteripSeries) -> NetrouteripSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetrouteripSeries::normalize(self : NetrouteripSeries) -> NetrouteripSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetrouteripSeries::cumsum(self : NetrouteripSeries) -> NetrouteripSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetrouteripSeries::to_string(self : NetrouteripSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteripMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_rip_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteripMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_rip_matrix_identity(n : Int) -> NetrouteripMatrix {
  let m = net_route_rip_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetrouteripMatrix::get(self : NetrouteripMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetrouteripMatrix::transpose(self : NetrouteripMatrix) -> NetrouteripMatrix {
  let result = net_route_rip_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetrouteripMatrix::add(self : NetrouteripMatrix, other : NetrouteripMatrix) -> NetrouteripMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_rip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetrouteripMatrix::scale(self : NetrouteripMatrix, s : Double) -> NetrouteripMatrix {
  let result = net_route_rip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetrouteripMatrix::multiply(self : NetrouteripMatrix, other : NetrouteripMatrix) -> NetrouteripMatrix {
  if self.cols != other.rows { return net_route_rip_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_rip_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetrouteripMatrix::trace(self : NetrouteripMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetrouteripMatrix::det(self : NetrouteripMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetrouteripMatrix::norm(self : NetrouteripMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetrouteripMatrix::to_string(self : NetrouteripMatrix) -> String {
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

pub(all) struct NetrouteripVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_rip_make_vector(comps : Array[Double]) -> NetrouteripVector {
  { comps, dim: comps.length() }
}

pub fn net_route_rip_vector_zero(dim : Int) -> NetrouteripVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetrouteripVector::add(self : NetrouteripVector, other : NetrouteripVector) -> NetrouteripVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteripVector::sub(self : NetrouteripVector, other : NetrouteripVector) -> NetrouteripVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteripVector::scale(self : NetrouteripVector, s : Double) -> NetrouteripVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetrouteripVector::dot(self : NetrouteripVector, other : NetrouteripVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetrouteripVector::norm(self : NetrouteripVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetrouteripVector::normalize(self : NetrouteripVector) -> NetrouteripVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteripVector::dist(self : NetrouteripVector, other : NetrouteripVector) -> Double {
  self.sub(other).norm()
}

pub fn NetrouteripVector::to_string(self : NetrouteripVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteripFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_frame_make(size : Int) -> NetrouteripFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripFrame::len(self : NetrouteripFrame) -> Int { self.size }

pub fn NetrouteripFrame::get(self : NetrouteripFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripFrame::set(self : NetrouteripFrame, i : Int, v : Double) -> NetrouteripFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripFrame::sum(self : NetrouteripFrame) -> Double { @_common.sum(self.data) }

pub fn NetrouteripFrame::mean(self : NetrouteripFrame) -> Double { @_common.mean(self.data) }

pub fn NetrouteripFrame::scale(self : NetrouteripFrame, f : Double) -> NetrouteripFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripFrame::add(self : NetrouteripFrame, other : NetrouteripFrame) -> NetrouteripFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripFrame::copy(self : NetrouteripFrame) -> NetrouteripFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripFrame::fill(self : NetrouteripFrame, v : Double) -> NetrouteripFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripFrame::min(self : NetrouteripFrame) -> Double { @_common.min(self.data) }

pub fn NetrouteripFrame::max(self : NetrouteripFrame) -> Double { @_common.max(self.data) }

pub fn NetrouteripFrame::to_string(self : NetrouteripFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_table_make(size : Int) -> NetrouteripTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripTable::len(self : NetrouteripTable) -> Int { self.size }

pub fn NetrouteripTable::get(self : NetrouteripTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripTable::set(self : NetrouteripTable, i : Int, v : Double) -> NetrouteripTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripTable::sum(self : NetrouteripTable) -> Double { @_common.sum(self.data) }

pub fn NetrouteripTable::mean(self : NetrouteripTable) -> Double { @_common.mean(self.data) }

pub fn NetrouteripTable::scale(self : NetrouteripTable, f : Double) -> NetrouteripTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripTable::add(self : NetrouteripTable, other : NetrouteripTable) -> NetrouteripTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripTable::copy(self : NetrouteripTable) -> NetrouteripTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripTable::fill(self : NetrouteripTable, v : Double) -> NetrouteripTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripTable::min(self : NetrouteripTable) -> Double { @_common.min(self.data) }

pub fn NetrouteripTable::max(self : NetrouteripTable) -> Double { @_common.max(self.data) }

pub fn NetrouteripTable::to_string(self : NetrouteripTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_graphn_make(size : Int) -> NetrouteripGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripGraphN::len(self : NetrouteripGraphN) -> Int { self.size }

pub fn NetrouteripGraphN::get(self : NetrouteripGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripGraphN::set(self : NetrouteripGraphN, i : Int, v : Double) -> NetrouteripGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripGraphN::sum(self : NetrouteripGraphN) -> Double { @_common.sum(self.data) }

pub fn NetrouteripGraphN::mean(self : NetrouteripGraphN) -> Double { @_common.mean(self.data) }

pub fn NetrouteripGraphN::scale(self : NetrouteripGraphN, f : Double) -> NetrouteripGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripGraphN::add(self : NetrouteripGraphN, other : NetrouteripGraphN) -> NetrouteripGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripGraphN::copy(self : NetrouteripGraphN) -> NetrouteripGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripGraphN::fill(self : NetrouteripGraphN, v : Double) -> NetrouteripGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripGraphN::min(self : NetrouteripGraphN) -> Double { @_common.min(self.data) }

pub fn NetrouteripGraphN::max(self : NetrouteripGraphN) -> Double { @_common.max(self.data) }

pub fn NetrouteripGraphN::to_string(self : NetrouteripGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_node_make(size : Int) -> NetrouteripNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripNode::len(self : NetrouteripNode) -> Int { self.size }

pub fn NetrouteripNode::get(self : NetrouteripNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripNode::set(self : NetrouteripNode, i : Int, v : Double) -> NetrouteripNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripNode::sum(self : NetrouteripNode) -> Double { @_common.sum(self.data) }

pub fn NetrouteripNode::mean(self : NetrouteripNode) -> Double { @_common.mean(self.data) }

pub fn NetrouteripNode::scale(self : NetrouteripNode, f : Double) -> NetrouteripNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripNode::add(self : NetrouteripNode, other : NetrouteripNode) -> NetrouteripNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripNode::copy(self : NetrouteripNode) -> NetrouteripNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripNode::fill(self : NetrouteripNode, v : Double) -> NetrouteripNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripNode::min(self : NetrouteripNode) -> Double { @_common.min(self.data) }

pub fn NetrouteripNode::max(self : NetrouteripNode) -> Double { @_common.max(self.data) }

pub fn NetrouteripNode::to_string(self : NetrouteripNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_edge_make(size : Int) -> NetrouteripEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripEdge::len(self : NetrouteripEdge) -> Int { self.size }

pub fn NetrouteripEdge::get(self : NetrouteripEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripEdge::set(self : NetrouteripEdge, i : Int, v : Double) -> NetrouteripEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripEdge::sum(self : NetrouteripEdge) -> Double { @_common.sum(self.data) }

pub fn NetrouteripEdge::mean(self : NetrouteripEdge) -> Double { @_common.mean(self.data) }

pub fn NetrouteripEdge::scale(self : NetrouteripEdge, f : Double) -> NetrouteripEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripEdge::add(self : NetrouteripEdge, other : NetrouteripEdge) -> NetrouteripEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripEdge::copy(self : NetrouteripEdge) -> NetrouteripEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripEdge::fill(self : NetrouteripEdge, v : Double) -> NetrouteripEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripEdge::min(self : NetrouteripEdge) -> Double { @_common.min(self.data) }

pub fn NetrouteripEdge::max(self : NetrouteripEdge) -> Double { @_common.max(self.data) }

pub fn NetrouteripEdge::to_string(self : NetrouteripEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_path_make(size : Int) -> NetrouteripPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripPath::len(self : NetrouteripPath) -> Int { self.size }

pub fn NetrouteripPath::get(self : NetrouteripPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripPath::set(self : NetrouteripPath, i : Int, v : Double) -> NetrouteripPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripPath::sum(self : NetrouteripPath) -> Double { @_common.sum(self.data) }

pub fn NetrouteripPath::mean(self : NetrouteripPath) -> Double { @_common.mean(self.data) }

pub fn NetrouteripPath::scale(self : NetrouteripPath, f : Double) -> NetrouteripPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripPath::add(self : NetrouteripPath, other : NetrouteripPath) -> NetrouteripPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripPath::copy(self : NetrouteripPath) -> NetrouteripPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripPath::fill(self : NetrouteripPath, v : Double) -> NetrouteripPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripPath::min(self : NetrouteripPath) -> Double { @_common.min(self.data) }

pub fn NetrouteripPath::max(self : NetrouteripPath) -> Double { @_common.max(self.data) }

pub fn NetrouteripPath::to_string(self : NetrouteripPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_cluster_make(size : Int) -> NetrouteripCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripCluster::len(self : NetrouteripCluster) -> Int { self.size }

pub fn NetrouteripCluster::get(self : NetrouteripCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripCluster::set(self : NetrouteripCluster, i : Int, v : Double) -> NetrouteripCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripCluster::sum(self : NetrouteripCluster) -> Double { @_common.sum(self.data) }

pub fn NetrouteripCluster::mean(self : NetrouteripCluster) -> Double { @_common.mean(self.data) }

pub fn NetrouteripCluster::scale(self : NetrouteripCluster, f : Double) -> NetrouteripCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripCluster::add(self : NetrouteripCluster, other : NetrouteripCluster) -> NetrouteripCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripCluster::copy(self : NetrouteripCluster) -> NetrouteripCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripCluster::fill(self : NetrouteripCluster, v : Double) -> NetrouteripCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripCluster::min(self : NetrouteripCluster) -> Double { @_common.min(self.data) }

pub fn NetrouteripCluster::max(self : NetrouteripCluster) -> Double { @_common.max(self.data) }

pub fn NetrouteripCluster::to_string(self : NetrouteripCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_model_make(size : Int) -> NetrouteripModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripModel::len(self : NetrouteripModel) -> Int { self.size }

pub fn NetrouteripModel::get(self : NetrouteripModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripModel::set(self : NetrouteripModel, i : Int, v : Double) -> NetrouteripModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripModel::sum(self : NetrouteripModel) -> Double { @_common.sum(self.data) }

pub fn NetrouteripModel::mean(self : NetrouteripModel) -> Double { @_common.mean(self.data) }

pub fn NetrouteripModel::scale(self : NetrouteripModel, f : Double) -> NetrouteripModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripModel::add(self : NetrouteripModel, other : NetrouteripModel) -> NetrouteripModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripModel::copy(self : NetrouteripModel) -> NetrouteripModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripModel::fill(self : NetrouteripModel, v : Double) -> NetrouteripModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripModel::min(self : NetrouteripModel) -> Double { @_common.min(self.data) }

pub fn NetrouteripModel::max(self : NetrouteripModel) -> Double { @_common.max(self.data) }

pub fn NetrouteripModel::to_string(self : NetrouteripModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_layer_make(size : Int) -> NetrouteripLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripLayer::len(self : NetrouteripLayer) -> Int { self.size }

pub fn NetrouteripLayer::get(self : NetrouteripLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripLayer::set(self : NetrouteripLayer, i : Int, v : Double) -> NetrouteripLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripLayer::sum(self : NetrouteripLayer) -> Double { @_common.sum(self.data) }

pub fn NetrouteripLayer::mean(self : NetrouteripLayer) -> Double { @_common.mean(self.data) }

pub fn NetrouteripLayer::scale(self : NetrouteripLayer, f : Double) -> NetrouteripLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripLayer::add(self : NetrouteripLayer, other : NetrouteripLayer) -> NetrouteripLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripLayer::copy(self : NetrouteripLayer) -> NetrouteripLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripLayer::fill(self : NetrouteripLayer, v : Double) -> NetrouteripLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripLayer::min(self : NetrouteripLayer) -> Double { @_common.min(self.data) }

pub fn NetrouteripLayer::max(self : NetrouteripLayer) -> Double { @_common.max(self.data) }

pub fn NetrouteripLayer::to_string(self : NetrouteripLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_buffer_make(size : Int) -> NetrouteripBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripBuffer::len(self : NetrouteripBuffer) -> Int { self.size }

pub fn NetrouteripBuffer::get(self : NetrouteripBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripBuffer::set(self : NetrouteripBuffer, i : Int, v : Double) -> NetrouteripBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripBuffer::sum(self : NetrouteripBuffer) -> Double { @_common.sum(self.data) }

pub fn NetrouteripBuffer::mean(self : NetrouteripBuffer) -> Double { @_common.mean(self.data) }

pub fn NetrouteripBuffer::scale(self : NetrouteripBuffer, f : Double) -> NetrouteripBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripBuffer::add(self : NetrouteripBuffer, other : NetrouteripBuffer) -> NetrouteripBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripBuffer::copy(self : NetrouteripBuffer) -> NetrouteripBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripBuffer::fill(self : NetrouteripBuffer, v : Double) -> NetrouteripBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripBuffer::min(self : NetrouteripBuffer) -> Double { @_common.min(self.data) }

pub fn NetrouteripBuffer::max(self : NetrouteripBuffer) -> Double { @_common.max(self.data) }

pub fn NetrouteripBuffer::to_string(self : NetrouteripBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_cursor_make(size : Int) -> NetrouteripCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripCursor::len(self : NetrouteripCursor) -> Int { self.size }

pub fn NetrouteripCursor::get(self : NetrouteripCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripCursor::set(self : NetrouteripCursor, i : Int, v : Double) -> NetrouteripCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripCursor::sum(self : NetrouteripCursor) -> Double { @_common.sum(self.data) }

pub fn NetrouteripCursor::mean(self : NetrouteripCursor) -> Double { @_common.mean(self.data) }

pub fn NetrouteripCursor::scale(self : NetrouteripCursor, f : Double) -> NetrouteripCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripCursor::add(self : NetrouteripCursor, other : NetrouteripCursor) -> NetrouteripCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripCursor::copy(self : NetrouteripCursor) -> NetrouteripCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripCursor::fill(self : NetrouteripCursor, v : Double) -> NetrouteripCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripCursor::min(self : NetrouteripCursor) -> Double { @_common.min(self.data) }

pub fn NetrouteripCursor::max(self : NetrouteripCursor) -> Double { @_common.max(self.data) }

pub fn NetrouteripCursor::to_string(self : NetrouteripCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_view_make(size : Int) -> NetrouteripView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripView::len(self : NetrouteripView) -> Int { self.size }

pub fn NetrouteripView::get(self : NetrouteripView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripView::set(self : NetrouteripView, i : Int, v : Double) -> NetrouteripView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripView::sum(self : NetrouteripView) -> Double { @_common.sum(self.data) }

pub fn NetrouteripView::mean(self : NetrouteripView) -> Double { @_common.mean(self.data) }

pub fn NetrouteripView::scale(self : NetrouteripView, f : Double) -> NetrouteripView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripView::add(self : NetrouteripView, other : NetrouteripView) -> NetrouteripView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripView::copy(self : NetrouteripView) -> NetrouteripView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripView::fill(self : NetrouteripView, v : Double) -> NetrouteripView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripView::min(self : NetrouteripView) -> Double { @_common.min(self.data) }

pub fn NetrouteripView::max(self : NetrouteripView) -> Double { @_common.max(self.data) }

pub fn NetrouteripView::to_string(self : NetrouteripView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_range_make(size : Int) -> NetrouteripRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripRange::len(self : NetrouteripRange) -> Int { self.size }

pub fn NetrouteripRange::get(self : NetrouteripRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripRange::set(self : NetrouteripRange, i : Int, v : Double) -> NetrouteripRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripRange::sum(self : NetrouteripRange) -> Double { @_common.sum(self.data) }

pub fn NetrouteripRange::mean(self : NetrouteripRange) -> Double { @_common.mean(self.data) }

pub fn NetrouteripRange::scale(self : NetrouteripRange, f : Double) -> NetrouteripRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripRange::add(self : NetrouteripRange, other : NetrouteripRange) -> NetrouteripRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripRange::copy(self : NetrouteripRange) -> NetrouteripRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripRange::fill(self : NetrouteripRange, v : Double) -> NetrouteripRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripRange::min(self : NetrouteripRange) -> Double { @_common.min(self.data) }

pub fn NetrouteripRange::max(self : NetrouteripRange) -> Double { @_common.max(self.data) }

pub fn NetrouteripRange::to_string(self : NetrouteripRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteripSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_slice_make(size : Int) -> NetrouteripSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteripSlice::len(self : NetrouteripSlice) -> Int { self.size }

pub fn NetrouteripSlice::get(self : NetrouteripSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteripSlice::set(self : NetrouteripSlice, i : Int, v : Double) -> NetrouteripSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteripSlice::sum(self : NetrouteripSlice) -> Double { @_common.sum(self.data) }

pub fn NetrouteripSlice::mean(self : NetrouteripSlice) -> Double { @_common.mean(self.data) }

pub fn NetrouteripSlice::scale(self : NetrouteripSlice, f : Double) -> NetrouteripSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteripSlice::add(self : NetrouteripSlice, other : NetrouteripSlice) -> NetrouteripSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteripSlice::copy(self : NetrouteripSlice) -> NetrouteripSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteripSlice::fill(self : NetrouteripSlice, v : Double) -> NetrouteripSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteripSlice::min(self : NetrouteripSlice) -> Double { @_common.min(self.data) }

pub fn NetrouteripSlice::max(self : NetrouteripSlice) -> Double { @_common.max(self.data) }

pub fn NetrouteripSlice::to_string(self : NetrouteripSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

