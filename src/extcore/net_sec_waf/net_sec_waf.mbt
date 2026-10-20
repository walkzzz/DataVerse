///===
/// extcore/net_sec_waf

pub(all) struct NetsecwafPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_waf_make_point(x : Double, y : Double) -> NetsecwafPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_waf_make_point3(x : Double, y : Double, z : Double) -> NetsecwafPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecwafPoint::x(self : NetsecwafPoint) -> Double { self.x }

pub fn NetsecwafPoint::y(self : NetsecwafPoint) -> Double { self.y }

pub fn NetsecwafPoint::z(self : NetsecwafPoint) -> Double { self.z }

pub fn NetsecwafPoint::label(self : NetsecwafPoint) -> Int { self.label }

pub fn NetsecwafPoint::dist(self : NetsecwafPoint, other : NetsecwafPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecwafPoint::add(self : NetsecwafPoint, other : NetsecwafPoint) -> NetsecwafPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecwafPoint::sub(self : NetsecwafPoint, other : NetsecwafPoint) -> NetsecwafPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecwafPoint::scale(self : NetsecwafPoint, s : Double) -> NetsecwafPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecwafPoint::dot(self : NetsecwafPoint, other : NetsecwafPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecwafPoint::cross(self : NetsecwafPoint, other : NetsecwafPoint) -> NetsecwafPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecwafPoint::norm(self : NetsecwafPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecwafPoint::normalize(self : NetsecwafPoint) -> NetsecwafPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecwafPoint::negate(self : NetsecwafPoint) -> NetsecwafPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecwafPoint::mid(self : NetsecwafPoint, other : NetsecwafPoint) -> NetsecwafPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecwafPoint::lerp(self : NetsecwafPoint, other : NetsecwafPoint, t : Double) -> NetsecwafPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecwafPoint::to_string(self : NetsecwafPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecwafSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_waf_make_series(vals : Array[Double], name : String) -> NetsecwafSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecwafSeries::len(self : NetsecwafSeries) -> Int { self.vals.length() }

pub fn NetsecwafSeries::sum(self : NetsecwafSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecwafSeries::mean(self : NetsecwafSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecwafSeries::min(self : NetsecwafSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecwafSeries::max(self : NetsecwafSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecwafSeries::range(self : NetsecwafSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecwafSeries::variance(self : NetsecwafSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecwafSeries::std(self : NetsecwafSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecwafSeries::median(self : NetsecwafSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecwafSeries::scale(self : NetsecwafSeries, f : Double) -> NetsecwafSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecwafSeries::add(self : NetsecwafSeries, other : NetsecwafSeries) -> NetsecwafSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecwafSeries::sub(self : NetsecwafSeries, other : NetsecwafSeries) -> NetsecwafSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecwafSeries::normalize(self : NetsecwafSeries) -> NetsecwafSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecwafSeries::cumsum(self : NetsecwafSeries) -> NetsecwafSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecwafSeries::to_string(self : NetsecwafSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecwafMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_waf_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecwafMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_waf_matrix_identity(n : Int) -> NetsecwafMatrix {
  let m = net_sec_waf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecwafMatrix::get(self : NetsecwafMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecwafMatrix::transpose(self : NetsecwafMatrix) -> NetsecwafMatrix {
  let result = net_sec_waf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecwafMatrix::add(self : NetsecwafMatrix, other : NetsecwafMatrix) -> NetsecwafMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_waf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecwafMatrix::scale(self : NetsecwafMatrix, s : Double) -> NetsecwafMatrix {
  let result = net_sec_waf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecwafMatrix::multiply(self : NetsecwafMatrix, other : NetsecwafMatrix) -> NetsecwafMatrix {
  if self.cols != other.rows { return net_sec_waf_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_waf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecwafMatrix::trace(self : NetsecwafMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecwafMatrix::det(self : NetsecwafMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecwafMatrix::norm(self : NetsecwafMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecwafMatrix::to_string(self : NetsecwafMatrix) -> String {
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

pub(all) struct NetsecwafVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_waf_make_vector(comps : Array[Double]) -> NetsecwafVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_waf_vector_zero(dim : Int) -> NetsecwafVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecwafVector::add(self : NetsecwafVector, other : NetsecwafVector) -> NetsecwafVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecwafVector::sub(self : NetsecwafVector, other : NetsecwafVector) -> NetsecwafVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecwafVector::scale(self : NetsecwafVector, s : Double) -> NetsecwafVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecwafVector::dot(self : NetsecwafVector, other : NetsecwafVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecwafVector::norm(self : NetsecwafVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecwafVector::normalize(self : NetsecwafVector) -> NetsecwafVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecwafVector::dist(self : NetsecwafVector, other : NetsecwafVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecwafVector::to_string(self : NetsecwafVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecwafFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_frame_make(size : Int) -> NetsecwafFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafFrame::len(self : NetsecwafFrame) -> Int { self.size }

pub fn NetsecwafFrame::get(self : NetsecwafFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafFrame::set(self : NetsecwafFrame, i : Int, v : Double) -> NetsecwafFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafFrame::sum(self : NetsecwafFrame) -> Double { @_common.sum(self.data) }

pub fn NetsecwafFrame::mean(self : NetsecwafFrame) -> Double { @_common.mean(self.data) }

pub fn NetsecwafFrame::scale(self : NetsecwafFrame, f : Double) -> NetsecwafFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafFrame::add(self : NetsecwafFrame, other : NetsecwafFrame) -> NetsecwafFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafFrame::copy(self : NetsecwafFrame) -> NetsecwafFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafFrame::fill(self : NetsecwafFrame, v : Double) -> NetsecwafFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafFrame::min(self : NetsecwafFrame) -> Double { @_common.min(self.data) }

pub fn NetsecwafFrame::max(self : NetsecwafFrame) -> Double { @_common.max(self.data) }

pub fn NetsecwafFrame::to_string(self : NetsecwafFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_table_make(size : Int) -> NetsecwafTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafTable::len(self : NetsecwafTable) -> Int { self.size }

pub fn NetsecwafTable::get(self : NetsecwafTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafTable::set(self : NetsecwafTable, i : Int, v : Double) -> NetsecwafTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafTable::sum(self : NetsecwafTable) -> Double { @_common.sum(self.data) }

pub fn NetsecwafTable::mean(self : NetsecwafTable) -> Double { @_common.mean(self.data) }

pub fn NetsecwafTable::scale(self : NetsecwafTable, f : Double) -> NetsecwafTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafTable::add(self : NetsecwafTable, other : NetsecwafTable) -> NetsecwafTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafTable::copy(self : NetsecwafTable) -> NetsecwafTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafTable::fill(self : NetsecwafTable, v : Double) -> NetsecwafTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafTable::min(self : NetsecwafTable) -> Double { @_common.min(self.data) }

pub fn NetsecwafTable::max(self : NetsecwafTable) -> Double { @_common.max(self.data) }

pub fn NetsecwafTable::to_string(self : NetsecwafTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_graphn_make(size : Int) -> NetsecwafGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafGraphN::len(self : NetsecwafGraphN) -> Int { self.size }

pub fn NetsecwafGraphN::get(self : NetsecwafGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafGraphN::set(self : NetsecwafGraphN, i : Int, v : Double) -> NetsecwafGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafGraphN::sum(self : NetsecwafGraphN) -> Double { @_common.sum(self.data) }

pub fn NetsecwafGraphN::mean(self : NetsecwafGraphN) -> Double { @_common.mean(self.data) }

pub fn NetsecwafGraphN::scale(self : NetsecwafGraphN, f : Double) -> NetsecwafGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafGraphN::add(self : NetsecwafGraphN, other : NetsecwafGraphN) -> NetsecwafGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafGraphN::copy(self : NetsecwafGraphN) -> NetsecwafGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafGraphN::fill(self : NetsecwafGraphN, v : Double) -> NetsecwafGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafGraphN::min(self : NetsecwafGraphN) -> Double { @_common.min(self.data) }

pub fn NetsecwafGraphN::max(self : NetsecwafGraphN) -> Double { @_common.max(self.data) }

pub fn NetsecwafGraphN::to_string(self : NetsecwafGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_node_make(size : Int) -> NetsecwafNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafNode::len(self : NetsecwafNode) -> Int { self.size }

pub fn NetsecwafNode::get(self : NetsecwafNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafNode::set(self : NetsecwafNode, i : Int, v : Double) -> NetsecwafNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafNode::sum(self : NetsecwafNode) -> Double { @_common.sum(self.data) }

pub fn NetsecwafNode::mean(self : NetsecwafNode) -> Double { @_common.mean(self.data) }

pub fn NetsecwafNode::scale(self : NetsecwafNode, f : Double) -> NetsecwafNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafNode::add(self : NetsecwafNode, other : NetsecwafNode) -> NetsecwafNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafNode::copy(self : NetsecwafNode) -> NetsecwafNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafNode::fill(self : NetsecwafNode, v : Double) -> NetsecwafNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafNode::min(self : NetsecwafNode) -> Double { @_common.min(self.data) }

pub fn NetsecwafNode::max(self : NetsecwafNode) -> Double { @_common.max(self.data) }

pub fn NetsecwafNode::to_string(self : NetsecwafNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_edge_make(size : Int) -> NetsecwafEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafEdge::len(self : NetsecwafEdge) -> Int { self.size }

pub fn NetsecwafEdge::get(self : NetsecwafEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafEdge::set(self : NetsecwafEdge, i : Int, v : Double) -> NetsecwafEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafEdge::sum(self : NetsecwafEdge) -> Double { @_common.sum(self.data) }

pub fn NetsecwafEdge::mean(self : NetsecwafEdge) -> Double { @_common.mean(self.data) }

pub fn NetsecwafEdge::scale(self : NetsecwafEdge, f : Double) -> NetsecwafEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafEdge::add(self : NetsecwafEdge, other : NetsecwafEdge) -> NetsecwafEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafEdge::copy(self : NetsecwafEdge) -> NetsecwafEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafEdge::fill(self : NetsecwafEdge, v : Double) -> NetsecwafEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafEdge::min(self : NetsecwafEdge) -> Double { @_common.min(self.data) }

pub fn NetsecwafEdge::max(self : NetsecwafEdge) -> Double { @_common.max(self.data) }

pub fn NetsecwafEdge::to_string(self : NetsecwafEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_path_make(size : Int) -> NetsecwafPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafPath::len(self : NetsecwafPath) -> Int { self.size }

pub fn NetsecwafPath::get(self : NetsecwafPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafPath::set(self : NetsecwafPath, i : Int, v : Double) -> NetsecwafPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafPath::sum(self : NetsecwafPath) -> Double { @_common.sum(self.data) }

pub fn NetsecwafPath::mean(self : NetsecwafPath) -> Double { @_common.mean(self.data) }

pub fn NetsecwafPath::scale(self : NetsecwafPath, f : Double) -> NetsecwafPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafPath::add(self : NetsecwafPath, other : NetsecwafPath) -> NetsecwafPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafPath::copy(self : NetsecwafPath) -> NetsecwafPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafPath::fill(self : NetsecwafPath, v : Double) -> NetsecwafPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafPath::min(self : NetsecwafPath) -> Double { @_common.min(self.data) }

pub fn NetsecwafPath::max(self : NetsecwafPath) -> Double { @_common.max(self.data) }

pub fn NetsecwafPath::to_string(self : NetsecwafPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_cluster_make(size : Int) -> NetsecwafCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafCluster::len(self : NetsecwafCluster) -> Int { self.size }

pub fn NetsecwafCluster::get(self : NetsecwafCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafCluster::set(self : NetsecwafCluster, i : Int, v : Double) -> NetsecwafCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafCluster::sum(self : NetsecwafCluster) -> Double { @_common.sum(self.data) }

pub fn NetsecwafCluster::mean(self : NetsecwafCluster) -> Double { @_common.mean(self.data) }

pub fn NetsecwafCluster::scale(self : NetsecwafCluster, f : Double) -> NetsecwafCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafCluster::add(self : NetsecwafCluster, other : NetsecwafCluster) -> NetsecwafCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafCluster::copy(self : NetsecwafCluster) -> NetsecwafCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafCluster::fill(self : NetsecwafCluster, v : Double) -> NetsecwafCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafCluster::min(self : NetsecwafCluster) -> Double { @_common.min(self.data) }

pub fn NetsecwafCluster::max(self : NetsecwafCluster) -> Double { @_common.max(self.data) }

pub fn NetsecwafCluster::to_string(self : NetsecwafCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_model_make(size : Int) -> NetsecwafModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafModel::len(self : NetsecwafModel) -> Int { self.size }

pub fn NetsecwafModel::get(self : NetsecwafModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafModel::set(self : NetsecwafModel, i : Int, v : Double) -> NetsecwafModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafModel::sum(self : NetsecwafModel) -> Double { @_common.sum(self.data) }

pub fn NetsecwafModel::mean(self : NetsecwafModel) -> Double { @_common.mean(self.data) }

pub fn NetsecwafModel::scale(self : NetsecwafModel, f : Double) -> NetsecwafModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafModel::add(self : NetsecwafModel, other : NetsecwafModel) -> NetsecwafModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafModel::copy(self : NetsecwafModel) -> NetsecwafModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafModel::fill(self : NetsecwafModel, v : Double) -> NetsecwafModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafModel::min(self : NetsecwafModel) -> Double { @_common.min(self.data) }

pub fn NetsecwafModel::max(self : NetsecwafModel) -> Double { @_common.max(self.data) }

pub fn NetsecwafModel::to_string(self : NetsecwafModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_layer_make(size : Int) -> NetsecwafLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafLayer::len(self : NetsecwafLayer) -> Int { self.size }

pub fn NetsecwafLayer::get(self : NetsecwafLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafLayer::set(self : NetsecwafLayer, i : Int, v : Double) -> NetsecwafLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafLayer::sum(self : NetsecwafLayer) -> Double { @_common.sum(self.data) }

pub fn NetsecwafLayer::mean(self : NetsecwafLayer) -> Double { @_common.mean(self.data) }

pub fn NetsecwafLayer::scale(self : NetsecwafLayer, f : Double) -> NetsecwafLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafLayer::add(self : NetsecwafLayer, other : NetsecwafLayer) -> NetsecwafLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafLayer::copy(self : NetsecwafLayer) -> NetsecwafLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafLayer::fill(self : NetsecwafLayer, v : Double) -> NetsecwafLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafLayer::min(self : NetsecwafLayer) -> Double { @_common.min(self.data) }

pub fn NetsecwafLayer::max(self : NetsecwafLayer) -> Double { @_common.max(self.data) }

pub fn NetsecwafLayer::to_string(self : NetsecwafLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_buffer_make(size : Int) -> NetsecwafBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafBuffer::len(self : NetsecwafBuffer) -> Int { self.size }

pub fn NetsecwafBuffer::get(self : NetsecwafBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafBuffer::set(self : NetsecwafBuffer, i : Int, v : Double) -> NetsecwafBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafBuffer::sum(self : NetsecwafBuffer) -> Double { @_common.sum(self.data) }

pub fn NetsecwafBuffer::mean(self : NetsecwafBuffer) -> Double { @_common.mean(self.data) }

pub fn NetsecwafBuffer::scale(self : NetsecwafBuffer, f : Double) -> NetsecwafBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafBuffer::add(self : NetsecwafBuffer, other : NetsecwafBuffer) -> NetsecwafBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafBuffer::copy(self : NetsecwafBuffer) -> NetsecwafBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafBuffer::fill(self : NetsecwafBuffer, v : Double) -> NetsecwafBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafBuffer::min(self : NetsecwafBuffer) -> Double { @_common.min(self.data) }

pub fn NetsecwafBuffer::max(self : NetsecwafBuffer) -> Double { @_common.max(self.data) }

pub fn NetsecwafBuffer::to_string(self : NetsecwafBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_cursor_make(size : Int) -> NetsecwafCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafCursor::len(self : NetsecwafCursor) -> Int { self.size }

pub fn NetsecwafCursor::get(self : NetsecwafCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafCursor::set(self : NetsecwafCursor, i : Int, v : Double) -> NetsecwafCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafCursor::sum(self : NetsecwafCursor) -> Double { @_common.sum(self.data) }

pub fn NetsecwafCursor::mean(self : NetsecwafCursor) -> Double { @_common.mean(self.data) }

pub fn NetsecwafCursor::scale(self : NetsecwafCursor, f : Double) -> NetsecwafCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafCursor::add(self : NetsecwafCursor, other : NetsecwafCursor) -> NetsecwafCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafCursor::copy(self : NetsecwafCursor) -> NetsecwafCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafCursor::fill(self : NetsecwafCursor, v : Double) -> NetsecwafCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafCursor::min(self : NetsecwafCursor) -> Double { @_common.min(self.data) }

pub fn NetsecwafCursor::max(self : NetsecwafCursor) -> Double { @_common.max(self.data) }

pub fn NetsecwafCursor::to_string(self : NetsecwafCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_view_make(size : Int) -> NetsecwafView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafView::len(self : NetsecwafView) -> Int { self.size }

pub fn NetsecwafView::get(self : NetsecwafView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafView::set(self : NetsecwafView, i : Int, v : Double) -> NetsecwafView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafView::sum(self : NetsecwafView) -> Double { @_common.sum(self.data) }

pub fn NetsecwafView::mean(self : NetsecwafView) -> Double { @_common.mean(self.data) }

pub fn NetsecwafView::scale(self : NetsecwafView, f : Double) -> NetsecwafView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafView::add(self : NetsecwafView, other : NetsecwafView) -> NetsecwafView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafView::copy(self : NetsecwafView) -> NetsecwafView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafView::fill(self : NetsecwafView, v : Double) -> NetsecwafView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafView::min(self : NetsecwafView) -> Double { @_common.min(self.data) }

pub fn NetsecwafView::max(self : NetsecwafView) -> Double { @_common.max(self.data) }

pub fn NetsecwafView::to_string(self : NetsecwafView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_range_make(size : Int) -> NetsecwafRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafRange::len(self : NetsecwafRange) -> Int { self.size }

pub fn NetsecwafRange::get(self : NetsecwafRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafRange::set(self : NetsecwafRange, i : Int, v : Double) -> NetsecwafRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafRange::sum(self : NetsecwafRange) -> Double { @_common.sum(self.data) }

pub fn NetsecwafRange::mean(self : NetsecwafRange) -> Double { @_common.mean(self.data) }

pub fn NetsecwafRange::scale(self : NetsecwafRange, f : Double) -> NetsecwafRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafRange::add(self : NetsecwafRange, other : NetsecwafRange) -> NetsecwafRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafRange::copy(self : NetsecwafRange) -> NetsecwafRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafRange::fill(self : NetsecwafRange, v : Double) -> NetsecwafRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafRange::min(self : NetsecwafRange) -> Double { @_common.min(self.data) }

pub fn NetsecwafRange::max(self : NetsecwafRange) -> Double { @_common.max(self.data) }

pub fn NetsecwafRange::to_string(self : NetsecwafRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecwafSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_slice_make(size : Int) -> NetsecwafSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecwafSlice::len(self : NetsecwafSlice) -> Int { self.size }

pub fn NetsecwafSlice::get(self : NetsecwafSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecwafSlice::set(self : NetsecwafSlice, i : Int, v : Double) -> NetsecwafSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecwafSlice::sum(self : NetsecwafSlice) -> Double { @_common.sum(self.data) }

pub fn NetsecwafSlice::mean(self : NetsecwafSlice) -> Double { @_common.mean(self.data) }

pub fn NetsecwafSlice::scale(self : NetsecwafSlice, f : Double) -> NetsecwafSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecwafSlice::add(self : NetsecwafSlice, other : NetsecwafSlice) -> NetsecwafSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecwafSlice::copy(self : NetsecwafSlice) -> NetsecwafSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecwafSlice::fill(self : NetsecwafSlice, v : Double) -> NetsecwafSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecwafSlice::min(self : NetsecwafSlice) -> Double { @_common.min(self.data) }

pub fn NetsecwafSlice::max(self : NetsecwafSlice) -> Double { @_common.max(self.data) }

pub fn NetsecwafSlice::to_string(self : NetsecwafSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

