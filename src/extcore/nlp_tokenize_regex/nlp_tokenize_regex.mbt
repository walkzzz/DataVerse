///===
/// extcore/nlp_tokenize_regex

pub(all) struct NlptokenizeregexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_regex_make_point(x : Double, y : Double) -> NlptokenizeregexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_regex_make_point3(x : Double, y : Double, z : Double) -> NlptokenizeregexPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizeregexPoint::x(self : NlptokenizeregexPoint) -> Double { self.x }

pub fn NlptokenizeregexPoint::y(self : NlptokenizeregexPoint) -> Double { self.y }

pub fn NlptokenizeregexPoint::z(self : NlptokenizeregexPoint) -> Double { self.z }

pub fn NlptokenizeregexPoint::label(self : NlptokenizeregexPoint) -> Int { self.label }

pub fn NlptokenizeregexPoint::dist(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizeregexPoint::add(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizeregexPoint::sub(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizeregexPoint::scale(self : NlptokenizeregexPoint, s : Double) -> NlptokenizeregexPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizeregexPoint::dot(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizeregexPoint::cross(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizeregexPoint::norm(self : NlptokenizeregexPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizeregexPoint::normalize(self : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizeregexPoint::negate(self : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizeregexPoint::mid(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizeregexPoint::lerp(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint, t : Double) -> NlptokenizeregexPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizeregexPoint::to_string(self : NlptokenizeregexPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizeregexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_regex_make_series(vals : Array[Double], name : String) -> NlptokenizeregexSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizeregexSeries::len(self : NlptokenizeregexSeries) -> Int { self.vals.length() }

pub fn NlptokenizeregexSeries::sum(self : NlptokenizeregexSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizeregexSeries::mean(self : NlptokenizeregexSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizeregexSeries::min(self : NlptokenizeregexSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizeregexSeries::max(self : NlptokenizeregexSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizeregexSeries::range(self : NlptokenizeregexSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizeregexSeries::variance(self : NlptokenizeregexSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizeregexSeries::std(self : NlptokenizeregexSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizeregexSeries::median(self : NlptokenizeregexSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizeregexSeries::scale(self : NlptokenizeregexSeries, f : Double) -> NlptokenizeregexSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizeregexSeries::add(self : NlptokenizeregexSeries, other : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizeregexSeries::sub(self : NlptokenizeregexSeries, other : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizeregexSeries::normalize(self : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizeregexSeries::cumsum(self : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizeregexSeries::to_string(self : NlptokenizeregexSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizeregexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_regex_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizeregexMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_tokenize_regex_matrix_identity(n : Int) -> NlptokenizeregexMatrix {
  let m = nlp_tokenize_regex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizeregexMatrix::get(self : NlptokenizeregexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizeregexMatrix::transpose(self : NlptokenizeregexMatrix) -> NlptokenizeregexMatrix {
  let result = nlp_tokenize_regex_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizeregexMatrix::add(self : NlptokenizeregexMatrix, other : NlptokenizeregexMatrix) -> NlptokenizeregexMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_regex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizeregexMatrix::scale(self : NlptokenizeregexMatrix, s : Double) -> NlptokenizeregexMatrix {
  let result = nlp_tokenize_regex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizeregexMatrix::multiply(self : NlptokenizeregexMatrix, other : NlptokenizeregexMatrix) -> NlptokenizeregexMatrix {
  if self.cols != other.rows { return nlp_tokenize_regex_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_regex_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlptokenizeregexMatrix::trace(self : NlptokenizeregexMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizeregexMatrix::det(self : NlptokenizeregexMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizeregexMatrix::norm(self : NlptokenizeregexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizeregexMatrix::to_string(self : NlptokenizeregexMatrix) -> String {
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

pub(all) struct NlptokenizeregexVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_regex_make_vector(comps : Array[Double]) -> NlptokenizeregexVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_regex_vector_zero(dim : Int) -> NlptokenizeregexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizeregexVector::add(self : NlptokenizeregexVector, other : NlptokenizeregexVector) -> NlptokenizeregexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizeregexVector::sub(self : NlptokenizeregexVector, other : NlptokenizeregexVector) -> NlptokenizeregexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizeregexVector::scale(self : NlptokenizeregexVector, s : Double) -> NlptokenizeregexVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizeregexVector::dot(self : NlptokenizeregexVector, other : NlptokenizeregexVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizeregexVector::norm(self : NlptokenizeregexVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizeregexVector::normalize(self : NlptokenizeregexVector) -> NlptokenizeregexVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizeregexVector::dist(self : NlptokenizeregexVector, other : NlptokenizeregexVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizeregexVector::to_string(self : NlptokenizeregexVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizeregexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_frame_make(size : Int) -> NlptokenizeregexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexFrame::len(self : NlptokenizeregexFrame) -> Int { self.size }

pub fn NlptokenizeregexFrame::get(self : NlptokenizeregexFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexFrame::set(self : NlptokenizeregexFrame, i : Int, v : Double) -> NlptokenizeregexFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexFrame::sum(self : NlptokenizeregexFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexFrame::mean(self : NlptokenizeregexFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexFrame::scale(self : NlptokenizeregexFrame, f : Double) -> NlptokenizeregexFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexFrame::add(self : NlptokenizeregexFrame, other : NlptokenizeregexFrame) -> NlptokenizeregexFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexFrame::copy(self : NlptokenizeregexFrame) -> NlptokenizeregexFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexFrame::fill(self : NlptokenizeregexFrame, v : Double) -> NlptokenizeregexFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexFrame::min(self : NlptokenizeregexFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexFrame::max(self : NlptokenizeregexFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexFrame::to_string(self : NlptokenizeregexFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_table_make(size : Int) -> NlptokenizeregexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexTable::len(self : NlptokenizeregexTable) -> Int { self.size }

pub fn NlptokenizeregexTable::get(self : NlptokenizeregexTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexTable::set(self : NlptokenizeregexTable, i : Int, v : Double) -> NlptokenizeregexTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexTable::sum(self : NlptokenizeregexTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexTable::mean(self : NlptokenizeregexTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexTable::scale(self : NlptokenizeregexTable, f : Double) -> NlptokenizeregexTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexTable::add(self : NlptokenizeregexTable, other : NlptokenizeregexTable) -> NlptokenizeregexTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexTable::copy(self : NlptokenizeregexTable) -> NlptokenizeregexTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexTable::fill(self : NlptokenizeregexTable, v : Double) -> NlptokenizeregexTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexTable::min(self : NlptokenizeregexTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexTable::max(self : NlptokenizeregexTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexTable::to_string(self : NlptokenizeregexTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_graphn_make(size : Int) -> NlptokenizeregexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexGraphN::len(self : NlptokenizeregexGraphN) -> Int { self.size }

pub fn NlptokenizeregexGraphN::get(self : NlptokenizeregexGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexGraphN::set(self : NlptokenizeregexGraphN, i : Int, v : Double) -> NlptokenizeregexGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexGraphN::sum(self : NlptokenizeregexGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexGraphN::mean(self : NlptokenizeregexGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexGraphN::scale(self : NlptokenizeregexGraphN, f : Double) -> NlptokenizeregexGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexGraphN::add(self : NlptokenizeregexGraphN, other : NlptokenizeregexGraphN) -> NlptokenizeregexGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexGraphN::copy(self : NlptokenizeregexGraphN) -> NlptokenizeregexGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexGraphN::fill(self : NlptokenizeregexGraphN, v : Double) -> NlptokenizeregexGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexGraphN::min(self : NlptokenizeregexGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexGraphN::max(self : NlptokenizeregexGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexGraphN::to_string(self : NlptokenizeregexGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_node_make(size : Int) -> NlptokenizeregexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexNode::len(self : NlptokenizeregexNode) -> Int { self.size }

pub fn NlptokenizeregexNode::get(self : NlptokenizeregexNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexNode::set(self : NlptokenizeregexNode, i : Int, v : Double) -> NlptokenizeregexNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexNode::sum(self : NlptokenizeregexNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexNode::mean(self : NlptokenizeregexNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexNode::scale(self : NlptokenizeregexNode, f : Double) -> NlptokenizeregexNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexNode::add(self : NlptokenizeregexNode, other : NlptokenizeregexNode) -> NlptokenizeregexNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexNode::copy(self : NlptokenizeregexNode) -> NlptokenizeregexNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexNode::fill(self : NlptokenizeregexNode, v : Double) -> NlptokenizeregexNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexNode::min(self : NlptokenizeregexNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexNode::max(self : NlptokenizeregexNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexNode::to_string(self : NlptokenizeregexNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_edge_make(size : Int) -> NlptokenizeregexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexEdge::len(self : NlptokenizeregexEdge) -> Int { self.size }

pub fn NlptokenizeregexEdge::get(self : NlptokenizeregexEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexEdge::set(self : NlptokenizeregexEdge, i : Int, v : Double) -> NlptokenizeregexEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexEdge::sum(self : NlptokenizeregexEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexEdge::mean(self : NlptokenizeregexEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexEdge::scale(self : NlptokenizeregexEdge, f : Double) -> NlptokenizeregexEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexEdge::add(self : NlptokenizeregexEdge, other : NlptokenizeregexEdge) -> NlptokenizeregexEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexEdge::copy(self : NlptokenizeregexEdge) -> NlptokenizeregexEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexEdge::fill(self : NlptokenizeregexEdge, v : Double) -> NlptokenizeregexEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexEdge::min(self : NlptokenizeregexEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexEdge::max(self : NlptokenizeregexEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexEdge::to_string(self : NlptokenizeregexEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_path_make(size : Int) -> NlptokenizeregexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexPath::len(self : NlptokenizeregexPath) -> Int { self.size }

pub fn NlptokenizeregexPath::get(self : NlptokenizeregexPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexPath::set(self : NlptokenizeregexPath, i : Int, v : Double) -> NlptokenizeregexPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexPath::sum(self : NlptokenizeregexPath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexPath::mean(self : NlptokenizeregexPath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexPath::scale(self : NlptokenizeregexPath, f : Double) -> NlptokenizeregexPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexPath::add(self : NlptokenizeregexPath, other : NlptokenizeregexPath) -> NlptokenizeregexPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexPath::copy(self : NlptokenizeregexPath) -> NlptokenizeregexPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexPath::fill(self : NlptokenizeregexPath, v : Double) -> NlptokenizeregexPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexPath::min(self : NlptokenizeregexPath) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexPath::max(self : NlptokenizeregexPath) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexPath::to_string(self : NlptokenizeregexPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_cluster_make(size : Int) -> NlptokenizeregexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexCluster::len(self : NlptokenizeregexCluster) -> Int { self.size }

pub fn NlptokenizeregexCluster::get(self : NlptokenizeregexCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexCluster::set(self : NlptokenizeregexCluster, i : Int, v : Double) -> NlptokenizeregexCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexCluster::sum(self : NlptokenizeregexCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexCluster::mean(self : NlptokenizeregexCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexCluster::scale(self : NlptokenizeregexCluster, f : Double) -> NlptokenizeregexCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexCluster::add(self : NlptokenizeregexCluster, other : NlptokenizeregexCluster) -> NlptokenizeregexCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexCluster::copy(self : NlptokenizeregexCluster) -> NlptokenizeregexCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexCluster::fill(self : NlptokenizeregexCluster, v : Double) -> NlptokenizeregexCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexCluster::min(self : NlptokenizeregexCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexCluster::max(self : NlptokenizeregexCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexCluster::to_string(self : NlptokenizeregexCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_model_make(size : Int) -> NlptokenizeregexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexModel::len(self : NlptokenizeregexModel) -> Int { self.size }

pub fn NlptokenizeregexModel::get(self : NlptokenizeregexModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexModel::set(self : NlptokenizeregexModel, i : Int, v : Double) -> NlptokenizeregexModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexModel::sum(self : NlptokenizeregexModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexModel::mean(self : NlptokenizeregexModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexModel::scale(self : NlptokenizeregexModel, f : Double) -> NlptokenizeregexModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexModel::add(self : NlptokenizeregexModel, other : NlptokenizeregexModel) -> NlptokenizeregexModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexModel::copy(self : NlptokenizeregexModel) -> NlptokenizeregexModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexModel::fill(self : NlptokenizeregexModel, v : Double) -> NlptokenizeregexModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexModel::min(self : NlptokenizeregexModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexModel::max(self : NlptokenizeregexModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexModel::to_string(self : NlptokenizeregexModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_layer_make(size : Int) -> NlptokenizeregexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexLayer::len(self : NlptokenizeregexLayer) -> Int { self.size }

pub fn NlptokenizeregexLayer::get(self : NlptokenizeregexLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexLayer::set(self : NlptokenizeregexLayer, i : Int, v : Double) -> NlptokenizeregexLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexLayer::sum(self : NlptokenizeregexLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexLayer::mean(self : NlptokenizeregexLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexLayer::scale(self : NlptokenizeregexLayer, f : Double) -> NlptokenizeregexLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexLayer::add(self : NlptokenizeregexLayer, other : NlptokenizeregexLayer) -> NlptokenizeregexLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexLayer::copy(self : NlptokenizeregexLayer) -> NlptokenizeregexLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexLayer::fill(self : NlptokenizeregexLayer, v : Double) -> NlptokenizeregexLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexLayer::min(self : NlptokenizeregexLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexLayer::max(self : NlptokenizeregexLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexLayer::to_string(self : NlptokenizeregexLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_buffer_make(size : Int) -> NlptokenizeregexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexBuffer::len(self : NlptokenizeregexBuffer) -> Int { self.size }

pub fn NlptokenizeregexBuffer::get(self : NlptokenizeregexBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexBuffer::set(self : NlptokenizeregexBuffer, i : Int, v : Double) -> NlptokenizeregexBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexBuffer::sum(self : NlptokenizeregexBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexBuffer::mean(self : NlptokenizeregexBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexBuffer::scale(self : NlptokenizeregexBuffer, f : Double) -> NlptokenizeregexBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexBuffer::add(self : NlptokenizeregexBuffer, other : NlptokenizeregexBuffer) -> NlptokenizeregexBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexBuffer::copy(self : NlptokenizeregexBuffer) -> NlptokenizeregexBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexBuffer::fill(self : NlptokenizeregexBuffer, v : Double) -> NlptokenizeregexBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexBuffer::min(self : NlptokenizeregexBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexBuffer::max(self : NlptokenizeregexBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexBuffer::to_string(self : NlptokenizeregexBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_cursor_make(size : Int) -> NlptokenizeregexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexCursor::len(self : NlptokenizeregexCursor) -> Int { self.size }

pub fn NlptokenizeregexCursor::get(self : NlptokenizeregexCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexCursor::set(self : NlptokenizeregexCursor, i : Int, v : Double) -> NlptokenizeregexCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexCursor::sum(self : NlptokenizeregexCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexCursor::mean(self : NlptokenizeregexCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexCursor::scale(self : NlptokenizeregexCursor, f : Double) -> NlptokenizeregexCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexCursor::add(self : NlptokenizeregexCursor, other : NlptokenizeregexCursor) -> NlptokenizeregexCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexCursor::copy(self : NlptokenizeregexCursor) -> NlptokenizeregexCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexCursor::fill(self : NlptokenizeregexCursor, v : Double) -> NlptokenizeregexCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexCursor::min(self : NlptokenizeregexCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexCursor::max(self : NlptokenizeregexCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexCursor::to_string(self : NlptokenizeregexCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_view_make(size : Int) -> NlptokenizeregexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexView::len(self : NlptokenizeregexView) -> Int { self.size }

pub fn NlptokenizeregexView::get(self : NlptokenizeregexView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexView::set(self : NlptokenizeregexView, i : Int, v : Double) -> NlptokenizeregexView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexView::sum(self : NlptokenizeregexView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexView::mean(self : NlptokenizeregexView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexView::scale(self : NlptokenizeregexView, f : Double) -> NlptokenizeregexView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexView::add(self : NlptokenizeregexView, other : NlptokenizeregexView) -> NlptokenizeregexView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexView::copy(self : NlptokenizeregexView) -> NlptokenizeregexView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexView::fill(self : NlptokenizeregexView, v : Double) -> NlptokenizeregexView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexView::min(self : NlptokenizeregexView) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexView::max(self : NlptokenizeregexView) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexView::to_string(self : NlptokenizeregexView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_range_make(size : Int) -> NlptokenizeregexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexRange::len(self : NlptokenizeregexRange) -> Int { self.size }

pub fn NlptokenizeregexRange::get(self : NlptokenizeregexRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexRange::set(self : NlptokenizeregexRange, i : Int, v : Double) -> NlptokenizeregexRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexRange::sum(self : NlptokenizeregexRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexRange::mean(self : NlptokenizeregexRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexRange::scale(self : NlptokenizeregexRange, f : Double) -> NlptokenizeregexRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexRange::add(self : NlptokenizeregexRange, other : NlptokenizeregexRange) -> NlptokenizeregexRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexRange::copy(self : NlptokenizeregexRange) -> NlptokenizeregexRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexRange::fill(self : NlptokenizeregexRange, v : Double) -> NlptokenizeregexRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexRange::min(self : NlptokenizeregexRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexRange::max(self : NlptokenizeregexRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexRange::to_string(self : NlptokenizeregexRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_slice_make(size : Int) -> NlptokenizeregexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeregexSlice::len(self : NlptokenizeregexSlice) -> Int { self.size }

pub fn NlptokenizeregexSlice::get(self : NlptokenizeregexSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeregexSlice::set(self : NlptokenizeregexSlice, i : Int, v : Double) -> NlptokenizeregexSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexSlice::sum(self : NlptokenizeregexSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeregexSlice::mean(self : NlptokenizeregexSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeregexSlice::scale(self : NlptokenizeregexSlice, f : Double) -> NlptokenizeregexSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexSlice::add(self : NlptokenizeregexSlice, other : NlptokenizeregexSlice) -> NlptokenizeregexSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeregexSlice::copy(self : NlptokenizeregexSlice) -> NlptokenizeregexSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexSlice::fill(self : NlptokenizeregexSlice, v : Double) -> NlptokenizeregexSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeregexSlice::min(self : NlptokenizeregexSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizeregexSlice::max(self : NlptokenizeregexSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizeregexSlice::to_string(self : NlptokenizeregexSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

