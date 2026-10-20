///===
/// extcore/net_sec_ddos

pub(all) struct NetsecddosPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ddos_make_point(x : Double, y : Double) -> NetsecddosPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ddos_make_point3(x : Double, y : Double, z : Double) -> NetsecddosPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecddosPoint::x(self : NetsecddosPoint) -> Double { self.x }

pub fn NetsecddosPoint::y(self : NetsecddosPoint) -> Double { self.y }

pub fn NetsecddosPoint::z(self : NetsecddosPoint) -> Double { self.z }

pub fn NetsecddosPoint::label(self : NetsecddosPoint) -> Int { self.label }

pub fn NetsecddosPoint::dist(self : NetsecddosPoint, other : NetsecddosPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecddosPoint::add(self : NetsecddosPoint, other : NetsecddosPoint) -> NetsecddosPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecddosPoint::sub(self : NetsecddosPoint, other : NetsecddosPoint) -> NetsecddosPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecddosPoint::scale(self : NetsecddosPoint, s : Double) -> NetsecddosPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecddosPoint::dot(self : NetsecddosPoint, other : NetsecddosPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecddosPoint::cross(self : NetsecddosPoint, other : NetsecddosPoint) -> NetsecddosPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecddosPoint::norm(self : NetsecddosPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecddosPoint::normalize(self : NetsecddosPoint) -> NetsecddosPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecddosPoint::negate(self : NetsecddosPoint) -> NetsecddosPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecddosPoint::mid(self : NetsecddosPoint, other : NetsecddosPoint) -> NetsecddosPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecddosPoint::lerp(self : NetsecddosPoint, other : NetsecddosPoint, t : Double) -> NetsecddosPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecddosPoint::to_string(self : NetsecddosPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecddosSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ddos_make_series(vals : Array[Double], name : String) -> NetsecddosSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecddosSeries::len(self : NetsecddosSeries) -> Int { self.vals.length() }

pub fn NetsecddosSeries::sum(self : NetsecddosSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecddosSeries::mean(self : NetsecddosSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecddosSeries::min(self : NetsecddosSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecddosSeries::max(self : NetsecddosSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecddosSeries::range(self : NetsecddosSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecddosSeries::variance(self : NetsecddosSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecddosSeries::std(self : NetsecddosSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecddosSeries::median(self : NetsecddosSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecddosSeries::scale(self : NetsecddosSeries, f : Double) -> NetsecddosSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecddosSeries::add(self : NetsecddosSeries, other : NetsecddosSeries) -> NetsecddosSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecddosSeries::sub(self : NetsecddosSeries, other : NetsecddosSeries) -> NetsecddosSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecddosSeries::normalize(self : NetsecddosSeries) -> NetsecddosSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecddosSeries::cumsum(self : NetsecddosSeries) -> NetsecddosSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecddosSeries::to_string(self : NetsecddosSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecddosMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ddos_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecddosMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ddos_matrix_identity(n : Int) -> NetsecddosMatrix {
  let m = net_sec_ddos_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecddosMatrix::get(self : NetsecddosMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecddosMatrix::transpose(self : NetsecddosMatrix) -> NetsecddosMatrix {
  let result = net_sec_ddos_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecddosMatrix::add(self : NetsecddosMatrix, other : NetsecddosMatrix) -> NetsecddosMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_ddos_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecddosMatrix::scale(self : NetsecddosMatrix, s : Double) -> NetsecddosMatrix {
  let result = net_sec_ddos_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecddosMatrix::multiply(self : NetsecddosMatrix, other : NetsecddosMatrix) -> NetsecddosMatrix {
  if self.cols != other.rows { return net_sec_ddos_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_ddos_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecddosMatrix::trace(self : NetsecddosMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecddosMatrix::det(self : NetsecddosMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecddosMatrix::norm(self : NetsecddosMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecddosMatrix::to_string(self : NetsecddosMatrix) -> String {
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

pub(all) struct NetsecddosVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ddos_make_vector(comps : Array[Double]) -> NetsecddosVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ddos_vector_zero(dim : Int) -> NetsecddosVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecddosVector::add(self : NetsecddosVector, other : NetsecddosVector) -> NetsecddosVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecddosVector::sub(self : NetsecddosVector, other : NetsecddosVector) -> NetsecddosVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecddosVector::scale(self : NetsecddosVector, s : Double) -> NetsecddosVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecddosVector::dot(self : NetsecddosVector, other : NetsecddosVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecddosVector::norm(self : NetsecddosVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecddosVector::normalize(self : NetsecddosVector) -> NetsecddosVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecddosVector::dist(self : NetsecddosVector, other : NetsecddosVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecddosVector::to_string(self : NetsecddosVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecddosFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_frame_make(size : Int) -> NetsecddosFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosFrame::len(self : NetsecddosFrame) -> Int { self.size }

pub fn NetsecddosFrame::get(self : NetsecddosFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosFrame::set(self : NetsecddosFrame, i : Int, v : Double) -> NetsecddosFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosFrame::sum(self : NetsecddosFrame) -> Double { @_common.sum(self.data) }

pub fn NetsecddosFrame::mean(self : NetsecddosFrame) -> Double { @_common.mean(self.data) }

pub fn NetsecddosFrame::scale(self : NetsecddosFrame, f : Double) -> NetsecddosFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosFrame::add(self : NetsecddosFrame, other : NetsecddosFrame) -> NetsecddosFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosFrame::copy(self : NetsecddosFrame) -> NetsecddosFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosFrame::fill(self : NetsecddosFrame, v : Double) -> NetsecddosFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosFrame::min(self : NetsecddosFrame) -> Double { @_common.min(self.data) }

pub fn NetsecddosFrame::max(self : NetsecddosFrame) -> Double { @_common.max(self.data) }

pub fn NetsecddosFrame::to_string(self : NetsecddosFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_table_make(size : Int) -> NetsecddosTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosTable::len(self : NetsecddosTable) -> Int { self.size }

pub fn NetsecddosTable::get(self : NetsecddosTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosTable::set(self : NetsecddosTable, i : Int, v : Double) -> NetsecddosTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosTable::sum(self : NetsecddosTable) -> Double { @_common.sum(self.data) }

pub fn NetsecddosTable::mean(self : NetsecddosTable) -> Double { @_common.mean(self.data) }

pub fn NetsecddosTable::scale(self : NetsecddosTable, f : Double) -> NetsecddosTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosTable::add(self : NetsecddosTable, other : NetsecddosTable) -> NetsecddosTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosTable::copy(self : NetsecddosTable) -> NetsecddosTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosTable::fill(self : NetsecddosTable, v : Double) -> NetsecddosTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosTable::min(self : NetsecddosTable) -> Double { @_common.min(self.data) }

pub fn NetsecddosTable::max(self : NetsecddosTable) -> Double { @_common.max(self.data) }

pub fn NetsecddosTable::to_string(self : NetsecddosTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_graphn_make(size : Int) -> NetsecddosGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosGraphN::len(self : NetsecddosGraphN) -> Int { self.size }

pub fn NetsecddosGraphN::get(self : NetsecddosGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosGraphN::set(self : NetsecddosGraphN, i : Int, v : Double) -> NetsecddosGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosGraphN::sum(self : NetsecddosGraphN) -> Double { @_common.sum(self.data) }

pub fn NetsecddosGraphN::mean(self : NetsecddosGraphN) -> Double { @_common.mean(self.data) }

pub fn NetsecddosGraphN::scale(self : NetsecddosGraphN, f : Double) -> NetsecddosGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosGraphN::add(self : NetsecddosGraphN, other : NetsecddosGraphN) -> NetsecddosGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosGraphN::copy(self : NetsecddosGraphN) -> NetsecddosGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosGraphN::fill(self : NetsecddosGraphN, v : Double) -> NetsecddosGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosGraphN::min(self : NetsecddosGraphN) -> Double { @_common.min(self.data) }

pub fn NetsecddosGraphN::max(self : NetsecddosGraphN) -> Double { @_common.max(self.data) }

pub fn NetsecddosGraphN::to_string(self : NetsecddosGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_node_make(size : Int) -> NetsecddosNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosNode::len(self : NetsecddosNode) -> Int { self.size }

pub fn NetsecddosNode::get(self : NetsecddosNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosNode::set(self : NetsecddosNode, i : Int, v : Double) -> NetsecddosNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosNode::sum(self : NetsecddosNode) -> Double { @_common.sum(self.data) }

pub fn NetsecddosNode::mean(self : NetsecddosNode) -> Double { @_common.mean(self.data) }

pub fn NetsecddosNode::scale(self : NetsecddosNode, f : Double) -> NetsecddosNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosNode::add(self : NetsecddosNode, other : NetsecddosNode) -> NetsecddosNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosNode::copy(self : NetsecddosNode) -> NetsecddosNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosNode::fill(self : NetsecddosNode, v : Double) -> NetsecddosNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosNode::min(self : NetsecddosNode) -> Double { @_common.min(self.data) }

pub fn NetsecddosNode::max(self : NetsecddosNode) -> Double { @_common.max(self.data) }

pub fn NetsecddosNode::to_string(self : NetsecddosNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_edge_make(size : Int) -> NetsecddosEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosEdge::len(self : NetsecddosEdge) -> Int { self.size }

pub fn NetsecddosEdge::get(self : NetsecddosEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosEdge::set(self : NetsecddosEdge, i : Int, v : Double) -> NetsecddosEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosEdge::sum(self : NetsecddosEdge) -> Double { @_common.sum(self.data) }

pub fn NetsecddosEdge::mean(self : NetsecddosEdge) -> Double { @_common.mean(self.data) }

pub fn NetsecddosEdge::scale(self : NetsecddosEdge, f : Double) -> NetsecddosEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosEdge::add(self : NetsecddosEdge, other : NetsecddosEdge) -> NetsecddosEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosEdge::copy(self : NetsecddosEdge) -> NetsecddosEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosEdge::fill(self : NetsecddosEdge, v : Double) -> NetsecddosEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosEdge::min(self : NetsecddosEdge) -> Double { @_common.min(self.data) }

pub fn NetsecddosEdge::max(self : NetsecddosEdge) -> Double { @_common.max(self.data) }

pub fn NetsecddosEdge::to_string(self : NetsecddosEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_path_make(size : Int) -> NetsecddosPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosPath::len(self : NetsecddosPath) -> Int { self.size }

pub fn NetsecddosPath::get(self : NetsecddosPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosPath::set(self : NetsecddosPath, i : Int, v : Double) -> NetsecddosPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosPath::sum(self : NetsecddosPath) -> Double { @_common.sum(self.data) }

pub fn NetsecddosPath::mean(self : NetsecddosPath) -> Double { @_common.mean(self.data) }

pub fn NetsecddosPath::scale(self : NetsecddosPath, f : Double) -> NetsecddosPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosPath::add(self : NetsecddosPath, other : NetsecddosPath) -> NetsecddosPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosPath::copy(self : NetsecddosPath) -> NetsecddosPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosPath::fill(self : NetsecddosPath, v : Double) -> NetsecddosPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosPath::min(self : NetsecddosPath) -> Double { @_common.min(self.data) }

pub fn NetsecddosPath::max(self : NetsecddosPath) -> Double { @_common.max(self.data) }

pub fn NetsecddosPath::to_string(self : NetsecddosPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_cluster_make(size : Int) -> NetsecddosCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosCluster::len(self : NetsecddosCluster) -> Int { self.size }

pub fn NetsecddosCluster::get(self : NetsecddosCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosCluster::set(self : NetsecddosCluster, i : Int, v : Double) -> NetsecddosCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosCluster::sum(self : NetsecddosCluster) -> Double { @_common.sum(self.data) }

pub fn NetsecddosCluster::mean(self : NetsecddosCluster) -> Double { @_common.mean(self.data) }

pub fn NetsecddosCluster::scale(self : NetsecddosCluster, f : Double) -> NetsecddosCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosCluster::add(self : NetsecddosCluster, other : NetsecddosCluster) -> NetsecddosCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosCluster::copy(self : NetsecddosCluster) -> NetsecddosCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosCluster::fill(self : NetsecddosCluster, v : Double) -> NetsecddosCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosCluster::min(self : NetsecddosCluster) -> Double { @_common.min(self.data) }

pub fn NetsecddosCluster::max(self : NetsecddosCluster) -> Double { @_common.max(self.data) }

pub fn NetsecddosCluster::to_string(self : NetsecddosCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_model_make(size : Int) -> NetsecddosModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosModel::len(self : NetsecddosModel) -> Int { self.size }

pub fn NetsecddosModel::get(self : NetsecddosModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosModel::set(self : NetsecddosModel, i : Int, v : Double) -> NetsecddosModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosModel::sum(self : NetsecddosModel) -> Double { @_common.sum(self.data) }

pub fn NetsecddosModel::mean(self : NetsecddosModel) -> Double { @_common.mean(self.data) }

pub fn NetsecddosModel::scale(self : NetsecddosModel, f : Double) -> NetsecddosModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosModel::add(self : NetsecddosModel, other : NetsecddosModel) -> NetsecddosModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosModel::copy(self : NetsecddosModel) -> NetsecddosModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosModel::fill(self : NetsecddosModel, v : Double) -> NetsecddosModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosModel::min(self : NetsecddosModel) -> Double { @_common.min(self.data) }

pub fn NetsecddosModel::max(self : NetsecddosModel) -> Double { @_common.max(self.data) }

pub fn NetsecddosModel::to_string(self : NetsecddosModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_layer_make(size : Int) -> NetsecddosLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosLayer::len(self : NetsecddosLayer) -> Int { self.size }

pub fn NetsecddosLayer::get(self : NetsecddosLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosLayer::set(self : NetsecddosLayer, i : Int, v : Double) -> NetsecddosLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosLayer::sum(self : NetsecddosLayer) -> Double { @_common.sum(self.data) }

pub fn NetsecddosLayer::mean(self : NetsecddosLayer) -> Double { @_common.mean(self.data) }

pub fn NetsecddosLayer::scale(self : NetsecddosLayer, f : Double) -> NetsecddosLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosLayer::add(self : NetsecddosLayer, other : NetsecddosLayer) -> NetsecddosLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosLayer::copy(self : NetsecddosLayer) -> NetsecddosLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosLayer::fill(self : NetsecddosLayer, v : Double) -> NetsecddosLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosLayer::min(self : NetsecddosLayer) -> Double { @_common.min(self.data) }

pub fn NetsecddosLayer::max(self : NetsecddosLayer) -> Double { @_common.max(self.data) }

pub fn NetsecddosLayer::to_string(self : NetsecddosLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_buffer_make(size : Int) -> NetsecddosBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosBuffer::len(self : NetsecddosBuffer) -> Int { self.size }

pub fn NetsecddosBuffer::get(self : NetsecddosBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosBuffer::set(self : NetsecddosBuffer, i : Int, v : Double) -> NetsecddosBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosBuffer::sum(self : NetsecddosBuffer) -> Double { @_common.sum(self.data) }

pub fn NetsecddosBuffer::mean(self : NetsecddosBuffer) -> Double { @_common.mean(self.data) }

pub fn NetsecddosBuffer::scale(self : NetsecddosBuffer, f : Double) -> NetsecddosBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosBuffer::add(self : NetsecddosBuffer, other : NetsecddosBuffer) -> NetsecddosBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosBuffer::copy(self : NetsecddosBuffer) -> NetsecddosBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosBuffer::fill(self : NetsecddosBuffer, v : Double) -> NetsecddosBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosBuffer::min(self : NetsecddosBuffer) -> Double { @_common.min(self.data) }

pub fn NetsecddosBuffer::max(self : NetsecddosBuffer) -> Double { @_common.max(self.data) }

pub fn NetsecddosBuffer::to_string(self : NetsecddosBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_cursor_make(size : Int) -> NetsecddosCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosCursor::len(self : NetsecddosCursor) -> Int { self.size }

pub fn NetsecddosCursor::get(self : NetsecddosCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosCursor::set(self : NetsecddosCursor, i : Int, v : Double) -> NetsecddosCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosCursor::sum(self : NetsecddosCursor) -> Double { @_common.sum(self.data) }

pub fn NetsecddosCursor::mean(self : NetsecddosCursor) -> Double { @_common.mean(self.data) }

pub fn NetsecddosCursor::scale(self : NetsecddosCursor, f : Double) -> NetsecddosCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosCursor::add(self : NetsecddosCursor, other : NetsecddosCursor) -> NetsecddosCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosCursor::copy(self : NetsecddosCursor) -> NetsecddosCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosCursor::fill(self : NetsecddosCursor, v : Double) -> NetsecddosCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosCursor::min(self : NetsecddosCursor) -> Double { @_common.min(self.data) }

pub fn NetsecddosCursor::max(self : NetsecddosCursor) -> Double { @_common.max(self.data) }

pub fn NetsecddosCursor::to_string(self : NetsecddosCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_view_make(size : Int) -> NetsecddosView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosView::len(self : NetsecddosView) -> Int { self.size }

pub fn NetsecddosView::get(self : NetsecddosView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosView::set(self : NetsecddosView, i : Int, v : Double) -> NetsecddosView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosView::sum(self : NetsecddosView) -> Double { @_common.sum(self.data) }

pub fn NetsecddosView::mean(self : NetsecddosView) -> Double { @_common.mean(self.data) }

pub fn NetsecddosView::scale(self : NetsecddosView, f : Double) -> NetsecddosView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosView::add(self : NetsecddosView, other : NetsecddosView) -> NetsecddosView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosView::copy(self : NetsecddosView) -> NetsecddosView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosView::fill(self : NetsecddosView, v : Double) -> NetsecddosView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosView::min(self : NetsecddosView) -> Double { @_common.min(self.data) }

pub fn NetsecddosView::max(self : NetsecddosView) -> Double { @_common.max(self.data) }

pub fn NetsecddosView::to_string(self : NetsecddosView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_range_make(size : Int) -> NetsecddosRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosRange::len(self : NetsecddosRange) -> Int { self.size }

pub fn NetsecddosRange::get(self : NetsecddosRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosRange::set(self : NetsecddosRange, i : Int, v : Double) -> NetsecddosRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosRange::sum(self : NetsecddosRange) -> Double { @_common.sum(self.data) }

pub fn NetsecddosRange::mean(self : NetsecddosRange) -> Double { @_common.mean(self.data) }

pub fn NetsecddosRange::scale(self : NetsecddosRange, f : Double) -> NetsecddosRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosRange::add(self : NetsecddosRange, other : NetsecddosRange) -> NetsecddosRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosRange::copy(self : NetsecddosRange) -> NetsecddosRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosRange::fill(self : NetsecddosRange, v : Double) -> NetsecddosRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosRange::min(self : NetsecddosRange) -> Double { @_common.min(self.data) }

pub fn NetsecddosRange::max(self : NetsecddosRange) -> Double { @_common.max(self.data) }

pub fn NetsecddosRange::to_string(self : NetsecddosRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecddosSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_slice_make(size : Int) -> NetsecddosSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecddosSlice::len(self : NetsecddosSlice) -> Int { self.size }

pub fn NetsecddosSlice::get(self : NetsecddosSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecddosSlice::set(self : NetsecddosSlice, i : Int, v : Double) -> NetsecddosSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecddosSlice::sum(self : NetsecddosSlice) -> Double { @_common.sum(self.data) }

pub fn NetsecddosSlice::mean(self : NetsecddosSlice) -> Double { @_common.mean(self.data) }

pub fn NetsecddosSlice::scale(self : NetsecddosSlice, f : Double) -> NetsecddosSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecddosSlice::add(self : NetsecddosSlice, other : NetsecddosSlice) -> NetsecddosSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecddosSlice::copy(self : NetsecddosSlice) -> NetsecddosSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecddosSlice::fill(self : NetsecddosSlice, v : Double) -> NetsecddosSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecddosSlice::min(self : NetsecddosSlice) -> Double { @_common.min(self.data) }

pub fn NetsecddosSlice::max(self : NetsecddosSlice) -> Double { @_common.max(self.data) }

pub fn NetsecddosSlice::to_string(self : NetsecddosSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

