///===
/// extcore/nlp_pos_maxent

pub(all) struct NlpposmaxentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_maxent_make_point(x : Double, y : Double) -> NlpposmaxentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_maxent_make_point3(x : Double, y : Double, z : Double) -> NlpposmaxentPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposmaxentPoint::x(self : NlpposmaxentPoint) -> Double { self.x }

pub fn NlpposmaxentPoint::y(self : NlpposmaxentPoint) -> Double { self.y }

pub fn NlpposmaxentPoint::z(self : NlpposmaxentPoint) -> Double { self.z }

pub fn NlpposmaxentPoint::label(self : NlpposmaxentPoint) -> Int { self.label }

pub fn NlpposmaxentPoint::dist(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposmaxentPoint::add(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposmaxentPoint::sub(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposmaxentPoint::scale(self : NlpposmaxentPoint, s : Double) -> NlpposmaxentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposmaxentPoint::dot(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposmaxentPoint::cross(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposmaxentPoint::norm(self : NlpposmaxentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposmaxentPoint::normalize(self : NlpposmaxentPoint) -> NlpposmaxentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposmaxentPoint::negate(self : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposmaxentPoint::mid(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposmaxentPoint::lerp(self : NlpposmaxentPoint, other : NlpposmaxentPoint, t : Double) -> NlpposmaxentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposmaxentPoint::to_string(self : NlpposmaxentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposmaxentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_maxent_make_series(vals : Array[Double], name : String) -> NlpposmaxentSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposmaxentSeries::len(self : NlpposmaxentSeries) -> Int { self.vals.length() }

pub fn NlpposmaxentSeries::sum(self : NlpposmaxentSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposmaxentSeries::mean(self : NlpposmaxentSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposmaxentSeries::min(self : NlpposmaxentSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposmaxentSeries::max(self : NlpposmaxentSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposmaxentSeries::range(self : NlpposmaxentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposmaxentSeries::variance(self : NlpposmaxentSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposmaxentSeries::std(self : NlpposmaxentSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposmaxentSeries::median(self : NlpposmaxentSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposmaxentSeries::scale(self : NlpposmaxentSeries, f : Double) -> NlpposmaxentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposmaxentSeries::add(self : NlpposmaxentSeries, other : NlpposmaxentSeries) -> NlpposmaxentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposmaxentSeries::sub(self : NlpposmaxentSeries, other : NlpposmaxentSeries) -> NlpposmaxentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposmaxentSeries::normalize(self : NlpposmaxentSeries) -> NlpposmaxentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposmaxentSeries::cumsum(self : NlpposmaxentSeries) -> NlpposmaxentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposmaxentSeries::to_string(self : NlpposmaxentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposmaxentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_maxent_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposmaxentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_maxent_matrix_identity(n : Int) -> NlpposmaxentMatrix {
  let m = nlp_pos_maxent_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposmaxentMatrix::get(self : NlpposmaxentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposmaxentMatrix::transpose(self : NlpposmaxentMatrix) -> NlpposmaxentMatrix {
  let result = nlp_pos_maxent_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposmaxentMatrix::add(self : NlpposmaxentMatrix, other : NlpposmaxentMatrix) -> NlpposmaxentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_maxent_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposmaxentMatrix::scale(self : NlpposmaxentMatrix, s : Double) -> NlpposmaxentMatrix {
  let result = nlp_pos_maxent_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposmaxentMatrix::multiply(self : NlpposmaxentMatrix, other : NlpposmaxentMatrix) -> NlpposmaxentMatrix {
  if self.cols != other.rows { return nlp_pos_maxent_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_maxent_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpposmaxentMatrix::trace(self : NlpposmaxentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposmaxentMatrix::det(self : NlpposmaxentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposmaxentMatrix::norm(self : NlpposmaxentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposmaxentMatrix::to_string(self : NlpposmaxentMatrix) -> String {
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

pub(all) struct NlpposmaxentVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_maxent_make_vector(comps : Array[Double]) -> NlpposmaxentVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_maxent_vector_zero(dim : Int) -> NlpposmaxentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposmaxentVector::add(self : NlpposmaxentVector, other : NlpposmaxentVector) -> NlpposmaxentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposmaxentVector::sub(self : NlpposmaxentVector, other : NlpposmaxentVector) -> NlpposmaxentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposmaxentVector::scale(self : NlpposmaxentVector, s : Double) -> NlpposmaxentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposmaxentVector::dot(self : NlpposmaxentVector, other : NlpposmaxentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposmaxentVector::norm(self : NlpposmaxentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposmaxentVector::normalize(self : NlpposmaxentVector) -> NlpposmaxentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposmaxentVector::dist(self : NlpposmaxentVector, other : NlpposmaxentVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposmaxentVector::to_string(self : NlpposmaxentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposmaxentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_frame_make(size : Int) -> NlpposmaxentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentFrame::len(self : NlpposmaxentFrame) -> Int { self.size }

pub fn NlpposmaxentFrame::get(self : NlpposmaxentFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentFrame::set(self : NlpposmaxentFrame, i : Int, v : Double) -> NlpposmaxentFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentFrame::sum(self : NlpposmaxentFrame) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentFrame::mean(self : NlpposmaxentFrame) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentFrame::scale(self : NlpposmaxentFrame, f : Double) -> NlpposmaxentFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentFrame::add(self : NlpposmaxentFrame, other : NlpposmaxentFrame) -> NlpposmaxentFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentFrame::copy(self : NlpposmaxentFrame) -> NlpposmaxentFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentFrame::fill(self : NlpposmaxentFrame, v : Double) -> NlpposmaxentFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentFrame::min(self : NlpposmaxentFrame) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentFrame::max(self : NlpposmaxentFrame) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentFrame::to_string(self : NlpposmaxentFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_table_make(size : Int) -> NlpposmaxentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentTable::len(self : NlpposmaxentTable) -> Int { self.size }

pub fn NlpposmaxentTable::get(self : NlpposmaxentTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentTable::set(self : NlpposmaxentTable, i : Int, v : Double) -> NlpposmaxentTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentTable::sum(self : NlpposmaxentTable) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentTable::mean(self : NlpposmaxentTable) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentTable::scale(self : NlpposmaxentTable, f : Double) -> NlpposmaxentTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentTable::add(self : NlpposmaxentTable, other : NlpposmaxentTable) -> NlpposmaxentTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentTable::copy(self : NlpposmaxentTable) -> NlpposmaxentTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentTable::fill(self : NlpposmaxentTable, v : Double) -> NlpposmaxentTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentTable::min(self : NlpposmaxentTable) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentTable::max(self : NlpposmaxentTable) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentTable::to_string(self : NlpposmaxentTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_graphn_make(size : Int) -> NlpposmaxentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentGraphN::len(self : NlpposmaxentGraphN) -> Int { self.size }

pub fn NlpposmaxentGraphN::get(self : NlpposmaxentGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentGraphN::set(self : NlpposmaxentGraphN, i : Int, v : Double) -> NlpposmaxentGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentGraphN::sum(self : NlpposmaxentGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentGraphN::mean(self : NlpposmaxentGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentGraphN::scale(self : NlpposmaxentGraphN, f : Double) -> NlpposmaxentGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentGraphN::add(self : NlpposmaxentGraphN, other : NlpposmaxentGraphN) -> NlpposmaxentGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentGraphN::copy(self : NlpposmaxentGraphN) -> NlpposmaxentGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentGraphN::fill(self : NlpposmaxentGraphN, v : Double) -> NlpposmaxentGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentGraphN::min(self : NlpposmaxentGraphN) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentGraphN::max(self : NlpposmaxentGraphN) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentGraphN::to_string(self : NlpposmaxentGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_node_make(size : Int) -> NlpposmaxentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentNode::len(self : NlpposmaxentNode) -> Int { self.size }

pub fn NlpposmaxentNode::get(self : NlpposmaxentNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentNode::set(self : NlpposmaxentNode, i : Int, v : Double) -> NlpposmaxentNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentNode::sum(self : NlpposmaxentNode) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentNode::mean(self : NlpposmaxentNode) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentNode::scale(self : NlpposmaxentNode, f : Double) -> NlpposmaxentNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentNode::add(self : NlpposmaxentNode, other : NlpposmaxentNode) -> NlpposmaxentNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentNode::copy(self : NlpposmaxentNode) -> NlpposmaxentNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentNode::fill(self : NlpposmaxentNode, v : Double) -> NlpposmaxentNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentNode::min(self : NlpposmaxentNode) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentNode::max(self : NlpposmaxentNode) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentNode::to_string(self : NlpposmaxentNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_edge_make(size : Int) -> NlpposmaxentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentEdge::len(self : NlpposmaxentEdge) -> Int { self.size }

pub fn NlpposmaxentEdge::get(self : NlpposmaxentEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentEdge::set(self : NlpposmaxentEdge, i : Int, v : Double) -> NlpposmaxentEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentEdge::sum(self : NlpposmaxentEdge) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentEdge::mean(self : NlpposmaxentEdge) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentEdge::scale(self : NlpposmaxentEdge, f : Double) -> NlpposmaxentEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentEdge::add(self : NlpposmaxentEdge, other : NlpposmaxentEdge) -> NlpposmaxentEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentEdge::copy(self : NlpposmaxentEdge) -> NlpposmaxentEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentEdge::fill(self : NlpposmaxentEdge, v : Double) -> NlpposmaxentEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentEdge::min(self : NlpposmaxentEdge) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentEdge::max(self : NlpposmaxentEdge) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentEdge::to_string(self : NlpposmaxentEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_path_make(size : Int) -> NlpposmaxentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentPath::len(self : NlpposmaxentPath) -> Int { self.size }

pub fn NlpposmaxentPath::get(self : NlpposmaxentPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentPath::set(self : NlpposmaxentPath, i : Int, v : Double) -> NlpposmaxentPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentPath::sum(self : NlpposmaxentPath) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentPath::mean(self : NlpposmaxentPath) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentPath::scale(self : NlpposmaxentPath, f : Double) -> NlpposmaxentPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentPath::add(self : NlpposmaxentPath, other : NlpposmaxentPath) -> NlpposmaxentPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentPath::copy(self : NlpposmaxentPath) -> NlpposmaxentPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentPath::fill(self : NlpposmaxentPath, v : Double) -> NlpposmaxentPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentPath::min(self : NlpposmaxentPath) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentPath::max(self : NlpposmaxentPath) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentPath::to_string(self : NlpposmaxentPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_cluster_make(size : Int) -> NlpposmaxentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentCluster::len(self : NlpposmaxentCluster) -> Int { self.size }

pub fn NlpposmaxentCluster::get(self : NlpposmaxentCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentCluster::set(self : NlpposmaxentCluster, i : Int, v : Double) -> NlpposmaxentCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentCluster::sum(self : NlpposmaxentCluster) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentCluster::mean(self : NlpposmaxentCluster) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentCluster::scale(self : NlpposmaxentCluster, f : Double) -> NlpposmaxentCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentCluster::add(self : NlpposmaxentCluster, other : NlpposmaxentCluster) -> NlpposmaxentCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentCluster::copy(self : NlpposmaxentCluster) -> NlpposmaxentCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentCluster::fill(self : NlpposmaxentCluster, v : Double) -> NlpposmaxentCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentCluster::min(self : NlpposmaxentCluster) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentCluster::max(self : NlpposmaxentCluster) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentCluster::to_string(self : NlpposmaxentCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_model_make(size : Int) -> NlpposmaxentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentModel::len(self : NlpposmaxentModel) -> Int { self.size }

pub fn NlpposmaxentModel::get(self : NlpposmaxentModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentModel::set(self : NlpposmaxentModel, i : Int, v : Double) -> NlpposmaxentModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentModel::sum(self : NlpposmaxentModel) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentModel::mean(self : NlpposmaxentModel) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentModel::scale(self : NlpposmaxentModel, f : Double) -> NlpposmaxentModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentModel::add(self : NlpposmaxentModel, other : NlpposmaxentModel) -> NlpposmaxentModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentModel::copy(self : NlpposmaxentModel) -> NlpposmaxentModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentModel::fill(self : NlpposmaxentModel, v : Double) -> NlpposmaxentModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentModel::min(self : NlpposmaxentModel) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentModel::max(self : NlpposmaxentModel) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentModel::to_string(self : NlpposmaxentModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_layer_make(size : Int) -> NlpposmaxentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentLayer::len(self : NlpposmaxentLayer) -> Int { self.size }

pub fn NlpposmaxentLayer::get(self : NlpposmaxentLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentLayer::set(self : NlpposmaxentLayer, i : Int, v : Double) -> NlpposmaxentLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentLayer::sum(self : NlpposmaxentLayer) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentLayer::mean(self : NlpposmaxentLayer) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentLayer::scale(self : NlpposmaxentLayer, f : Double) -> NlpposmaxentLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentLayer::add(self : NlpposmaxentLayer, other : NlpposmaxentLayer) -> NlpposmaxentLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentLayer::copy(self : NlpposmaxentLayer) -> NlpposmaxentLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentLayer::fill(self : NlpposmaxentLayer, v : Double) -> NlpposmaxentLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentLayer::min(self : NlpposmaxentLayer) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentLayer::max(self : NlpposmaxentLayer) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentLayer::to_string(self : NlpposmaxentLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_buffer_make(size : Int) -> NlpposmaxentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentBuffer::len(self : NlpposmaxentBuffer) -> Int { self.size }

pub fn NlpposmaxentBuffer::get(self : NlpposmaxentBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentBuffer::set(self : NlpposmaxentBuffer, i : Int, v : Double) -> NlpposmaxentBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentBuffer::sum(self : NlpposmaxentBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentBuffer::mean(self : NlpposmaxentBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentBuffer::scale(self : NlpposmaxentBuffer, f : Double) -> NlpposmaxentBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentBuffer::add(self : NlpposmaxentBuffer, other : NlpposmaxentBuffer) -> NlpposmaxentBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentBuffer::copy(self : NlpposmaxentBuffer) -> NlpposmaxentBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentBuffer::fill(self : NlpposmaxentBuffer, v : Double) -> NlpposmaxentBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentBuffer::min(self : NlpposmaxentBuffer) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentBuffer::max(self : NlpposmaxentBuffer) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentBuffer::to_string(self : NlpposmaxentBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_cursor_make(size : Int) -> NlpposmaxentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentCursor::len(self : NlpposmaxentCursor) -> Int { self.size }

pub fn NlpposmaxentCursor::get(self : NlpposmaxentCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentCursor::set(self : NlpposmaxentCursor, i : Int, v : Double) -> NlpposmaxentCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentCursor::sum(self : NlpposmaxentCursor) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentCursor::mean(self : NlpposmaxentCursor) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentCursor::scale(self : NlpposmaxentCursor, f : Double) -> NlpposmaxentCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentCursor::add(self : NlpposmaxentCursor, other : NlpposmaxentCursor) -> NlpposmaxentCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentCursor::copy(self : NlpposmaxentCursor) -> NlpposmaxentCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentCursor::fill(self : NlpposmaxentCursor, v : Double) -> NlpposmaxentCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentCursor::min(self : NlpposmaxentCursor) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentCursor::max(self : NlpposmaxentCursor) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentCursor::to_string(self : NlpposmaxentCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_view_make(size : Int) -> NlpposmaxentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentView::len(self : NlpposmaxentView) -> Int { self.size }

pub fn NlpposmaxentView::get(self : NlpposmaxentView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentView::set(self : NlpposmaxentView, i : Int, v : Double) -> NlpposmaxentView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentView::sum(self : NlpposmaxentView) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentView::mean(self : NlpposmaxentView) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentView::scale(self : NlpposmaxentView, f : Double) -> NlpposmaxentView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentView::add(self : NlpposmaxentView, other : NlpposmaxentView) -> NlpposmaxentView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentView::copy(self : NlpposmaxentView) -> NlpposmaxentView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentView::fill(self : NlpposmaxentView, v : Double) -> NlpposmaxentView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentView::min(self : NlpposmaxentView) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentView::max(self : NlpposmaxentView) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentView::to_string(self : NlpposmaxentView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_range_make(size : Int) -> NlpposmaxentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentRange::len(self : NlpposmaxentRange) -> Int { self.size }

pub fn NlpposmaxentRange::get(self : NlpposmaxentRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentRange::set(self : NlpposmaxentRange, i : Int, v : Double) -> NlpposmaxentRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentRange::sum(self : NlpposmaxentRange) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentRange::mean(self : NlpposmaxentRange) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentRange::scale(self : NlpposmaxentRange, f : Double) -> NlpposmaxentRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentRange::add(self : NlpposmaxentRange, other : NlpposmaxentRange) -> NlpposmaxentRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentRange::copy(self : NlpposmaxentRange) -> NlpposmaxentRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentRange::fill(self : NlpposmaxentRange, v : Double) -> NlpposmaxentRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentRange::min(self : NlpposmaxentRange) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentRange::max(self : NlpposmaxentRange) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentRange::to_string(self : NlpposmaxentRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_slice_make(size : Int) -> NlpposmaxentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposmaxentSlice::len(self : NlpposmaxentSlice) -> Int { self.size }

pub fn NlpposmaxentSlice::get(self : NlpposmaxentSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposmaxentSlice::set(self : NlpposmaxentSlice, i : Int, v : Double) -> NlpposmaxentSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposmaxentSlice::sum(self : NlpposmaxentSlice) -> Double { @_common.sum(self.data) }

pub fn NlpposmaxentSlice::mean(self : NlpposmaxentSlice) -> Double { @_common.mean(self.data) }

pub fn NlpposmaxentSlice::scale(self : NlpposmaxentSlice, f : Double) -> NlpposmaxentSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentSlice::add(self : NlpposmaxentSlice, other : NlpposmaxentSlice) -> NlpposmaxentSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposmaxentSlice::copy(self : NlpposmaxentSlice) -> NlpposmaxentSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentSlice::fill(self : NlpposmaxentSlice, v : Double) -> NlpposmaxentSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposmaxentSlice::min(self : NlpposmaxentSlice) -> Double { @_common.min(self.data) }

pub fn NlpposmaxentSlice::max(self : NlpposmaxentSlice) -> Double { @_common.max(self.data) }

pub fn NlpposmaxentSlice::to_string(self : NlpposmaxentSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

