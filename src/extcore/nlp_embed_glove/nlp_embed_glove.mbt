///===
/// extcore/nlp_embed_glove

pub(all) struct NlpembedglovePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_glove_make_point(x : Double, y : Double) -> NlpembedglovePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_glove_make_point3(x : Double, y : Double, z : Double) -> NlpembedglovePoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedglovePoint::x(self : NlpembedglovePoint) -> Double { self.x }

pub fn NlpembedglovePoint::y(self : NlpembedglovePoint) -> Double { self.y }

pub fn NlpembedglovePoint::z(self : NlpembedglovePoint) -> Double { self.z }

pub fn NlpembedglovePoint::label(self : NlpembedglovePoint) -> Int { self.label }

pub fn NlpembedglovePoint::dist(self : NlpembedglovePoint, other : NlpembedglovePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedglovePoint::add(self : NlpembedglovePoint, other : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedglovePoint::sub(self : NlpembedglovePoint, other : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedglovePoint::scale(self : NlpembedglovePoint, s : Double) -> NlpembedglovePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedglovePoint::dot(self : NlpembedglovePoint, other : NlpembedglovePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedglovePoint::cross(self : NlpembedglovePoint, other : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedglovePoint::norm(self : NlpembedglovePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedglovePoint::normalize(self : NlpembedglovePoint) -> NlpembedglovePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedglovePoint::negate(self : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedglovePoint::mid(self : NlpembedglovePoint, other : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedglovePoint::lerp(self : NlpembedglovePoint, other : NlpembedglovePoint, t : Double) -> NlpembedglovePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedglovePoint::to_string(self : NlpembedglovePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedgloveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_glove_make_series(vals : Array[Double], name : String) -> NlpembedgloveSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedgloveSeries::len(self : NlpembedgloveSeries) -> Int { self.vals.length() }

pub fn NlpembedgloveSeries::sum(self : NlpembedgloveSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedgloveSeries::mean(self : NlpembedgloveSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedgloveSeries::min(self : NlpembedgloveSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedgloveSeries::max(self : NlpembedgloveSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedgloveSeries::range(self : NlpembedgloveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedgloveSeries::variance(self : NlpembedgloveSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedgloveSeries::std(self : NlpembedgloveSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedgloveSeries::median(self : NlpembedgloveSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedgloveSeries::scale(self : NlpembedgloveSeries, f : Double) -> NlpembedgloveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedgloveSeries::add(self : NlpembedgloveSeries, other : NlpembedgloveSeries) -> NlpembedgloveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedgloveSeries::sub(self : NlpembedgloveSeries, other : NlpembedgloveSeries) -> NlpembedgloveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedgloveSeries::normalize(self : NlpembedgloveSeries) -> NlpembedgloveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedgloveSeries::cumsum(self : NlpembedgloveSeries) -> NlpembedgloveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedgloveSeries::to_string(self : NlpembedgloveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedgloveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_glove_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedgloveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_glove_matrix_identity(n : Int) -> NlpembedgloveMatrix {
  let m = nlp_embed_glove_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedgloveMatrix::get(self : NlpembedgloveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedgloveMatrix::transpose(self : NlpembedgloveMatrix) -> NlpembedgloveMatrix {
  let result = nlp_embed_glove_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedgloveMatrix::add(self : NlpembedgloveMatrix, other : NlpembedgloveMatrix) -> NlpembedgloveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_glove_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedgloveMatrix::scale(self : NlpembedgloveMatrix, s : Double) -> NlpembedgloveMatrix {
  let result = nlp_embed_glove_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedgloveMatrix::multiply(self : NlpembedgloveMatrix, other : NlpembedgloveMatrix) -> NlpembedgloveMatrix {
  if self.cols != other.rows { return nlp_embed_glove_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_glove_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpembedgloveMatrix::trace(self : NlpembedgloveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedgloveMatrix::det(self : NlpembedgloveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedgloveMatrix::norm(self : NlpembedgloveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedgloveMatrix::to_string(self : NlpembedgloveMatrix) -> String {
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

pub(all) struct NlpembedgloveVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_glove_make_vector(comps : Array[Double]) -> NlpembedgloveVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_glove_vector_zero(dim : Int) -> NlpembedgloveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedgloveVector::add(self : NlpembedgloveVector, other : NlpembedgloveVector) -> NlpembedgloveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedgloveVector::sub(self : NlpembedgloveVector, other : NlpembedgloveVector) -> NlpembedgloveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedgloveVector::scale(self : NlpembedgloveVector, s : Double) -> NlpembedgloveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedgloveVector::dot(self : NlpembedgloveVector, other : NlpembedgloveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedgloveVector::norm(self : NlpembedgloveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedgloveVector::normalize(self : NlpembedgloveVector) -> NlpembedgloveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedgloveVector::dist(self : NlpembedgloveVector, other : NlpembedgloveVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedgloveVector::to_string(self : NlpembedgloveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedgloveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_frame_make(size : Int) -> NlpembedgloveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveFrame::len(self : NlpembedgloveFrame) -> Int { self.size }

pub fn NlpembedgloveFrame::get(self : NlpembedgloveFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveFrame::set(self : NlpembedgloveFrame, i : Int, v : Double) -> NlpembedgloveFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveFrame::sum(self : NlpembedgloveFrame) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveFrame::mean(self : NlpembedgloveFrame) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveFrame::scale(self : NlpembedgloveFrame, f : Double) -> NlpembedgloveFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveFrame::add(self : NlpembedgloveFrame, other : NlpembedgloveFrame) -> NlpembedgloveFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveFrame::copy(self : NlpembedgloveFrame) -> NlpembedgloveFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveFrame::fill(self : NlpembedgloveFrame, v : Double) -> NlpembedgloveFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveFrame::min(self : NlpembedgloveFrame) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveFrame::max(self : NlpembedgloveFrame) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveFrame::to_string(self : NlpembedgloveFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_table_make(size : Int) -> NlpembedgloveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveTable::len(self : NlpembedgloveTable) -> Int { self.size }

pub fn NlpembedgloveTable::get(self : NlpembedgloveTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveTable::set(self : NlpembedgloveTable, i : Int, v : Double) -> NlpembedgloveTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveTable::sum(self : NlpembedgloveTable) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveTable::mean(self : NlpembedgloveTable) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveTable::scale(self : NlpembedgloveTable, f : Double) -> NlpembedgloveTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveTable::add(self : NlpembedgloveTable, other : NlpembedgloveTable) -> NlpembedgloveTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveTable::copy(self : NlpembedgloveTable) -> NlpembedgloveTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveTable::fill(self : NlpembedgloveTable, v : Double) -> NlpembedgloveTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveTable::min(self : NlpembedgloveTable) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveTable::max(self : NlpembedgloveTable) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveTable::to_string(self : NlpembedgloveTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_graphn_make(size : Int) -> NlpembedgloveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveGraphN::len(self : NlpembedgloveGraphN) -> Int { self.size }

pub fn NlpembedgloveGraphN::get(self : NlpembedgloveGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveGraphN::set(self : NlpembedgloveGraphN, i : Int, v : Double) -> NlpembedgloveGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveGraphN::sum(self : NlpembedgloveGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveGraphN::mean(self : NlpembedgloveGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveGraphN::scale(self : NlpembedgloveGraphN, f : Double) -> NlpembedgloveGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveGraphN::add(self : NlpembedgloveGraphN, other : NlpembedgloveGraphN) -> NlpembedgloveGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveGraphN::copy(self : NlpembedgloveGraphN) -> NlpembedgloveGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveGraphN::fill(self : NlpembedgloveGraphN, v : Double) -> NlpembedgloveGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveGraphN::min(self : NlpembedgloveGraphN) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveGraphN::max(self : NlpembedgloveGraphN) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveGraphN::to_string(self : NlpembedgloveGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_node_make(size : Int) -> NlpembedgloveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveNode::len(self : NlpembedgloveNode) -> Int { self.size }

pub fn NlpembedgloveNode::get(self : NlpembedgloveNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveNode::set(self : NlpembedgloveNode, i : Int, v : Double) -> NlpembedgloveNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveNode::sum(self : NlpembedgloveNode) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveNode::mean(self : NlpembedgloveNode) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveNode::scale(self : NlpembedgloveNode, f : Double) -> NlpembedgloveNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveNode::add(self : NlpembedgloveNode, other : NlpembedgloveNode) -> NlpembedgloveNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveNode::copy(self : NlpembedgloveNode) -> NlpembedgloveNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveNode::fill(self : NlpembedgloveNode, v : Double) -> NlpembedgloveNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveNode::min(self : NlpembedgloveNode) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveNode::max(self : NlpembedgloveNode) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveNode::to_string(self : NlpembedgloveNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_edge_make(size : Int) -> NlpembedgloveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveEdge::len(self : NlpembedgloveEdge) -> Int { self.size }

pub fn NlpembedgloveEdge::get(self : NlpembedgloveEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveEdge::set(self : NlpembedgloveEdge, i : Int, v : Double) -> NlpembedgloveEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveEdge::sum(self : NlpembedgloveEdge) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveEdge::mean(self : NlpembedgloveEdge) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveEdge::scale(self : NlpembedgloveEdge, f : Double) -> NlpembedgloveEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveEdge::add(self : NlpembedgloveEdge, other : NlpembedgloveEdge) -> NlpembedgloveEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveEdge::copy(self : NlpembedgloveEdge) -> NlpembedgloveEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveEdge::fill(self : NlpembedgloveEdge, v : Double) -> NlpembedgloveEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveEdge::min(self : NlpembedgloveEdge) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveEdge::max(self : NlpembedgloveEdge) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveEdge::to_string(self : NlpembedgloveEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedglovePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_path_make(size : Int) -> NlpembedglovePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedglovePath::len(self : NlpembedglovePath) -> Int { self.size }

pub fn NlpembedglovePath::get(self : NlpembedglovePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedglovePath::set(self : NlpembedglovePath, i : Int, v : Double) -> NlpembedglovePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedglovePath::sum(self : NlpembedglovePath) -> Double { @_common.sum(self.data) }

pub fn NlpembedglovePath::mean(self : NlpembedglovePath) -> Double { @_common.mean(self.data) }

pub fn NlpembedglovePath::scale(self : NlpembedglovePath, f : Double) -> NlpembedglovePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedglovePath::add(self : NlpembedglovePath, other : NlpembedglovePath) -> NlpembedglovePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedglovePath::copy(self : NlpembedglovePath) -> NlpembedglovePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedglovePath::fill(self : NlpembedglovePath, v : Double) -> NlpembedglovePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedglovePath::min(self : NlpembedglovePath) -> Double { @_common.min(self.data) }

pub fn NlpembedglovePath::max(self : NlpembedglovePath) -> Double { @_common.max(self.data) }

pub fn NlpembedglovePath::to_string(self : NlpembedglovePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_cluster_make(size : Int) -> NlpembedgloveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveCluster::len(self : NlpembedgloveCluster) -> Int { self.size }

pub fn NlpembedgloveCluster::get(self : NlpembedgloveCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveCluster::set(self : NlpembedgloveCluster, i : Int, v : Double) -> NlpembedgloveCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveCluster::sum(self : NlpembedgloveCluster) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveCluster::mean(self : NlpembedgloveCluster) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveCluster::scale(self : NlpembedgloveCluster, f : Double) -> NlpembedgloveCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveCluster::add(self : NlpembedgloveCluster, other : NlpembedgloveCluster) -> NlpembedgloveCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveCluster::copy(self : NlpembedgloveCluster) -> NlpembedgloveCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveCluster::fill(self : NlpembedgloveCluster, v : Double) -> NlpembedgloveCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveCluster::min(self : NlpembedgloveCluster) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveCluster::max(self : NlpembedgloveCluster) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveCluster::to_string(self : NlpembedgloveCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_model_make(size : Int) -> NlpembedgloveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveModel::len(self : NlpembedgloveModel) -> Int { self.size }

pub fn NlpembedgloveModel::get(self : NlpembedgloveModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveModel::set(self : NlpembedgloveModel, i : Int, v : Double) -> NlpembedgloveModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveModel::sum(self : NlpembedgloveModel) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveModel::mean(self : NlpembedgloveModel) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveModel::scale(self : NlpembedgloveModel, f : Double) -> NlpembedgloveModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveModel::add(self : NlpembedgloveModel, other : NlpembedgloveModel) -> NlpembedgloveModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveModel::copy(self : NlpembedgloveModel) -> NlpembedgloveModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveModel::fill(self : NlpembedgloveModel, v : Double) -> NlpembedgloveModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveModel::min(self : NlpembedgloveModel) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveModel::max(self : NlpembedgloveModel) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveModel::to_string(self : NlpembedgloveModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_layer_make(size : Int) -> NlpembedgloveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveLayer::len(self : NlpembedgloveLayer) -> Int { self.size }

pub fn NlpembedgloveLayer::get(self : NlpembedgloveLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveLayer::set(self : NlpembedgloveLayer, i : Int, v : Double) -> NlpembedgloveLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveLayer::sum(self : NlpembedgloveLayer) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveLayer::mean(self : NlpembedgloveLayer) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveLayer::scale(self : NlpembedgloveLayer, f : Double) -> NlpembedgloveLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveLayer::add(self : NlpembedgloveLayer, other : NlpembedgloveLayer) -> NlpembedgloveLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveLayer::copy(self : NlpembedgloveLayer) -> NlpembedgloveLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveLayer::fill(self : NlpembedgloveLayer, v : Double) -> NlpembedgloveLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveLayer::min(self : NlpembedgloveLayer) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveLayer::max(self : NlpembedgloveLayer) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveLayer::to_string(self : NlpembedgloveLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_buffer_make(size : Int) -> NlpembedgloveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveBuffer::len(self : NlpembedgloveBuffer) -> Int { self.size }

pub fn NlpembedgloveBuffer::get(self : NlpembedgloveBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveBuffer::set(self : NlpembedgloveBuffer, i : Int, v : Double) -> NlpembedgloveBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveBuffer::sum(self : NlpembedgloveBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveBuffer::mean(self : NlpembedgloveBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveBuffer::scale(self : NlpembedgloveBuffer, f : Double) -> NlpembedgloveBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveBuffer::add(self : NlpembedgloveBuffer, other : NlpembedgloveBuffer) -> NlpembedgloveBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveBuffer::copy(self : NlpembedgloveBuffer) -> NlpembedgloveBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveBuffer::fill(self : NlpembedgloveBuffer, v : Double) -> NlpembedgloveBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveBuffer::min(self : NlpembedgloveBuffer) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveBuffer::max(self : NlpembedgloveBuffer) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveBuffer::to_string(self : NlpembedgloveBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_cursor_make(size : Int) -> NlpembedgloveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveCursor::len(self : NlpembedgloveCursor) -> Int { self.size }

pub fn NlpembedgloveCursor::get(self : NlpembedgloveCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveCursor::set(self : NlpembedgloveCursor, i : Int, v : Double) -> NlpembedgloveCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveCursor::sum(self : NlpembedgloveCursor) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveCursor::mean(self : NlpembedgloveCursor) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveCursor::scale(self : NlpembedgloveCursor, f : Double) -> NlpembedgloveCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveCursor::add(self : NlpembedgloveCursor, other : NlpembedgloveCursor) -> NlpembedgloveCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveCursor::copy(self : NlpembedgloveCursor) -> NlpembedgloveCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveCursor::fill(self : NlpembedgloveCursor, v : Double) -> NlpembedgloveCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveCursor::min(self : NlpembedgloveCursor) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveCursor::max(self : NlpembedgloveCursor) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveCursor::to_string(self : NlpembedgloveCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_view_make(size : Int) -> NlpembedgloveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveView::len(self : NlpembedgloveView) -> Int { self.size }

pub fn NlpembedgloveView::get(self : NlpembedgloveView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveView::set(self : NlpembedgloveView, i : Int, v : Double) -> NlpembedgloveView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveView::sum(self : NlpembedgloveView) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveView::mean(self : NlpembedgloveView) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveView::scale(self : NlpembedgloveView, f : Double) -> NlpembedgloveView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveView::add(self : NlpembedgloveView, other : NlpembedgloveView) -> NlpembedgloveView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveView::copy(self : NlpembedgloveView) -> NlpembedgloveView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveView::fill(self : NlpembedgloveView, v : Double) -> NlpembedgloveView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveView::min(self : NlpembedgloveView) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveView::max(self : NlpembedgloveView) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveView::to_string(self : NlpembedgloveView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_range_make(size : Int) -> NlpembedgloveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveRange::len(self : NlpembedgloveRange) -> Int { self.size }

pub fn NlpembedgloveRange::get(self : NlpembedgloveRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveRange::set(self : NlpembedgloveRange, i : Int, v : Double) -> NlpembedgloveRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveRange::sum(self : NlpembedgloveRange) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveRange::mean(self : NlpembedgloveRange) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveRange::scale(self : NlpembedgloveRange, f : Double) -> NlpembedgloveRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveRange::add(self : NlpembedgloveRange, other : NlpembedgloveRange) -> NlpembedgloveRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveRange::copy(self : NlpembedgloveRange) -> NlpembedgloveRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveRange::fill(self : NlpembedgloveRange, v : Double) -> NlpembedgloveRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveRange::min(self : NlpembedgloveRange) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveRange::max(self : NlpembedgloveRange) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveRange::to_string(self : NlpembedgloveRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_slice_make(size : Int) -> NlpembedgloveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgloveSlice::len(self : NlpembedgloveSlice) -> Int { self.size }

pub fn NlpembedgloveSlice::get(self : NlpembedgloveSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgloveSlice::set(self : NlpembedgloveSlice, i : Int, v : Double) -> NlpembedgloveSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgloveSlice::sum(self : NlpembedgloveSlice) -> Double { @_common.sum(self.data) }

pub fn NlpembedgloveSlice::mean(self : NlpembedgloveSlice) -> Double { @_common.mean(self.data) }

pub fn NlpembedgloveSlice::scale(self : NlpembedgloveSlice, f : Double) -> NlpembedgloveSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveSlice::add(self : NlpembedgloveSlice, other : NlpembedgloveSlice) -> NlpembedgloveSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgloveSlice::copy(self : NlpembedgloveSlice) -> NlpembedgloveSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveSlice::fill(self : NlpembedgloveSlice, v : Double) -> NlpembedgloveSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgloveSlice::min(self : NlpembedgloveSlice) -> Double { @_common.min(self.data) }

pub fn NlpembedgloveSlice::max(self : NlpembedgloveSlice) -> Double { @_common.max(self.data) }

pub fn NlpembedgloveSlice::to_string(self : NlpembedgloveSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

