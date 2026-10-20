///===
/// extcore/nlp_tokenize_unigram

pub(all) struct NlptokenizeunigramPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_unigram_make_point(x : Double, y : Double) -> NlptokenizeunigramPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_unigram_make_point3(x : Double, y : Double, z : Double) -> NlptokenizeunigramPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizeunigramPoint::x(self : NlptokenizeunigramPoint) -> Double { self.x }

pub fn NlptokenizeunigramPoint::y(self : NlptokenizeunigramPoint) -> Double { self.y }

pub fn NlptokenizeunigramPoint::z(self : NlptokenizeunigramPoint) -> Double { self.z }

pub fn NlptokenizeunigramPoint::label(self : NlptokenizeunigramPoint) -> Int { self.label }

pub fn NlptokenizeunigramPoint::dist(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizeunigramPoint::add(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizeunigramPoint::sub(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizeunigramPoint::scale(self : NlptokenizeunigramPoint, s : Double) -> NlptokenizeunigramPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizeunigramPoint::dot(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizeunigramPoint::cross(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizeunigramPoint::norm(self : NlptokenizeunigramPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizeunigramPoint::normalize(self : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizeunigramPoint::negate(self : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizeunigramPoint::mid(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizeunigramPoint::lerp(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint, t : Double) -> NlptokenizeunigramPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizeunigramPoint::to_string(self : NlptokenizeunigramPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizeunigramSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_unigram_make_series(vals : Array[Double], name : String) -> NlptokenizeunigramSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizeunigramSeries::len(self : NlptokenizeunigramSeries) -> Int { self.vals.length() }

pub fn NlptokenizeunigramSeries::sum(self : NlptokenizeunigramSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizeunigramSeries::mean(self : NlptokenizeunigramSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizeunigramSeries::min(self : NlptokenizeunigramSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizeunigramSeries::max(self : NlptokenizeunigramSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizeunigramSeries::range(self : NlptokenizeunigramSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizeunigramSeries::variance(self : NlptokenizeunigramSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizeunigramSeries::std(self : NlptokenizeunigramSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizeunigramSeries::median(self : NlptokenizeunigramSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizeunigramSeries::scale(self : NlptokenizeunigramSeries, f : Double) -> NlptokenizeunigramSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizeunigramSeries::add(self : NlptokenizeunigramSeries, other : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizeunigramSeries::sub(self : NlptokenizeunigramSeries, other : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizeunigramSeries::normalize(self : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizeunigramSeries::cumsum(self : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizeunigramSeries::to_string(self : NlptokenizeunigramSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizeunigramMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_unigram_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizeunigramMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_unigram_matrix_identity(n : Int) -> NlptokenizeunigramMatrix {
  let m = nlp_tokenize_unigram_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizeunigramMatrix::get(self : NlptokenizeunigramMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizeunigramMatrix::transpose(self : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  let result = nlp_tokenize_unigram_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizeunigramMatrix::add(self : NlptokenizeunigramMatrix, other : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_unigram_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizeunigramMatrix::scale(self : NlptokenizeunigramMatrix, s : Double) -> NlptokenizeunigramMatrix {
  let result = nlp_tokenize_unigram_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizeunigramMatrix::multiply(self : NlptokenizeunigramMatrix, other : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  if self.cols != other.rows { return nlp_tokenize_unigram_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_unigram_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlptokenizeunigramMatrix::trace(self : NlptokenizeunigramMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizeunigramMatrix::det(self : NlptokenizeunigramMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizeunigramMatrix::norm(self : NlptokenizeunigramMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizeunigramMatrix::to_string(self : NlptokenizeunigramMatrix) -> String {
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

pub(all) struct NlptokenizeunigramVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_unigram_make_vector(comps : Array[Double]) -> NlptokenizeunigramVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_unigram_vector_zero(dim : Int) -> NlptokenizeunigramVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizeunigramVector::add(self : NlptokenizeunigramVector, other : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizeunigramVector::sub(self : NlptokenizeunigramVector, other : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizeunigramVector::scale(self : NlptokenizeunigramVector, s : Double) -> NlptokenizeunigramVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizeunigramVector::dot(self : NlptokenizeunigramVector, other : NlptokenizeunigramVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizeunigramVector::norm(self : NlptokenizeunigramVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizeunigramVector::normalize(self : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizeunigramVector::dist(self : NlptokenizeunigramVector, other : NlptokenizeunigramVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizeunigramVector::to_string(self : NlptokenizeunigramVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizeunigramFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_frame_make(size : Int) -> NlptokenizeunigramFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramFrame::len(self : NlptokenizeunigramFrame) -> Int { self.size }

pub fn NlptokenizeunigramFrame::get(self : NlptokenizeunigramFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramFrame::set(self : NlptokenizeunigramFrame, i : Int, v : Double) -> NlptokenizeunigramFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramFrame::sum(self : NlptokenizeunigramFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramFrame::mean(self : NlptokenizeunigramFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramFrame::scale(self : NlptokenizeunigramFrame, f : Double) -> NlptokenizeunigramFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramFrame::add(self : NlptokenizeunigramFrame, other : NlptokenizeunigramFrame) -> NlptokenizeunigramFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramFrame::copy(self : NlptokenizeunigramFrame) -> NlptokenizeunigramFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramFrame::fill(self : NlptokenizeunigramFrame, v : Double) -> NlptokenizeunigramFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramFrame::min(self : NlptokenizeunigramFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramFrame::max(self : NlptokenizeunigramFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramFrame::to_string(self : NlptokenizeunigramFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_table_make(size : Int) -> NlptokenizeunigramTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramTable::len(self : NlptokenizeunigramTable) -> Int { self.size }

pub fn NlptokenizeunigramTable::get(self : NlptokenizeunigramTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramTable::set(self : NlptokenizeunigramTable, i : Int, v : Double) -> NlptokenizeunigramTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramTable::sum(self : NlptokenizeunigramTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramTable::mean(self : NlptokenizeunigramTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramTable::scale(self : NlptokenizeunigramTable, f : Double) -> NlptokenizeunigramTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramTable::add(self : NlptokenizeunigramTable, other : NlptokenizeunigramTable) -> NlptokenizeunigramTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramTable::copy(self : NlptokenizeunigramTable) -> NlptokenizeunigramTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramTable::fill(self : NlptokenizeunigramTable, v : Double) -> NlptokenizeunigramTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramTable::min(self : NlptokenizeunigramTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramTable::max(self : NlptokenizeunigramTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramTable::to_string(self : NlptokenizeunigramTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_graphn_make(size : Int) -> NlptokenizeunigramGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramGraphN::len(self : NlptokenizeunigramGraphN) -> Int { self.size }

pub fn NlptokenizeunigramGraphN::get(self : NlptokenizeunigramGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramGraphN::set(self : NlptokenizeunigramGraphN, i : Int, v : Double) -> NlptokenizeunigramGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramGraphN::sum(self : NlptokenizeunigramGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramGraphN::mean(self : NlptokenizeunigramGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramGraphN::scale(self : NlptokenizeunigramGraphN, f : Double) -> NlptokenizeunigramGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramGraphN::add(self : NlptokenizeunigramGraphN, other : NlptokenizeunigramGraphN) -> NlptokenizeunigramGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramGraphN::copy(self : NlptokenizeunigramGraphN) -> NlptokenizeunigramGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramGraphN::fill(self : NlptokenizeunigramGraphN, v : Double) -> NlptokenizeunigramGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramGraphN::min(self : NlptokenizeunigramGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramGraphN::max(self : NlptokenizeunigramGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramGraphN::to_string(self : NlptokenizeunigramGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_node_make(size : Int) -> NlptokenizeunigramNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramNode::len(self : NlptokenizeunigramNode) -> Int { self.size }

pub fn NlptokenizeunigramNode::get(self : NlptokenizeunigramNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramNode::set(self : NlptokenizeunigramNode, i : Int, v : Double) -> NlptokenizeunigramNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramNode::sum(self : NlptokenizeunigramNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramNode::mean(self : NlptokenizeunigramNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramNode::scale(self : NlptokenizeunigramNode, f : Double) -> NlptokenizeunigramNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramNode::add(self : NlptokenizeunigramNode, other : NlptokenizeunigramNode) -> NlptokenizeunigramNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramNode::copy(self : NlptokenizeunigramNode) -> NlptokenizeunigramNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramNode::fill(self : NlptokenizeunigramNode, v : Double) -> NlptokenizeunigramNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramNode::min(self : NlptokenizeunigramNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramNode::max(self : NlptokenizeunigramNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramNode::to_string(self : NlptokenizeunigramNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_edge_make(size : Int) -> NlptokenizeunigramEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramEdge::len(self : NlptokenizeunigramEdge) -> Int { self.size }

pub fn NlptokenizeunigramEdge::get(self : NlptokenizeunigramEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramEdge::set(self : NlptokenizeunigramEdge, i : Int, v : Double) -> NlptokenizeunigramEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramEdge::sum(self : NlptokenizeunigramEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramEdge::mean(self : NlptokenizeunigramEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramEdge::scale(self : NlptokenizeunigramEdge, f : Double) -> NlptokenizeunigramEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramEdge::add(self : NlptokenizeunigramEdge, other : NlptokenizeunigramEdge) -> NlptokenizeunigramEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramEdge::copy(self : NlptokenizeunigramEdge) -> NlptokenizeunigramEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramEdge::fill(self : NlptokenizeunigramEdge, v : Double) -> NlptokenizeunigramEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramEdge::min(self : NlptokenizeunigramEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramEdge::max(self : NlptokenizeunigramEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramEdge::to_string(self : NlptokenizeunigramEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_path_make(size : Int) -> NlptokenizeunigramPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramPath::len(self : NlptokenizeunigramPath) -> Int { self.size }

pub fn NlptokenizeunigramPath::get(self : NlptokenizeunigramPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramPath::set(self : NlptokenizeunigramPath, i : Int, v : Double) -> NlptokenizeunigramPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramPath::sum(self : NlptokenizeunigramPath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramPath::mean(self : NlptokenizeunigramPath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramPath::scale(self : NlptokenizeunigramPath, f : Double) -> NlptokenizeunigramPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramPath::add(self : NlptokenizeunigramPath, other : NlptokenizeunigramPath) -> NlptokenizeunigramPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramPath::copy(self : NlptokenizeunigramPath) -> NlptokenizeunigramPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramPath::fill(self : NlptokenizeunigramPath, v : Double) -> NlptokenizeunigramPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramPath::min(self : NlptokenizeunigramPath) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramPath::max(self : NlptokenizeunigramPath) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramPath::to_string(self : NlptokenizeunigramPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_cluster_make(size : Int) -> NlptokenizeunigramCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramCluster::len(self : NlptokenizeunigramCluster) -> Int { self.size }

pub fn NlptokenizeunigramCluster::get(self : NlptokenizeunigramCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramCluster::set(self : NlptokenizeunigramCluster, i : Int, v : Double) -> NlptokenizeunigramCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramCluster::sum(self : NlptokenizeunigramCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramCluster::mean(self : NlptokenizeunigramCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramCluster::scale(self : NlptokenizeunigramCluster, f : Double) -> NlptokenizeunigramCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramCluster::add(self : NlptokenizeunigramCluster, other : NlptokenizeunigramCluster) -> NlptokenizeunigramCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramCluster::copy(self : NlptokenizeunigramCluster) -> NlptokenizeunigramCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramCluster::fill(self : NlptokenizeunigramCluster, v : Double) -> NlptokenizeunigramCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramCluster::min(self : NlptokenizeunigramCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramCluster::max(self : NlptokenizeunigramCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramCluster::to_string(self : NlptokenizeunigramCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_model_make(size : Int) -> NlptokenizeunigramModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramModel::len(self : NlptokenizeunigramModel) -> Int { self.size }

pub fn NlptokenizeunigramModel::get(self : NlptokenizeunigramModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramModel::set(self : NlptokenizeunigramModel, i : Int, v : Double) -> NlptokenizeunigramModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramModel::sum(self : NlptokenizeunigramModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramModel::mean(self : NlptokenizeunigramModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramModel::scale(self : NlptokenizeunigramModel, f : Double) -> NlptokenizeunigramModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramModel::add(self : NlptokenizeunigramModel, other : NlptokenizeunigramModel) -> NlptokenizeunigramModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramModel::copy(self : NlptokenizeunigramModel) -> NlptokenizeunigramModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramModel::fill(self : NlptokenizeunigramModel, v : Double) -> NlptokenizeunigramModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramModel::min(self : NlptokenizeunigramModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramModel::max(self : NlptokenizeunigramModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramModel::to_string(self : NlptokenizeunigramModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_layer_make(size : Int) -> NlptokenizeunigramLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramLayer::len(self : NlptokenizeunigramLayer) -> Int { self.size }

pub fn NlptokenizeunigramLayer::get(self : NlptokenizeunigramLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramLayer::set(self : NlptokenizeunigramLayer, i : Int, v : Double) -> NlptokenizeunigramLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramLayer::sum(self : NlptokenizeunigramLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramLayer::mean(self : NlptokenizeunigramLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramLayer::scale(self : NlptokenizeunigramLayer, f : Double) -> NlptokenizeunigramLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramLayer::add(self : NlptokenizeunigramLayer, other : NlptokenizeunigramLayer) -> NlptokenizeunigramLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramLayer::copy(self : NlptokenizeunigramLayer) -> NlptokenizeunigramLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramLayer::fill(self : NlptokenizeunigramLayer, v : Double) -> NlptokenizeunigramLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramLayer::min(self : NlptokenizeunigramLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramLayer::max(self : NlptokenizeunigramLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramLayer::to_string(self : NlptokenizeunigramLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_buffer_make(size : Int) -> NlptokenizeunigramBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramBuffer::len(self : NlptokenizeunigramBuffer) -> Int { self.size }

pub fn NlptokenizeunigramBuffer::get(self : NlptokenizeunigramBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramBuffer::set(self : NlptokenizeunigramBuffer, i : Int, v : Double) -> NlptokenizeunigramBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramBuffer::sum(self : NlptokenizeunigramBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramBuffer::mean(self : NlptokenizeunigramBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramBuffer::scale(self : NlptokenizeunigramBuffer, f : Double) -> NlptokenizeunigramBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramBuffer::add(self : NlptokenizeunigramBuffer, other : NlptokenizeunigramBuffer) -> NlptokenizeunigramBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramBuffer::copy(self : NlptokenizeunigramBuffer) -> NlptokenizeunigramBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramBuffer::fill(self : NlptokenizeunigramBuffer, v : Double) -> NlptokenizeunigramBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramBuffer::min(self : NlptokenizeunigramBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramBuffer::max(self : NlptokenizeunigramBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramBuffer::to_string(self : NlptokenizeunigramBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_cursor_make(size : Int) -> NlptokenizeunigramCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramCursor::len(self : NlptokenizeunigramCursor) -> Int { self.size }

pub fn NlptokenizeunigramCursor::get(self : NlptokenizeunigramCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramCursor::set(self : NlptokenizeunigramCursor, i : Int, v : Double) -> NlptokenizeunigramCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramCursor::sum(self : NlptokenizeunigramCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramCursor::mean(self : NlptokenizeunigramCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramCursor::scale(self : NlptokenizeunigramCursor, f : Double) -> NlptokenizeunigramCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramCursor::add(self : NlptokenizeunigramCursor, other : NlptokenizeunigramCursor) -> NlptokenizeunigramCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramCursor::copy(self : NlptokenizeunigramCursor) -> NlptokenizeunigramCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramCursor::fill(self : NlptokenizeunigramCursor, v : Double) -> NlptokenizeunigramCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramCursor::min(self : NlptokenizeunigramCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramCursor::max(self : NlptokenizeunigramCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramCursor::to_string(self : NlptokenizeunigramCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_view_make(size : Int) -> NlptokenizeunigramView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramView::len(self : NlptokenizeunigramView) -> Int { self.size }

pub fn NlptokenizeunigramView::get(self : NlptokenizeunigramView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramView::set(self : NlptokenizeunigramView, i : Int, v : Double) -> NlptokenizeunigramView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramView::sum(self : NlptokenizeunigramView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramView::mean(self : NlptokenizeunigramView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramView::scale(self : NlptokenizeunigramView, f : Double) -> NlptokenizeunigramView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramView::add(self : NlptokenizeunigramView, other : NlptokenizeunigramView) -> NlptokenizeunigramView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramView::copy(self : NlptokenizeunigramView) -> NlptokenizeunigramView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramView::fill(self : NlptokenizeunigramView, v : Double) -> NlptokenizeunigramView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramView::min(self : NlptokenizeunigramView) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramView::max(self : NlptokenizeunigramView) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramView::to_string(self : NlptokenizeunigramView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_range_make(size : Int) -> NlptokenizeunigramRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramRange::len(self : NlptokenizeunigramRange) -> Int { self.size }

pub fn NlptokenizeunigramRange::get(self : NlptokenizeunigramRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramRange::set(self : NlptokenizeunigramRange, i : Int, v : Double) -> NlptokenizeunigramRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramRange::sum(self : NlptokenizeunigramRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramRange::mean(self : NlptokenizeunigramRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramRange::scale(self : NlptokenizeunigramRange, f : Double) -> NlptokenizeunigramRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramRange::add(self : NlptokenizeunigramRange, other : NlptokenizeunigramRange) -> NlptokenizeunigramRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramRange::copy(self : NlptokenizeunigramRange) -> NlptokenizeunigramRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramRange::fill(self : NlptokenizeunigramRange, v : Double) -> NlptokenizeunigramRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramRange::min(self : NlptokenizeunigramRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramRange::max(self : NlptokenizeunigramRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramRange::to_string(self : NlptokenizeunigramRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_slice_make(size : Int) -> NlptokenizeunigramSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizeunigramSlice::len(self : NlptokenizeunigramSlice) -> Int { self.size }

pub fn NlptokenizeunigramSlice::get(self : NlptokenizeunigramSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizeunigramSlice::set(self : NlptokenizeunigramSlice, i : Int, v : Double) -> NlptokenizeunigramSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramSlice::sum(self : NlptokenizeunigramSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizeunigramSlice::mean(self : NlptokenizeunigramSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizeunigramSlice::scale(self : NlptokenizeunigramSlice, f : Double) -> NlptokenizeunigramSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramSlice::add(self : NlptokenizeunigramSlice, other : NlptokenizeunigramSlice) -> NlptokenizeunigramSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizeunigramSlice::copy(self : NlptokenizeunigramSlice) -> NlptokenizeunigramSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramSlice::fill(self : NlptokenizeunigramSlice, v : Double) -> NlptokenizeunigramSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizeunigramSlice::min(self : NlptokenizeunigramSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizeunigramSlice::max(self : NlptokenizeunigramSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizeunigramSlice::to_string(self : NlptokenizeunigramSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

