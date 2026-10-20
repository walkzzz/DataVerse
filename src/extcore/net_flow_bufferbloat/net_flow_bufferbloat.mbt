///===
/// extcore/net_flow_bufferbloat

pub(all) struct NetflowbufferbloatPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_bufferbloat_make_point(x : Double, y : Double) -> NetflowbufferbloatPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_bufferbloat_make_point3(x : Double, y : Double, z : Double) -> NetflowbufferbloatPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowbufferbloatPoint::x(self : NetflowbufferbloatPoint) -> Double { self.x }

pub fn NetflowbufferbloatPoint::y(self : NetflowbufferbloatPoint) -> Double { self.y }

pub fn NetflowbufferbloatPoint::z(self : NetflowbufferbloatPoint) -> Double { self.z }

pub fn NetflowbufferbloatPoint::label(self : NetflowbufferbloatPoint) -> Int { self.label }

pub fn NetflowbufferbloatPoint::dist(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowbufferbloatPoint::add(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowbufferbloatPoint::sub(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowbufferbloatPoint::scale(self : NetflowbufferbloatPoint, s : Double) -> NetflowbufferbloatPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowbufferbloatPoint::dot(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowbufferbloatPoint::cross(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowbufferbloatPoint::norm(self : NetflowbufferbloatPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowbufferbloatPoint::normalize(self : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowbufferbloatPoint::negate(self : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowbufferbloatPoint::mid(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowbufferbloatPoint::lerp(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint, t : Double) -> NetflowbufferbloatPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowbufferbloatPoint::to_string(self : NetflowbufferbloatPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowbufferbloatSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_bufferbloat_make_series(vals : Array[Double], name : String) -> NetflowbufferbloatSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowbufferbloatSeries::len(self : NetflowbufferbloatSeries) -> Int { self.vals.length() }

pub fn NetflowbufferbloatSeries::sum(self : NetflowbufferbloatSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowbufferbloatSeries::mean(self : NetflowbufferbloatSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowbufferbloatSeries::min(self : NetflowbufferbloatSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowbufferbloatSeries::max(self : NetflowbufferbloatSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowbufferbloatSeries::range(self : NetflowbufferbloatSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowbufferbloatSeries::variance(self : NetflowbufferbloatSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowbufferbloatSeries::std(self : NetflowbufferbloatSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowbufferbloatSeries::median(self : NetflowbufferbloatSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowbufferbloatSeries::scale(self : NetflowbufferbloatSeries, f : Double) -> NetflowbufferbloatSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowbufferbloatSeries::add(self : NetflowbufferbloatSeries, other : NetflowbufferbloatSeries) -> NetflowbufferbloatSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowbufferbloatSeries::sub(self : NetflowbufferbloatSeries, other : NetflowbufferbloatSeries) -> NetflowbufferbloatSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowbufferbloatSeries::normalize(self : NetflowbufferbloatSeries) -> NetflowbufferbloatSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowbufferbloatSeries::cumsum(self : NetflowbufferbloatSeries) -> NetflowbufferbloatSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowbufferbloatSeries::to_string(self : NetflowbufferbloatSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowbufferbloatMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_bufferbloat_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowbufferbloatMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn net_flow_bufferbloat_matrix_identity(n : Int) -> NetflowbufferbloatMatrix {
  let m = net_flow_bufferbloat_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowbufferbloatMatrix::get(self : NetflowbufferbloatMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowbufferbloatMatrix::transpose(self : NetflowbufferbloatMatrix) -> NetflowbufferbloatMatrix {
  let result = net_flow_bufferbloat_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowbufferbloatMatrix::add(self : NetflowbufferbloatMatrix, other : NetflowbufferbloatMatrix) -> NetflowbufferbloatMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_bufferbloat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowbufferbloatMatrix::scale(self : NetflowbufferbloatMatrix, s : Double) -> NetflowbufferbloatMatrix {
  let result = net_flow_bufferbloat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowbufferbloatMatrix::multiply(self : NetflowbufferbloatMatrix, other : NetflowbufferbloatMatrix) -> NetflowbufferbloatMatrix {
  if self.cols != other.rows { return net_flow_bufferbloat_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_bufferbloat_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetflowbufferbloatMatrix::trace(self : NetflowbufferbloatMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowbufferbloatMatrix::det(self : NetflowbufferbloatMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowbufferbloatMatrix::norm(self : NetflowbufferbloatMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowbufferbloatMatrix::to_string(self : NetflowbufferbloatMatrix) -> String {
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

pub(all) struct NetflowbufferbloatVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_bufferbloat_make_vector(comps : Array[Double]) -> NetflowbufferbloatVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_bufferbloat_vector_zero(dim : Int) -> NetflowbufferbloatVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowbufferbloatVector::add(self : NetflowbufferbloatVector, other : NetflowbufferbloatVector) -> NetflowbufferbloatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowbufferbloatVector::sub(self : NetflowbufferbloatVector, other : NetflowbufferbloatVector) -> NetflowbufferbloatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowbufferbloatVector::scale(self : NetflowbufferbloatVector, s : Double) -> NetflowbufferbloatVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowbufferbloatVector::dot(self : NetflowbufferbloatVector, other : NetflowbufferbloatVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowbufferbloatVector::norm(self : NetflowbufferbloatVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowbufferbloatVector::normalize(self : NetflowbufferbloatVector) -> NetflowbufferbloatVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowbufferbloatVector::dist(self : NetflowbufferbloatVector, other : NetflowbufferbloatVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowbufferbloatVector::to_string(self : NetflowbufferbloatVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowbufferbloatFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_frame_make(size : Int) -> NetflowbufferbloatFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatFrame::len(self : NetflowbufferbloatFrame) -> Int { self.size }

pub fn NetflowbufferbloatFrame::get(self : NetflowbufferbloatFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatFrame::set(self : NetflowbufferbloatFrame, i : Int, v : Double) -> NetflowbufferbloatFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatFrame::sum(self : NetflowbufferbloatFrame) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatFrame::mean(self : NetflowbufferbloatFrame) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatFrame::scale(self : NetflowbufferbloatFrame, f : Double) -> NetflowbufferbloatFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatFrame::add(self : NetflowbufferbloatFrame, other : NetflowbufferbloatFrame) -> NetflowbufferbloatFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatFrame::copy(self : NetflowbufferbloatFrame) -> NetflowbufferbloatFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatFrame::fill(self : NetflowbufferbloatFrame, v : Double) -> NetflowbufferbloatFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatFrame::min(self : NetflowbufferbloatFrame) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatFrame::max(self : NetflowbufferbloatFrame) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatFrame::to_string(self : NetflowbufferbloatFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_table_make(size : Int) -> NetflowbufferbloatTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatTable::len(self : NetflowbufferbloatTable) -> Int { self.size }

pub fn NetflowbufferbloatTable::get(self : NetflowbufferbloatTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatTable::set(self : NetflowbufferbloatTable, i : Int, v : Double) -> NetflowbufferbloatTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatTable::sum(self : NetflowbufferbloatTable) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatTable::mean(self : NetflowbufferbloatTable) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatTable::scale(self : NetflowbufferbloatTable, f : Double) -> NetflowbufferbloatTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatTable::add(self : NetflowbufferbloatTable, other : NetflowbufferbloatTable) -> NetflowbufferbloatTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatTable::copy(self : NetflowbufferbloatTable) -> NetflowbufferbloatTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatTable::fill(self : NetflowbufferbloatTable, v : Double) -> NetflowbufferbloatTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatTable::min(self : NetflowbufferbloatTable) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatTable::max(self : NetflowbufferbloatTable) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatTable::to_string(self : NetflowbufferbloatTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_graphn_make(size : Int) -> NetflowbufferbloatGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatGraphN::len(self : NetflowbufferbloatGraphN) -> Int { self.size }

pub fn NetflowbufferbloatGraphN::get(self : NetflowbufferbloatGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatGraphN::set(self : NetflowbufferbloatGraphN, i : Int, v : Double) -> NetflowbufferbloatGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatGraphN::sum(self : NetflowbufferbloatGraphN) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatGraphN::mean(self : NetflowbufferbloatGraphN) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatGraphN::scale(self : NetflowbufferbloatGraphN, f : Double) -> NetflowbufferbloatGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatGraphN::add(self : NetflowbufferbloatGraphN, other : NetflowbufferbloatGraphN) -> NetflowbufferbloatGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatGraphN::copy(self : NetflowbufferbloatGraphN) -> NetflowbufferbloatGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatGraphN::fill(self : NetflowbufferbloatGraphN, v : Double) -> NetflowbufferbloatGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatGraphN::min(self : NetflowbufferbloatGraphN) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatGraphN::max(self : NetflowbufferbloatGraphN) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatGraphN::to_string(self : NetflowbufferbloatGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_node_make(size : Int) -> NetflowbufferbloatNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatNode::len(self : NetflowbufferbloatNode) -> Int { self.size }

pub fn NetflowbufferbloatNode::get(self : NetflowbufferbloatNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatNode::set(self : NetflowbufferbloatNode, i : Int, v : Double) -> NetflowbufferbloatNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatNode::sum(self : NetflowbufferbloatNode) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatNode::mean(self : NetflowbufferbloatNode) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatNode::scale(self : NetflowbufferbloatNode, f : Double) -> NetflowbufferbloatNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatNode::add(self : NetflowbufferbloatNode, other : NetflowbufferbloatNode) -> NetflowbufferbloatNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatNode::copy(self : NetflowbufferbloatNode) -> NetflowbufferbloatNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatNode::fill(self : NetflowbufferbloatNode, v : Double) -> NetflowbufferbloatNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatNode::min(self : NetflowbufferbloatNode) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatNode::max(self : NetflowbufferbloatNode) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatNode::to_string(self : NetflowbufferbloatNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_edge_make(size : Int) -> NetflowbufferbloatEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatEdge::len(self : NetflowbufferbloatEdge) -> Int { self.size }

pub fn NetflowbufferbloatEdge::get(self : NetflowbufferbloatEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatEdge::set(self : NetflowbufferbloatEdge, i : Int, v : Double) -> NetflowbufferbloatEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatEdge::sum(self : NetflowbufferbloatEdge) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatEdge::mean(self : NetflowbufferbloatEdge) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatEdge::scale(self : NetflowbufferbloatEdge, f : Double) -> NetflowbufferbloatEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatEdge::add(self : NetflowbufferbloatEdge, other : NetflowbufferbloatEdge) -> NetflowbufferbloatEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatEdge::copy(self : NetflowbufferbloatEdge) -> NetflowbufferbloatEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatEdge::fill(self : NetflowbufferbloatEdge, v : Double) -> NetflowbufferbloatEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatEdge::min(self : NetflowbufferbloatEdge) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatEdge::max(self : NetflowbufferbloatEdge) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatEdge::to_string(self : NetflowbufferbloatEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_path_make(size : Int) -> NetflowbufferbloatPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatPath::len(self : NetflowbufferbloatPath) -> Int { self.size }

pub fn NetflowbufferbloatPath::get(self : NetflowbufferbloatPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatPath::set(self : NetflowbufferbloatPath, i : Int, v : Double) -> NetflowbufferbloatPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatPath::sum(self : NetflowbufferbloatPath) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatPath::mean(self : NetflowbufferbloatPath) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatPath::scale(self : NetflowbufferbloatPath, f : Double) -> NetflowbufferbloatPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatPath::add(self : NetflowbufferbloatPath, other : NetflowbufferbloatPath) -> NetflowbufferbloatPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatPath::copy(self : NetflowbufferbloatPath) -> NetflowbufferbloatPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatPath::fill(self : NetflowbufferbloatPath, v : Double) -> NetflowbufferbloatPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatPath::min(self : NetflowbufferbloatPath) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatPath::max(self : NetflowbufferbloatPath) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatPath::to_string(self : NetflowbufferbloatPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_cluster_make(size : Int) -> NetflowbufferbloatCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatCluster::len(self : NetflowbufferbloatCluster) -> Int { self.size }

pub fn NetflowbufferbloatCluster::get(self : NetflowbufferbloatCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatCluster::set(self : NetflowbufferbloatCluster, i : Int, v : Double) -> NetflowbufferbloatCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatCluster::sum(self : NetflowbufferbloatCluster) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatCluster::mean(self : NetflowbufferbloatCluster) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatCluster::scale(self : NetflowbufferbloatCluster, f : Double) -> NetflowbufferbloatCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatCluster::add(self : NetflowbufferbloatCluster, other : NetflowbufferbloatCluster) -> NetflowbufferbloatCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatCluster::copy(self : NetflowbufferbloatCluster) -> NetflowbufferbloatCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatCluster::fill(self : NetflowbufferbloatCluster, v : Double) -> NetflowbufferbloatCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatCluster::min(self : NetflowbufferbloatCluster) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatCluster::max(self : NetflowbufferbloatCluster) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatCluster::to_string(self : NetflowbufferbloatCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_model_make(size : Int) -> NetflowbufferbloatModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatModel::len(self : NetflowbufferbloatModel) -> Int { self.size }

pub fn NetflowbufferbloatModel::get(self : NetflowbufferbloatModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatModel::set(self : NetflowbufferbloatModel, i : Int, v : Double) -> NetflowbufferbloatModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatModel::sum(self : NetflowbufferbloatModel) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatModel::mean(self : NetflowbufferbloatModel) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatModel::scale(self : NetflowbufferbloatModel, f : Double) -> NetflowbufferbloatModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatModel::add(self : NetflowbufferbloatModel, other : NetflowbufferbloatModel) -> NetflowbufferbloatModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatModel::copy(self : NetflowbufferbloatModel) -> NetflowbufferbloatModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatModel::fill(self : NetflowbufferbloatModel, v : Double) -> NetflowbufferbloatModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatModel::min(self : NetflowbufferbloatModel) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatModel::max(self : NetflowbufferbloatModel) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatModel::to_string(self : NetflowbufferbloatModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_layer_make(size : Int) -> NetflowbufferbloatLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatLayer::len(self : NetflowbufferbloatLayer) -> Int { self.size }

pub fn NetflowbufferbloatLayer::get(self : NetflowbufferbloatLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatLayer::set(self : NetflowbufferbloatLayer, i : Int, v : Double) -> NetflowbufferbloatLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatLayer::sum(self : NetflowbufferbloatLayer) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatLayer::mean(self : NetflowbufferbloatLayer) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatLayer::scale(self : NetflowbufferbloatLayer, f : Double) -> NetflowbufferbloatLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatLayer::add(self : NetflowbufferbloatLayer, other : NetflowbufferbloatLayer) -> NetflowbufferbloatLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatLayer::copy(self : NetflowbufferbloatLayer) -> NetflowbufferbloatLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatLayer::fill(self : NetflowbufferbloatLayer, v : Double) -> NetflowbufferbloatLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatLayer::min(self : NetflowbufferbloatLayer) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatLayer::max(self : NetflowbufferbloatLayer) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatLayer::to_string(self : NetflowbufferbloatLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_buffer_make(size : Int) -> NetflowbufferbloatBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatBuffer::len(self : NetflowbufferbloatBuffer) -> Int { self.size }

pub fn NetflowbufferbloatBuffer::get(self : NetflowbufferbloatBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatBuffer::set(self : NetflowbufferbloatBuffer, i : Int, v : Double) -> NetflowbufferbloatBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatBuffer::sum(self : NetflowbufferbloatBuffer) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatBuffer::mean(self : NetflowbufferbloatBuffer) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatBuffer::scale(self : NetflowbufferbloatBuffer, f : Double) -> NetflowbufferbloatBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatBuffer::add(self : NetflowbufferbloatBuffer, other : NetflowbufferbloatBuffer) -> NetflowbufferbloatBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatBuffer::copy(self : NetflowbufferbloatBuffer) -> NetflowbufferbloatBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatBuffer::fill(self : NetflowbufferbloatBuffer, v : Double) -> NetflowbufferbloatBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatBuffer::min(self : NetflowbufferbloatBuffer) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatBuffer::max(self : NetflowbufferbloatBuffer) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatBuffer::to_string(self : NetflowbufferbloatBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_cursor_make(size : Int) -> NetflowbufferbloatCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatCursor::len(self : NetflowbufferbloatCursor) -> Int { self.size }

pub fn NetflowbufferbloatCursor::get(self : NetflowbufferbloatCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatCursor::set(self : NetflowbufferbloatCursor, i : Int, v : Double) -> NetflowbufferbloatCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatCursor::sum(self : NetflowbufferbloatCursor) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatCursor::mean(self : NetflowbufferbloatCursor) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatCursor::scale(self : NetflowbufferbloatCursor, f : Double) -> NetflowbufferbloatCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatCursor::add(self : NetflowbufferbloatCursor, other : NetflowbufferbloatCursor) -> NetflowbufferbloatCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatCursor::copy(self : NetflowbufferbloatCursor) -> NetflowbufferbloatCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatCursor::fill(self : NetflowbufferbloatCursor, v : Double) -> NetflowbufferbloatCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatCursor::min(self : NetflowbufferbloatCursor) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatCursor::max(self : NetflowbufferbloatCursor) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatCursor::to_string(self : NetflowbufferbloatCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_view_make(size : Int) -> NetflowbufferbloatView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatView::len(self : NetflowbufferbloatView) -> Int { self.size }

pub fn NetflowbufferbloatView::get(self : NetflowbufferbloatView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatView::set(self : NetflowbufferbloatView, i : Int, v : Double) -> NetflowbufferbloatView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatView::sum(self : NetflowbufferbloatView) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatView::mean(self : NetflowbufferbloatView) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatView::scale(self : NetflowbufferbloatView, f : Double) -> NetflowbufferbloatView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatView::add(self : NetflowbufferbloatView, other : NetflowbufferbloatView) -> NetflowbufferbloatView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatView::copy(self : NetflowbufferbloatView) -> NetflowbufferbloatView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatView::fill(self : NetflowbufferbloatView, v : Double) -> NetflowbufferbloatView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatView::min(self : NetflowbufferbloatView) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatView::max(self : NetflowbufferbloatView) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatView::to_string(self : NetflowbufferbloatView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_range_make(size : Int) -> NetflowbufferbloatRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatRange::len(self : NetflowbufferbloatRange) -> Int { self.size }

pub fn NetflowbufferbloatRange::get(self : NetflowbufferbloatRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatRange::set(self : NetflowbufferbloatRange, i : Int, v : Double) -> NetflowbufferbloatRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatRange::sum(self : NetflowbufferbloatRange) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatRange::mean(self : NetflowbufferbloatRange) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatRange::scale(self : NetflowbufferbloatRange, f : Double) -> NetflowbufferbloatRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatRange::add(self : NetflowbufferbloatRange, other : NetflowbufferbloatRange) -> NetflowbufferbloatRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatRange::copy(self : NetflowbufferbloatRange) -> NetflowbufferbloatRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatRange::fill(self : NetflowbufferbloatRange, v : Double) -> NetflowbufferbloatRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatRange::min(self : NetflowbufferbloatRange) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatRange::max(self : NetflowbufferbloatRange) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatRange::to_string(self : NetflowbufferbloatRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_slice_make(size : Int) -> NetflowbufferbloatSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowbufferbloatSlice::len(self : NetflowbufferbloatSlice) -> Int { self.size }

pub fn NetflowbufferbloatSlice::get(self : NetflowbufferbloatSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowbufferbloatSlice::set(self : NetflowbufferbloatSlice, i : Int, v : Double) -> NetflowbufferbloatSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatSlice::sum(self : NetflowbufferbloatSlice) -> Double { @_common.sum(self.data) }

pub fn NetflowbufferbloatSlice::mean(self : NetflowbufferbloatSlice) -> Double { @_common.mean(self.data) }

pub fn NetflowbufferbloatSlice::scale(self : NetflowbufferbloatSlice, f : Double) -> NetflowbufferbloatSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatSlice::add(self : NetflowbufferbloatSlice, other : NetflowbufferbloatSlice) -> NetflowbufferbloatSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowbufferbloatSlice::copy(self : NetflowbufferbloatSlice) -> NetflowbufferbloatSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatSlice::fill(self : NetflowbufferbloatSlice, v : Double) -> NetflowbufferbloatSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowbufferbloatSlice::min(self : NetflowbufferbloatSlice) -> Double { @_common.min(self.data) }

pub fn NetflowbufferbloatSlice::max(self : NetflowbufferbloatSlice) -> Double { @_common.max(self.data) }

pub fn NetflowbufferbloatSlice::to_string(self : NetflowbufferbloatSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

