///===
/// extcore/nlp_embed_universal

pub(all) struct NlpembeduniversalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_universal_make_point(x : Double, y : Double) -> NlpembeduniversalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_universal_make_point3(x : Double, y : Double, z : Double) -> NlpembeduniversalPoint {
  { x, y, z, label: 0 }
}

pub fn NlpembeduniversalPoint::x(self : NlpembeduniversalPoint) -> Double { self.x }

pub fn NlpembeduniversalPoint::y(self : NlpembeduniversalPoint) -> Double { self.y }

pub fn NlpembeduniversalPoint::z(self : NlpembeduniversalPoint) -> Double { self.z }

pub fn NlpembeduniversalPoint::label(self : NlpembeduniversalPoint) -> Int { self.label }

pub fn NlpembeduniversalPoint::dist(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembeduniversalPoint::add(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembeduniversalPoint::sub(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembeduniversalPoint::scale(self : NlpembeduniversalPoint, s : Double) -> NlpembeduniversalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembeduniversalPoint::dot(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembeduniversalPoint::cross(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembeduniversalPoint::norm(self : NlpembeduniversalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembeduniversalPoint::normalize(self : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembeduniversalPoint::negate(self : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembeduniversalPoint::mid(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembeduniversalPoint::lerp(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint, t : Double) -> NlpembeduniversalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembeduniversalPoint::to_string(self : NlpembeduniversalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembeduniversalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_universal_make_series(vals : Array[Double], name : String) -> NlpembeduniversalSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembeduniversalSeries::len(self : NlpembeduniversalSeries) -> Int { self.vals.length() }

pub fn NlpembeduniversalSeries::sum(self : NlpembeduniversalSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembeduniversalSeries::mean(self : NlpembeduniversalSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembeduniversalSeries::min(self : NlpembeduniversalSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembeduniversalSeries::max(self : NlpembeduniversalSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembeduniversalSeries::range(self : NlpembeduniversalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembeduniversalSeries::variance(self : NlpembeduniversalSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembeduniversalSeries::std(self : NlpembeduniversalSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembeduniversalSeries::median(self : NlpembeduniversalSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembeduniversalSeries::scale(self : NlpembeduniversalSeries, f : Double) -> NlpembeduniversalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembeduniversalSeries::add(self : NlpembeduniversalSeries, other : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembeduniversalSeries::sub(self : NlpembeduniversalSeries, other : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembeduniversalSeries::normalize(self : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembeduniversalSeries::cumsum(self : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembeduniversalSeries::to_string(self : NlpembeduniversalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembeduniversalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_universal_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembeduniversalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_universal_matrix_identity(n : Int) -> NlpembeduniversalMatrix {
  let m = nlp_embed_universal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembeduniversalMatrix::get(self : NlpembeduniversalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembeduniversalMatrix::transpose(self : NlpembeduniversalMatrix) -> NlpembeduniversalMatrix {
  let result = nlp_embed_universal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembeduniversalMatrix::add(self : NlpembeduniversalMatrix, other : NlpembeduniversalMatrix) -> NlpembeduniversalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_universal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembeduniversalMatrix::scale(self : NlpembeduniversalMatrix, s : Double) -> NlpembeduniversalMatrix {
  let result = nlp_embed_universal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembeduniversalMatrix::multiply(self : NlpembeduniversalMatrix, other : NlpembeduniversalMatrix) -> NlpembeduniversalMatrix {
  if self.cols != other.rows { return nlp_embed_universal_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_universal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpembeduniversalMatrix::trace(self : NlpembeduniversalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembeduniversalMatrix::det(self : NlpembeduniversalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembeduniversalMatrix::norm(self : NlpembeduniversalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembeduniversalMatrix::to_string(self : NlpembeduniversalMatrix) -> String {
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

pub(all) struct NlpembeduniversalVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_universal_make_vector(comps : Array[Double]) -> NlpembeduniversalVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_universal_vector_zero(dim : Int) -> NlpembeduniversalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembeduniversalVector::add(self : NlpembeduniversalVector, other : NlpembeduniversalVector) -> NlpembeduniversalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembeduniversalVector::sub(self : NlpembeduniversalVector, other : NlpembeduniversalVector) -> NlpembeduniversalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembeduniversalVector::scale(self : NlpembeduniversalVector, s : Double) -> NlpembeduniversalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembeduniversalVector::dot(self : NlpembeduniversalVector, other : NlpembeduniversalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembeduniversalVector::norm(self : NlpembeduniversalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembeduniversalVector::normalize(self : NlpembeduniversalVector) -> NlpembeduniversalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembeduniversalVector::dist(self : NlpembeduniversalVector, other : NlpembeduniversalVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembeduniversalVector::to_string(self : NlpembeduniversalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembeduniversalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_frame_make(size : Int) -> NlpembeduniversalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalFrame::len(self : NlpembeduniversalFrame) -> Int { self.size }

pub fn NlpembeduniversalFrame::get(self : NlpembeduniversalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalFrame::set(self : NlpembeduniversalFrame, i : Int, v : Double) -> NlpembeduniversalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalFrame::sum(self : NlpembeduniversalFrame) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalFrame::mean(self : NlpembeduniversalFrame) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalFrame::scale(self : NlpembeduniversalFrame, f : Double) -> NlpembeduniversalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalFrame::add(self : NlpembeduniversalFrame, other : NlpembeduniversalFrame) -> NlpembeduniversalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalFrame::copy(self : NlpembeduniversalFrame) -> NlpembeduniversalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalFrame::fill(self : NlpembeduniversalFrame, v : Double) -> NlpembeduniversalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalFrame::min(self : NlpembeduniversalFrame) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalFrame::max(self : NlpembeduniversalFrame) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalFrame::to_string(self : NlpembeduniversalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_table_make(size : Int) -> NlpembeduniversalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalTable::len(self : NlpembeduniversalTable) -> Int { self.size }

pub fn NlpembeduniversalTable::get(self : NlpembeduniversalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalTable::set(self : NlpembeduniversalTable, i : Int, v : Double) -> NlpembeduniversalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalTable::sum(self : NlpembeduniversalTable) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalTable::mean(self : NlpembeduniversalTable) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalTable::scale(self : NlpembeduniversalTable, f : Double) -> NlpembeduniversalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalTable::add(self : NlpembeduniversalTable, other : NlpembeduniversalTable) -> NlpembeduniversalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalTable::copy(self : NlpembeduniversalTable) -> NlpembeduniversalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalTable::fill(self : NlpembeduniversalTable, v : Double) -> NlpembeduniversalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalTable::min(self : NlpembeduniversalTable) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalTable::max(self : NlpembeduniversalTable) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalTable::to_string(self : NlpembeduniversalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_graphn_make(size : Int) -> NlpembeduniversalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalGraphN::len(self : NlpembeduniversalGraphN) -> Int { self.size }

pub fn NlpembeduniversalGraphN::get(self : NlpembeduniversalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalGraphN::set(self : NlpembeduniversalGraphN, i : Int, v : Double) -> NlpembeduniversalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalGraphN::sum(self : NlpembeduniversalGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalGraphN::mean(self : NlpembeduniversalGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalGraphN::scale(self : NlpembeduniversalGraphN, f : Double) -> NlpembeduniversalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalGraphN::add(self : NlpembeduniversalGraphN, other : NlpembeduniversalGraphN) -> NlpembeduniversalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalGraphN::copy(self : NlpembeduniversalGraphN) -> NlpembeduniversalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalGraphN::fill(self : NlpembeduniversalGraphN, v : Double) -> NlpembeduniversalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalGraphN::min(self : NlpembeduniversalGraphN) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalGraphN::max(self : NlpembeduniversalGraphN) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalGraphN::to_string(self : NlpembeduniversalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_node_make(size : Int) -> NlpembeduniversalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalNode::len(self : NlpembeduniversalNode) -> Int { self.size }

pub fn NlpembeduniversalNode::get(self : NlpembeduniversalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalNode::set(self : NlpembeduniversalNode, i : Int, v : Double) -> NlpembeduniversalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalNode::sum(self : NlpembeduniversalNode) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalNode::mean(self : NlpembeduniversalNode) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalNode::scale(self : NlpembeduniversalNode, f : Double) -> NlpembeduniversalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalNode::add(self : NlpembeduniversalNode, other : NlpembeduniversalNode) -> NlpembeduniversalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalNode::copy(self : NlpembeduniversalNode) -> NlpembeduniversalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalNode::fill(self : NlpembeduniversalNode, v : Double) -> NlpembeduniversalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalNode::min(self : NlpembeduniversalNode) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalNode::max(self : NlpembeduniversalNode) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalNode::to_string(self : NlpembeduniversalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_edge_make(size : Int) -> NlpembeduniversalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalEdge::len(self : NlpembeduniversalEdge) -> Int { self.size }

pub fn NlpembeduniversalEdge::get(self : NlpembeduniversalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalEdge::set(self : NlpembeduniversalEdge, i : Int, v : Double) -> NlpembeduniversalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalEdge::sum(self : NlpembeduniversalEdge) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalEdge::mean(self : NlpembeduniversalEdge) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalEdge::scale(self : NlpembeduniversalEdge, f : Double) -> NlpembeduniversalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalEdge::add(self : NlpembeduniversalEdge, other : NlpembeduniversalEdge) -> NlpembeduniversalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalEdge::copy(self : NlpembeduniversalEdge) -> NlpembeduniversalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalEdge::fill(self : NlpembeduniversalEdge, v : Double) -> NlpembeduniversalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalEdge::min(self : NlpembeduniversalEdge) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalEdge::max(self : NlpembeduniversalEdge) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalEdge::to_string(self : NlpembeduniversalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_path_make(size : Int) -> NlpembeduniversalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalPath::len(self : NlpembeduniversalPath) -> Int { self.size }

pub fn NlpembeduniversalPath::get(self : NlpembeduniversalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalPath::set(self : NlpembeduniversalPath, i : Int, v : Double) -> NlpembeduniversalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalPath::sum(self : NlpembeduniversalPath) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalPath::mean(self : NlpembeduniversalPath) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalPath::scale(self : NlpembeduniversalPath, f : Double) -> NlpembeduniversalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalPath::add(self : NlpembeduniversalPath, other : NlpembeduniversalPath) -> NlpembeduniversalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalPath::copy(self : NlpembeduniversalPath) -> NlpembeduniversalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalPath::fill(self : NlpembeduniversalPath, v : Double) -> NlpembeduniversalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalPath::min(self : NlpembeduniversalPath) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalPath::max(self : NlpembeduniversalPath) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalPath::to_string(self : NlpembeduniversalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_cluster_make(size : Int) -> NlpembeduniversalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalCluster::len(self : NlpembeduniversalCluster) -> Int { self.size }

pub fn NlpembeduniversalCluster::get(self : NlpembeduniversalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalCluster::set(self : NlpembeduniversalCluster, i : Int, v : Double) -> NlpembeduniversalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalCluster::sum(self : NlpembeduniversalCluster) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalCluster::mean(self : NlpembeduniversalCluster) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalCluster::scale(self : NlpembeduniversalCluster, f : Double) -> NlpembeduniversalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalCluster::add(self : NlpembeduniversalCluster, other : NlpembeduniversalCluster) -> NlpembeduniversalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalCluster::copy(self : NlpembeduniversalCluster) -> NlpembeduniversalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalCluster::fill(self : NlpembeduniversalCluster, v : Double) -> NlpembeduniversalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalCluster::min(self : NlpembeduniversalCluster) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalCluster::max(self : NlpembeduniversalCluster) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalCluster::to_string(self : NlpembeduniversalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_model_make(size : Int) -> NlpembeduniversalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalModel::len(self : NlpembeduniversalModel) -> Int { self.size }

pub fn NlpembeduniversalModel::get(self : NlpembeduniversalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalModel::set(self : NlpembeduniversalModel, i : Int, v : Double) -> NlpembeduniversalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalModel::sum(self : NlpembeduniversalModel) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalModel::mean(self : NlpembeduniversalModel) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalModel::scale(self : NlpembeduniversalModel, f : Double) -> NlpembeduniversalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalModel::add(self : NlpembeduniversalModel, other : NlpembeduniversalModel) -> NlpembeduniversalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalModel::copy(self : NlpembeduniversalModel) -> NlpembeduniversalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalModel::fill(self : NlpembeduniversalModel, v : Double) -> NlpembeduniversalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalModel::min(self : NlpembeduniversalModel) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalModel::max(self : NlpembeduniversalModel) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalModel::to_string(self : NlpembeduniversalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_layer_make(size : Int) -> NlpembeduniversalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalLayer::len(self : NlpembeduniversalLayer) -> Int { self.size }

pub fn NlpembeduniversalLayer::get(self : NlpembeduniversalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalLayer::set(self : NlpembeduniversalLayer, i : Int, v : Double) -> NlpembeduniversalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalLayer::sum(self : NlpembeduniversalLayer) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalLayer::mean(self : NlpembeduniversalLayer) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalLayer::scale(self : NlpembeduniversalLayer, f : Double) -> NlpembeduniversalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalLayer::add(self : NlpembeduniversalLayer, other : NlpembeduniversalLayer) -> NlpembeduniversalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalLayer::copy(self : NlpembeduniversalLayer) -> NlpembeduniversalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalLayer::fill(self : NlpembeduniversalLayer, v : Double) -> NlpembeduniversalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalLayer::min(self : NlpembeduniversalLayer) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalLayer::max(self : NlpembeduniversalLayer) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalLayer::to_string(self : NlpembeduniversalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_buffer_make(size : Int) -> NlpembeduniversalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalBuffer::len(self : NlpembeduniversalBuffer) -> Int { self.size }

pub fn NlpembeduniversalBuffer::get(self : NlpembeduniversalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalBuffer::set(self : NlpembeduniversalBuffer, i : Int, v : Double) -> NlpembeduniversalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalBuffer::sum(self : NlpembeduniversalBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalBuffer::mean(self : NlpembeduniversalBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalBuffer::scale(self : NlpembeduniversalBuffer, f : Double) -> NlpembeduniversalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalBuffer::add(self : NlpembeduniversalBuffer, other : NlpembeduniversalBuffer) -> NlpembeduniversalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalBuffer::copy(self : NlpembeduniversalBuffer) -> NlpembeduniversalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalBuffer::fill(self : NlpembeduniversalBuffer, v : Double) -> NlpembeduniversalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalBuffer::min(self : NlpembeduniversalBuffer) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalBuffer::max(self : NlpembeduniversalBuffer) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalBuffer::to_string(self : NlpembeduniversalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_cursor_make(size : Int) -> NlpembeduniversalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalCursor::len(self : NlpembeduniversalCursor) -> Int { self.size }

pub fn NlpembeduniversalCursor::get(self : NlpembeduniversalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalCursor::set(self : NlpembeduniversalCursor, i : Int, v : Double) -> NlpembeduniversalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalCursor::sum(self : NlpembeduniversalCursor) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalCursor::mean(self : NlpembeduniversalCursor) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalCursor::scale(self : NlpembeduniversalCursor, f : Double) -> NlpembeduniversalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalCursor::add(self : NlpembeduniversalCursor, other : NlpembeduniversalCursor) -> NlpembeduniversalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalCursor::copy(self : NlpembeduniversalCursor) -> NlpembeduniversalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalCursor::fill(self : NlpembeduniversalCursor, v : Double) -> NlpembeduniversalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalCursor::min(self : NlpembeduniversalCursor) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalCursor::max(self : NlpembeduniversalCursor) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalCursor::to_string(self : NlpembeduniversalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_view_make(size : Int) -> NlpembeduniversalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalView::len(self : NlpembeduniversalView) -> Int { self.size }

pub fn NlpembeduniversalView::get(self : NlpembeduniversalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalView::set(self : NlpembeduniversalView, i : Int, v : Double) -> NlpembeduniversalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalView::sum(self : NlpembeduniversalView) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalView::mean(self : NlpembeduniversalView) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalView::scale(self : NlpembeduniversalView, f : Double) -> NlpembeduniversalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalView::add(self : NlpembeduniversalView, other : NlpembeduniversalView) -> NlpembeduniversalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalView::copy(self : NlpembeduniversalView) -> NlpembeduniversalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalView::fill(self : NlpembeduniversalView, v : Double) -> NlpembeduniversalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalView::min(self : NlpembeduniversalView) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalView::max(self : NlpembeduniversalView) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalView::to_string(self : NlpembeduniversalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_range_make(size : Int) -> NlpembeduniversalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalRange::len(self : NlpembeduniversalRange) -> Int { self.size }

pub fn NlpembeduniversalRange::get(self : NlpembeduniversalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalRange::set(self : NlpembeduniversalRange, i : Int, v : Double) -> NlpembeduniversalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalRange::sum(self : NlpembeduniversalRange) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalRange::mean(self : NlpembeduniversalRange) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalRange::scale(self : NlpembeduniversalRange, f : Double) -> NlpembeduniversalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalRange::add(self : NlpembeduniversalRange, other : NlpembeduniversalRange) -> NlpembeduniversalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalRange::copy(self : NlpembeduniversalRange) -> NlpembeduniversalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalRange::fill(self : NlpembeduniversalRange, v : Double) -> NlpembeduniversalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalRange::min(self : NlpembeduniversalRange) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalRange::max(self : NlpembeduniversalRange) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalRange::to_string(self : NlpembeduniversalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_slice_make(size : Int) -> NlpembeduniversalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembeduniversalSlice::len(self : NlpembeduniversalSlice) -> Int { self.size }

pub fn NlpembeduniversalSlice::get(self : NlpembeduniversalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembeduniversalSlice::set(self : NlpembeduniversalSlice, i : Int, v : Double) -> NlpembeduniversalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalSlice::sum(self : NlpembeduniversalSlice) -> Double { @_common.sum(self.data) }

pub fn NlpembeduniversalSlice::mean(self : NlpembeduniversalSlice) -> Double { @_common.mean(self.data) }

pub fn NlpembeduniversalSlice::scale(self : NlpembeduniversalSlice, f : Double) -> NlpembeduniversalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalSlice::add(self : NlpembeduniversalSlice, other : NlpembeduniversalSlice) -> NlpembeduniversalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembeduniversalSlice::copy(self : NlpembeduniversalSlice) -> NlpembeduniversalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalSlice::fill(self : NlpembeduniversalSlice, v : Double) -> NlpembeduniversalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembeduniversalSlice::min(self : NlpembeduniversalSlice) -> Double { @_common.min(self.data) }

pub fn NlpembeduniversalSlice::max(self : NlpembeduniversalSlice) -> Double { @_common.max(self.data) }

pub fn NlpembeduniversalSlice::to_string(self : NlpembeduniversalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

