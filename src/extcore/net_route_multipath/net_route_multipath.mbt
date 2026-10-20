///===
/// extcore/net_route_multipath

pub(all) struct NetroutemultipathPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_multipath_make_point(x : Double, y : Double) -> NetroutemultipathPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_multipath_make_point3(x : Double, y : Double, z : Double) -> NetroutemultipathPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutemultipathPoint::x(self : NetroutemultipathPoint) -> Double { self.x }

pub fn NetroutemultipathPoint::y(self : NetroutemultipathPoint) -> Double { self.y }

pub fn NetroutemultipathPoint::z(self : NetroutemultipathPoint) -> Double { self.z }

pub fn NetroutemultipathPoint::label(self : NetroutemultipathPoint) -> Int { self.label }

pub fn NetroutemultipathPoint::dist(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutemultipathPoint::add(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutemultipathPoint::sub(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutemultipathPoint::scale(self : NetroutemultipathPoint, s : Double) -> NetroutemultipathPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutemultipathPoint::dot(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutemultipathPoint::cross(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutemultipathPoint::norm(self : NetroutemultipathPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutemultipathPoint::normalize(self : NetroutemultipathPoint) -> NetroutemultipathPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutemultipathPoint::negate(self : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutemultipathPoint::mid(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutemultipathPoint::lerp(self : NetroutemultipathPoint, other : NetroutemultipathPoint, t : Double) -> NetroutemultipathPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutemultipathPoint::to_string(self : NetroutemultipathPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutemultipathSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_multipath_make_series(vals : Array[Double], name : String) -> NetroutemultipathSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutemultipathSeries::len(self : NetroutemultipathSeries) -> Int { self.vals.length() }

pub fn NetroutemultipathSeries::sum(self : NetroutemultipathSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutemultipathSeries::mean(self : NetroutemultipathSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutemultipathSeries::min(self : NetroutemultipathSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutemultipathSeries::max(self : NetroutemultipathSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutemultipathSeries::range(self : NetroutemultipathSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutemultipathSeries::variance(self : NetroutemultipathSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutemultipathSeries::std(self : NetroutemultipathSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutemultipathSeries::median(self : NetroutemultipathSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutemultipathSeries::scale(self : NetroutemultipathSeries, f : Double) -> NetroutemultipathSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutemultipathSeries::add(self : NetroutemultipathSeries, other : NetroutemultipathSeries) -> NetroutemultipathSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutemultipathSeries::sub(self : NetroutemultipathSeries, other : NetroutemultipathSeries) -> NetroutemultipathSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutemultipathSeries::normalize(self : NetroutemultipathSeries) -> NetroutemultipathSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutemultipathSeries::cumsum(self : NetroutemultipathSeries) -> NetroutemultipathSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutemultipathSeries::to_string(self : NetroutemultipathSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutemultipathMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_multipath_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutemultipathMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_multipath_matrix_identity(n : Int) -> NetroutemultipathMatrix {
  let m = net_route_multipath_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutemultipathMatrix::get(self : NetroutemultipathMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutemultipathMatrix::transpose(self : NetroutemultipathMatrix) -> NetroutemultipathMatrix {
  let result = net_route_multipath_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutemultipathMatrix::add(self : NetroutemultipathMatrix, other : NetroutemultipathMatrix) -> NetroutemultipathMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_multipath_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutemultipathMatrix::scale(self : NetroutemultipathMatrix, s : Double) -> NetroutemultipathMatrix {
  let result = net_route_multipath_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutemultipathMatrix::multiply(self : NetroutemultipathMatrix, other : NetroutemultipathMatrix) -> NetroutemultipathMatrix {
  if self.cols != other.rows { return net_route_multipath_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_multipath_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetroutemultipathMatrix::trace(self : NetroutemultipathMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutemultipathMatrix::det(self : NetroutemultipathMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutemultipathMatrix::norm(self : NetroutemultipathMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutemultipathMatrix::to_string(self : NetroutemultipathMatrix) -> String {
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

pub(all) struct NetroutemultipathVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_multipath_make_vector(comps : Array[Double]) -> NetroutemultipathVector {
  { comps, dim: comps.length() }
}

pub fn net_route_multipath_vector_zero(dim : Int) -> NetroutemultipathVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutemultipathVector::add(self : NetroutemultipathVector, other : NetroutemultipathVector) -> NetroutemultipathVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutemultipathVector::sub(self : NetroutemultipathVector, other : NetroutemultipathVector) -> NetroutemultipathVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutemultipathVector::scale(self : NetroutemultipathVector, s : Double) -> NetroutemultipathVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutemultipathVector::dot(self : NetroutemultipathVector, other : NetroutemultipathVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutemultipathVector::norm(self : NetroutemultipathVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutemultipathVector::normalize(self : NetroutemultipathVector) -> NetroutemultipathVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutemultipathVector::dist(self : NetroutemultipathVector, other : NetroutemultipathVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutemultipathVector::to_string(self : NetroutemultipathVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutemultipathFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_frame_make(size : Int) -> NetroutemultipathFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathFrame::len(self : NetroutemultipathFrame) -> Int { self.size }

pub fn NetroutemultipathFrame::get(self : NetroutemultipathFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathFrame::set(self : NetroutemultipathFrame, i : Int, v : Double) -> NetroutemultipathFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathFrame::sum(self : NetroutemultipathFrame) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathFrame::mean(self : NetroutemultipathFrame) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathFrame::scale(self : NetroutemultipathFrame, f : Double) -> NetroutemultipathFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathFrame::add(self : NetroutemultipathFrame, other : NetroutemultipathFrame) -> NetroutemultipathFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathFrame::copy(self : NetroutemultipathFrame) -> NetroutemultipathFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathFrame::fill(self : NetroutemultipathFrame, v : Double) -> NetroutemultipathFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathFrame::min(self : NetroutemultipathFrame) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathFrame::max(self : NetroutemultipathFrame) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathFrame::to_string(self : NetroutemultipathFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_table_make(size : Int) -> NetroutemultipathTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathTable::len(self : NetroutemultipathTable) -> Int { self.size }

pub fn NetroutemultipathTable::get(self : NetroutemultipathTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathTable::set(self : NetroutemultipathTable, i : Int, v : Double) -> NetroutemultipathTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathTable::sum(self : NetroutemultipathTable) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathTable::mean(self : NetroutemultipathTable) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathTable::scale(self : NetroutemultipathTable, f : Double) -> NetroutemultipathTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathTable::add(self : NetroutemultipathTable, other : NetroutemultipathTable) -> NetroutemultipathTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathTable::copy(self : NetroutemultipathTable) -> NetroutemultipathTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathTable::fill(self : NetroutemultipathTable, v : Double) -> NetroutemultipathTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathTable::min(self : NetroutemultipathTable) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathTable::max(self : NetroutemultipathTable) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathTable::to_string(self : NetroutemultipathTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_graphn_make(size : Int) -> NetroutemultipathGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathGraphN::len(self : NetroutemultipathGraphN) -> Int { self.size }

pub fn NetroutemultipathGraphN::get(self : NetroutemultipathGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathGraphN::set(self : NetroutemultipathGraphN, i : Int, v : Double) -> NetroutemultipathGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathGraphN::sum(self : NetroutemultipathGraphN) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathGraphN::mean(self : NetroutemultipathGraphN) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathGraphN::scale(self : NetroutemultipathGraphN, f : Double) -> NetroutemultipathGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathGraphN::add(self : NetroutemultipathGraphN, other : NetroutemultipathGraphN) -> NetroutemultipathGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathGraphN::copy(self : NetroutemultipathGraphN) -> NetroutemultipathGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathGraphN::fill(self : NetroutemultipathGraphN, v : Double) -> NetroutemultipathGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathGraphN::min(self : NetroutemultipathGraphN) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathGraphN::max(self : NetroutemultipathGraphN) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathGraphN::to_string(self : NetroutemultipathGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_node_make(size : Int) -> NetroutemultipathNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathNode::len(self : NetroutemultipathNode) -> Int { self.size }

pub fn NetroutemultipathNode::get(self : NetroutemultipathNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathNode::set(self : NetroutemultipathNode, i : Int, v : Double) -> NetroutemultipathNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathNode::sum(self : NetroutemultipathNode) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathNode::mean(self : NetroutemultipathNode) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathNode::scale(self : NetroutemultipathNode, f : Double) -> NetroutemultipathNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathNode::add(self : NetroutemultipathNode, other : NetroutemultipathNode) -> NetroutemultipathNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathNode::copy(self : NetroutemultipathNode) -> NetroutemultipathNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathNode::fill(self : NetroutemultipathNode, v : Double) -> NetroutemultipathNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathNode::min(self : NetroutemultipathNode) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathNode::max(self : NetroutemultipathNode) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathNode::to_string(self : NetroutemultipathNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_edge_make(size : Int) -> NetroutemultipathEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathEdge::len(self : NetroutemultipathEdge) -> Int { self.size }

pub fn NetroutemultipathEdge::get(self : NetroutemultipathEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathEdge::set(self : NetroutemultipathEdge, i : Int, v : Double) -> NetroutemultipathEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathEdge::sum(self : NetroutemultipathEdge) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathEdge::mean(self : NetroutemultipathEdge) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathEdge::scale(self : NetroutemultipathEdge, f : Double) -> NetroutemultipathEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathEdge::add(self : NetroutemultipathEdge, other : NetroutemultipathEdge) -> NetroutemultipathEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathEdge::copy(self : NetroutemultipathEdge) -> NetroutemultipathEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathEdge::fill(self : NetroutemultipathEdge, v : Double) -> NetroutemultipathEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathEdge::min(self : NetroutemultipathEdge) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathEdge::max(self : NetroutemultipathEdge) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathEdge::to_string(self : NetroutemultipathEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_path_make(size : Int) -> NetroutemultipathPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathPath::len(self : NetroutemultipathPath) -> Int { self.size }

pub fn NetroutemultipathPath::get(self : NetroutemultipathPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathPath::set(self : NetroutemultipathPath, i : Int, v : Double) -> NetroutemultipathPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathPath::sum(self : NetroutemultipathPath) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathPath::mean(self : NetroutemultipathPath) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathPath::scale(self : NetroutemultipathPath, f : Double) -> NetroutemultipathPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathPath::add(self : NetroutemultipathPath, other : NetroutemultipathPath) -> NetroutemultipathPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathPath::copy(self : NetroutemultipathPath) -> NetroutemultipathPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathPath::fill(self : NetroutemultipathPath, v : Double) -> NetroutemultipathPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathPath::min(self : NetroutemultipathPath) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathPath::max(self : NetroutemultipathPath) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathPath::to_string(self : NetroutemultipathPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_cluster_make(size : Int) -> NetroutemultipathCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathCluster::len(self : NetroutemultipathCluster) -> Int { self.size }

pub fn NetroutemultipathCluster::get(self : NetroutemultipathCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathCluster::set(self : NetroutemultipathCluster, i : Int, v : Double) -> NetroutemultipathCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathCluster::sum(self : NetroutemultipathCluster) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathCluster::mean(self : NetroutemultipathCluster) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathCluster::scale(self : NetroutemultipathCluster, f : Double) -> NetroutemultipathCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathCluster::add(self : NetroutemultipathCluster, other : NetroutemultipathCluster) -> NetroutemultipathCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathCluster::copy(self : NetroutemultipathCluster) -> NetroutemultipathCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathCluster::fill(self : NetroutemultipathCluster, v : Double) -> NetroutemultipathCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathCluster::min(self : NetroutemultipathCluster) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathCluster::max(self : NetroutemultipathCluster) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathCluster::to_string(self : NetroutemultipathCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_model_make(size : Int) -> NetroutemultipathModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathModel::len(self : NetroutemultipathModel) -> Int { self.size }

pub fn NetroutemultipathModel::get(self : NetroutemultipathModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathModel::set(self : NetroutemultipathModel, i : Int, v : Double) -> NetroutemultipathModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathModel::sum(self : NetroutemultipathModel) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathModel::mean(self : NetroutemultipathModel) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathModel::scale(self : NetroutemultipathModel, f : Double) -> NetroutemultipathModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathModel::add(self : NetroutemultipathModel, other : NetroutemultipathModel) -> NetroutemultipathModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathModel::copy(self : NetroutemultipathModel) -> NetroutemultipathModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathModel::fill(self : NetroutemultipathModel, v : Double) -> NetroutemultipathModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathModel::min(self : NetroutemultipathModel) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathModel::max(self : NetroutemultipathModel) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathModel::to_string(self : NetroutemultipathModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_layer_make(size : Int) -> NetroutemultipathLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathLayer::len(self : NetroutemultipathLayer) -> Int { self.size }

pub fn NetroutemultipathLayer::get(self : NetroutemultipathLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathLayer::set(self : NetroutemultipathLayer, i : Int, v : Double) -> NetroutemultipathLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathLayer::sum(self : NetroutemultipathLayer) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathLayer::mean(self : NetroutemultipathLayer) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathLayer::scale(self : NetroutemultipathLayer, f : Double) -> NetroutemultipathLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathLayer::add(self : NetroutemultipathLayer, other : NetroutemultipathLayer) -> NetroutemultipathLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathLayer::copy(self : NetroutemultipathLayer) -> NetroutemultipathLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathLayer::fill(self : NetroutemultipathLayer, v : Double) -> NetroutemultipathLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathLayer::min(self : NetroutemultipathLayer) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathLayer::max(self : NetroutemultipathLayer) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathLayer::to_string(self : NetroutemultipathLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_buffer_make(size : Int) -> NetroutemultipathBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathBuffer::len(self : NetroutemultipathBuffer) -> Int { self.size }

pub fn NetroutemultipathBuffer::get(self : NetroutemultipathBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathBuffer::set(self : NetroutemultipathBuffer, i : Int, v : Double) -> NetroutemultipathBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathBuffer::sum(self : NetroutemultipathBuffer) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathBuffer::mean(self : NetroutemultipathBuffer) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathBuffer::scale(self : NetroutemultipathBuffer, f : Double) -> NetroutemultipathBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathBuffer::add(self : NetroutemultipathBuffer, other : NetroutemultipathBuffer) -> NetroutemultipathBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathBuffer::copy(self : NetroutemultipathBuffer) -> NetroutemultipathBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathBuffer::fill(self : NetroutemultipathBuffer, v : Double) -> NetroutemultipathBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathBuffer::min(self : NetroutemultipathBuffer) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathBuffer::max(self : NetroutemultipathBuffer) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathBuffer::to_string(self : NetroutemultipathBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_cursor_make(size : Int) -> NetroutemultipathCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathCursor::len(self : NetroutemultipathCursor) -> Int { self.size }

pub fn NetroutemultipathCursor::get(self : NetroutemultipathCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathCursor::set(self : NetroutemultipathCursor, i : Int, v : Double) -> NetroutemultipathCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathCursor::sum(self : NetroutemultipathCursor) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathCursor::mean(self : NetroutemultipathCursor) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathCursor::scale(self : NetroutemultipathCursor, f : Double) -> NetroutemultipathCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathCursor::add(self : NetroutemultipathCursor, other : NetroutemultipathCursor) -> NetroutemultipathCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathCursor::copy(self : NetroutemultipathCursor) -> NetroutemultipathCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathCursor::fill(self : NetroutemultipathCursor, v : Double) -> NetroutemultipathCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathCursor::min(self : NetroutemultipathCursor) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathCursor::max(self : NetroutemultipathCursor) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathCursor::to_string(self : NetroutemultipathCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_view_make(size : Int) -> NetroutemultipathView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathView::len(self : NetroutemultipathView) -> Int { self.size }

pub fn NetroutemultipathView::get(self : NetroutemultipathView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathView::set(self : NetroutemultipathView, i : Int, v : Double) -> NetroutemultipathView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathView::sum(self : NetroutemultipathView) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathView::mean(self : NetroutemultipathView) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathView::scale(self : NetroutemultipathView, f : Double) -> NetroutemultipathView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathView::add(self : NetroutemultipathView, other : NetroutemultipathView) -> NetroutemultipathView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathView::copy(self : NetroutemultipathView) -> NetroutemultipathView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathView::fill(self : NetroutemultipathView, v : Double) -> NetroutemultipathView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathView::min(self : NetroutemultipathView) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathView::max(self : NetroutemultipathView) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathView::to_string(self : NetroutemultipathView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_range_make(size : Int) -> NetroutemultipathRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathRange::len(self : NetroutemultipathRange) -> Int { self.size }

pub fn NetroutemultipathRange::get(self : NetroutemultipathRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathRange::set(self : NetroutemultipathRange, i : Int, v : Double) -> NetroutemultipathRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathRange::sum(self : NetroutemultipathRange) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathRange::mean(self : NetroutemultipathRange) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathRange::scale(self : NetroutemultipathRange, f : Double) -> NetroutemultipathRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathRange::add(self : NetroutemultipathRange, other : NetroutemultipathRange) -> NetroutemultipathRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathRange::copy(self : NetroutemultipathRange) -> NetroutemultipathRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathRange::fill(self : NetroutemultipathRange, v : Double) -> NetroutemultipathRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathRange::min(self : NetroutemultipathRange) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathRange::max(self : NetroutemultipathRange) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathRange::to_string(self : NetroutemultipathRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_slice_make(size : Int) -> NetroutemultipathSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutemultipathSlice::len(self : NetroutemultipathSlice) -> Int { self.size }

pub fn NetroutemultipathSlice::get(self : NetroutemultipathSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutemultipathSlice::set(self : NetroutemultipathSlice, i : Int, v : Double) -> NetroutemultipathSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutemultipathSlice::sum(self : NetroutemultipathSlice) -> Double { @_common.sum(self.data) }

pub fn NetroutemultipathSlice::mean(self : NetroutemultipathSlice) -> Double { @_common.mean(self.data) }

pub fn NetroutemultipathSlice::scale(self : NetroutemultipathSlice, f : Double) -> NetroutemultipathSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathSlice::add(self : NetroutemultipathSlice, other : NetroutemultipathSlice) -> NetroutemultipathSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutemultipathSlice::copy(self : NetroutemultipathSlice) -> NetroutemultipathSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathSlice::fill(self : NetroutemultipathSlice, v : Double) -> NetroutemultipathSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutemultipathSlice::min(self : NetroutemultipathSlice) -> Double { @_common.min(self.data) }

pub fn NetroutemultipathSlice::max(self : NetroutemultipathSlice) -> Double { @_common.max(self.data) }

pub fn NetroutemultipathSlice::to_string(self : NetroutemultipathSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

