///===
/// extcore/net_route_static

pub(all) struct NetroutestaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_static_make_point(x : Double, y : Double) -> NetroutestaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_static_make_point3(x : Double, y : Double, z : Double) -> NetroutestaticPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutestaticPoint::x(self : NetroutestaticPoint) -> Double { self.x }

pub fn NetroutestaticPoint::y(self : NetroutestaticPoint) -> Double { self.y }

pub fn NetroutestaticPoint::z(self : NetroutestaticPoint) -> Double { self.z }

pub fn NetroutestaticPoint::label(self : NetroutestaticPoint) -> Int { self.label }

pub fn NetroutestaticPoint::dist(self : NetroutestaticPoint, other : NetroutestaticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutestaticPoint::add(self : NetroutestaticPoint, other : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutestaticPoint::sub(self : NetroutestaticPoint, other : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutestaticPoint::scale(self : NetroutestaticPoint, s : Double) -> NetroutestaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutestaticPoint::dot(self : NetroutestaticPoint, other : NetroutestaticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutestaticPoint::cross(self : NetroutestaticPoint, other : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutestaticPoint::norm(self : NetroutestaticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutestaticPoint::normalize(self : NetroutestaticPoint) -> NetroutestaticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutestaticPoint::negate(self : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutestaticPoint::mid(self : NetroutestaticPoint, other : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutestaticPoint::lerp(self : NetroutestaticPoint, other : NetroutestaticPoint, t : Double) -> NetroutestaticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutestaticPoint::to_string(self : NetroutestaticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutestaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_static_make_series(vals : Array[Double], name : String) -> NetroutestaticSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutestaticSeries::len(self : NetroutestaticSeries) -> Int { self.vals.length() }

pub fn NetroutestaticSeries::sum(self : NetroutestaticSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutestaticSeries::mean(self : NetroutestaticSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutestaticSeries::min(self : NetroutestaticSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutestaticSeries::max(self : NetroutestaticSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutestaticSeries::range(self : NetroutestaticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutestaticSeries::variance(self : NetroutestaticSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutestaticSeries::std(self : NetroutestaticSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutestaticSeries::median(self : NetroutestaticSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutestaticSeries::scale(self : NetroutestaticSeries, f : Double) -> NetroutestaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutestaticSeries::add(self : NetroutestaticSeries, other : NetroutestaticSeries) -> NetroutestaticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutestaticSeries::sub(self : NetroutestaticSeries, other : NetroutestaticSeries) -> NetroutestaticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutestaticSeries::normalize(self : NetroutestaticSeries) -> NetroutestaticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutestaticSeries::cumsum(self : NetroutestaticSeries) -> NetroutestaticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutestaticSeries::to_string(self : NetroutestaticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutestaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_static_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutestaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_static_matrix_identity(n : Int) -> NetroutestaticMatrix {
  let m = net_route_static_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutestaticMatrix::get(self : NetroutestaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutestaticMatrix::transpose(self : NetroutestaticMatrix) -> NetroutestaticMatrix {
  let result = net_route_static_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutestaticMatrix::add(self : NetroutestaticMatrix, other : NetroutestaticMatrix) -> NetroutestaticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_static_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutestaticMatrix::scale(self : NetroutestaticMatrix, s : Double) -> NetroutestaticMatrix {
  let result = net_route_static_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutestaticMatrix::multiply(self : NetroutestaticMatrix, other : NetroutestaticMatrix) -> NetroutestaticMatrix {
  if self.cols != other.rows { return net_route_static_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_static_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetroutestaticMatrix::trace(self : NetroutestaticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutestaticMatrix::det(self : NetroutestaticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutestaticMatrix::norm(self : NetroutestaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutestaticMatrix::to_string(self : NetroutestaticMatrix) -> String {
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

pub(all) struct NetroutestaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_static_make_vector(comps : Array[Double]) -> NetroutestaticVector {
  { comps, dim: comps.length() }
}

pub fn net_route_static_vector_zero(dim : Int) -> NetroutestaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutestaticVector::add(self : NetroutestaticVector, other : NetroutestaticVector) -> NetroutestaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutestaticVector::sub(self : NetroutestaticVector, other : NetroutestaticVector) -> NetroutestaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutestaticVector::scale(self : NetroutestaticVector, s : Double) -> NetroutestaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutestaticVector::dot(self : NetroutestaticVector, other : NetroutestaticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutestaticVector::norm(self : NetroutestaticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutestaticVector::normalize(self : NetroutestaticVector) -> NetroutestaticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutestaticVector::dist(self : NetroutestaticVector, other : NetroutestaticVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutestaticVector::to_string(self : NetroutestaticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutestaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_frame_make(size : Int) -> NetroutestaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticFrame::len(self : NetroutestaticFrame) -> Int { self.size }

pub fn NetroutestaticFrame::get(self : NetroutestaticFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticFrame::set(self : NetroutestaticFrame, i : Int, v : Double) -> NetroutestaticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticFrame::sum(self : NetroutestaticFrame) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticFrame::mean(self : NetroutestaticFrame) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticFrame::scale(self : NetroutestaticFrame, f : Double) -> NetroutestaticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticFrame::add(self : NetroutestaticFrame, other : NetroutestaticFrame) -> NetroutestaticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticFrame::copy(self : NetroutestaticFrame) -> NetroutestaticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticFrame::fill(self : NetroutestaticFrame, v : Double) -> NetroutestaticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticFrame::min(self : NetroutestaticFrame) -> Double { @_common.min(self.data) }

pub fn NetroutestaticFrame::max(self : NetroutestaticFrame) -> Double { @_common.max(self.data) }

pub fn NetroutestaticFrame::to_string(self : NetroutestaticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_table_make(size : Int) -> NetroutestaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticTable::len(self : NetroutestaticTable) -> Int { self.size }

pub fn NetroutestaticTable::get(self : NetroutestaticTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticTable::set(self : NetroutestaticTable, i : Int, v : Double) -> NetroutestaticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticTable::sum(self : NetroutestaticTable) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticTable::mean(self : NetroutestaticTable) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticTable::scale(self : NetroutestaticTable, f : Double) -> NetroutestaticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticTable::add(self : NetroutestaticTable, other : NetroutestaticTable) -> NetroutestaticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticTable::copy(self : NetroutestaticTable) -> NetroutestaticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticTable::fill(self : NetroutestaticTable, v : Double) -> NetroutestaticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticTable::min(self : NetroutestaticTable) -> Double { @_common.min(self.data) }

pub fn NetroutestaticTable::max(self : NetroutestaticTable) -> Double { @_common.max(self.data) }

pub fn NetroutestaticTable::to_string(self : NetroutestaticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_graphn_make(size : Int) -> NetroutestaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticGraphN::len(self : NetroutestaticGraphN) -> Int { self.size }

pub fn NetroutestaticGraphN::get(self : NetroutestaticGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticGraphN::set(self : NetroutestaticGraphN, i : Int, v : Double) -> NetroutestaticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticGraphN::sum(self : NetroutestaticGraphN) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticGraphN::mean(self : NetroutestaticGraphN) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticGraphN::scale(self : NetroutestaticGraphN, f : Double) -> NetroutestaticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticGraphN::add(self : NetroutestaticGraphN, other : NetroutestaticGraphN) -> NetroutestaticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticGraphN::copy(self : NetroutestaticGraphN) -> NetroutestaticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticGraphN::fill(self : NetroutestaticGraphN, v : Double) -> NetroutestaticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticGraphN::min(self : NetroutestaticGraphN) -> Double { @_common.min(self.data) }

pub fn NetroutestaticGraphN::max(self : NetroutestaticGraphN) -> Double { @_common.max(self.data) }

pub fn NetroutestaticGraphN::to_string(self : NetroutestaticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_node_make(size : Int) -> NetroutestaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticNode::len(self : NetroutestaticNode) -> Int { self.size }

pub fn NetroutestaticNode::get(self : NetroutestaticNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticNode::set(self : NetroutestaticNode, i : Int, v : Double) -> NetroutestaticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticNode::sum(self : NetroutestaticNode) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticNode::mean(self : NetroutestaticNode) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticNode::scale(self : NetroutestaticNode, f : Double) -> NetroutestaticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticNode::add(self : NetroutestaticNode, other : NetroutestaticNode) -> NetroutestaticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticNode::copy(self : NetroutestaticNode) -> NetroutestaticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticNode::fill(self : NetroutestaticNode, v : Double) -> NetroutestaticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticNode::min(self : NetroutestaticNode) -> Double { @_common.min(self.data) }

pub fn NetroutestaticNode::max(self : NetroutestaticNode) -> Double { @_common.max(self.data) }

pub fn NetroutestaticNode::to_string(self : NetroutestaticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_edge_make(size : Int) -> NetroutestaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticEdge::len(self : NetroutestaticEdge) -> Int { self.size }

pub fn NetroutestaticEdge::get(self : NetroutestaticEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticEdge::set(self : NetroutestaticEdge, i : Int, v : Double) -> NetroutestaticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticEdge::sum(self : NetroutestaticEdge) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticEdge::mean(self : NetroutestaticEdge) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticEdge::scale(self : NetroutestaticEdge, f : Double) -> NetroutestaticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticEdge::add(self : NetroutestaticEdge, other : NetroutestaticEdge) -> NetroutestaticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticEdge::copy(self : NetroutestaticEdge) -> NetroutestaticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticEdge::fill(self : NetroutestaticEdge, v : Double) -> NetroutestaticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticEdge::min(self : NetroutestaticEdge) -> Double { @_common.min(self.data) }

pub fn NetroutestaticEdge::max(self : NetroutestaticEdge) -> Double { @_common.max(self.data) }

pub fn NetroutestaticEdge::to_string(self : NetroutestaticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_path_make(size : Int) -> NetroutestaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticPath::len(self : NetroutestaticPath) -> Int { self.size }

pub fn NetroutestaticPath::get(self : NetroutestaticPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticPath::set(self : NetroutestaticPath, i : Int, v : Double) -> NetroutestaticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticPath::sum(self : NetroutestaticPath) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticPath::mean(self : NetroutestaticPath) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticPath::scale(self : NetroutestaticPath, f : Double) -> NetroutestaticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticPath::add(self : NetroutestaticPath, other : NetroutestaticPath) -> NetroutestaticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticPath::copy(self : NetroutestaticPath) -> NetroutestaticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticPath::fill(self : NetroutestaticPath, v : Double) -> NetroutestaticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticPath::min(self : NetroutestaticPath) -> Double { @_common.min(self.data) }

pub fn NetroutestaticPath::max(self : NetroutestaticPath) -> Double { @_common.max(self.data) }

pub fn NetroutestaticPath::to_string(self : NetroutestaticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_cluster_make(size : Int) -> NetroutestaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticCluster::len(self : NetroutestaticCluster) -> Int { self.size }

pub fn NetroutestaticCluster::get(self : NetroutestaticCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticCluster::set(self : NetroutestaticCluster, i : Int, v : Double) -> NetroutestaticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticCluster::sum(self : NetroutestaticCluster) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticCluster::mean(self : NetroutestaticCluster) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticCluster::scale(self : NetroutestaticCluster, f : Double) -> NetroutestaticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticCluster::add(self : NetroutestaticCluster, other : NetroutestaticCluster) -> NetroutestaticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticCluster::copy(self : NetroutestaticCluster) -> NetroutestaticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticCluster::fill(self : NetroutestaticCluster, v : Double) -> NetroutestaticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticCluster::min(self : NetroutestaticCluster) -> Double { @_common.min(self.data) }

pub fn NetroutestaticCluster::max(self : NetroutestaticCluster) -> Double { @_common.max(self.data) }

pub fn NetroutestaticCluster::to_string(self : NetroutestaticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_model_make(size : Int) -> NetroutestaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticModel::len(self : NetroutestaticModel) -> Int { self.size }

pub fn NetroutestaticModel::get(self : NetroutestaticModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticModel::set(self : NetroutestaticModel, i : Int, v : Double) -> NetroutestaticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticModel::sum(self : NetroutestaticModel) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticModel::mean(self : NetroutestaticModel) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticModel::scale(self : NetroutestaticModel, f : Double) -> NetroutestaticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticModel::add(self : NetroutestaticModel, other : NetroutestaticModel) -> NetroutestaticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticModel::copy(self : NetroutestaticModel) -> NetroutestaticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticModel::fill(self : NetroutestaticModel, v : Double) -> NetroutestaticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticModel::min(self : NetroutestaticModel) -> Double { @_common.min(self.data) }

pub fn NetroutestaticModel::max(self : NetroutestaticModel) -> Double { @_common.max(self.data) }

pub fn NetroutestaticModel::to_string(self : NetroutestaticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_layer_make(size : Int) -> NetroutestaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticLayer::len(self : NetroutestaticLayer) -> Int { self.size }

pub fn NetroutestaticLayer::get(self : NetroutestaticLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticLayer::set(self : NetroutestaticLayer, i : Int, v : Double) -> NetroutestaticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticLayer::sum(self : NetroutestaticLayer) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticLayer::mean(self : NetroutestaticLayer) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticLayer::scale(self : NetroutestaticLayer, f : Double) -> NetroutestaticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticLayer::add(self : NetroutestaticLayer, other : NetroutestaticLayer) -> NetroutestaticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticLayer::copy(self : NetroutestaticLayer) -> NetroutestaticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticLayer::fill(self : NetroutestaticLayer, v : Double) -> NetroutestaticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticLayer::min(self : NetroutestaticLayer) -> Double { @_common.min(self.data) }

pub fn NetroutestaticLayer::max(self : NetroutestaticLayer) -> Double { @_common.max(self.data) }

pub fn NetroutestaticLayer::to_string(self : NetroutestaticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_buffer_make(size : Int) -> NetroutestaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticBuffer::len(self : NetroutestaticBuffer) -> Int { self.size }

pub fn NetroutestaticBuffer::get(self : NetroutestaticBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticBuffer::set(self : NetroutestaticBuffer, i : Int, v : Double) -> NetroutestaticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticBuffer::sum(self : NetroutestaticBuffer) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticBuffer::mean(self : NetroutestaticBuffer) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticBuffer::scale(self : NetroutestaticBuffer, f : Double) -> NetroutestaticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticBuffer::add(self : NetroutestaticBuffer, other : NetroutestaticBuffer) -> NetroutestaticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticBuffer::copy(self : NetroutestaticBuffer) -> NetroutestaticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticBuffer::fill(self : NetroutestaticBuffer, v : Double) -> NetroutestaticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticBuffer::min(self : NetroutestaticBuffer) -> Double { @_common.min(self.data) }

pub fn NetroutestaticBuffer::max(self : NetroutestaticBuffer) -> Double { @_common.max(self.data) }

pub fn NetroutestaticBuffer::to_string(self : NetroutestaticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_cursor_make(size : Int) -> NetroutestaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticCursor::len(self : NetroutestaticCursor) -> Int { self.size }

pub fn NetroutestaticCursor::get(self : NetroutestaticCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticCursor::set(self : NetroutestaticCursor, i : Int, v : Double) -> NetroutestaticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticCursor::sum(self : NetroutestaticCursor) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticCursor::mean(self : NetroutestaticCursor) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticCursor::scale(self : NetroutestaticCursor, f : Double) -> NetroutestaticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticCursor::add(self : NetroutestaticCursor, other : NetroutestaticCursor) -> NetroutestaticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticCursor::copy(self : NetroutestaticCursor) -> NetroutestaticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticCursor::fill(self : NetroutestaticCursor, v : Double) -> NetroutestaticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticCursor::min(self : NetroutestaticCursor) -> Double { @_common.min(self.data) }

pub fn NetroutestaticCursor::max(self : NetroutestaticCursor) -> Double { @_common.max(self.data) }

pub fn NetroutestaticCursor::to_string(self : NetroutestaticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_view_make(size : Int) -> NetroutestaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticView::len(self : NetroutestaticView) -> Int { self.size }

pub fn NetroutestaticView::get(self : NetroutestaticView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticView::set(self : NetroutestaticView, i : Int, v : Double) -> NetroutestaticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticView::sum(self : NetroutestaticView) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticView::mean(self : NetroutestaticView) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticView::scale(self : NetroutestaticView, f : Double) -> NetroutestaticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticView::add(self : NetroutestaticView, other : NetroutestaticView) -> NetroutestaticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticView::copy(self : NetroutestaticView) -> NetroutestaticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticView::fill(self : NetroutestaticView, v : Double) -> NetroutestaticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticView::min(self : NetroutestaticView) -> Double { @_common.min(self.data) }

pub fn NetroutestaticView::max(self : NetroutestaticView) -> Double { @_common.max(self.data) }

pub fn NetroutestaticView::to_string(self : NetroutestaticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_range_make(size : Int) -> NetroutestaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticRange::len(self : NetroutestaticRange) -> Int { self.size }

pub fn NetroutestaticRange::get(self : NetroutestaticRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticRange::set(self : NetroutestaticRange, i : Int, v : Double) -> NetroutestaticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticRange::sum(self : NetroutestaticRange) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticRange::mean(self : NetroutestaticRange) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticRange::scale(self : NetroutestaticRange, f : Double) -> NetroutestaticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticRange::add(self : NetroutestaticRange, other : NetroutestaticRange) -> NetroutestaticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticRange::copy(self : NetroutestaticRange) -> NetroutestaticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticRange::fill(self : NetroutestaticRange, v : Double) -> NetroutestaticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticRange::min(self : NetroutestaticRange) -> Double { @_common.min(self.data) }

pub fn NetroutestaticRange::max(self : NetroutestaticRange) -> Double { @_common.max(self.data) }

pub fn NetroutestaticRange::to_string(self : NetroutestaticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutestaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_slice_make(size : Int) -> NetroutestaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutestaticSlice::len(self : NetroutestaticSlice) -> Int { self.size }

pub fn NetroutestaticSlice::get(self : NetroutestaticSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutestaticSlice::set(self : NetroutestaticSlice, i : Int, v : Double) -> NetroutestaticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutestaticSlice::sum(self : NetroutestaticSlice) -> Double { @_common.sum(self.data) }

pub fn NetroutestaticSlice::mean(self : NetroutestaticSlice) -> Double { @_common.mean(self.data) }

pub fn NetroutestaticSlice::scale(self : NetroutestaticSlice, f : Double) -> NetroutestaticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutestaticSlice::add(self : NetroutestaticSlice, other : NetroutestaticSlice) -> NetroutestaticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutestaticSlice::copy(self : NetroutestaticSlice) -> NetroutestaticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutestaticSlice::fill(self : NetroutestaticSlice, v : Double) -> NetroutestaticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutestaticSlice::min(self : NetroutestaticSlice) -> Double { @_common.min(self.data) }

pub fn NetroutestaticSlice::max(self : NetroutestaticSlice) -> Double { @_common.max(self.data) }

pub fn NetroutestaticSlice::to_string(self : NetroutestaticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

