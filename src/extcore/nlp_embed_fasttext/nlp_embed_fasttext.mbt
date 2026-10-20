///===
/// extcore/nlp_embed_fasttext

pub(all) struct NlpembedfasttextPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_fasttext_make_point(x : Double, y : Double) -> NlpembedfasttextPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_fasttext_make_point3(x : Double, y : Double, z : Double) -> NlpembedfasttextPoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedfasttextPoint::x(self : NlpembedfasttextPoint) -> Double { self.x }

pub fn NlpembedfasttextPoint::y(self : NlpembedfasttextPoint) -> Double { self.y }

pub fn NlpembedfasttextPoint::z(self : NlpembedfasttextPoint) -> Double { self.z }

pub fn NlpembedfasttextPoint::label(self : NlpembedfasttextPoint) -> Int { self.label }

pub fn NlpembedfasttextPoint::dist(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedfasttextPoint::add(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedfasttextPoint::sub(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedfasttextPoint::scale(self : NlpembedfasttextPoint, s : Double) -> NlpembedfasttextPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedfasttextPoint::dot(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedfasttextPoint::cross(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedfasttextPoint::norm(self : NlpembedfasttextPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedfasttextPoint::normalize(self : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedfasttextPoint::negate(self : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedfasttextPoint::mid(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedfasttextPoint::lerp(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint, t : Double) -> NlpembedfasttextPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedfasttextPoint::to_string(self : NlpembedfasttextPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedfasttextSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_fasttext_make_series(vals : Array[Double], name : String) -> NlpembedfasttextSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedfasttextSeries::len(self : NlpembedfasttextSeries) -> Int { self.vals.length() }

pub fn NlpembedfasttextSeries::sum(self : NlpembedfasttextSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedfasttextSeries::mean(self : NlpembedfasttextSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedfasttextSeries::min(self : NlpembedfasttextSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedfasttextSeries::max(self : NlpembedfasttextSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedfasttextSeries::range(self : NlpembedfasttextSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedfasttextSeries::variance(self : NlpembedfasttextSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedfasttextSeries::std(self : NlpembedfasttextSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedfasttextSeries::median(self : NlpembedfasttextSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedfasttextSeries::scale(self : NlpembedfasttextSeries, f : Double) -> NlpembedfasttextSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedfasttextSeries::add(self : NlpembedfasttextSeries, other : NlpembedfasttextSeries) -> NlpembedfasttextSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedfasttextSeries::sub(self : NlpembedfasttextSeries, other : NlpembedfasttextSeries) -> NlpembedfasttextSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedfasttextSeries::normalize(self : NlpembedfasttextSeries) -> NlpembedfasttextSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedfasttextSeries::cumsum(self : NlpembedfasttextSeries) -> NlpembedfasttextSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedfasttextSeries::to_string(self : NlpembedfasttextSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedfasttextMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_fasttext_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedfasttextMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_fasttext_matrix_identity(n : Int) -> NlpembedfasttextMatrix {
  let m = nlp_embed_fasttext_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedfasttextMatrix::get(self : NlpembedfasttextMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedfasttextMatrix::transpose(self : NlpembedfasttextMatrix) -> NlpembedfasttextMatrix {
  let result = nlp_embed_fasttext_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedfasttextMatrix::add(self : NlpembedfasttextMatrix, other : NlpembedfasttextMatrix) -> NlpembedfasttextMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_fasttext_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedfasttextMatrix::scale(self : NlpembedfasttextMatrix, s : Double) -> NlpembedfasttextMatrix {
  let result = nlp_embed_fasttext_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedfasttextMatrix::multiply(self : NlpembedfasttextMatrix, other : NlpembedfasttextMatrix) -> NlpembedfasttextMatrix {
  if self.cols != other.rows { return nlp_embed_fasttext_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_fasttext_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlpembedfasttextMatrix::trace(self : NlpembedfasttextMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedfasttextMatrix::det(self : NlpembedfasttextMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedfasttextMatrix::norm(self : NlpembedfasttextMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedfasttextMatrix::to_string(self : NlpembedfasttextMatrix) -> String {
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

pub(all) struct NlpembedfasttextVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_fasttext_make_vector(comps : Array[Double]) -> NlpembedfasttextVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_fasttext_vector_zero(dim : Int) -> NlpembedfasttextVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedfasttextVector::add(self : NlpembedfasttextVector, other : NlpembedfasttextVector) -> NlpembedfasttextVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedfasttextVector::sub(self : NlpembedfasttextVector, other : NlpembedfasttextVector) -> NlpembedfasttextVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedfasttextVector::scale(self : NlpembedfasttextVector, s : Double) -> NlpembedfasttextVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedfasttextVector::dot(self : NlpembedfasttextVector, other : NlpembedfasttextVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedfasttextVector::norm(self : NlpembedfasttextVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedfasttextVector::normalize(self : NlpembedfasttextVector) -> NlpembedfasttextVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedfasttextVector::dist(self : NlpembedfasttextVector, other : NlpembedfasttextVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedfasttextVector::to_string(self : NlpembedfasttextVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedfasttextFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_frame_make(size : Int) -> NlpembedfasttextFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextFrame::len(self : NlpembedfasttextFrame) -> Int { self.size }

pub fn NlpembedfasttextFrame::get(self : NlpembedfasttextFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextFrame::set(self : NlpembedfasttextFrame, i : Int, v : Double) -> NlpembedfasttextFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextFrame::sum(self : NlpembedfasttextFrame) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextFrame::mean(self : NlpembedfasttextFrame) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextFrame::scale(self : NlpembedfasttextFrame, f : Double) -> NlpembedfasttextFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextFrame::add(self : NlpembedfasttextFrame, other : NlpembedfasttextFrame) -> NlpembedfasttextFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextFrame::copy(self : NlpembedfasttextFrame) -> NlpembedfasttextFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextFrame::fill(self : NlpembedfasttextFrame, v : Double) -> NlpembedfasttextFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextFrame::min(self : NlpembedfasttextFrame) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextFrame::max(self : NlpembedfasttextFrame) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextFrame::to_string(self : NlpembedfasttextFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_table_make(size : Int) -> NlpembedfasttextTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextTable::len(self : NlpembedfasttextTable) -> Int { self.size }

pub fn NlpembedfasttextTable::get(self : NlpembedfasttextTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextTable::set(self : NlpembedfasttextTable, i : Int, v : Double) -> NlpembedfasttextTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextTable::sum(self : NlpembedfasttextTable) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextTable::mean(self : NlpembedfasttextTable) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextTable::scale(self : NlpembedfasttextTable, f : Double) -> NlpembedfasttextTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextTable::add(self : NlpembedfasttextTable, other : NlpembedfasttextTable) -> NlpembedfasttextTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextTable::copy(self : NlpembedfasttextTable) -> NlpembedfasttextTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextTable::fill(self : NlpembedfasttextTable, v : Double) -> NlpembedfasttextTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextTable::min(self : NlpembedfasttextTable) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextTable::max(self : NlpembedfasttextTable) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextTable::to_string(self : NlpembedfasttextTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_graphn_make(size : Int) -> NlpembedfasttextGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextGraphN::len(self : NlpembedfasttextGraphN) -> Int { self.size }

pub fn NlpembedfasttextGraphN::get(self : NlpembedfasttextGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextGraphN::set(self : NlpembedfasttextGraphN, i : Int, v : Double) -> NlpembedfasttextGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextGraphN::sum(self : NlpembedfasttextGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextGraphN::mean(self : NlpembedfasttextGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextGraphN::scale(self : NlpembedfasttextGraphN, f : Double) -> NlpembedfasttextGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextGraphN::add(self : NlpembedfasttextGraphN, other : NlpembedfasttextGraphN) -> NlpembedfasttextGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextGraphN::copy(self : NlpembedfasttextGraphN) -> NlpembedfasttextGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextGraphN::fill(self : NlpembedfasttextGraphN, v : Double) -> NlpembedfasttextGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextGraphN::min(self : NlpembedfasttextGraphN) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextGraphN::max(self : NlpembedfasttextGraphN) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextGraphN::to_string(self : NlpembedfasttextGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_node_make(size : Int) -> NlpembedfasttextNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextNode::len(self : NlpembedfasttextNode) -> Int { self.size }

pub fn NlpembedfasttextNode::get(self : NlpembedfasttextNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextNode::set(self : NlpembedfasttextNode, i : Int, v : Double) -> NlpembedfasttextNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextNode::sum(self : NlpembedfasttextNode) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextNode::mean(self : NlpembedfasttextNode) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextNode::scale(self : NlpembedfasttextNode, f : Double) -> NlpembedfasttextNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextNode::add(self : NlpembedfasttextNode, other : NlpembedfasttextNode) -> NlpembedfasttextNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextNode::copy(self : NlpembedfasttextNode) -> NlpembedfasttextNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextNode::fill(self : NlpembedfasttextNode, v : Double) -> NlpembedfasttextNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextNode::min(self : NlpembedfasttextNode) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextNode::max(self : NlpembedfasttextNode) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextNode::to_string(self : NlpembedfasttextNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_edge_make(size : Int) -> NlpembedfasttextEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextEdge::len(self : NlpembedfasttextEdge) -> Int { self.size }

pub fn NlpembedfasttextEdge::get(self : NlpembedfasttextEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextEdge::set(self : NlpembedfasttextEdge, i : Int, v : Double) -> NlpembedfasttextEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextEdge::sum(self : NlpembedfasttextEdge) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextEdge::mean(self : NlpembedfasttextEdge) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextEdge::scale(self : NlpembedfasttextEdge, f : Double) -> NlpembedfasttextEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextEdge::add(self : NlpembedfasttextEdge, other : NlpembedfasttextEdge) -> NlpembedfasttextEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextEdge::copy(self : NlpembedfasttextEdge) -> NlpembedfasttextEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextEdge::fill(self : NlpembedfasttextEdge, v : Double) -> NlpembedfasttextEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextEdge::min(self : NlpembedfasttextEdge) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextEdge::max(self : NlpembedfasttextEdge) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextEdge::to_string(self : NlpembedfasttextEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_path_make(size : Int) -> NlpembedfasttextPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextPath::len(self : NlpembedfasttextPath) -> Int { self.size }

pub fn NlpembedfasttextPath::get(self : NlpembedfasttextPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextPath::set(self : NlpembedfasttextPath, i : Int, v : Double) -> NlpembedfasttextPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextPath::sum(self : NlpembedfasttextPath) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextPath::mean(self : NlpembedfasttextPath) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextPath::scale(self : NlpembedfasttextPath, f : Double) -> NlpembedfasttextPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextPath::add(self : NlpembedfasttextPath, other : NlpembedfasttextPath) -> NlpembedfasttextPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextPath::copy(self : NlpembedfasttextPath) -> NlpembedfasttextPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextPath::fill(self : NlpembedfasttextPath, v : Double) -> NlpembedfasttextPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextPath::min(self : NlpembedfasttextPath) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextPath::max(self : NlpembedfasttextPath) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextPath::to_string(self : NlpembedfasttextPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_cluster_make(size : Int) -> NlpembedfasttextCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextCluster::len(self : NlpembedfasttextCluster) -> Int { self.size }

pub fn NlpembedfasttextCluster::get(self : NlpembedfasttextCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextCluster::set(self : NlpembedfasttextCluster, i : Int, v : Double) -> NlpembedfasttextCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextCluster::sum(self : NlpembedfasttextCluster) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextCluster::mean(self : NlpembedfasttextCluster) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextCluster::scale(self : NlpembedfasttextCluster, f : Double) -> NlpembedfasttextCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextCluster::add(self : NlpembedfasttextCluster, other : NlpembedfasttextCluster) -> NlpembedfasttextCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextCluster::copy(self : NlpembedfasttextCluster) -> NlpembedfasttextCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextCluster::fill(self : NlpembedfasttextCluster, v : Double) -> NlpembedfasttextCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextCluster::min(self : NlpembedfasttextCluster) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextCluster::max(self : NlpembedfasttextCluster) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextCluster::to_string(self : NlpembedfasttextCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_model_make(size : Int) -> NlpembedfasttextModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextModel::len(self : NlpembedfasttextModel) -> Int { self.size }

pub fn NlpembedfasttextModel::get(self : NlpembedfasttextModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextModel::set(self : NlpembedfasttextModel, i : Int, v : Double) -> NlpembedfasttextModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextModel::sum(self : NlpembedfasttextModel) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextModel::mean(self : NlpembedfasttextModel) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextModel::scale(self : NlpembedfasttextModel, f : Double) -> NlpembedfasttextModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextModel::add(self : NlpembedfasttextModel, other : NlpembedfasttextModel) -> NlpembedfasttextModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextModel::copy(self : NlpembedfasttextModel) -> NlpembedfasttextModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextModel::fill(self : NlpembedfasttextModel, v : Double) -> NlpembedfasttextModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextModel::min(self : NlpembedfasttextModel) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextModel::max(self : NlpembedfasttextModel) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextModel::to_string(self : NlpembedfasttextModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_layer_make(size : Int) -> NlpembedfasttextLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextLayer::len(self : NlpembedfasttextLayer) -> Int { self.size }

pub fn NlpembedfasttextLayer::get(self : NlpembedfasttextLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextLayer::set(self : NlpembedfasttextLayer, i : Int, v : Double) -> NlpembedfasttextLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextLayer::sum(self : NlpembedfasttextLayer) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextLayer::mean(self : NlpembedfasttextLayer) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextLayer::scale(self : NlpembedfasttextLayer, f : Double) -> NlpembedfasttextLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextLayer::add(self : NlpembedfasttextLayer, other : NlpembedfasttextLayer) -> NlpembedfasttextLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextLayer::copy(self : NlpembedfasttextLayer) -> NlpembedfasttextLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextLayer::fill(self : NlpembedfasttextLayer, v : Double) -> NlpembedfasttextLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextLayer::min(self : NlpembedfasttextLayer) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextLayer::max(self : NlpembedfasttextLayer) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextLayer::to_string(self : NlpembedfasttextLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_buffer_make(size : Int) -> NlpembedfasttextBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextBuffer::len(self : NlpembedfasttextBuffer) -> Int { self.size }

pub fn NlpembedfasttextBuffer::get(self : NlpembedfasttextBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextBuffer::set(self : NlpembedfasttextBuffer, i : Int, v : Double) -> NlpembedfasttextBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextBuffer::sum(self : NlpembedfasttextBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextBuffer::mean(self : NlpembedfasttextBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextBuffer::scale(self : NlpembedfasttextBuffer, f : Double) -> NlpembedfasttextBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextBuffer::add(self : NlpembedfasttextBuffer, other : NlpembedfasttextBuffer) -> NlpembedfasttextBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextBuffer::copy(self : NlpembedfasttextBuffer) -> NlpembedfasttextBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextBuffer::fill(self : NlpembedfasttextBuffer, v : Double) -> NlpembedfasttextBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextBuffer::min(self : NlpembedfasttextBuffer) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextBuffer::max(self : NlpembedfasttextBuffer) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextBuffer::to_string(self : NlpembedfasttextBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_cursor_make(size : Int) -> NlpembedfasttextCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextCursor::len(self : NlpembedfasttextCursor) -> Int { self.size }

pub fn NlpembedfasttextCursor::get(self : NlpembedfasttextCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextCursor::set(self : NlpembedfasttextCursor, i : Int, v : Double) -> NlpembedfasttextCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextCursor::sum(self : NlpembedfasttextCursor) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextCursor::mean(self : NlpembedfasttextCursor) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextCursor::scale(self : NlpembedfasttextCursor, f : Double) -> NlpembedfasttextCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextCursor::add(self : NlpembedfasttextCursor, other : NlpembedfasttextCursor) -> NlpembedfasttextCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextCursor::copy(self : NlpembedfasttextCursor) -> NlpembedfasttextCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextCursor::fill(self : NlpembedfasttextCursor, v : Double) -> NlpembedfasttextCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextCursor::min(self : NlpembedfasttextCursor) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextCursor::max(self : NlpembedfasttextCursor) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextCursor::to_string(self : NlpembedfasttextCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_view_make(size : Int) -> NlpembedfasttextView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextView::len(self : NlpembedfasttextView) -> Int { self.size }

pub fn NlpembedfasttextView::get(self : NlpembedfasttextView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextView::set(self : NlpembedfasttextView, i : Int, v : Double) -> NlpembedfasttextView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextView::sum(self : NlpembedfasttextView) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextView::mean(self : NlpembedfasttextView) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextView::scale(self : NlpembedfasttextView, f : Double) -> NlpembedfasttextView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextView::add(self : NlpembedfasttextView, other : NlpembedfasttextView) -> NlpembedfasttextView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextView::copy(self : NlpembedfasttextView) -> NlpembedfasttextView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextView::fill(self : NlpembedfasttextView, v : Double) -> NlpembedfasttextView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextView::min(self : NlpembedfasttextView) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextView::max(self : NlpembedfasttextView) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextView::to_string(self : NlpembedfasttextView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_range_make(size : Int) -> NlpembedfasttextRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextRange::len(self : NlpembedfasttextRange) -> Int { self.size }

pub fn NlpembedfasttextRange::get(self : NlpembedfasttextRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextRange::set(self : NlpembedfasttextRange, i : Int, v : Double) -> NlpembedfasttextRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextRange::sum(self : NlpembedfasttextRange) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextRange::mean(self : NlpembedfasttextRange) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextRange::scale(self : NlpembedfasttextRange, f : Double) -> NlpembedfasttextRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextRange::add(self : NlpembedfasttextRange, other : NlpembedfasttextRange) -> NlpembedfasttextRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextRange::copy(self : NlpembedfasttextRange) -> NlpembedfasttextRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextRange::fill(self : NlpembedfasttextRange, v : Double) -> NlpembedfasttextRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextRange::min(self : NlpembedfasttextRange) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextRange::max(self : NlpembedfasttextRange) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextRange::to_string(self : NlpembedfasttextRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_slice_make(size : Int) -> NlpembedfasttextSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedfasttextSlice::len(self : NlpembedfasttextSlice) -> Int { self.size }

pub fn NlpembedfasttextSlice::get(self : NlpembedfasttextSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedfasttextSlice::set(self : NlpembedfasttextSlice, i : Int, v : Double) -> NlpembedfasttextSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextSlice::sum(self : NlpembedfasttextSlice) -> Double { @_common.sum(self.data) }

pub fn NlpembedfasttextSlice::mean(self : NlpembedfasttextSlice) -> Double { @_common.mean(self.data) }

pub fn NlpembedfasttextSlice::scale(self : NlpembedfasttextSlice, f : Double) -> NlpembedfasttextSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextSlice::add(self : NlpembedfasttextSlice, other : NlpembedfasttextSlice) -> NlpembedfasttextSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedfasttextSlice::copy(self : NlpembedfasttextSlice) -> NlpembedfasttextSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextSlice::fill(self : NlpembedfasttextSlice, v : Double) -> NlpembedfasttextSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedfasttextSlice::min(self : NlpembedfasttextSlice) -> Double { @_common.min(self.data) }

pub fn NlpembedfasttextSlice::max(self : NlpembedfasttextSlice) -> Double { @_common.max(self.data) }

pub fn NlpembedfasttextSlice::to_string(self : NlpembedfasttextSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

