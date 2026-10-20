///===
/// extcore/nlp_tokenize_morph

pub(all) struct NlptokenizemorphPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_morph_make_point(x : Double, y : Double) -> NlptokenizemorphPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_morph_make_point3(x : Double, y : Double, z : Double) -> NlptokenizemorphPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizemorphPoint::x(self : NlptokenizemorphPoint) -> Double { self.x }

pub fn NlptokenizemorphPoint::y(self : NlptokenizemorphPoint) -> Double { self.y }

pub fn NlptokenizemorphPoint::z(self : NlptokenizemorphPoint) -> Double { self.z }

pub fn NlptokenizemorphPoint::label(self : NlptokenizemorphPoint) -> Int { self.label }

pub fn NlptokenizemorphPoint::dist(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizemorphPoint::add(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizemorphPoint::sub(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizemorphPoint::scale(self : NlptokenizemorphPoint, s : Double) -> NlptokenizemorphPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizemorphPoint::dot(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizemorphPoint::cross(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizemorphPoint::norm(self : NlptokenizemorphPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizemorphPoint::normalize(self : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizemorphPoint::negate(self : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizemorphPoint::mid(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizemorphPoint::lerp(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint, t : Double) -> NlptokenizemorphPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizemorphPoint::to_string(self : NlptokenizemorphPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizemorphSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_morph_make_series(vals : Array[Double], name : String) -> NlptokenizemorphSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizemorphSeries::len(self : NlptokenizemorphSeries) -> Int { self.vals.length() }

pub fn NlptokenizemorphSeries::sum(self : NlptokenizemorphSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizemorphSeries::mean(self : NlptokenizemorphSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizemorphSeries::min(self : NlptokenizemorphSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizemorphSeries::max(self : NlptokenizemorphSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizemorphSeries::range(self : NlptokenizemorphSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizemorphSeries::variance(self : NlptokenizemorphSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizemorphSeries::std(self : NlptokenizemorphSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizemorphSeries::median(self : NlptokenizemorphSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizemorphSeries::scale(self : NlptokenizemorphSeries, f : Double) -> NlptokenizemorphSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizemorphSeries::add(self : NlptokenizemorphSeries, other : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizemorphSeries::sub(self : NlptokenizemorphSeries, other : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizemorphSeries::normalize(self : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizemorphSeries::cumsum(self : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizemorphSeries::to_string(self : NlptokenizemorphSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizemorphMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_morph_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizemorphMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_tokenize_morph_matrix_identity(n : Int) -> NlptokenizemorphMatrix {
  let m = nlp_tokenize_morph_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizemorphMatrix::get(self : NlptokenizemorphMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizemorphMatrix::transpose(self : NlptokenizemorphMatrix) -> NlptokenizemorphMatrix {
  let result = nlp_tokenize_morph_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizemorphMatrix::add(self : NlptokenizemorphMatrix, other : NlptokenizemorphMatrix) -> NlptokenizemorphMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_morph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizemorphMatrix::scale(self : NlptokenizemorphMatrix, s : Double) -> NlptokenizemorphMatrix {
  let result = nlp_tokenize_morph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizemorphMatrix::multiply(self : NlptokenizemorphMatrix, other : NlptokenizemorphMatrix) -> NlptokenizemorphMatrix {
  if self.cols != other.rows { return nlp_tokenize_morph_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_morph_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlptokenizemorphMatrix::trace(self : NlptokenizemorphMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizemorphMatrix::det(self : NlptokenizemorphMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizemorphMatrix::norm(self : NlptokenizemorphMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizemorphMatrix::to_string(self : NlptokenizemorphMatrix) -> String {
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

pub(all) struct NlptokenizemorphVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_morph_make_vector(comps : Array[Double]) -> NlptokenizemorphVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_morph_vector_zero(dim : Int) -> NlptokenizemorphVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizemorphVector::add(self : NlptokenizemorphVector, other : NlptokenizemorphVector) -> NlptokenizemorphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizemorphVector::sub(self : NlptokenizemorphVector, other : NlptokenizemorphVector) -> NlptokenizemorphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizemorphVector::scale(self : NlptokenizemorphVector, s : Double) -> NlptokenizemorphVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizemorphVector::dot(self : NlptokenizemorphVector, other : NlptokenizemorphVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizemorphVector::norm(self : NlptokenizemorphVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizemorphVector::normalize(self : NlptokenizemorphVector) -> NlptokenizemorphVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizemorphVector::dist(self : NlptokenizemorphVector, other : NlptokenizemorphVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizemorphVector::to_string(self : NlptokenizemorphVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizemorphFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_frame_make(size : Int) -> NlptokenizemorphFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphFrame::len(self : NlptokenizemorphFrame) -> Int { self.size }

pub fn NlptokenizemorphFrame::get(self : NlptokenizemorphFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphFrame::set(self : NlptokenizemorphFrame, i : Int, v : Double) -> NlptokenizemorphFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphFrame::sum(self : NlptokenizemorphFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphFrame::mean(self : NlptokenizemorphFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphFrame::scale(self : NlptokenizemorphFrame, f : Double) -> NlptokenizemorphFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphFrame::add(self : NlptokenizemorphFrame, other : NlptokenizemorphFrame) -> NlptokenizemorphFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphFrame::copy(self : NlptokenizemorphFrame) -> NlptokenizemorphFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphFrame::fill(self : NlptokenizemorphFrame, v : Double) -> NlptokenizemorphFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphFrame::min(self : NlptokenizemorphFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphFrame::max(self : NlptokenizemorphFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphFrame::to_string(self : NlptokenizemorphFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_table_make(size : Int) -> NlptokenizemorphTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphTable::len(self : NlptokenizemorphTable) -> Int { self.size }

pub fn NlptokenizemorphTable::get(self : NlptokenizemorphTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphTable::set(self : NlptokenizemorphTable, i : Int, v : Double) -> NlptokenizemorphTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphTable::sum(self : NlptokenizemorphTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphTable::mean(self : NlptokenizemorphTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphTable::scale(self : NlptokenizemorphTable, f : Double) -> NlptokenizemorphTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphTable::add(self : NlptokenizemorphTable, other : NlptokenizemorphTable) -> NlptokenizemorphTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphTable::copy(self : NlptokenizemorphTable) -> NlptokenizemorphTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphTable::fill(self : NlptokenizemorphTable, v : Double) -> NlptokenizemorphTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphTable::min(self : NlptokenizemorphTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphTable::max(self : NlptokenizemorphTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphTable::to_string(self : NlptokenizemorphTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_graphn_make(size : Int) -> NlptokenizemorphGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphGraphN::len(self : NlptokenizemorphGraphN) -> Int { self.size }

pub fn NlptokenizemorphGraphN::get(self : NlptokenizemorphGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphGraphN::set(self : NlptokenizemorphGraphN, i : Int, v : Double) -> NlptokenizemorphGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphGraphN::sum(self : NlptokenizemorphGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphGraphN::mean(self : NlptokenizemorphGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphGraphN::scale(self : NlptokenizemorphGraphN, f : Double) -> NlptokenizemorphGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphGraphN::add(self : NlptokenizemorphGraphN, other : NlptokenizemorphGraphN) -> NlptokenizemorphGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphGraphN::copy(self : NlptokenizemorphGraphN) -> NlptokenizemorphGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphGraphN::fill(self : NlptokenizemorphGraphN, v : Double) -> NlptokenizemorphGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphGraphN::min(self : NlptokenizemorphGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphGraphN::max(self : NlptokenizemorphGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphGraphN::to_string(self : NlptokenizemorphGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_node_make(size : Int) -> NlptokenizemorphNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphNode::len(self : NlptokenizemorphNode) -> Int { self.size }

pub fn NlptokenizemorphNode::get(self : NlptokenizemorphNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphNode::set(self : NlptokenizemorphNode, i : Int, v : Double) -> NlptokenizemorphNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphNode::sum(self : NlptokenizemorphNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphNode::mean(self : NlptokenizemorphNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphNode::scale(self : NlptokenizemorphNode, f : Double) -> NlptokenizemorphNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphNode::add(self : NlptokenizemorphNode, other : NlptokenizemorphNode) -> NlptokenizemorphNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphNode::copy(self : NlptokenizemorphNode) -> NlptokenizemorphNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphNode::fill(self : NlptokenizemorphNode, v : Double) -> NlptokenizemorphNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphNode::min(self : NlptokenizemorphNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphNode::max(self : NlptokenizemorphNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphNode::to_string(self : NlptokenizemorphNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_edge_make(size : Int) -> NlptokenizemorphEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphEdge::len(self : NlptokenizemorphEdge) -> Int { self.size }

pub fn NlptokenizemorphEdge::get(self : NlptokenizemorphEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphEdge::set(self : NlptokenizemorphEdge, i : Int, v : Double) -> NlptokenizemorphEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphEdge::sum(self : NlptokenizemorphEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphEdge::mean(self : NlptokenizemorphEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphEdge::scale(self : NlptokenizemorphEdge, f : Double) -> NlptokenizemorphEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphEdge::add(self : NlptokenizemorphEdge, other : NlptokenizemorphEdge) -> NlptokenizemorphEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphEdge::copy(self : NlptokenizemorphEdge) -> NlptokenizemorphEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphEdge::fill(self : NlptokenizemorphEdge, v : Double) -> NlptokenizemorphEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphEdge::min(self : NlptokenizemorphEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphEdge::max(self : NlptokenizemorphEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphEdge::to_string(self : NlptokenizemorphEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_path_make(size : Int) -> NlptokenizemorphPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphPath::len(self : NlptokenizemorphPath) -> Int { self.size }

pub fn NlptokenizemorphPath::get(self : NlptokenizemorphPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphPath::set(self : NlptokenizemorphPath, i : Int, v : Double) -> NlptokenizemorphPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphPath::sum(self : NlptokenizemorphPath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphPath::mean(self : NlptokenizemorphPath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphPath::scale(self : NlptokenizemorphPath, f : Double) -> NlptokenizemorphPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphPath::add(self : NlptokenizemorphPath, other : NlptokenizemorphPath) -> NlptokenizemorphPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphPath::copy(self : NlptokenizemorphPath) -> NlptokenizemorphPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphPath::fill(self : NlptokenizemorphPath, v : Double) -> NlptokenizemorphPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphPath::min(self : NlptokenizemorphPath) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphPath::max(self : NlptokenizemorphPath) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphPath::to_string(self : NlptokenizemorphPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_cluster_make(size : Int) -> NlptokenizemorphCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphCluster::len(self : NlptokenizemorphCluster) -> Int { self.size }

pub fn NlptokenizemorphCluster::get(self : NlptokenizemorphCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphCluster::set(self : NlptokenizemorphCluster, i : Int, v : Double) -> NlptokenizemorphCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphCluster::sum(self : NlptokenizemorphCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphCluster::mean(self : NlptokenizemorphCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphCluster::scale(self : NlptokenizemorphCluster, f : Double) -> NlptokenizemorphCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphCluster::add(self : NlptokenizemorphCluster, other : NlptokenizemorphCluster) -> NlptokenizemorphCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphCluster::copy(self : NlptokenizemorphCluster) -> NlptokenizemorphCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphCluster::fill(self : NlptokenizemorphCluster, v : Double) -> NlptokenizemorphCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphCluster::min(self : NlptokenizemorphCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphCluster::max(self : NlptokenizemorphCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphCluster::to_string(self : NlptokenizemorphCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_model_make(size : Int) -> NlptokenizemorphModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphModel::len(self : NlptokenizemorphModel) -> Int { self.size }

pub fn NlptokenizemorphModel::get(self : NlptokenizemorphModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphModel::set(self : NlptokenizemorphModel, i : Int, v : Double) -> NlptokenizemorphModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphModel::sum(self : NlptokenizemorphModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphModel::mean(self : NlptokenizemorphModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphModel::scale(self : NlptokenizemorphModel, f : Double) -> NlptokenizemorphModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphModel::add(self : NlptokenizemorphModel, other : NlptokenizemorphModel) -> NlptokenizemorphModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphModel::copy(self : NlptokenizemorphModel) -> NlptokenizemorphModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphModel::fill(self : NlptokenizemorphModel, v : Double) -> NlptokenizemorphModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphModel::min(self : NlptokenizemorphModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphModel::max(self : NlptokenizemorphModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphModel::to_string(self : NlptokenizemorphModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_layer_make(size : Int) -> NlptokenizemorphLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphLayer::len(self : NlptokenizemorphLayer) -> Int { self.size }

pub fn NlptokenizemorphLayer::get(self : NlptokenizemorphLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphLayer::set(self : NlptokenizemorphLayer, i : Int, v : Double) -> NlptokenizemorphLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphLayer::sum(self : NlptokenizemorphLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphLayer::mean(self : NlptokenizemorphLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphLayer::scale(self : NlptokenizemorphLayer, f : Double) -> NlptokenizemorphLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphLayer::add(self : NlptokenizemorphLayer, other : NlptokenizemorphLayer) -> NlptokenizemorphLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphLayer::copy(self : NlptokenizemorphLayer) -> NlptokenizemorphLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphLayer::fill(self : NlptokenizemorphLayer, v : Double) -> NlptokenizemorphLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphLayer::min(self : NlptokenizemorphLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphLayer::max(self : NlptokenizemorphLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphLayer::to_string(self : NlptokenizemorphLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_buffer_make(size : Int) -> NlptokenizemorphBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphBuffer::len(self : NlptokenizemorphBuffer) -> Int { self.size }

pub fn NlptokenizemorphBuffer::get(self : NlptokenizemorphBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphBuffer::set(self : NlptokenizemorphBuffer, i : Int, v : Double) -> NlptokenizemorphBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphBuffer::sum(self : NlptokenizemorphBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphBuffer::mean(self : NlptokenizemorphBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphBuffer::scale(self : NlptokenizemorphBuffer, f : Double) -> NlptokenizemorphBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphBuffer::add(self : NlptokenizemorphBuffer, other : NlptokenizemorphBuffer) -> NlptokenizemorphBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphBuffer::copy(self : NlptokenizemorphBuffer) -> NlptokenizemorphBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphBuffer::fill(self : NlptokenizemorphBuffer, v : Double) -> NlptokenizemorphBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphBuffer::min(self : NlptokenizemorphBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphBuffer::max(self : NlptokenizemorphBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphBuffer::to_string(self : NlptokenizemorphBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_cursor_make(size : Int) -> NlptokenizemorphCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphCursor::len(self : NlptokenizemorphCursor) -> Int { self.size }

pub fn NlptokenizemorphCursor::get(self : NlptokenizemorphCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphCursor::set(self : NlptokenizemorphCursor, i : Int, v : Double) -> NlptokenizemorphCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphCursor::sum(self : NlptokenizemorphCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphCursor::mean(self : NlptokenizemorphCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphCursor::scale(self : NlptokenizemorphCursor, f : Double) -> NlptokenizemorphCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphCursor::add(self : NlptokenizemorphCursor, other : NlptokenizemorphCursor) -> NlptokenizemorphCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphCursor::copy(self : NlptokenizemorphCursor) -> NlptokenizemorphCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphCursor::fill(self : NlptokenizemorphCursor, v : Double) -> NlptokenizemorphCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphCursor::min(self : NlptokenizemorphCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphCursor::max(self : NlptokenizemorphCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphCursor::to_string(self : NlptokenizemorphCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_view_make(size : Int) -> NlptokenizemorphView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphView::len(self : NlptokenizemorphView) -> Int { self.size }

pub fn NlptokenizemorphView::get(self : NlptokenizemorphView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphView::set(self : NlptokenizemorphView, i : Int, v : Double) -> NlptokenizemorphView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphView::sum(self : NlptokenizemorphView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphView::mean(self : NlptokenizemorphView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphView::scale(self : NlptokenizemorphView, f : Double) -> NlptokenizemorphView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphView::add(self : NlptokenizemorphView, other : NlptokenizemorphView) -> NlptokenizemorphView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphView::copy(self : NlptokenizemorphView) -> NlptokenizemorphView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphView::fill(self : NlptokenizemorphView, v : Double) -> NlptokenizemorphView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphView::min(self : NlptokenizemorphView) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphView::max(self : NlptokenizemorphView) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphView::to_string(self : NlptokenizemorphView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_range_make(size : Int) -> NlptokenizemorphRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphRange::len(self : NlptokenizemorphRange) -> Int { self.size }

pub fn NlptokenizemorphRange::get(self : NlptokenizemorphRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphRange::set(self : NlptokenizemorphRange, i : Int, v : Double) -> NlptokenizemorphRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphRange::sum(self : NlptokenizemorphRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphRange::mean(self : NlptokenizemorphRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphRange::scale(self : NlptokenizemorphRange, f : Double) -> NlptokenizemorphRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphRange::add(self : NlptokenizemorphRange, other : NlptokenizemorphRange) -> NlptokenizemorphRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphRange::copy(self : NlptokenizemorphRange) -> NlptokenizemorphRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphRange::fill(self : NlptokenizemorphRange, v : Double) -> NlptokenizemorphRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphRange::min(self : NlptokenizemorphRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphRange::max(self : NlptokenizemorphRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphRange::to_string(self : NlptokenizemorphRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_slice_make(size : Int) -> NlptokenizemorphSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizemorphSlice::len(self : NlptokenizemorphSlice) -> Int { self.size }

pub fn NlptokenizemorphSlice::get(self : NlptokenizemorphSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizemorphSlice::set(self : NlptokenizemorphSlice, i : Int, v : Double) -> NlptokenizemorphSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphSlice::sum(self : NlptokenizemorphSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizemorphSlice::mean(self : NlptokenizemorphSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizemorphSlice::scale(self : NlptokenizemorphSlice, f : Double) -> NlptokenizemorphSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphSlice::add(self : NlptokenizemorphSlice, other : NlptokenizemorphSlice) -> NlptokenizemorphSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizemorphSlice::copy(self : NlptokenizemorphSlice) -> NlptokenizemorphSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphSlice::fill(self : NlptokenizemorphSlice, v : Double) -> NlptokenizemorphSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizemorphSlice::min(self : NlptokenizemorphSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizemorphSlice::max(self : NlptokenizemorphSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizemorphSlice::to_string(self : NlptokenizemorphSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

