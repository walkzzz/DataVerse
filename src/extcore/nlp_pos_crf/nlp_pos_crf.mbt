///===
/// extcore/nlp_pos_crf

pub(all) struct NlpposcrfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_crf_make_point(x : Double, y : Double) -> NlpposcrfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_crf_make_point3(x : Double, y : Double, z : Double) -> NlpposcrfPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposcrfPoint::x(self : NlpposcrfPoint) -> Double { self.x }

pub fn NlpposcrfPoint::y(self : NlpposcrfPoint) -> Double { self.y }

pub fn NlpposcrfPoint::z(self : NlpposcrfPoint) -> Double { self.z }

pub fn NlpposcrfPoint::label(self : NlpposcrfPoint) -> Int { self.label }

pub fn NlpposcrfPoint::dist(self : NlpposcrfPoint, other : NlpposcrfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposcrfPoint::add(self : NlpposcrfPoint, other : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposcrfPoint::sub(self : NlpposcrfPoint, other : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposcrfPoint::scale(self : NlpposcrfPoint, s : Double) -> NlpposcrfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposcrfPoint::dot(self : NlpposcrfPoint, other : NlpposcrfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposcrfPoint::cross(self : NlpposcrfPoint, other : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposcrfPoint::norm(self : NlpposcrfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposcrfPoint::normalize(self : NlpposcrfPoint) -> NlpposcrfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposcrfPoint::negate(self : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposcrfPoint::mid(self : NlpposcrfPoint, other : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposcrfPoint::lerp(self : NlpposcrfPoint, other : NlpposcrfPoint, t : Double) -> NlpposcrfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposcrfPoint::to_string(self : NlpposcrfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposcrfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_crf_make_series(vals : Array[Double], name : String) -> NlpposcrfSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposcrfSeries::len(self : NlpposcrfSeries) -> Int { self.vals.length() }

pub fn NlpposcrfSeries::sum(self : NlpposcrfSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposcrfSeries::mean(self : NlpposcrfSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposcrfSeries::min(self : NlpposcrfSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposcrfSeries::max(self : NlpposcrfSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposcrfSeries::range(self : NlpposcrfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposcrfSeries::variance(self : NlpposcrfSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposcrfSeries::std(self : NlpposcrfSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposcrfSeries::median(self : NlpposcrfSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposcrfSeries::scale(self : NlpposcrfSeries, f : Double) -> NlpposcrfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposcrfSeries::add(self : NlpposcrfSeries, other : NlpposcrfSeries) -> NlpposcrfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposcrfSeries::sub(self : NlpposcrfSeries, other : NlpposcrfSeries) -> NlpposcrfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposcrfSeries::normalize(self : NlpposcrfSeries) -> NlpposcrfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposcrfSeries::cumsum(self : NlpposcrfSeries) -> NlpposcrfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposcrfSeries::to_string(self : NlpposcrfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposcrfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_crf_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposcrfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_crf_matrix_identity(n : Int) -> NlpposcrfMatrix {
  let m = nlp_pos_crf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposcrfMatrix::get(self : NlpposcrfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposcrfMatrix::transpose(self : NlpposcrfMatrix) -> NlpposcrfMatrix {
  let result = nlp_pos_crf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposcrfMatrix::add(self : NlpposcrfMatrix, other : NlpposcrfMatrix) -> NlpposcrfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_crf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposcrfMatrix::scale(self : NlpposcrfMatrix, s : Double) -> NlpposcrfMatrix {
  let result = nlp_pos_crf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposcrfMatrix::multiply(self : NlpposcrfMatrix, other : NlpposcrfMatrix) -> NlpposcrfMatrix {
  if self.cols != other.rows { return nlp_pos_crf_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_crf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpposcrfMatrix::trace(self : NlpposcrfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposcrfMatrix::det(self : NlpposcrfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposcrfMatrix::norm(self : NlpposcrfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposcrfMatrix::to_string(self : NlpposcrfMatrix) -> String {
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

pub(all) struct NlpposcrfVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_crf_make_vector(comps : Array[Double]) -> NlpposcrfVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_crf_vector_zero(dim : Int) -> NlpposcrfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposcrfVector::add(self : NlpposcrfVector, other : NlpposcrfVector) -> NlpposcrfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposcrfVector::sub(self : NlpposcrfVector, other : NlpposcrfVector) -> NlpposcrfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposcrfVector::scale(self : NlpposcrfVector, s : Double) -> NlpposcrfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposcrfVector::dot(self : NlpposcrfVector, other : NlpposcrfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposcrfVector::norm(self : NlpposcrfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposcrfVector::normalize(self : NlpposcrfVector) -> NlpposcrfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposcrfVector::dist(self : NlpposcrfVector, other : NlpposcrfVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposcrfVector::to_string(self : NlpposcrfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposcrfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_frame_make(size : Int) -> NlpposcrfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfFrame::len(self : NlpposcrfFrame) -> Int { self.size }

pub fn NlpposcrfFrame::get(self : NlpposcrfFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfFrame::set(self : NlpposcrfFrame, i : Int, v : Double) -> NlpposcrfFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfFrame::sum(self : NlpposcrfFrame) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfFrame::mean(self : NlpposcrfFrame) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfFrame::scale(self : NlpposcrfFrame, f : Double) -> NlpposcrfFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfFrame::add(self : NlpposcrfFrame, other : NlpposcrfFrame) -> NlpposcrfFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfFrame::copy(self : NlpposcrfFrame) -> NlpposcrfFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfFrame::fill(self : NlpposcrfFrame, v : Double) -> NlpposcrfFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfFrame::min(self : NlpposcrfFrame) -> Double { @_common.min(self.data) }

pub fn NlpposcrfFrame::max(self : NlpposcrfFrame) -> Double { @_common.max(self.data) }

pub fn NlpposcrfFrame::to_string(self : NlpposcrfFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_table_make(size : Int) -> NlpposcrfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfTable::len(self : NlpposcrfTable) -> Int { self.size }

pub fn NlpposcrfTable::get(self : NlpposcrfTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfTable::set(self : NlpposcrfTable, i : Int, v : Double) -> NlpposcrfTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfTable::sum(self : NlpposcrfTable) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfTable::mean(self : NlpposcrfTable) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfTable::scale(self : NlpposcrfTable, f : Double) -> NlpposcrfTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfTable::add(self : NlpposcrfTable, other : NlpposcrfTable) -> NlpposcrfTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfTable::copy(self : NlpposcrfTable) -> NlpposcrfTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfTable::fill(self : NlpposcrfTable, v : Double) -> NlpposcrfTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfTable::min(self : NlpposcrfTable) -> Double { @_common.min(self.data) }

pub fn NlpposcrfTable::max(self : NlpposcrfTable) -> Double { @_common.max(self.data) }

pub fn NlpposcrfTable::to_string(self : NlpposcrfTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_graphn_make(size : Int) -> NlpposcrfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfGraphN::len(self : NlpposcrfGraphN) -> Int { self.size }

pub fn NlpposcrfGraphN::get(self : NlpposcrfGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfGraphN::set(self : NlpposcrfGraphN, i : Int, v : Double) -> NlpposcrfGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfGraphN::sum(self : NlpposcrfGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfGraphN::mean(self : NlpposcrfGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfGraphN::scale(self : NlpposcrfGraphN, f : Double) -> NlpposcrfGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfGraphN::add(self : NlpposcrfGraphN, other : NlpposcrfGraphN) -> NlpposcrfGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfGraphN::copy(self : NlpposcrfGraphN) -> NlpposcrfGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfGraphN::fill(self : NlpposcrfGraphN, v : Double) -> NlpposcrfGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfGraphN::min(self : NlpposcrfGraphN) -> Double { @_common.min(self.data) }

pub fn NlpposcrfGraphN::max(self : NlpposcrfGraphN) -> Double { @_common.max(self.data) }

pub fn NlpposcrfGraphN::to_string(self : NlpposcrfGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_node_make(size : Int) -> NlpposcrfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfNode::len(self : NlpposcrfNode) -> Int { self.size }

pub fn NlpposcrfNode::get(self : NlpposcrfNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfNode::set(self : NlpposcrfNode, i : Int, v : Double) -> NlpposcrfNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfNode::sum(self : NlpposcrfNode) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfNode::mean(self : NlpposcrfNode) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfNode::scale(self : NlpposcrfNode, f : Double) -> NlpposcrfNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfNode::add(self : NlpposcrfNode, other : NlpposcrfNode) -> NlpposcrfNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfNode::copy(self : NlpposcrfNode) -> NlpposcrfNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfNode::fill(self : NlpposcrfNode, v : Double) -> NlpposcrfNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfNode::min(self : NlpposcrfNode) -> Double { @_common.min(self.data) }

pub fn NlpposcrfNode::max(self : NlpposcrfNode) -> Double { @_common.max(self.data) }

pub fn NlpposcrfNode::to_string(self : NlpposcrfNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_edge_make(size : Int) -> NlpposcrfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfEdge::len(self : NlpposcrfEdge) -> Int { self.size }

pub fn NlpposcrfEdge::get(self : NlpposcrfEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfEdge::set(self : NlpposcrfEdge, i : Int, v : Double) -> NlpposcrfEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfEdge::sum(self : NlpposcrfEdge) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfEdge::mean(self : NlpposcrfEdge) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfEdge::scale(self : NlpposcrfEdge, f : Double) -> NlpposcrfEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfEdge::add(self : NlpposcrfEdge, other : NlpposcrfEdge) -> NlpposcrfEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfEdge::copy(self : NlpposcrfEdge) -> NlpposcrfEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfEdge::fill(self : NlpposcrfEdge, v : Double) -> NlpposcrfEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfEdge::min(self : NlpposcrfEdge) -> Double { @_common.min(self.data) }

pub fn NlpposcrfEdge::max(self : NlpposcrfEdge) -> Double { @_common.max(self.data) }

pub fn NlpposcrfEdge::to_string(self : NlpposcrfEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_path_make(size : Int) -> NlpposcrfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfPath::len(self : NlpposcrfPath) -> Int { self.size }

pub fn NlpposcrfPath::get(self : NlpposcrfPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfPath::set(self : NlpposcrfPath, i : Int, v : Double) -> NlpposcrfPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfPath::sum(self : NlpposcrfPath) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfPath::mean(self : NlpposcrfPath) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfPath::scale(self : NlpposcrfPath, f : Double) -> NlpposcrfPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfPath::add(self : NlpposcrfPath, other : NlpposcrfPath) -> NlpposcrfPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfPath::copy(self : NlpposcrfPath) -> NlpposcrfPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfPath::fill(self : NlpposcrfPath, v : Double) -> NlpposcrfPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfPath::min(self : NlpposcrfPath) -> Double { @_common.min(self.data) }

pub fn NlpposcrfPath::max(self : NlpposcrfPath) -> Double { @_common.max(self.data) }

pub fn NlpposcrfPath::to_string(self : NlpposcrfPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_cluster_make(size : Int) -> NlpposcrfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfCluster::len(self : NlpposcrfCluster) -> Int { self.size }

pub fn NlpposcrfCluster::get(self : NlpposcrfCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfCluster::set(self : NlpposcrfCluster, i : Int, v : Double) -> NlpposcrfCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfCluster::sum(self : NlpposcrfCluster) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfCluster::mean(self : NlpposcrfCluster) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfCluster::scale(self : NlpposcrfCluster, f : Double) -> NlpposcrfCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfCluster::add(self : NlpposcrfCluster, other : NlpposcrfCluster) -> NlpposcrfCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfCluster::copy(self : NlpposcrfCluster) -> NlpposcrfCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfCluster::fill(self : NlpposcrfCluster, v : Double) -> NlpposcrfCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfCluster::min(self : NlpposcrfCluster) -> Double { @_common.min(self.data) }

pub fn NlpposcrfCluster::max(self : NlpposcrfCluster) -> Double { @_common.max(self.data) }

pub fn NlpposcrfCluster::to_string(self : NlpposcrfCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_model_make(size : Int) -> NlpposcrfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfModel::len(self : NlpposcrfModel) -> Int { self.size }

pub fn NlpposcrfModel::get(self : NlpposcrfModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfModel::set(self : NlpposcrfModel, i : Int, v : Double) -> NlpposcrfModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfModel::sum(self : NlpposcrfModel) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfModel::mean(self : NlpposcrfModel) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfModel::scale(self : NlpposcrfModel, f : Double) -> NlpposcrfModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfModel::add(self : NlpposcrfModel, other : NlpposcrfModel) -> NlpposcrfModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfModel::copy(self : NlpposcrfModel) -> NlpposcrfModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfModel::fill(self : NlpposcrfModel, v : Double) -> NlpposcrfModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfModel::min(self : NlpposcrfModel) -> Double { @_common.min(self.data) }

pub fn NlpposcrfModel::max(self : NlpposcrfModel) -> Double { @_common.max(self.data) }

pub fn NlpposcrfModel::to_string(self : NlpposcrfModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_layer_make(size : Int) -> NlpposcrfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfLayer::len(self : NlpposcrfLayer) -> Int { self.size }

pub fn NlpposcrfLayer::get(self : NlpposcrfLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfLayer::set(self : NlpposcrfLayer, i : Int, v : Double) -> NlpposcrfLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfLayer::sum(self : NlpposcrfLayer) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfLayer::mean(self : NlpposcrfLayer) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfLayer::scale(self : NlpposcrfLayer, f : Double) -> NlpposcrfLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfLayer::add(self : NlpposcrfLayer, other : NlpposcrfLayer) -> NlpposcrfLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfLayer::copy(self : NlpposcrfLayer) -> NlpposcrfLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfLayer::fill(self : NlpposcrfLayer, v : Double) -> NlpposcrfLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfLayer::min(self : NlpposcrfLayer) -> Double { @_common.min(self.data) }

pub fn NlpposcrfLayer::max(self : NlpposcrfLayer) -> Double { @_common.max(self.data) }

pub fn NlpposcrfLayer::to_string(self : NlpposcrfLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_buffer_make(size : Int) -> NlpposcrfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfBuffer::len(self : NlpposcrfBuffer) -> Int { self.size }

pub fn NlpposcrfBuffer::get(self : NlpposcrfBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfBuffer::set(self : NlpposcrfBuffer, i : Int, v : Double) -> NlpposcrfBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfBuffer::sum(self : NlpposcrfBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfBuffer::mean(self : NlpposcrfBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfBuffer::scale(self : NlpposcrfBuffer, f : Double) -> NlpposcrfBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfBuffer::add(self : NlpposcrfBuffer, other : NlpposcrfBuffer) -> NlpposcrfBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfBuffer::copy(self : NlpposcrfBuffer) -> NlpposcrfBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfBuffer::fill(self : NlpposcrfBuffer, v : Double) -> NlpposcrfBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfBuffer::min(self : NlpposcrfBuffer) -> Double { @_common.min(self.data) }

pub fn NlpposcrfBuffer::max(self : NlpposcrfBuffer) -> Double { @_common.max(self.data) }

pub fn NlpposcrfBuffer::to_string(self : NlpposcrfBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_cursor_make(size : Int) -> NlpposcrfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfCursor::len(self : NlpposcrfCursor) -> Int { self.size }

pub fn NlpposcrfCursor::get(self : NlpposcrfCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfCursor::set(self : NlpposcrfCursor, i : Int, v : Double) -> NlpposcrfCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfCursor::sum(self : NlpposcrfCursor) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfCursor::mean(self : NlpposcrfCursor) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfCursor::scale(self : NlpposcrfCursor, f : Double) -> NlpposcrfCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfCursor::add(self : NlpposcrfCursor, other : NlpposcrfCursor) -> NlpposcrfCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfCursor::copy(self : NlpposcrfCursor) -> NlpposcrfCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfCursor::fill(self : NlpposcrfCursor, v : Double) -> NlpposcrfCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfCursor::min(self : NlpposcrfCursor) -> Double { @_common.min(self.data) }

pub fn NlpposcrfCursor::max(self : NlpposcrfCursor) -> Double { @_common.max(self.data) }

pub fn NlpposcrfCursor::to_string(self : NlpposcrfCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_view_make(size : Int) -> NlpposcrfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfView::len(self : NlpposcrfView) -> Int { self.size }

pub fn NlpposcrfView::get(self : NlpposcrfView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfView::set(self : NlpposcrfView, i : Int, v : Double) -> NlpposcrfView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfView::sum(self : NlpposcrfView) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfView::mean(self : NlpposcrfView) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfView::scale(self : NlpposcrfView, f : Double) -> NlpposcrfView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfView::add(self : NlpposcrfView, other : NlpposcrfView) -> NlpposcrfView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfView::copy(self : NlpposcrfView) -> NlpposcrfView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfView::fill(self : NlpposcrfView, v : Double) -> NlpposcrfView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfView::min(self : NlpposcrfView) -> Double { @_common.min(self.data) }

pub fn NlpposcrfView::max(self : NlpposcrfView) -> Double { @_common.max(self.data) }

pub fn NlpposcrfView::to_string(self : NlpposcrfView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_range_make(size : Int) -> NlpposcrfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfRange::len(self : NlpposcrfRange) -> Int { self.size }

pub fn NlpposcrfRange::get(self : NlpposcrfRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfRange::set(self : NlpposcrfRange, i : Int, v : Double) -> NlpposcrfRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfRange::sum(self : NlpposcrfRange) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfRange::mean(self : NlpposcrfRange) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfRange::scale(self : NlpposcrfRange, f : Double) -> NlpposcrfRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfRange::add(self : NlpposcrfRange, other : NlpposcrfRange) -> NlpposcrfRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfRange::copy(self : NlpposcrfRange) -> NlpposcrfRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfRange::fill(self : NlpposcrfRange, v : Double) -> NlpposcrfRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfRange::min(self : NlpposcrfRange) -> Double { @_common.min(self.data) }

pub fn NlpposcrfRange::max(self : NlpposcrfRange) -> Double { @_common.max(self.data) }

pub fn NlpposcrfRange::to_string(self : NlpposcrfRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposcrfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_slice_make(size : Int) -> NlpposcrfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposcrfSlice::len(self : NlpposcrfSlice) -> Int { self.size }

pub fn NlpposcrfSlice::get(self : NlpposcrfSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposcrfSlice::set(self : NlpposcrfSlice, i : Int, v : Double) -> NlpposcrfSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposcrfSlice::sum(self : NlpposcrfSlice) -> Double { @_common.sum(self.data) }

pub fn NlpposcrfSlice::mean(self : NlpposcrfSlice) -> Double { @_common.mean(self.data) }

pub fn NlpposcrfSlice::scale(self : NlpposcrfSlice, f : Double) -> NlpposcrfSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposcrfSlice::add(self : NlpposcrfSlice, other : NlpposcrfSlice) -> NlpposcrfSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposcrfSlice::copy(self : NlpposcrfSlice) -> NlpposcrfSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposcrfSlice::fill(self : NlpposcrfSlice, v : Double) -> NlpposcrfSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposcrfSlice::min(self : NlpposcrfSlice) -> Double { @_common.min(self.data) }

pub fn NlpposcrfSlice::max(self : NlpposcrfSlice) -> Double { @_common.max(self.data) }

pub fn NlpposcrfSlice::to_string(self : NlpposcrfSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

