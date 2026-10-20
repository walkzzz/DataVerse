///===
/// extcore/nlp_pos_transformer

pub(all) struct NlppostransformerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_transformer_make_point(x : Double, y : Double) -> NlppostransformerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_transformer_make_point3(x : Double, y : Double, z : Double) -> NlppostransformerPoint {
  { x, y, z, label: 0 }
}

pub fn NlppostransformerPoint::x(self : NlppostransformerPoint) -> Double { self.x }

pub fn NlppostransformerPoint::y(self : NlppostransformerPoint) -> Double { self.y }

pub fn NlppostransformerPoint::z(self : NlppostransformerPoint) -> Double { self.z }

pub fn NlppostransformerPoint::label(self : NlppostransformerPoint) -> Int { self.label }

pub fn NlppostransformerPoint::dist(self : NlppostransformerPoint, other : NlppostransformerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlppostransformerPoint::add(self : NlppostransformerPoint, other : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlppostransformerPoint::sub(self : NlppostransformerPoint, other : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlppostransformerPoint::scale(self : NlppostransformerPoint, s : Double) -> NlppostransformerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlppostransformerPoint::dot(self : NlppostransformerPoint, other : NlppostransformerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlppostransformerPoint::cross(self : NlppostransformerPoint, other : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlppostransformerPoint::norm(self : NlppostransformerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlppostransformerPoint::normalize(self : NlppostransformerPoint) -> NlppostransformerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppostransformerPoint::negate(self : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlppostransformerPoint::mid(self : NlppostransformerPoint, other : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlppostransformerPoint::lerp(self : NlppostransformerPoint, other : NlppostransformerPoint, t : Double) -> NlppostransformerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlppostransformerPoint::to_string(self : NlppostransformerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlppostransformerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_transformer_make_series(vals : Array[Double], name : String) -> NlppostransformerSeries {
  { vals, name, meta: 0 }
}

pub fn NlppostransformerSeries::len(self : NlppostransformerSeries) -> Int { self.vals.length() }

pub fn NlppostransformerSeries::sum(self : NlppostransformerSeries) -> Double { @_common.sum(self.vals) }

pub fn NlppostransformerSeries::mean(self : NlppostransformerSeries) -> Double { @_common.mean(self.vals) }

pub fn NlppostransformerSeries::min(self : NlppostransformerSeries) -> Double { @_common.min(self.vals) }

pub fn NlppostransformerSeries::max(self : NlppostransformerSeries) -> Double { @_common.max(self.vals) }

pub fn NlppostransformerSeries::range(self : NlppostransformerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlppostransformerSeries::variance(self : NlppostransformerSeries) -> Double { @_common.variance(self.vals) }

pub fn NlppostransformerSeries::std(self : NlppostransformerSeries) -> Double { @_common.std(self.vals) }

pub fn NlppostransformerSeries::median(self : NlppostransformerSeries) -> Double { @_common.median(self.vals) }

pub fn NlppostransformerSeries::scale(self : NlppostransformerSeries, f : Double) -> NlppostransformerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlppostransformerSeries::add(self : NlppostransformerSeries, other : NlppostransformerSeries) -> NlppostransformerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlppostransformerSeries::sub(self : NlppostransformerSeries, other : NlppostransformerSeries) -> NlppostransformerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlppostransformerSeries::normalize(self : NlppostransformerSeries) -> NlppostransformerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlppostransformerSeries::cumsum(self : NlppostransformerSeries) -> NlppostransformerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlppostransformerSeries::to_string(self : NlppostransformerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppostransformerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_transformer_make_matrix(rows : Int, cols : Int, val : Double) -> NlppostransformerMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_pos_transformer_matrix_identity(n : Int) -> NlppostransformerMatrix {
  let m = nlp_pos_transformer_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlppostransformerMatrix::get(self : NlppostransformerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlppostransformerMatrix::transpose(self : NlppostransformerMatrix) -> NlppostransformerMatrix {
  let result = nlp_pos_transformer_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlppostransformerMatrix::add(self : NlppostransformerMatrix, other : NlppostransformerMatrix) -> NlppostransformerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_transformer_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlppostransformerMatrix::scale(self : NlppostransformerMatrix, s : Double) -> NlppostransformerMatrix {
  let result = nlp_pos_transformer_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlppostransformerMatrix::multiply(self : NlppostransformerMatrix, other : NlppostransformerMatrix) -> NlppostransformerMatrix {
  if self.cols != other.rows { return nlp_pos_transformer_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_transformer_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlppostransformerMatrix::trace(self : NlppostransformerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlppostransformerMatrix::det(self : NlppostransformerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlppostransformerMatrix::norm(self : NlppostransformerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlppostransformerMatrix::to_string(self : NlppostransformerMatrix) -> String {
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

pub(all) struct NlppostransformerVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_transformer_make_vector(comps : Array[Double]) -> NlppostransformerVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_transformer_vector_zero(dim : Int) -> NlppostransformerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlppostransformerVector::add(self : NlppostransformerVector, other : NlppostransformerVector) -> NlppostransformerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlppostransformerVector::sub(self : NlppostransformerVector, other : NlppostransformerVector) -> NlppostransformerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlppostransformerVector::scale(self : NlppostransformerVector, s : Double) -> NlppostransformerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlppostransformerVector::dot(self : NlppostransformerVector, other : NlppostransformerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlppostransformerVector::norm(self : NlppostransformerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlppostransformerVector::normalize(self : NlppostransformerVector) -> NlppostransformerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppostransformerVector::dist(self : NlppostransformerVector, other : NlppostransformerVector) -> Double {
  self.sub(other).norm()
}

pub fn NlppostransformerVector::to_string(self : NlppostransformerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppostransformerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_frame_make(size : Int) -> NlppostransformerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerFrame::len(self : NlppostransformerFrame) -> Int { self.size }

pub fn NlppostransformerFrame::get(self : NlppostransformerFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerFrame::set(self : NlppostransformerFrame, i : Int, v : Double) -> NlppostransformerFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerFrame::sum(self : NlppostransformerFrame) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerFrame::mean(self : NlppostransformerFrame) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerFrame::scale(self : NlppostransformerFrame, f : Double) -> NlppostransformerFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerFrame::add(self : NlppostransformerFrame, other : NlppostransformerFrame) -> NlppostransformerFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerFrame::copy(self : NlppostransformerFrame) -> NlppostransformerFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerFrame::fill(self : NlppostransformerFrame, v : Double) -> NlppostransformerFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerFrame::min(self : NlppostransformerFrame) -> Double { @_common.min(self.data) }

pub fn NlppostransformerFrame::max(self : NlppostransformerFrame) -> Double { @_common.max(self.data) }

pub fn NlppostransformerFrame::to_string(self : NlppostransformerFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_table_make(size : Int) -> NlppostransformerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerTable::len(self : NlppostransformerTable) -> Int { self.size }

pub fn NlppostransformerTable::get(self : NlppostransformerTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerTable::set(self : NlppostransformerTable, i : Int, v : Double) -> NlppostransformerTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerTable::sum(self : NlppostransformerTable) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerTable::mean(self : NlppostransformerTable) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerTable::scale(self : NlppostransformerTable, f : Double) -> NlppostransformerTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerTable::add(self : NlppostransformerTable, other : NlppostransformerTable) -> NlppostransformerTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerTable::copy(self : NlppostransformerTable) -> NlppostransformerTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerTable::fill(self : NlppostransformerTable, v : Double) -> NlppostransformerTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerTable::min(self : NlppostransformerTable) -> Double { @_common.min(self.data) }

pub fn NlppostransformerTable::max(self : NlppostransformerTable) -> Double { @_common.max(self.data) }

pub fn NlppostransformerTable::to_string(self : NlppostransformerTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_graphn_make(size : Int) -> NlppostransformerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerGraphN::len(self : NlppostransformerGraphN) -> Int { self.size }

pub fn NlppostransformerGraphN::get(self : NlppostransformerGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerGraphN::set(self : NlppostransformerGraphN, i : Int, v : Double) -> NlppostransformerGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerGraphN::sum(self : NlppostransformerGraphN) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerGraphN::mean(self : NlppostransformerGraphN) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerGraphN::scale(self : NlppostransformerGraphN, f : Double) -> NlppostransformerGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerGraphN::add(self : NlppostransformerGraphN, other : NlppostransformerGraphN) -> NlppostransformerGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerGraphN::copy(self : NlppostransformerGraphN) -> NlppostransformerGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerGraphN::fill(self : NlppostransformerGraphN, v : Double) -> NlppostransformerGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerGraphN::min(self : NlppostransformerGraphN) -> Double { @_common.min(self.data) }

pub fn NlppostransformerGraphN::max(self : NlppostransformerGraphN) -> Double { @_common.max(self.data) }

pub fn NlppostransformerGraphN::to_string(self : NlppostransformerGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_node_make(size : Int) -> NlppostransformerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerNode::len(self : NlppostransformerNode) -> Int { self.size }

pub fn NlppostransformerNode::get(self : NlppostransformerNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerNode::set(self : NlppostransformerNode, i : Int, v : Double) -> NlppostransformerNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerNode::sum(self : NlppostransformerNode) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerNode::mean(self : NlppostransformerNode) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerNode::scale(self : NlppostransformerNode, f : Double) -> NlppostransformerNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerNode::add(self : NlppostransformerNode, other : NlppostransformerNode) -> NlppostransformerNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerNode::copy(self : NlppostransformerNode) -> NlppostransformerNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerNode::fill(self : NlppostransformerNode, v : Double) -> NlppostransformerNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerNode::min(self : NlppostransformerNode) -> Double { @_common.min(self.data) }

pub fn NlppostransformerNode::max(self : NlppostransformerNode) -> Double { @_common.max(self.data) }

pub fn NlppostransformerNode::to_string(self : NlppostransformerNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_edge_make(size : Int) -> NlppostransformerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerEdge::len(self : NlppostransformerEdge) -> Int { self.size }

pub fn NlppostransformerEdge::get(self : NlppostransformerEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerEdge::set(self : NlppostransformerEdge, i : Int, v : Double) -> NlppostransformerEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerEdge::sum(self : NlppostransformerEdge) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerEdge::mean(self : NlppostransformerEdge) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerEdge::scale(self : NlppostransformerEdge, f : Double) -> NlppostransformerEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerEdge::add(self : NlppostransformerEdge, other : NlppostransformerEdge) -> NlppostransformerEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerEdge::copy(self : NlppostransformerEdge) -> NlppostransformerEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerEdge::fill(self : NlppostransformerEdge, v : Double) -> NlppostransformerEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerEdge::min(self : NlppostransformerEdge) -> Double { @_common.min(self.data) }

pub fn NlppostransformerEdge::max(self : NlppostransformerEdge) -> Double { @_common.max(self.data) }

pub fn NlppostransformerEdge::to_string(self : NlppostransformerEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_path_make(size : Int) -> NlppostransformerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerPath::len(self : NlppostransformerPath) -> Int { self.size }

pub fn NlppostransformerPath::get(self : NlppostransformerPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerPath::set(self : NlppostransformerPath, i : Int, v : Double) -> NlppostransformerPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerPath::sum(self : NlppostransformerPath) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerPath::mean(self : NlppostransformerPath) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerPath::scale(self : NlppostransformerPath, f : Double) -> NlppostransformerPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerPath::add(self : NlppostransformerPath, other : NlppostransformerPath) -> NlppostransformerPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerPath::copy(self : NlppostransformerPath) -> NlppostransformerPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerPath::fill(self : NlppostransformerPath, v : Double) -> NlppostransformerPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerPath::min(self : NlppostransformerPath) -> Double { @_common.min(self.data) }

pub fn NlppostransformerPath::max(self : NlppostransformerPath) -> Double { @_common.max(self.data) }

pub fn NlppostransformerPath::to_string(self : NlppostransformerPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_cluster_make(size : Int) -> NlppostransformerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerCluster::len(self : NlppostransformerCluster) -> Int { self.size }

pub fn NlppostransformerCluster::get(self : NlppostransformerCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerCluster::set(self : NlppostransformerCluster, i : Int, v : Double) -> NlppostransformerCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerCluster::sum(self : NlppostransformerCluster) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerCluster::mean(self : NlppostransformerCluster) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerCluster::scale(self : NlppostransformerCluster, f : Double) -> NlppostransformerCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerCluster::add(self : NlppostransformerCluster, other : NlppostransformerCluster) -> NlppostransformerCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerCluster::copy(self : NlppostransformerCluster) -> NlppostransformerCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerCluster::fill(self : NlppostransformerCluster, v : Double) -> NlppostransformerCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerCluster::min(self : NlppostransformerCluster) -> Double { @_common.min(self.data) }

pub fn NlppostransformerCluster::max(self : NlppostransformerCluster) -> Double { @_common.max(self.data) }

pub fn NlppostransformerCluster::to_string(self : NlppostransformerCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_model_make(size : Int) -> NlppostransformerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerModel::len(self : NlppostransformerModel) -> Int { self.size }

pub fn NlppostransformerModel::get(self : NlppostransformerModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerModel::set(self : NlppostransformerModel, i : Int, v : Double) -> NlppostransformerModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerModel::sum(self : NlppostransformerModel) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerModel::mean(self : NlppostransformerModel) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerModel::scale(self : NlppostransformerModel, f : Double) -> NlppostransformerModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerModel::add(self : NlppostransformerModel, other : NlppostransformerModel) -> NlppostransformerModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerModel::copy(self : NlppostransformerModel) -> NlppostransformerModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerModel::fill(self : NlppostransformerModel, v : Double) -> NlppostransformerModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerModel::min(self : NlppostransformerModel) -> Double { @_common.min(self.data) }

pub fn NlppostransformerModel::max(self : NlppostransformerModel) -> Double { @_common.max(self.data) }

pub fn NlppostransformerModel::to_string(self : NlppostransformerModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_layer_make(size : Int) -> NlppostransformerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerLayer::len(self : NlppostransformerLayer) -> Int { self.size }

pub fn NlppostransformerLayer::get(self : NlppostransformerLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerLayer::set(self : NlppostransformerLayer, i : Int, v : Double) -> NlppostransformerLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerLayer::sum(self : NlppostransformerLayer) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerLayer::mean(self : NlppostransformerLayer) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerLayer::scale(self : NlppostransformerLayer, f : Double) -> NlppostransformerLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerLayer::add(self : NlppostransformerLayer, other : NlppostransformerLayer) -> NlppostransformerLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerLayer::copy(self : NlppostransformerLayer) -> NlppostransformerLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerLayer::fill(self : NlppostransformerLayer, v : Double) -> NlppostransformerLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerLayer::min(self : NlppostransformerLayer) -> Double { @_common.min(self.data) }

pub fn NlppostransformerLayer::max(self : NlppostransformerLayer) -> Double { @_common.max(self.data) }

pub fn NlppostransformerLayer::to_string(self : NlppostransformerLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_buffer_make(size : Int) -> NlppostransformerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerBuffer::len(self : NlppostransformerBuffer) -> Int { self.size }

pub fn NlppostransformerBuffer::get(self : NlppostransformerBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerBuffer::set(self : NlppostransformerBuffer, i : Int, v : Double) -> NlppostransformerBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerBuffer::sum(self : NlppostransformerBuffer) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerBuffer::mean(self : NlppostransformerBuffer) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerBuffer::scale(self : NlppostransformerBuffer, f : Double) -> NlppostransformerBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerBuffer::add(self : NlppostransformerBuffer, other : NlppostransformerBuffer) -> NlppostransformerBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerBuffer::copy(self : NlppostransformerBuffer) -> NlppostransformerBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerBuffer::fill(self : NlppostransformerBuffer, v : Double) -> NlppostransformerBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerBuffer::min(self : NlppostransformerBuffer) -> Double { @_common.min(self.data) }

pub fn NlppostransformerBuffer::max(self : NlppostransformerBuffer) -> Double { @_common.max(self.data) }

pub fn NlppostransformerBuffer::to_string(self : NlppostransformerBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_cursor_make(size : Int) -> NlppostransformerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerCursor::len(self : NlppostransformerCursor) -> Int { self.size }

pub fn NlppostransformerCursor::get(self : NlppostransformerCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerCursor::set(self : NlppostransformerCursor, i : Int, v : Double) -> NlppostransformerCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerCursor::sum(self : NlppostransformerCursor) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerCursor::mean(self : NlppostransformerCursor) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerCursor::scale(self : NlppostransformerCursor, f : Double) -> NlppostransformerCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerCursor::add(self : NlppostransformerCursor, other : NlppostransformerCursor) -> NlppostransformerCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerCursor::copy(self : NlppostransformerCursor) -> NlppostransformerCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerCursor::fill(self : NlppostransformerCursor, v : Double) -> NlppostransformerCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerCursor::min(self : NlppostransformerCursor) -> Double { @_common.min(self.data) }

pub fn NlppostransformerCursor::max(self : NlppostransformerCursor) -> Double { @_common.max(self.data) }

pub fn NlppostransformerCursor::to_string(self : NlppostransformerCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_view_make(size : Int) -> NlppostransformerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerView::len(self : NlppostransformerView) -> Int { self.size }

pub fn NlppostransformerView::get(self : NlppostransformerView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerView::set(self : NlppostransformerView, i : Int, v : Double) -> NlppostransformerView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerView::sum(self : NlppostransformerView) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerView::mean(self : NlppostransformerView) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerView::scale(self : NlppostransformerView, f : Double) -> NlppostransformerView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerView::add(self : NlppostransformerView, other : NlppostransformerView) -> NlppostransformerView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerView::copy(self : NlppostransformerView) -> NlppostransformerView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerView::fill(self : NlppostransformerView, v : Double) -> NlppostransformerView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerView::min(self : NlppostransformerView) -> Double { @_common.min(self.data) }

pub fn NlppostransformerView::max(self : NlppostransformerView) -> Double { @_common.max(self.data) }

pub fn NlppostransformerView::to_string(self : NlppostransformerView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_range_make(size : Int) -> NlppostransformerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerRange::len(self : NlppostransformerRange) -> Int { self.size }

pub fn NlppostransformerRange::get(self : NlppostransformerRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerRange::set(self : NlppostransformerRange, i : Int, v : Double) -> NlppostransformerRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerRange::sum(self : NlppostransformerRange) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerRange::mean(self : NlppostransformerRange) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerRange::scale(self : NlppostransformerRange, f : Double) -> NlppostransformerRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerRange::add(self : NlppostransformerRange, other : NlppostransformerRange) -> NlppostransformerRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerRange::copy(self : NlppostransformerRange) -> NlppostransformerRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerRange::fill(self : NlppostransformerRange, v : Double) -> NlppostransformerRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerRange::min(self : NlppostransformerRange) -> Double { @_common.min(self.data) }

pub fn NlppostransformerRange::max(self : NlppostransformerRange) -> Double { @_common.max(self.data) }

pub fn NlppostransformerRange::to_string(self : NlppostransformerRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostransformerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_slice_make(size : Int) -> NlppostransformerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostransformerSlice::len(self : NlppostransformerSlice) -> Int { self.size }

pub fn NlppostransformerSlice::get(self : NlppostransformerSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostransformerSlice::set(self : NlppostransformerSlice, i : Int, v : Double) -> NlppostransformerSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostransformerSlice::sum(self : NlppostransformerSlice) -> Double { @_common.sum(self.data) }

pub fn NlppostransformerSlice::mean(self : NlppostransformerSlice) -> Double { @_common.mean(self.data) }

pub fn NlppostransformerSlice::scale(self : NlppostransformerSlice, f : Double) -> NlppostransformerSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostransformerSlice::add(self : NlppostransformerSlice, other : NlppostransformerSlice) -> NlppostransformerSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostransformerSlice::copy(self : NlppostransformerSlice) -> NlppostransformerSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostransformerSlice::fill(self : NlppostransformerSlice, v : Double) -> NlppostransformerSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostransformerSlice::min(self : NlppostransformerSlice) -> Double { @_common.min(self.data) }

pub fn NlppostransformerSlice::max(self : NlppostransformerSlice) -> Double { @_common.max(self.data) }

pub fn NlppostransformerSlice::to_string(self : NlppostransformerSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

