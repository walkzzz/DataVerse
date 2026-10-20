///===
/// extcore/geo_buffer_line

pub(all) struct GeobufferlinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_line_make_point(x : Double, y : Double) -> GeobufferlinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_line_make_point3(x : Double, y : Double, z : Double) -> GeobufferlinePoint {
  { x, y, z, label: 0 }
}

pub fn GeobufferlinePoint::x(self : GeobufferlinePoint) -> Double { self.x }

pub fn GeobufferlinePoint::y(self : GeobufferlinePoint) -> Double { self.y }

pub fn GeobufferlinePoint::z(self : GeobufferlinePoint) -> Double { self.z }

pub fn GeobufferlinePoint::label(self : GeobufferlinePoint) -> Int { self.label }

pub fn GeobufferlinePoint::dist(self : GeobufferlinePoint, other : GeobufferlinePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobufferlinePoint::add(self : GeobufferlinePoint, other : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobufferlinePoint::sub(self : GeobufferlinePoint, other : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobufferlinePoint::scale(self : GeobufferlinePoint, s : Double) -> GeobufferlinePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobufferlinePoint::dot(self : GeobufferlinePoint, other : GeobufferlinePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobufferlinePoint::cross(self : GeobufferlinePoint, other : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobufferlinePoint::norm(self : GeobufferlinePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobufferlinePoint::normalize(self : GeobufferlinePoint) -> GeobufferlinePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferlinePoint::negate(self : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobufferlinePoint::mid(self : GeobufferlinePoint, other : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobufferlinePoint::lerp(self : GeobufferlinePoint, other : GeobufferlinePoint, t : Double) -> GeobufferlinePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobufferlinePoint::to_string(self : GeobufferlinePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobufferlineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_line_make_series(vals : Array[Double], name : String) -> GeobufferlineSeries {
  { vals, name, meta: 0 }
}

pub fn GeobufferlineSeries::len(self : GeobufferlineSeries) -> Int { self.vals.length() }

pub fn GeobufferlineSeries::sum(self : GeobufferlineSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobufferlineSeries::mean(self : GeobufferlineSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobufferlineSeries::min(self : GeobufferlineSeries) -> Double { @_common.min(self.vals) }

pub fn GeobufferlineSeries::max(self : GeobufferlineSeries) -> Double { @_common.max(self.vals) }

pub fn GeobufferlineSeries::range(self : GeobufferlineSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobufferlineSeries::variance(self : GeobufferlineSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobufferlineSeries::std(self : GeobufferlineSeries) -> Double { @_common.std(self.vals) }

pub fn GeobufferlineSeries::median(self : GeobufferlineSeries) -> Double { @_common.median(self.vals) }

pub fn GeobufferlineSeries::scale(self : GeobufferlineSeries, f : Double) -> GeobufferlineSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobufferlineSeries::add(self : GeobufferlineSeries, other : GeobufferlineSeries) -> GeobufferlineSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobufferlineSeries::sub(self : GeobufferlineSeries, other : GeobufferlineSeries) -> GeobufferlineSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobufferlineSeries::normalize(self : GeobufferlineSeries) -> GeobufferlineSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobufferlineSeries::cumsum(self : GeobufferlineSeries) -> GeobufferlineSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobufferlineSeries::to_string(self : GeobufferlineSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferlineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_line_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferlineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_line_matrix_identity(n : Int) -> GeobufferlineMatrix {
  let m = geo_buffer_line_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobufferlineMatrix::get(self : GeobufferlineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobufferlineMatrix::transpose(self : GeobufferlineMatrix) -> GeobufferlineMatrix {
  let result = geo_buffer_line_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobufferlineMatrix::add(self : GeobufferlineMatrix, other : GeobufferlineMatrix) -> GeobufferlineMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_line_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobufferlineMatrix::scale(self : GeobufferlineMatrix, s : Double) -> GeobufferlineMatrix {
  let result = geo_buffer_line_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobufferlineMatrix::multiply(self : GeobufferlineMatrix, other : GeobufferlineMatrix) -> GeobufferlineMatrix {
  if self.cols != other.rows { return geo_buffer_line_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_line_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobufferlineMatrix::trace(self : GeobufferlineMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobufferlineMatrix::det(self : GeobufferlineMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobufferlineMatrix::norm(self : GeobufferlineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobufferlineMatrix::to_string(self : GeobufferlineMatrix) -> String {
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

pub(all) struct GeobufferlineVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_line_make_vector(comps : Array[Double]) -> GeobufferlineVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_line_vector_zero(dim : Int) -> GeobufferlineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobufferlineVector::add(self : GeobufferlineVector, other : GeobufferlineVector) -> GeobufferlineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferlineVector::sub(self : GeobufferlineVector, other : GeobufferlineVector) -> GeobufferlineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferlineVector::scale(self : GeobufferlineVector, s : Double) -> GeobufferlineVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobufferlineVector::dot(self : GeobufferlineVector, other : GeobufferlineVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobufferlineVector::norm(self : GeobufferlineVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobufferlineVector::normalize(self : GeobufferlineVector) -> GeobufferlineVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferlineVector::dist(self : GeobufferlineVector, other : GeobufferlineVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobufferlineVector::to_string(self : GeobufferlineVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferlineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_frame_make(size : Int) -> GeobufferlineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineFrame::len(self : GeobufferlineFrame) -> Int { self.size }

pub fn GeobufferlineFrame::get(self : GeobufferlineFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineFrame::set(self : GeobufferlineFrame, i : Int, v : Double) -> GeobufferlineFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineFrame::sum(self : GeobufferlineFrame) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineFrame::mean(self : GeobufferlineFrame) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineFrame::scale(self : GeobufferlineFrame, f : Double) -> GeobufferlineFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineFrame::add(self : GeobufferlineFrame, other : GeobufferlineFrame) -> GeobufferlineFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineFrame::copy(self : GeobufferlineFrame) -> GeobufferlineFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineFrame::fill(self : GeobufferlineFrame, v : Double) -> GeobufferlineFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineFrame::min(self : GeobufferlineFrame) -> Double { @_common.min(self.data) }

pub fn GeobufferlineFrame::max(self : GeobufferlineFrame) -> Double { @_common.max(self.data) }

pub fn GeobufferlineFrame::to_string(self : GeobufferlineFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_table_make(size : Int) -> GeobufferlineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineTable::len(self : GeobufferlineTable) -> Int { self.size }

pub fn GeobufferlineTable::get(self : GeobufferlineTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineTable::set(self : GeobufferlineTable, i : Int, v : Double) -> GeobufferlineTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineTable::sum(self : GeobufferlineTable) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineTable::mean(self : GeobufferlineTable) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineTable::scale(self : GeobufferlineTable, f : Double) -> GeobufferlineTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineTable::add(self : GeobufferlineTable, other : GeobufferlineTable) -> GeobufferlineTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineTable::copy(self : GeobufferlineTable) -> GeobufferlineTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineTable::fill(self : GeobufferlineTable, v : Double) -> GeobufferlineTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineTable::min(self : GeobufferlineTable) -> Double { @_common.min(self.data) }

pub fn GeobufferlineTable::max(self : GeobufferlineTable) -> Double { @_common.max(self.data) }

pub fn GeobufferlineTable::to_string(self : GeobufferlineTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_graphn_make(size : Int) -> GeobufferlineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineGraphN::len(self : GeobufferlineGraphN) -> Int { self.size }

pub fn GeobufferlineGraphN::get(self : GeobufferlineGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineGraphN::set(self : GeobufferlineGraphN, i : Int, v : Double) -> GeobufferlineGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineGraphN::sum(self : GeobufferlineGraphN) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineGraphN::mean(self : GeobufferlineGraphN) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineGraphN::scale(self : GeobufferlineGraphN, f : Double) -> GeobufferlineGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineGraphN::add(self : GeobufferlineGraphN, other : GeobufferlineGraphN) -> GeobufferlineGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineGraphN::copy(self : GeobufferlineGraphN) -> GeobufferlineGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineGraphN::fill(self : GeobufferlineGraphN, v : Double) -> GeobufferlineGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineGraphN::min(self : GeobufferlineGraphN) -> Double { @_common.min(self.data) }

pub fn GeobufferlineGraphN::max(self : GeobufferlineGraphN) -> Double { @_common.max(self.data) }

pub fn GeobufferlineGraphN::to_string(self : GeobufferlineGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_node_make(size : Int) -> GeobufferlineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineNode::len(self : GeobufferlineNode) -> Int { self.size }

pub fn GeobufferlineNode::get(self : GeobufferlineNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineNode::set(self : GeobufferlineNode, i : Int, v : Double) -> GeobufferlineNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineNode::sum(self : GeobufferlineNode) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineNode::mean(self : GeobufferlineNode) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineNode::scale(self : GeobufferlineNode, f : Double) -> GeobufferlineNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineNode::add(self : GeobufferlineNode, other : GeobufferlineNode) -> GeobufferlineNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineNode::copy(self : GeobufferlineNode) -> GeobufferlineNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineNode::fill(self : GeobufferlineNode, v : Double) -> GeobufferlineNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineNode::min(self : GeobufferlineNode) -> Double { @_common.min(self.data) }

pub fn GeobufferlineNode::max(self : GeobufferlineNode) -> Double { @_common.max(self.data) }

pub fn GeobufferlineNode::to_string(self : GeobufferlineNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_edge_make(size : Int) -> GeobufferlineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineEdge::len(self : GeobufferlineEdge) -> Int { self.size }

pub fn GeobufferlineEdge::get(self : GeobufferlineEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineEdge::set(self : GeobufferlineEdge, i : Int, v : Double) -> GeobufferlineEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineEdge::sum(self : GeobufferlineEdge) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineEdge::mean(self : GeobufferlineEdge) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineEdge::scale(self : GeobufferlineEdge, f : Double) -> GeobufferlineEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineEdge::add(self : GeobufferlineEdge, other : GeobufferlineEdge) -> GeobufferlineEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineEdge::copy(self : GeobufferlineEdge) -> GeobufferlineEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineEdge::fill(self : GeobufferlineEdge, v : Double) -> GeobufferlineEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineEdge::min(self : GeobufferlineEdge) -> Double { @_common.min(self.data) }

pub fn GeobufferlineEdge::max(self : GeobufferlineEdge) -> Double { @_common.max(self.data) }

pub fn GeobufferlineEdge::to_string(self : GeobufferlineEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_path_make(size : Int) -> GeobufferlinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlinePath::len(self : GeobufferlinePath) -> Int { self.size }

pub fn GeobufferlinePath::get(self : GeobufferlinePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlinePath::set(self : GeobufferlinePath, i : Int, v : Double) -> GeobufferlinePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlinePath::sum(self : GeobufferlinePath) -> Double { @_common.sum(self.data) }

pub fn GeobufferlinePath::mean(self : GeobufferlinePath) -> Double { @_common.mean(self.data) }

pub fn GeobufferlinePath::scale(self : GeobufferlinePath, f : Double) -> GeobufferlinePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlinePath::add(self : GeobufferlinePath, other : GeobufferlinePath) -> GeobufferlinePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlinePath::copy(self : GeobufferlinePath) -> GeobufferlinePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlinePath::fill(self : GeobufferlinePath, v : Double) -> GeobufferlinePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlinePath::min(self : GeobufferlinePath) -> Double { @_common.min(self.data) }

pub fn GeobufferlinePath::max(self : GeobufferlinePath) -> Double { @_common.max(self.data) }

pub fn GeobufferlinePath::to_string(self : GeobufferlinePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_cluster_make(size : Int) -> GeobufferlineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineCluster::len(self : GeobufferlineCluster) -> Int { self.size }

pub fn GeobufferlineCluster::get(self : GeobufferlineCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineCluster::set(self : GeobufferlineCluster, i : Int, v : Double) -> GeobufferlineCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineCluster::sum(self : GeobufferlineCluster) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineCluster::mean(self : GeobufferlineCluster) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineCluster::scale(self : GeobufferlineCluster, f : Double) -> GeobufferlineCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineCluster::add(self : GeobufferlineCluster, other : GeobufferlineCluster) -> GeobufferlineCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineCluster::copy(self : GeobufferlineCluster) -> GeobufferlineCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineCluster::fill(self : GeobufferlineCluster, v : Double) -> GeobufferlineCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineCluster::min(self : GeobufferlineCluster) -> Double { @_common.min(self.data) }

pub fn GeobufferlineCluster::max(self : GeobufferlineCluster) -> Double { @_common.max(self.data) }

pub fn GeobufferlineCluster::to_string(self : GeobufferlineCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_model_make(size : Int) -> GeobufferlineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineModel::len(self : GeobufferlineModel) -> Int { self.size }

pub fn GeobufferlineModel::get(self : GeobufferlineModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineModel::set(self : GeobufferlineModel, i : Int, v : Double) -> GeobufferlineModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineModel::sum(self : GeobufferlineModel) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineModel::mean(self : GeobufferlineModel) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineModel::scale(self : GeobufferlineModel, f : Double) -> GeobufferlineModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineModel::add(self : GeobufferlineModel, other : GeobufferlineModel) -> GeobufferlineModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineModel::copy(self : GeobufferlineModel) -> GeobufferlineModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineModel::fill(self : GeobufferlineModel, v : Double) -> GeobufferlineModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineModel::min(self : GeobufferlineModel) -> Double { @_common.min(self.data) }

pub fn GeobufferlineModel::max(self : GeobufferlineModel) -> Double { @_common.max(self.data) }

pub fn GeobufferlineModel::to_string(self : GeobufferlineModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_layer_make(size : Int) -> GeobufferlineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineLayer::len(self : GeobufferlineLayer) -> Int { self.size }

pub fn GeobufferlineLayer::get(self : GeobufferlineLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineLayer::set(self : GeobufferlineLayer, i : Int, v : Double) -> GeobufferlineLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineLayer::sum(self : GeobufferlineLayer) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineLayer::mean(self : GeobufferlineLayer) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineLayer::scale(self : GeobufferlineLayer, f : Double) -> GeobufferlineLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineLayer::add(self : GeobufferlineLayer, other : GeobufferlineLayer) -> GeobufferlineLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineLayer::copy(self : GeobufferlineLayer) -> GeobufferlineLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineLayer::fill(self : GeobufferlineLayer, v : Double) -> GeobufferlineLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineLayer::min(self : GeobufferlineLayer) -> Double { @_common.min(self.data) }

pub fn GeobufferlineLayer::max(self : GeobufferlineLayer) -> Double { @_common.max(self.data) }

pub fn GeobufferlineLayer::to_string(self : GeobufferlineLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_buffer_make(size : Int) -> GeobufferlineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineBuffer::len(self : GeobufferlineBuffer) -> Int { self.size }

pub fn GeobufferlineBuffer::get(self : GeobufferlineBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineBuffer::set(self : GeobufferlineBuffer, i : Int, v : Double) -> GeobufferlineBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineBuffer::sum(self : GeobufferlineBuffer) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineBuffer::mean(self : GeobufferlineBuffer) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineBuffer::scale(self : GeobufferlineBuffer, f : Double) -> GeobufferlineBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineBuffer::add(self : GeobufferlineBuffer, other : GeobufferlineBuffer) -> GeobufferlineBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineBuffer::copy(self : GeobufferlineBuffer) -> GeobufferlineBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineBuffer::fill(self : GeobufferlineBuffer, v : Double) -> GeobufferlineBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineBuffer::min(self : GeobufferlineBuffer) -> Double { @_common.min(self.data) }

pub fn GeobufferlineBuffer::max(self : GeobufferlineBuffer) -> Double { @_common.max(self.data) }

pub fn GeobufferlineBuffer::to_string(self : GeobufferlineBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_cursor_make(size : Int) -> GeobufferlineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineCursor::len(self : GeobufferlineCursor) -> Int { self.size }

pub fn GeobufferlineCursor::get(self : GeobufferlineCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineCursor::set(self : GeobufferlineCursor, i : Int, v : Double) -> GeobufferlineCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineCursor::sum(self : GeobufferlineCursor) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineCursor::mean(self : GeobufferlineCursor) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineCursor::scale(self : GeobufferlineCursor, f : Double) -> GeobufferlineCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineCursor::add(self : GeobufferlineCursor, other : GeobufferlineCursor) -> GeobufferlineCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineCursor::copy(self : GeobufferlineCursor) -> GeobufferlineCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineCursor::fill(self : GeobufferlineCursor, v : Double) -> GeobufferlineCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineCursor::min(self : GeobufferlineCursor) -> Double { @_common.min(self.data) }

pub fn GeobufferlineCursor::max(self : GeobufferlineCursor) -> Double { @_common.max(self.data) }

pub fn GeobufferlineCursor::to_string(self : GeobufferlineCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_view_make(size : Int) -> GeobufferlineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineView::len(self : GeobufferlineView) -> Int { self.size }

pub fn GeobufferlineView::get(self : GeobufferlineView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineView::set(self : GeobufferlineView, i : Int, v : Double) -> GeobufferlineView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineView::sum(self : GeobufferlineView) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineView::mean(self : GeobufferlineView) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineView::scale(self : GeobufferlineView, f : Double) -> GeobufferlineView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineView::add(self : GeobufferlineView, other : GeobufferlineView) -> GeobufferlineView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineView::copy(self : GeobufferlineView) -> GeobufferlineView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineView::fill(self : GeobufferlineView, v : Double) -> GeobufferlineView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineView::min(self : GeobufferlineView) -> Double { @_common.min(self.data) }

pub fn GeobufferlineView::max(self : GeobufferlineView) -> Double { @_common.max(self.data) }

pub fn GeobufferlineView::to_string(self : GeobufferlineView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_range_make(size : Int) -> GeobufferlineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineRange::len(self : GeobufferlineRange) -> Int { self.size }

pub fn GeobufferlineRange::get(self : GeobufferlineRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineRange::set(self : GeobufferlineRange, i : Int, v : Double) -> GeobufferlineRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineRange::sum(self : GeobufferlineRange) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineRange::mean(self : GeobufferlineRange) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineRange::scale(self : GeobufferlineRange, f : Double) -> GeobufferlineRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineRange::add(self : GeobufferlineRange, other : GeobufferlineRange) -> GeobufferlineRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineRange::copy(self : GeobufferlineRange) -> GeobufferlineRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineRange::fill(self : GeobufferlineRange, v : Double) -> GeobufferlineRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineRange::min(self : GeobufferlineRange) -> Double { @_common.min(self.data) }

pub fn GeobufferlineRange::max(self : GeobufferlineRange) -> Double { @_common.max(self.data) }

pub fn GeobufferlineRange::to_string(self : GeobufferlineRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferlineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_slice_make(size : Int) -> GeobufferlineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferlineSlice::len(self : GeobufferlineSlice) -> Int { self.size }

pub fn GeobufferlineSlice::get(self : GeobufferlineSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferlineSlice::set(self : GeobufferlineSlice, i : Int, v : Double) -> GeobufferlineSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferlineSlice::sum(self : GeobufferlineSlice) -> Double { @_common.sum(self.data) }

pub fn GeobufferlineSlice::mean(self : GeobufferlineSlice) -> Double { @_common.mean(self.data) }

pub fn GeobufferlineSlice::scale(self : GeobufferlineSlice, f : Double) -> GeobufferlineSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferlineSlice::add(self : GeobufferlineSlice, other : GeobufferlineSlice) -> GeobufferlineSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferlineSlice::copy(self : GeobufferlineSlice) -> GeobufferlineSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferlineSlice::fill(self : GeobufferlineSlice, v : Double) -> GeobufferlineSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferlineSlice::min(self : GeobufferlineSlice) -> Double { @_common.min(self.data) }

pub fn GeobufferlineSlice::max(self : GeobufferlineSlice) -> Double { @_common.max(self.data) }

pub fn GeobufferlineSlice::to_string(self : GeobufferlineSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

