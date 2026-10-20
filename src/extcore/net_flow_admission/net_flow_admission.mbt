///===
/// extcore/net_flow_admission

pub(all) struct NetflowadmissionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_admission_make_point(x : Double, y : Double) -> NetflowadmissionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_admission_make_point3(x : Double, y : Double, z : Double) -> NetflowadmissionPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowadmissionPoint::x(self : NetflowadmissionPoint) -> Double { self.x }

pub fn NetflowadmissionPoint::y(self : NetflowadmissionPoint) -> Double { self.y }

pub fn NetflowadmissionPoint::z(self : NetflowadmissionPoint) -> Double { self.z }

pub fn NetflowadmissionPoint::label(self : NetflowadmissionPoint) -> Int { self.label }

pub fn NetflowadmissionPoint::dist(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowadmissionPoint::add(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowadmissionPoint::sub(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowadmissionPoint::scale(self : NetflowadmissionPoint, s : Double) -> NetflowadmissionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowadmissionPoint::dot(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowadmissionPoint::cross(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowadmissionPoint::norm(self : NetflowadmissionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowadmissionPoint::normalize(self : NetflowadmissionPoint) -> NetflowadmissionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowadmissionPoint::negate(self : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowadmissionPoint::mid(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowadmissionPoint::lerp(self : NetflowadmissionPoint, other : NetflowadmissionPoint, t : Double) -> NetflowadmissionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowadmissionPoint::to_string(self : NetflowadmissionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowadmissionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_admission_make_series(vals : Array[Double], name : String) -> NetflowadmissionSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowadmissionSeries::len(self : NetflowadmissionSeries) -> Int { self.vals.length() }

pub fn NetflowadmissionSeries::sum(self : NetflowadmissionSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowadmissionSeries::mean(self : NetflowadmissionSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowadmissionSeries::min(self : NetflowadmissionSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowadmissionSeries::max(self : NetflowadmissionSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowadmissionSeries::range(self : NetflowadmissionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowadmissionSeries::variance(self : NetflowadmissionSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowadmissionSeries::std(self : NetflowadmissionSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowadmissionSeries::median(self : NetflowadmissionSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowadmissionSeries::scale(self : NetflowadmissionSeries, f : Double) -> NetflowadmissionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowadmissionSeries::add(self : NetflowadmissionSeries, other : NetflowadmissionSeries) -> NetflowadmissionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowadmissionSeries::sub(self : NetflowadmissionSeries, other : NetflowadmissionSeries) -> NetflowadmissionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowadmissionSeries::normalize(self : NetflowadmissionSeries) -> NetflowadmissionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowadmissionSeries::cumsum(self : NetflowadmissionSeries) -> NetflowadmissionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowadmissionSeries::to_string(self : NetflowadmissionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowadmissionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_admission_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowadmissionMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn net_flow_admission_matrix_identity(n : Int) -> NetflowadmissionMatrix {
  let m = net_flow_admission_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowadmissionMatrix::get(self : NetflowadmissionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowadmissionMatrix::transpose(self : NetflowadmissionMatrix) -> NetflowadmissionMatrix {
  let result = net_flow_admission_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowadmissionMatrix::add(self : NetflowadmissionMatrix, other : NetflowadmissionMatrix) -> NetflowadmissionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_admission_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowadmissionMatrix::scale(self : NetflowadmissionMatrix, s : Double) -> NetflowadmissionMatrix {
  let result = net_flow_admission_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowadmissionMatrix::multiply(self : NetflowadmissionMatrix, other : NetflowadmissionMatrix) -> NetflowadmissionMatrix {
  if self.cols != other.rows { return net_flow_admission_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_admission_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetflowadmissionMatrix::trace(self : NetflowadmissionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowadmissionMatrix::det(self : NetflowadmissionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowadmissionMatrix::norm(self : NetflowadmissionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowadmissionMatrix::to_string(self : NetflowadmissionMatrix) -> String {
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

pub(all) struct NetflowadmissionVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_admission_make_vector(comps : Array[Double]) -> NetflowadmissionVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_admission_vector_zero(dim : Int) -> NetflowadmissionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowadmissionVector::add(self : NetflowadmissionVector, other : NetflowadmissionVector) -> NetflowadmissionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowadmissionVector::sub(self : NetflowadmissionVector, other : NetflowadmissionVector) -> NetflowadmissionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowadmissionVector::scale(self : NetflowadmissionVector, s : Double) -> NetflowadmissionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowadmissionVector::dot(self : NetflowadmissionVector, other : NetflowadmissionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowadmissionVector::norm(self : NetflowadmissionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowadmissionVector::normalize(self : NetflowadmissionVector) -> NetflowadmissionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowadmissionVector::dist(self : NetflowadmissionVector, other : NetflowadmissionVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowadmissionVector::to_string(self : NetflowadmissionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowadmissionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_frame_make(size : Int) -> NetflowadmissionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionFrame::len(self : NetflowadmissionFrame) -> Int { self.size }

pub fn NetflowadmissionFrame::get(self : NetflowadmissionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionFrame::set(self : NetflowadmissionFrame, i : Int, v : Double) -> NetflowadmissionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionFrame::sum(self : NetflowadmissionFrame) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionFrame::mean(self : NetflowadmissionFrame) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionFrame::scale(self : NetflowadmissionFrame, f : Double) -> NetflowadmissionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionFrame::add(self : NetflowadmissionFrame, other : NetflowadmissionFrame) -> NetflowadmissionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionFrame::copy(self : NetflowadmissionFrame) -> NetflowadmissionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionFrame::fill(self : NetflowadmissionFrame, v : Double) -> NetflowadmissionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionFrame::min(self : NetflowadmissionFrame) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionFrame::max(self : NetflowadmissionFrame) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionFrame::to_string(self : NetflowadmissionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_table_make(size : Int) -> NetflowadmissionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionTable::len(self : NetflowadmissionTable) -> Int { self.size }

pub fn NetflowadmissionTable::get(self : NetflowadmissionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionTable::set(self : NetflowadmissionTable, i : Int, v : Double) -> NetflowadmissionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionTable::sum(self : NetflowadmissionTable) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionTable::mean(self : NetflowadmissionTable) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionTable::scale(self : NetflowadmissionTable, f : Double) -> NetflowadmissionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionTable::add(self : NetflowadmissionTable, other : NetflowadmissionTable) -> NetflowadmissionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionTable::copy(self : NetflowadmissionTable) -> NetflowadmissionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionTable::fill(self : NetflowadmissionTable, v : Double) -> NetflowadmissionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionTable::min(self : NetflowadmissionTable) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionTable::max(self : NetflowadmissionTable) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionTable::to_string(self : NetflowadmissionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_graphn_make(size : Int) -> NetflowadmissionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionGraphN::len(self : NetflowadmissionGraphN) -> Int { self.size }

pub fn NetflowadmissionGraphN::get(self : NetflowadmissionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionGraphN::set(self : NetflowadmissionGraphN, i : Int, v : Double) -> NetflowadmissionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionGraphN::sum(self : NetflowadmissionGraphN) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionGraphN::mean(self : NetflowadmissionGraphN) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionGraphN::scale(self : NetflowadmissionGraphN, f : Double) -> NetflowadmissionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionGraphN::add(self : NetflowadmissionGraphN, other : NetflowadmissionGraphN) -> NetflowadmissionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionGraphN::copy(self : NetflowadmissionGraphN) -> NetflowadmissionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionGraphN::fill(self : NetflowadmissionGraphN, v : Double) -> NetflowadmissionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionGraphN::min(self : NetflowadmissionGraphN) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionGraphN::max(self : NetflowadmissionGraphN) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionGraphN::to_string(self : NetflowadmissionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_node_make(size : Int) -> NetflowadmissionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionNode::len(self : NetflowadmissionNode) -> Int { self.size }

pub fn NetflowadmissionNode::get(self : NetflowadmissionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionNode::set(self : NetflowadmissionNode, i : Int, v : Double) -> NetflowadmissionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionNode::sum(self : NetflowadmissionNode) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionNode::mean(self : NetflowadmissionNode) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionNode::scale(self : NetflowadmissionNode, f : Double) -> NetflowadmissionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionNode::add(self : NetflowadmissionNode, other : NetflowadmissionNode) -> NetflowadmissionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionNode::copy(self : NetflowadmissionNode) -> NetflowadmissionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionNode::fill(self : NetflowadmissionNode, v : Double) -> NetflowadmissionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionNode::min(self : NetflowadmissionNode) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionNode::max(self : NetflowadmissionNode) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionNode::to_string(self : NetflowadmissionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_edge_make(size : Int) -> NetflowadmissionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionEdge::len(self : NetflowadmissionEdge) -> Int { self.size }

pub fn NetflowadmissionEdge::get(self : NetflowadmissionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionEdge::set(self : NetflowadmissionEdge, i : Int, v : Double) -> NetflowadmissionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionEdge::sum(self : NetflowadmissionEdge) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionEdge::mean(self : NetflowadmissionEdge) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionEdge::scale(self : NetflowadmissionEdge, f : Double) -> NetflowadmissionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionEdge::add(self : NetflowadmissionEdge, other : NetflowadmissionEdge) -> NetflowadmissionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionEdge::copy(self : NetflowadmissionEdge) -> NetflowadmissionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionEdge::fill(self : NetflowadmissionEdge, v : Double) -> NetflowadmissionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionEdge::min(self : NetflowadmissionEdge) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionEdge::max(self : NetflowadmissionEdge) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionEdge::to_string(self : NetflowadmissionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_path_make(size : Int) -> NetflowadmissionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionPath::len(self : NetflowadmissionPath) -> Int { self.size }

pub fn NetflowadmissionPath::get(self : NetflowadmissionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionPath::set(self : NetflowadmissionPath, i : Int, v : Double) -> NetflowadmissionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionPath::sum(self : NetflowadmissionPath) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionPath::mean(self : NetflowadmissionPath) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionPath::scale(self : NetflowadmissionPath, f : Double) -> NetflowadmissionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionPath::add(self : NetflowadmissionPath, other : NetflowadmissionPath) -> NetflowadmissionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionPath::copy(self : NetflowadmissionPath) -> NetflowadmissionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionPath::fill(self : NetflowadmissionPath, v : Double) -> NetflowadmissionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionPath::min(self : NetflowadmissionPath) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionPath::max(self : NetflowadmissionPath) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionPath::to_string(self : NetflowadmissionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_cluster_make(size : Int) -> NetflowadmissionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionCluster::len(self : NetflowadmissionCluster) -> Int { self.size }

pub fn NetflowadmissionCluster::get(self : NetflowadmissionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionCluster::set(self : NetflowadmissionCluster, i : Int, v : Double) -> NetflowadmissionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionCluster::sum(self : NetflowadmissionCluster) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionCluster::mean(self : NetflowadmissionCluster) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionCluster::scale(self : NetflowadmissionCluster, f : Double) -> NetflowadmissionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionCluster::add(self : NetflowadmissionCluster, other : NetflowadmissionCluster) -> NetflowadmissionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionCluster::copy(self : NetflowadmissionCluster) -> NetflowadmissionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionCluster::fill(self : NetflowadmissionCluster, v : Double) -> NetflowadmissionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionCluster::min(self : NetflowadmissionCluster) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionCluster::max(self : NetflowadmissionCluster) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionCluster::to_string(self : NetflowadmissionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_model_make(size : Int) -> NetflowadmissionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionModel::len(self : NetflowadmissionModel) -> Int { self.size }

pub fn NetflowadmissionModel::get(self : NetflowadmissionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionModel::set(self : NetflowadmissionModel, i : Int, v : Double) -> NetflowadmissionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionModel::sum(self : NetflowadmissionModel) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionModel::mean(self : NetflowadmissionModel) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionModel::scale(self : NetflowadmissionModel, f : Double) -> NetflowadmissionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionModel::add(self : NetflowadmissionModel, other : NetflowadmissionModel) -> NetflowadmissionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionModel::copy(self : NetflowadmissionModel) -> NetflowadmissionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionModel::fill(self : NetflowadmissionModel, v : Double) -> NetflowadmissionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionModel::min(self : NetflowadmissionModel) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionModel::max(self : NetflowadmissionModel) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionModel::to_string(self : NetflowadmissionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_layer_make(size : Int) -> NetflowadmissionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionLayer::len(self : NetflowadmissionLayer) -> Int { self.size }

pub fn NetflowadmissionLayer::get(self : NetflowadmissionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionLayer::set(self : NetflowadmissionLayer, i : Int, v : Double) -> NetflowadmissionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionLayer::sum(self : NetflowadmissionLayer) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionLayer::mean(self : NetflowadmissionLayer) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionLayer::scale(self : NetflowadmissionLayer, f : Double) -> NetflowadmissionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionLayer::add(self : NetflowadmissionLayer, other : NetflowadmissionLayer) -> NetflowadmissionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionLayer::copy(self : NetflowadmissionLayer) -> NetflowadmissionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionLayer::fill(self : NetflowadmissionLayer, v : Double) -> NetflowadmissionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionLayer::min(self : NetflowadmissionLayer) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionLayer::max(self : NetflowadmissionLayer) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionLayer::to_string(self : NetflowadmissionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_buffer_make(size : Int) -> NetflowadmissionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionBuffer::len(self : NetflowadmissionBuffer) -> Int { self.size }

pub fn NetflowadmissionBuffer::get(self : NetflowadmissionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionBuffer::set(self : NetflowadmissionBuffer, i : Int, v : Double) -> NetflowadmissionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionBuffer::sum(self : NetflowadmissionBuffer) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionBuffer::mean(self : NetflowadmissionBuffer) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionBuffer::scale(self : NetflowadmissionBuffer, f : Double) -> NetflowadmissionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionBuffer::add(self : NetflowadmissionBuffer, other : NetflowadmissionBuffer) -> NetflowadmissionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionBuffer::copy(self : NetflowadmissionBuffer) -> NetflowadmissionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionBuffer::fill(self : NetflowadmissionBuffer, v : Double) -> NetflowadmissionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionBuffer::min(self : NetflowadmissionBuffer) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionBuffer::max(self : NetflowadmissionBuffer) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionBuffer::to_string(self : NetflowadmissionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_cursor_make(size : Int) -> NetflowadmissionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionCursor::len(self : NetflowadmissionCursor) -> Int { self.size }

pub fn NetflowadmissionCursor::get(self : NetflowadmissionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionCursor::set(self : NetflowadmissionCursor, i : Int, v : Double) -> NetflowadmissionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionCursor::sum(self : NetflowadmissionCursor) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionCursor::mean(self : NetflowadmissionCursor) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionCursor::scale(self : NetflowadmissionCursor, f : Double) -> NetflowadmissionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionCursor::add(self : NetflowadmissionCursor, other : NetflowadmissionCursor) -> NetflowadmissionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionCursor::copy(self : NetflowadmissionCursor) -> NetflowadmissionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionCursor::fill(self : NetflowadmissionCursor, v : Double) -> NetflowadmissionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionCursor::min(self : NetflowadmissionCursor) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionCursor::max(self : NetflowadmissionCursor) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionCursor::to_string(self : NetflowadmissionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_view_make(size : Int) -> NetflowadmissionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionView::len(self : NetflowadmissionView) -> Int { self.size }

pub fn NetflowadmissionView::get(self : NetflowadmissionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionView::set(self : NetflowadmissionView, i : Int, v : Double) -> NetflowadmissionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionView::sum(self : NetflowadmissionView) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionView::mean(self : NetflowadmissionView) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionView::scale(self : NetflowadmissionView, f : Double) -> NetflowadmissionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionView::add(self : NetflowadmissionView, other : NetflowadmissionView) -> NetflowadmissionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionView::copy(self : NetflowadmissionView) -> NetflowadmissionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionView::fill(self : NetflowadmissionView, v : Double) -> NetflowadmissionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionView::min(self : NetflowadmissionView) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionView::max(self : NetflowadmissionView) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionView::to_string(self : NetflowadmissionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_range_make(size : Int) -> NetflowadmissionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionRange::len(self : NetflowadmissionRange) -> Int { self.size }

pub fn NetflowadmissionRange::get(self : NetflowadmissionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionRange::set(self : NetflowadmissionRange, i : Int, v : Double) -> NetflowadmissionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionRange::sum(self : NetflowadmissionRange) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionRange::mean(self : NetflowadmissionRange) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionRange::scale(self : NetflowadmissionRange, f : Double) -> NetflowadmissionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionRange::add(self : NetflowadmissionRange, other : NetflowadmissionRange) -> NetflowadmissionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionRange::copy(self : NetflowadmissionRange) -> NetflowadmissionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionRange::fill(self : NetflowadmissionRange, v : Double) -> NetflowadmissionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionRange::min(self : NetflowadmissionRange) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionRange::max(self : NetflowadmissionRange) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionRange::to_string(self : NetflowadmissionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_slice_make(size : Int) -> NetflowadmissionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowadmissionSlice::len(self : NetflowadmissionSlice) -> Int { self.size }

pub fn NetflowadmissionSlice::get(self : NetflowadmissionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowadmissionSlice::set(self : NetflowadmissionSlice, i : Int, v : Double) -> NetflowadmissionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowadmissionSlice::sum(self : NetflowadmissionSlice) -> Double { @_common.sum(self.data) }

pub fn NetflowadmissionSlice::mean(self : NetflowadmissionSlice) -> Double { @_common.mean(self.data) }

pub fn NetflowadmissionSlice::scale(self : NetflowadmissionSlice, f : Double) -> NetflowadmissionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionSlice::add(self : NetflowadmissionSlice, other : NetflowadmissionSlice) -> NetflowadmissionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowadmissionSlice::copy(self : NetflowadmissionSlice) -> NetflowadmissionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionSlice::fill(self : NetflowadmissionSlice, v : Double) -> NetflowadmissionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowadmissionSlice::min(self : NetflowadmissionSlice) -> Double { @_common.min(self.data) }

pub fn NetflowadmissionSlice::max(self : NetflowadmissionSlice) -> Double { @_common.max(self.data) }

pub fn NetflowadmissionSlice::to_string(self : NetflowadmissionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

