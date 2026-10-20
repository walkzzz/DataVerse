///===
/// extcore/nlp_tokenize_wordpiece

pub(all) struct NlptokenizewordpiecePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_wordpiece_make_point(x : Double, y : Double) -> NlptokenizewordpiecePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_wordpiece_make_point3(x : Double, y : Double, z : Double) -> NlptokenizewordpiecePoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizewordpiecePoint::x(self : NlptokenizewordpiecePoint) -> Double { self.x }

pub fn NlptokenizewordpiecePoint::y(self : NlptokenizewordpiecePoint) -> Double { self.y }

pub fn NlptokenizewordpiecePoint::z(self : NlptokenizewordpiecePoint) -> Double { self.z }

pub fn NlptokenizewordpiecePoint::label(self : NlptokenizewordpiecePoint) -> Int { self.label }

pub fn NlptokenizewordpiecePoint::dist(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizewordpiecePoint::add(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizewordpiecePoint::sub(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizewordpiecePoint::scale(self : NlptokenizewordpiecePoint, s : Double) -> NlptokenizewordpiecePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizewordpiecePoint::dot(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizewordpiecePoint::cross(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizewordpiecePoint::norm(self : NlptokenizewordpiecePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizewordpiecePoint::normalize(self : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizewordpiecePoint::negate(self : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizewordpiecePoint::mid(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizewordpiecePoint::lerp(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint, t : Double) -> NlptokenizewordpiecePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizewordpiecePoint::to_string(self : NlptokenizewordpiecePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_wordpiece_make_series(vals : Array[Double], name : String) -> NlptokenizewordpieceSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizewordpieceSeries::len(self : NlptokenizewordpieceSeries) -> Int { self.vals.length() }

pub fn NlptokenizewordpieceSeries::sum(self : NlptokenizewordpieceSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizewordpieceSeries::mean(self : NlptokenizewordpieceSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizewordpieceSeries::min(self : NlptokenizewordpieceSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizewordpieceSeries::max(self : NlptokenizewordpieceSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizewordpieceSeries::range(self : NlptokenizewordpieceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizewordpieceSeries::variance(self : NlptokenizewordpieceSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizewordpieceSeries::std(self : NlptokenizewordpieceSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizewordpieceSeries::median(self : NlptokenizewordpieceSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizewordpieceSeries::scale(self : NlptokenizewordpieceSeries, f : Double) -> NlptokenizewordpieceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizewordpieceSeries::add(self : NlptokenizewordpieceSeries, other : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizewordpieceSeries::sub(self : NlptokenizewordpieceSeries, other : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizewordpieceSeries::normalize(self : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizewordpieceSeries::cumsum(self : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizewordpieceSeries::to_string(self : NlptokenizewordpieceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizewordpieceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_wordpiece_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizewordpieceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_wordpiece_matrix_identity(n : Int) -> NlptokenizewordpieceMatrix {
  let m = nlp_tokenize_wordpiece_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizewordpieceMatrix::get(self : NlptokenizewordpieceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizewordpieceMatrix::transpose(self : NlptokenizewordpieceMatrix) -> NlptokenizewordpieceMatrix {
  let result = nlp_tokenize_wordpiece_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizewordpieceMatrix::add(self : NlptokenizewordpieceMatrix, other : NlptokenizewordpieceMatrix) -> NlptokenizewordpieceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_wordpiece_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizewordpieceMatrix::scale(self : NlptokenizewordpieceMatrix, s : Double) -> NlptokenizewordpieceMatrix {
  let result = nlp_tokenize_wordpiece_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizewordpieceMatrix::multiply(self : NlptokenizewordpieceMatrix, other : NlptokenizewordpieceMatrix) -> NlptokenizewordpieceMatrix {
  if self.cols != other.rows { return nlp_tokenize_wordpiece_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_wordpiece_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlptokenizewordpieceMatrix::trace(self : NlptokenizewordpieceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizewordpieceMatrix::det(self : NlptokenizewordpieceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizewordpieceMatrix::norm(self : NlptokenizewordpieceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizewordpieceMatrix::to_string(self : NlptokenizewordpieceMatrix) -> String {
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

pub(all) struct NlptokenizewordpieceVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_wordpiece_make_vector(comps : Array[Double]) -> NlptokenizewordpieceVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_wordpiece_vector_zero(dim : Int) -> NlptokenizewordpieceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizewordpieceVector::add(self : NlptokenizewordpieceVector, other : NlptokenizewordpieceVector) -> NlptokenizewordpieceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizewordpieceVector::sub(self : NlptokenizewordpieceVector, other : NlptokenizewordpieceVector) -> NlptokenizewordpieceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizewordpieceVector::scale(self : NlptokenizewordpieceVector, s : Double) -> NlptokenizewordpieceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizewordpieceVector::dot(self : NlptokenizewordpieceVector, other : NlptokenizewordpieceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizewordpieceVector::norm(self : NlptokenizewordpieceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizewordpieceVector::normalize(self : NlptokenizewordpieceVector) -> NlptokenizewordpieceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizewordpieceVector::dist(self : NlptokenizewordpieceVector, other : NlptokenizewordpieceVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizewordpieceVector::to_string(self : NlptokenizewordpieceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizewordpieceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_frame_make(size : Int) -> NlptokenizewordpieceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceFrame::len(self : NlptokenizewordpieceFrame) -> Int { self.size }

pub fn NlptokenizewordpieceFrame::get(self : NlptokenizewordpieceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceFrame::set(self : NlptokenizewordpieceFrame, i : Int, v : Double) -> NlptokenizewordpieceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceFrame::sum(self : NlptokenizewordpieceFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceFrame::mean(self : NlptokenizewordpieceFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceFrame::scale(self : NlptokenizewordpieceFrame, f : Double) -> NlptokenizewordpieceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceFrame::add(self : NlptokenizewordpieceFrame, other : NlptokenizewordpieceFrame) -> NlptokenizewordpieceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceFrame::copy(self : NlptokenizewordpieceFrame) -> NlptokenizewordpieceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceFrame::fill(self : NlptokenizewordpieceFrame, v : Double) -> NlptokenizewordpieceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceFrame::min(self : NlptokenizewordpieceFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceFrame::max(self : NlptokenizewordpieceFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceFrame::to_string(self : NlptokenizewordpieceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_table_make(size : Int) -> NlptokenizewordpieceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceTable::len(self : NlptokenizewordpieceTable) -> Int { self.size }

pub fn NlptokenizewordpieceTable::get(self : NlptokenizewordpieceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceTable::set(self : NlptokenizewordpieceTable, i : Int, v : Double) -> NlptokenizewordpieceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceTable::sum(self : NlptokenizewordpieceTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceTable::mean(self : NlptokenizewordpieceTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceTable::scale(self : NlptokenizewordpieceTable, f : Double) -> NlptokenizewordpieceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceTable::add(self : NlptokenizewordpieceTable, other : NlptokenizewordpieceTable) -> NlptokenizewordpieceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceTable::copy(self : NlptokenizewordpieceTable) -> NlptokenizewordpieceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceTable::fill(self : NlptokenizewordpieceTable, v : Double) -> NlptokenizewordpieceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceTable::min(self : NlptokenizewordpieceTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceTable::max(self : NlptokenizewordpieceTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceTable::to_string(self : NlptokenizewordpieceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_graphn_make(size : Int) -> NlptokenizewordpieceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceGraphN::len(self : NlptokenizewordpieceGraphN) -> Int { self.size }

pub fn NlptokenizewordpieceGraphN::get(self : NlptokenizewordpieceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceGraphN::set(self : NlptokenizewordpieceGraphN, i : Int, v : Double) -> NlptokenizewordpieceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceGraphN::sum(self : NlptokenizewordpieceGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceGraphN::mean(self : NlptokenizewordpieceGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceGraphN::scale(self : NlptokenizewordpieceGraphN, f : Double) -> NlptokenizewordpieceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceGraphN::add(self : NlptokenizewordpieceGraphN, other : NlptokenizewordpieceGraphN) -> NlptokenizewordpieceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceGraphN::copy(self : NlptokenizewordpieceGraphN) -> NlptokenizewordpieceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceGraphN::fill(self : NlptokenizewordpieceGraphN, v : Double) -> NlptokenizewordpieceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceGraphN::min(self : NlptokenizewordpieceGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceGraphN::max(self : NlptokenizewordpieceGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceGraphN::to_string(self : NlptokenizewordpieceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_node_make(size : Int) -> NlptokenizewordpieceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceNode::len(self : NlptokenizewordpieceNode) -> Int { self.size }

pub fn NlptokenizewordpieceNode::get(self : NlptokenizewordpieceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceNode::set(self : NlptokenizewordpieceNode, i : Int, v : Double) -> NlptokenizewordpieceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceNode::sum(self : NlptokenizewordpieceNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceNode::mean(self : NlptokenizewordpieceNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceNode::scale(self : NlptokenizewordpieceNode, f : Double) -> NlptokenizewordpieceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceNode::add(self : NlptokenizewordpieceNode, other : NlptokenizewordpieceNode) -> NlptokenizewordpieceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceNode::copy(self : NlptokenizewordpieceNode) -> NlptokenizewordpieceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceNode::fill(self : NlptokenizewordpieceNode, v : Double) -> NlptokenizewordpieceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceNode::min(self : NlptokenizewordpieceNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceNode::max(self : NlptokenizewordpieceNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceNode::to_string(self : NlptokenizewordpieceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_edge_make(size : Int) -> NlptokenizewordpieceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceEdge::len(self : NlptokenizewordpieceEdge) -> Int { self.size }

pub fn NlptokenizewordpieceEdge::get(self : NlptokenizewordpieceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceEdge::set(self : NlptokenizewordpieceEdge, i : Int, v : Double) -> NlptokenizewordpieceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceEdge::sum(self : NlptokenizewordpieceEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceEdge::mean(self : NlptokenizewordpieceEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceEdge::scale(self : NlptokenizewordpieceEdge, f : Double) -> NlptokenizewordpieceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceEdge::add(self : NlptokenizewordpieceEdge, other : NlptokenizewordpieceEdge) -> NlptokenizewordpieceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceEdge::copy(self : NlptokenizewordpieceEdge) -> NlptokenizewordpieceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceEdge::fill(self : NlptokenizewordpieceEdge, v : Double) -> NlptokenizewordpieceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceEdge::min(self : NlptokenizewordpieceEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceEdge::max(self : NlptokenizewordpieceEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceEdge::to_string(self : NlptokenizewordpieceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpiecePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_path_make(size : Int) -> NlptokenizewordpiecePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpiecePath::len(self : NlptokenizewordpiecePath) -> Int { self.size }

pub fn NlptokenizewordpiecePath::get(self : NlptokenizewordpiecePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpiecePath::set(self : NlptokenizewordpiecePath, i : Int, v : Double) -> NlptokenizewordpiecePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpiecePath::sum(self : NlptokenizewordpiecePath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpiecePath::mean(self : NlptokenizewordpiecePath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpiecePath::scale(self : NlptokenizewordpiecePath, f : Double) -> NlptokenizewordpiecePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpiecePath::add(self : NlptokenizewordpiecePath, other : NlptokenizewordpiecePath) -> NlptokenizewordpiecePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpiecePath::copy(self : NlptokenizewordpiecePath) -> NlptokenizewordpiecePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpiecePath::fill(self : NlptokenizewordpiecePath, v : Double) -> NlptokenizewordpiecePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpiecePath::min(self : NlptokenizewordpiecePath) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpiecePath::max(self : NlptokenizewordpiecePath) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpiecePath::to_string(self : NlptokenizewordpiecePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_cluster_make(size : Int) -> NlptokenizewordpieceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceCluster::len(self : NlptokenizewordpieceCluster) -> Int { self.size }

pub fn NlptokenizewordpieceCluster::get(self : NlptokenizewordpieceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceCluster::set(self : NlptokenizewordpieceCluster, i : Int, v : Double) -> NlptokenizewordpieceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceCluster::sum(self : NlptokenizewordpieceCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceCluster::mean(self : NlptokenizewordpieceCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceCluster::scale(self : NlptokenizewordpieceCluster, f : Double) -> NlptokenizewordpieceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceCluster::add(self : NlptokenizewordpieceCluster, other : NlptokenizewordpieceCluster) -> NlptokenizewordpieceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceCluster::copy(self : NlptokenizewordpieceCluster) -> NlptokenizewordpieceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceCluster::fill(self : NlptokenizewordpieceCluster, v : Double) -> NlptokenizewordpieceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceCluster::min(self : NlptokenizewordpieceCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceCluster::max(self : NlptokenizewordpieceCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceCluster::to_string(self : NlptokenizewordpieceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_model_make(size : Int) -> NlptokenizewordpieceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceModel::len(self : NlptokenizewordpieceModel) -> Int { self.size }

pub fn NlptokenizewordpieceModel::get(self : NlptokenizewordpieceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceModel::set(self : NlptokenizewordpieceModel, i : Int, v : Double) -> NlptokenizewordpieceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceModel::sum(self : NlptokenizewordpieceModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceModel::mean(self : NlptokenizewordpieceModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceModel::scale(self : NlptokenizewordpieceModel, f : Double) -> NlptokenizewordpieceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceModel::add(self : NlptokenizewordpieceModel, other : NlptokenizewordpieceModel) -> NlptokenizewordpieceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceModel::copy(self : NlptokenizewordpieceModel) -> NlptokenizewordpieceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceModel::fill(self : NlptokenizewordpieceModel, v : Double) -> NlptokenizewordpieceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceModel::min(self : NlptokenizewordpieceModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceModel::max(self : NlptokenizewordpieceModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceModel::to_string(self : NlptokenizewordpieceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_layer_make(size : Int) -> NlptokenizewordpieceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceLayer::len(self : NlptokenizewordpieceLayer) -> Int { self.size }

pub fn NlptokenizewordpieceLayer::get(self : NlptokenizewordpieceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceLayer::set(self : NlptokenizewordpieceLayer, i : Int, v : Double) -> NlptokenizewordpieceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceLayer::sum(self : NlptokenizewordpieceLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceLayer::mean(self : NlptokenizewordpieceLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceLayer::scale(self : NlptokenizewordpieceLayer, f : Double) -> NlptokenizewordpieceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceLayer::add(self : NlptokenizewordpieceLayer, other : NlptokenizewordpieceLayer) -> NlptokenizewordpieceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceLayer::copy(self : NlptokenizewordpieceLayer) -> NlptokenizewordpieceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceLayer::fill(self : NlptokenizewordpieceLayer, v : Double) -> NlptokenizewordpieceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceLayer::min(self : NlptokenizewordpieceLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceLayer::max(self : NlptokenizewordpieceLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceLayer::to_string(self : NlptokenizewordpieceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_buffer_make(size : Int) -> NlptokenizewordpieceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceBuffer::len(self : NlptokenizewordpieceBuffer) -> Int { self.size }

pub fn NlptokenizewordpieceBuffer::get(self : NlptokenizewordpieceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceBuffer::set(self : NlptokenizewordpieceBuffer, i : Int, v : Double) -> NlptokenizewordpieceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceBuffer::sum(self : NlptokenizewordpieceBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceBuffer::mean(self : NlptokenizewordpieceBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceBuffer::scale(self : NlptokenizewordpieceBuffer, f : Double) -> NlptokenizewordpieceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceBuffer::add(self : NlptokenizewordpieceBuffer, other : NlptokenizewordpieceBuffer) -> NlptokenizewordpieceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceBuffer::copy(self : NlptokenizewordpieceBuffer) -> NlptokenizewordpieceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceBuffer::fill(self : NlptokenizewordpieceBuffer, v : Double) -> NlptokenizewordpieceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceBuffer::min(self : NlptokenizewordpieceBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceBuffer::max(self : NlptokenizewordpieceBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceBuffer::to_string(self : NlptokenizewordpieceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_cursor_make(size : Int) -> NlptokenizewordpieceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceCursor::len(self : NlptokenizewordpieceCursor) -> Int { self.size }

pub fn NlptokenizewordpieceCursor::get(self : NlptokenizewordpieceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceCursor::set(self : NlptokenizewordpieceCursor, i : Int, v : Double) -> NlptokenizewordpieceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceCursor::sum(self : NlptokenizewordpieceCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceCursor::mean(self : NlptokenizewordpieceCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceCursor::scale(self : NlptokenizewordpieceCursor, f : Double) -> NlptokenizewordpieceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceCursor::add(self : NlptokenizewordpieceCursor, other : NlptokenizewordpieceCursor) -> NlptokenizewordpieceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceCursor::copy(self : NlptokenizewordpieceCursor) -> NlptokenizewordpieceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceCursor::fill(self : NlptokenizewordpieceCursor, v : Double) -> NlptokenizewordpieceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceCursor::min(self : NlptokenizewordpieceCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceCursor::max(self : NlptokenizewordpieceCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceCursor::to_string(self : NlptokenizewordpieceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_view_make(size : Int) -> NlptokenizewordpieceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceView::len(self : NlptokenizewordpieceView) -> Int { self.size }

pub fn NlptokenizewordpieceView::get(self : NlptokenizewordpieceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceView::set(self : NlptokenizewordpieceView, i : Int, v : Double) -> NlptokenizewordpieceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceView::sum(self : NlptokenizewordpieceView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceView::mean(self : NlptokenizewordpieceView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceView::scale(self : NlptokenizewordpieceView, f : Double) -> NlptokenizewordpieceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceView::add(self : NlptokenizewordpieceView, other : NlptokenizewordpieceView) -> NlptokenizewordpieceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceView::copy(self : NlptokenizewordpieceView) -> NlptokenizewordpieceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceView::fill(self : NlptokenizewordpieceView, v : Double) -> NlptokenizewordpieceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceView::min(self : NlptokenizewordpieceView) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceView::max(self : NlptokenizewordpieceView) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceView::to_string(self : NlptokenizewordpieceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_range_make(size : Int) -> NlptokenizewordpieceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceRange::len(self : NlptokenizewordpieceRange) -> Int { self.size }

pub fn NlptokenizewordpieceRange::get(self : NlptokenizewordpieceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceRange::set(self : NlptokenizewordpieceRange, i : Int, v : Double) -> NlptokenizewordpieceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceRange::sum(self : NlptokenizewordpieceRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceRange::mean(self : NlptokenizewordpieceRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceRange::scale(self : NlptokenizewordpieceRange, f : Double) -> NlptokenizewordpieceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceRange::add(self : NlptokenizewordpieceRange, other : NlptokenizewordpieceRange) -> NlptokenizewordpieceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceRange::copy(self : NlptokenizewordpieceRange) -> NlptokenizewordpieceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceRange::fill(self : NlptokenizewordpieceRange, v : Double) -> NlptokenizewordpieceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceRange::min(self : NlptokenizewordpieceRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceRange::max(self : NlptokenizewordpieceRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceRange::to_string(self : NlptokenizewordpieceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_slice_make(size : Int) -> NlptokenizewordpieceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizewordpieceSlice::len(self : NlptokenizewordpieceSlice) -> Int { self.size }

pub fn NlptokenizewordpieceSlice::get(self : NlptokenizewordpieceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizewordpieceSlice::set(self : NlptokenizewordpieceSlice, i : Int, v : Double) -> NlptokenizewordpieceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceSlice::sum(self : NlptokenizewordpieceSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizewordpieceSlice::mean(self : NlptokenizewordpieceSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizewordpieceSlice::scale(self : NlptokenizewordpieceSlice, f : Double) -> NlptokenizewordpieceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceSlice::add(self : NlptokenizewordpieceSlice, other : NlptokenizewordpieceSlice) -> NlptokenizewordpieceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizewordpieceSlice::copy(self : NlptokenizewordpieceSlice) -> NlptokenizewordpieceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceSlice::fill(self : NlptokenizewordpieceSlice, v : Double) -> NlptokenizewordpieceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizewordpieceSlice::min(self : NlptokenizewordpieceSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizewordpieceSlice::max(self : NlptokenizewordpieceSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizewordpieceSlice::to_string(self : NlptokenizewordpieceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

