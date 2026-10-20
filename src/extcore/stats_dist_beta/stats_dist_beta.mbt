///===
/// extcore/stats_dist_beta

pub(all) struct StatsdistbetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_beta_make_point(x : Double, y : Double) -> StatsdistbetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_beta_make_point3(x : Double, y : Double, z : Double) -> StatsdistbetaPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistbetaPoint::x(self : StatsdistbetaPoint) -> Double { self.x }

pub fn StatsdistbetaPoint::y(self : StatsdistbetaPoint) -> Double { self.y }

pub fn StatsdistbetaPoint::z(self : StatsdistbetaPoint) -> Double { self.z }

pub fn StatsdistbetaPoint::label(self : StatsdistbetaPoint) -> Int { self.label }

pub fn StatsdistbetaPoint::dist(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistbetaPoint::add(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistbetaPoint::sub(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistbetaPoint::scale(self : StatsdistbetaPoint, s : Double) -> StatsdistbetaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistbetaPoint::dot(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistbetaPoint::cross(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistbetaPoint::norm(self : StatsdistbetaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistbetaPoint::normalize(self : StatsdistbetaPoint) -> StatsdistbetaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistbetaPoint::negate(self : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistbetaPoint::mid(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistbetaPoint::lerp(self : StatsdistbetaPoint, other : StatsdistbetaPoint, t : Double) -> StatsdistbetaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistbetaPoint::to_string(self : StatsdistbetaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistbetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_beta_make_series(vals : Array[Double], name : String) -> StatsdistbetaSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistbetaSeries::len(self : StatsdistbetaSeries) -> Int { self.vals.length() }

pub fn StatsdistbetaSeries::sum(self : StatsdistbetaSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistbetaSeries::mean(self : StatsdistbetaSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistbetaSeries::min(self : StatsdistbetaSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistbetaSeries::max(self : StatsdistbetaSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistbetaSeries::range(self : StatsdistbetaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistbetaSeries::variance(self : StatsdistbetaSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistbetaSeries::std(self : StatsdistbetaSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistbetaSeries::median(self : StatsdistbetaSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistbetaSeries::scale(self : StatsdistbetaSeries, f : Double) -> StatsdistbetaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistbetaSeries::add(self : StatsdistbetaSeries, other : StatsdistbetaSeries) -> StatsdistbetaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistbetaSeries::sub(self : StatsdistbetaSeries, other : StatsdistbetaSeries) -> StatsdistbetaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistbetaSeries::normalize(self : StatsdistbetaSeries) -> StatsdistbetaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistbetaSeries::cumsum(self : StatsdistbetaSeries) -> StatsdistbetaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistbetaSeries::to_string(self : StatsdistbetaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistbetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_beta_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistbetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_beta_matrix_identity(n : Int) -> StatsdistbetaMatrix {
  let m = stats_dist_beta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistbetaMatrix::get(self : StatsdistbetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistbetaMatrix::transpose(self : StatsdistbetaMatrix) -> StatsdistbetaMatrix {
  let result = stats_dist_beta_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistbetaMatrix::add(self : StatsdistbetaMatrix, other : StatsdistbetaMatrix) -> StatsdistbetaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_beta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistbetaMatrix::scale(self : StatsdistbetaMatrix, s : Double) -> StatsdistbetaMatrix {
  let result = stats_dist_beta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistbetaMatrix::multiply(self : StatsdistbetaMatrix, other : StatsdistbetaMatrix) -> StatsdistbetaMatrix {
  if self.cols != other.rows { return stats_dist_beta_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_beta_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsdistbetaMatrix::trace(self : StatsdistbetaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistbetaMatrix::det(self : StatsdistbetaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistbetaMatrix::norm(self : StatsdistbetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistbetaMatrix::to_string(self : StatsdistbetaMatrix) -> String {
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

pub(all) struct StatsdistbetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_beta_make_vector(comps : Array[Double]) -> StatsdistbetaVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_beta_vector_zero(dim : Int) -> StatsdistbetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistbetaVector::add(self : StatsdistbetaVector, other : StatsdistbetaVector) -> StatsdistbetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistbetaVector::sub(self : StatsdistbetaVector, other : StatsdistbetaVector) -> StatsdistbetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistbetaVector::scale(self : StatsdistbetaVector, s : Double) -> StatsdistbetaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistbetaVector::dot(self : StatsdistbetaVector, other : StatsdistbetaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistbetaVector::norm(self : StatsdistbetaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistbetaVector::normalize(self : StatsdistbetaVector) -> StatsdistbetaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistbetaVector::dist(self : StatsdistbetaVector, other : StatsdistbetaVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistbetaVector::to_string(self : StatsdistbetaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistbetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_frame_make(size : Int) -> StatsdistbetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaFrame::len(self : StatsdistbetaFrame) -> Int { self.size }

pub fn StatsdistbetaFrame::get(self : StatsdistbetaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaFrame::set(self : StatsdistbetaFrame, i : Int, v : Double) -> StatsdistbetaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaFrame::sum(self : StatsdistbetaFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaFrame::mean(self : StatsdistbetaFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaFrame::scale(self : StatsdistbetaFrame, f : Double) -> StatsdistbetaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaFrame::add(self : StatsdistbetaFrame, other : StatsdistbetaFrame) -> StatsdistbetaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaFrame::copy(self : StatsdistbetaFrame) -> StatsdistbetaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaFrame::fill(self : StatsdistbetaFrame, v : Double) -> StatsdistbetaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaFrame::min(self : StatsdistbetaFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaFrame::max(self : StatsdistbetaFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaFrame::to_string(self : StatsdistbetaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_table_make(size : Int) -> StatsdistbetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaTable::len(self : StatsdistbetaTable) -> Int { self.size }

pub fn StatsdistbetaTable::get(self : StatsdistbetaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaTable::set(self : StatsdistbetaTable, i : Int, v : Double) -> StatsdistbetaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaTable::sum(self : StatsdistbetaTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaTable::mean(self : StatsdistbetaTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaTable::scale(self : StatsdistbetaTable, f : Double) -> StatsdistbetaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaTable::add(self : StatsdistbetaTable, other : StatsdistbetaTable) -> StatsdistbetaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaTable::copy(self : StatsdistbetaTable) -> StatsdistbetaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaTable::fill(self : StatsdistbetaTable, v : Double) -> StatsdistbetaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaTable::min(self : StatsdistbetaTable) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaTable::max(self : StatsdistbetaTable) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaTable::to_string(self : StatsdistbetaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_graphn_make(size : Int) -> StatsdistbetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaGraphN::len(self : StatsdistbetaGraphN) -> Int { self.size }

pub fn StatsdistbetaGraphN::get(self : StatsdistbetaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaGraphN::set(self : StatsdistbetaGraphN, i : Int, v : Double) -> StatsdistbetaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaGraphN::sum(self : StatsdistbetaGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaGraphN::mean(self : StatsdistbetaGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaGraphN::scale(self : StatsdistbetaGraphN, f : Double) -> StatsdistbetaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaGraphN::add(self : StatsdistbetaGraphN, other : StatsdistbetaGraphN) -> StatsdistbetaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaGraphN::copy(self : StatsdistbetaGraphN) -> StatsdistbetaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaGraphN::fill(self : StatsdistbetaGraphN, v : Double) -> StatsdistbetaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaGraphN::min(self : StatsdistbetaGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaGraphN::max(self : StatsdistbetaGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaGraphN::to_string(self : StatsdistbetaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_node_make(size : Int) -> StatsdistbetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaNode::len(self : StatsdistbetaNode) -> Int { self.size }

pub fn StatsdistbetaNode::get(self : StatsdistbetaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaNode::set(self : StatsdistbetaNode, i : Int, v : Double) -> StatsdistbetaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaNode::sum(self : StatsdistbetaNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaNode::mean(self : StatsdistbetaNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaNode::scale(self : StatsdistbetaNode, f : Double) -> StatsdistbetaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaNode::add(self : StatsdistbetaNode, other : StatsdistbetaNode) -> StatsdistbetaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaNode::copy(self : StatsdistbetaNode) -> StatsdistbetaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaNode::fill(self : StatsdistbetaNode, v : Double) -> StatsdistbetaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaNode::min(self : StatsdistbetaNode) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaNode::max(self : StatsdistbetaNode) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaNode::to_string(self : StatsdistbetaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_edge_make(size : Int) -> StatsdistbetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaEdge::len(self : StatsdistbetaEdge) -> Int { self.size }

pub fn StatsdistbetaEdge::get(self : StatsdistbetaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaEdge::set(self : StatsdistbetaEdge, i : Int, v : Double) -> StatsdistbetaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaEdge::sum(self : StatsdistbetaEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaEdge::mean(self : StatsdistbetaEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaEdge::scale(self : StatsdistbetaEdge, f : Double) -> StatsdistbetaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaEdge::add(self : StatsdistbetaEdge, other : StatsdistbetaEdge) -> StatsdistbetaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaEdge::copy(self : StatsdistbetaEdge) -> StatsdistbetaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaEdge::fill(self : StatsdistbetaEdge, v : Double) -> StatsdistbetaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaEdge::min(self : StatsdistbetaEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaEdge::max(self : StatsdistbetaEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaEdge::to_string(self : StatsdistbetaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_path_make(size : Int) -> StatsdistbetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaPath::len(self : StatsdistbetaPath) -> Int { self.size }

pub fn StatsdistbetaPath::get(self : StatsdistbetaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaPath::set(self : StatsdistbetaPath, i : Int, v : Double) -> StatsdistbetaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaPath::sum(self : StatsdistbetaPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaPath::mean(self : StatsdistbetaPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaPath::scale(self : StatsdistbetaPath, f : Double) -> StatsdistbetaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaPath::add(self : StatsdistbetaPath, other : StatsdistbetaPath) -> StatsdistbetaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaPath::copy(self : StatsdistbetaPath) -> StatsdistbetaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaPath::fill(self : StatsdistbetaPath, v : Double) -> StatsdistbetaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaPath::min(self : StatsdistbetaPath) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaPath::max(self : StatsdistbetaPath) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaPath::to_string(self : StatsdistbetaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_cluster_make(size : Int) -> StatsdistbetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaCluster::len(self : StatsdistbetaCluster) -> Int { self.size }

pub fn StatsdistbetaCluster::get(self : StatsdistbetaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaCluster::set(self : StatsdistbetaCluster, i : Int, v : Double) -> StatsdistbetaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaCluster::sum(self : StatsdistbetaCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaCluster::mean(self : StatsdistbetaCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaCluster::scale(self : StatsdistbetaCluster, f : Double) -> StatsdistbetaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaCluster::add(self : StatsdistbetaCluster, other : StatsdistbetaCluster) -> StatsdistbetaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaCluster::copy(self : StatsdistbetaCluster) -> StatsdistbetaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaCluster::fill(self : StatsdistbetaCluster, v : Double) -> StatsdistbetaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaCluster::min(self : StatsdistbetaCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaCluster::max(self : StatsdistbetaCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaCluster::to_string(self : StatsdistbetaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_model_make(size : Int) -> StatsdistbetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaModel::len(self : StatsdistbetaModel) -> Int { self.size }

pub fn StatsdistbetaModel::get(self : StatsdistbetaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaModel::set(self : StatsdistbetaModel, i : Int, v : Double) -> StatsdistbetaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaModel::sum(self : StatsdistbetaModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaModel::mean(self : StatsdistbetaModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaModel::scale(self : StatsdistbetaModel, f : Double) -> StatsdistbetaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaModel::add(self : StatsdistbetaModel, other : StatsdistbetaModel) -> StatsdistbetaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaModel::copy(self : StatsdistbetaModel) -> StatsdistbetaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaModel::fill(self : StatsdistbetaModel, v : Double) -> StatsdistbetaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaModel::min(self : StatsdistbetaModel) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaModel::max(self : StatsdistbetaModel) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaModel::to_string(self : StatsdistbetaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_layer_make(size : Int) -> StatsdistbetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaLayer::len(self : StatsdistbetaLayer) -> Int { self.size }

pub fn StatsdistbetaLayer::get(self : StatsdistbetaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaLayer::set(self : StatsdistbetaLayer, i : Int, v : Double) -> StatsdistbetaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaLayer::sum(self : StatsdistbetaLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaLayer::mean(self : StatsdistbetaLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaLayer::scale(self : StatsdistbetaLayer, f : Double) -> StatsdistbetaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaLayer::add(self : StatsdistbetaLayer, other : StatsdistbetaLayer) -> StatsdistbetaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaLayer::copy(self : StatsdistbetaLayer) -> StatsdistbetaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaLayer::fill(self : StatsdistbetaLayer, v : Double) -> StatsdistbetaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaLayer::min(self : StatsdistbetaLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaLayer::max(self : StatsdistbetaLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaLayer::to_string(self : StatsdistbetaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_buffer_make(size : Int) -> StatsdistbetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaBuffer::len(self : StatsdistbetaBuffer) -> Int { self.size }

pub fn StatsdistbetaBuffer::get(self : StatsdistbetaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaBuffer::set(self : StatsdistbetaBuffer, i : Int, v : Double) -> StatsdistbetaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaBuffer::sum(self : StatsdistbetaBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaBuffer::mean(self : StatsdistbetaBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaBuffer::scale(self : StatsdistbetaBuffer, f : Double) -> StatsdistbetaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaBuffer::add(self : StatsdistbetaBuffer, other : StatsdistbetaBuffer) -> StatsdistbetaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaBuffer::copy(self : StatsdistbetaBuffer) -> StatsdistbetaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaBuffer::fill(self : StatsdistbetaBuffer, v : Double) -> StatsdistbetaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaBuffer::min(self : StatsdistbetaBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaBuffer::max(self : StatsdistbetaBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaBuffer::to_string(self : StatsdistbetaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_cursor_make(size : Int) -> StatsdistbetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaCursor::len(self : StatsdistbetaCursor) -> Int { self.size }

pub fn StatsdistbetaCursor::get(self : StatsdistbetaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaCursor::set(self : StatsdistbetaCursor, i : Int, v : Double) -> StatsdistbetaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaCursor::sum(self : StatsdistbetaCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaCursor::mean(self : StatsdistbetaCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaCursor::scale(self : StatsdistbetaCursor, f : Double) -> StatsdistbetaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaCursor::add(self : StatsdistbetaCursor, other : StatsdistbetaCursor) -> StatsdistbetaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaCursor::copy(self : StatsdistbetaCursor) -> StatsdistbetaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaCursor::fill(self : StatsdistbetaCursor, v : Double) -> StatsdistbetaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaCursor::min(self : StatsdistbetaCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaCursor::max(self : StatsdistbetaCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaCursor::to_string(self : StatsdistbetaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_view_make(size : Int) -> StatsdistbetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaView::len(self : StatsdistbetaView) -> Int { self.size }

pub fn StatsdistbetaView::get(self : StatsdistbetaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaView::set(self : StatsdistbetaView, i : Int, v : Double) -> StatsdistbetaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaView::sum(self : StatsdistbetaView) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaView::mean(self : StatsdistbetaView) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaView::scale(self : StatsdistbetaView, f : Double) -> StatsdistbetaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaView::add(self : StatsdistbetaView, other : StatsdistbetaView) -> StatsdistbetaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaView::copy(self : StatsdistbetaView) -> StatsdistbetaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaView::fill(self : StatsdistbetaView, v : Double) -> StatsdistbetaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaView::min(self : StatsdistbetaView) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaView::max(self : StatsdistbetaView) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaView::to_string(self : StatsdistbetaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_range_make(size : Int) -> StatsdistbetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaRange::len(self : StatsdistbetaRange) -> Int { self.size }

pub fn StatsdistbetaRange::get(self : StatsdistbetaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaRange::set(self : StatsdistbetaRange, i : Int, v : Double) -> StatsdistbetaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaRange::sum(self : StatsdistbetaRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaRange::mean(self : StatsdistbetaRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaRange::scale(self : StatsdistbetaRange, f : Double) -> StatsdistbetaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaRange::add(self : StatsdistbetaRange, other : StatsdistbetaRange) -> StatsdistbetaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaRange::copy(self : StatsdistbetaRange) -> StatsdistbetaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaRange::fill(self : StatsdistbetaRange, v : Double) -> StatsdistbetaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaRange::min(self : StatsdistbetaRange) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaRange::max(self : StatsdistbetaRange) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaRange::to_string(self : StatsdistbetaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_slice_make(size : Int) -> StatsdistbetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbetaSlice::len(self : StatsdistbetaSlice) -> Int { self.size }

pub fn StatsdistbetaSlice::get(self : StatsdistbetaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbetaSlice::set(self : StatsdistbetaSlice, i : Int, v : Double) -> StatsdistbetaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbetaSlice::sum(self : StatsdistbetaSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistbetaSlice::mean(self : StatsdistbetaSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistbetaSlice::scale(self : StatsdistbetaSlice, f : Double) -> StatsdistbetaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaSlice::add(self : StatsdistbetaSlice, other : StatsdistbetaSlice) -> StatsdistbetaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbetaSlice::copy(self : StatsdistbetaSlice) -> StatsdistbetaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaSlice::fill(self : StatsdistbetaSlice, v : Double) -> StatsdistbetaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbetaSlice::min(self : StatsdistbetaSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistbetaSlice::max(self : StatsdistbetaSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistbetaSlice::to_string(self : StatsdistbetaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

