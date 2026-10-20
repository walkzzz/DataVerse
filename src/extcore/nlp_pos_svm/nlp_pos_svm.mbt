///===
/// extcore/nlp_pos_svm

pub(all) struct NlppossvmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_svm_make_point(x : Double, y : Double) -> NlppossvmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_svm_make_point3(x : Double, y : Double, z : Double) -> NlppossvmPoint {
  { x, y, z, label: 0 }
}

pub fn NlppossvmPoint::x(self : NlppossvmPoint) -> Double { self.x }

pub fn NlppossvmPoint::y(self : NlppossvmPoint) -> Double { self.y }

pub fn NlppossvmPoint::z(self : NlppossvmPoint) -> Double { self.z }

pub fn NlppossvmPoint::label(self : NlppossvmPoint) -> Int { self.label }

pub fn NlppossvmPoint::dist(self : NlppossvmPoint, other : NlppossvmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlppossvmPoint::add(self : NlppossvmPoint, other : NlppossvmPoint) -> NlppossvmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlppossvmPoint::sub(self : NlppossvmPoint, other : NlppossvmPoint) -> NlppossvmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlppossvmPoint::scale(self : NlppossvmPoint, s : Double) -> NlppossvmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlppossvmPoint::dot(self : NlppossvmPoint, other : NlppossvmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlppossvmPoint::cross(self : NlppossvmPoint, other : NlppossvmPoint) -> NlppossvmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlppossvmPoint::norm(self : NlppossvmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlppossvmPoint::normalize(self : NlppossvmPoint) -> NlppossvmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppossvmPoint::negate(self : NlppossvmPoint) -> NlppossvmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlppossvmPoint::mid(self : NlppossvmPoint, other : NlppossvmPoint) -> NlppossvmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlppossvmPoint::lerp(self : NlppossvmPoint, other : NlppossvmPoint, t : Double) -> NlppossvmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlppossvmPoint::to_string(self : NlppossvmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlppossvmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_svm_make_series(vals : Array[Double], name : String) -> NlppossvmSeries {
  { vals, name, meta: 0 }
}

pub fn NlppossvmSeries::len(self : NlppossvmSeries) -> Int { self.vals.length() }

pub fn NlppossvmSeries::sum(self : NlppossvmSeries) -> Double { @_common.sum(self.vals) }

pub fn NlppossvmSeries::mean(self : NlppossvmSeries) -> Double { @_common.mean(self.vals) }

pub fn NlppossvmSeries::min(self : NlppossvmSeries) -> Double { @_common.min(self.vals) }

pub fn NlppossvmSeries::max(self : NlppossvmSeries) -> Double { @_common.max(self.vals) }

pub fn NlppossvmSeries::range(self : NlppossvmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlppossvmSeries::variance(self : NlppossvmSeries) -> Double { @_common.variance(self.vals) }

pub fn NlppossvmSeries::std(self : NlppossvmSeries) -> Double { @_common.std(self.vals) }

pub fn NlppossvmSeries::median(self : NlppossvmSeries) -> Double { @_common.median(self.vals) }

pub fn NlppossvmSeries::scale(self : NlppossvmSeries, f : Double) -> NlppossvmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlppossvmSeries::add(self : NlppossvmSeries, other : NlppossvmSeries) -> NlppossvmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlppossvmSeries::sub(self : NlppossvmSeries, other : NlppossvmSeries) -> NlppossvmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlppossvmSeries::normalize(self : NlppossvmSeries) -> NlppossvmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlppossvmSeries::cumsum(self : NlppossvmSeries) -> NlppossvmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlppossvmSeries::to_string(self : NlppossvmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppossvmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_svm_make_matrix(rows : Int, cols : Int, val : Double) -> NlppossvmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_svm_matrix_identity(n : Int) -> NlppossvmMatrix {
  let m = nlp_pos_svm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlppossvmMatrix::get(self : NlppossvmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlppossvmMatrix::transpose(self : NlppossvmMatrix) -> NlppossvmMatrix {
  let result = nlp_pos_svm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlppossvmMatrix::add(self : NlppossvmMatrix, other : NlppossvmMatrix) -> NlppossvmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_svm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlppossvmMatrix::scale(self : NlppossvmMatrix, s : Double) -> NlppossvmMatrix {
  let result = nlp_pos_svm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlppossvmMatrix::multiply(self : NlppossvmMatrix, other : NlppossvmMatrix) -> NlppossvmMatrix {
  if self.cols != other.rows { return nlp_pos_svm_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_svm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlppossvmMatrix::trace(self : NlppossvmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlppossvmMatrix::det(self : NlppossvmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlppossvmMatrix::norm(self : NlppossvmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlppossvmMatrix::to_string(self : NlppossvmMatrix) -> String {
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

pub(all) struct NlppossvmVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_svm_make_vector(comps : Array[Double]) -> NlppossvmVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_svm_vector_zero(dim : Int) -> NlppossvmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlppossvmVector::add(self : NlppossvmVector, other : NlppossvmVector) -> NlppossvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlppossvmVector::sub(self : NlppossvmVector, other : NlppossvmVector) -> NlppossvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlppossvmVector::scale(self : NlppossvmVector, s : Double) -> NlppossvmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlppossvmVector::dot(self : NlppossvmVector, other : NlppossvmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlppossvmVector::norm(self : NlppossvmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlppossvmVector::normalize(self : NlppossvmVector) -> NlppossvmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppossvmVector::dist(self : NlppossvmVector, other : NlppossvmVector) -> Double {
  self.sub(other).norm()
}

pub fn NlppossvmVector::to_string(self : NlppossvmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppossvmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_frame_make(size : Int) -> NlppossvmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmFrame::len(self : NlppossvmFrame) -> Int { self.size }

pub fn NlppossvmFrame::get(self : NlppossvmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmFrame::set(self : NlppossvmFrame, i : Int, v : Double) -> NlppossvmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmFrame::sum(self : NlppossvmFrame) -> Double { @_common.sum(self.data) }

pub fn NlppossvmFrame::mean(self : NlppossvmFrame) -> Double { @_common.mean(self.data) }

pub fn NlppossvmFrame::scale(self : NlppossvmFrame, f : Double) -> NlppossvmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmFrame::add(self : NlppossvmFrame, other : NlppossvmFrame) -> NlppossvmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmFrame::copy(self : NlppossvmFrame) -> NlppossvmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmFrame::fill(self : NlppossvmFrame, v : Double) -> NlppossvmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmFrame::min(self : NlppossvmFrame) -> Double { @_common.min(self.data) }

pub fn NlppossvmFrame::max(self : NlppossvmFrame) -> Double { @_common.max(self.data) }

pub fn NlppossvmFrame::to_string(self : NlppossvmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_table_make(size : Int) -> NlppossvmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmTable::len(self : NlppossvmTable) -> Int { self.size }

pub fn NlppossvmTable::get(self : NlppossvmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmTable::set(self : NlppossvmTable, i : Int, v : Double) -> NlppossvmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmTable::sum(self : NlppossvmTable) -> Double { @_common.sum(self.data) }

pub fn NlppossvmTable::mean(self : NlppossvmTable) -> Double { @_common.mean(self.data) }

pub fn NlppossvmTable::scale(self : NlppossvmTable, f : Double) -> NlppossvmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmTable::add(self : NlppossvmTable, other : NlppossvmTable) -> NlppossvmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmTable::copy(self : NlppossvmTable) -> NlppossvmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmTable::fill(self : NlppossvmTable, v : Double) -> NlppossvmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmTable::min(self : NlppossvmTable) -> Double { @_common.min(self.data) }

pub fn NlppossvmTable::max(self : NlppossvmTable) -> Double { @_common.max(self.data) }

pub fn NlppossvmTable::to_string(self : NlppossvmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_graphn_make(size : Int) -> NlppossvmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmGraphN::len(self : NlppossvmGraphN) -> Int { self.size }

pub fn NlppossvmGraphN::get(self : NlppossvmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmGraphN::set(self : NlppossvmGraphN, i : Int, v : Double) -> NlppossvmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmGraphN::sum(self : NlppossvmGraphN) -> Double { @_common.sum(self.data) }

pub fn NlppossvmGraphN::mean(self : NlppossvmGraphN) -> Double { @_common.mean(self.data) }

pub fn NlppossvmGraphN::scale(self : NlppossvmGraphN, f : Double) -> NlppossvmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmGraphN::add(self : NlppossvmGraphN, other : NlppossvmGraphN) -> NlppossvmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmGraphN::copy(self : NlppossvmGraphN) -> NlppossvmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmGraphN::fill(self : NlppossvmGraphN, v : Double) -> NlppossvmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmGraphN::min(self : NlppossvmGraphN) -> Double { @_common.min(self.data) }

pub fn NlppossvmGraphN::max(self : NlppossvmGraphN) -> Double { @_common.max(self.data) }

pub fn NlppossvmGraphN::to_string(self : NlppossvmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_node_make(size : Int) -> NlppossvmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmNode::len(self : NlppossvmNode) -> Int { self.size }

pub fn NlppossvmNode::get(self : NlppossvmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmNode::set(self : NlppossvmNode, i : Int, v : Double) -> NlppossvmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmNode::sum(self : NlppossvmNode) -> Double { @_common.sum(self.data) }

pub fn NlppossvmNode::mean(self : NlppossvmNode) -> Double { @_common.mean(self.data) }

pub fn NlppossvmNode::scale(self : NlppossvmNode, f : Double) -> NlppossvmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmNode::add(self : NlppossvmNode, other : NlppossvmNode) -> NlppossvmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmNode::copy(self : NlppossvmNode) -> NlppossvmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmNode::fill(self : NlppossvmNode, v : Double) -> NlppossvmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmNode::min(self : NlppossvmNode) -> Double { @_common.min(self.data) }

pub fn NlppossvmNode::max(self : NlppossvmNode) -> Double { @_common.max(self.data) }

pub fn NlppossvmNode::to_string(self : NlppossvmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_edge_make(size : Int) -> NlppossvmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmEdge::len(self : NlppossvmEdge) -> Int { self.size }

pub fn NlppossvmEdge::get(self : NlppossvmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmEdge::set(self : NlppossvmEdge, i : Int, v : Double) -> NlppossvmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmEdge::sum(self : NlppossvmEdge) -> Double { @_common.sum(self.data) }

pub fn NlppossvmEdge::mean(self : NlppossvmEdge) -> Double { @_common.mean(self.data) }

pub fn NlppossvmEdge::scale(self : NlppossvmEdge, f : Double) -> NlppossvmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmEdge::add(self : NlppossvmEdge, other : NlppossvmEdge) -> NlppossvmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmEdge::copy(self : NlppossvmEdge) -> NlppossvmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmEdge::fill(self : NlppossvmEdge, v : Double) -> NlppossvmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmEdge::min(self : NlppossvmEdge) -> Double { @_common.min(self.data) }

pub fn NlppossvmEdge::max(self : NlppossvmEdge) -> Double { @_common.max(self.data) }

pub fn NlppossvmEdge::to_string(self : NlppossvmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_path_make(size : Int) -> NlppossvmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmPath::len(self : NlppossvmPath) -> Int { self.size }

pub fn NlppossvmPath::get(self : NlppossvmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmPath::set(self : NlppossvmPath, i : Int, v : Double) -> NlppossvmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmPath::sum(self : NlppossvmPath) -> Double { @_common.sum(self.data) }

pub fn NlppossvmPath::mean(self : NlppossvmPath) -> Double { @_common.mean(self.data) }

pub fn NlppossvmPath::scale(self : NlppossvmPath, f : Double) -> NlppossvmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmPath::add(self : NlppossvmPath, other : NlppossvmPath) -> NlppossvmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmPath::copy(self : NlppossvmPath) -> NlppossvmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmPath::fill(self : NlppossvmPath, v : Double) -> NlppossvmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmPath::min(self : NlppossvmPath) -> Double { @_common.min(self.data) }

pub fn NlppossvmPath::max(self : NlppossvmPath) -> Double { @_common.max(self.data) }

pub fn NlppossvmPath::to_string(self : NlppossvmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_cluster_make(size : Int) -> NlppossvmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmCluster::len(self : NlppossvmCluster) -> Int { self.size }

pub fn NlppossvmCluster::get(self : NlppossvmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmCluster::set(self : NlppossvmCluster, i : Int, v : Double) -> NlppossvmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmCluster::sum(self : NlppossvmCluster) -> Double { @_common.sum(self.data) }

pub fn NlppossvmCluster::mean(self : NlppossvmCluster) -> Double { @_common.mean(self.data) }

pub fn NlppossvmCluster::scale(self : NlppossvmCluster, f : Double) -> NlppossvmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmCluster::add(self : NlppossvmCluster, other : NlppossvmCluster) -> NlppossvmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmCluster::copy(self : NlppossvmCluster) -> NlppossvmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmCluster::fill(self : NlppossvmCluster, v : Double) -> NlppossvmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmCluster::min(self : NlppossvmCluster) -> Double { @_common.min(self.data) }

pub fn NlppossvmCluster::max(self : NlppossvmCluster) -> Double { @_common.max(self.data) }

pub fn NlppossvmCluster::to_string(self : NlppossvmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_model_make(size : Int) -> NlppossvmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmModel::len(self : NlppossvmModel) -> Int { self.size }

pub fn NlppossvmModel::get(self : NlppossvmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmModel::set(self : NlppossvmModel, i : Int, v : Double) -> NlppossvmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmModel::sum(self : NlppossvmModel) -> Double { @_common.sum(self.data) }

pub fn NlppossvmModel::mean(self : NlppossvmModel) -> Double { @_common.mean(self.data) }

pub fn NlppossvmModel::scale(self : NlppossvmModel, f : Double) -> NlppossvmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmModel::add(self : NlppossvmModel, other : NlppossvmModel) -> NlppossvmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmModel::copy(self : NlppossvmModel) -> NlppossvmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmModel::fill(self : NlppossvmModel, v : Double) -> NlppossvmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmModel::min(self : NlppossvmModel) -> Double { @_common.min(self.data) }

pub fn NlppossvmModel::max(self : NlppossvmModel) -> Double { @_common.max(self.data) }

pub fn NlppossvmModel::to_string(self : NlppossvmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_layer_make(size : Int) -> NlppossvmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmLayer::len(self : NlppossvmLayer) -> Int { self.size }

pub fn NlppossvmLayer::get(self : NlppossvmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmLayer::set(self : NlppossvmLayer, i : Int, v : Double) -> NlppossvmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmLayer::sum(self : NlppossvmLayer) -> Double { @_common.sum(self.data) }

pub fn NlppossvmLayer::mean(self : NlppossvmLayer) -> Double { @_common.mean(self.data) }

pub fn NlppossvmLayer::scale(self : NlppossvmLayer, f : Double) -> NlppossvmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmLayer::add(self : NlppossvmLayer, other : NlppossvmLayer) -> NlppossvmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmLayer::copy(self : NlppossvmLayer) -> NlppossvmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmLayer::fill(self : NlppossvmLayer, v : Double) -> NlppossvmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmLayer::min(self : NlppossvmLayer) -> Double { @_common.min(self.data) }

pub fn NlppossvmLayer::max(self : NlppossvmLayer) -> Double { @_common.max(self.data) }

pub fn NlppossvmLayer::to_string(self : NlppossvmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_buffer_make(size : Int) -> NlppossvmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmBuffer::len(self : NlppossvmBuffer) -> Int { self.size }

pub fn NlppossvmBuffer::get(self : NlppossvmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmBuffer::set(self : NlppossvmBuffer, i : Int, v : Double) -> NlppossvmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmBuffer::sum(self : NlppossvmBuffer) -> Double { @_common.sum(self.data) }

pub fn NlppossvmBuffer::mean(self : NlppossvmBuffer) -> Double { @_common.mean(self.data) }

pub fn NlppossvmBuffer::scale(self : NlppossvmBuffer, f : Double) -> NlppossvmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmBuffer::add(self : NlppossvmBuffer, other : NlppossvmBuffer) -> NlppossvmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmBuffer::copy(self : NlppossvmBuffer) -> NlppossvmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmBuffer::fill(self : NlppossvmBuffer, v : Double) -> NlppossvmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmBuffer::min(self : NlppossvmBuffer) -> Double { @_common.min(self.data) }

pub fn NlppossvmBuffer::max(self : NlppossvmBuffer) -> Double { @_common.max(self.data) }

pub fn NlppossvmBuffer::to_string(self : NlppossvmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_cursor_make(size : Int) -> NlppossvmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmCursor::len(self : NlppossvmCursor) -> Int { self.size }

pub fn NlppossvmCursor::get(self : NlppossvmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmCursor::set(self : NlppossvmCursor, i : Int, v : Double) -> NlppossvmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmCursor::sum(self : NlppossvmCursor) -> Double { @_common.sum(self.data) }

pub fn NlppossvmCursor::mean(self : NlppossvmCursor) -> Double { @_common.mean(self.data) }

pub fn NlppossvmCursor::scale(self : NlppossvmCursor, f : Double) -> NlppossvmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmCursor::add(self : NlppossvmCursor, other : NlppossvmCursor) -> NlppossvmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmCursor::copy(self : NlppossvmCursor) -> NlppossvmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmCursor::fill(self : NlppossvmCursor, v : Double) -> NlppossvmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmCursor::min(self : NlppossvmCursor) -> Double { @_common.min(self.data) }

pub fn NlppossvmCursor::max(self : NlppossvmCursor) -> Double { @_common.max(self.data) }

pub fn NlppossvmCursor::to_string(self : NlppossvmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_view_make(size : Int) -> NlppossvmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmView::len(self : NlppossvmView) -> Int { self.size }

pub fn NlppossvmView::get(self : NlppossvmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmView::set(self : NlppossvmView, i : Int, v : Double) -> NlppossvmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmView::sum(self : NlppossvmView) -> Double { @_common.sum(self.data) }

pub fn NlppossvmView::mean(self : NlppossvmView) -> Double { @_common.mean(self.data) }

pub fn NlppossvmView::scale(self : NlppossvmView, f : Double) -> NlppossvmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmView::add(self : NlppossvmView, other : NlppossvmView) -> NlppossvmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmView::copy(self : NlppossvmView) -> NlppossvmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmView::fill(self : NlppossvmView, v : Double) -> NlppossvmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmView::min(self : NlppossvmView) -> Double { @_common.min(self.data) }

pub fn NlppossvmView::max(self : NlppossvmView) -> Double { @_common.max(self.data) }

pub fn NlppossvmView::to_string(self : NlppossvmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_range_make(size : Int) -> NlppossvmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmRange::len(self : NlppossvmRange) -> Int { self.size }

pub fn NlppossvmRange::get(self : NlppossvmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmRange::set(self : NlppossvmRange, i : Int, v : Double) -> NlppossvmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmRange::sum(self : NlppossvmRange) -> Double { @_common.sum(self.data) }

pub fn NlppossvmRange::mean(self : NlppossvmRange) -> Double { @_common.mean(self.data) }

pub fn NlppossvmRange::scale(self : NlppossvmRange, f : Double) -> NlppossvmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmRange::add(self : NlppossvmRange, other : NlppossvmRange) -> NlppossvmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmRange::copy(self : NlppossvmRange) -> NlppossvmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmRange::fill(self : NlppossvmRange, v : Double) -> NlppossvmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmRange::min(self : NlppossvmRange) -> Double { @_common.min(self.data) }

pub fn NlppossvmRange::max(self : NlppossvmRange) -> Double { @_common.max(self.data) }

pub fn NlppossvmRange::to_string(self : NlppossvmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlppossvmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_slice_make(size : Int) -> NlppossvmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlppossvmSlice::len(self : NlppossvmSlice) -> Int { self.size }

pub fn NlppossvmSlice::get(self : NlppossvmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlppossvmSlice::set(self : NlppossvmSlice, i : Int, v : Double) -> NlppossvmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlppossvmSlice::sum(self : NlppossvmSlice) -> Double { @_common.sum(self.data) }

pub fn NlppossvmSlice::mean(self : NlppossvmSlice) -> Double { @_common.mean(self.data) }

pub fn NlppossvmSlice::scale(self : NlppossvmSlice, f : Double) -> NlppossvmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlppossvmSlice::add(self : NlppossvmSlice, other : NlppossvmSlice) -> NlppossvmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlppossvmSlice::copy(self : NlppossvmSlice) -> NlppossvmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlppossvmSlice::fill(self : NlppossvmSlice, v : Double) -> NlppossvmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlppossvmSlice::min(self : NlppossvmSlice) -> Double { @_common.min(self.data) }

pub fn NlppossvmSlice::max(self : NlppossvmSlice) -> Double { @_common.max(self.data) }

pub fn NlppossvmSlice::to_string(self : NlppossvmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

