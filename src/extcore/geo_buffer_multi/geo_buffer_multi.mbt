///===
/// extcore/geo_buffer_multi

pub(all) struct GeobuffermultiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_multi_make_point(x : Double, y : Double) -> GeobuffermultiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_multi_make_point3(x : Double, y : Double, z : Double) -> GeobuffermultiPoint {
  { x, y, z, label: 0 }
}

pub fn GeobuffermultiPoint::x(self : GeobuffermultiPoint) -> Double { self.x }

pub fn GeobuffermultiPoint::y(self : GeobuffermultiPoint) -> Double { self.y }

pub fn GeobuffermultiPoint::z(self : GeobuffermultiPoint) -> Double { self.z }

pub fn GeobuffermultiPoint::label(self : GeobuffermultiPoint) -> Int { self.label }

pub fn GeobuffermultiPoint::dist(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobuffermultiPoint::add(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobuffermultiPoint::sub(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobuffermultiPoint::scale(self : GeobuffermultiPoint, s : Double) -> GeobuffermultiPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobuffermultiPoint::dot(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobuffermultiPoint::cross(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobuffermultiPoint::norm(self : GeobuffermultiPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobuffermultiPoint::normalize(self : GeobuffermultiPoint) -> GeobuffermultiPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffermultiPoint::negate(self : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobuffermultiPoint::mid(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobuffermultiPoint::lerp(self : GeobuffermultiPoint, other : GeobuffermultiPoint, t : Double) -> GeobuffermultiPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobuffermultiPoint::to_string(self : GeobuffermultiPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobuffermultiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_multi_make_series(vals : Array[Double], name : String) -> GeobuffermultiSeries {
  { vals, name, meta: 0 }
}

pub fn GeobuffermultiSeries::len(self : GeobuffermultiSeries) -> Int { self.vals.length() }

pub fn GeobuffermultiSeries::sum(self : GeobuffermultiSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobuffermultiSeries::mean(self : GeobuffermultiSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobuffermultiSeries::min(self : GeobuffermultiSeries) -> Double { @_common.min(self.vals) }

pub fn GeobuffermultiSeries::max(self : GeobuffermultiSeries) -> Double { @_common.max(self.vals) }

pub fn GeobuffermultiSeries::range(self : GeobuffermultiSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobuffermultiSeries::variance(self : GeobuffermultiSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobuffermultiSeries::std(self : GeobuffermultiSeries) -> Double { @_common.std(self.vals) }

pub fn GeobuffermultiSeries::median(self : GeobuffermultiSeries) -> Double { @_common.median(self.vals) }

pub fn GeobuffermultiSeries::scale(self : GeobuffermultiSeries, f : Double) -> GeobuffermultiSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobuffermultiSeries::add(self : GeobuffermultiSeries, other : GeobuffermultiSeries) -> GeobuffermultiSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobuffermultiSeries::sub(self : GeobuffermultiSeries, other : GeobuffermultiSeries) -> GeobuffermultiSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobuffermultiSeries::normalize(self : GeobuffermultiSeries) -> GeobuffermultiSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobuffermultiSeries::cumsum(self : GeobuffermultiSeries) -> GeobuffermultiSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobuffermultiSeries::to_string(self : GeobuffermultiSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffermultiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_multi_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffermultiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_multi_matrix_identity(n : Int) -> GeobuffermultiMatrix {
  let m = geo_buffer_multi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobuffermultiMatrix::get(self : GeobuffermultiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobuffermultiMatrix::transpose(self : GeobuffermultiMatrix) -> GeobuffermultiMatrix {
  let result = geo_buffer_multi_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobuffermultiMatrix::add(self : GeobuffermultiMatrix, other : GeobuffermultiMatrix) -> GeobuffermultiMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_multi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobuffermultiMatrix::scale(self : GeobuffermultiMatrix, s : Double) -> GeobuffermultiMatrix {
  let result = geo_buffer_multi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobuffermultiMatrix::multiply(self : GeobuffermultiMatrix, other : GeobuffermultiMatrix) -> GeobuffermultiMatrix {
  if self.cols != other.rows { return geo_buffer_multi_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_multi_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeobuffermultiMatrix::trace(self : GeobuffermultiMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobuffermultiMatrix::det(self : GeobuffermultiMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobuffermultiMatrix::norm(self : GeobuffermultiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobuffermultiMatrix::to_string(self : GeobuffermultiMatrix) -> String {
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

pub(all) struct GeobuffermultiVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_multi_make_vector(comps : Array[Double]) -> GeobuffermultiVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_multi_vector_zero(dim : Int) -> GeobuffermultiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobuffermultiVector::add(self : GeobuffermultiVector, other : GeobuffermultiVector) -> GeobuffermultiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffermultiVector::sub(self : GeobuffermultiVector, other : GeobuffermultiVector) -> GeobuffermultiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffermultiVector::scale(self : GeobuffermultiVector, s : Double) -> GeobuffermultiVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobuffermultiVector::dot(self : GeobuffermultiVector, other : GeobuffermultiVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobuffermultiVector::norm(self : GeobuffermultiVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobuffermultiVector::normalize(self : GeobuffermultiVector) -> GeobuffermultiVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffermultiVector::dist(self : GeobuffermultiVector, other : GeobuffermultiVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobuffermultiVector::to_string(self : GeobuffermultiVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffermultiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_frame_make(size : Int) -> GeobuffermultiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiFrame::len(self : GeobuffermultiFrame) -> Int { self.size }

pub fn GeobuffermultiFrame::get(self : GeobuffermultiFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiFrame::set(self : GeobuffermultiFrame, i : Int, v : Double) -> GeobuffermultiFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiFrame::sum(self : GeobuffermultiFrame) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiFrame::mean(self : GeobuffermultiFrame) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiFrame::scale(self : GeobuffermultiFrame, f : Double) -> GeobuffermultiFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiFrame::add(self : GeobuffermultiFrame, other : GeobuffermultiFrame) -> GeobuffermultiFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiFrame::copy(self : GeobuffermultiFrame) -> GeobuffermultiFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiFrame::fill(self : GeobuffermultiFrame, v : Double) -> GeobuffermultiFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiFrame::min(self : GeobuffermultiFrame) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiFrame::max(self : GeobuffermultiFrame) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiFrame::to_string(self : GeobuffermultiFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_table_make(size : Int) -> GeobuffermultiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiTable::len(self : GeobuffermultiTable) -> Int { self.size }

pub fn GeobuffermultiTable::get(self : GeobuffermultiTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiTable::set(self : GeobuffermultiTable, i : Int, v : Double) -> GeobuffermultiTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiTable::sum(self : GeobuffermultiTable) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiTable::mean(self : GeobuffermultiTable) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiTable::scale(self : GeobuffermultiTable, f : Double) -> GeobuffermultiTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiTable::add(self : GeobuffermultiTable, other : GeobuffermultiTable) -> GeobuffermultiTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiTable::copy(self : GeobuffermultiTable) -> GeobuffermultiTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiTable::fill(self : GeobuffermultiTable, v : Double) -> GeobuffermultiTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiTable::min(self : GeobuffermultiTable) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiTable::max(self : GeobuffermultiTable) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiTable::to_string(self : GeobuffermultiTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_graphn_make(size : Int) -> GeobuffermultiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiGraphN::len(self : GeobuffermultiGraphN) -> Int { self.size }

pub fn GeobuffermultiGraphN::get(self : GeobuffermultiGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiGraphN::set(self : GeobuffermultiGraphN, i : Int, v : Double) -> GeobuffermultiGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiGraphN::sum(self : GeobuffermultiGraphN) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiGraphN::mean(self : GeobuffermultiGraphN) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiGraphN::scale(self : GeobuffermultiGraphN, f : Double) -> GeobuffermultiGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiGraphN::add(self : GeobuffermultiGraphN, other : GeobuffermultiGraphN) -> GeobuffermultiGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiGraphN::copy(self : GeobuffermultiGraphN) -> GeobuffermultiGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiGraphN::fill(self : GeobuffermultiGraphN, v : Double) -> GeobuffermultiGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiGraphN::min(self : GeobuffermultiGraphN) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiGraphN::max(self : GeobuffermultiGraphN) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiGraphN::to_string(self : GeobuffermultiGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_node_make(size : Int) -> GeobuffermultiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiNode::len(self : GeobuffermultiNode) -> Int { self.size }

pub fn GeobuffermultiNode::get(self : GeobuffermultiNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiNode::set(self : GeobuffermultiNode, i : Int, v : Double) -> GeobuffermultiNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiNode::sum(self : GeobuffermultiNode) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiNode::mean(self : GeobuffermultiNode) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiNode::scale(self : GeobuffermultiNode, f : Double) -> GeobuffermultiNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiNode::add(self : GeobuffermultiNode, other : GeobuffermultiNode) -> GeobuffermultiNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiNode::copy(self : GeobuffermultiNode) -> GeobuffermultiNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiNode::fill(self : GeobuffermultiNode, v : Double) -> GeobuffermultiNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiNode::min(self : GeobuffermultiNode) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiNode::max(self : GeobuffermultiNode) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiNode::to_string(self : GeobuffermultiNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_edge_make(size : Int) -> GeobuffermultiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiEdge::len(self : GeobuffermultiEdge) -> Int { self.size }

pub fn GeobuffermultiEdge::get(self : GeobuffermultiEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiEdge::set(self : GeobuffermultiEdge, i : Int, v : Double) -> GeobuffermultiEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiEdge::sum(self : GeobuffermultiEdge) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiEdge::mean(self : GeobuffermultiEdge) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiEdge::scale(self : GeobuffermultiEdge, f : Double) -> GeobuffermultiEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiEdge::add(self : GeobuffermultiEdge, other : GeobuffermultiEdge) -> GeobuffermultiEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiEdge::copy(self : GeobuffermultiEdge) -> GeobuffermultiEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiEdge::fill(self : GeobuffermultiEdge, v : Double) -> GeobuffermultiEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiEdge::min(self : GeobuffermultiEdge) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiEdge::max(self : GeobuffermultiEdge) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiEdge::to_string(self : GeobuffermultiEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_path_make(size : Int) -> GeobuffermultiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiPath::len(self : GeobuffermultiPath) -> Int { self.size }

pub fn GeobuffermultiPath::get(self : GeobuffermultiPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiPath::set(self : GeobuffermultiPath, i : Int, v : Double) -> GeobuffermultiPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiPath::sum(self : GeobuffermultiPath) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiPath::mean(self : GeobuffermultiPath) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiPath::scale(self : GeobuffermultiPath, f : Double) -> GeobuffermultiPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiPath::add(self : GeobuffermultiPath, other : GeobuffermultiPath) -> GeobuffermultiPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiPath::copy(self : GeobuffermultiPath) -> GeobuffermultiPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiPath::fill(self : GeobuffermultiPath, v : Double) -> GeobuffermultiPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiPath::min(self : GeobuffermultiPath) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiPath::max(self : GeobuffermultiPath) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiPath::to_string(self : GeobuffermultiPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_cluster_make(size : Int) -> GeobuffermultiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiCluster::len(self : GeobuffermultiCluster) -> Int { self.size }

pub fn GeobuffermultiCluster::get(self : GeobuffermultiCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiCluster::set(self : GeobuffermultiCluster, i : Int, v : Double) -> GeobuffermultiCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiCluster::sum(self : GeobuffermultiCluster) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiCluster::mean(self : GeobuffermultiCluster) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiCluster::scale(self : GeobuffermultiCluster, f : Double) -> GeobuffermultiCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiCluster::add(self : GeobuffermultiCluster, other : GeobuffermultiCluster) -> GeobuffermultiCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiCluster::copy(self : GeobuffermultiCluster) -> GeobuffermultiCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiCluster::fill(self : GeobuffermultiCluster, v : Double) -> GeobuffermultiCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiCluster::min(self : GeobuffermultiCluster) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiCluster::max(self : GeobuffermultiCluster) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiCluster::to_string(self : GeobuffermultiCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_model_make(size : Int) -> GeobuffermultiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiModel::len(self : GeobuffermultiModel) -> Int { self.size }

pub fn GeobuffermultiModel::get(self : GeobuffermultiModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiModel::set(self : GeobuffermultiModel, i : Int, v : Double) -> GeobuffermultiModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiModel::sum(self : GeobuffermultiModel) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiModel::mean(self : GeobuffermultiModel) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiModel::scale(self : GeobuffermultiModel, f : Double) -> GeobuffermultiModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiModel::add(self : GeobuffermultiModel, other : GeobuffermultiModel) -> GeobuffermultiModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiModel::copy(self : GeobuffermultiModel) -> GeobuffermultiModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiModel::fill(self : GeobuffermultiModel, v : Double) -> GeobuffermultiModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiModel::min(self : GeobuffermultiModel) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiModel::max(self : GeobuffermultiModel) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiModel::to_string(self : GeobuffermultiModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_layer_make(size : Int) -> GeobuffermultiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiLayer::len(self : GeobuffermultiLayer) -> Int { self.size }

pub fn GeobuffermultiLayer::get(self : GeobuffermultiLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiLayer::set(self : GeobuffermultiLayer, i : Int, v : Double) -> GeobuffermultiLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiLayer::sum(self : GeobuffermultiLayer) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiLayer::mean(self : GeobuffermultiLayer) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiLayer::scale(self : GeobuffermultiLayer, f : Double) -> GeobuffermultiLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiLayer::add(self : GeobuffermultiLayer, other : GeobuffermultiLayer) -> GeobuffermultiLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiLayer::copy(self : GeobuffermultiLayer) -> GeobuffermultiLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiLayer::fill(self : GeobuffermultiLayer, v : Double) -> GeobuffermultiLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiLayer::min(self : GeobuffermultiLayer) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiLayer::max(self : GeobuffermultiLayer) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiLayer::to_string(self : GeobuffermultiLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_buffer_make(size : Int) -> GeobuffermultiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiBuffer::len(self : GeobuffermultiBuffer) -> Int { self.size }

pub fn GeobuffermultiBuffer::get(self : GeobuffermultiBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiBuffer::set(self : GeobuffermultiBuffer, i : Int, v : Double) -> GeobuffermultiBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiBuffer::sum(self : GeobuffermultiBuffer) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiBuffer::mean(self : GeobuffermultiBuffer) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiBuffer::scale(self : GeobuffermultiBuffer, f : Double) -> GeobuffermultiBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiBuffer::add(self : GeobuffermultiBuffer, other : GeobuffermultiBuffer) -> GeobuffermultiBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiBuffer::copy(self : GeobuffermultiBuffer) -> GeobuffermultiBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiBuffer::fill(self : GeobuffermultiBuffer, v : Double) -> GeobuffermultiBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiBuffer::min(self : GeobuffermultiBuffer) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiBuffer::max(self : GeobuffermultiBuffer) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiBuffer::to_string(self : GeobuffermultiBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_cursor_make(size : Int) -> GeobuffermultiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiCursor::len(self : GeobuffermultiCursor) -> Int { self.size }

pub fn GeobuffermultiCursor::get(self : GeobuffermultiCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiCursor::set(self : GeobuffermultiCursor, i : Int, v : Double) -> GeobuffermultiCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiCursor::sum(self : GeobuffermultiCursor) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiCursor::mean(self : GeobuffermultiCursor) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiCursor::scale(self : GeobuffermultiCursor, f : Double) -> GeobuffermultiCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiCursor::add(self : GeobuffermultiCursor, other : GeobuffermultiCursor) -> GeobuffermultiCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiCursor::copy(self : GeobuffermultiCursor) -> GeobuffermultiCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiCursor::fill(self : GeobuffermultiCursor, v : Double) -> GeobuffermultiCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiCursor::min(self : GeobuffermultiCursor) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiCursor::max(self : GeobuffermultiCursor) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiCursor::to_string(self : GeobuffermultiCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_view_make(size : Int) -> GeobuffermultiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiView::len(self : GeobuffermultiView) -> Int { self.size }

pub fn GeobuffermultiView::get(self : GeobuffermultiView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiView::set(self : GeobuffermultiView, i : Int, v : Double) -> GeobuffermultiView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiView::sum(self : GeobuffermultiView) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiView::mean(self : GeobuffermultiView) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiView::scale(self : GeobuffermultiView, f : Double) -> GeobuffermultiView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiView::add(self : GeobuffermultiView, other : GeobuffermultiView) -> GeobuffermultiView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiView::copy(self : GeobuffermultiView) -> GeobuffermultiView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiView::fill(self : GeobuffermultiView, v : Double) -> GeobuffermultiView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiView::min(self : GeobuffermultiView) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiView::max(self : GeobuffermultiView) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiView::to_string(self : GeobuffermultiView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_range_make(size : Int) -> GeobuffermultiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiRange::len(self : GeobuffermultiRange) -> Int { self.size }

pub fn GeobuffermultiRange::get(self : GeobuffermultiRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiRange::set(self : GeobuffermultiRange, i : Int, v : Double) -> GeobuffermultiRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiRange::sum(self : GeobuffermultiRange) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiRange::mean(self : GeobuffermultiRange) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiRange::scale(self : GeobuffermultiRange, f : Double) -> GeobuffermultiRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiRange::add(self : GeobuffermultiRange, other : GeobuffermultiRange) -> GeobuffermultiRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiRange::copy(self : GeobuffermultiRange) -> GeobuffermultiRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiRange::fill(self : GeobuffermultiRange, v : Double) -> GeobuffermultiRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiRange::min(self : GeobuffermultiRange) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiRange::max(self : GeobuffermultiRange) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiRange::to_string(self : GeobuffermultiRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_slice_make(size : Int) -> GeobuffermultiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffermultiSlice::len(self : GeobuffermultiSlice) -> Int { self.size }

pub fn GeobuffermultiSlice::get(self : GeobuffermultiSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffermultiSlice::set(self : GeobuffermultiSlice, i : Int, v : Double) -> GeobuffermultiSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffermultiSlice::sum(self : GeobuffermultiSlice) -> Double { @_common.sum(self.data) }

pub fn GeobuffermultiSlice::mean(self : GeobuffermultiSlice) -> Double { @_common.mean(self.data) }

pub fn GeobuffermultiSlice::scale(self : GeobuffermultiSlice, f : Double) -> GeobuffermultiSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiSlice::add(self : GeobuffermultiSlice, other : GeobuffermultiSlice) -> GeobuffermultiSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffermultiSlice::copy(self : GeobuffermultiSlice) -> GeobuffermultiSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiSlice::fill(self : GeobuffermultiSlice, v : Double) -> GeobuffermultiSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffermultiSlice::min(self : GeobuffermultiSlice) -> Double { @_common.min(self.data) }

pub fn GeobuffermultiSlice::max(self : GeobuffermultiSlice) -> Double { @_common.max(self.data) }

pub fn GeobuffermultiSlice::to_string(self : GeobuffermultiSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

