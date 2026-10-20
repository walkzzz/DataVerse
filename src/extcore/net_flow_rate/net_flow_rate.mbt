///===
/// extcore/net_flow_rate

pub(all) struct NetflowratePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_rate_make_point(x : Double, y : Double) -> NetflowratePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_rate_make_point3(x : Double, y : Double, z : Double) -> NetflowratePoint {
  { x, y, z, label: 0 }
}

pub fn NetflowratePoint::x(self : NetflowratePoint) -> Double { self.x }

pub fn NetflowratePoint::y(self : NetflowratePoint) -> Double { self.y }

pub fn NetflowratePoint::z(self : NetflowratePoint) -> Double { self.z }

pub fn NetflowratePoint::label(self : NetflowratePoint) -> Int { self.label }

pub fn NetflowratePoint::dist(self : NetflowratePoint, other : NetflowratePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowratePoint::add(self : NetflowratePoint, other : NetflowratePoint) -> NetflowratePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowratePoint::sub(self : NetflowratePoint, other : NetflowratePoint) -> NetflowratePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowratePoint::scale(self : NetflowratePoint, s : Double) -> NetflowratePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowratePoint::dot(self : NetflowratePoint, other : NetflowratePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowratePoint::cross(self : NetflowratePoint, other : NetflowratePoint) -> NetflowratePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowratePoint::norm(self : NetflowratePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowratePoint::normalize(self : NetflowratePoint) -> NetflowratePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowratePoint::negate(self : NetflowratePoint) -> NetflowratePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowratePoint::mid(self : NetflowratePoint, other : NetflowratePoint) -> NetflowratePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowratePoint::lerp(self : NetflowratePoint, other : NetflowratePoint, t : Double) -> NetflowratePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowratePoint::to_string(self : NetflowratePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowrateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_rate_make_series(vals : Array[Double], name : String) -> NetflowrateSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowrateSeries::len(self : NetflowrateSeries) -> Int { self.vals.length() }

pub fn NetflowrateSeries::sum(self : NetflowrateSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowrateSeries::mean(self : NetflowrateSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowrateSeries::min(self : NetflowrateSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowrateSeries::max(self : NetflowrateSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowrateSeries::range(self : NetflowrateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowrateSeries::variance(self : NetflowrateSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowrateSeries::std(self : NetflowrateSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowrateSeries::median(self : NetflowrateSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowrateSeries::scale(self : NetflowrateSeries, f : Double) -> NetflowrateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowrateSeries::add(self : NetflowrateSeries, other : NetflowrateSeries) -> NetflowrateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowrateSeries::sub(self : NetflowrateSeries, other : NetflowrateSeries) -> NetflowrateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowrateSeries::normalize(self : NetflowrateSeries) -> NetflowrateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowrateSeries::cumsum(self : NetflowrateSeries) -> NetflowrateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowrateSeries::to_string(self : NetflowrateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowrateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_rate_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowrateMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn net_flow_rate_matrix_identity(n : Int) -> NetflowrateMatrix {
  let m = net_flow_rate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowrateMatrix::get(self : NetflowrateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowrateMatrix::transpose(self : NetflowrateMatrix) -> NetflowrateMatrix {
  let result = net_flow_rate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowrateMatrix::add(self : NetflowrateMatrix, other : NetflowrateMatrix) -> NetflowrateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_rate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowrateMatrix::scale(self : NetflowrateMatrix, s : Double) -> NetflowrateMatrix {
  let result = net_flow_rate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowrateMatrix::multiply(self : NetflowrateMatrix, other : NetflowrateMatrix) -> NetflowrateMatrix {
  if self.cols != other.rows { return net_flow_rate_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_rate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetflowrateMatrix::trace(self : NetflowrateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowrateMatrix::det(self : NetflowrateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowrateMatrix::norm(self : NetflowrateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowrateMatrix::to_string(self : NetflowrateMatrix) -> String {
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

pub(all) struct NetflowrateVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_rate_make_vector(comps : Array[Double]) -> NetflowrateVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_rate_vector_zero(dim : Int) -> NetflowrateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowrateVector::add(self : NetflowrateVector, other : NetflowrateVector) -> NetflowrateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowrateVector::sub(self : NetflowrateVector, other : NetflowrateVector) -> NetflowrateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowrateVector::scale(self : NetflowrateVector, s : Double) -> NetflowrateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowrateVector::dot(self : NetflowrateVector, other : NetflowrateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowrateVector::norm(self : NetflowrateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowrateVector::normalize(self : NetflowrateVector) -> NetflowrateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowrateVector::dist(self : NetflowrateVector, other : NetflowrateVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowrateVector::to_string(self : NetflowrateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowrateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_frame_make(size : Int) -> NetflowrateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateFrame::len(self : NetflowrateFrame) -> Int { self.size }

pub fn NetflowrateFrame::get(self : NetflowrateFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateFrame::set(self : NetflowrateFrame, i : Int, v : Double) -> NetflowrateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateFrame::sum(self : NetflowrateFrame) -> Double { @_common.sum(self.data) }

pub fn NetflowrateFrame::mean(self : NetflowrateFrame) -> Double { @_common.mean(self.data) }

pub fn NetflowrateFrame::scale(self : NetflowrateFrame, f : Double) -> NetflowrateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateFrame::add(self : NetflowrateFrame, other : NetflowrateFrame) -> NetflowrateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateFrame::copy(self : NetflowrateFrame) -> NetflowrateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateFrame::fill(self : NetflowrateFrame, v : Double) -> NetflowrateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateFrame::min(self : NetflowrateFrame) -> Double { @_common.min(self.data) }

pub fn NetflowrateFrame::max(self : NetflowrateFrame) -> Double { @_common.max(self.data) }

pub fn NetflowrateFrame::to_string(self : NetflowrateFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_table_make(size : Int) -> NetflowrateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateTable::len(self : NetflowrateTable) -> Int { self.size }

pub fn NetflowrateTable::get(self : NetflowrateTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateTable::set(self : NetflowrateTable, i : Int, v : Double) -> NetflowrateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateTable::sum(self : NetflowrateTable) -> Double { @_common.sum(self.data) }

pub fn NetflowrateTable::mean(self : NetflowrateTable) -> Double { @_common.mean(self.data) }

pub fn NetflowrateTable::scale(self : NetflowrateTable, f : Double) -> NetflowrateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateTable::add(self : NetflowrateTable, other : NetflowrateTable) -> NetflowrateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateTable::copy(self : NetflowrateTable) -> NetflowrateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateTable::fill(self : NetflowrateTable, v : Double) -> NetflowrateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateTable::min(self : NetflowrateTable) -> Double { @_common.min(self.data) }

pub fn NetflowrateTable::max(self : NetflowrateTable) -> Double { @_common.max(self.data) }

pub fn NetflowrateTable::to_string(self : NetflowrateTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_graphn_make(size : Int) -> NetflowrateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateGraphN::len(self : NetflowrateGraphN) -> Int { self.size }

pub fn NetflowrateGraphN::get(self : NetflowrateGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateGraphN::set(self : NetflowrateGraphN, i : Int, v : Double) -> NetflowrateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateGraphN::sum(self : NetflowrateGraphN) -> Double { @_common.sum(self.data) }

pub fn NetflowrateGraphN::mean(self : NetflowrateGraphN) -> Double { @_common.mean(self.data) }

pub fn NetflowrateGraphN::scale(self : NetflowrateGraphN, f : Double) -> NetflowrateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateGraphN::add(self : NetflowrateGraphN, other : NetflowrateGraphN) -> NetflowrateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateGraphN::copy(self : NetflowrateGraphN) -> NetflowrateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateGraphN::fill(self : NetflowrateGraphN, v : Double) -> NetflowrateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateGraphN::min(self : NetflowrateGraphN) -> Double { @_common.min(self.data) }

pub fn NetflowrateGraphN::max(self : NetflowrateGraphN) -> Double { @_common.max(self.data) }

pub fn NetflowrateGraphN::to_string(self : NetflowrateGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_node_make(size : Int) -> NetflowrateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateNode::len(self : NetflowrateNode) -> Int { self.size }

pub fn NetflowrateNode::get(self : NetflowrateNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateNode::set(self : NetflowrateNode, i : Int, v : Double) -> NetflowrateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateNode::sum(self : NetflowrateNode) -> Double { @_common.sum(self.data) }

pub fn NetflowrateNode::mean(self : NetflowrateNode) -> Double { @_common.mean(self.data) }

pub fn NetflowrateNode::scale(self : NetflowrateNode, f : Double) -> NetflowrateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateNode::add(self : NetflowrateNode, other : NetflowrateNode) -> NetflowrateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateNode::copy(self : NetflowrateNode) -> NetflowrateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateNode::fill(self : NetflowrateNode, v : Double) -> NetflowrateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateNode::min(self : NetflowrateNode) -> Double { @_common.min(self.data) }

pub fn NetflowrateNode::max(self : NetflowrateNode) -> Double { @_common.max(self.data) }

pub fn NetflowrateNode::to_string(self : NetflowrateNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_edge_make(size : Int) -> NetflowrateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateEdge::len(self : NetflowrateEdge) -> Int { self.size }

pub fn NetflowrateEdge::get(self : NetflowrateEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateEdge::set(self : NetflowrateEdge, i : Int, v : Double) -> NetflowrateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateEdge::sum(self : NetflowrateEdge) -> Double { @_common.sum(self.data) }

pub fn NetflowrateEdge::mean(self : NetflowrateEdge) -> Double { @_common.mean(self.data) }

pub fn NetflowrateEdge::scale(self : NetflowrateEdge, f : Double) -> NetflowrateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateEdge::add(self : NetflowrateEdge, other : NetflowrateEdge) -> NetflowrateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateEdge::copy(self : NetflowrateEdge) -> NetflowrateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateEdge::fill(self : NetflowrateEdge, v : Double) -> NetflowrateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateEdge::min(self : NetflowrateEdge) -> Double { @_common.min(self.data) }

pub fn NetflowrateEdge::max(self : NetflowrateEdge) -> Double { @_common.max(self.data) }

pub fn NetflowrateEdge::to_string(self : NetflowrateEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowratePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_path_make(size : Int) -> NetflowratePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowratePath::len(self : NetflowratePath) -> Int { self.size }

pub fn NetflowratePath::get(self : NetflowratePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowratePath::set(self : NetflowratePath, i : Int, v : Double) -> NetflowratePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowratePath::sum(self : NetflowratePath) -> Double { @_common.sum(self.data) }

pub fn NetflowratePath::mean(self : NetflowratePath) -> Double { @_common.mean(self.data) }

pub fn NetflowratePath::scale(self : NetflowratePath, f : Double) -> NetflowratePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowratePath::add(self : NetflowratePath, other : NetflowratePath) -> NetflowratePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowratePath::copy(self : NetflowratePath) -> NetflowratePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowratePath::fill(self : NetflowratePath, v : Double) -> NetflowratePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowratePath::min(self : NetflowratePath) -> Double { @_common.min(self.data) }

pub fn NetflowratePath::max(self : NetflowratePath) -> Double { @_common.max(self.data) }

pub fn NetflowratePath::to_string(self : NetflowratePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_cluster_make(size : Int) -> NetflowrateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateCluster::len(self : NetflowrateCluster) -> Int { self.size }

pub fn NetflowrateCluster::get(self : NetflowrateCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateCluster::set(self : NetflowrateCluster, i : Int, v : Double) -> NetflowrateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateCluster::sum(self : NetflowrateCluster) -> Double { @_common.sum(self.data) }

pub fn NetflowrateCluster::mean(self : NetflowrateCluster) -> Double { @_common.mean(self.data) }

pub fn NetflowrateCluster::scale(self : NetflowrateCluster, f : Double) -> NetflowrateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateCluster::add(self : NetflowrateCluster, other : NetflowrateCluster) -> NetflowrateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateCluster::copy(self : NetflowrateCluster) -> NetflowrateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateCluster::fill(self : NetflowrateCluster, v : Double) -> NetflowrateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateCluster::min(self : NetflowrateCluster) -> Double { @_common.min(self.data) }

pub fn NetflowrateCluster::max(self : NetflowrateCluster) -> Double { @_common.max(self.data) }

pub fn NetflowrateCluster::to_string(self : NetflowrateCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_model_make(size : Int) -> NetflowrateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateModel::len(self : NetflowrateModel) -> Int { self.size }

pub fn NetflowrateModel::get(self : NetflowrateModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateModel::set(self : NetflowrateModel, i : Int, v : Double) -> NetflowrateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateModel::sum(self : NetflowrateModel) -> Double { @_common.sum(self.data) }

pub fn NetflowrateModel::mean(self : NetflowrateModel) -> Double { @_common.mean(self.data) }

pub fn NetflowrateModel::scale(self : NetflowrateModel, f : Double) -> NetflowrateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateModel::add(self : NetflowrateModel, other : NetflowrateModel) -> NetflowrateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateModel::copy(self : NetflowrateModel) -> NetflowrateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateModel::fill(self : NetflowrateModel, v : Double) -> NetflowrateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateModel::min(self : NetflowrateModel) -> Double { @_common.min(self.data) }

pub fn NetflowrateModel::max(self : NetflowrateModel) -> Double { @_common.max(self.data) }

pub fn NetflowrateModel::to_string(self : NetflowrateModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_layer_make(size : Int) -> NetflowrateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateLayer::len(self : NetflowrateLayer) -> Int { self.size }

pub fn NetflowrateLayer::get(self : NetflowrateLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateLayer::set(self : NetflowrateLayer, i : Int, v : Double) -> NetflowrateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateLayer::sum(self : NetflowrateLayer) -> Double { @_common.sum(self.data) }

pub fn NetflowrateLayer::mean(self : NetflowrateLayer) -> Double { @_common.mean(self.data) }

pub fn NetflowrateLayer::scale(self : NetflowrateLayer, f : Double) -> NetflowrateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateLayer::add(self : NetflowrateLayer, other : NetflowrateLayer) -> NetflowrateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateLayer::copy(self : NetflowrateLayer) -> NetflowrateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateLayer::fill(self : NetflowrateLayer, v : Double) -> NetflowrateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateLayer::min(self : NetflowrateLayer) -> Double { @_common.min(self.data) }

pub fn NetflowrateLayer::max(self : NetflowrateLayer) -> Double { @_common.max(self.data) }

pub fn NetflowrateLayer::to_string(self : NetflowrateLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_buffer_make(size : Int) -> NetflowrateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateBuffer::len(self : NetflowrateBuffer) -> Int { self.size }

pub fn NetflowrateBuffer::get(self : NetflowrateBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateBuffer::set(self : NetflowrateBuffer, i : Int, v : Double) -> NetflowrateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateBuffer::sum(self : NetflowrateBuffer) -> Double { @_common.sum(self.data) }

pub fn NetflowrateBuffer::mean(self : NetflowrateBuffer) -> Double { @_common.mean(self.data) }

pub fn NetflowrateBuffer::scale(self : NetflowrateBuffer, f : Double) -> NetflowrateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateBuffer::add(self : NetflowrateBuffer, other : NetflowrateBuffer) -> NetflowrateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateBuffer::copy(self : NetflowrateBuffer) -> NetflowrateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateBuffer::fill(self : NetflowrateBuffer, v : Double) -> NetflowrateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateBuffer::min(self : NetflowrateBuffer) -> Double { @_common.min(self.data) }

pub fn NetflowrateBuffer::max(self : NetflowrateBuffer) -> Double { @_common.max(self.data) }

pub fn NetflowrateBuffer::to_string(self : NetflowrateBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_cursor_make(size : Int) -> NetflowrateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateCursor::len(self : NetflowrateCursor) -> Int { self.size }

pub fn NetflowrateCursor::get(self : NetflowrateCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateCursor::set(self : NetflowrateCursor, i : Int, v : Double) -> NetflowrateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateCursor::sum(self : NetflowrateCursor) -> Double { @_common.sum(self.data) }

pub fn NetflowrateCursor::mean(self : NetflowrateCursor) -> Double { @_common.mean(self.data) }

pub fn NetflowrateCursor::scale(self : NetflowrateCursor, f : Double) -> NetflowrateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateCursor::add(self : NetflowrateCursor, other : NetflowrateCursor) -> NetflowrateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateCursor::copy(self : NetflowrateCursor) -> NetflowrateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateCursor::fill(self : NetflowrateCursor, v : Double) -> NetflowrateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateCursor::min(self : NetflowrateCursor) -> Double { @_common.min(self.data) }

pub fn NetflowrateCursor::max(self : NetflowrateCursor) -> Double { @_common.max(self.data) }

pub fn NetflowrateCursor::to_string(self : NetflowrateCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_view_make(size : Int) -> NetflowrateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateView::len(self : NetflowrateView) -> Int { self.size }

pub fn NetflowrateView::get(self : NetflowrateView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateView::set(self : NetflowrateView, i : Int, v : Double) -> NetflowrateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateView::sum(self : NetflowrateView) -> Double { @_common.sum(self.data) }

pub fn NetflowrateView::mean(self : NetflowrateView) -> Double { @_common.mean(self.data) }

pub fn NetflowrateView::scale(self : NetflowrateView, f : Double) -> NetflowrateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateView::add(self : NetflowrateView, other : NetflowrateView) -> NetflowrateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateView::copy(self : NetflowrateView) -> NetflowrateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateView::fill(self : NetflowrateView, v : Double) -> NetflowrateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateView::min(self : NetflowrateView) -> Double { @_common.min(self.data) }

pub fn NetflowrateView::max(self : NetflowrateView) -> Double { @_common.max(self.data) }

pub fn NetflowrateView::to_string(self : NetflowrateView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_range_make(size : Int) -> NetflowrateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateRange::len(self : NetflowrateRange) -> Int { self.size }

pub fn NetflowrateRange::get(self : NetflowrateRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateRange::set(self : NetflowrateRange, i : Int, v : Double) -> NetflowrateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateRange::sum(self : NetflowrateRange) -> Double { @_common.sum(self.data) }

pub fn NetflowrateRange::mean(self : NetflowrateRange) -> Double { @_common.mean(self.data) }

pub fn NetflowrateRange::scale(self : NetflowrateRange, f : Double) -> NetflowrateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateRange::add(self : NetflowrateRange, other : NetflowrateRange) -> NetflowrateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateRange::copy(self : NetflowrateRange) -> NetflowrateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateRange::fill(self : NetflowrateRange, v : Double) -> NetflowrateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateRange::min(self : NetflowrateRange) -> Double { @_common.min(self.data) }

pub fn NetflowrateRange::max(self : NetflowrateRange) -> Double { @_common.max(self.data) }

pub fn NetflowrateRange::to_string(self : NetflowrateRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowrateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_slice_make(size : Int) -> NetflowrateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowrateSlice::len(self : NetflowrateSlice) -> Int { self.size }

pub fn NetflowrateSlice::get(self : NetflowrateSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowrateSlice::set(self : NetflowrateSlice, i : Int, v : Double) -> NetflowrateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowrateSlice::sum(self : NetflowrateSlice) -> Double { @_common.sum(self.data) }

pub fn NetflowrateSlice::mean(self : NetflowrateSlice) -> Double { @_common.mean(self.data) }

pub fn NetflowrateSlice::scale(self : NetflowrateSlice, f : Double) -> NetflowrateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowrateSlice::add(self : NetflowrateSlice, other : NetflowrateSlice) -> NetflowrateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowrateSlice::copy(self : NetflowrateSlice) -> NetflowrateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowrateSlice::fill(self : NetflowrateSlice, v : Double) -> NetflowrateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowrateSlice::min(self : NetflowrateSlice) -> Double { @_common.min(self.data) }

pub fn NetflowrateSlice::max(self : NetflowrateSlice) -> Double { @_common.max(self.data) }

pub fn NetflowrateSlice::to_string(self : NetflowrateSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

