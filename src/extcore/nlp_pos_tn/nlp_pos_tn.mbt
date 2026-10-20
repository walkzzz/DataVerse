///===
/// extcore/nlp_pos_tn

pub(all) struct NlppostnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_tn_make_point(x : Double, y : Double) -> NlppostnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_tn_make_point3(x : Double, y : Double, z : Double) -> NlppostnPoint {
  { x, y, z, label: 0 }
}

pub fn NlppostnPoint::x(self : NlppostnPoint) -> Double { self.x }

pub fn NlppostnPoint::y(self : NlppostnPoint) -> Double { self.y }

pub fn NlppostnPoint::z(self : NlppostnPoint) -> Double { self.z }

pub fn NlppostnPoint::label(self : NlppostnPoint) -> Int { self.label }

pub fn NlppostnPoint::dist(self : NlppostnPoint, other : NlppostnPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlppostnPoint::add(self : NlppostnPoint, other : NlppostnPoint) -> NlppostnPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlppostnPoint::sub(self : NlppostnPoint, other : NlppostnPoint) -> NlppostnPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlppostnPoint::scale(self : NlppostnPoint, s : Double) -> NlppostnPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlppostnPoint::dot(self : NlppostnPoint, other : NlppostnPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlppostnPoint::cross(self : NlppostnPoint, other : NlppostnPoint) -> NlppostnPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlppostnPoint::norm(self : NlppostnPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlppostnPoint::normalize(self : NlppostnPoint) -> NlppostnPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppostnPoint::negate(self : NlppostnPoint) -> NlppostnPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlppostnPoint::mid(self : NlppostnPoint, other : NlppostnPoint) -> NlppostnPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlppostnPoint::lerp(self : NlppostnPoint, other : NlppostnPoint, t : Double) -> NlppostnPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlppostnPoint::to_string(self : NlppostnPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlppostnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_tn_make_series(vals : Array[Double], name : String) -> NlppostnSeries {
  { vals, name, meta: 0 }
}

pub fn NlppostnSeries::len(self : NlppostnSeries) -> Int { self.vals.length() }

pub fn NlppostnSeries::sum(self : NlppostnSeries) -> Double { @_common.sum(self.vals) }

pub fn NlppostnSeries::mean(self : NlppostnSeries) -> Double { @_common.mean(self.vals) }

pub fn NlppostnSeries::min(self : NlppostnSeries) -> Double { @_common.min(self.vals) }

pub fn NlppostnSeries::max(self : NlppostnSeries) -> Double { @_common.max(self.vals) }

pub fn NlppostnSeries::range(self : NlppostnSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlppostnSeries::variance(self : NlppostnSeries) -> Double { @_common.variance(self.vals) }

pub fn NlppostnSeries::std(self : NlppostnSeries) -> Double { @_common.std(self.vals) }

pub fn NlppostnSeries::median(self : NlppostnSeries) -> Double { @_common.median(self.vals) }

pub fn NlppostnSeries::scale(self : NlppostnSeries, f : Double) -> NlppostnSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlppostnSeries::add(self : NlppostnSeries, other : NlppostnSeries) -> NlppostnSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlppostnSeries::sub(self : NlppostnSeries, other : NlppostnSeries) -> NlppostnSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlppostnSeries::normalize(self : NlppostnSeries) -> NlppostnSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlppostnSeries::cumsum(self : NlppostnSeries) -> NlppostnSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlppostnSeries::to_string(self : NlppostnSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppostnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_tn_make_matrix(rows : Int, cols : Int, val : Double) -> NlppostnMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_pos_tn_matrix_identity(n : Int) -> NlppostnMatrix {
  let m = nlp_pos_tn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlppostnMatrix::get(self : NlppostnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlppostnMatrix::transpose(self : NlppostnMatrix) -> NlppostnMatrix {
  let result = nlp_pos_tn_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlppostnMatrix::add(self : NlppostnMatrix, other : NlppostnMatrix) -> NlppostnMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_tn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlppostnMatrix::scale(self : NlppostnMatrix, s : Double) -> NlppostnMatrix {
  let result = nlp_pos_tn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlppostnMatrix::multiply(self : NlppostnMatrix, other : NlppostnMatrix) -> NlppostnMatrix {
  if self.cols != other.rows { return nlp_pos_tn_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_tn_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlppostnMatrix::trace(self : NlppostnMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlppostnMatrix::det(self : NlppostnMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlppostnMatrix::norm(self : NlppostnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlppostnMatrix::to_string(self : NlppostnMatrix) -> String {
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

pub(all) struct NlppostnVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_tn_make_vector(comps : Array[Double]) -> NlppostnVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_tn_vector_zero(dim : Int) -> NlppostnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlppostnVector::add(self : NlppostnVector, other : NlppostnVector) -> NlppostnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlppostnVector::sub(self : NlppostnVector, other : NlppostnVector) -> NlppostnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlppostnVector::scale(self : NlppostnVector, s : Double) -> NlppostnVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlppostnVector::dot(self : NlppostnVector, other : NlppostnVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlppostnVector::norm(self : NlppostnVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlppostnVector::normalize(self : NlppostnVector) -> NlppostnVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppostnVector::dist(self : NlppostnVector, other : NlppostnVector) -> Double {
  self.sub(other).norm()
}

pub fn NlppostnVector::to_string(self : NlppostnVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppostnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_frame_make(size : Int) -> NlppostnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnFrame::len(self : NlppostnFrame) -> Int { self.size }

pub fn NlppostnFrame::get(self : NlppostnFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnFrame::set(self : NlppostnFrame, i : Int, v : Double) -> NlppostnFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnFrame::sum(self : NlppostnFrame) -> Double { @_common.sum(self.data) }

pub fn NlppostnFrame::mean(self : NlppostnFrame) -> Double { @_common.mean(self.data) }

pub fn NlppostnFrame::scale(self : NlppostnFrame, f : Double) -> NlppostnFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnFrame::add(self : NlppostnFrame, other : NlppostnFrame) -> NlppostnFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnFrame::copy(self : NlppostnFrame) -> NlppostnFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnFrame::fill(self : NlppostnFrame, v : Double) -> NlppostnFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnFrame::min(self : NlppostnFrame) -> Double { @_common.min(self.data) }

pub fn NlppostnFrame::max(self : NlppostnFrame) -> Double { @_common.max(self.data) }

pub fn NlppostnFrame::to_string(self : NlppostnFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_table_make(size : Int) -> NlppostnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnTable::len(self : NlppostnTable) -> Int { self.size }

pub fn NlppostnTable::get(self : NlppostnTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnTable::set(self : NlppostnTable, i : Int, v : Double) -> NlppostnTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnTable::sum(self : NlppostnTable) -> Double { @_common.sum(self.data) }

pub fn NlppostnTable::mean(self : NlppostnTable) -> Double { @_common.mean(self.data) }

pub fn NlppostnTable::scale(self : NlppostnTable, f : Double) -> NlppostnTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnTable::add(self : NlppostnTable, other : NlppostnTable) -> NlppostnTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnTable::copy(self : NlppostnTable) -> NlppostnTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnTable::fill(self : NlppostnTable, v : Double) -> NlppostnTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnTable::min(self : NlppostnTable) -> Double { @_common.min(self.data) }

pub fn NlppostnTable::max(self : NlppostnTable) -> Double { @_common.max(self.data) }

pub fn NlppostnTable::to_string(self : NlppostnTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_graphn_make(size : Int) -> NlppostnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnGraphN::len(self : NlppostnGraphN) -> Int { self.size }

pub fn NlppostnGraphN::get(self : NlppostnGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnGraphN::set(self : NlppostnGraphN, i : Int, v : Double) -> NlppostnGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnGraphN::sum(self : NlppostnGraphN) -> Double { @_common.sum(self.data) }

pub fn NlppostnGraphN::mean(self : NlppostnGraphN) -> Double { @_common.mean(self.data) }

pub fn NlppostnGraphN::scale(self : NlppostnGraphN, f : Double) -> NlppostnGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnGraphN::add(self : NlppostnGraphN, other : NlppostnGraphN) -> NlppostnGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnGraphN::copy(self : NlppostnGraphN) -> NlppostnGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnGraphN::fill(self : NlppostnGraphN, v : Double) -> NlppostnGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnGraphN::min(self : NlppostnGraphN) -> Double { @_common.min(self.data) }

pub fn NlppostnGraphN::max(self : NlppostnGraphN) -> Double { @_common.max(self.data) }

pub fn NlppostnGraphN::to_string(self : NlppostnGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_node_make(size : Int) -> NlppostnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnNode::len(self : NlppostnNode) -> Int { self.size }

pub fn NlppostnNode::get(self : NlppostnNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnNode::set(self : NlppostnNode, i : Int, v : Double) -> NlppostnNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnNode::sum(self : NlppostnNode) -> Double { @_common.sum(self.data) }

pub fn NlppostnNode::mean(self : NlppostnNode) -> Double { @_common.mean(self.data) }

pub fn NlppostnNode::scale(self : NlppostnNode, f : Double) -> NlppostnNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnNode::add(self : NlppostnNode, other : NlppostnNode) -> NlppostnNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnNode::copy(self : NlppostnNode) -> NlppostnNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnNode::fill(self : NlppostnNode, v : Double) -> NlppostnNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnNode::min(self : NlppostnNode) -> Double { @_common.min(self.data) }

pub fn NlppostnNode::max(self : NlppostnNode) -> Double { @_common.max(self.data) }

pub fn NlppostnNode::to_string(self : NlppostnNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_edge_make(size : Int) -> NlppostnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnEdge::len(self : NlppostnEdge) -> Int { self.size }

pub fn NlppostnEdge::get(self : NlppostnEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnEdge::set(self : NlppostnEdge, i : Int, v : Double) -> NlppostnEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnEdge::sum(self : NlppostnEdge) -> Double { @_common.sum(self.data) }

pub fn NlppostnEdge::mean(self : NlppostnEdge) -> Double { @_common.mean(self.data) }

pub fn NlppostnEdge::scale(self : NlppostnEdge, f : Double) -> NlppostnEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnEdge::add(self : NlppostnEdge, other : NlppostnEdge) -> NlppostnEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnEdge::copy(self : NlppostnEdge) -> NlppostnEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnEdge::fill(self : NlppostnEdge, v : Double) -> NlppostnEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnEdge::min(self : NlppostnEdge) -> Double { @_common.min(self.data) }

pub fn NlppostnEdge::max(self : NlppostnEdge) -> Double { @_common.max(self.data) }

pub fn NlppostnEdge::to_string(self : NlppostnEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_path_make(size : Int) -> NlppostnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnPath::len(self : NlppostnPath) -> Int { self.size }

pub fn NlppostnPath::get(self : NlppostnPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnPath::set(self : NlppostnPath, i : Int, v : Double) -> NlppostnPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnPath::sum(self : NlppostnPath) -> Double { @_common.sum(self.data) }

pub fn NlppostnPath::mean(self : NlppostnPath) -> Double { @_common.mean(self.data) }

pub fn NlppostnPath::scale(self : NlppostnPath, f : Double) -> NlppostnPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnPath::add(self : NlppostnPath, other : NlppostnPath) -> NlppostnPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnPath::copy(self : NlppostnPath) -> NlppostnPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnPath::fill(self : NlppostnPath, v : Double) -> NlppostnPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnPath::min(self : NlppostnPath) -> Double { @_common.min(self.data) }

pub fn NlppostnPath::max(self : NlppostnPath) -> Double { @_common.max(self.data) }

pub fn NlppostnPath::to_string(self : NlppostnPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_cluster_make(size : Int) -> NlppostnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnCluster::len(self : NlppostnCluster) -> Int { self.size }

pub fn NlppostnCluster::get(self : NlppostnCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnCluster::set(self : NlppostnCluster, i : Int, v : Double) -> NlppostnCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnCluster::sum(self : NlppostnCluster) -> Double { @_common.sum(self.data) }

pub fn NlppostnCluster::mean(self : NlppostnCluster) -> Double { @_common.mean(self.data) }

pub fn NlppostnCluster::scale(self : NlppostnCluster, f : Double) -> NlppostnCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnCluster::add(self : NlppostnCluster, other : NlppostnCluster) -> NlppostnCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnCluster::copy(self : NlppostnCluster) -> NlppostnCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnCluster::fill(self : NlppostnCluster, v : Double) -> NlppostnCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnCluster::min(self : NlppostnCluster) -> Double { @_common.min(self.data) }

pub fn NlppostnCluster::max(self : NlppostnCluster) -> Double { @_common.max(self.data) }

pub fn NlppostnCluster::to_string(self : NlppostnCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_model_make(size : Int) -> NlppostnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnModel::len(self : NlppostnModel) -> Int { self.size }

pub fn NlppostnModel::get(self : NlppostnModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnModel::set(self : NlppostnModel, i : Int, v : Double) -> NlppostnModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnModel::sum(self : NlppostnModel) -> Double { @_common.sum(self.data) }

pub fn NlppostnModel::mean(self : NlppostnModel) -> Double { @_common.mean(self.data) }

pub fn NlppostnModel::scale(self : NlppostnModel, f : Double) -> NlppostnModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnModel::add(self : NlppostnModel, other : NlppostnModel) -> NlppostnModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnModel::copy(self : NlppostnModel) -> NlppostnModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnModel::fill(self : NlppostnModel, v : Double) -> NlppostnModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnModel::min(self : NlppostnModel) -> Double { @_common.min(self.data) }

pub fn NlppostnModel::max(self : NlppostnModel) -> Double { @_common.max(self.data) }

pub fn NlppostnModel::to_string(self : NlppostnModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_layer_make(size : Int) -> NlppostnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnLayer::len(self : NlppostnLayer) -> Int { self.size }

pub fn NlppostnLayer::get(self : NlppostnLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnLayer::set(self : NlppostnLayer, i : Int, v : Double) -> NlppostnLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnLayer::sum(self : NlppostnLayer) -> Double { @_common.sum(self.data) }

pub fn NlppostnLayer::mean(self : NlppostnLayer) -> Double { @_common.mean(self.data) }

pub fn NlppostnLayer::scale(self : NlppostnLayer, f : Double) -> NlppostnLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnLayer::add(self : NlppostnLayer, other : NlppostnLayer) -> NlppostnLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnLayer::copy(self : NlppostnLayer) -> NlppostnLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnLayer::fill(self : NlppostnLayer, v : Double) -> NlppostnLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnLayer::min(self : NlppostnLayer) -> Double { @_common.min(self.data) }

pub fn NlppostnLayer::max(self : NlppostnLayer) -> Double { @_common.max(self.data) }

pub fn NlppostnLayer::to_string(self : NlppostnLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_buffer_make(size : Int) -> NlppostnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnBuffer::len(self : NlppostnBuffer) -> Int { self.size }

pub fn NlppostnBuffer::get(self : NlppostnBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnBuffer::set(self : NlppostnBuffer, i : Int, v : Double) -> NlppostnBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnBuffer::sum(self : NlppostnBuffer) -> Double { @_common.sum(self.data) }

pub fn NlppostnBuffer::mean(self : NlppostnBuffer) -> Double { @_common.mean(self.data) }

pub fn NlppostnBuffer::scale(self : NlppostnBuffer, f : Double) -> NlppostnBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnBuffer::add(self : NlppostnBuffer, other : NlppostnBuffer) -> NlppostnBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnBuffer::copy(self : NlppostnBuffer) -> NlppostnBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnBuffer::fill(self : NlppostnBuffer, v : Double) -> NlppostnBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnBuffer::min(self : NlppostnBuffer) -> Double { @_common.min(self.data) }

pub fn NlppostnBuffer::max(self : NlppostnBuffer) -> Double { @_common.max(self.data) }

pub fn NlppostnBuffer::to_string(self : NlppostnBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_cursor_make(size : Int) -> NlppostnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnCursor::len(self : NlppostnCursor) -> Int { self.size }

pub fn NlppostnCursor::get(self : NlppostnCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnCursor::set(self : NlppostnCursor, i : Int, v : Double) -> NlppostnCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnCursor::sum(self : NlppostnCursor) -> Double { @_common.sum(self.data) }

pub fn NlppostnCursor::mean(self : NlppostnCursor) -> Double { @_common.mean(self.data) }

pub fn NlppostnCursor::scale(self : NlppostnCursor, f : Double) -> NlppostnCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnCursor::add(self : NlppostnCursor, other : NlppostnCursor) -> NlppostnCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnCursor::copy(self : NlppostnCursor) -> NlppostnCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnCursor::fill(self : NlppostnCursor, v : Double) -> NlppostnCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnCursor::min(self : NlppostnCursor) -> Double { @_common.min(self.data) }

pub fn NlppostnCursor::max(self : NlppostnCursor) -> Double { @_common.max(self.data) }

pub fn NlppostnCursor::to_string(self : NlppostnCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_view_make(size : Int) -> NlppostnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnView::len(self : NlppostnView) -> Int { self.size }

pub fn NlppostnView::get(self : NlppostnView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnView::set(self : NlppostnView, i : Int, v : Double) -> NlppostnView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnView::sum(self : NlppostnView) -> Double { @_common.sum(self.data) }

pub fn NlppostnView::mean(self : NlppostnView) -> Double { @_common.mean(self.data) }

pub fn NlppostnView::scale(self : NlppostnView, f : Double) -> NlppostnView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnView::add(self : NlppostnView, other : NlppostnView) -> NlppostnView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnView::copy(self : NlppostnView) -> NlppostnView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnView::fill(self : NlppostnView, v : Double) -> NlppostnView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnView::min(self : NlppostnView) -> Double { @_common.min(self.data) }

pub fn NlppostnView::max(self : NlppostnView) -> Double { @_common.max(self.data) }

pub fn NlppostnView::to_string(self : NlppostnView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_range_make(size : Int) -> NlppostnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnRange::len(self : NlppostnRange) -> Int { self.size }

pub fn NlppostnRange::get(self : NlppostnRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnRange::set(self : NlppostnRange, i : Int, v : Double) -> NlppostnRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnRange::sum(self : NlppostnRange) -> Double { @_common.sum(self.data) }

pub fn NlppostnRange::mean(self : NlppostnRange) -> Double { @_common.mean(self.data) }

pub fn NlppostnRange::scale(self : NlppostnRange, f : Double) -> NlppostnRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnRange::add(self : NlppostnRange, other : NlppostnRange) -> NlppostnRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnRange::copy(self : NlppostnRange) -> NlppostnRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnRange::fill(self : NlppostnRange, v : Double) -> NlppostnRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnRange::min(self : NlppostnRange) -> Double { @_common.min(self.data) }

pub fn NlppostnRange::max(self : NlppostnRange) -> Double { @_common.max(self.data) }

pub fn NlppostnRange::to_string(self : NlppostnRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppostnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_slice_make(size : Int) -> NlppostnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppostnSlice::len(self : NlppostnSlice) -> Int { self.size }

pub fn NlppostnSlice::get(self : NlppostnSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppostnSlice::set(self : NlppostnSlice, i : Int, v : Double) -> NlppostnSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppostnSlice::sum(self : NlppostnSlice) -> Double { @_common.sum(self.data) }

pub fn NlppostnSlice::mean(self : NlppostnSlice) -> Double { @_common.mean(self.data) }

pub fn NlppostnSlice::scale(self : NlppostnSlice, f : Double) -> NlppostnSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppostnSlice::add(self : NlppostnSlice, other : NlppostnSlice) -> NlppostnSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppostnSlice::copy(self : NlppostnSlice) -> NlppostnSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppostnSlice::fill(self : NlppostnSlice, v : Double) -> NlppostnSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppostnSlice::min(self : NlppostnSlice) -> Double { @_common.min(self.data) }

pub fn NlppostnSlice::max(self : NlppostnSlice) -> Double { @_common.max(self.data) }

pub fn NlppostnSlice::to_string(self : NlppostnSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

