///===
/// extcore/geo_buffer_segment

pub(all) struct GeobuffersegmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_segment_make_point(x : Double, y : Double) -> GeobuffersegmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_segment_make_point3(x : Double, y : Double, z : Double) -> GeobuffersegmentPoint {
  { x, y, z, label: 0 }
}

pub fn GeobuffersegmentPoint::x(self : GeobuffersegmentPoint) -> Double { self.x }

pub fn GeobuffersegmentPoint::y(self : GeobuffersegmentPoint) -> Double { self.y }

pub fn GeobuffersegmentPoint::z(self : GeobuffersegmentPoint) -> Double { self.z }

pub fn GeobuffersegmentPoint::label(self : GeobuffersegmentPoint) -> Int { self.label }

pub fn GeobuffersegmentPoint::dist(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobuffersegmentPoint::add(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobuffersegmentPoint::sub(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobuffersegmentPoint::scale(self : GeobuffersegmentPoint, s : Double) -> GeobuffersegmentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobuffersegmentPoint::dot(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobuffersegmentPoint::cross(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobuffersegmentPoint::norm(self : GeobuffersegmentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobuffersegmentPoint::normalize(self : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffersegmentPoint::negate(self : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobuffersegmentPoint::mid(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobuffersegmentPoint::lerp(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint, t : Double) -> GeobuffersegmentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobuffersegmentPoint::to_string(self : GeobuffersegmentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobuffersegmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_segment_make_series(vals : Array[Double], name : String) -> GeobuffersegmentSeries {
  { vals, name, meta: 0 }
}

pub fn GeobuffersegmentSeries::len(self : GeobuffersegmentSeries) -> Int { self.vals.length() }

pub fn GeobuffersegmentSeries::sum(self : GeobuffersegmentSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobuffersegmentSeries::mean(self : GeobuffersegmentSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobuffersegmentSeries::min(self : GeobuffersegmentSeries) -> Double { @_common.min(self.vals) }

pub fn GeobuffersegmentSeries::max(self : GeobuffersegmentSeries) -> Double { @_common.max(self.vals) }

pub fn GeobuffersegmentSeries::range(self : GeobuffersegmentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobuffersegmentSeries::variance(self : GeobuffersegmentSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobuffersegmentSeries::std(self : GeobuffersegmentSeries) -> Double { @_common.std(self.vals) }

pub fn GeobuffersegmentSeries::median(self : GeobuffersegmentSeries) -> Double { @_common.median(self.vals) }

pub fn GeobuffersegmentSeries::scale(self : GeobuffersegmentSeries, f : Double) -> GeobuffersegmentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobuffersegmentSeries::add(self : GeobuffersegmentSeries, other : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobuffersegmentSeries::sub(self : GeobuffersegmentSeries, other : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobuffersegmentSeries::normalize(self : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobuffersegmentSeries::cumsum(self : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobuffersegmentSeries::to_string(self : GeobuffersegmentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffersegmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_segment_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffersegmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_segment_matrix_identity(n : Int) -> GeobuffersegmentMatrix {
  let m = geo_buffer_segment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobuffersegmentMatrix::get(self : GeobuffersegmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobuffersegmentMatrix::transpose(self : GeobuffersegmentMatrix) -> GeobuffersegmentMatrix {
  let result = geo_buffer_segment_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobuffersegmentMatrix::add(self : GeobuffersegmentMatrix, other : GeobuffersegmentMatrix) -> GeobuffersegmentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobuffersegmentMatrix::scale(self : GeobuffersegmentMatrix, s : Double) -> GeobuffersegmentMatrix {
  let result = geo_buffer_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobuffersegmentMatrix::multiply(self : GeobuffersegmentMatrix, other : GeobuffersegmentMatrix) -> GeobuffersegmentMatrix {
  if self.cols != other.rows { return geo_buffer_segment_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_segment_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeobuffersegmentMatrix::trace(self : GeobuffersegmentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobuffersegmentMatrix::det(self : GeobuffersegmentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobuffersegmentMatrix::norm(self : GeobuffersegmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobuffersegmentMatrix::to_string(self : GeobuffersegmentMatrix) -> String {
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

pub(all) struct GeobuffersegmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_segment_make_vector(comps : Array[Double]) -> GeobuffersegmentVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_segment_vector_zero(dim : Int) -> GeobuffersegmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobuffersegmentVector::add(self : GeobuffersegmentVector, other : GeobuffersegmentVector) -> GeobuffersegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffersegmentVector::sub(self : GeobuffersegmentVector, other : GeobuffersegmentVector) -> GeobuffersegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffersegmentVector::scale(self : GeobuffersegmentVector, s : Double) -> GeobuffersegmentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobuffersegmentVector::dot(self : GeobuffersegmentVector, other : GeobuffersegmentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobuffersegmentVector::norm(self : GeobuffersegmentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobuffersegmentVector::normalize(self : GeobuffersegmentVector) -> GeobuffersegmentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffersegmentVector::dist(self : GeobuffersegmentVector, other : GeobuffersegmentVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobuffersegmentVector::to_string(self : GeobuffersegmentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffersegmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_frame_make(size : Int) -> GeobuffersegmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentFrame::len(self : GeobuffersegmentFrame) -> Int { self.size }

pub fn GeobuffersegmentFrame::get(self : GeobuffersegmentFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentFrame::set(self : GeobuffersegmentFrame, i : Int, v : Double) -> GeobuffersegmentFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentFrame::sum(self : GeobuffersegmentFrame) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentFrame::mean(self : GeobuffersegmentFrame) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentFrame::scale(self : GeobuffersegmentFrame, f : Double) -> GeobuffersegmentFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentFrame::add(self : GeobuffersegmentFrame, other : GeobuffersegmentFrame) -> GeobuffersegmentFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentFrame::copy(self : GeobuffersegmentFrame) -> GeobuffersegmentFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentFrame::fill(self : GeobuffersegmentFrame, v : Double) -> GeobuffersegmentFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentFrame::min(self : GeobuffersegmentFrame) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentFrame::max(self : GeobuffersegmentFrame) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentFrame::to_string(self : GeobuffersegmentFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_table_make(size : Int) -> GeobuffersegmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentTable::len(self : GeobuffersegmentTable) -> Int { self.size }

pub fn GeobuffersegmentTable::get(self : GeobuffersegmentTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentTable::set(self : GeobuffersegmentTable, i : Int, v : Double) -> GeobuffersegmentTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentTable::sum(self : GeobuffersegmentTable) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentTable::mean(self : GeobuffersegmentTable) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentTable::scale(self : GeobuffersegmentTable, f : Double) -> GeobuffersegmentTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentTable::add(self : GeobuffersegmentTable, other : GeobuffersegmentTable) -> GeobuffersegmentTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentTable::copy(self : GeobuffersegmentTable) -> GeobuffersegmentTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentTable::fill(self : GeobuffersegmentTable, v : Double) -> GeobuffersegmentTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentTable::min(self : GeobuffersegmentTable) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentTable::max(self : GeobuffersegmentTable) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentTable::to_string(self : GeobuffersegmentTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_graphn_make(size : Int) -> GeobuffersegmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentGraphN::len(self : GeobuffersegmentGraphN) -> Int { self.size }

pub fn GeobuffersegmentGraphN::get(self : GeobuffersegmentGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentGraphN::set(self : GeobuffersegmentGraphN, i : Int, v : Double) -> GeobuffersegmentGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentGraphN::sum(self : GeobuffersegmentGraphN) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentGraphN::mean(self : GeobuffersegmentGraphN) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentGraphN::scale(self : GeobuffersegmentGraphN, f : Double) -> GeobuffersegmentGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentGraphN::add(self : GeobuffersegmentGraphN, other : GeobuffersegmentGraphN) -> GeobuffersegmentGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentGraphN::copy(self : GeobuffersegmentGraphN) -> GeobuffersegmentGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentGraphN::fill(self : GeobuffersegmentGraphN, v : Double) -> GeobuffersegmentGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentGraphN::min(self : GeobuffersegmentGraphN) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentGraphN::max(self : GeobuffersegmentGraphN) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentGraphN::to_string(self : GeobuffersegmentGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_node_make(size : Int) -> GeobuffersegmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentNode::len(self : GeobuffersegmentNode) -> Int { self.size }

pub fn GeobuffersegmentNode::get(self : GeobuffersegmentNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentNode::set(self : GeobuffersegmentNode, i : Int, v : Double) -> GeobuffersegmentNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentNode::sum(self : GeobuffersegmentNode) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentNode::mean(self : GeobuffersegmentNode) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentNode::scale(self : GeobuffersegmentNode, f : Double) -> GeobuffersegmentNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentNode::add(self : GeobuffersegmentNode, other : GeobuffersegmentNode) -> GeobuffersegmentNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentNode::copy(self : GeobuffersegmentNode) -> GeobuffersegmentNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentNode::fill(self : GeobuffersegmentNode, v : Double) -> GeobuffersegmentNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentNode::min(self : GeobuffersegmentNode) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentNode::max(self : GeobuffersegmentNode) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentNode::to_string(self : GeobuffersegmentNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_edge_make(size : Int) -> GeobuffersegmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentEdge::len(self : GeobuffersegmentEdge) -> Int { self.size }

pub fn GeobuffersegmentEdge::get(self : GeobuffersegmentEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentEdge::set(self : GeobuffersegmentEdge, i : Int, v : Double) -> GeobuffersegmentEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentEdge::sum(self : GeobuffersegmentEdge) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentEdge::mean(self : GeobuffersegmentEdge) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentEdge::scale(self : GeobuffersegmentEdge, f : Double) -> GeobuffersegmentEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentEdge::add(self : GeobuffersegmentEdge, other : GeobuffersegmentEdge) -> GeobuffersegmentEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentEdge::copy(self : GeobuffersegmentEdge) -> GeobuffersegmentEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentEdge::fill(self : GeobuffersegmentEdge, v : Double) -> GeobuffersegmentEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentEdge::min(self : GeobuffersegmentEdge) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentEdge::max(self : GeobuffersegmentEdge) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentEdge::to_string(self : GeobuffersegmentEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_path_make(size : Int) -> GeobuffersegmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentPath::len(self : GeobuffersegmentPath) -> Int { self.size }

pub fn GeobuffersegmentPath::get(self : GeobuffersegmentPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentPath::set(self : GeobuffersegmentPath, i : Int, v : Double) -> GeobuffersegmentPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentPath::sum(self : GeobuffersegmentPath) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentPath::mean(self : GeobuffersegmentPath) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentPath::scale(self : GeobuffersegmentPath, f : Double) -> GeobuffersegmentPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentPath::add(self : GeobuffersegmentPath, other : GeobuffersegmentPath) -> GeobuffersegmentPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentPath::copy(self : GeobuffersegmentPath) -> GeobuffersegmentPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentPath::fill(self : GeobuffersegmentPath, v : Double) -> GeobuffersegmentPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentPath::min(self : GeobuffersegmentPath) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentPath::max(self : GeobuffersegmentPath) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentPath::to_string(self : GeobuffersegmentPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_cluster_make(size : Int) -> GeobuffersegmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentCluster::len(self : GeobuffersegmentCluster) -> Int { self.size }

pub fn GeobuffersegmentCluster::get(self : GeobuffersegmentCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentCluster::set(self : GeobuffersegmentCluster, i : Int, v : Double) -> GeobuffersegmentCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentCluster::sum(self : GeobuffersegmentCluster) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentCluster::mean(self : GeobuffersegmentCluster) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentCluster::scale(self : GeobuffersegmentCluster, f : Double) -> GeobuffersegmentCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentCluster::add(self : GeobuffersegmentCluster, other : GeobuffersegmentCluster) -> GeobuffersegmentCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentCluster::copy(self : GeobuffersegmentCluster) -> GeobuffersegmentCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentCluster::fill(self : GeobuffersegmentCluster, v : Double) -> GeobuffersegmentCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentCluster::min(self : GeobuffersegmentCluster) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentCluster::max(self : GeobuffersegmentCluster) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentCluster::to_string(self : GeobuffersegmentCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_model_make(size : Int) -> GeobuffersegmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentModel::len(self : GeobuffersegmentModel) -> Int { self.size }

pub fn GeobuffersegmentModel::get(self : GeobuffersegmentModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentModel::set(self : GeobuffersegmentModel, i : Int, v : Double) -> GeobuffersegmentModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentModel::sum(self : GeobuffersegmentModel) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentModel::mean(self : GeobuffersegmentModel) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentModel::scale(self : GeobuffersegmentModel, f : Double) -> GeobuffersegmentModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentModel::add(self : GeobuffersegmentModel, other : GeobuffersegmentModel) -> GeobuffersegmentModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentModel::copy(self : GeobuffersegmentModel) -> GeobuffersegmentModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentModel::fill(self : GeobuffersegmentModel, v : Double) -> GeobuffersegmentModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentModel::min(self : GeobuffersegmentModel) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentModel::max(self : GeobuffersegmentModel) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentModel::to_string(self : GeobuffersegmentModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_layer_make(size : Int) -> GeobuffersegmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentLayer::len(self : GeobuffersegmentLayer) -> Int { self.size }

pub fn GeobuffersegmentLayer::get(self : GeobuffersegmentLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentLayer::set(self : GeobuffersegmentLayer, i : Int, v : Double) -> GeobuffersegmentLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentLayer::sum(self : GeobuffersegmentLayer) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentLayer::mean(self : GeobuffersegmentLayer) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentLayer::scale(self : GeobuffersegmentLayer, f : Double) -> GeobuffersegmentLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentLayer::add(self : GeobuffersegmentLayer, other : GeobuffersegmentLayer) -> GeobuffersegmentLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentLayer::copy(self : GeobuffersegmentLayer) -> GeobuffersegmentLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentLayer::fill(self : GeobuffersegmentLayer, v : Double) -> GeobuffersegmentLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentLayer::min(self : GeobuffersegmentLayer) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentLayer::max(self : GeobuffersegmentLayer) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentLayer::to_string(self : GeobuffersegmentLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_buffer_make(size : Int) -> GeobuffersegmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentBuffer::len(self : GeobuffersegmentBuffer) -> Int { self.size }

pub fn GeobuffersegmentBuffer::get(self : GeobuffersegmentBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentBuffer::set(self : GeobuffersegmentBuffer, i : Int, v : Double) -> GeobuffersegmentBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentBuffer::sum(self : GeobuffersegmentBuffer) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentBuffer::mean(self : GeobuffersegmentBuffer) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentBuffer::scale(self : GeobuffersegmentBuffer, f : Double) -> GeobuffersegmentBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentBuffer::add(self : GeobuffersegmentBuffer, other : GeobuffersegmentBuffer) -> GeobuffersegmentBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentBuffer::copy(self : GeobuffersegmentBuffer) -> GeobuffersegmentBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentBuffer::fill(self : GeobuffersegmentBuffer, v : Double) -> GeobuffersegmentBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentBuffer::min(self : GeobuffersegmentBuffer) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentBuffer::max(self : GeobuffersegmentBuffer) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentBuffer::to_string(self : GeobuffersegmentBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_cursor_make(size : Int) -> GeobuffersegmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentCursor::len(self : GeobuffersegmentCursor) -> Int { self.size }

pub fn GeobuffersegmentCursor::get(self : GeobuffersegmentCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentCursor::set(self : GeobuffersegmentCursor, i : Int, v : Double) -> GeobuffersegmentCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentCursor::sum(self : GeobuffersegmentCursor) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentCursor::mean(self : GeobuffersegmentCursor) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentCursor::scale(self : GeobuffersegmentCursor, f : Double) -> GeobuffersegmentCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentCursor::add(self : GeobuffersegmentCursor, other : GeobuffersegmentCursor) -> GeobuffersegmentCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentCursor::copy(self : GeobuffersegmentCursor) -> GeobuffersegmentCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentCursor::fill(self : GeobuffersegmentCursor, v : Double) -> GeobuffersegmentCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentCursor::min(self : GeobuffersegmentCursor) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentCursor::max(self : GeobuffersegmentCursor) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentCursor::to_string(self : GeobuffersegmentCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_view_make(size : Int) -> GeobuffersegmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentView::len(self : GeobuffersegmentView) -> Int { self.size }

pub fn GeobuffersegmentView::get(self : GeobuffersegmentView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentView::set(self : GeobuffersegmentView, i : Int, v : Double) -> GeobuffersegmentView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentView::sum(self : GeobuffersegmentView) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentView::mean(self : GeobuffersegmentView) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentView::scale(self : GeobuffersegmentView, f : Double) -> GeobuffersegmentView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentView::add(self : GeobuffersegmentView, other : GeobuffersegmentView) -> GeobuffersegmentView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentView::copy(self : GeobuffersegmentView) -> GeobuffersegmentView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentView::fill(self : GeobuffersegmentView, v : Double) -> GeobuffersegmentView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentView::min(self : GeobuffersegmentView) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentView::max(self : GeobuffersegmentView) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentView::to_string(self : GeobuffersegmentView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_range_make(size : Int) -> GeobuffersegmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentRange::len(self : GeobuffersegmentRange) -> Int { self.size }

pub fn GeobuffersegmentRange::get(self : GeobuffersegmentRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentRange::set(self : GeobuffersegmentRange, i : Int, v : Double) -> GeobuffersegmentRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentRange::sum(self : GeobuffersegmentRange) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentRange::mean(self : GeobuffersegmentRange) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentRange::scale(self : GeobuffersegmentRange, f : Double) -> GeobuffersegmentRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentRange::add(self : GeobuffersegmentRange, other : GeobuffersegmentRange) -> GeobuffersegmentRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentRange::copy(self : GeobuffersegmentRange) -> GeobuffersegmentRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentRange::fill(self : GeobuffersegmentRange, v : Double) -> GeobuffersegmentRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentRange::min(self : GeobuffersegmentRange) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentRange::max(self : GeobuffersegmentRange) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentRange::to_string(self : GeobuffersegmentRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_slice_make(size : Int) -> GeobuffersegmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffersegmentSlice::len(self : GeobuffersegmentSlice) -> Int { self.size }

pub fn GeobuffersegmentSlice::get(self : GeobuffersegmentSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffersegmentSlice::set(self : GeobuffersegmentSlice, i : Int, v : Double) -> GeobuffersegmentSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentSlice::sum(self : GeobuffersegmentSlice) -> Double { @_common.sum(self.data) }

pub fn GeobuffersegmentSlice::mean(self : GeobuffersegmentSlice) -> Double { @_common.mean(self.data) }

pub fn GeobuffersegmentSlice::scale(self : GeobuffersegmentSlice, f : Double) -> GeobuffersegmentSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentSlice::add(self : GeobuffersegmentSlice, other : GeobuffersegmentSlice) -> GeobuffersegmentSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffersegmentSlice::copy(self : GeobuffersegmentSlice) -> GeobuffersegmentSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentSlice::fill(self : GeobuffersegmentSlice, v : Double) -> GeobuffersegmentSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffersegmentSlice::min(self : GeobuffersegmentSlice) -> Double { @_common.min(self.data) }

pub fn GeobuffersegmentSlice::max(self : GeobuffersegmentSlice) -> Double { @_common.max(self.data) }

pub fn GeobuffersegmentSlice::to_string(self : GeobuffersegmentSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

