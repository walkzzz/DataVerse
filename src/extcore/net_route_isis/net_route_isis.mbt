///===
/// extcore/net_route_isis

pub(all) struct NetrouteisisPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_isis_make_point(x : Double, y : Double) -> NetrouteisisPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_isis_make_point3(x : Double, y : Double, z : Double) -> NetrouteisisPoint {
  { x, y, z, label: 0 }
}

pub fn NetrouteisisPoint::x(self : NetrouteisisPoint) -> Double { self.x }

pub fn NetrouteisisPoint::y(self : NetrouteisisPoint) -> Double { self.y }

pub fn NetrouteisisPoint::z(self : NetrouteisisPoint) -> Double { self.z }

pub fn NetrouteisisPoint::label(self : NetrouteisisPoint) -> Int { self.label }

pub fn NetrouteisisPoint::dist(self : NetrouteisisPoint, other : NetrouteisisPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetrouteisisPoint::add(self : NetrouteisisPoint, other : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetrouteisisPoint::sub(self : NetrouteisisPoint, other : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetrouteisisPoint::scale(self : NetrouteisisPoint, s : Double) -> NetrouteisisPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetrouteisisPoint::dot(self : NetrouteisisPoint, other : NetrouteisisPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetrouteisisPoint::cross(self : NetrouteisisPoint, other : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetrouteisisPoint::norm(self : NetrouteisisPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetrouteisisPoint::normalize(self : NetrouteisisPoint) -> NetrouteisisPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteisisPoint::negate(self : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetrouteisisPoint::mid(self : NetrouteisisPoint, other : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetrouteisisPoint::lerp(self : NetrouteisisPoint, other : NetrouteisisPoint, t : Double) -> NetrouteisisPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetrouteisisPoint::to_string(self : NetrouteisisPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetrouteisisSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_isis_make_series(vals : Array[Double], name : String) -> NetrouteisisSeries {
  { vals, name, meta: 0 }
}

pub fn NetrouteisisSeries::len(self : NetrouteisisSeries) -> Int { self.vals.length() }

pub fn NetrouteisisSeries::sum(self : NetrouteisisSeries) -> Double { @_common.sum(self.vals) }

pub fn NetrouteisisSeries::mean(self : NetrouteisisSeries) -> Double { @_common.mean(self.vals) }

pub fn NetrouteisisSeries::min(self : NetrouteisisSeries) -> Double { @_common.min(self.vals) }

pub fn NetrouteisisSeries::max(self : NetrouteisisSeries) -> Double { @_common.max(self.vals) }

pub fn NetrouteisisSeries::range(self : NetrouteisisSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetrouteisisSeries::variance(self : NetrouteisisSeries) -> Double { @_common.variance(self.vals) }

pub fn NetrouteisisSeries::std(self : NetrouteisisSeries) -> Double { @_common.std(self.vals) }

pub fn NetrouteisisSeries::median(self : NetrouteisisSeries) -> Double { @_common.median(self.vals) }

pub fn NetrouteisisSeries::scale(self : NetrouteisisSeries, f : Double) -> NetrouteisisSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetrouteisisSeries::add(self : NetrouteisisSeries, other : NetrouteisisSeries) -> NetrouteisisSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetrouteisisSeries::sub(self : NetrouteisisSeries, other : NetrouteisisSeries) -> NetrouteisisSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetrouteisisSeries::normalize(self : NetrouteisisSeries) -> NetrouteisisSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetrouteisisSeries::cumsum(self : NetrouteisisSeries) -> NetrouteisisSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetrouteisisSeries::to_string(self : NetrouteisisSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteisisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_isis_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteisisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_isis_matrix_identity(n : Int) -> NetrouteisisMatrix {
  let m = net_route_isis_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetrouteisisMatrix::get(self : NetrouteisisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetrouteisisMatrix::transpose(self : NetrouteisisMatrix) -> NetrouteisisMatrix {
  let result = net_route_isis_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetrouteisisMatrix::add(self : NetrouteisisMatrix, other : NetrouteisisMatrix) -> NetrouteisisMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_isis_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetrouteisisMatrix::scale(self : NetrouteisisMatrix, s : Double) -> NetrouteisisMatrix {
  let result = net_route_isis_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetrouteisisMatrix::multiply(self : NetrouteisisMatrix, other : NetrouteisisMatrix) -> NetrouteisisMatrix {
  if self.cols != other.rows { return net_route_isis_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_isis_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetrouteisisMatrix::trace(self : NetrouteisisMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetrouteisisMatrix::det(self : NetrouteisisMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetrouteisisMatrix::norm(self : NetrouteisisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetrouteisisMatrix::to_string(self : NetrouteisisMatrix) -> String {
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

pub(all) struct NetrouteisisVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_isis_make_vector(comps : Array[Double]) -> NetrouteisisVector {
  { comps, dim: comps.length() }
}

pub fn net_route_isis_vector_zero(dim : Int) -> NetrouteisisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetrouteisisVector::add(self : NetrouteisisVector, other : NetrouteisisVector) -> NetrouteisisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteisisVector::sub(self : NetrouteisisVector, other : NetrouteisisVector) -> NetrouteisisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteisisVector::scale(self : NetrouteisisVector, s : Double) -> NetrouteisisVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetrouteisisVector::dot(self : NetrouteisisVector, other : NetrouteisisVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetrouteisisVector::norm(self : NetrouteisisVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetrouteisisVector::normalize(self : NetrouteisisVector) -> NetrouteisisVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteisisVector::dist(self : NetrouteisisVector, other : NetrouteisisVector) -> Double {
  self.sub(other).norm()
}

pub fn NetrouteisisVector::to_string(self : NetrouteisisVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteisisFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_frame_make(size : Int) -> NetrouteisisFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisFrame::len(self : NetrouteisisFrame) -> Int { self.size }

pub fn NetrouteisisFrame::get(self : NetrouteisisFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisFrame::set(self : NetrouteisisFrame, i : Int, v : Double) -> NetrouteisisFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisFrame::sum(self : NetrouteisisFrame) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisFrame::mean(self : NetrouteisisFrame) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisFrame::scale(self : NetrouteisisFrame, f : Double) -> NetrouteisisFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisFrame::add(self : NetrouteisisFrame, other : NetrouteisisFrame) -> NetrouteisisFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisFrame::copy(self : NetrouteisisFrame) -> NetrouteisisFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisFrame::fill(self : NetrouteisisFrame, v : Double) -> NetrouteisisFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisFrame::min(self : NetrouteisisFrame) -> Double { @_common.min(self.data) }

pub fn NetrouteisisFrame::max(self : NetrouteisisFrame) -> Double { @_common.max(self.data) }

pub fn NetrouteisisFrame::to_string(self : NetrouteisisFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_table_make(size : Int) -> NetrouteisisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisTable::len(self : NetrouteisisTable) -> Int { self.size }

pub fn NetrouteisisTable::get(self : NetrouteisisTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisTable::set(self : NetrouteisisTable, i : Int, v : Double) -> NetrouteisisTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisTable::sum(self : NetrouteisisTable) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisTable::mean(self : NetrouteisisTable) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisTable::scale(self : NetrouteisisTable, f : Double) -> NetrouteisisTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisTable::add(self : NetrouteisisTable, other : NetrouteisisTable) -> NetrouteisisTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisTable::copy(self : NetrouteisisTable) -> NetrouteisisTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisTable::fill(self : NetrouteisisTable, v : Double) -> NetrouteisisTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisTable::min(self : NetrouteisisTable) -> Double { @_common.min(self.data) }

pub fn NetrouteisisTable::max(self : NetrouteisisTable) -> Double { @_common.max(self.data) }

pub fn NetrouteisisTable::to_string(self : NetrouteisisTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_graphn_make(size : Int) -> NetrouteisisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisGraphN::len(self : NetrouteisisGraphN) -> Int { self.size }

pub fn NetrouteisisGraphN::get(self : NetrouteisisGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisGraphN::set(self : NetrouteisisGraphN, i : Int, v : Double) -> NetrouteisisGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisGraphN::sum(self : NetrouteisisGraphN) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisGraphN::mean(self : NetrouteisisGraphN) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisGraphN::scale(self : NetrouteisisGraphN, f : Double) -> NetrouteisisGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisGraphN::add(self : NetrouteisisGraphN, other : NetrouteisisGraphN) -> NetrouteisisGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisGraphN::copy(self : NetrouteisisGraphN) -> NetrouteisisGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisGraphN::fill(self : NetrouteisisGraphN, v : Double) -> NetrouteisisGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisGraphN::min(self : NetrouteisisGraphN) -> Double { @_common.min(self.data) }

pub fn NetrouteisisGraphN::max(self : NetrouteisisGraphN) -> Double { @_common.max(self.data) }

pub fn NetrouteisisGraphN::to_string(self : NetrouteisisGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_node_make(size : Int) -> NetrouteisisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisNode::len(self : NetrouteisisNode) -> Int { self.size }

pub fn NetrouteisisNode::get(self : NetrouteisisNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisNode::set(self : NetrouteisisNode, i : Int, v : Double) -> NetrouteisisNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisNode::sum(self : NetrouteisisNode) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisNode::mean(self : NetrouteisisNode) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisNode::scale(self : NetrouteisisNode, f : Double) -> NetrouteisisNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisNode::add(self : NetrouteisisNode, other : NetrouteisisNode) -> NetrouteisisNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisNode::copy(self : NetrouteisisNode) -> NetrouteisisNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisNode::fill(self : NetrouteisisNode, v : Double) -> NetrouteisisNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisNode::min(self : NetrouteisisNode) -> Double { @_common.min(self.data) }

pub fn NetrouteisisNode::max(self : NetrouteisisNode) -> Double { @_common.max(self.data) }

pub fn NetrouteisisNode::to_string(self : NetrouteisisNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_edge_make(size : Int) -> NetrouteisisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisEdge::len(self : NetrouteisisEdge) -> Int { self.size }

pub fn NetrouteisisEdge::get(self : NetrouteisisEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisEdge::set(self : NetrouteisisEdge, i : Int, v : Double) -> NetrouteisisEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisEdge::sum(self : NetrouteisisEdge) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisEdge::mean(self : NetrouteisisEdge) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisEdge::scale(self : NetrouteisisEdge, f : Double) -> NetrouteisisEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisEdge::add(self : NetrouteisisEdge, other : NetrouteisisEdge) -> NetrouteisisEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisEdge::copy(self : NetrouteisisEdge) -> NetrouteisisEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisEdge::fill(self : NetrouteisisEdge, v : Double) -> NetrouteisisEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisEdge::min(self : NetrouteisisEdge) -> Double { @_common.min(self.data) }

pub fn NetrouteisisEdge::max(self : NetrouteisisEdge) -> Double { @_common.max(self.data) }

pub fn NetrouteisisEdge::to_string(self : NetrouteisisEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_path_make(size : Int) -> NetrouteisisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisPath::len(self : NetrouteisisPath) -> Int { self.size }

pub fn NetrouteisisPath::get(self : NetrouteisisPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisPath::set(self : NetrouteisisPath, i : Int, v : Double) -> NetrouteisisPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisPath::sum(self : NetrouteisisPath) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisPath::mean(self : NetrouteisisPath) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisPath::scale(self : NetrouteisisPath, f : Double) -> NetrouteisisPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisPath::add(self : NetrouteisisPath, other : NetrouteisisPath) -> NetrouteisisPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisPath::copy(self : NetrouteisisPath) -> NetrouteisisPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisPath::fill(self : NetrouteisisPath, v : Double) -> NetrouteisisPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisPath::min(self : NetrouteisisPath) -> Double { @_common.min(self.data) }

pub fn NetrouteisisPath::max(self : NetrouteisisPath) -> Double { @_common.max(self.data) }

pub fn NetrouteisisPath::to_string(self : NetrouteisisPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_cluster_make(size : Int) -> NetrouteisisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisCluster::len(self : NetrouteisisCluster) -> Int { self.size }

pub fn NetrouteisisCluster::get(self : NetrouteisisCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisCluster::set(self : NetrouteisisCluster, i : Int, v : Double) -> NetrouteisisCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisCluster::sum(self : NetrouteisisCluster) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisCluster::mean(self : NetrouteisisCluster) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisCluster::scale(self : NetrouteisisCluster, f : Double) -> NetrouteisisCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisCluster::add(self : NetrouteisisCluster, other : NetrouteisisCluster) -> NetrouteisisCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisCluster::copy(self : NetrouteisisCluster) -> NetrouteisisCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisCluster::fill(self : NetrouteisisCluster, v : Double) -> NetrouteisisCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisCluster::min(self : NetrouteisisCluster) -> Double { @_common.min(self.data) }

pub fn NetrouteisisCluster::max(self : NetrouteisisCluster) -> Double { @_common.max(self.data) }

pub fn NetrouteisisCluster::to_string(self : NetrouteisisCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_model_make(size : Int) -> NetrouteisisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisModel::len(self : NetrouteisisModel) -> Int { self.size }

pub fn NetrouteisisModel::get(self : NetrouteisisModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisModel::set(self : NetrouteisisModel, i : Int, v : Double) -> NetrouteisisModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisModel::sum(self : NetrouteisisModel) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisModel::mean(self : NetrouteisisModel) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisModel::scale(self : NetrouteisisModel, f : Double) -> NetrouteisisModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisModel::add(self : NetrouteisisModel, other : NetrouteisisModel) -> NetrouteisisModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisModel::copy(self : NetrouteisisModel) -> NetrouteisisModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisModel::fill(self : NetrouteisisModel, v : Double) -> NetrouteisisModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisModel::min(self : NetrouteisisModel) -> Double { @_common.min(self.data) }

pub fn NetrouteisisModel::max(self : NetrouteisisModel) -> Double { @_common.max(self.data) }

pub fn NetrouteisisModel::to_string(self : NetrouteisisModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_layer_make(size : Int) -> NetrouteisisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisLayer::len(self : NetrouteisisLayer) -> Int { self.size }

pub fn NetrouteisisLayer::get(self : NetrouteisisLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisLayer::set(self : NetrouteisisLayer, i : Int, v : Double) -> NetrouteisisLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisLayer::sum(self : NetrouteisisLayer) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisLayer::mean(self : NetrouteisisLayer) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisLayer::scale(self : NetrouteisisLayer, f : Double) -> NetrouteisisLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisLayer::add(self : NetrouteisisLayer, other : NetrouteisisLayer) -> NetrouteisisLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisLayer::copy(self : NetrouteisisLayer) -> NetrouteisisLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisLayer::fill(self : NetrouteisisLayer, v : Double) -> NetrouteisisLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisLayer::min(self : NetrouteisisLayer) -> Double { @_common.min(self.data) }

pub fn NetrouteisisLayer::max(self : NetrouteisisLayer) -> Double { @_common.max(self.data) }

pub fn NetrouteisisLayer::to_string(self : NetrouteisisLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_buffer_make(size : Int) -> NetrouteisisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisBuffer::len(self : NetrouteisisBuffer) -> Int { self.size }

pub fn NetrouteisisBuffer::get(self : NetrouteisisBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisBuffer::set(self : NetrouteisisBuffer, i : Int, v : Double) -> NetrouteisisBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisBuffer::sum(self : NetrouteisisBuffer) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisBuffer::mean(self : NetrouteisisBuffer) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisBuffer::scale(self : NetrouteisisBuffer, f : Double) -> NetrouteisisBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisBuffer::add(self : NetrouteisisBuffer, other : NetrouteisisBuffer) -> NetrouteisisBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisBuffer::copy(self : NetrouteisisBuffer) -> NetrouteisisBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisBuffer::fill(self : NetrouteisisBuffer, v : Double) -> NetrouteisisBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisBuffer::min(self : NetrouteisisBuffer) -> Double { @_common.min(self.data) }

pub fn NetrouteisisBuffer::max(self : NetrouteisisBuffer) -> Double { @_common.max(self.data) }

pub fn NetrouteisisBuffer::to_string(self : NetrouteisisBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_cursor_make(size : Int) -> NetrouteisisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisCursor::len(self : NetrouteisisCursor) -> Int { self.size }

pub fn NetrouteisisCursor::get(self : NetrouteisisCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisCursor::set(self : NetrouteisisCursor, i : Int, v : Double) -> NetrouteisisCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisCursor::sum(self : NetrouteisisCursor) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisCursor::mean(self : NetrouteisisCursor) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisCursor::scale(self : NetrouteisisCursor, f : Double) -> NetrouteisisCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisCursor::add(self : NetrouteisisCursor, other : NetrouteisisCursor) -> NetrouteisisCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisCursor::copy(self : NetrouteisisCursor) -> NetrouteisisCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisCursor::fill(self : NetrouteisisCursor, v : Double) -> NetrouteisisCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisCursor::min(self : NetrouteisisCursor) -> Double { @_common.min(self.data) }

pub fn NetrouteisisCursor::max(self : NetrouteisisCursor) -> Double { @_common.max(self.data) }

pub fn NetrouteisisCursor::to_string(self : NetrouteisisCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_view_make(size : Int) -> NetrouteisisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisView::len(self : NetrouteisisView) -> Int { self.size }

pub fn NetrouteisisView::get(self : NetrouteisisView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisView::set(self : NetrouteisisView, i : Int, v : Double) -> NetrouteisisView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisView::sum(self : NetrouteisisView) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisView::mean(self : NetrouteisisView) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisView::scale(self : NetrouteisisView, f : Double) -> NetrouteisisView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisView::add(self : NetrouteisisView, other : NetrouteisisView) -> NetrouteisisView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisView::copy(self : NetrouteisisView) -> NetrouteisisView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisView::fill(self : NetrouteisisView, v : Double) -> NetrouteisisView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisView::min(self : NetrouteisisView) -> Double { @_common.min(self.data) }

pub fn NetrouteisisView::max(self : NetrouteisisView) -> Double { @_common.max(self.data) }

pub fn NetrouteisisView::to_string(self : NetrouteisisView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_range_make(size : Int) -> NetrouteisisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisRange::len(self : NetrouteisisRange) -> Int { self.size }

pub fn NetrouteisisRange::get(self : NetrouteisisRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisRange::set(self : NetrouteisisRange, i : Int, v : Double) -> NetrouteisisRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisRange::sum(self : NetrouteisisRange) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisRange::mean(self : NetrouteisisRange) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisRange::scale(self : NetrouteisisRange, f : Double) -> NetrouteisisRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisRange::add(self : NetrouteisisRange, other : NetrouteisisRange) -> NetrouteisisRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisRange::copy(self : NetrouteisisRange) -> NetrouteisisRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisRange::fill(self : NetrouteisisRange, v : Double) -> NetrouteisisRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisRange::min(self : NetrouteisisRange) -> Double { @_common.min(self.data) }

pub fn NetrouteisisRange::max(self : NetrouteisisRange) -> Double { @_common.max(self.data) }

pub fn NetrouteisisRange::to_string(self : NetrouteisisRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteisisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_slice_make(size : Int) -> NetrouteisisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteisisSlice::len(self : NetrouteisisSlice) -> Int { self.size }

pub fn NetrouteisisSlice::get(self : NetrouteisisSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteisisSlice::set(self : NetrouteisisSlice, i : Int, v : Double) -> NetrouteisisSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteisisSlice::sum(self : NetrouteisisSlice) -> Double { @_common.sum(self.data) }

pub fn NetrouteisisSlice::mean(self : NetrouteisisSlice) -> Double { @_common.mean(self.data) }

pub fn NetrouteisisSlice::scale(self : NetrouteisisSlice, f : Double) -> NetrouteisisSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteisisSlice::add(self : NetrouteisisSlice, other : NetrouteisisSlice) -> NetrouteisisSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteisisSlice::copy(self : NetrouteisisSlice) -> NetrouteisisSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteisisSlice::fill(self : NetrouteisisSlice, v : Double) -> NetrouteisisSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteisisSlice::min(self : NetrouteisisSlice) -> Double { @_common.min(self.data) }

pub fn NetrouteisisSlice::max(self : NetrouteisisSlice) -> Double { @_common.max(self.data) }

pub fn NetrouteisisSlice::to_string(self : NetrouteisisSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

