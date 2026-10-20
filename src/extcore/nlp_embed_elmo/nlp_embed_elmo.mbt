///===
/// extcore/nlp_embed_elmo

pub(all) struct NlpembedelmoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_elmo_make_point(x : Double, y : Double) -> NlpembedelmoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_elmo_make_point3(x : Double, y : Double, z : Double) -> NlpembedelmoPoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedelmoPoint::x(self : NlpembedelmoPoint) -> Double { self.x }

pub fn NlpembedelmoPoint::y(self : NlpembedelmoPoint) -> Double { self.y }

pub fn NlpembedelmoPoint::z(self : NlpembedelmoPoint) -> Double { self.z }

pub fn NlpembedelmoPoint::label(self : NlpembedelmoPoint) -> Int { self.label }

pub fn NlpembedelmoPoint::dist(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedelmoPoint::add(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedelmoPoint::sub(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedelmoPoint::scale(self : NlpembedelmoPoint, s : Double) -> NlpembedelmoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedelmoPoint::dot(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedelmoPoint::cross(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedelmoPoint::norm(self : NlpembedelmoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedelmoPoint::normalize(self : NlpembedelmoPoint) -> NlpembedelmoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedelmoPoint::negate(self : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedelmoPoint::mid(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedelmoPoint::lerp(self : NlpembedelmoPoint, other : NlpembedelmoPoint, t : Double) -> NlpembedelmoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedelmoPoint::to_string(self : NlpembedelmoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedelmoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_elmo_make_series(vals : Array[Double], name : String) -> NlpembedelmoSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedelmoSeries::len(self : NlpembedelmoSeries) -> Int { self.vals.length() }

pub fn NlpembedelmoSeries::sum(self : NlpembedelmoSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedelmoSeries::mean(self : NlpembedelmoSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedelmoSeries::min(self : NlpembedelmoSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedelmoSeries::max(self : NlpembedelmoSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedelmoSeries::range(self : NlpembedelmoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedelmoSeries::variance(self : NlpembedelmoSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedelmoSeries::std(self : NlpembedelmoSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedelmoSeries::median(self : NlpembedelmoSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedelmoSeries::scale(self : NlpembedelmoSeries, f : Double) -> NlpembedelmoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedelmoSeries::add(self : NlpembedelmoSeries, other : NlpembedelmoSeries) -> NlpembedelmoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedelmoSeries::sub(self : NlpembedelmoSeries, other : NlpembedelmoSeries) -> NlpembedelmoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedelmoSeries::normalize(self : NlpembedelmoSeries) -> NlpembedelmoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedelmoSeries::cumsum(self : NlpembedelmoSeries) -> NlpembedelmoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedelmoSeries::to_string(self : NlpembedelmoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedelmoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_elmo_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedelmoMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_embed_elmo_matrix_identity(n : Int) -> NlpembedelmoMatrix {
  let m = nlp_embed_elmo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedelmoMatrix::get(self : NlpembedelmoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedelmoMatrix::transpose(self : NlpembedelmoMatrix) -> NlpembedelmoMatrix {
  let result = nlp_embed_elmo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedelmoMatrix::add(self : NlpembedelmoMatrix, other : NlpembedelmoMatrix) -> NlpembedelmoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_elmo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedelmoMatrix::scale(self : NlpembedelmoMatrix, s : Double) -> NlpembedelmoMatrix {
  let result = nlp_embed_elmo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedelmoMatrix::multiply(self : NlpembedelmoMatrix, other : NlpembedelmoMatrix) -> NlpembedelmoMatrix {
  if self.cols != other.rows { return nlp_embed_elmo_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_elmo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlpembedelmoMatrix::trace(self : NlpembedelmoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedelmoMatrix::det(self : NlpembedelmoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedelmoMatrix::norm(self : NlpembedelmoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedelmoMatrix::to_string(self : NlpembedelmoMatrix) -> String {
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

pub(all) struct NlpembedelmoVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_elmo_make_vector(comps : Array[Double]) -> NlpembedelmoVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_elmo_vector_zero(dim : Int) -> NlpembedelmoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedelmoVector::add(self : NlpembedelmoVector, other : NlpembedelmoVector) -> NlpembedelmoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedelmoVector::sub(self : NlpembedelmoVector, other : NlpembedelmoVector) -> NlpembedelmoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedelmoVector::scale(self : NlpembedelmoVector, s : Double) -> NlpembedelmoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedelmoVector::dot(self : NlpembedelmoVector, other : NlpembedelmoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedelmoVector::norm(self : NlpembedelmoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedelmoVector::normalize(self : NlpembedelmoVector) -> NlpembedelmoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedelmoVector::dist(self : NlpembedelmoVector, other : NlpembedelmoVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedelmoVector::to_string(self : NlpembedelmoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedelmoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_frame_make(size : Int) -> NlpembedelmoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoFrame::len(self : NlpembedelmoFrame) -> Int { self.size }

pub fn NlpembedelmoFrame::get(self : NlpembedelmoFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoFrame::set(self : NlpembedelmoFrame, i : Int, v : Double) -> NlpembedelmoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoFrame::sum(self : NlpembedelmoFrame) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoFrame::mean(self : NlpembedelmoFrame) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoFrame::scale(self : NlpembedelmoFrame, f : Double) -> NlpembedelmoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoFrame::add(self : NlpembedelmoFrame, other : NlpembedelmoFrame) -> NlpembedelmoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoFrame::copy(self : NlpembedelmoFrame) -> NlpembedelmoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoFrame::fill(self : NlpembedelmoFrame, v : Double) -> NlpembedelmoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoFrame::min(self : NlpembedelmoFrame) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoFrame::max(self : NlpembedelmoFrame) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoFrame::to_string(self : NlpembedelmoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_table_make(size : Int) -> NlpembedelmoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoTable::len(self : NlpembedelmoTable) -> Int { self.size }

pub fn NlpembedelmoTable::get(self : NlpembedelmoTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoTable::set(self : NlpembedelmoTable, i : Int, v : Double) -> NlpembedelmoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoTable::sum(self : NlpembedelmoTable) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoTable::mean(self : NlpembedelmoTable) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoTable::scale(self : NlpembedelmoTable, f : Double) -> NlpembedelmoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoTable::add(self : NlpembedelmoTable, other : NlpembedelmoTable) -> NlpembedelmoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoTable::copy(self : NlpembedelmoTable) -> NlpembedelmoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoTable::fill(self : NlpembedelmoTable, v : Double) -> NlpembedelmoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoTable::min(self : NlpembedelmoTable) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoTable::max(self : NlpembedelmoTable) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoTable::to_string(self : NlpembedelmoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_graphn_make(size : Int) -> NlpembedelmoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoGraphN::len(self : NlpembedelmoGraphN) -> Int { self.size }

pub fn NlpembedelmoGraphN::get(self : NlpembedelmoGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoGraphN::set(self : NlpembedelmoGraphN, i : Int, v : Double) -> NlpembedelmoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoGraphN::sum(self : NlpembedelmoGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoGraphN::mean(self : NlpembedelmoGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoGraphN::scale(self : NlpembedelmoGraphN, f : Double) -> NlpembedelmoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoGraphN::add(self : NlpembedelmoGraphN, other : NlpembedelmoGraphN) -> NlpembedelmoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoGraphN::copy(self : NlpembedelmoGraphN) -> NlpembedelmoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoGraphN::fill(self : NlpembedelmoGraphN, v : Double) -> NlpembedelmoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoGraphN::min(self : NlpembedelmoGraphN) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoGraphN::max(self : NlpembedelmoGraphN) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoGraphN::to_string(self : NlpembedelmoGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_node_make(size : Int) -> NlpembedelmoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoNode::len(self : NlpembedelmoNode) -> Int { self.size }

pub fn NlpembedelmoNode::get(self : NlpembedelmoNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoNode::set(self : NlpembedelmoNode, i : Int, v : Double) -> NlpembedelmoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoNode::sum(self : NlpembedelmoNode) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoNode::mean(self : NlpembedelmoNode) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoNode::scale(self : NlpembedelmoNode, f : Double) -> NlpembedelmoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoNode::add(self : NlpembedelmoNode, other : NlpembedelmoNode) -> NlpembedelmoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoNode::copy(self : NlpembedelmoNode) -> NlpembedelmoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoNode::fill(self : NlpembedelmoNode, v : Double) -> NlpembedelmoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoNode::min(self : NlpembedelmoNode) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoNode::max(self : NlpembedelmoNode) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoNode::to_string(self : NlpembedelmoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_edge_make(size : Int) -> NlpembedelmoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoEdge::len(self : NlpembedelmoEdge) -> Int { self.size }

pub fn NlpembedelmoEdge::get(self : NlpembedelmoEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoEdge::set(self : NlpembedelmoEdge, i : Int, v : Double) -> NlpembedelmoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoEdge::sum(self : NlpembedelmoEdge) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoEdge::mean(self : NlpembedelmoEdge) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoEdge::scale(self : NlpembedelmoEdge, f : Double) -> NlpembedelmoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoEdge::add(self : NlpembedelmoEdge, other : NlpembedelmoEdge) -> NlpembedelmoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoEdge::copy(self : NlpembedelmoEdge) -> NlpembedelmoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoEdge::fill(self : NlpembedelmoEdge, v : Double) -> NlpembedelmoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoEdge::min(self : NlpembedelmoEdge) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoEdge::max(self : NlpembedelmoEdge) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoEdge::to_string(self : NlpembedelmoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_path_make(size : Int) -> NlpembedelmoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoPath::len(self : NlpembedelmoPath) -> Int { self.size }

pub fn NlpembedelmoPath::get(self : NlpembedelmoPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoPath::set(self : NlpembedelmoPath, i : Int, v : Double) -> NlpembedelmoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoPath::sum(self : NlpembedelmoPath) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoPath::mean(self : NlpembedelmoPath) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoPath::scale(self : NlpembedelmoPath, f : Double) -> NlpembedelmoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoPath::add(self : NlpembedelmoPath, other : NlpembedelmoPath) -> NlpembedelmoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoPath::copy(self : NlpembedelmoPath) -> NlpembedelmoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoPath::fill(self : NlpembedelmoPath, v : Double) -> NlpembedelmoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoPath::min(self : NlpembedelmoPath) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoPath::max(self : NlpembedelmoPath) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoPath::to_string(self : NlpembedelmoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_cluster_make(size : Int) -> NlpembedelmoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoCluster::len(self : NlpembedelmoCluster) -> Int { self.size }

pub fn NlpembedelmoCluster::get(self : NlpembedelmoCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoCluster::set(self : NlpembedelmoCluster, i : Int, v : Double) -> NlpembedelmoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoCluster::sum(self : NlpembedelmoCluster) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoCluster::mean(self : NlpembedelmoCluster) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoCluster::scale(self : NlpembedelmoCluster, f : Double) -> NlpembedelmoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoCluster::add(self : NlpembedelmoCluster, other : NlpembedelmoCluster) -> NlpembedelmoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoCluster::copy(self : NlpembedelmoCluster) -> NlpembedelmoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoCluster::fill(self : NlpembedelmoCluster, v : Double) -> NlpembedelmoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoCluster::min(self : NlpembedelmoCluster) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoCluster::max(self : NlpembedelmoCluster) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoCluster::to_string(self : NlpembedelmoCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_model_make(size : Int) -> NlpembedelmoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoModel::len(self : NlpembedelmoModel) -> Int { self.size }

pub fn NlpembedelmoModel::get(self : NlpembedelmoModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoModel::set(self : NlpembedelmoModel, i : Int, v : Double) -> NlpembedelmoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoModel::sum(self : NlpembedelmoModel) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoModel::mean(self : NlpembedelmoModel) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoModel::scale(self : NlpembedelmoModel, f : Double) -> NlpembedelmoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoModel::add(self : NlpembedelmoModel, other : NlpembedelmoModel) -> NlpembedelmoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoModel::copy(self : NlpembedelmoModel) -> NlpembedelmoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoModel::fill(self : NlpembedelmoModel, v : Double) -> NlpembedelmoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoModel::min(self : NlpembedelmoModel) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoModel::max(self : NlpembedelmoModel) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoModel::to_string(self : NlpembedelmoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_layer_make(size : Int) -> NlpembedelmoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoLayer::len(self : NlpembedelmoLayer) -> Int { self.size }

pub fn NlpembedelmoLayer::get(self : NlpembedelmoLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoLayer::set(self : NlpembedelmoLayer, i : Int, v : Double) -> NlpembedelmoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoLayer::sum(self : NlpembedelmoLayer) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoLayer::mean(self : NlpembedelmoLayer) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoLayer::scale(self : NlpembedelmoLayer, f : Double) -> NlpembedelmoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoLayer::add(self : NlpembedelmoLayer, other : NlpembedelmoLayer) -> NlpembedelmoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoLayer::copy(self : NlpembedelmoLayer) -> NlpembedelmoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoLayer::fill(self : NlpembedelmoLayer, v : Double) -> NlpembedelmoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoLayer::min(self : NlpembedelmoLayer) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoLayer::max(self : NlpembedelmoLayer) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoLayer::to_string(self : NlpembedelmoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_buffer_make(size : Int) -> NlpembedelmoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoBuffer::len(self : NlpembedelmoBuffer) -> Int { self.size }

pub fn NlpembedelmoBuffer::get(self : NlpembedelmoBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoBuffer::set(self : NlpembedelmoBuffer, i : Int, v : Double) -> NlpembedelmoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoBuffer::sum(self : NlpembedelmoBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoBuffer::mean(self : NlpembedelmoBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoBuffer::scale(self : NlpembedelmoBuffer, f : Double) -> NlpembedelmoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoBuffer::add(self : NlpembedelmoBuffer, other : NlpembedelmoBuffer) -> NlpembedelmoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoBuffer::copy(self : NlpembedelmoBuffer) -> NlpembedelmoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoBuffer::fill(self : NlpembedelmoBuffer, v : Double) -> NlpembedelmoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoBuffer::min(self : NlpembedelmoBuffer) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoBuffer::max(self : NlpembedelmoBuffer) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoBuffer::to_string(self : NlpembedelmoBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_cursor_make(size : Int) -> NlpembedelmoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoCursor::len(self : NlpembedelmoCursor) -> Int { self.size }

pub fn NlpembedelmoCursor::get(self : NlpembedelmoCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoCursor::set(self : NlpembedelmoCursor, i : Int, v : Double) -> NlpembedelmoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoCursor::sum(self : NlpembedelmoCursor) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoCursor::mean(self : NlpembedelmoCursor) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoCursor::scale(self : NlpembedelmoCursor, f : Double) -> NlpembedelmoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoCursor::add(self : NlpembedelmoCursor, other : NlpembedelmoCursor) -> NlpembedelmoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoCursor::copy(self : NlpembedelmoCursor) -> NlpembedelmoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoCursor::fill(self : NlpembedelmoCursor, v : Double) -> NlpembedelmoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoCursor::min(self : NlpembedelmoCursor) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoCursor::max(self : NlpembedelmoCursor) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoCursor::to_string(self : NlpembedelmoCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_view_make(size : Int) -> NlpembedelmoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoView::len(self : NlpembedelmoView) -> Int { self.size }

pub fn NlpembedelmoView::get(self : NlpembedelmoView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoView::set(self : NlpembedelmoView, i : Int, v : Double) -> NlpembedelmoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoView::sum(self : NlpembedelmoView) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoView::mean(self : NlpembedelmoView) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoView::scale(self : NlpembedelmoView, f : Double) -> NlpembedelmoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoView::add(self : NlpembedelmoView, other : NlpembedelmoView) -> NlpembedelmoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoView::copy(self : NlpembedelmoView) -> NlpembedelmoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoView::fill(self : NlpembedelmoView, v : Double) -> NlpembedelmoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoView::min(self : NlpembedelmoView) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoView::max(self : NlpembedelmoView) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoView::to_string(self : NlpembedelmoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_range_make(size : Int) -> NlpembedelmoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoRange::len(self : NlpembedelmoRange) -> Int { self.size }

pub fn NlpembedelmoRange::get(self : NlpembedelmoRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoRange::set(self : NlpembedelmoRange, i : Int, v : Double) -> NlpembedelmoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoRange::sum(self : NlpembedelmoRange) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoRange::mean(self : NlpembedelmoRange) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoRange::scale(self : NlpembedelmoRange, f : Double) -> NlpembedelmoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoRange::add(self : NlpembedelmoRange, other : NlpembedelmoRange) -> NlpembedelmoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoRange::copy(self : NlpembedelmoRange) -> NlpembedelmoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoRange::fill(self : NlpembedelmoRange, v : Double) -> NlpembedelmoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoRange::min(self : NlpembedelmoRange) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoRange::max(self : NlpembedelmoRange) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoRange::to_string(self : NlpembedelmoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_slice_make(size : Int) -> NlpembedelmoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedelmoSlice::len(self : NlpembedelmoSlice) -> Int { self.size }

pub fn NlpembedelmoSlice::get(self : NlpembedelmoSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedelmoSlice::set(self : NlpembedelmoSlice, i : Int, v : Double) -> NlpembedelmoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedelmoSlice::sum(self : NlpembedelmoSlice) -> Double { @_common.sum(self.data) }

pub fn NlpembedelmoSlice::mean(self : NlpembedelmoSlice) -> Double { @_common.mean(self.data) }

pub fn NlpembedelmoSlice::scale(self : NlpembedelmoSlice, f : Double) -> NlpembedelmoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoSlice::add(self : NlpembedelmoSlice, other : NlpembedelmoSlice) -> NlpembedelmoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedelmoSlice::copy(self : NlpembedelmoSlice) -> NlpembedelmoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoSlice::fill(self : NlpembedelmoSlice, v : Double) -> NlpembedelmoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedelmoSlice::min(self : NlpembedelmoSlice) -> Double { @_common.min(self.data) }

pub fn NlpembedelmoSlice::max(self : NlpembedelmoSlice) -> Double { @_common.max(self.data) }

pub fn NlpembedelmoSlice::to_string(self : NlpembedelmoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

