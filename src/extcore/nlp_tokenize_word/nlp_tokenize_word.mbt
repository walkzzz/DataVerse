///===
/// extcore/nlp_tokenize_word

pub(all) struct NlptokenizewordPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_word_make_point(x : Double, y : Double) -> NlptokenizewordPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_word_make_point3(x : Double, y : Double, z : Double) -> NlptokenizewordPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizewordPoint::x(self : NlptokenizewordPoint) -> Double { self.x }

pub fn NlptokenizewordPoint::y(self : NlptokenizewordPoint) -> Double { self.y }

pub fn NlptokenizewordPoint::z(self : NlptokenizewordPoint) -> Double { self.z }

pub fn NlptokenizewordPoint::label(self : NlptokenizewordPoint) -> Int { self.label }

pub fn NlptokenizewordPoint::dist(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizewordPoint::add(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizewordPoint::sub(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizewordPoint::scale(self : NlptokenizewordPoint, s : Double) -> NlptokenizewordPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizewordPoint::dot(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizewordPoint::cross(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizewordPoint::norm(self : NlptokenizewordPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizewordPoint::normalize(self : NlptokenizewordPoint) -> NlptokenizewordPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizewordPoint::negate(self : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizewordPoint::mid(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizewordPoint::lerp(self : NlptokenizewordPoint, other : NlptokenizewordPoint, t : Double) -> NlptokenizewordPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizewordPoint::to_string(self : NlptokenizewordPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizewordSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_word_make_series(vals : Array[Double], name : String) -> NlptokenizewordSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizewordSeries::len(self : NlptokenizewordSeries) -> Int { self.vals.length() }

pub fn NlptokenizewordSeries::sum(self : NlptokenizewordSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizewordSeries::mean(self : NlptokenizewordSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizewordSeries::min(self : NlptokenizewordSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizewordSeries::max(self : NlptokenizewordSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizewordSeries::range(self : NlptokenizewordSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizewordSeries::variance(self : NlptokenizewordSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizewordSeries::std(self : NlptokenizewordSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizewordSeries::median(self : NlptokenizewordSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizewordSeries::scale(self : NlptokenizewordSeries, f : Double) -> NlptokenizewordSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizewordSeries::add(self : NlptokenizewordSeries, other : NlptokenizewordSeries) -> NlptokenizewordSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizewordSeries::sub(self : NlptokenizewordSeries, other : NlptokenizewordSeries) -> NlptokenizewordSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizewordSeries::normalize(self : NlptokenizewordSeries) -> NlptokenizewordSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizewordSeries::cumsum(self : NlptokenizewordSeries) -> NlptokenizewordSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizewordSeries::to_string(self : NlptokenizewordSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizewordMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_word_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizewordMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_word_matrix_identity(n : Int) -> NlptokenizewordMatrix {
  let m = nlp_tokenize_word_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizewordMatrix::get(self : NlptokenizewordMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizewordMatrix::transpose(self : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  let result = nlp_tokenize_word_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizewordMatrix::add(self : NlptokenizewordMatrix, other : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_word_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizewordMatrix::scale(self : NlptokenizewordMatrix, s : Double) -> NlptokenizewordMatrix {
  let result = nlp_tokenize_word_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizewordMatrix::multiply(self : NlptokenizewordMatrix, other : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  if self.cols != other.rows { return nlp_tokenize_word_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_word_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizewordMatrix::trace(self : NlptokenizewordMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizewordMatrix::det(self : NlptokenizewordMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizewordMatrix::norm(self : NlptokenizewordMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizewordMatrix::to_string(self : NlptokenizewordMatrix) -> String {
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

pub(all) struct NlptokenizewordVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_word_make_vector(comps : Array[Double]) -> NlptokenizewordVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_word_vector_zero(dim : Int) -> NlptokenizewordVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizewordVector::add(self : NlptokenizewordVector, other : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizewordVector::sub(self : NlptokenizewordVector, other : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizewordVector::scale(self : NlptokenizewordVector, s : Double) -> NlptokenizewordVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizewordVector::dot(self : NlptokenizewordVector, other : NlptokenizewordVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizewordVector::norm(self : NlptokenizewordVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizewordVector::normalize(self : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizewordVector::dist(self : NlptokenizewordVector, other : NlptokenizewordVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizewordVector::to_string(self : NlptokenizewordVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizewordFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_frame_make(size : Int) -> NlptokenizewordFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordFrame::len(self : NlptokenizewordFrame) -> Int { self.size }

pub fn NlptokenizewordFrame::get(self : NlptokenizewordFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordFrame::set(self : NlptokenizewordFrame, i : Int, v : Double) -> NlptokenizewordFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordFrame::sum(self : NlptokenizewordFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordFrame::mean(self : NlptokenizewordFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordFrame::scale(self : NlptokenizewordFrame, f : Double) -> NlptokenizewordFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordFrame::add(self : NlptokenizewordFrame, other : NlptokenizewordFrame) -> NlptokenizewordFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordFrame::copy(self : NlptokenizewordFrame) -> NlptokenizewordFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordFrame::fill(self : NlptokenizewordFrame, v : Double) -> NlptokenizewordFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordFrame::min(self : NlptokenizewordFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordFrame::max(self : NlptokenizewordFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordFrame::to_string(self : NlptokenizewordFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_table_make(size : Int) -> NlptokenizewordTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordTable::len(self : NlptokenizewordTable) -> Int { self.size }

pub fn NlptokenizewordTable::get(self : NlptokenizewordTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordTable::set(self : NlptokenizewordTable, i : Int, v : Double) -> NlptokenizewordTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordTable::sum(self : NlptokenizewordTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordTable::mean(self : NlptokenizewordTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordTable::scale(self : NlptokenizewordTable, f : Double) -> NlptokenizewordTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordTable::add(self : NlptokenizewordTable, other : NlptokenizewordTable) -> NlptokenizewordTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordTable::copy(self : NlptokenizewordTable) -> NlptokenizewordTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordTable::fill(self : NlptokenizewordTable, v : Double) -> NlptokenizewordTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordTable::min(self : NlptokenizewordTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordTable::max(self : NlptokenizewordTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordTable::to_string(self : NlptokenizewordTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_graphn_make(size : Int) -> NlptokenizewordGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordGraphN::len(self : NlptokenizewordGraphN) -> Int { self.size }

pub fn NlptokenizewordGraphN::get(self : NlptokenizewordGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordGraphN::set(self : NlptokenizewordGraphN, i : Int, v : Double) -> NlptokenizewordGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordGraphN::sum(self : NlptokenizewordGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordGraphN::mean(self : NlptokenizewordGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordGraphN::scale(self : NlptokenizewordGraphN, f : Double) -> NlptokenizewordGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordGraphN::add(self : NlptokenizewordGraphN, other : NlptokenizewordGraphN) -> NlptokenizewordGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordGraphN::copy(self : NlptokenizewordGraphN) -> NlptokenizewordGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordGraphN::fill(self : NlptokenizewordGraphN, v : Double) -> NlptokenizewordGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordGraphN::min(self : NlptokenizewordGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordGraphN::max(self : NlptokenizewordGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordGraphN::to_string(self : NlptokenizewordGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_node_make(size : Int) -> NlptokenizewordNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordNode::len(self : NlptokenizewordNode) -> Int { self.size }

pub fn NlptokenizewordNode::get(self : NlptokenizewordNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordNode::set(self : NlptokenizewordNode, i : Int, v : Double) -> NlptokenizewordNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordNode::sum(self : NlptokenizewordNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordNode::mean(self : NlptokenizewordNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordNode::scale(self : NlptokenizewordNode, f : Double) -> NlptokenizewordNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordNode::add(self : NlptokenizewordNode, other : NlptokenizewordNode) -> NlptokenizewordNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordNode::copy(self : NlptokenizewordNode) -> NlptokenizewordNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordNode::fill(self : NlptokenizewordNode, v : Double) -> NlptokenizewordNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordNode::min(self : NlptokenizewordNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordNode::max(self : NlptokenizewordNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordNode::to_string(self : NlptokenizewordNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_edge_make(size : Int) -> NlptokenizewordEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordEdge::len(self : NlptokenizewordEdge) -> Int { self.size }

pub fn NlptokenizewordEdge::get(self : NlptokenizewordEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordEdge::set(self : NlptokenizewordEdge, i : Int, v : Double) -> NlptokenizewordEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordEdge::sum(self : NlptokenizewordEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordEdge::mean(self : NlptokenizewordEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordEdge::scale(self : NlptokenizewordEdge, f : Double) -> NlptokenizewordEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordEdge::add(self : NlptokenizewordEdge, other : NlptokenizewordEdge) -> NlptokenizewordEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordEdge::copy(self : NlptokenizewordEdge) -> NlptokenizewordEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordEdge::fill(self : NlptokenizewordEdge, v : Double) -> NlptokenizewordEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordEdge::min(self : NlptokenizewordEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordEdge::max(self : NlptokenizewordEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordEdge::to_string(self : NlptokenizewordEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_path_make(size : Int) -> NlptokenizewordPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordPath::len(self : NlptokenizewordPath) -> Int { self.size }

pub fn NlptokenizewordPath::get(self : NlptokenizewordPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordPath::set(self : NlptokenizewordPath, i : Int, v : Double) -> NlptokenizewordPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordPath::sum(self : NlptokenizewordPath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordPath::mean(self : NlptokenizewordPath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordPath::scale(self : NlptokenizewordPath, f : Double) -> NlptokenizewordPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordPath::add(self : NlptokenizewordPath, other : NlptokenizewordPath) -> NlptokenizewordPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordPath::copy(self : NlptokenizewordPath) -> NlptokenizewordPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordPath::fill(self : NlptokenizewordPath, v : Double) -> NlptokenizewordPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordPath::min(self : NlptokenizewordPath) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordPath::max(self : NlptokenizewordPath) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordPath::to_string(self : NlptokenizewordPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_cluster_make(size : Int) -> NlptokenizewordCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordCluster::len(self : NlptokenizewordCluster) -> Int { self.size }

pub fn NlptokenizewordCluster::get(self : NlptokenizewordCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordCluster::set(self : NlptokenizewordCluster, i : Int, v : Double) -> NlptokenizewordCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordCluster::sum(self : NlptokenizewordCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordCluster::mean(self : NlptokenizewordCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordCluster::scale(self : NlptokenizewordCluster, f : Double) -> NlptokenizewordCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordCluster::add(self : NlptokenizewordCluster, other : NlptokenizewordCluster) -> NlptokenizewordCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordCluster::copy(self : NlptokenizewordCluster) -> NlptokenizewordCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordCluster::fill(self : NlptokenizewordCluster, v : Double) -> NlptokenizewordCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordCluster::min(self : NlptokenizewordCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordCluster::max(self : NlptokenizewordCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordCluster::to_string(self : NlptokenizewordCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_model_make(size : Int) -> NlptokenizewordModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordModel::len(self : NlptokenizewordModel) -> Int { self.size }

pub fn NlptokenizewordModel::get(self : NlptokenizewordModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordModel::set(self : NlptokenizewordModel, i : Int, v : Double) -> NlptokenizewordModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordModel::sum(self : NlptokenizewordModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordModel::mean(self : NlptokenizewordModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordModel::scale(self : NlptokenizewordModel, f : Double) -> NlptokenizewordModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordModel::add(self : NlptokenizewordModel, other : NlptokenizewordModel) -> NlptokenizewordModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordModel::copy(self : NlptokenizewordModel) -> NlptokenizewordModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordModel::fill(self : NlptokenizewordModel, v : Double) -> NlptokenizewordModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordModel::min(self : NlptokenizewordModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordModel::max(self : NlptokenizewordModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordModel::to_string(self : NlptokenizewordModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_layer_make(size : Int) -> NlptokenizewordLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordLayer::len(self : NlptokenizewordLayer) -> Int { self.size }

pub fn NlptokenizewordLayer::get(self : NlptokenizewordLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordLayer::set(self : NlptokenizewordLayer, i : Int, v : Double) -> NlptokenizewordLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordLayer::sum(self : NlptokenizewordLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordLayer::mean(self : NlptokenizewordLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordLayer::scale(self : NlptokenizewordLayer, f : Double) -> NlptokenizewordLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordLayer::add(self : NlptokenizewordLayer, other : NlptokenizewordLayer) -> NlptokenizewordLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordLayer::copy(self : NlptokenizewordLayer) -> NlptokenizewordLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordLayer::fill(self : NlptokenizewordLayer, v : Double) -> NlptokenizewordLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordLayer::min(self : NlptokenizewordLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordLayer::max(self : NlptokenizewordLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordLayer::to_string(self : NlptokenizewordLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_buffer_make(size : Int) -> NlptokenizewordBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordBuffer::len(self : NlptokenizewordBuffer) -> Int { self.size }

pub fn NlptokenizewordBuffer::get(self : NlptokenizewordBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordBuffer::set(self : NlptokenizewordBuffer, i : Int, v : Double) -> NlptokenizewordBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordBuffer::sum(self : NlptokenizewordBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordBuffer::mean(self : NlptokenizewordBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordBuffer::scale(self : NlptokenizewordBuffer, f : Double) -> NlptokenizewordBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordBuffer::add(self : NlptokenizewordBuffer, other : NlptokenizewordBuffer) -> NlptokenizewordBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordBuffer::copy(self : NlptokenizewordBuffer) -> NlptokenizewordBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordBuffer::fill(self : NlptokenizewordBuffer, v : Double) -> NlptokenizewordBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordBuffer::min(self : NlptokenizewordBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordBuffer::max(self : NlptokenizewordBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordBuffer::to_string(self : NlptokenizewordBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_cursor_make(size : Int) -> NlptokenizewordCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordCursor::len(self : NlptokenizewordCursor) -> Int { self.size }

pub fn NlptokenizewordCursor::get(self : NlptokenizewordCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordCursor::set(self : NlptokenizewordCursor, i : Int, v : Double) -> NlptokenizewordCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordCursor::sum(self : NlptokenizewordCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordCursor::mean(self : NlptokenizewordCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordCursor::scale(self : NlptokenizewordCursor, f : Double) -> NlptokenizewordCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordCursor::add(self : NlptokenizewordCursor, other : NlptokenizewordCursor) -> NlptokenizewordCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordCursor::copy(self : NlptokenizewordCursor) -> NlptokenizewordCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordCursor::fill(self : NlptokenizewordCursor, v : Double) -> NlptokenizewordCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordCursor::min(self : NlptokenizewordCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordCursor::max(self : NlptokenizewordCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordCursor::to_string(self : NlptokenizewordCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_view_make(size : Int) -> NlptokenizewordView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordView::len(self : NlptokenizewordView) -> Int { self.size }

pub fn NlptokenizewordView::get(self : NlptokenizewordView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordView::set(self : NlptokenizewordView, i : Int, v : Double) -> NlptokenizewordView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordView::sum(self : NlptokenizewordView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordView::mean(self : NlptokenizewordView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordView::scale(self : NlptokenizewordView, f : Double) -> NlptokenizewordView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordView::add(self : NlptokenizewordView, other : NlptokenizewordView) -> NlptokenizewordView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordView::copy(self : NlptokenizewordView) -> NlptokenizewordView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordView::fill(self : NlptokenizewordView, v : Double) -> NlptokenizewordView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordView::min(self : NlptokenizewordView) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordView::max(self : NlptokenizewordView) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordView::to_string(self : NlptokenizewordView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_range_make(size : Int) -> NlptokenizewordRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordRange::len(self : NlptokenizewordRange) -> Int { self.size }

pub fn NlptokenizewordRange::get(self : NlptokenizewordRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordRange::set(self : NlptokenizewordRange, i : Int, v : Double) -> NlptokenizewordRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordRange::sum(self : NlptokenizewordRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordRange::mean(self : NlptokenizewordRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordRange::scale(self : NlptokenizewordRange, f : Double) -> NlptokenizewordRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordRange::add(self : NlptokenizewordRange, other : NlptokenizewordRange) -> NlptokenizewordRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordRange::copy(self : NlptokenizewordRange) -> NlptokenizewordRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordRange::fill(self : NlptokenizewordRange, v : Double) -> NlptokenizewordRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordRange::min(self : NlptokenizewordRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordRange::max(self : NlptokenizewordRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordRange::to_string(self : NlptokenizewordRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_slice_make(size : Int) -> NlptokenizewordSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordSlice::len(self : NlptokenizewordSlice) -> Int { self.size }

pub fn NlptokenizewordSlice::get(self : NlptokenizewordSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordSlice::set(self : NlptokenizewordSlice, i : Int, v : Double) -> NlptokenizewordSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordSlice::sum(self : NlptokenizewordSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordSlice::mean(self : NlptokenizewordSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordSlice::scale(self : NlptokenizewordSlice, f : Double) -> NlptokenizewordSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordSlice::add(self : NlptokenizewordSlice, other : NlptokenizewordSlice) -> NlptokenizewordSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordSlice::copy(self : NlptokenizewordSlice) -> NlptokenizewordSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordSlice::fill(self : NlptokenizewordSlice, v : Double) -> NlptokenizewordSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordSlice::min(self : NlptokenizewordSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordSlice::max(self : NlptokenizewordSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordSlice::to_string(self : NlptokenizewordSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

