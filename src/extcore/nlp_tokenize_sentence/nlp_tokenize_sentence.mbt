///===
/// extcore/nlp_tokenize_sentence

pub(all) struct NlptokenizesentencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_sentence_make_point(x : Double, y : Double) -> NlptokenizesentencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_sentence_make_point3(x : Double, y : Double, z : Double) -> NlptokenizesentencePoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizesentencePoint::x(self : NlptokenizesentencePoint) -> Double { self.x }

pub fn NlptokenizesentencePoint::y(self : NlptokenizesentencePoint) -> Double { self.y }

pub fn NlptokenizesentencePoint::z(self : NlptokenizesentencePoint) -> Double { self.z }

pub fn NlptokenizesentencePoint::label(self : NlptokenizesentencePoint) -> Int { self.label }

pub fn NlptokenizesentencePoint::dist(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizesentencePoint::add(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizesentencePoint::sub(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizesentencePoint::scale(self : NlptokenizesentencePoint, s : Double) -> NlptokenizesentencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizesentencePoint::dot(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizesentencePoint::cross(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizesentencePoint::norm(self : NlptokenizesentencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizesentencePoint::normalize(self : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesentencePoint::negate(self : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizesentencePoint::mid(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizesentencePoint::lerp(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint, t : Double) -> NlptokenizesentencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizesentencePoint::to_string(self : NlptokenizesentencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizesentenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_sentence_make_series(vals : Array[Double], name : String) -> NlptokenizesentenceSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizesentenceSeries::len(self : NlptokenizesentenceSeries) -> Int { self.vals.length() }

pub fn NlptokenizesentenceSeries::sum(self : NlptokenizesentenceSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizesentenceSeries::mean(self : NlptokenizesentenceSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizesentenceSeries::min(self : NlptokenizesentenceSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizesentenceSeries::max(self : NlptokenizesentenceSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizesentenceSeries::range(self : NlptokenizesentenceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizesentenceSeries::variance(self : NlptokenizesentenceSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizesentenceSeries::std(self : NlptokenizesentenceSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizesentenceSeries::median(self : NlptokenizesentenceSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizesentenceSeries::scale(self : NlptokenizesentenceSeries, f : Double) -> NlptokenizesentenceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizesentenceSeries::add(self : NlptokenizesentenceSeries, other : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizesentenceSeries::sub(self : NlptokenizesentenceSeries, other : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizesentenceSeries::normalize(self : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizesentenceSeries::cumsum(self : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizesentenceSeries::to_string(self : NlptokenizesentenceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesentenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_sentence_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizesentenceMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_tokenize_sentence_matrix_identity(n : Int) -> NlptokenizesentenceMatrix {
  let m = nlp_tokenize_sentence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizesentenceMatrix::get(self : NlptokenizesentenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizesentenceMatrix::transpose(self : NlptokenizesentenceMatrix) -> NlptokenizesentenceMatrix {
  let result = nlp_tokenize_sentence_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizesentenceMatrix::add(self : NlptokenizesentenceMatrix, other : NlptokenizesentenceMatrix) -> NlptokenizesentenceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_sentence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizesentenceMatrix::scale(self : NlptokenizesentenceMatrix, s : Double) -> NlptokenizesentenceMatrix {
  let result = nlp_tokenize_sentence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizesentenceMatrix::multiply(self : NlptokenizesentenceMatrix, other : NlptokenizesentenceMatrix) -> NlptokenizesentenceMatrix {
  if self.cols != other.rows { return nlp_tokenize_sentence_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_sentence_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlptokenizesentenceMatrix::trace(self : NlptokenizesentenceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizesentenceMatrix::det(self : NlptokenizesentenceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizesentenceMatrix::norm(self : NlptokenizesentenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizesentenceMatrix::to_string(self : NlptokenizesentenceMatrix) -> String {
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

pub(all) struct NlptokenizesentenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_sentence_make_vector(comps : Array[Double]) -> NlptokenizesentenceVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_sentence_vector_zero(dim : Int) -> NlptokenizesentenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizesentenceVector::add(self : NlptokenizesentenceVector, other : NlptokenizesentenceVector) -> NlptokenizesentenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesentenceVector::sub(self : NlptokenizesentenceVector, other : NlptokenizesentenceVector) -> NlptokenizesentenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesentenceVector::scale(self : NlptokenizesentenceVector, s : Double) -> NlptokenizesentenceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizesentenceVector::dot(self : NlptokenizesentenceVector, other : NlptokenizesentenceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizesentenceVector::norm(self : NlptokenizesentenceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizesentenceVector::normalize(self : NlptokenizesentenceVector) -> NlptokenizesentenceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesentenceVector::dist(self : NlptokenizesentenceVector, other : NlptokenizesentenceVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizesentenceVector::to_string(self : NlptokenizesentenceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesentenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_frame_make(size : Int) -> NlptokenizesentenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceFrame::len(self : NlptokenizesentenceFrame) -> Int { self.size }

pub fn NlptokenizesentenceFrame::get(self : NlptokenizesentenceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceFrame::set(self : NlptokenizesentenceFrame, i : Int, v : Double) -> NlptokenizesentenceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceFrame::sum(self : NlptokenizesentenceFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceFrame::mean(self : NlptokenizesentenceFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceFrame::scale(self : NlptokenizesentenceFrame, f : Double) -> NlptokenizesentenceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceFrame::add(self : NlptokenizesentenceFrame, other : NlptokenizesentenceFrame) -> NlptokenizesentenceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceFrame::copy(self : NlptokenizesentenceFrame) -> NlptokenizesentenceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceFrame::fill(self : NlptokenizesentenceFrame, v : Double) -> NlptokenizesentenceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceFrame::min(self : NlptokenizesentenceFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceFrame::max(self : NlptokenizesentenceFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceFrame::to_string(self : NlptokenizesentenceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_table_make(size : Int) -> NlptokenizesentenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceTable::len(self : NlptokenizesentenceTable) -> Int { self.size }

pub fn NlptokenizesentenceTable::get(self : NlptokenizesentenceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceTable::set(self : NlptokenizesentenceTable, i : Int, v : Double) -> NlptokenizesentenceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceTable::sum(self : NlptokenizesentenceTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceTable::mean(self : NlptokenizesentenceTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceTable::scale(self : NlptokenizesentenceTable, f : Double) -> NlptokenizesentenceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceTable::add(self : NlptokenizesentenceTable, other : NlptokenizesentenceTable) -> NlptokenizesentenceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceTable::copy(self : NlptokenizesentenceTable) -> NlptokenizesentenceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceTable::fill(self : NlptokenizesentenceTable, v : Double) -> NlptokenizesentenceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceTable::min(self : NlptokenizesentenceTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceTable::max(self : NlptokenizesentenceTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceTable::to_string(self : NlptokenizesentenceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_graphn_make(size : Int) -> NlptokenizesentenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceGraphN::len(self : NlptokenizesentenceGraphN) -> Int { self.size }

pub fn NlptokenizesentenceGraphN::get(self : NlptokenizesentenceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceGraphN::set(self : NlptokenizesentenceGraphN, i : Int, v : Double) -> NlptokenizesentenceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceGraphN::sum(self : NlptokenizesentenceGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceGraphN::mean(self : NlptokenizesentenceGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceGraphN::scale(self : NlptokenizesentenceGraphN, f : Double) -> NlptokenizesentenceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceGraphN::add(self : NlptokenizesentenceGraphN, other : NlptokenizesentenceGraphN) -> NlptokenizesentenceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceGraphN::copy(self : NlptokenizesentenceGraphN) -> NlptokenizesentenceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceGraphN::fill(self : NlptokenizesentenceGraphN, v : Double) -> NlptokenizesentenceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceGraphN::min(self : NlptokenizesentenceGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceGraphN::max(self : NlptokenizesentenceGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceGraphN::to_string(self : NlptokenizesentenceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_node_make(size : Int) -> NlptokenizesentenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceNode::len(self : NlptokenizesentenceNode) -> Int { self.size }

pub fn NlptokenizesentenceNode::get(self : NlptokenizesentenceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceNode::set(self : NlptokenizesentenceNode, i : Int, v : Double) -> NlptokenizesentenceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceNode::sum(self : NlptokenizesentenceNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceNode::mean(self : NlptokenizesentenceNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceNode::scale(self : NlptokenizesentenceNode, f : Double) -> NlptokenizesentenceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceNode::add(self : NlptokenizesentenceNode, other : NlptokenizesentenceNode) -> NlptokenizesentenceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceNode::copy(self : NlptokenizesentenceNode) -> NlptokenizesentenceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceNode::fill(self : NlptokenizesentenceNode, v : Double) -> NlptokenizesentenceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceNode::min(self : NlptokenizesentenceNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceNode::max(self : NlptokenizesentenceNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceNode::to_string(self : NlptokenizesentenceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_edge_make(size : Int) -> NlptokenizesentenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceEdge::len(self : NlptokenizesentenceEdge) -> Int { self.size }

pub fn NlptokenizesentenceEdge::get(self : NlptokenizesentenceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceEdge::set(self : NlptokenizesentenceEdge, i : Int, v : Double) -> NlptokenizesentenceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceEdge::sum(self : NlptokenizesentenceEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceEdge::mean(self : NlptokenizesentenceEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceEdge::scale(self : NlptokenizesentenceEdge, f : Double) -> NlptokenizesentenceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceEdge::add(self : NlptokenizesentenceEdge, other : NlptokenizesentenceEdge) -> NlptokenizesentenceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceEdge::copy(self : NlptokenizesentenceEdge) -> NlptokenizesentenceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceEdge::fill(self : NlptokenizesentenceEdge, v : Double) -> NlptokenizesentenceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceEdge::min(self : NlptokenizesentenceEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceEdge::max(self : NlptokenizesentenceEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceEdge::to_string(self : NlptokenizesentenceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_path_make(size : Int) -> NlptokenizesentencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentencePath::len(self : NlptokenizesentencePath) -> Int { self.size }

pub fn NlptokenizesentencePath::get(self : NlptokenizesentencePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentencePath::set(self : NlptokenizesentencePath, i : Int, v : Double) -> NlptokenizesentencePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentencePath::sum(self : NlptokenizesentencePath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentencePath::mean(self : NlptokenizesentencePath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentencePath::scale(self : NlptokenizesentencePath, f : Double) -> NlptokenizesentencePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentencePath::add(self : NlptokenizesentencePath, other : NlptokenizesentencePath) -> NlptokenizesentencePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentencePath::copy(self : NlptokenizesentencePath) -> NlptokenizesentencePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentencePath::fill(self : NlptokenizesentencePath, v : Double) -> NlptokenizesentencePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentencePath::min(self : NlptokenizesentencePath) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentencePath::max(self : NlptokenizesentencePath) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentencePath::to_string(self : NlptokenizesentencePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_cluster_make(size : Int) -> NlptokenizesentenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceCluster::len(self : NlptokenizesentenceCluster) -> Int { self.size }

pub fn NlptokenizesentenceCluster::get(self : NlptokenizesentenceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceCluster::set(self : NlptokenizesentenceCluster, i : Int, v : Double) -> NlptokenizesentenceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceCluster::sum(self : NlptokenizesentenceCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceCluster::mean(self : NlptokenizesentenceCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceCluster::scale(self : NlptokenizesentenceCluster, f : Double) -> NlptokenizesentenceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceCluster::add(self : NlptokenizesentenceCluster, other : NlptokenizesentenceCluster) -> NlptokenizesentenceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceCluster::copy(self : NlptokenizesentenceCluster) -> NlptokenizesentenceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceCluster::fill(self : NlptokenizesentenceCluster, v : Double) -> NlptokenizesentenceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceCluster::min(self : NlptokenizesentenceCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceCluster::max(self : NlptokenizesentenceCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceCluster::to_string(self : NlptokenizesentenceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_model_make(size : Int) -> NlptokenizesentenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceModel::len(self : NlptokenizesentenceModel) -> Int { self.size }

pub fn NlptokenizesentenceModel::get(self : NlptokenizesentenceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceModel::set(self : NlptokenizesentenceModel, i : Int, v : Double) -> NlptokenizesentenceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceModel::sum(self : NlptokenizesentenceModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceModel::mean(self : NlptokenizesentenceModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceModel::scale(self : NlptokenizesentenceModel, f : Double) -> NlptokenizesentenceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceModel::add(self : NlptokenizesentenceModel, other : NlptokenizesentenceModel) -> NlptokenizesentenceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceModel::copy(self : NlptokenizesentenceModel) -> NlptokenizesentenceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceModel::fill(self : NlptokenizesentenceModel, v : Double) -> NlptokenizesentenceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceModel::min(self : NlptokenizesentenceModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceModel::max(self : NlptokenizesentenceModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceModel::to_string(self : NlptokenizesentenceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_layer_make(size : Int) -> NlptokenizesentenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceLayer::len(self : NlptokenizesentenceLayer) -> Int { self.size }

pub fn NlptokenizesentenceLayer::get(self : NlptokenizesentenceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceLayer::set(self : NlptokenizesentenceLayer, i : Int, v : Double) -> NlptokenizesentenceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceLayer::sum(self : NlptokenizesentenceLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceLayer::mean(self : NlptokenizesentenceLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceLayer::scale(self : NlptokenizesentenceLayer, f : Double) -> NlptokenizesentenceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceLayer::add(self : NlptokenizesentenceLayer, other : NlptokenizesentenceLayer) -> NlptokenizesentenceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceLayer::copy(self : NlptokenizesentenceLayer) -> NlptokenizesentenceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceLayer::fill(self : NlptokenizesentenceLayer, v : Double) -> NlptokenizesentenceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceLayer::min(self : NlptokenizesentenceLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceLayer::max(self : NlptokenizesentenceLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceLayer::to_string(self : NlptokenizesentenceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_buffer_make(size : Int) -> NlptokenizesentenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceBuffer::len(self : NlptokenizesentenceBuffer) -> Int { self.size }

pub fn NlptokenizesentenceBuffer::get(self : NlptokenizesentenceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceBuffer::set(self : NlptokenizesentenceBuffer, i : Int, v : Double) -> NlptokenizesentenceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceBuffer::sum(self : NlptokenizesentenceBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceBuffer::mean(self : NlptokenizesentenceBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceBuffer::scale(self : NlptokenizesentenceBuffer, f : Double) -> NlptokenizesentenceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceBuffer::add(self : NlptokenizesentenceBuffer, other : NlptokenizesentenceBuffer) -> NlptokenizesentenceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceBuffer::copy(self : NlptokenizesentenceBuffer) -> NlptokenizesentenceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceBuffer::fill(self : NlptokenizesentenceBuffer, v : Double) -> NlptokenizesentenceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceBuffer::min(self : NlptokenizesentenceBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceBuffer::max(self : NlptokenizesentenceBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceBuffer::to_string(self : NlptokenizesentenceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_cursor_make(size : Int) -> NlptokenizesentenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceCursor::len(self : NlptokenizesentenceCursor) -> Int { self.size }

pub fn NlptokenizesentenceCursor::get(self : NlptokenizesentenceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceCursor::set(self : NlptokenizesentenceCursor, i : Int, v : Double) -> NlptokenizesentenceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceCursor::sum(self : NlptokenizesentenceCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceCursor::mean(self : NlptokenizesentenceCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceCursor::scale(self : NlptokenizesentenceCursor, f : Double) -> NlptokenizesentenceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceCursor::add(self : NlptokenizesentenceCursor, other : NlptokenizesentenceCursor) -> NlptokenizesentenceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceCursor::copy(self : NlptokenizesentenceCursor) -> NlptokenizesentenceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceCursor::fill(self : NlptokenizesentenceCursor, v : Double) -> NlptokenizesentenceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceCursor::min(self : NlptokenizesentenceCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceCursor::max(self : NlptokenizesentenceCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceCursor::to_string(self : NlptokenizesentenceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_view_make(size : Int) -> NlptokenizesentenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceView::len(self : NlptokenizesentenceView) -> Int { self.size }

pub fn NlptokenizesentenceView::get(self : NlptokenizesentenceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceView::set(self : NlptokenizesentenceView, i : Int, v : Double) -> NlptokenizesentenceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceView::sum(self : NlptokenizesentenceView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceView::mean(self : NlptokenizesentenceView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceView::scale(self : NlptokenizesentenceView, f : Double) -> NlptokenizesentenceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceView::add(self : NlptokenizesentenceView, other : NlptokenizesentenceView) -> NlptokenizesentenceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceView::copy(self : NlptokenizesentenceView) -> NlptokenizesentenceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceView::fill(self : NlptokenizesentenceView, v : Double) -> NlptokenizesentenceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceView::min(self : NlptokenizesentenceView) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceView::max(self : NlptokenizesentenceView) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceView::to_string(self : NlptokenizesentenceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_range_make(size : Int) -> NlptokenizesentenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceRange::len(self : NlptokenizesentenceRange) -> Int { self.size }

pub fn NlptokenizesentenceRange::get(self : NlptokenizesentenceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceRange::set(self : NlptokenizesentenceRange, i : Int, v : Double) -> NlptokenizesentenceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceRange::sum(self : NlptokenizesentenceRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceRange::mean(self : NlptokenizesentenceRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceRange::scale(self : NlptokenizesentenceRange, f : Double) -> NlptokenizesentenceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceRange::add(self : NlptokenizesentenceRange, other : NlptokenizesentenceRange) -> NlptokenizesentenceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceRange::copy(self : NlptokenizesentenceRange) -> NlptokenizesentenceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceRange::fill(self : NlptokenizesentenceRange, v : Double) -> NlptokenizesentenceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceRange::min(self : NlptokenizesentenceRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceRange::max(self : NlptokenizesentenceRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceRange::to_string(self : NlptokenizesentenceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_slice_make(size : Int) -> NlptokenizesentenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesentenceSlice::len(self : NlptokenizesentenceSlice) -> Int { self.size }

pub fn NlptokenizesentenceSlice::get(self : NlptokenizesentenceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesentenceSlice::set(self : NlptokenizesentenceSlice, i : Int, v : Double) -> NlptokenizesentenceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceSlice::sum(self : NlptokenizesentenceSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesentenceSlice::mean(self : NlptokenizesentenceSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesentenceSlice::scale(self : NlptokenizesentenceSlice, f : Double) -> NlptokenizesentenceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceSlice::add(self : NlptokenizesentenceSlice, other : NlptokenizesentenceSlice) -> NlptokenizesentenceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesentenceSlice::copy(self : NlptokenizesentenceSlice) -> NlptokenizesentenceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceSlice::fill(self : NlptokenizesentenceSlice, v : Double) -> NlptokenizesentenceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesentenceSlice::min(self : NlptokenizesentenceSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizesentenceSlice::max(self : NlptokenizesentenceSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizesentenceSlice::to_string(self : NlptokenizesentenceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

