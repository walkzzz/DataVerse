///===
/// extcore/math_sparse_matrix

pub(all) struct MathsparsematrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_sparse_matrix_make_point(x : Double, y : Double) -> MathsparsematrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_sparse_matrix_make_point3(x : Double, y : Double, z : Double) -> MathsparsematrixPoint {
  { x, y, z, label: 0 }
}

pub fn MathsparsematrixPoint::x(self : MathsparsematrixPoint) -> Double { self.x }

pub fn MathsparsematrixPoint::y(self : MathsparsematrixPoint) -> Double { self.y }

pub fn MathsparsematrixPoint::z(self : MathsparsematrixPoint) -> Double { self.z }

pub fn MathsparsematrixPoint::label(self : MathsparsematrixPoint) -> Int { self.label }

pub fn MathsparsematrixPoint::dist(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathsparsematrixPoint::add(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathsparsematrixPoint::sub(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathsparsematrixPoint::scale(self : MathsparsematrixPoint, s : Double) -> MathsparsematrixPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathsparsematrixPoint::dot(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathsparsematrixPoint::cross(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathsparsematrixPoint::norm(self : MathsparsematrixPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathsparsematrixPoint::normalize(self : MathsparsematrixPoint) -> MathsparsematrixPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathsparsematrixPoint::negate(self : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathsparsematrixPoint::mid(self : MathsparsematrixPoint, other : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathsparsematrixPoint::lerp(self : MathsparsematrixPoint, other : MathsparsematrixPoint, t : Double) -> MathsparsematrixPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathsparsematrixPoint::to_string(self : MathsparsematrixPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathsparsematrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_sparse_matrix_make_series(vals : Array[Double], name : String) -> MathsparsematrixSeries {
  { vals, name, meta: 0 }
}

pub fn MathsparsematrixSeries::len(self : MathsparsematrixSeries) -> Int { self.vals.length() }

pub fn MathsparsematrixSeries::sum(self : MathsparsematrixSeries) -> Double { @_common.sum(self.vals) }

pub fn MathsparsematrixSeries::mean(self : MathsparsematrixSeries) -> Double { @_common.mean(self.vals) }

pub fn MathsparsematrixSeries::min(self : MathsparsematrixSeries) -> Double { @_common.min(self.vals) }

pub fn MathsparsematrixSeries::max(self : MathsparsematrixSeries) -> Double { @_common.max(self.vals) }

pub fn MathsparsematrixSeries::range(self : MathsparsematrixSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathsparsematrixSeries::variance(self : MathsparsematrixSeries) -> Double { @_common.variance(self.vals) }

pub fn MathsparsematrixSeries::std(self : MathsparsematrixSeries) -> Double { @_common.std(self.vals) }

pub fn MathsparsematrixSeries::median(self : MathsparsematrixSeries) -> Double { @_common.median(self.vals) }

pub fn MathsparsematrixSeries::scale(self : MathsparsematrixSeries, f : Double) -> MathsparsematrixSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathsparsematrixSeries::add(self : MathsparsematrixSeries, other : MathsparsematrixSeries) -> MathsparsematrixSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathsparsematrixSeries::sub(self : MathsparsematrixSeries, other : MathsparsematrixSeries) -> MathsparsematrixSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathsparsematrixSeries::normalize(self : MathsparsematrixSeries) -> MathsparsematrixSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathsparsematrixSeries::cumsum(self : MathsparsematrixSeries) -> MathsparsematrixSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathsparsematrixSeries::to_string(self : MathsparsematrixSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathsparsematrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_sparse_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> MathsparsematrixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_sparse_matrix_matrix_identity(n : Int) -> MathsparsematrixMatrix {
  let m = math_sparse_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathsparsematrixMatrix::get(self : MathsparsematrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathsparsematrixMatrix::transpose(self : MathsparsematrixMatrix) -> MathsparsematrixMatrix {
  let result = math_sparse_matrix_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathsparsematrixMatrix::add(self : MathsparsematrixMatrix, other : MathsparsematrixMatrix) -> MathsparsematrixMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_sparse_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathsparsematrixMatrix::scale(self : MathsparsematrixMatrix, s : Double) -> MathsparsematrixMatrix {
  let result = math_sparse_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathsparsematrixMatrix::multiply(self : MathsparsematrixMatrix, other : MathsparsematrixMatrix) -> MathsparsematrixMatrix {
  if self.cols != other.rows { return math_sparse_matrix_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_sparse_matrix_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathsparsematrixMatrix::trace(self : MathsparsematrixMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathsparsematrixMatrix::det(self : MathsparsematrixMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathsparsematrixMatrix::norm(self : MathsparsematrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathsparsematrixMatrix::to_string(self : MathsparsematrixMatrix) -> String {
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

pub(all) struct MathsparsematrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_sparse_matrix_make_vector(comps : Array[Double]) -> MathsparsematrixVector {
  { comps, dim: comps.length() }
}

pub fn math_sparse_matrix_vector_zero(dim : Int) -> MathsparsematrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathsparsematrixVector::add(self : MathsparsematrixVector, other : MathsparsematrixVector) -> MathsparsematrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathsparsematrixVector::sub(self : MathsparsematrixVector, other : MathsparsematrixVector) -> MathsparsematrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathsparsematrixVector::scale(self : MathsparsematrixVector, s : Double) -> MathsparsematrixVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathsparsematrixVector::dot(self : MathsparsematrixVector, other : MathsparsematrixVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathsparsematrixVector::norm(self : MathsparsematrixVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathsparsematrixVector::normalize(self : MathsparsematrixVector) -> MathsparsematrixVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathsparsematrixVector::dist(self : MathsparsematrixVector, other : MathsparsematrixVector) -> Double {
  self.sub(other).norm()
}

pub fn MathsparsematrixVector::to_string(self : MathsparsematrixVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathsparsematrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_frame_make(size : Int) -> MathsparsematrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixFrame::len(self : MathsparsematrixFrame) -> Int { self.size }

pub fn MathsparsematrixFrame::get(self : MathsparsematrixFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixFrame::set(self : MathsparsematrixFrame, i : Int, v : Double) -> MathsparsematrixFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixFrame::sum(self : MathsparsematrixFrame) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixFrame::mean(self : MathsparsematrixFrame) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixFrame::scale(self : MathsparsematrixFrame, f : Double) -> MathsparsematrixFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixFrame::add(self : MathsparsematrixFrame, other : MathsparsematrixFrame) -> MathsparsematrixFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixFrame::copy(self : MathsparsematrixFrame) -> MathsparsematrixFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixFrame::fill(self : MathsparsematrixFrame, v : Double) -> MathsparsematrixFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixFrame::min(self : MathsparsematrixFrame) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixFrame::max(self : MathsparsematrixFrame) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixFrame::to_string(self : MathsparsematrixFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_table_make(size : Int) -> MathsparsematrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixTable::len(self : MathsparsematrixTable) -> Int { self.size }

pub fn MathsparsematrixTable::get(self : MathsparsematrixTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixTable::set(self : MathsparsematrixTable, i : Int, v : Double) -> MathsparsematrixTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixTable::sum(self : MathsparsematrixTable) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixTable::mean(self : MathsparsematrixTable) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixTable::scale(self : MathsparsematrixTable, f : Double) -> MathsparsematrixTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixTable::add(self : MathsparsematrixTable, other : MathsparsematrixTable) -> MathsparsematrixTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixTable::copy(self : MathsparsematrixTable) -> MathsparsematrixTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixTable::fill(self : MathsparsematrixTable, v : Double) -> MathsparsematrixTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixTable::min(self : MathsparsematrixTable) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixTable::max(self : MathsparsematrixTable) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixTable::to_string(self : MathsparsematrixTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_graphn_make(size : Int) -> MathsparsematrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixGraphN::len(self : MathsparsematrixGraphN) -> Int { self.size }

pub fn MathsparsematrixGraphN::get(self : MathsparsematrixGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixGraphN::set(self : MathsparsematrixGraphN, i : Int, v : Double) -> MathsparsematrixGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixGraphN::sum(self : MathsparsematrixGraphN) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixGraphN::mean(self : MathsparsematrixGraphN) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixGraphN::scale(self : MathsparsematrixGraphN, f : Double) -> MathsparsematrixGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixGraphN::add(self : MathsparsematrixGraphN, other : MathsparsematrixGraphN) -> MathsparsematrixGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixGraphN::copy(self : MathsparsematrixGraphN) -> MathsparsematrixGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixGraphN::fill(self : MathsparsematrixGraphN, v : Double) -> MathsparsematrixGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixGraphN::min(self : MathsparsematrixGraphN) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixGraphN::max(self : MathsparsematrixGraphN) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixGraphN::to_string(self : MathsparsematrixGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_node_make(size : Int) -> MathsparsematrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixNode::len(self : MathsparsematrixNode) -> Int { self.size }

pub fn MathsparsematrixNode::get(self : MathsparsematrixNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixNode::set(self : MathsparsematrixNode, i : Int, v : Double) -> MathsparsematrixNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixNode::sum(self : MathsparsematrixNode) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixNode::mean(self : MathsparsematrixNode) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixNode::scale(self : MathsparsematrixNode, f : Double) -> MathsparsematrixNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixNode::add(self : MathsparsematrixNode, other : MathsparsematrixNode) -> MathsparsematrixNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixNode::copy(self : MathsparsematrixNode) -> MathsparsematrixNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixNode::fill(self : MathsparsematrixNode, v : Double) -> MathsparsematrixNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixNode::min(self : MathsparsematrixNode) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixNode::max(self : MathsparsematrixNode) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixNode::to_string(self : MathsparsematrixNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_edge_make(size : Int) -> MathsparsematrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixEdge::len(self : MathsparsematrixEdge) -> Int { self.size }

pub fn MathsparsematrixEdge::get(self : MathsparsematrixEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixEdge::set(self : MathsparsematrixEdge, i : Int, v : Double) -> MathsparsematrixEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixEdge::sum(self : MathsparsematrixEdge) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixEdge::mean(self : MathsparsematrixEdge) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixEdge::scale(self : MathsparsematrixEdge, f : Double) -> MathsparsematrixEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixEdge::add(self : MathsparsematrixEdge, other : MathsparsematrixEdge) -> MathsparsematrixEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixEdge::copy(self : MathsparsematrixEdge) -> MathsparsematrixEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixEdge::fill(self : MathsparsematrixEdge, v : Double) -> MathsparsematrixEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixEdge::min(self : MathsparsematrixEdge) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixEdge::max(self : MathsparsematrixEdge) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixEdge::to_string(self : MathsparsematrixEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_path_make(size : Int) -> MathsparsematrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixPath::len(self : MathsparsematrixPath) -> Int { self.size }

pub fn MathsparsematrixPath::get(self : MathsparsematrixPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixPath::set(self : MathsparsematrixPath, i : Int, v : Double) -> MathsparsematrixPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixPath::sum(self : MathsparsematrixPath) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixPath::mean(self : MathsparsematrixPath) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixPath::scale(self : MathsparsematrixPath, f : Double) -> MathsparsematrixPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixPath::add(self : MathsparsematrixPath, other : MathsparsematrixPath) -> MathsparsematrixPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixPath::copy(self : MathsparsematrixPath) -> MathsparsematrixPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixPath::fill(self : MathsparsematrixPath, v : Double) -> MathsparsematrixPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixPath::min(self : MathsparsematrixPath) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixPath::max(self : MathsparsematrixPath) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixPath::to_string(self : MathsparsematrixPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_cluster_make(size : Int) -> MathsparsematrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixCluster::len(self : MathsparsematrixCluster) -> Int { self.size }

pub fn MathsparsematrixCluster::get(self : MathsparsematrixCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixCluster::set(self : MathsparsematrixCluster, i : Int, v : Double) -> MathsparsematrixCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixCluster::sum(self : MathsparsematrixCluster) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixCluster::mean(self : MathsparsematrixCluster) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixCluster::scale(self : MathsparsematrixCluster, f : Double) -> MathsparsematrixCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixCluster::add(self : MathsparsematrixCluster, other : MathsparsematrixCluster) -> MathsparsematrixCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixCluster::copy(self : MathsparsematrixCluster) -> MathsparsematrixCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixCluster::fill(self : MathsparsematrixCluster, v : Double) -> MathsparsematrixCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixCluster::min(self : MathsparsematrixCluster) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixCluster::max(self : MathsparsematrixCluster) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixCluster::to_string(self : MathsparsematrixCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_model_make(size : Int) -> MathsparsematrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixModel::len(self : MathsparsematrixModel) -> Int { self.size }

pub fn MathsparsematrixModel::get(self : MathsparsematrixModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixModel::set(self : MathsparsematrixModel, i : Int, v : Double) -> MathsparsematrixModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixModel::sum(self : MathsparsematrixModel) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixModel::mean(self : MathsparsematrixModel) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixModel::scale(self : MathsparsematrixModel, f : Double) -> MathsparsematrixModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixModel::add(self : MathsparsematrixModel, other : MathsparsematrixModel) -> MathsparsematrixModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixModel::copy(self : MathsparsematrixModel) -> MathsparsematrixModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixModel::fill(self : MathsparsematrixModel, v : Double) -> MathsparsematrixModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixModel::min(self : MathsparsematrixModel) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixModel::max(self : MathsparsematrixModel) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixModel::to_string(self : MathsparsematrixModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_layer_make(size : Int) -> MathsparsematrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixLayer::len(self : MathsparsematrixLayer) -> Int { self.size }

pub fn MathsparsematrixLayer::get(self : MathsparsematrixLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixLayer::set(self : MathsparsematrixLayer, i : Int, v : Double) -> MathsparsematrixLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixLayer::sum(self : MathsparsematrixLayer) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixLayer::mean(self : MathsparsematrixLayer) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixLayer::scale(self : MathsparsematrixLayer, f : Double) -> MathsparsematrixLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixLayer::add(self : MathsparsematrixLayer, other : MathsparsematrixLayer) -> MathsparsematrixLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixLayer::copy(self : MathsparsematrixLayer) -> MathsparsematrixLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixLayer::fill(self : MathsparsematrixLayer, v : Double) -> MathsparsematrixLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixLayer::min(self : MathsparsematrixLayer) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixLayer::max(self : MathsparsematrixLayer) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixLayer::to_string(self : MathsparsematrixLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_buffer_make(size : Int) -> MathsparsematrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixBuffer::len(self : MathsparsematrixBuffer) -> Int { self.size }

pub fn MathsparsematrixBuffer::get(self : MathsparsematrixBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixBuffer::set(self : MathsparsematrixBuffer, i : Int, v : Double) -> MathsparsematrixBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixBuffer::sum(self : MathsparsematrixBuffer) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixBuffer::mean(self : MathsparsematrixBuffer) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixBuffer::scale(self : MathsparsematrixBuffer, f : Double) -> MathsparsematrixBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixBuffer::add(self : MathsparsematrixBuffer, other : MathsparsematrixBuffer) -> MathsparsematrixBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixBuffer::copy(self : MathsparsematrixBuffer) -> MathsparsematrixBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixBuffer::fill(self : MathsparsematrixBuffer, v : Double) -> MathsparsematrixBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixBuffer::min(self : MathsparsematrixBuffer) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixBuffer::max(self : MathsparsematrixBuffer) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixBuffer::to_string(self : MathsparsematrixBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_cursor_make(size : Int) -> MathsparsematrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixCursor::len(self : MathsparsematrixCursor) -> Int { self.size }

pub fn MathsparsematrixCursor::get(self : MathsparsematrixCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixCursor::set(self : MathsparsematrixCursor, i : Int, v : Double) -> MathsparsematrixCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixCursor::sum(self : MathsparsematrixCursor) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixCursor::mean(self : MathsparsematrixCursor) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixCursor::scale(self : MathsparsematrixCursor, f : Double) -> MathsparsematrixCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixCursor::add(self : MathsparsematrixCursor, other : MathsparsematrixCursor) -> MathsparsematrixCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixCursor::copy(self : MathsparsematrixCursor) -> MathsparsematrixCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixCursor::fill(self : MathsparsematrixCursor, v : Double) -> MathsparsematrixCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixCursor::min(self : MathsparsematrixCursor) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixCursor::max(self : MathsparsematrixCursor) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixCursor::to_string(self : MathsparsematrixCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_view_make(size : Int) -> MathsparsematrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixView::len(self : MathsparsematrixView) -> Int { self.size }

pub fn MathsparsematrixView::get(self : MathsparsematrixView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixView::set(self : MathsparsematrixView, i : Int, v : Double) -> MathsparsematrixView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixView::sum(self : MathsparsematrixView) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixView::mean(self : MathsparsematrixView) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixView::scale(self : MathsparsematrixView, f : Double) -> MathsparsematrixView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixView::add(self : MathsparsematrixView, other : MathsparsematrixView) -> MathsparsematrixView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixView::copy(self : MathsparsematrixView) -> MathsparsematrixView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixView::fill(self : MathsparsematrixView, v : Double) -> MathsparsematrixView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixView::min(self : MathsparsematrixView) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixView::max(self : MathsparsematrixView) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixView::to_string(self : MathsparsematrixView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_range_make(size : Int) -> MathsparsematrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixRange::len(self : MathsparsematrixRange) -> Int { self.size }

pub fn MathsparsematrixRange::get(self : MathsparsematrixRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixRange::set(self : MathsparsematrixRange, i : Int, v : Double) -> MathsparsematrixRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixRange::sum(self : MathsparsematrixRange) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixRange::mean(self : MathsparsematrixRange) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixRange::scale(self : MathsparsematrixRange, f : Double) -> MathsparsematrixRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixRange::add(self : MathsparsematrixRange, other : MathsparsematrixRange) -> MathsparsematrixRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixRange::copy(self : MathsparsematrixRange) -> MathsparsematrixRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixRange::fill(self : MathsparsematrixRange, v : Double) -> MathsparsematrixRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixRange::min(self : MathsparsematrixRange) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixRange::max(self : MathsparsematrixRange) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixRange::to_string(self : MathsparsematrixRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_slice_make(size : Int) -> MathsparsematrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsparsematrixSlice::len(self : MathsparsematrixSlice) -> Int { self.size }

pub fn MathsparsematrixSlice::get(self : MathsparsematrixSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsparsematrixSlice::set(self : MathsparsematrixSlice, i : Int, v : Double) -> MathsparsematrixSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsparsematrixSlice::sum(self : MathsparsematrixSlice) -> Double { @_common.sum(self.data) }

pub fn MathsparsematrixSlice::mean(self : MathsparsematrixSlice) -> Double { @_common.mean(self.data) }

pub fn MathsparsematrixSlice::scale(self : MathsparsematrixSlice, f : Double) -> MathsparsematrixSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixSlice::add(self : MathsparsematrixSlice, other : MathsparsematrixSlice) -> MathsparsematrixSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsparsematrixSlice::copy(self : MathsparsematrixSlice) -> MathsparsematrixSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixSlice::fill(self : MathsparsematrixSlice, v : Double) -> MathsparsematrixSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsparsematrixSlice::min(self : MathsparsematrixSlice) -> Double { @_common.min(self.data) }

pub fn MathsparsematrixSlice::max(self : MathsparsematrixSlice) -> Double { @_common.max(self.data) }

pub fn MathsparsematrixSlice::to_string(self : MathsparsematrixSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

