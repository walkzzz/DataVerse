///===
/// extcore/nlp_tokenize_char

pub(all) struct NlptokenizecharPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_char_make_point(x : Double, y : Double) -> NlptokenizecharPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_char_make_point3(x : Double, y : Double, z : Double) -> NlptokenizecharPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizecharPoint::x(self : NlptokenizecharPoint) -> Double { self.x }

pub fn NlptokenizecharPoint::y(self : NlptokenizecharPoint) -> Double { self.y }

pub fn NlptokenizecharPoint::z(self : NlptokenizecharPoint) -> Double { self.z }

pub fn NlptokenizecharPoint::label(self : NlptokenizecharPoint) -> Int { self.label }

pub fn NlptokenizecharPoint::dist(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizecharPoint::add(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizecharPoint::sub(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizecharPoint::scale(self : NlptokenizecharPoint, s : Double) -> NlptokenizecharPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizecharPoint::dot(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizecharPoint::cross(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizecharPoint::norm(self : NlptokenizecharPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizecharPoint::normalize(self : NlptokenizecharPoint) -> NlptokenizecharPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizecharPoint::negate(self : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizecharPoint::mid(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizecharPoint::lerp(self : NlptokenizecharPoint, other : NlptokenizecharPoint, t : Double) -> NlptokenizecharPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizecharPoint::to_string(self : NlptokenizecharPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizecharSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_char_make_series(vals : Array[Double], name : String) -> NlptokenizecharSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizecharSeries::len(self : NlptokenizecharSeries) -> Int { self.vals.length() }

pub fn NlptokenizecharSeries::sum(self : NlptokenizecharSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizecharSeries::mean(self : NlptokenizecharSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizecharSeries::min(self : NlptokenizecharSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizecharSeries::max(self : NlptokenizecharSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizecharSeries::range(self : NlptokenizecharSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizecharSeries::variance(self : NlptokenizecharSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizecharSeries::std(self : NlptokenizecharSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizecharSeries::median(self : NlptokenizecharSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizecharSeries::scale(self : NlptokenizecharSeries, f : Double) -> NlptokenizecharSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizecharSeries::add(self : NlptokenizecharSeries, other : NlptokenizecharSeries) -> NlptokenizecharSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizecharSeries::sub(self : NlptokenizecharSeries, other : NlptokenizecharSeries) -> NlptokenizecharSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizecharSeries::normalize(self : NlptokenizecharSeries) -> NlptokenizecharSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizecharSeries::cumsum(self : NlptokenizecharSeries) -> NlptokenizecharSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizecharSeries::to_string(self : NlptokenizecharSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizecharMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_char_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizecharMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_char_matrix_identity(n : Int) -> NlptokenizecharMatrix {
  let m = nlp_tokenize_char_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizecharMatrix::get(self : NlptokenizecharMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizecharMatrix::transpose(self : NlptokenizecharMatrix) -> NlptokenizecharMatrix {
  let result = nlp_tokenize_char_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizecharMatrix::add(self : NlptokenizecharMatrix, other : NlptokenizecharMatrix) -> NlptokenizecharMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_char_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizecharMatrix::scale(self : NlptokenizecharMatrix, s : Double) -> NlptokenizecharMatrix {
  let result = nlp_tokenize_char_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizecharMatrix::multiply(self : NlptokenizecharMatrix, other : NlptokenizecharMatrix) -> NlptokenizecharMatrix {
  if self.cols != other.rows { return nlp_tokenize_char_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_char_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizecharMatrix::trace(self : NlptokenizecharMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizecharMatrix::det(self : NlptokenizecharMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizecharMatrix::norm(self : NlptokenizecharMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizecharMatrix::to_string(self : NlptokenizecharMatrix) -> String {
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

pub(all) struct NlptokenizecharVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_char_make_vector(comps : Array[Double]) -> NlptokenizecharVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_char_vector_zero(dim : Int) -> NlptokenizecharVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizecharVector::add(self : NlptokenizecharVector, other : NlptokenizecharVector) -> NlptokenizecharVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizecharVector::sub(self : NlptokenizecharVector, other : NlptokenizecharVector) -> NlptokenizecharVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizecharVector::scale(self : NlptokenizecharVector, s : Double) -> NlptokenizecharVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizecharVector::dot(self : NlptokenizecharVector, other : NlptokenizecharVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizecharVector::norm(self : NlptokenizecharVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizecharVector::normalize(self : NlptokenizecharVector) -> NlptokenizecharVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizecharVector::dist(self : NlptokenizecharVector, other : NlptokenizecharVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizecharVector::to_string(self : NlptokenizecharVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizecharFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_frame_make(size : Int) -> NlptokenizecharFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharFrame::len(self : NlptokenizecharFrame) -> Int { self.size }

pub fn NlptokenizecharFrame::get(self : NlptokenizecharFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharFrame::set(self : NlptokenizecharFrame, i : Int, v : Double) -> NlptokenizecharFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharFrame::sum(self : NlptokenizecharFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharFrame::mean(self : NlptokenizecharFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharFrame::scale(self : NlptokenizecharFrame, f : Double) -> NlptokenizecharFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharFrame::add(self : NlptokenizecharFrame, other : NlptokenizecharFrame) -> NlptokenizecharFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharFrame::copy(self : NlptokenizecharFrame) -> NlptokenizecharFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharFrame::fill(self : NlptokenizecharFrame, v : Double) -> NlptokenizecharFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharFrame::min(self : NlptokenizecharFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharFrame::max(self : NlptokenizecharFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharFrame::to_string(self : NlptokenizecharFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_table_make(size : Int) -> NlptokenizecharTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharTable::len(self : NlptokenizecharTable) -> Int { self.size }

pub fn NlptokenizecharTable::get(self : NlptokenizecharTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharTable::set(self : NlptokenizecharTable, i : Int, v : Double) -> NlptokenizecharTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharTable::sum(self : NlptokenizecharTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharTable::mean(self : NlptokenizecharTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharTable::scale(self : NlptokenizecharTable, f : Double) -> NlptokenizecharTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharTable::add(self : NlptokenizecharTable, other : NlptokenizecharTable) -> NlptokenizecharTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharTable::copy(self : NlptokenizecharTable) -> NlptokenizecharTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharTable::fill(self : NlptokenizecharTable, v : Double) -> NlptokenizecharTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharTable::min(self : NlptokenizecharTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharTable::max(self : NlptokenizecharTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharTable::to_string(self : NlptokenizecharTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_graphn_make(size : Int) -> NlptokenizecharGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharGraphN::len(self : NlptokenizecharGraphN) -> Int { self.size }

pub fn NlptokenizecharGraphN::get(self : NlptokenizecharGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharGraphN::set(self : NlptokenizecharGraphN, i : Int, v : Double) -> NlptokenizecharGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharGraphN::sum(self : NlptokenizecharGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharGraphN::mean(self : NlptokenizecharGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharGraphN::scale(self : NlptokenizecharGraphN, f : Double) -> NlptokenizecharGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharGraphN::add(self : NlptokenizecharGraphN, other : NlptokenizecharGraphN) -> NlptokenizecharGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharGraphN::copy(self : NlptokenizecharGraphN) -> NlptokenizecharGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharGraphN::fill(self : NlptokenizecharGraphN, v : Double) -> NlptokenizecharGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharGraphN::min(self : NlptokenizecharGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharGraphN::max(self : NlptokenizecharGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharGraphN::to_string(self : NlptokenizecharGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_node_make(size : Int) -> NlptokenizecharNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharNode::len(self : NlptokenizecharNode) -> Int { self.size }

pub fn NlptokenizecharNode::get(self : NlptokenizecharNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharNode::set(self : NlptokenizecharNode, i : Int, v : Double) -> NlptokenizecharNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharNode::sum(self : NlptokenizecharNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharNode::mean(self : NlptokenizecharNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharNode::scale(self : NlptokenizecharNode, f : Double) -> NlptokenizecharNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharNode::add(self : NlptokenizecharNode, other : NlptokenizecharNode) -> NlptokenizecharNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharNode::copy(self : NlptokenizecharNode) -> NlptokenizecharNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharNode::fill(self : NlptokenizecharNode, v : Double) -> NlptokenizecharNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharNode::min(self : NlptokenizecharNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharNode::max(self : NlptokenizecharNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharNode::to_string(self : NlptokenizecharNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_edge_make(size : Int) -> NlptokenizecharEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharEdge::len(self : NlptokenizecharEdge) -> Int { self.size }

pub fn NlptokenizecharEdge::get(self : NlptokenizecharEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharEdge::set(self : NlptokenizecharEdge, i : Int, v : Double) -> NlptokenizecharEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharEdge::sum(self : NlptokenizecharEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharEdge::mean(self : NlptokenizecharEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharEdge::scale(self : NlptokenizecharEdge, f : Double) -> NlptokenizecharEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharEdge::add(self : NlptokenizecharEdge, other : NlptokenizecharEdge) -> NlptokenizecharEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharEdge::copy(self : NlptokenizecharEdge) -> NlptokenizecharEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharEdge::fill(self : NlptokenizecharEdge, v : Double) -> NlptokenizecharEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharEdge::min(self : NlptokenizecharEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharEdge::max(self : NlptokenizecharEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharEdge::to_string(self : NlptokenizecharEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_path_make(size : Int) -> NlptokenizecharPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharPath::len(self : NlptokenizecharPath) -> Int { self.size }

pub fn NlptokenizecharPath::get(self : NlptokenizecharPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharPath::set(self : NlptokenizecharPath, i : Int, v : Double) -> NlptokenizecharPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharPath::sum(self : NlptokenizecharPath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharPath::mean(self : NlptokenizecharPath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharPath::scale(self : NlptokenizecharPath, f : Double) -> NlptokenizecharPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharPath::add(self : NlptokenizecharPath, other : NlptokenizecharPath) -> NlptokenizecharPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharPath::copy(self : NlptokenizecharPath) -> NlptokenizecharPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharPath::fill(self : NlptokenizecharPath, v : Double) -> NlptokenizecharPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharPath::min(self : NlptokenizecharPath) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharPath::max(self : NlptokenizecharPath) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharPath::to_string(self : NlptokenizecharPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_cluster_make(size : Int) -> NlptokenizecharCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharCluster::len(self : NlptokenizecharCluster) -> Int { self.size }

pub fn NlptokenizecharCluster::get(self : NlptokenizecharCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharCluster::set(self : NlptokenizecharCluster, i : Int, v : Double) -> NlptokenizecharCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharCluster::sum(self : NlptokenizecharCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharCluster::mean(self : NlptokenizecharCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharCluster::scale(self : NlptokenizecharCluster, f : Double) -> NlptokenizecharCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharCluster::add(self : NlptokenizecharCluster, other : NlptokenizecharCluster) -> NlptokenizecharCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharCluster::copy(self : NlptokenizecharCluster) -> NlptokenizecharCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharCluster::fill(self : NlptokenizecharCluster, v : Double) -> NlptokenizecharCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharCluster::min(self : NlptokenizecharCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharCluster::max(self : NlptokenizecharCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharCluster::to_string(self : NlptokenizecharCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_model_make(size : Int) -> NlptokenizecharModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharModel::len(self : NlptokenizecharModel) -> Int { self.size }

pub fn NlptokenizecharModel::get(self : NlptokenizecharModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharModel::set(self : NlptokenizecharModel, i : Int, v : Double) -> NlptokenizecharModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharModel::sum(self : NlptokenizecharModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharModel::mean(self : NlptokenizecharModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharModel::scale(self : NlptokenizecharModel, f : Double) -> NlptokenizecharModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharModel::add(self : NlptokenizecharModel, other : NlptokenizecharModel) -> NlptokenizecharModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharModel::copy(self : NlptokenizecharModel) -> NlptokenizecharModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharModel::fill(self : NlptokenizecharModel, v : Double) -> NlptokenizecharModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharModel::min(self : NlptokenizecharModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharModel::max(self : NlptokenizecharModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharModel::to_string(self : NlptokenizecharModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_layer_make(size : Int) -> NlptokenizecharLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharLayer::len(self : NlptokenizecharLayer) -> Int { self.size }

pub fn NlptokenizecharLayer::get(self : NlptokenizecharLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharLayer::set(self : NlptokenizecharLayer, i : Int, v : Double) -> NlptokenizecharLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharLayer::sum(self : NlptokenizecharLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharLayer::mean(self : NlptokenizecharLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharLayer::scale(self : NlptokenizecharLayer, f : Double) -> NlptokenizecharLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharLayer::add(self : NlptokenizecharLayer, other : NlptokenizecharLayer) -> NlptokenizecharLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharLayer::copy(self : NlptokenizecharLayer) -> NlptokenizecharLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharLayer::fill(self : NlptokenizecharLayer, v : Double) -> NlptokenizecharLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharLayer::min(self : NlptokenizecharLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharLayer::max(self : NlptokenizecharLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharLayer::to_string(self : NlptokenizecharLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_buffer_make(size : Int) -> NlptokenizecharBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharBuffer::len(self : NlptokenizecharBuffer) -> Int { self.size }

pub fn NlptokenizecharBuffer::get(self : NlptokenizecharBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharBuffer::set(self : NlptokenizecharBuffer, i : Int, v : Double) -> NlptokenizecharBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharBuffer::sum(self : NlptokenizecharBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharBuffer::mean(self : NlptokenizecharBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharBuffer::scale(self : NlptokenizecharBuffer, f : Double) -> NlptokenizecharBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharBuffer::add(self : NlptokenizecharBuffer, other : NlptokenizecharBuffer) -> NlptokenizecharBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharBuffer::copy(self : NlptokenizecharBuffer) -> NlptokenizecharBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharBuffer::fill(self : NlptokenizecharBuffer, v : Double) -> NlptokenizecharBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharBuffer::min(self : NlptokenizecharBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharBuffer::max(self : NlptokenizecharBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharBuffer::to_string(self : NlptokenizecharBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_cursor_make(size : Int) -> NlptokenizecharCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharCursor::len(self : NlptokenizecharCursor) -> Int { self.size }

pub fn NlptokenizecharCursor::get(self : NlptokenizecharCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharCursor::set(self : NlptokenizecharCursor, i : Int, v : Double) -> NlptokenizecharCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharCursor::sum(self : NlptokenizecharCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharCursor::mean(self : NlptokenizecharCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharCursor::scale(self : NlptokenizecharCursor, f : Double) -> NlptokenizecharCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharCursor::add(self : NlptokenizecharCursor, other : NlptokenizecharCursor) -> NlptokenizecharCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharCursor::copy(self : NlptokenizecharCursor) -> NlptokenizecharCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharCursor::fill(self : NlptokenizecharCursor, v : Double) -> NlptokenizecharCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharCursor::min(self : NlptokenizecharCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharCursor::max(self : NlptokenizecharCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharCursor::to_string(self : NlptokenizecharCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_view_make(size : Int) -> NlptokenizecharView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharView::len(self : NlptokenizecharView) -> Int { self.size }

pub fn NlptokenizecharView::get(self : NlptokenizecharView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharView::set(self : NlptokenizecharView, i : Int, v : Double) -> NlptokenizecharView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharView::sum(self : NlptokenizecharView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharView::mean(self : NlptokenizecharView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharView::scale(self : NlptokenizecharView, f : Double) -> NlptokenizecharView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharView::add(self : NlptokenizecharView, other : NlptokenizecharView) -> NlptokenizecharView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharView::copy(self : NlptokenizecharView) -> NlptokenizecharView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharView::fill(self : NlptokenizecharView, v : Double) -> NlptokenizecharView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharView::min(self : NlptokenizecharView) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharView::max(self : NlptokenizecharView) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharView::to_string(self : NlptokenizecharView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_range_make(size : Int) -> NlptokenizecharRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharRange::len(self : NlptokenizecharRange) -> Int { self.size }

pub fn NlptokenizecharRange::get(self : NlptokenizecharRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharRange::set(self : NlptokenizecharRange, i : Int, v : Double) -> NlptokenizecharRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharRange::sum(self : NlptokenizecharRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharRange::mean(self : NlptokenizecharRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharRange::scale(self : NlptokenizecharRange, f : Double) -> NlptokenizecharRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharRange::add(self : NlptokenizecharRange, other : NlptokenizecharRange) -> NlptokenizecharRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharRange::copy(self : NlptokenizecharRange) -> NlptokenizecharRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharRange::fill(self : NlptokenizecharRange, v : Double) -> NlptokenizecharRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharRange::min(self : NlptokenizecharRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharRange::max(self : NlptokenizecharRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharRange::to_string(self : NlptokenizecharRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_slice_make(size : Int) -> NlptokenizecharSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizecharSlice::len(self : NlptokenizecharSlice) -> Int { self.size }

pub fn NlptokenizecharSlice::get(self : NlptokenizecharSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizecharSlice::set(self : NlptokenizecharSlice, i : Int, v : Double) -> NlptokenizecharSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizecharSlice::sum(self : NlptokenizecharSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizecharSlice::mean(self : NlptokenizecharSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizecharSlice::scale(self : NlptokenizecharSlice, f : Double) -> NlptokenizecharSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharSlice::add(self : NlptokenizecharSlice, other : NlptokenizecharSlice) -> NlptokenizecharSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizecharSlice::copy(self : NlptokenizecharSlice) -> NlptokenizecharSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharSlice::fill(self : NlptokenizecharSlice, v : Double) -> NlptokenizecharSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizecharSlice::min(self : NlptokenizecharSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizecharSlice::max(self : NlptokenizecharSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizecharSlice::to_string(self : NlptokenizecharSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

