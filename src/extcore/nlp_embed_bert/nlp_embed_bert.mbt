///===
/// extcore/nlp_embed_bert

pub(all) struct NlpembedbertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_bert_make_point(x : Double, y : Double) -> NlpembedbertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_bert_make_point3(x : Double, y : Double, z : Double) -> NlpembedbertPoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedbertPoint::x(self : NlpembedbertPoint) -> Double { self.x }

pub fn NlpembedbertPoint::y(self : NlpembedbertPoint) -> Double { self.y }

pub fn NlpembedbertPoint::z(self : NlpembedbertPoint) -> Double { self.z }

pub fn NlpembedbertPoint::label(self : NlpembedbertPoint) -> Int { self.label }

pub fn NlpembedbertPoint::dist(self : NlpembedbertPoint, other : NlpembedbertPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedbertPoint::add(self : NlpembedbertPoint, other : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedbertPoint::sub(self : NlpembedbertPoint, other : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedbertPoint::scale(self : NlpembedbertPoint, s : Double) -> NlpembedbertPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedbertPoint::dot(self : NlpembedbertPoint, other : NlpembedbertPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedbertPoint::cross(self : NlpembedbertPoint, other : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedbertPoint::norm(self : NlpembedbertPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedbertPoint::normalize(self : NlpembedbertPoint) -> NlpembedbertPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedbertPoint::negate(self : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedbertPoint::mid(self : NlpembedbertPoint, other : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedbertPoint::lerp(self : NlpembedbertPoint, other : NlpembedbertPoint, t : Double) -> NlpembedbertPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedbertPoint::to_string(self : NlpembedbertPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedbertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_bert_make_series(vals : Array[Double], name : String) -> NlpembedbertSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedbertSeries::len(self : NlpembedbertSeries) -> Int { self.vals.length() }

pub fn NlpembedbertSeries::sum(self : NlpembedbertSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedbertSeries::mean(self : NlpembedbertSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedbertSeries::min(self : NlpembedbertSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedbertSeries::max(self : NlpembedbertSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedbertSeries::range(self : NlpembedbertSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedbertSeries::variance(self : NlpembedbertSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedbertSeries::std(self : NlpembedbertSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedbertSeries::median(self : NlpembedbertSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedbertSeries::scale(self : NlpembedbertSeries, f : Double) -> NlpembedbertSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedbertSeries::add(self : NlpembedbertSeries, other : NlpembedbertSeries) -> NlpembedbertSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedbertSeries::sub(self : NlpembedbertSeries, other : NlpembedbertSeries) -> NlpembedbertSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedbertSeries::normalize(self : NlpembedbertSeries) -> NlpembedbertSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedbertSeries::cumsum(self : NlpembedbertSeries) -> NlpembedbertSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedbertSeries::to_string(self : NlpembedbertSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedbertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_bert_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedbertMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_embed_bert_matrix_identity(n : Int) -> NlpembedbertMatrix {
  let m = nlp_embed_bert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedbertMatrix::get(self : NlpembedbertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedbertMatrix::transpose(self : NlpembedbertMatrix) -> NlpembedbertMatrix {
  let result = nlp_embed_bert_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedbertMatrix::add(self : NlpembedbertMatrix, other : NlpembedbertMatrix) -> NlpembedbertMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_bert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedbertMatrix::scale(self : NlpembedbertMatrix, s : Double) -> NlpembedbertMatrix {
  let result = nlp_embed_bert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedbertMatrix::multiply(self : NlpembedbertMatrix, other : NlpembedbertMatrix) -> NlpembedbertMatrix {
  if self.cols != other.rows { return nlp_embed_bert_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_bert_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlpembedbertMatrix::trace(self : NlpembedbertMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedbertMatrix::det(self : NlpembedbertMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedbertMatrix::norm(self : NlpembedbertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedbertMatrix::to_string(self : NlpembedbertMatrix) -> String {
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

pub(all) struct NlpembedbertVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_bert_make_vector(comps : Array[Double]) -> NlpembedbertVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_bert_vector_zero(dim : Int) -> NlpembedbertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedbertVector::add(self : NlpembedbertVector, other : NlpembedbertVector) -> NlpembedbertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedbertVector::sub(self : NlpembedbertVector, other : NlpembedbertVector) -> NlpembedbertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedbertVector::scale(self : NlpembedbertVector, s : Double) -> NlpembedbertVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedbertVector::dot(self : NlpembedbertVector, other : NlpembedbertVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedbertVector::norm(self : NlpembedbertVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedbertVector::normalize(self : NlpembedbertVector) -> NlpembedbertVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedbertVector::dist(self : NlpembedbertVector, other : NlpembedbertVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedbertVector::to_string(self : NlpembedbertVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedbertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_frame_make(size : Int) -> NlpembedbertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertFrame::len(self : NlpembedbertFrame) -> Int { self.size }

pub fn NlpembedbertFrame::get(self : NlpembedbertFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertFrame::set(self : NlpembedbertFrame, i : Int, v : Double) -> NlpembedbertFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertFrame::sum(self : NlpembedbertFrame) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertFrame::mean(self : NlpembedbertFrame) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertFrame::scale(self : NlpembedbertFrame, f : Double) -> NlpembedbertFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertFrame::add(self : NlpembedbertFrame, other : NlpembedbertFrame) -> NlpembedbertFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertFrame::copy(self : NlpembedbertFrame) -> NlpembedbertFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertFrame::fill(self : NlpembedbertFrame, v : Double) -> NlpembedbertFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertFrame::min(self : NlpembedbertFrame) -> Double { @_common.min(self.data) }

pub fn NlpembedbertFrame::max(self : NlpembedbertFrame) -> Double { @_common.max(self.data) }

pub fn NlpembedbertFrame::to_string(self : NlpembedbertFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_table_make(size : Int) -> NlpembedbertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertTable::len(self : NlpembedbertTable) -> Int { self.size }

pub fn NlpembedbertTable::get(self : NlpembedbertTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertTable::set(self : NlpembedbertTable, i : Int, v : Double) -> NlpembedbertTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertTable::sum(self : NlpembedbertTable) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertTable::mean(self : NlpembedbertTable) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertTable::scale(self : NlpembedbertTable, f : Double) -> NlpembedbertTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertTable::add(self : NlpembedbertTable, other : NlpembedbertTable) -> NlpembedbertTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertTable::copy(self : NlpembedbertTable) -> NlpembedbertTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertTable::fill(self : NlpembedbertTable, v : Double) -> NlpembedbertTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertTable::min(self : NlpembedbertTable) -> Double { @_common.min(self.data) }

pub fn NlpembedbertTable::max(self : NlpembedbertTable) -> Double { @_common.max(self.data) }

pub fn NlpembedbertTable::to_string(self : NlpembedbertTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_graphn_make(size : Int) -> NlpembedbertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertGraphN::len(self : NlpembedbertGraphN) -> Int { self.size }

pub fn NlpembedbertGraphN::get(self : NlpembedbertGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertGraphN::set(self : NlpembedbertGraphN, i : Int, v : Double) -> NlpembedbertGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertGraphN::sum(self : NlpembedbertGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertGraphN::mean(self : NlpembedbertGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertGraphN::scale(self : NlpembedbertGraphN, f : Double) -> NlpembedbertGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertGraphN::add(self : NlpembedbertGraphN, other : NlpembedbertGraphN) -> NlpembedbertGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertGraphN::copy(self : NlpembedbertGraphN) -> NlpembedbertGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertGraphN::fill(self : NlpembedbertGraphN, v : Double) -> NlpembedbertGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertGraphN::min(self : NlpembedbertGraphN) -> Double { @_common.min(self.data) }

pub fn NlpembedbertGraphN::max(self : NlpembedbertGraphN) -> Double { @_common.max(self.data) }

pub fn NlpembedbertGraphN::to_string(self : NlpembedbertGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_node_make(size : Int) -> NlpembedbertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertNode::len(self : NlpembedbertNode) -> Int { self.size }

pub fn NlpembedbertNode::get(self : NlpembedbertNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertNode::set(self : NlpembedbertNode, i : Int, v : Double) -> NlpembedbertNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertNode::sum(self : NlpembedbertNode) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertNode::mean(self : NlpembedbertNode) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertNode::scale(self : NlpembedbertNode, f : Double) -> NlpembedbertNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertNode::add(self : NlpembedbertNode, other : NlpembedbertNode) -> NlpembedbertNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertNode::copy(self : NlpembedbertNode) -> NlpembedbertNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertNode::fill(self : NlpembedbertNode, v : Double) -> NlpembedbertNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertNode::min(self : NlpembedbertNode) -> Double { @_common.min(self.data) }

pub fn NlpembedbertNode::max(self : NlpembedbertNode) -> Double { @_common.max(self.data) }

pub fn NlpembedbertNode::to_string(self : NlpembedbertNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_edge_make(size : Int) -> NlpembedbertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertEdge::len(self : NlpembedbertEdge) -> Int { self.size }

pub fn NlpembedbertEdge::get(self : NlpembedbertEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertEdge::set(self : NlpembedbertEdge, i : Int, v : Double) -> NlpembedbertEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertEdge::sum(self : NlpembedbertEdge) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertEdge::mean(self : NlpembedbertEdge) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertEdge::scale(self : NlpembedbertEdge, f : Double) -> NlpembedbertEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertEdge::add(self : NlpembedbertEdge, other : NlpembedbertEdge) -> NlpembedbertEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertEdge::copy(self : NlpembedbertEdge) -> NlpembedbertEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertEdge::fill(self : NlpembedbertEdge, v : Double) -> NlpembedbertEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertEdge::min(self : NlpembedbertEdge) -> Double { @_common.min(self.data) }

pub fn NlpembedbertEdge::max(self : NlpembedbertEdge) -> Double { @_common.max(self.data) }

pub fn NlpembedbertEdge::to_string(self : NlpembedbertEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_path_make(size : Int) -> NlpembedbertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertPath::len(self : NlpembedbertPath) -> Int { self.size }

pub fn NlpembedbertPath::get(self : NlpembedbertPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertPath::set(self : NlpembedbertPath, i : Int, v : Double) -> NlpembedbertPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertPath::sum(self : NlpembedbertPath) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertPath::mean(self : NlpembedbertPath) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertPath::scale(self : NlpembedbertPath, f : Double) -> NlpembedbertPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertPath::add(self : NlpembedbertPath, other : NlpembedbertPath) -> NlpembedbertPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertPath::copy(self : NlpembedbertPath) -> NlpembedbertPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertPath::fill(self : NlpembedbertPath, v : Double) -> NlpembedbertPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertPath::min(self : NlpembedbertPath) -> Double { @_common.min(self.data) }

pub fn NlpembedbertPath::max(self : NlpembedbertPath) -> Double { @_common.max(self.data) }

pub fn NlpembedbertPath::to_string(self : NlpembedbertPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_cluster_make(size : Int) -> NlpembedbertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertCluster::len(self : NlpembedbertCluster) -> Int { self.size }

pub fn NlpembedbertCluster::get(self : NlpembedbertCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertCluster::set(self : NlpembedbertCluster, i : Int, v : Double) -> NlpembedbertCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertCluster::sum(self : NlpembedbertCluster) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertCluster::mean(self : NlpembedbertCluster) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertCluster::scale(self : NlpembedbertCluster, f : Double) -> NlpembedbertCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertCluster::add(self : NlpembedbertCluster, other : NlpembedbertCluster) -> NlpembedbertCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertCluster::copy(self : NlpembedbertCluster) -> NlpembedbertCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertCluster::fill(self : NlpembedbertCluster, v : Double) -> NlpembedbertCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertCluster::min(self : NlpembedbertCluster) -> Double { @_common.min(self.data) }

pub fn NlpembedbertCluster::max(self : NlpembedbertCluster) -> Double { @_common.max(self.data) }

pub fn NlpembedbertCluster::to_string(self : NlpembedbertCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_model_make(size : Int) -> NlpembedbertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertModel::len(self : NlpembedbertModel) -> Int { self.size }

pub fn NlpembedbertModel::get(self : NlpembedbertModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertModel::set(self : NlpembedbertModel, i : Int, v : Double) -> NlpembedbertModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertModel::sum(self : NlpembedbertModel) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertModel::mean(self : NlpembedbertModel) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertModel::scale(self : NlpembedbertModel, f : Double) -> NlpembedbertModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertModel::add(self : NlpembedbertModel, other : NlpembedbertModel) -> NlpembedbertModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertModel::copy(self : NlpembedbertModel) -> NlpembedbertModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertModel::fill(self : NlpembedbertModel, v : Double) -> NlpembedbertModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertModel::min(self : NlpembedbertModel) -> Double { @_common.min(self.data) }

pub fn NlpembedbertModel::max(self : NlpembedbertModel) -> Double { @_common.max(self.data) }

pub fn NlpembedbertModel::to_string(self : NlpembedbertModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_layer_make(size : Int) -> NlpembedbertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertLayer::len(self : NlpembedbertLayer) -> Int { self.size }

pub fn NlpembedbertLayer::get(self : NlpembedbertLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertLayer::set(self : NlpembedbertLayer, i : Int, v : Double) -> NlpembedbertLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertLayer::sum(self : NlpembedbertLayer) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertLayer::mean(self : NlpembedbertLayer) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertLayer::scale(self : NlpembedbertLayer, f : Double) -> NlpembedbertLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertLayer::add(self : NlpembedbertLayer, other : NlpembedbertLayer) -> NlpembedbertLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertLayer::copy(self : NlpembedbertLayer) -> NlpembedbertLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertLayer::fill(self : NlpembedbertLayer, v : Double) -> NlpembedbertLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertLayer::min(self : NlpembedbertLayer) -> Double { @_common.min(self.data) }

pub fn NlpembedbertLayer::max(self : NlpembedbertLayer) -> Double { @_common.max(self.data) }

pub fn NlpembedbertLayer::to_string(self : NlpembedbertLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_buffer_make(size : Int) -> NlpembedbertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertBuffer::len(self : NlpembedbertBuffer) -> Int { self.size }

pub fn NlpembedbertBuffer::get(self : NlpembedbertBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertBuffer::set(self : NlpembedbertBuffer, i : Int, v : Double) -> NlpembedbertBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertBuffer::sum(self : NlpembedbertBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertBuffer::mean(self : NlpembedbertBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertBuffer::scale(self : NlpembedbertBuffer, f : Double) -> NlpembedbertBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertBuffer::add(self : NlpembedbertBuffer, other : NlpembedbertBuffer) -> NlpembedbertBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertBuffer::copy(self : NlpembedbertBuffer) -> NlpembedbertBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertBuffer::fill(self : NlpembedbertBuffer, v : Double) -> NlpembedbertBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertBuffer::min(self : NlpembedbertBuffer) -> Double { @_common.min(self.data) }

pub fn NlpembedbertBuffer::max(self : NlpembedbertBuffer) -> Double { @_common.max(self.data) }

pub fn NlpembedbertBuffer::to_string(self : NlpembedbertBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_cursor_make(size : Int) -> NlpembedbertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertCursor::len(self : NlpembedbertCursor) -> Int { self.size }

pub fn NlpembedbertCursor::get(self : NlpembedbertCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertCursor::set(self : NlpembedbertCursor, i : Int, v : Double) -> NlpembedbertCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertCursor::sum(self : NlpembedbertCursor) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertCursor::mean(self : NlpembedbertCursor) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertCursor::scale(self : NlpembedbertCursor, f : Double) -> NlpembedbertCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertCursor::add(self : NlpembedbertCursor, other : NlpembedbertCursor) -> NlpembedbertCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertCursor::copy(self : NlpembedbertCursor) -> NlpembedbertCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertCursor::fill(self : NlpembedbertCursor, v : Double) -> NlpembedbertCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertCursor::min(self : NlpembedbertCursor) -> Double { @_common.min(self.data) }

pub fn NlpembedbertCursor::max(self : NlpembedbertCursor) -> Double { @_common.max(self.data) }

pub fn NlpembedbertCursor::to_string(self : NlpembedbertCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_view_make(size : Int) -> NlpembedbertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertView::len(self : NlpembedbertView) -> Int { self.size }

pub fn NlpembedbertView::get(self : NlpembedbertView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertView::set(self : NlpembedbertView, i : Int, v : Double) -> NlpembedbertView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertView::sum(self : NlpembedbertView) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertView::mean(self : NlpembedbertView) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertView::scale(self : NlpembedbertView, f : Double) -> NlpembedbertView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertView::add(self : NlpembedbertView, other : NlpembedbertView) -> NlpembedbertView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertView::copy(self : NlpembedbertView) -> NlpembedbertView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertView::fill(self : NlpembedbertView, v : Double) -> NlpembedbertView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertView::min(self : NlpembedbertView) -> Double { @_common.min(self.data) }

pub fn NlpembedbertView::max(self : NlpembedbertView) -> Double { @_common.max(self.data) }

pub fn NlpembedbertView::to_string(self : NlpembedbertView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_range_make(size : Int) -> NlpembedbertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertRange::len(self : NlpembedbertRange) -> Int { self.size }

pub fn NlpembedbertRange::get(self : NlpembedbertRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertRange::set(self : NlpembedbertRange, i : Int, v : Double) -> NlpembedbertRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertRange::sum(self : NlpembedbertRange) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertRange::mean(self : NlpembedbertRange) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertRange::scale(self : NlpembedbertRange, f : Double) -> NlpembedbertRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertRange::add(self : NlpembedbertRange, other : NlpembedbertRange) -> NlpembedbertRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertRange::copy(self : NlpembedbertRange) -> NlpembedbertRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertRange::fill(self : NlpembedbertRange, v : Double) -> NlpembedbertRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertRange::min(self : NlpembedbertRange) -> Double { @_common.min(self.data) }

pub fn NlpembedbertRange::max(self : NlpembedbertRange) -> Double { @_common.max(self.data) }

pub fn NlpembedbertRange::to_string(self : NlpembedbertRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedbertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_slice_make(size : Int) -> NlpembedbertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedbertSlice::len(self : NlpembedbertSlice) -> Int { self.size }

pub fn NlpembedbertSlice::get(self : NlpembedbertSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedbertSlice::set(self : NlpembedbertSlice, i : Int, v : Double) -> NlpembedbertSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedbertSlice::sum(self : NlpembedbertSlice) -> Double { @_common.sum(self.data) }

pub fn NlpembedbertSlice::mean(self : NlpembedbertSlice) -> Double { @_common.mean(self.data) }

pub fn NlpembedbertSlice::scale(self : NlpembedbertSlice, f : Double) -> NlpembedbertSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedbertSlice::add(self : NlpembedbertSlice, other : NlpembedbertSlice) -> NlpembedbertSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedbertSlice::copy(self : NlpembedbertSlice) -> NlpembedbertSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedbertSlice::fill(self : NlpembedbertSlice, v : Double) -> NlpembedbertSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedbertSlice::min(self : NlpembedbertSlice) -> Double { @_common.min(self.data) }

pub fn NlpembedbertSlice::max(self : NlpembedbertSlice) -> Double { @_common.max(self.data) }

pub fn NlpembedbertSlice::to_string(self : NlpembedbertSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

