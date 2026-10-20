///===
/// extcore/net_route_dijkstra

pub(all) struct NetroutedijkstraPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_dijkstra_make_point(x : Double, y : Double) -> NetroutedijkstraPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_dijkstra_make_point3(x : Double, y : Double, z : Double) -> NetroutedijkstraPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutedijkstraPoint::x(self : NetroutedijkstraPoint) -> Double { self.x }

pub fn NetroutedijkstraPoint::y(self : NetroutedijkstraPoint) -> Double { self.y }

pub fn NetroutedijkstraPoint::z(self : NetroutedijkstraPoint) -> Double { self.z }

pub fn NetroutedijkstraPoint::label(self : NetroutedijkstraPoint) -> Int { self.label }

pub fn NetroutedijkstraPoint::dist(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutedijkstraPoint::add(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutedijkstraPoint::sub(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutedijkstraPoint::scale(self : NetroutedijkstraPoint, s : Double) -> NetroutedijkstraPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutedijkstraPoint::dot(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutedijkstraPoint::cross(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutedijkstraPoint::norm(self : NetroutedijkstraPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutedijkstraPoint::normalize(self : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutedijkstraPoint::negate(self : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutedijkstraPoint::mid(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutedijkstraPoint::lerp(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint, t : Double) -> NetroutedijkstraPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutedijkstraPoint::to_string(self : NetroutedijkstraPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutedijkstraSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_dijkstra_make_series(vals : Array[Double], name : String) -> NetroutedijkstraSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutedijkstraSeries::len(self : NetroutedijkstraSeries) -> Int { self.vals.length() }

pub fn NetroutedijkstraSeries::sum(self : NetroutedijkstraSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutedijkstraSeries::mean(self : NetroutedijkstraSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutedijkstraSeries::min(self : NetroutedijkstraSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutedijkstraSeries::max(self : NetroutedijkstraSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutedijkstraSeries::range(self : NetroutedijkstraSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutedijkstraSeries::variance(self : NetroutedijkstraSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutedijkstraSeries::std(self : NetroutedijkstraSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutedijkstraSeries::median(self : NetroutedijkstraSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutedijkstraSeries::scale(self : NetroutedijkstraSeries, f : Double) -> NetroutedijkstraSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutedijkstraSeries::add(self : NetroutedijkstraSeries, other : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutedijkstraSeries::sub(self : NetroutedijkstraSeries, other : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutedijkstraSeries::normalize(self : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutedijkstraSeries::cumsum(self : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutedijkstraSeries::to_string(self : NetroutedijkstraSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutedijkstraMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_dijkstra_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutedijkstraMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_dijkstra_matrix_identity(n : Int) -> NetroutedijkstraMatrix {
  let m = net_route_dijkstra_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutedijkstraMatrix::get(self : NetroutedijkstraMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutedijkstraMatrix::transpose(self : NetroutedijkstraMatrix) -> NetroutedijkstraMatrix {
  let result = net_route_dijkstra_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutedijkstraMatrix::add(self : NetroutedijkstraMatrix, other : NetroutedijkstraMatrix) -> NetroutedijkstraMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_dijkstra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutedijkstraMatrix::scale(self : NetroutedijkstraMatrix, s : Double) -> NetroutedijkstraMatrix {
  let result = net_route_dijkstra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutedijkstraMatrix::multiply(self : NetroutedijkstraMatrix, other : NetroutedijkstraMatrix) -> NetroutedijkstraMatrix {
  if self.cols != other.rows { return net_route_dijkstra_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_dijkstra_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetroutedijkstraMatrix::trace(self : NetroutedijkstraMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutedijkstraMatrix::det(self : NetroutedijkstraMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutedijkstraMatrix::norm(self : NetroutedijkstraMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutedijkstraMatrix::to_string(self : NetroutedijkstraMatrix) -> String {
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

pub(all) struct NetroutedijkstraVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_dijkstra_make_vector(comps : Array[Double]) -> NetroutedijkstraVector {
  { comps, dim: comps.length() }
}

pub fn net_route_dijkstra_vector_zero(dim : Int) -> NetroutedijkstraVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutedijkstraVector::add(self : NetroutedijkstraVector, other : NetroutedijkstraVector) -> NetroutedijkstraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutedijkstraVector::sub(self : NetroutedijkstraVector, other : NetroutedijkstraVector) -> NetroutedijkstraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutedijkstraVector::scale(self : NetroutedijkstraVector, s : Double) -> NetroutedijkstraVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutedijkstraVector::dot(self : NetroutedijkstraVector, other : NetroutedijkstraVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutedijkstraVector::norm(self : NetroutedijkstraVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutedijkstraVector::normalize(self : NetroutedijkstraVector) -> NetroutedijkstraVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutedijkstraVector::dist(self : NetroutedijkstraVector, other : NetroutedijkstraVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutedijkstraVector::to_string(self : NetroutedijkstraVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutedijkstraFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_frame_make(size : Int) -> NetroutedijkstraFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraFrame::len(self : NetroutedijkstraFrame) -> Int { self.size }

pub fn NetroutedijkstraFrame::get(self : NetroutedijkstraFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraFrame::set(self : NetroutedijkstraFrame, i : Int, v : Double) -> NetroutedijkstraFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraFrame::sum(self : NetroutedijkstraFrame) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraFrame::mean(self : NetroutedijkstraFrame) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraFrame::scale(self : NetroutedijkstraFrame, f : Double) -> NetroutedijkstraFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraFrame::add(self : NetroutedijkstraFrame, other : NetroutedijkstraFrame) -> NetroutedijkstraFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraFrame::copy(self : NetroutedijkstraFrame) -> NetroutedijkstraFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraFrame::fill(self : NetroutedijkstraFrame, v : Double) -> NetroutedijkstraFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraFrame::min(self : NetroutedijkstraFrame) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraFrame::max(self : NetroutedijkstraFrame) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraFrame::to_string(self : NetroutedijkstraFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_table_make(size : Int) -> NetroutedijkstraTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraTable::len(self : NetroutedijkstraTable) -> Int { self.size }

pub fn NetroutedijkstraTable::get(self : NetroutedijkstraTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraTable::set(self : NetroutedijkstraTable, i : Int, v : Double) -> NetroutedijkstraTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraTable::sum(self : NetroutedijkstraTable) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraTable::mean(self : NetroutedijkstraTable) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraTable::scale(self : NetroutedijkstraTable, f : Double) -> NetroutedijkstraTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraTable::add(self : NetroutedijkstraTable, other : NetroutedijkstraTable) -> NetroutedijkstraTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraTable::copy(self : NetroutedijkstraTable) -> NetroutedijkstraTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraTable::fill(self : NetroutedijkstraTable, v : Double) -> NetroutedijkstraTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraTable::min(self : NetroutedijkstraTable) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraTable::max(self : NetroutedijkstraTable) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraTable::to_string(self : NetroutedijkstraTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_graphn_make(size : Int) -> NetroutedijkstraGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraGraphN::len(self : NetroutedijkstraGraphN) -> Int { self.size }

pub fn NetroutedijkstraGraphN::get(self : NetroutedijkstraGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraGraphN::set(self : NetroutedijkstraGraphN, i : Int, v : Double) -> NetroutedijkstraGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraGraphN::sum(self : NetroutedijkstraGraphN) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraGraphN::mean(self : NetroutedijkstraGraphN) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraGraphN::scale(self : NetroutedijkstraGraphN, f : Double) -> NetroutedijkstraGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraGraphN::add(self : NetroutedijkstraGraphN, other : NetroutedijkstraGraphN) -> NetroutedijkstraGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraGraphN::copy(self : NetroutedijkstraGraphN) -> NetroutedijkstraGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraGraphN::fill(self : NetroutedijkstraGraphN, v : Double) -> NetroutedijkstraGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraGraphN::min(self : NetroutedijkstraGraphN) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraGraphN::max(self : NetroutedijkstraGraphN) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraGraphN::to_string(self : NetroutedijkstraGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_node_make(size : Int) -> NetroutedijkstraNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraNode::len(self : NetroutedijkstraNode) -> Int { self.size }

pub fn NetroutedijkstraNode::get(self : NetroutedijkstraNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraNode::set(self : NetroutedijkstraNode, i : Int, v : Double) -> NetroutedijkstraNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraNode::sum(self : NetroutedijkstraNode) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraNode::mean(self : NetroutedijkstraNode) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraNode::scale(self : NetroutedijkstraNode, f : Double) -> NetroutedijkstraNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraNode::add(self : NetroutedijkstraNode, other : NetroutedijkstraNode) -> NetroutedijkstraNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraNode::copy(self : NetroutedijkstraNode) -> NetroutedijkstraNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraNode::fill(self : NetroutedijkstraNode, v : Double) -> NetroutedijkstraNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraNode::min(self : NetroutedijkstraNode) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraNode::max(self : NetroutedijkstraNode) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraNode::to_string(self : NetroutedijkstraNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_edge_make(size : Int) -> NetroutedijkstraEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraEdge::len(self : NetroutedijkstraEdge) -> Int { self.size }

pub fn NetroutedijkstraEdge::get(self : NetroutedijkstraEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraEdge::set(self : NetroutedijkstraEdge, i : Int, v : Double) -> NetroutedijkstraEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraEdge::sum(self : NetroutedijkstraEdge) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraEdge::mean(self : NetroutedijkstraEdge) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraEdge::scale(self : NetroutedijkstraEdge, f : Double) -> NetroutedijkstraEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraEdge::add(self : NetroutedijkstraEdge, other : NetroutedijkstraEdge) -> NetroutedijkstraEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraEdge::copy(self : NetroutedijkstraEdge) -> NetroutedijkstraEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraEdge::fill(self : NetroutedijkstraEdge, v : Double) -> NetroutedijkstraEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraEdge::min(self : NetroutedijkstraEdge) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraEdge::max(self : NetroutedijkstraEdge) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraEdge::to_string(self : NetroutedijkstraEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_path_make(size : Int) -> NetroutedijkstraPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraPath::len(self : NetroutedijkstraPath) -> Int { self.size }

pub fn NetroutedijkstraPath::get(self : NetroutedijkstraPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraPath::set(self : NetroutedijkstraPath, i : Int, v : Double) -> NetroutedijkstraPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraPath::sum(self : NetroutedijkstraPath) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraPath::mean(self : NetroutedijkstraPath) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraPath::scale(self : NetroutedijkstraPath, f : Double) -> NetroutedijkstraPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraPath::add(self : NetroutedijkstraPath, other : NetroutedijkstraPath) -> NetroutedijkstraPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraPath::copy(self : NetroutedijkstraPath) -> NetroutedijkstraPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraPath::fill(self : NetroutedijkstraPath, v : Double) -> NetroutedijkstraPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraPath::min(self : NetroutedijkstraPath) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraPath::max(self : NetroutedijkstraPath) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraPath::to_string(self : NetroutedijkstraPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_cluster_make(size : Int) -> NetroutedijkstraCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraCluster::len(self : NetroutedijkstraCluster) -> Int { self.size }

pub fn NetroutedijkstraCluster::get(self : NetroutedijkstraCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraCluster::set(self : NetroutedijkstraCluster, i : Int, v : Double) -> NetroutedijkstraCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraCluster::sum(self : NetroutedijkstraCluster) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraCluster::mean(self : NetroutedijkstraCluster) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraCluster::scale(self : NetroutedijkstraCluster, f : Double) -> NetroutedijkstraCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraCluster::add(self : NetroutedijkstraCluster, other : NetroutedijkstraCluster) -> NetroutedijkstraCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraCluster::copy(self : NetroutedijkstraCluster) -> NetroutedijkstraCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraCluster::fill(self : NetroutedijkstraCluster, v : Double) -> NetroutedijkstraCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraCluster::min(self : NetroutedijkstraCluster) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraCluster::max(self : NetroutedijkstraCluster) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraCluster::to_string(self : NetroutedijkstraCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_model_make(size : Int) -> NetroutedijkstraModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraModel::len(self : NetroutedijkstraModel) -> Int { self.size }

pub fn NetroutedijkstraModel::get(self : NetroutedijkstraModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraModel::set(self : NetroutedijkstraModel, i : Int, v : Double) -> NetroutedijkstraModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraModel::sum(self : NetroutedijkstraModel) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraModel::mean(self : NetroutedijkstraModel) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraModel::scale(self : NetroutedijkstraModel, f : Double) -> NetroutedijkstraModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraModel::add(self : NetroutedijkstraModel, other : NetroutedijkstraModel) -> NetroutedijkstraModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraModel::copy(self : NetroutedijkstraModel) -> NetroutedijkstraModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraModel::fill(self : NetroutedijkstraModel, v : Double) -> NetroutedijkstraModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraModel::min(self : NetroutedijkstraModel) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraModel::max(self : NetroutedijkstraModel) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraModel::to_string(self : NetroutedijkstraModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_layer_make(size : Int) -> NetroutedijkstraLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraLayer::len(self : NetroutedijkstraLayer) -> Int { self.size }

pub fn NetroutedijkstraLayer::get(self : NetroutedijkstraLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraLayer::set(self : NetroutedijkstraLayer, i : Int, v : Double) -> NetroutedijkstraLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraLayer::sum(self : NetroutedijkstraLayer) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraLayer::mean(self : NetroutedijkstraLayer) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraLayer::scale(self : NetroutedijkstraLayer, f : Double) -> NetroutedijkstraLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraLayer::add(self : NetroutedijkstraLayer, other : NetroutedijkstraLayer) -> NetroutedijkstraLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraLayer::copy(self : NetroutedijkstraLayer) -> NetroutedijkstraLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraLayer::fill(self : NetroutedijkstraLayer, v : Double) -> NetroutedijkstraLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraLayer::min(self : NetroutedijkstraLayer) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraLayer::max(self : NetroutedijkstraLayer) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraLayer::to_string(self : NetroutedijkstraLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_buffer_make(size : Int) -> NetroutedijkstraBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraBuffer::len(self : NetroutedijkstraBuffer) -> Int { self.size }

pub fn NetroutedijkstraBuffer::get(self : NetroutedijkstraBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraBuffer::set(self : NetroutedijkstraBuffer, i : Int, v : Double) -> NetroutedijkstraBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraBuffer::sum(self : NetroutedijkstraBuffer) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraBuffer::mean(self : NetroutedijkstraBuffer) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraBuffer::scale(self : NetroutedijkstraBuffer, f : Double) -> NetroutedijkstraBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraBuffer::add(self : NetroutedijkstraBuffer, other : NetroutedijkstraBuffer) -> NetroutedijkstraBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraBuffer::copy(self : NetroutedijkstraBuffer) -> NetroutedijkstraBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraBuffer::fill(self : NetroutedijkstraBuffer, v : Double) -> NetroutedijkstraBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraBuffer::min(self : NetroutedijkstraBuffer) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraBuffer::max(self : NetroutedijkstraBuffer) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraBuffer::to_string(self : NetroutedijkstraBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_cursor_make(size : Int) -> NetroutedijkstraCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraCursor::len(self : NetroutedijkstraCursor) -> Int { self.size }

pub fn NetroutedijkstraCursor::get(self : NetroutedijkstraCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraCursor::set(self : NetroutedijkstraCursor, i : Int, v : Double) -> NetroutedijkstraCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraCursor::sum(self : NetroutedijkstraCursor) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraCursor::mean(self : NetroutedijkstraCursor) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraCursor::scale(self : NetroutedijkstraCursor, f : Double) -> NetroutedijkstraCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraCursor::add(self : NetroutedijkstraCursor, other : NetroutedijkstraCursor) -> NetroutedijkstraCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraCursor::copy(self : NetroutedijkstraCursor) -> NetroutedijkstraCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraCursor::fill(self : NetroutedijkstraCursor, v : Double) -> NetroutedijkstraCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraCursor::min(self : NetroutedijkstraCursor) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraCursor::max(self : NetroutedijkstraCursor) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraCursor::to_string(self : NetroutedijkstraCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_view_make(size : Int) -> NetroutedijkstraView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraView::len(self : NetroutedijkstraView) -> Int { self.size }

pub fn NetroutedijkstraView::get(self : NetroutedijkstraView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraView::set(self : NetroutedijkstraView, i : Int, v : Double) -> NetroutedijkstraView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraView::sum(self : NetroutedijkstraView) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraView::mean(self : NetroutedijkstraView) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraView::scale(self : NetroutedijkstraView, f : Double) -> NetroutedijkstraView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraView::add(self : NetroutedijkstraView, other : NetroutedijkstraView) -> NetroutedijkstraView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraView::copy(self : NetroutedijkstraView) -> NetroutedijkstraView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraView::fill(self : NetroutedijkstraView, v : Double) -> NetroutedijkstraView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraView::min(self : NetroutedijkstraView) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraView::max(self : NetroutedijkstraView) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraView::to_string(self : NetroutedijkstraView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_range_make(size : Int) -> NetroutedijkstraRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraRange::len(self : NetroutedijkstraRange) -> Int { self.size }

pub fn NetroutedijkstraRange::get(self : NetroutedijkstraRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraRange::set(self : NetroutedijkstraRange, i : Int, v : Double) -> NetroutedijkstraRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraRange::sum(self : NetroutedijkstraRange) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraRange::mean(self : NetroutedijkstraRange) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraRange::scale(self : NetroutedijkstraRange, f : Double) -> NetroutedijkstraRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraRange::add(self : NetroutedijkstraRange, other : NetroutedijkstraRange) -> NetroutedijkstraRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraRange::copy(self : NetroutedijkstraRange) -> NetroutedijkstraRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraRange::fill(self : NetroutedijkstraRange, v : Double) -> NetroutedijkstraRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraRange::min(self : NetroutedijkstraRange) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraRange::max(self : NetroutedijkstraRange) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraRange::to_string(self : NetroutedijkstraRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_slice_make(size : Int) -> NetroutedijkstraSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutedijkstraSlice::len(self : NetroutedijkstraSlice) -> Int { self.size }

pub fn NetroutedijkstraSlice::get(self : NetroutedijkstraSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutedijkstraSlice::set(self : NetroutedijkstraSlice, i : Int, v : Double) -> NetroutedijkstraSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraSlice::sum(self : NetroutedijkstraSlice) -> Double { @_common.sum(self.data) }

pub fn NetroutedijkstraSlice::mean(self : NetroutedijkstraSlice) -> Double { @_common.mean(self.data) }

pub fn NetroutedijkstraSlice::scale(self : NetroutedijkstraSlice, f : Double) -> NetroutedijkstraSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraSlice::add(self : NetroutedijkstraSlice, other : NetroutedijkstraSlice) -> NetroutedijkstraSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutedijkstraSlice::copy(self : NetroutedijkstraSlice) -> NetroutedijkstraSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraSlice::fill(self : NetroutedijkstraSlice, v : Double) -> NetroutedijkstraSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutedijkstraSlice::min(self : NetroutedijkstraSlice) -> Double { @_common.min(self.data) }

pub fn NetroutedijkstraSlice::max(self : NetroutedijkstraSlice) -> Double { @_common.max(self.data) }

pub fn NetroutedijkstraSlice::to_string(self : NetroutedijkstraSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

