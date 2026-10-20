///===
/// extcore/nlp_tokenize_subword

pub(all) struct NlptokenizesubwordPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_subword_make_point(x : Double, y : Double) -> NlptokenizesubwordPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_subword_make_point3(x : Double, y : Double, z : Double) -> NlptokenizesubwordPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizesubwordPoint::x(self : NlptokenizesubwordPoint) -> Double { self.x }

pub fn NlptokenizesubwordPoint::y(self : NlptokenizesubwordPoint) -> Double { self.y }

pub fn NlptokenizesubwordPoint::z(self : NlptokenizesubwordPoint) -> Double { self.z }

pub fn NlptokenizesubwordPoint::label(self : NlptokenizesubwordPoint) -> Int { self.label }

pub fn NlptokenizesubwordPoint::dist(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizesubwordPoint::add(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizesubwordPoint::sub(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizesubwordPoint::scale(self : NlptokenizesubwordPoint, s : Double) -> NlptokenizesubwordPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizesubwordPoint::dot(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizesubwordPoint::cross(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizesubwordPoint::norm(self : NlptokenizesubwordPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizesubwordPoint::normalize(self : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesubwordPoint::negate(self : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizesubwordPoint::mid(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizesubwordPoint::lerp(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint, t : Double) -> NlptokenizesubwordPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizesubwordPoint::to_string(self : NlptokenizesubwordPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizesubwordSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_subword_make_series(vals : Array[Double], name : String) -> NlptokenizesubwordSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizesubwordSeries::len(self : NlptokenizesubwordSeries) -> Int { self.vals.length() }

pub fn NlptokenizesubwordSeries::sum(self : NlptokenizesubwordSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizesubwordSeries::mean(self : NlptokenizesubwordSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizesubwordSeries::min(self : NlptokenizesubwordSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizesubwordSeries::max(self : NlptokenizesubwordSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizesubwordSeries::range(self : NlptokenizesubwordSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizesubwordSeries::variance(self : NlptokenizesubwordSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizesubwordSeries::std(self : NlptokenizesubwordSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizesubwordSeries::median(self : NlptokenizesubwordSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizesubwordSeries::scale(self : NlptokenizesubwordSeries, f : Double) -> NlptokenizesubwordSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizesubwordSeries::add(self : NlptokenizesubwordSeries, other : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizesubwordSeries::sub(self : NlptokenizesubwordSeries, other : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizesubwordSeries::normalize(self : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizesubwordSeries::cumsum(self : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizesubwordSeries::to_string(self : NlptokenizesubwordSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesubwordMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_subword_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizesubwordMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_subword_matrix_identity(n : Int) -> NlptokenizesubwordMatrix {
  let m = nlp_tokenize_subword_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizesubwordMatrix::get(self : NlptokenizesubwordMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizesubwordMatrix::transpose(self : NlptokenizesubwordMatrix) -> NlptokenizesubwordMatrix {
  let result = nlp_tokenize_subword_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizesubwordMatrix::add(self : NlptokenizesubwordMatrix, other : NlptokenizesubwordMatrix) -> NlptokenizesubwordMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_subword_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizesubwordMatrix::scale(self : NlptokenizesubwordMatrix, s : Double) -> NlptokenizesubwordMatrix {
  let result = nlp_tokenize_subword_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizesubwordMatrix::multiply(self : NlptokenizesubwordMatrix, other : NlptokenizesubwordMatrix) -> NlptokenizesubwordMatrix {
  if self.cols != other.rows { return nlp_tokenize_subword_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_subword_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlptokenizesubwordMatrix::trace(self : NlptokenizesubwordMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizesubwordMatrix::det(self : NlptokenizesubwordMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizesubwordMatrix::norm(self : NlptokenizesubwordMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizesubwordMatrix::to_string(self : NlptokenizesubwordMatrix) -> String {
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

pub(all) struct NlptokenizesubwordVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_subword_make_vector(comps : Array[Double]) -> NlptokenizesubwordVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_subword_vector_zero(dim : Int) -> NlptokenizesubwordVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizesubwordVector::add(self : NlptokenizesubwordVector, other : NlptokenizesubwordVector) -> NlptokenizesubwordVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesubwordVector::sub(self : NlptokenizesubwordVector, other : NlptokenizesubwordVector) -> NlptokenizesubwordVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesubwordVector::scale(self : NlptokenizesubwordVector, s : Double) -> NlptokenizesubwordVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizesubwordVector::dot(self : NlptokenizesubwordVector, other : NlptokenizesubwordVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizesubwordVector::norm(self : NlptokenizesubwordVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizesubwordVector::normalize(self : NlptokenizesubwordVector) -> NlptokenizesubwordVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesubwordVector::dist(self : NlptokenizesubwordVector, other : NlptokenizesubwordVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizesubwordVector::to_string(self : NlptokenizesubwordVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesubwordFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_frame_make(size : Int) -> NlptokenizesubwordFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordFrame::len(self : NlptokenizesubwordFrame) -> Int { self.size }

pub fn NlptokenizesubwordFrame::get(self : NlptokenizesubwordFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordFrame::set(self : NlptokenizesubwordFrame, i : Int, v : Double) -> NlptokenizesubwordFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordFrame::sum(self : NlptokenizesubwordFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordFrame::mean(self : NlptokenizesubwordFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordFrame::scale(self : NlptokenizesubwordFrame, f : Double) -> NlptokenizesubwordFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordFrame::add(self : NlptokenizesubwordFrame, other : NlptokenizesubwordFrame) -> NlptokenizesubwordFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordFrame::copy(self : NlptokenizesubwordFrame) -> NlptokenizesubwordFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordFrame::fill(self : NlptokenizesubwordFrame, v : Double) -> NlptokenizesubwordFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordFrame::min(self : NlptokenizesubwordFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordFrame::max(self : NlptokenizesubwordFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordFrame::to_string(self : NlptokenizesubwordFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_table_make(size : Int) -> NlptokenizesubwordTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordTable::len(self : NlptokenizesubwordTable) -> Int { self.size }

pub fn NlptokenizesubwordTable::get(self : NlptokenizesubwordTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordTable::set(self : NlptokenizesubwordTable, i : Int, v : Double) -> NlptokenizesubwordTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordTable::sum(self : NlptokenizesubwordTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordTable::mean(self : NlptokenizesubwordTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordTable::scale(self : NlptokenizesubwordTable, f : Double) -> NlptokenizesubwordTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordTable::add(self : NlptokenizesubwordTable, other : NlptokenizesubwordTable) -> NlptokenizesubwordTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordTable::copy(self : NlptokenizesubwordTable) -> NlptokenizesubwordTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordTable::fill(self : NlptokenizesubwordTable, v : Double) -> NlptokenizesubwordTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordTable::min(self : NlptokenizesubwordTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordTable::max(self : NlptokenizesubwordTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordTable::to_string(self : NlptokenizesubwordTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_graphn_make(size : Int) -> NlptokenizesubwordGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordGraphN::len(self : NlptokenizesubwordGraphN) -> Int { self.size }

pub fn NlptokenizesubwordGraphN::get(self : NlptokenizesubwordGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordGraphN::set(self : NlptokenizesubwordGraphN, i : Int, v : Double) -> NlptokenizesubwordGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordGraphN::sum(self : NlptokenizesubwordGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordGraphN::mean(self : NlptokenizesubwordGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordGraphN::scale(self : NlptokenizesubwordGraphN, f : Double) -> NlptokenizesubwordGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordGraphN::add(self : NlptokenizesubwordGraphN, other : NlptokenizesubwordGraphN) -> NlptokenizesubwordGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordGraphN::copy(self : NlptokenizesubwordGraphN) -> NlptokenizesubwordGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordGraphN::fill(self : NlptokenizesubwordGraphN, v : Double) -> NlptokenizesubwordGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordGraphN::min(self : NlptokenizesubwordGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordGraphN::max(self : NlptokenizesubwordGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordGraphN::to_string(self : NlptokenizesubwordGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_node_make(size : Int) -> NlptokenizesubwordNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordNode::len(self : NlptokenizesubwordNode) -> Int { self.size }

pub fn NlptokenizesubwordNode::get(self : NlptokenizesubwordNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordNode::set(self : NlptokenizesubwordNode, i : Int, v : Double) -> NlptokenizesubwordNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordNode::sum(self : NlptokenizesubwordNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordNode::mean(self : NlptokenizesubwordNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordNode::scale(self : NlptokenizesubwordNode, f : Double) -> NlptokenizesubwordNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordNode::add(self : NlptokenizesubwordNode, other : NlptokenizesubwordNode) -> NlptokenizesubwordNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordNode::copy(self : NlptokenizesubwordNode) -> NlptokenizesubwordNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordNode::fill(self : NlptokenizesubwordNode, v : Double) -> NlptokenizesubwordNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordNode::min(self : NlptokenizesubwordNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordNode::max(self : NlptokenizesubwordNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordNode::to_string(self : NlptokenizesubwordNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_edge_make(size : Int) -> NlptokenizesubwordEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordEdge::len(self : NlptokenizesubwordEdge) -> Int { self.size }

pub fn NlptokenizesubwordEdge::get(self : NlptokenizesubwordEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordEdge::set(self : NlptokenizesubwordEdge, i : Int, v : Double) -> NlptokenizesubwordEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordEdge::sum(self : NlptokenizesubwordEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordEdge::mean(self : NlptokenizesubwordEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordEdge::scale(self : NlptokenizesubwordEdge, f : Double) -> NlptokenizesubwordEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordEdge::add(self : NlptokenizesubwordEdge, other : NlptokenizesubwordEdge) -> NlptokenizesubwordEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordEdge::copy(self : NlptokenizesubwordEdge) -> NlptokenizesubwordEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordEdge::fill(self : NlptokenizesubwordEdge, v : Double) -> NlptokenizesubwordEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordEdge::min(self : NlptokenizesubwordEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordEdge::max(self : NlptokenizesubwordEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordEdge::to_string(self : NlptokenizesubwordEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_path_make(size : Int) -> NlptokenizesubwordPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordPath::len(self : NlptokenizesubwordPath) -> Int { self.size }

pub fn NlptokenizesubwordPath::get(self : NlptokenizesubwordPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordPath::set(self : NlptokenizesubwordPath, i : Int, v : Double) -> NlptokenizesubwordPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordPath::sum(self : NlptokenizesubwordPath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordPath::mean(self : NlptokenizesubwordPath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordPath::scale(self : NlptokenizesubwordPath, f : Double) -> NlptokenizesubwordPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordPath::add(self : NlptokenizesubwordPath, other : NlptokenizesubwordPath) -> NlptokenizesubwordPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordPath::copy(self : NlptokenizesubwordPath) -> NlptokenizesubwordPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordPath::fill(self : NlptokenizesubwordPath, v : Double) -> NlptokenizesubwordPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordPath::min(self : NlptokenizesubwordPath) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordPath::max(self : NlptokenizesubwordPath) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordPath::to_string(self : NlptokenizesubwordPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_cluster_make(size : Int) -> NlptokenizesubwordCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordCluster::len(self : NlptokenizesubwordCluster) -> Int { self.size }

pub fn NlptokenizesubwordCluster::get(self : NlptokenizesubwordCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordCluster::set(self : NlptokenizesubwordCluster, i : Int, v : Double) -> NlptokenizesubwordCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordCluster::sum(self : NlptokenizesubwordCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordCluster::mean(self : NlptokenizesubwordCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordCluster::scale(self : NlptokenizesubwordCluster, f : Double) -> NlptokenizesubwordCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordCluster::add(self : NlptokenizesubwordCluster, other : NlptokenizesubwordCluster) -> NlptokenizesubwordCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordCluster::copy(self : NlptokenizesubwordCluster) -> NlptokenizesubwordCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordCluster::fill(self : NlptokenizesubwordCluster, v : Double) -> NlptokenizesubwordCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordCluster::min(self : NlptokenizesubwordCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordCluster::max(self : NlptokenizesubwordCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordCluster::to_string(self : NlptokenizesubwordCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_model_make(size : Int) -> NlptokenizesubwordModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordModel::len(self : NlptokenizesubwordModel) -> Int { self.size }

pub fn NlptokenizesubwordModel::get(self : NlptokenizesubwordModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordModel::set(self : NlptokenizesubwordModel, i : Int, v : Double) -> NlptokenizesubwordModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordModel::sum(self : NlptokenizesubwordModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordModel::mean(self : NlptokenizesubwordModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordModel::scale(self : NlptokenizesubwordModel, f : Double) -> NlptokenizesubwordModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordModel::add(self : NlptokenizesubwordModel, other : NlptokenizesubwordModel) -> NlptokenizesubwordModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordModel::copy(self : NlptokenizesubwordModel) -> NlptokenizesubwordModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordModel::fill(self : NlptokenizesubwordModel, v : Double) -> NlptokenizesubwordModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordModel::min(self : NlptokenizesubwordModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordModel::max(self : NlptokenizesubwordModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordModel::to_string(self : NlptokenizesubwordModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_layer_make(size : Int) -> NlptokenizesubwordLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordLayer::len(self : NlptokenizesubwordLayer) -> Int { self.size }

pub fn NlptokenizesubwordLayer::get(self : NlptokenizesubwordLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordLayer::set(self : NlptokenizesubwordLayer, i : Int, v : Double) -> NlptokenizesubwordLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordLayer::sum(self : NlptokenizesubwordLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordLayer::mean(self : NlptokenizesubwordLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordLayer::scale(self : NlptokenizesubwordLayer, f : Double) -> NlptokenizesubwordLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordLayer::add(self : NlptokenizesubwordLayer, other : NlptokenizesubwordLayer) -> NlptokenizesubwordLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordLayer::copy(self : NlptokenizesubwordLayer) -> NlptokenizesubwordLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordLayer::fill(self : NlptokenizesubwordLayer, v : Double) -> NlptokenizesubwordLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordLayer::min(self : NlptokenizesubwordLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordLayer::max(self : NlptokenizesubwordLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordLayer::to_string(self : NlptokenizesubwordLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_buffer_make(size : Int) -> NlptokenizesubwordBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordBuffer::len(self : NlptokenizesubwordBuffer) -> Int { self.size }

pub fn NlptokenizesubwordBuffer::get(self : NlptokenizesubwordBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordBuffer::set(self : NlptokenizesubwordBuffer, i : Int, v : Double) -> NlptokenizesubwordBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordBuffer::sum(self : NlptokenizesubwordBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordBuffer::mean(self : NlptokenizesubwordBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordBuffer::scale(self : NlptokenizesubwordBuffer, f : Double) -> NlptokenizesubwordBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordBuffer::add(self : NlptokenizesubwordBuffer, other : NlptokenizesubwordBuffer) -> NlptokenizesubwordBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordBuffer::copy(self : NlptokenizesubwordBuffer) -> NlptokenizesubwordBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordBuffer::fill(self : NlptokenizesubwordBuffer, v : Double) -> NlptokenizesubwordBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordBuffer::min(self : NlptokenizesubwordBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordBuffer::max(self : NlptokenizesubwordBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordBuffer::to_string(self : NlptokenizesubwordBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_cursor_make(size : Int) -> NlptokenizesubwordCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordCursor::len(self : NlptokenizesubwordCursor) -> Int { self.size }

pub fn NlptokenizesubwordCursor::get(self : NlptokenizesubwordCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordCursor::set(self : NlptokenizesubwordCursor, i : Int, v : Double) -> NlptokenizesubwordCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordCursor::sum(self : NlptokenizesubwordCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordCursor::mean(self : NlptokenizesubwordCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordCursor::scale(self : NlptokenizesubwordCursor, f : Double) -> NlptokenizesubwordCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordCursor::add(self : NlptokenizesubwordCursor, other : NlptokenizesubwordCursor) -> NlptokenizesubwordCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordCursor::copy(self : NlptokenizesubwordCursor) -> NlptokenizesubwordCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordCursor::fill(self : NlptokenizesubwordCursor, v : Double) -> NlptokenizesubwordCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordCursor::min(self : NlptokenizesubwordCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordCursor::max(self : NlptokenizesubwordCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordCursor::to_string(self : NlptokenizesubwordCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_view_make(size : Int) -> NlptokenizesubwordView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordView::len(self : NlptokenizesubwordView) -> Int { self.size }

pub fn NlptokenizesubwordView::get(self : NlptokenizesubwordView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordView::set(self : NlptokenizesubwordView, i : Int, v : Double) -> NlptokenizesubwordView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordView::sum(self : NlptokenizesubwordView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordView::mean(self : NlptokenizesubwordView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordView::scale(self : NlptokenizesubwordView, f : Double) -> NlptokenizesubwordView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordView::add(self : NlptokenizesubwordView, other : NlptokenizesubwordView) -> NlptokenizesubwordView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordView::copy(self : NlptokenizesubwordView) -> NlptokenizesubwordView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordView::fill(self : NlptokenizesubwordView, v : Double) -> NlptokenizesubwordView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordView::min(self : NlptokenizesubwordView) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordView::max(self : NlptokenizesubwordView) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordView::to_string(self : NlptokenizesubwordView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_range_make(size : Int) -> NlptokenizesubwordRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordRange::len(self : NlptokenizesubwordRange) -> Int { self.size }

pub fn NlptokenizesubwordRange::get(self : NlptokenizesubwordRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordRange::set(self : NlptokenizesubwordRange, i : Int, v : Double) -> NlptokenizesubwordRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordRange::sum(self : NlptokenizesubwordRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordRange::mean(self : NlptokenizesubwordRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordRange::scale(self : NlptokenizesubwordRange, f : Double) -> NlptokenizesubwordRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordRange::add(self : NlptokenizesubwordRange, other : NlptokenizesubwordRange) -> NlptokenizesubwordRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordRange::copy(self : NlptokenizesubwordRange) -> NlptokenizesubwordRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordRange::fill(self : NlptokenizesubwordRange, v : Double) -> NlptokenizesubwordRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordRange::min(self : NlptokenizesubwordRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordRange::max(self : NlptokenizesubwordRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordRange::to_string(self : NlptokenizesubwordRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_slice_make(size : Int) -> NlptokenizesubwordSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesubwordSlice::len(self : NlptokenizesubwordSlice) -> Int { self.size }

pub fn NlptokenizesubwordSlice::get(self : NlptokenizesubwordSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesubwordSlice::set(self : NlptokenizesubwordSlice, i : Int, v : Double) -> NlptokenizesubwordSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordSlice::sum(self : NlptokenizesubwordSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesubwordSlice::mean(self : NlptokenizesubwordSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesubwordSlice::scale(self : NlptokenizesubwordSlice, f : Double) -> NlptokenizesubwordSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordSlice::add(self : NlptokenizesubwordSlice, other : NlptokenizesubwordSlice) -> NlptokenizesubwordSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesubwordSlice::copy(self : NlptokenizesubwordSlice) -> NlptokenizesubwordSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordSlice::fill(self : NlptokenizesubwordSlice, v : Double) -> NlptokenizesubwordSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesubwordSlice::min(self : NlptokenizesubwordSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizesubwordSlice::max(self : NlptokenizesubwordSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizesubwordSlice::to_string(self : NlptokenizesubwordSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

