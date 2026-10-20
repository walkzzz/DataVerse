///===
/// extcore/nlp_tokenize_bpe

pub(all) struct NlptokenizebpePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_bpe_make_point(x : Double, y : Double) -> NlptokenizebpePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_bpe_make_point3(x : Double, y : Double, z : Double) -> NlptokenizebpePoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizebpePoint::x(self : NlptokenizebpePoint) -> Double { self.x }

pub fn NlptokenizebpePoint::y(self : NlptokenizebpePoint) -> Double { self.y }

pub fn NlptokenizebpePoint::z(self : NlptokenizebpePoint) -> Double { self.z }

pub fn NlptokenizebpePoint::label(self : NlptokenizebpePoint) -> Int { self.label }

pub fn NlptokenizebpePoint::dist(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizebpePoint::add(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizebpePoint::sub(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizebpePoint::scale(self : NlptokenizebpePoint, s : Double) -> NlptokenizebpePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizebpePoint::dot(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizebpePoint::cross(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizebpePoint::norm(self : NlptokenizebpePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizebpePoint::normalize(self : NlptokenizebpePoint) -> NlptokenizebpePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizebpePoint::negate(self : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizebpePoint::mid(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizebpePoint::lerp(self : NlptokenizebpePoint, other : NlptokenizebpePoint, t : Double) -> NlptokenizebpePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizebpePoint::to_string(self : NlptokenizebpePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizebpeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_bpe_make_series(vals : Array[Double], name : String) -> NlptokenizebpeSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizebpeSeries::len(self : NlptokenizebpeSeries) -> Int { self.vals.length() }

pub fn NlptokenizebpeSeries::sum(self : NlptokenizebpeSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizebpeSeries::mean(self : NlptokenizebpeSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizebpeSeries::min(self : NlptokenizebpeSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizebpeSeries::max(self : NlptokenizebpeSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizebpeSeries::range(self : NlptokenizebpeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizebpeSeries::variance(self : NlptokenizebpeSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizebpeSeries::std(self : NlptokenizebpeSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizebpeSeries::median(self : NlptokenizebpeSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizebpeSeries::scale(self : NlptokenizebpeSeries, f : Double) -> NlptokenizebpeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizebpeSeries::add(self : NlptokenizebpeSeries, other : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizebpeSeries::sub(self : NlptokenizebpeSeries, other : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizebpeSeries::normalize(self : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizebpeSeries::cumsum(self : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizebpeSeries::to_string(self : NlptokenizebpeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizebpeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_bpe_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizebpeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_bpe_matrix_identity(n : Int) -> NlptokenizebpeMatrix {
  let m = nlp_tokenize_bpe_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizebpeMatrix::get(self : NlptokenizebpeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizebpeMatrix::transpose(self : NlptokenizebpeMatrix) -> NlptokenizebpeMatrix {
  let result = nlp_tokenize_bpe_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizebpeMatrix::add(self : NlptokenizebpeMatrix, other : NlptokenizebpeMatrix) -> NlptokenizebpeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_bpe_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizebpeMatrix::scale(self : NlptokenizebpeMatrix, s : Double) -> NlptokenizebpeMatrix {
  let result = nlp_tokenize_bpe_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizebpeMatrix::multiply(self : NlptokenizebpeMatrix, other : NlptokenizebpeMatrix) -> NlptokenizebpeMatrix {
  if self.cols != other.rows { return nlp_tokenize_bpe_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_bpe_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizebpeMatrix::trace(self : NlptokenizebpeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizebpeMatrix::det(self : NlptokenizebpeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizebpeMatrix::norm(self : NlptokenizebpeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizebpeMatrix::to_string(self : NlptokenizebpeMatrix) -> String {
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

pub(all) struct NlptokenizebpeVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_bpe_make_vector(comps : Array[Double]) -> NlptokenizebpeVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_bpe_vector_zero(dim : Int) -> NlptokenizebpeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizebpeVector::add(self : NlptokenizebpeVector, other : NlptokenizebpeVector) -> NlptokenizebpeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizebpeVector::sub(self : NlptokenizebpeVector, other : NlptokenizebpeVector) -> NlptokenizebpeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizebpeVector::scale(self : NlptokenizebpeVector, s : Double) -> NlptokenizebpeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizebpeVector::dot(self : NlptokenizebpeVector, other : NlptokenizebpeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizebpeVector::norm(self : NlptokenizebpeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizebpeVector::normalize(self : NlptokenizebpeVector) -> NlptokenizebpeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizebpeVector::dist(self : NlptokenizebpeVector, other : NlptokenizebpeVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizebpeVector::to_string(self : NlptokenizebpeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizebpeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_frame_make(size : Int) -> NlptokenizebpeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeFrame::len(self : NlptokenizebpeFrame) -> Int { self.size }

pub fn NlptokenizebpeFrame::get(self : NlptokenizebpeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeFrame::set(self : NlptokenizebpeFrame, i : Int, v : Double) -> NlptokenizebpeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeFrame::sum(self : NlptokenizebpeFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeFrame::mean(self : NlptokenizebpeFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeFrame::scale(self : NlptokenizebpeFrame, f : Double) -> NlptokenizebpeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeFrame::add(self : NlptokenizebpeFrame, other : NlptokenizebpeFrame) -> NlptokenizebpeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeFrame::copy(self : NlptokenizebpeFrame) -> NlptokenizebpeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeFrame::fill(self : NlptokenizebpeFrame, v : Double) -> NlptokenizebpeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeFrame::min(self : NlptokenizebpeFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeFrame::max(self : NlptokenizebpeFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeFrame::to_string(self : NlptokenizebpeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_table_make(size : Int) -> NlptokenizebpeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeTable::len(self : NlptokenizebpeTable) -> Int { self.size }

pub fn NlptokenizebpeTable::get(self : NlptokenizebpeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeTable::set(self : NlptokenizebpeTable, i : Int, v : Double) -> NlptokenizebpeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeTable::sum(self : NlptokenizebpeTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeTable::mean(self : NlptokenizebpeTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeTable::scale(self : NlptokenizebpeTable, f : Double) -> NlptokenizebpeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeTable::add(self : NlptokenizebpeTable, other : NlptokenizebpeTable) -> NlptokenizebpeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeTable::copy(self : NlptokenizebpeTable) -> NlptokenizebpeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeTable::fill(self : NlptokenizebpeTable, v : Double) -> NlptokenizebpeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeTable::min(self : NlptokenizebpeTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeTable::max(self : NlptokenizebpeTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeTable::to_string(self : NlptokenizebpeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_graphn_make(size : Int) -> NlptokenizebpeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeGraphN::len(self : NlptokenizebpeGraphN) -> Int { self.size }

pub fn NlptokenizebpeGraphN::get(self : NlptokenizebpeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeGraphN::set(self : NlptokenizebpeGraphN, i : Int, v : Double) -> NlptokenizebpeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeGraphN::sum(self : NlptokenizebpeGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeGraphN::mean(self : NlptokenizebpeGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeGraphN::scale(self : NlptokenizebpeGraphN, f : Double) -> NlptokenizebpeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeGraphN::add(self : NlptokenizebpeGraphN, other : NlptokenizebpeGraphN) -> NlptokenizebpeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeGraphN::copy(self : NlptokenizebpeGraphN) -> NlptokenizebpeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeGraphN::fill(self : NlptokenizebpeGraphN, v : Double) -> NlptokenizebpeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeGraphN::min(self : NlptokenizebpeGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeGraphN::max(self : NlptokenizebpeGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeGraphN::to_string(self : NlptokenizebpeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_node_make(size : Int) -> NlptokenizebpeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeNode::len(self : NlptokenizebpeNode) -> Int { self.size }

pub fn NlptokenizebpeNode::get(self : NlptokenizebpeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeNode::set(self : NlptokenizebpeNode, i : Int, v : Double) -> NlptokenizebpeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeNode::sum(self : NlptokenizebpeNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeNode::mean(self : NlptokenizebpeNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeNode::scale(self : NlptokenizebpeNode, f : Double) -> NlptokenizebpeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeNode::add(self : NlptokenizebpeNode, other : NlptokenizebpeNode) -> NlptokenizebpeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeNode::copy(self : NlptokenizebpeNode) -> NlptokenizebpeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeNode::fill(self : NlptokenizebpeNode, v : Double) -> NlptokenizebpeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeNode::min(self : NlptokenizebpeNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeNode::max(self : NlptokenizebpeNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeNode::to_string(self : NlptokenizebpeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_edge_make(size : Int) -> NlptokenizebpeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeEdge::len(self : NlptokenizebpeEdge) -> Int { self.size }

pub fn NlptokenizebpeEdge::get(self : NlptokenizebpeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeEdge::set(self : NlptokenizebpeEdge, i : Int, v : Double) -> NlptokenizebpeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeEdge::sum(self : NlptokenizebpeEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeEdge::mean(self : NlptokenizebpeEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeEdge::scale(self : NlptokenizebpeEdge, f : Double) -> NlptokenizebpeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeEdge::add(self : NlptokenizebpeEdge, other : NlptokenizebpeEdge) -> NlptokenizebpeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeEdge::copy(self : NlptokenizebpeEdge) -> NlptokenizebpeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeEdge::fill(self : NlptokenizebpeEdge, v : Double) -> NlptokenizebpeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeEdge::min(self : NlptokenizebpeEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeEdge::max(self : NlptokenizebpeEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeEdge::to_string(self : NlptokenizebpeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_path_make(size : Int) -> NlptokenizebpePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpePath::len(self : NlptokenizebpePath) -> Int { self.size }

pub fn NlptokenizebpePath::get(self : NlptokenizebpePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpePath::set(self : NlptokenizebpePath, i : Int, v : Double) -> NlptokenizebpePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpePath::sum(self : NlptokenizebpePath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpePath::mean(self : NlptokenizebpePath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpePath::scale(self : NlptokenizebpePath, f : Double) -> NlptokenizebpePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpePath::add(self : NlptokenizebpePath, other : NlptokenizebpePath) -> NlptokenizebpePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpePath::copy(self : NlptokenizebpePath) -> NlptokenizebpePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpePath::fill(self : NlptokenizebpePath, v : Double) -> NlptokenizebpePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpePath::min(self : NlptokenizebpePath) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpePath::max(self : NlptokenizebpePath) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpePath::to_string(self : NlptokenizebpePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_cluster_make(size : Int) -> NlptokenizebpeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeCluster::len(self : NlptokenizebpeCluster) -> Int { self.size }

pub fn NlptokenizebpeCluster::get(self : NlptokenizebpeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeCluster::set(self : NlptokenizebpeCluster, i : Int, v : Double) -> NlptokenizebpeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeCluster::sum(self : NlptokenizebpeCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeCluster::mean(self : NlptokenizebpeCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeCluster::scale(self : NlptokenizebpeCluster, f : Double) -> NlptokenizebpeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeCluster::add(self : NlptokenizebpeCluster, other : NlptokenizebpeCluster) -> NlptokenizebpeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeCluster::copy(self : NlptokenizebpeCluster) -> NlptokenizebpeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeCluster::fill(self : NlptokenizebpeCluster, v : Double) -> NlptokenizebpeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeCluster::min(self : NlptokenizebpeCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeCluster::max(self : NlptokenizebpeCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeCluster::to_string(self : NlptokenizebpeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_model_make(size : Int) -> NlptokenizebpeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeModel::len(self : NlptokenizebpeModel) -> Int { self.size }

pub fn NlptokenizebpeModel::get(self : NlptokenizebpeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeModel::set(self : NlptokenizebpeModel, i : Int, v : Double) -> NlptokenizebpeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeModel::sum(self : NlptokenizebpeModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeModel::mean(self : NlptokenizebpeModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeModel::scale(self : NlptokenizebpeModel, f : Double) -> NlptokenizebpeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeModel::add(self : NlptokenizebpeModel, other : NlptokenizebpeModel) -> NlptokenizebpeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeModel::copy(self : NlptokenizebpeModel) -> NlptokenizebpeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeModel::fill(self : NlptokenizebpeModel, v : Double) -> NlptokenizebpeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeModel::min(self : NlptokenizebpeModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeModel::max(self : NlptokenizebpeModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeModel::to_string(self : NlptokenizebpeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_layer_make(size : Int) -> NlptokenizebpeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeLayer::len(self : NlptokenizebpeLayer) -> Int { self.size }

pub fn NlptokenizebpeLayer::get(self : NlptokenizebpeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeLayer::set(self : NlptokenizebpeLayer, i : Int, v : Double) -> NlptokenizebpeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeLayer::sum(self : NlptokenizebpeLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeLayer::mean(self : NlptokenizebpeLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeLayer::scale(self : NlptokenizebpeLayer, f : Double) -> NlptokenizebpeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeLayer::add(self : NlptokenizebpeLayer, other : NlptokenizebpeLayer) -> NlptokenizebpeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeLayer::copy(self : NlptokenizebpeLayer) -> NlptokenizebpeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeLayer::fill(self : NlptokenizebpeLayer, v : Double) -> NlptokenizebpeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeLayer::min(self : NlptokenizebpeLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeLayer::max(self : NlptokenizebpeLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeLayer::to_string(self : NlptokenizebpeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_buffer_make(size : Int) -> NlptokenizebpeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeBuffer::len(self : NlptokenizebpeBuffer) -> Int { self.size }

pub fn NlptokenizebpeBuffer::get(self : NlptokenizebpeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeBuffer::set(self : NlptokenizebpeBuffer, i : Int, v : Double) -> NlptokenizebpeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeBuffer::sum(self : NlptokenizebpeBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeBuffer::mean(self : NlptokenizebpeBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeBuffer::scale(self : NlptokenizebpeBuffer, f : Double) -> NlptokenizebpeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeBuffer::add(self : NlptokenizebpeBuffer, other : NlptokenizebpeBuffer) -> NlptokenizebpeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeBuffer::copy(self : NlptokenizebpeBuffer) -> NlptokenizebpeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeBuffer::fill(self : NlptokenizebpeBuffer, v : Double) -> NlptokenizebpeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeBuffer::min(self : NlptokenizebpeBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeBuffer::max(self : NlptokenizebpeBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeBuffer::to_string(self : NlptokenizebpeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_cursor_make(size : Int) -> NlptokenizebpeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeCursor::len(self : NlptokenizebpeCursor) -> Int { self.size }

pub fn NlptokenizebpeCursor::get(self : NlptokenizebpeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeCursor::set(self : NlptokenizebpeCursor, i : Int, v : Double) -> NlptokenizebpeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeCursor::sum(self : NlptokenizebpeCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeCursor::mean(self : NlptokenizebpeCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeCursor::scale(self : NlptokenizebpeCursor, f : Double) -> NlptokenizebpeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeCursor::add(self : NlptokenizebpeCursor, other : NlptokenizebpeCursor) -> NlptokenizebpeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeCursor::copy(self : NlptokenizebpeCursor) -> NlptokenizebpeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeCursor::fill(self : NlptokenizebpeCursor, v : Double) -> NlptokenizebpeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeCursor::min(self : NlptokenizebpeCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeCursor::max(self : NlptokenizebpeCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeCursor::to_string(self : NlptokenizebpeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_view_make(size : Int) -> NlptokenizebpeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeView::len(self : NlptokenizebpeView) -> Int { self.size }

pub fn NlptokenizebpeView::get(self : NlptokenizebpeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeView::set(self : NlptokenizebpeView, i : Int, v : Double) -> NlptokenizebpeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeView::sum(self : NlptokenizebpeView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeView::mean(self : NlptokenizebpeView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeView::scale(self : NlptokenizebpeView, f : Double) -> NlptokenizebpeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeView::add(self : NlptokenizebpeView, other : NlptokenizebpeView) -> NlptokenizebpeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeView::copy(self : NlptokenizebpeView) -> NlptokenizebpeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeView::fill(self : NlptokenizebpeView, v : Double) -> NlptokenizebpeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeView::min(self : NlptokenizebpeView) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeView::max(self : NlptokenizebpeView) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeView::to_string(self : NlptokenizebpeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_range_make(size : Int) -> NlptokenizebpeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeRange::len(self : NlptokenizebpeRange) -> Int { self.size }

pub fn NlptokenizebpeRange::get(self : NlptokenizebpeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeRange::set(self : NlptokenizebpeRange, i : Int, v : Double) -> NlptokenizebpeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeRange::sum(self : NlptokenizebpeRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeRange::mean(self : NlptokenizebpeRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeRange::scale(self : NlptokenizebpeRange, f : Double) -> NlptokenizebpeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeRange::add(self : NlptokenizebpeRange, other : NlptokenizebpeRange) -> NlptokenizebpeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeRange::copy(self : NlptokenizebpeRange) -> NlptokenizebpeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeRange::fill(self : NlptokenizebpeRange, v : Double) -> NlptokenizebpeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeRange::min(self : NlptokenizebpeRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeRange::max(self : NlptokenizebpeRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeRange::to_string(self : NlptokenizebpeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_slice_make(size : Int) -> NlptokenizebpeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizebpeSlice::len(self : NlptokenizebpeSlice) -> Int { self.size }

pub fn NlptokenizebpeSlice::get(self : NlptokenizebpeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizebpeSlice::set(self : NlptokenizebpeSlice, i : Int, v : Double) -> NlptokenizebpeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeSlice::sum(self : NlptokenizebpeSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizebpeSlice::mean(self : NlptokenizebpeSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizebpeSlice::scale(self : NlptokenizebpeSlice, f : Double) -> NlptokenizebpeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeSlice::add(self : NlptokenizebpeSlice, other : NlptokenizebpeSlice) -> NlptokenizebpeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizebpeSlice::copy(self : NlptokenizebpeSlice) -> NlptokenizebpeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeSlice::fill(self : NlptokenizebpeSlice, v : Double) -> NlptokenizebpeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizebpeSlice::min(self : NlptokenizebpeSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizebpeSlice::max(self : NlptokenizebpeSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizebpeSlice::to_string(self : NlptokenizebpeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

