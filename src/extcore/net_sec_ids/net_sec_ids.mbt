///===
/// extcore/net_sec_ids

pub(all) struct NetsecidsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ids_make_point(x : Double, y : Double) -> NetsecidsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ids_make_point3(x : Double, y : Double, z : Double) -> NetsecidsPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecidsPoint::x(self : NetsecidsPoint) -> Double { self.x }

pub fn NetsecidsPoint::y(self : NetsecidsPoint) -> Double { self.y }

pub fn NetsecidsPoint::z(self : NetsecidsPoint) -> Double { self.z }

pub fn NetsecidsPoint::label(self : NetsecidsPoint) -> Int { self.label }

pub fn NetsecidsPoint::dist(self : NetsecidsPoint, other : NetsecidsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecidsPoint::add(self : NetsecidsPoint, other : NetsecidsPoint) -> NetsecidsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecidsPoint::sub(self : NetsecidsPoint, other : NetsecidsPoint) -> NetsecidsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecidsPoint::scale(self : NetsecidsPoint, s : Double) -> NetsecidsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecidsPoint::dot(self : NetsecidsPoint, other : NetsecidsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecidsPoint::cross(self : NetsecidsPoint, other : NetsecidsPoint) -> NetsecidsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecidsPoint::norm(self : NetsecidsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecidsPoint::normalize(self : NetsecidsPoint) -> NetsecidsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecidsPoint::negate(self : NetsecidsPoint) -> NetsecidsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecidsPoint::mid(self : NetsecidsPoint, other : NetsecidsPoint) -> NetsecidsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecidsPoint::lerp(self : NetsecidsPoint, other : NetsecidsPoint, t : Double) -> NetsecidsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecidsPoint::to_string(self : NetsecidsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecidsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ids_make_series(vals : Array[Double], name : String) -> NetsecidsSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecidsSeries::len(self : NetsecidsSeries) -> Int { self.vals.length() }

pub fn NetsecidsSeries::sum(self : NetsecidsSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecidsSeries::mean(self : NetsecidsSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecidsSeries::min(self : NetsecidsSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecidsSeries::max(self : NetsecidsSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecidsSeries::range(self : NetsecidsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecidsSeries::variance(self : NetsecidsSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecidsSeries::std(self : NetsecidsSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecidsSeries::median(self : NetsecidsSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecidsSeries::scale(self : NetsecidsSeries, f : Double) -> NetsecidsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecidsSeries::add(self : NetsecidsSeries, other : NetsecidsSeries) -> NetsecidsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecidsSeries::sub(self : NetsecidsSeries, other : NetsecidsSeries) -> NetsecidsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecidsSeries::normalize(self : NetsecidsSeries) -> NetsecidsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecidsSeries::cumsum(self : NetsecidsSeries) -> NetsecidsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecidsSeries::to_string(self : NetsecidsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecidsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ids_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecidsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ids_matrix_identity(n : Int) -> NetsecidsMatrix {
  let m = net_sec_ids_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecidsMatrix::get(self : NetsecidsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecidsMatrix::transpose(self : NetsecidsMatrix) -> NetsecidsMatrix {
  let result = net_sec_ids_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecidsMatrix::add(self : NetsecidsMatrix, other : NetsecidsMatrix) -> NetsecidsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_ids_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecidsMatrix::scale(self : NetsecidsMatrix, s : Double) -> NetsecidsMatrix {
  let result = net_sec_ids_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecidsMatrix::multiply(self : NetsecidsMatrix, other : NetsecidsMatrix) -> NetsecidsMatrix {
  if self.cols != other.rows { return net_sec_ids_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_ids_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecidsMatrix::trace(self : NetsecidsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecidsMatrix::det(self : NetsecidsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecidsMatrix::norm(self : NetsecidsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecidsMatrix::to_string(self : NetsecidsMatrix) -> String {
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

pub(all) struct NetsecidsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ids_make_vector(comps : Array[Double]) -> NetsecidsVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ids_vector_zero(dim : Int) -> NetsecidsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecidsVector::add(self : NetsecidsVector, other : NetsecidsVector) -> NetsecidsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecidsVector::sub(self : NetsecidsVector, other : NetsecidsVector) -> NetsecidsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecidsVector::scale(self : NetsecidsVector, s : Double) -> NetsecidsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecidsVector::dot(self : NetsecidsVector, other : NetsecidsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecidsVector::norm(self : NetsecidsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecidsVector::normalize(self : NetsecidsVector) -> NetsecidsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecidsVector::dist(self : NetsecidsVector, other : NetsecidsVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecidsVector::to_string(self : NetsecidsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecidsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_frame_make(size : Int) -> NetsecidsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsFrame::len(self : NetsecidsFrame) -> Int { self.size }

pub fn NetsecidsFrame::get(self : NetsecidsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsFrame::set(self : NetsecidsFrame, i : Int, v : Double) -> NetsecidsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsFrame::sum(self : NetsecidsFrame) -> Double { @_common.sum(self.data) }

pub fn NetsecidsFrame::mean(self : NetsecidsFrame) -> Double { @_common.mean(self.data) }

pub fn NetsecidsFrame::scale(self : NetsecidsFrame, f : Double) -> NetsecidsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsFrame::add(self : NetsecidsFrame, other : NetsecidsFrame) -> NetsecidsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsFrame::copy(self : NetsecidsFrame) -> NetsecidsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsFrame::fill(self : NetsecidsFrame, v : Double) -> NetsecidsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsFrame::min(self : NetsecidsFrame) -> Double { @_common.min(self.data) }

pub fn NetsecidsFrame::max(self : NetsecidsFrame) -> Double { @_common.max(self.data) }

pub fn NetsecidsFrame::to_string(self : NetsecidsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_table_make(size : Int) -> NetsecidsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsTable::len(self : NetsecidsTable) -> Int { self.size }

pub fn NetsecidsTable::get(self : NetsecidsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsTable::set(self : NetsecidsTable, i : Int, v : Double) -> NetsecidsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsTable::sum(self : NetsecidsTable) -> Double { @_common.sum(self.data) }

pub fn NetsecidsTable::mean(self : NetsecidsTable) -> Double { @_common.mean(self.data) }

pub fn NetsecidsTable::scale(self : NetsecidsTable, f : Double) -> NetsecidsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsTable::add(self : NetsecidsTable, other : NetsecidsTable) -> NetsecidsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsTable::copy(self : NetsecidsTable) -> NetsecidsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsTable::fill(self : NetsecidsTable, v : Double) -> NetsecidsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsTable::min(self : NetsecidsTable) -> Double { @_common.min(self.data) }

pub fn NetsecidsTable::max(self : NetsecidsTable) -> Double { @_common.max(self.data) }

pub fn NetsecidsTable::to_string(self : NetsecidsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_graphn_make(size : Int) -> NetsecidsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsGraphN::len(self : NetsecidsGraphN) -> Int { self.size }

pub fn NetsecidsGraphN::get(self : NetsecidsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsGraphN::set(self : NetsecidsGraphN, i : Int, v : Double) -> NetsecidsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsGraphN::sum(self : NetsecidsGraphN) -> Double { @_common.sum(self.data) }

pub fn NetsecidsGraphN::mean(self : NetsecidsGraphN) -> Double { @_common.mean(self.data) }

pub fn NetsecidsGraphN::scale(self : NetsecidsGraphN, f : Double) -> NetsecidsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsGraphN::add(self : NetsecidsGraphN, other : NetsecidsGraphN) -> NetsecidsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsGraphN::copy(self : NetsecidsGraphN) -> NetsecidsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsGraphN::fill(self : NetsecidsGraphN, v : Double) -> NetsecidsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsGraphN::min(self : NetsecidsGraphN) -> Double { @_common.min(self.data) }

pub fn NetsecidsGraphN::max(self : NetsecidsGraphN) -> Double { @_common.max(self.data) }

pub fn NetsecidsGraphN::to_string(self : NetsecidsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_node_make(size : Int) -> NetsecidsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsNode::len(self : NetsecidsNode) -> Int { self.size }

pub fn NetsecidsNode::get(self : NetsecidsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsNode::set(self : NetsecidsNode, i : Int, v : Double) -> NetsecidsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsNode::sum(self : NetsecidsNode) -> Double { @_common.sum(self.data) }

pub fn NetsecidsNode::mean(self : NetsecidsNode) -> Double { @_common.mean(self.data) }

pub fn NetsecidsNode::scale(self : NetsecidsNode, f : Double) -> NetsecidsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsNode::add(self : NetsecidsNode, other : NetsecidsNode) -> NetsecidsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsNode::copy(self : NetsecidsNode) -> NetsecidsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsNode::fill(self : NetsecidsNode, v : Double) -> NetsecidsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsNode::min(self : NetsecidsNode) -> Double { @_common.min(self.data) }

pub fn NetsecidsNode::max(self : NetsecidsNode) -> Double { @_common.max(self.data) }

pub fn NetsecidsNode::to_string(self : NetsecidsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_edge_make(size : Int) -> NetsecidsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsEdge::len(self : NetsecidsEdge) -> Int { self.size }

pub fn NetsecidsEdge::get(self : NetsecidsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsEdge::set(self : NetsecidsEdge, i : Int, v : Double) -> NetsecidsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsEdge::sum(self : NetsecidsEdge) -> Double { @_common.sum(self.data) }

pub fn NetsecidsEdge::mean(self : NetsecidsEdge) -> Double { @_common.mean(self.data) }

pub fn NetsecidsEdge::scale(self : NetsecidsEdge, f : Double) -> NetsecidsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsEdge::add(self : NetsecidsEdge, other : NetsecidsEdge) -> NetsecidsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsEdge::copy(self : NetsecidsEdge) -> NetsecidsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsEdge::fill(self : NetsecidsEdge, v : Double) -> NetsecidsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsEdge::min(self : NetsecidsEdge) -> Double { @_common.min(self.data) }

pub fn NetsecidsEdge::max(self : NetsecidsEdge) -> Double { @_common.max(self.data) }

pub fn NetsecidsEdge::to_string(self : NetsecidsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_path_make(size : Int) -> NetsecidsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsPath::len(self : NetsecidsPath) -> Int { self.size }

pub fn NetsecidsPath::get(self : NetsecidsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsPath::set(self : NetsecidsPath, i : Int, v : Double) -> NetsecidsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsPath::sum(self : NetsecidsPath) -> Double { @_common.sum(self.data) }

pub fn NetsecidsPath::mean(self : NetsecidsPath) -> Double { @_common.mean(self.data) }

pub fn NetsecidsPath::scale(self : NetsecidsPath, f : Double) -> NetsecidsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsPath::add(self : NetsecidsPath, other : NetsecidsPath) -> NetsecidsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsPath::copy(self : NetsecidsPath) -> NetsecidsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsPath::fill(self : NetsecidsPath, v : Double) -> NetsecidsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsPath::min(self : NetsecidsPath) -> Double { @_common.min(self.data) }

pub fn NetsecidsPath::max(self : NetsecidsPath) -> Double { @_common.max(self.data) }

pub fn NetsecidsPath::to_string(self : NetsecidsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_cluster_make(size : Int) -> NetsecidsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsCluster::len(self : NetsecidsCluster) -> Int { self.size }

pub fn NetsecidsCluster::get(self : NetsecidsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsCluster::set(self : NetsecidsCluster, i : Int, v : Double) -> NetsecidsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsCluster::sum(self : NetsecidsCluster) -> Double { @_common.sum(self.data) }

pub fn NetsecidsCluster::mean(self : NetsecidsCluster) -> Double { @_common.mean(self.data) }

pub fn NetsecidsCluster::scale(self : NetsecidsCluster, f : Double) -> NetsecidsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsCluster::add(self : NetsecidsCluster, other : NetsecidsCluster) -> NetsecidsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsCluster::copy(self : NetsecidsCluster) -> NetsecidsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsCluster::fill(self : NetsecidsCluster, v : Double) -> NetsecidsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsCluster::min(self : NetsecidsCluster) -> Double { @_common.min(self.data) }

pub fn NetsecidsCluster::max(self : NetsecidsCluster) -> Double { @_common.max(self.data) }

pub fn NetsecidsCluster::to_string(self : NetsecidsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_model_make(size : Int) -> NetsecidsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsModel::len(self : NetsecidsModel) -> Int { self.size }

pub fn NetsecidsModel::get(self : NetsecidsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsModel::set(self : NetsecidsModel, i : Int, v : Double) -> NetsecidsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsModel::sum(self : NetsecidsModel) -> Double { @_common.sum(self.data) }

pub fn NetsecidsModel::mean(self : NetsecidsModel) -> Double { @_common.mean(self.data) }

pub fn NetsecidsModel::scale(self : NetsecidsModel, f : Double) -> NetsecidsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsModel::add(self : NetsecidsModel, other : NetsecidsModel) -> NetsecidsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsModel::copy(self : NetsecidsModel) -> NetsecidsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsModel::fill(self : NetsecidsModel, v : Double) -> NetsecidsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsModel::min(self : NetsecidsModel) -> Double { @_common.min(self.data) }

pub fn NetsecidsModel::max(self : NetsecidsModel) -> Double { @_common.max(self.data) }

pub fn NetsecidsModel::to_string(self : NetsecidsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_layer_make(size : Int) -> NetsecidsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsLayer::len(self : NetsecidsLayer) -> Int { self.size }

pub fn NetsecidsLayer::get(self : NetsecidsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsLayer::set(self : NetsecidsLayer, i : Int, v : Double) -> NetsecidsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsLayer::sum(self : NetsecidsLayer) -> Double { @_common.sum(self.data) }

pub fn NetsecidsLayer::mean(self : NetsecidsLayer) -> Double { @_common.mean(self.data) }

pub fn NetsecidsLayer::scale(self : NetsecidsLayer, f : Double) -> NetsecidsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsLayer::add(self : NetsecidsLayer, other : NetsecidsLayer) -> NetsecidsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsLayer::copy(self : NetsecidsLayer) -> NetsecidsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsLayer::fill(self : NetsecidsLayer, v : Double) -> NetsecidsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsLayer::min(self : NetsecidsLayer) -> Double { @_common.min(self.data) }

pub fn NetsecidsLayer::max(self : NetsecidsLayer) -> Double { @_common.max(self.data) }

pub fn NetsecidsLayer::to_string(self : NetsecidsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_buffer_make(size : Int) -> NetsecidsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsBuffer::len(self : NetsecidsBuffer) -> Int { self.size }

pub fn NetsecidsBuffer::get(self : NetsecidsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsBuffer::set(self : NetsecidsBuffer, i : Int, v : Double) -> NetsecidsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsBuffer::sum(self : NetsecidsBuffer) -> Double { @_common.sum(self.data) }

pub fn NetsecidsBuffer::mean(self : NetsecidsBuffer) -> Double { @_common.mean(self.data) }

pub fn NetsecidsBuffer::scale(self : NetsecidsBuffer, f : Double) -> NetsecidsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsBuffer::add(self : NetsecidsBuffer, other : NetsecidsBuffer) -> NetsecidsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsBuffer::copy(self : NetsecidsBuffer) -> NetsecidsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsBuffer::fill(self : NetsecidsBuffer, v : Double) -> NetsecidsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsBuffer::min(self : NetsecidsBuffer) -> Double { @_common.min(self.data) }

pub fn NetsecidsBuffer::max(self : NetsecidsBuffer) -> Double { @_common.max(self.data) }

pub fn NetsecidsBuffer::to_string(self : NetsecidsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_cursor_make(size : Int) -> NetsecidsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsCursor::len(self : NetsecidsCursor) -> Int { self.size }

pub fn NetsecidsCursor::get(self : NetsecidsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsCursor::set(self : NetsecidsCursor, i : Int, v : Double) -> NetsecidsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsCursor::sum(self : NetsecidsCursor) -> Double { @_common.sum(self.data) }

pub fn NetsecidsCursor::mean(self : NetsecidsCursor) -> Double { @_common.mean(self.data) }

pub fn NetsecidsCursor::scale(self : NetsecidsCursor, f : Double) -> NetsecidsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsCursor::add(self : NetsecidsCursor, other : NetsecidsCursor) -> NetsecidsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsCursor::copy(self : NetsecidsCursor) -> NetsecidsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsCursor::fill(self : NetsecidsCursor, v : Double) -> NetsecidsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsCursor::min(self : NetsecidsCursor) -> Double { @_common.min(self.data) }

pub fn NetsecidsCursor::max(self : NetsecidsCursor) -> Double { @_common.max(self.data) }

pub fn NetsecidsCursor::to_string(self : NetsecidsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_view_make(size : Int) -> NetsecidsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsView::len(self : NetsecidsView) -> Int { self.size }

pub fn NetsecidsView::get(self : NetsecidsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsView::set(self : NetsecidsView, i : Int, v : Double) -> NetsecidsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsView::sum(self : NetsecidsView) -> Double { @_common.sum(self.data) }

pub fn NetsecidsView::mean(self : NetsecidsView) -> Double { @_common.mean(self.data) }

pub fn NetsecidsView::scale(self : NetsecidsView, f : Double) -> NetsecidsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsView::add(self : NetsecidsView, other : NetsecidsView) -> NetsecidsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsView::copy(self : NetsecidsView) -> NetsecidsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsView::fill(self : NetsecidsView, v : Double) -> NetsecidsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsView::min(self : NetsecidsView) -> Double { @_common.min(self.data) }

pub fn NetsecidsView::max(self : NetsecidsView) -> Double { @_common.max(self.data) }

pub fn NetsecidsView::to_string(self : NetsecidsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_range_make(size : Int) -> NetsecidsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsRange::len(self : NetsecidsRange) -> Int { self.size }

pub fn NetsecidsRange::get(self : NetsecidsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsRange::set(self : NetsecidsRange, i : Int, v : Double) -> NetsecidsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsRange::sum(self : NetsecidsRange) -> Double { @_common.sum(self.data) }

pub fn NetsecidsRange::mean(self : NetsecidsRange) -> Double { @_common.mean(self.data) }

pub fn NetsecidsRange::scale(self : NetsecidsRange, f : Double) -> NetsecidsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsRange::add(self : NetsecidsRange, other : NetsecidsRange) -> NetsecidsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsRange::copy(self : NetsecidsRange) -> NetsecidsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsRange::fill(self : NetsecidsRange, v : Double) -> NetsecidsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsRange::min(self : NetsecidsRange) -> Double { @_common.min(self.data) }

pub fn NetsecidsRange::max(self : NetsecidsRange) -> Double { @_common.max(self.data) }

pub fn NetsecidsRange::to_string(self : NetsecidsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecidsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_slice_make(size : Int) -> NetsecidsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecidsSlice::len(self : NetsecidsSlice) -> Int { self.size }

pub fn NetsecidsSlice::get(self : NetsecidsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecidsSlice::set(self : NetsecidsSlice, i : Int, v : Double) -> NetsecidsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecidsSlice::sum(self : NetsecidsSlice) -> Double { @_common.sum(self.data) }

pub fn NetsecidsSlice::mean(self : NetsecidsSlice) -> Double { @_common.mean(self.data) }

pub fn NetsecidsSlice::scale(self : NetsecidsSlice, f : Double) -> NetsecidsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecidsSlice::add(self : NetsecidsSlice, other : NetsecidsSlice) -> NetsecidsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecidsSlice::copy(self : NetsecidsSlice) -> NetsecidsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecidsSlice::fill(self : NetsecidsSlice, v : Double) -> NetsecidsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecidsSlice::min(self : NetsecidsSlice) -> Double { @_common.min(self.data) }

pub fn NetsecidsSlice::max(self : NetsecidsSlice) -> Double { @_common.max(self.data) }

pub fn NetsecidsSlice::to_string(self : NetsecidsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

